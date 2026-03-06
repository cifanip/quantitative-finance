module HM_gen_mod

  use formats_mod
  use allocate_arrays_mod
  
  implicit none
      
  type, abstract, public :: HM_gen
    private
    
    !length of observation sequence
    integer, public :: tau
    
    !number of states
    integer, public :: n
    
    !number of observation symbols
    integer, public :: m
    
    !state transition probabilities (nxn)
    real(double_p), allocatable, dimension(:,:), public :: a

    !observation probability matrix (nxm)
    real(double_p), allocatable, dimension(:,:), public :: b

    !initial state distribution (1xn)
    real(double_p), allocatable, dimension(:,:), public :: p
    
    !observation array
    integer, allocatable, dimension(:), public :: o
    
    !log of P(O|\lambda)
    real(double_p) :: log_p
    
    !store most probable state sequence (in the HM sense)
    integer, allocatable, dimension(:), public :: seq

    !store most probable state sequence (in the Viterbi sense)
    integer, allocatable, dimension(:), public :: vseq
    
    !work arrays
    real(double_p), allocatable, dimension(:,:) :: alpha,beta,gamma
    real(double_p), allocatable, dimension(:,:,:) :: digamma
    real(double_p), allocatable, dimension(:) :: c
    
    !output dir
    character(len=:), allocatable, public :: dir
    
  contains
    private
    
    procedure, public :: delete_HM_gen
    procedure, public :: initialize_HM_gen
    procedure, public :: allocate_arrays
    procedure, public :: set_initial_probs
    procedure :: alpha_pass
    procedure :: beta_pass
    procedure :: compute_gamma
    procedure :: estimate_parameters
    procedure :: log_prob
    procedure, public :: run_opt
    procedure, public :: seq_opt
    procedure, public :: seq_viterbi
    procedure, public :: write_a
    procedure, public :: write_b
    procedure, public :: print_a
    procedure, public :: print_b
    
    procedure(init_HM_gen_interface), public, deferred :: init_model
    
  end type

  interface 
    subroutine init_HM_gen_interface(this)
      import
      class(HM_gen), intent(inout) :: this
    end subroutine init_HM_gen_interface
  end interface

  private :: initialize_HM_gen,&
             delete_HM_gen,&
             init_HM_gen_interface,&
             allocate_arrays,&
             set_initial_probs,&
             alpha_pass,&
             beta_pass,&
             compute_gamma,&
             estimate_parameters,&
             log_prob,&
             run_opt,&
             seq_opt,&
             seq_viterbi
             
  public :: bproc_check_nan

contains

