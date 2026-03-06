module fft_r2c_batch_1d
  
  use fft

  implicit none
  
  type, extends(fft_type), public :: fft_r2c_batch_1d_type
    private
    
    integer, allocatable, dimension(:), public :: s
  
    real(double_p), allocatable, dimension(:,:) :: in;
    
    complex(double_p), allocatable, dimension(:,:), public :: out;

    contains
    
    procedure :: build_plan
    
    procedure, public :: ctor,&
                         delete,&
                         execute_plan,&
                         set_input,&
                         get_input,&
                         get_output
    
  end type

  private :: ctor,&
             delete,&
             build_plan,&
             execute_plan,&
             set_input,&
             get_input,&
             get_output

contains

!========================================================================================!
  subroutine delete(this)
    class(fft_r2c_batch_1d_type), intent(inout) :: this
    
    call deallocate_array(this%s)
    call deallocate_array(this%in)
    call deallocate_array(this%out)
    call this%delete_fft_type()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor(this,s)
    class(fft_r2c_batch_1d_type), intent(out) :: this
    integer, dimension(:), intent(in) :: s
    integer :: i,s_max
    
    call this%init_fft_type()
    
    if (size(s)==0) then
      call mpi_abort_run("size(s)=0 at fft_r2c_batch_1d_type%ctor")
    end if
    
    do i=1,size(s)
      if (s(i)<2) then
        call mpi_abort_run("s(i)<2 at fft_r2c_batch_1d_type%ctor")
      end if      
    end do
    
    call allocate_array(this%s,1,size(s))
    this%s = s
    
    s_max = maxval(this%s,1)

    call allocate_array(this%in,1,s_max,1,size(s))
    this%in=0.d0
    
    call allocate_array(this%out,1,s_max,1,size(s))
    this%out=(0.d0,0.d0)

    call this%build_plan()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine build_plan(this)
    class(fft_r2c_batch_1d_type), intent(inout) :: this
    integer :: i,n
    
    n = size(this%s)

    allocate(this%plan(1:n))
    
    do i=1,n
      this%plan(i)=fftw_plan_dft_r2c_1d(this%s(i),&
                                        this%in(1,i),&
                                        this%out(1,i),&
                                        fftw_estimate)
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine execute_plan(this)
    class(fft_r2c_batch_1d_type), intent(inout) :: this
    integer :: i
    
    do i=1,size(this%s)
      call dfftw_execute_dft_r2c(this%plan(i),this%in(1,i),this%out(1,i))
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_input(this,x)
    class(fft_r2c_batch_1d_type), intent(inout) :: this
    real(double_p), dimension(:,:), intent(in) :: x
    
    if (size(x)==0) then
      call mpi_abort_run("size(x)=0 "//&
                         "at fft_r2c_batch_1d_type%set_input")
    else if ((size(x,1).ne.size(this%in,1)).or.&
             (size(x,2).ne.size(this%in,2))) then
      call mpi_abort_run("wrong x size "//&
                         "at fft_r2c_batch_1d_type%set_input")
    end if
    
    this%in = x
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_input(this,x)
    class(fft_r2c_batch_1d_type), intent(in) :: this
    real(double_p), allocatable, dimension(:,:), intent(inout) :: x
    
    if (.not.allocated(this%in)) then
      call mpi_abort_run("input array not allocated "//&
                         "at fft_r2c_batch_1d_type%get_input")
    end if
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,size(this%in,1),1,size(this%in,2))
    else if ((size(x,1).ne.size(this%in,1)).or.&
             (size(x,2).ne.size(this%in,2))) then
      call reallocate_array(x,1,size(this%in,1),1,size(this%in,2))
    end if
    
    x = this%in
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_output(this,x)
    class(fft_r2c_batch_1d_type), intent(in) :: this
    complex(double_p), allocatable, dimension(:,:), intent(inout) :: x
    
    if (.not.allocated(this%out)) then
      call mpi_abort_run("output array not allocated "//&
                         "at fft_r2c_batch_1d_type%get_output")
    end if
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,size(this%out,1),1,size(this%out,2))
    else if ((size(x,1).ne.size(this%out,1)).or.&
             (size(x,2).ne.size(this%out,2))) then
      call reallocate_array(x,1,size(this%out,1),1,size(this%out,2))
    end if
    
    x = this%out
    
  end subroutine
!========================================================================================!

end module fft_r2c_batch_1d