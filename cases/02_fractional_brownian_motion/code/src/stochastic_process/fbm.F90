module fbm
  
  use random_utils
  use scalar_tseries
  use fft_r2c_1d
  use fft_c2c_1d

  implicit none
  
  type, extends(scalar_tseries_type), public :: fbm_type
    private

    integer :: ns !number of sample points (t=0 included)

    integer :: nr !number of realisations
    
    real(double_p) :: tf !final time
    
    real(double_p), public :: dt !time-step
    
    real(double_p) :: h  !Hurst exponent

    contains
    
    procedure, public :: delete,&
                         compute
                         
    procedure :: ctor_fbm,compute_path
    
    generic, public :: ctor => ctor_fbm
    
  end type

  private :: delete,&
             ctor_fbm,&
             compute_path,&
             compute

contains

!========================================================================================!
  subroutine delete(this) 
    class(fbm_type), intent(inout) :: this
    
    call this%scalar_tseries_type%delete()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_fbm(this,ns,nr,tf,h)
    class(fbm_type), intent(out) :: this
    integer, intent(in) :: ns,nr
    real(double_p), intent(in) :: tf,h
    
    if (ns<100) then
      call mpi_abort_run("ns is too small at fbm%ctor")
    end if

    if (nr<1) then
      call mpi_abort_run("nr<1 at fbm%ctor")
    end if

    if (tf<=0.d0) then
      call mpi_abort_run("invalid tf at fbm%ctor")
    end if

    if ((h<=0.d0).or.(h>=1.d0)) then
      call mpi_abort_run("invalid h at fbm%ctor")
    end if
    
    this%ns = ns
    this%nr = nr
    this%tf = tf
    this%h  = h
    
    this%dt = tf/(this%ns-1)
    
    call this%scalar_tseries_type%ctor(this%ns,this%nr,0.d0)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine compute_path(this,ipath)
    class(fbm_type), intent(inout) :: this
    integer, intent(in) :: ipath
    real(double_p), allocatable, dimension(:) :: c
    complex(double_p), allocatable, dimension(:) :: z
    real(double_p) :: r1,r2,r3,h
    integer :: i,k,n,m
    type(fft_r2c_1d_type) :: fft_r2c
    type(fft_c2c_1d_type) :: fft_c2c_fwd,fft_c2c_bwd
    
    this%x(1,:)=0.d0
    
    h = this%h
    
    n = this%ns-1
    m = 2*(n-1)
    
    call allocate_array(c,1,m)
    c(1)=1.d0
    do i=2,m
      if (i<=n) then
        k = i-1
      else
        k = m - (i-1)
      end if
      r1 = (dble(k+1)*dble(k+1))**h
      r2 = (dble(k-1)*dble(k-1))**h
      r3 = (dble(k)*dble(k))**h
      c(i)=0.5d0*( r1 + r2 - 2.d0*r3 )
    end do
    
    !compute eigenvalues
    call fft_r2c%ctor(m)
    call fft_r2c%set_input(c)
    call fft_r2c%execute_plan()
    call fft_complete_csym_1d(fft_r2c%out)
    
    !generate Z
    call reallocate_array(c,1,m)
    call allocate_array(z,1,m)
    z=(0.d0,0.d0)
    call randn_array(c)
    z=c
    
    !compute L (Q^+)Z
    call fft_c2c_bwd%ctor(m,fftw_backward)
    call fft_c2c_bwd%set_input(z)
    call fft_c2c_bwd%execute_plan()
    fft_c2c_bwd%out=fft_c2c_bwd%out*sqrt(abs(fft_r2c%out%re))
    
    !compute (Q) L (Q^+) Z
    call fft_c2c_fwd%ctor(m,fftw_forward)
    call fft_c2c_fwd%set_input(fft_c2c_bwd%out)
    call fft_c2c_fwd%execute_plan()
    fft_c2c_fwd%out=fft_c2c_fwd%out/dble(m)
    
    !fbm noise
    call reallocate_array(c,1,n)
    c=fft_c2c_fwd%out(1:n)%re
    
    !cumulative sum to get motion from noise
    do i=2,this%get_ntime()
      this%x(i,ipath)=this%x(i-1,ipath)+c(i-1)
    end do
    
    !apply self similarity
    this%x(:,ipath) = (this%dt**h)*this%x(:,ipath)
    
    !clean up
    call fft_r2c%delete()
    call fft_c2c_fwd%delete()
    call fft_c2c_bwd%delete()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine compute(this) 
    class(fbm_type), intent(inout) :: this
    integer :: i
    
    do i=1,this%nr
      call this%compute_path(i)
    end do 

  end subroutine
!========================================================================================!

end module fbm