!========================================================================================!
  subroutine delete_HM_gen(this)
    class(HM_gen), intent(inout) :: this
    
    call deallocate_array(this%a)
    call deallocate_array(this%b)
    call deallocate_array(this%p)
    call deallocate_array(this%o)
    call deallocate_array(this%alpha)
    call deallocate_array(this%beta)
    call deallocate_array(this%gamma)
    call deallocate_array(this%c)
    call deallocate_array(this%digamma)
    call deallocate_array(this%seq)
    call deallocate_array(this%vseq)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine initialize_HM_gen(this)
    class(HM_gen), intent(inout) :: this
    
    ! nothing to be done yet

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine allocate_arrays(this)
    class(HM_gen), intent(inout) :: this
    
    !to be called after n,m and tau have been set

    call allocate_array(this%a,1,this%n,1,this%n)
    call allocate_array(this%b,1,this%n,1,this%m)
    call allocate_array(this%p,1,1,1,this%n)
    call allocate_array(this%o,1,this%tau)
    
    call allocate_array(this%alpha,1,this%n,1,this%tau)
    call allocate_array(this%beta,1,this%n,1,this%tau)
    call allocate_array(this%c,1,this%tau)
    
    call allocate_array(this%gamma,1,this%n,1,this%tau)
    call allocate_array(this%digamma,1,this%n,1,this%n,1,this%tau)
    
    this%a=0.d0
    this%b=0.d0
    this%p=0.d0
    this%o=0
    
    this%alpha=0.d0
    this%beta=0.d0
    this%c=0.d0
    
    this%gamma=0.d0
    this%digamma=0.d0

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_initial_probs(this)
    class(HM_gen), intent(inout) :: this
    real(double_p) :: x,y,r
    integer :: i,j,n,m
    
    n=this%n
    m=this%m
    
    x=dble(1.d0)/dble(n)
    y=dble(1.d0)/dble(m)
    
    !p
    do i=1,n
      call random_number(r)
      r=(r-0.5d0)      
      this%p(1,i)=x*(1.d0+1.d-2*r)
    end do
    this%p(1,:)=this%p(1,:)/sum(this%p(1,:))

    !a
    do j=1,n
      do i=1,n
        call random_number(r)
        r=(r-0.5d0)
        this%a(i,j)=x*(1.d0+1.d-2*r)
      end do
    end do
    do i=1,n
      this%a(i,:)=this%a(i,:)/sum(this%a(i,:))
    end do
    
    !b
    do j=1,m
      do i=1,n
        call random_number(r)
        call random_number(r)
        r=(r-0.5d0)
        this%b(i,j)=y*(1.d0+1.d-2*r)
      end do
    end do
    do i=1,n
      this%b(i,:)=this%b(i,:)/sum(this%b(i,:))
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine alpha_pass(this)
    class(HM_gen), intent(inout) :: this
    integer :: i,t
    
    !compute alpha_0
    this%alpha(:,1)=this%p(1,:)*this%b(:,this%o(1))
    this%c(1)=1.d0/sum(this%alpha(:,1))
    this%alpha(:,1)=this%alpha(:,1)*this%c(1)
    
    !compute alpha_t
    do t=2,this%tau
      do i=1,this%n
        this%alpha(i,t)=sum(this%alpha(:,t-1)*this%a(:,i))
        this%alpha(i,t)=this%alpha(i,t)*this%b(i,this%o(t))
      end do
      this%c(t)=1.d0/sum(this%alpha(:,t))      
      this%alpha(:,t)=this%alpha(:,t)*this%c(t)
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine beta_pass(this)
    class(HM_gen), intent(inout) :: this
    integer :: i,t
    
    !compute beta_tau
    this%beta(:,this%tau)=this%c(this%tau)
    
    !compute beta_t
    do t=this%tau-1,1,-1
      do i=1,this%n
        this%beta(i,t)=sum(this%a(i,:)*this%b(:,this%o(t+1))*this%beta(:,t+1))
        this%beta(i,t)=this%c(t)*this%beta(i,t)
      end do
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine compute_gamma(this)
    class(HM_gen), intent(inout) :: this
    integer :: i,t   
    
    do t=1,this%tau-1
      do i=1,this%n
        this%digamma(i,:,t)=this%alpha(i,t)*this%a(i,:)*this%b(:,this%o(t+1))*&
                            this%beta(:,t+1)
        this%gamma(i,t)=sum(this%digamma(i,:,t))
      end do
    end do
    
    this%gamma(:,this%tau)=this%alpha(:,this%tau)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine estimate_parameters(this)
    class(HM_gen), intent(inout) :: this
    real(double_p) :: num,den
    integer :: i,j,t,tau
    
    tau=this%tau
    
    !p
    this%p(1,:)=this%gamma(:,1)
    
    !a
    do j=1,this%n
      do i=1,this%n
        num=sum(this%digamma(i,j,1:tau-1))
        den=sum(this%gamma(i,1:tau-1))
        this%a(i,j)=num/den
      end do
    end do

    !b
    do j=1,this%m
      do i=1,this%n
        den=sum(this%gamma(i,:))
        num=0.d0
        do t=1,tau
          if (this%o(t)==j) then
            num=num+this%gamma(i,t)
          end if
        end do
        this%b(i,j)=num/den
      end do
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine log_prob(this)
    class(HM_gen), intent(inout) :: this
    integer :: t
    
    this%log_p = 0.d0
    
    do t=1,this%tau
      this%log_p = this%log_p + log(this%c(t))      
    end do
    this%log_p=-this%log_p

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine run_opt(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: a
    real(double_p) :: log_p0,tol,err
    
    log_p0=0.d0
    tol=1.d-12
    
    write(*,*) '  Running EM algorithm: '
    
    do

      call this%alpha_pass()
      call this%beta_pass()
      call this%compute_gamma()
      call this%estimate_parameters()
      
      call this%log_prob()
      call bproc_check_NaN(this%log_p)
      
      err=abs((this%log_p-log_p0)/this%log_p)
      
      write(*,*) this%log_p
      
      if (err<tol) then
        exit
      else
        log_p0=this%log_p
      end if
    
    end do   
    
    write(*,*) '  DONE'
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine seq_opt(this)
    class(HM_gen), intent(inout) :: this
    integer :: i
    
    write(*,*) '  Running opt seq: '
    
    call this%alpha_pass()
    call this%beta_pass()
    call this%compute_gamma()
    
    call reallocate_array(this%seq,1,this%tau)
    do i=1,this%tau
      this%seq(i)=maxloc(this%gamma(:,i),1)      
    end do
    
    write(*,*) '  DONE'

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine seq_viterbi(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: d1
    integer, allocatable, dimension(:,:) :: d2
    integer, allocatable, dimension(:) :: z
    integer :: i,t
    
    write(*,*) '  Running Viterbi seq: '
    
    call reallocate_array(this%vseq,1,this%tau)
    this%vseq=0
    
    call allocate_array(d1,1,this%n,1,this%tau)
    call allocate_array(d2,1,this%n,1,this%tau)
 
    !i.c.
    d1(:,1)=log(this%p(1,:)*this%b(:,this%o(1)))
    d2(:,1)=0
    
    do t=2,this%tau
      do i=1,this%n
        d1(i,t)=maxval(d1(:,t-1)+log(this%a(:,i))+log(this%b(i,this%o(t))),1)
        d2(i,t)=maxloc(d1(:,t-1)+log(this%a(:,i))+log(this%b(i,this%o(t))),1)
      end do
    end do
    
    this%vseq(this%tau)=maxloc(d1(:,this%tau),1)
    do t=this%tau,2,-1
      this%vseq(t-1)=d2(this%vseq(t),t)
    end do
    
    write(*,*) '  DONE'

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_a(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: a
    character(len=10) :: char_n
    character(len=:), allocatable :: fname
    integer :: i

    fname=this%dir//'a_mat'
    open(UNIT=s_io_unit,FILE=fname,STATUS='replace',ACTION='write')
      write(char_n,s_int_format) size(this%a,2)
      do i=1,size(this%a,1)
        write(s_io_unit,'('//adjustl(trim(char_n))&
                   //s_double_format(2:10)//')') this%a(i,:)
      end do
    close(s_io_unit)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_b(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: b
    character(len=10) :: char_n
    character(len=:), allocatable :: fname
    integer :: i

    fname=this%dir//'b_mat'
    open(UNIT=s_io_unit,FILE=fname,STATUS='replace',ACTION='write')
      write(char_n,s_int_format) size(this%b,2)
      do i=1,size(this%b,1)
        write(s_io_unit,'('//adjustl(trim(char_n))&
                           //s_double_format(2:10)//')') this%b(i,:)
      end do
    close(s_io_unit)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine print_a(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: a
    character(len=10) :: char_n
    integer :: i
    
    write(*,*) 'MATRIX A:'
    
    write(char_n,s_int_format) size(this%a,2)
    do i=1,size(this%a,1)
      write(*,'('//adjustl(trim(char_n))&
                //s_double_format(2:10)//')') this%a(i,:)
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine print_b(this)
    class(HM_gen), intent(inout) :: this
    real(double_p), allocatable, dimension(:,:) :: b
    character(len=10) :: char_n
    integer :: i
    
    write(*,*) 'MATRIX B:'
    
    write(char_n,s_int_format) size(this%b,2)
    do i=1,size(this%b,1)
      write(*,'('//adjustl(trim(char_n))&
                //s_double_format(2:10)//')') this%b(i,:)
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine bproc_check_nan(f)
    real(double_p), intent(in) :: f
    
    if (f/=f) then
      call abort_run('NaN found in value of f')
    end if
   
  end subroutine
!========================================================================================!

end module HM_gen_mod