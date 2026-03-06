module fft_c2c_1d
  
  use fft

  implicit none
  
  type, extends(fft_type), public :: fft_c2c_1d_type
    private
    
    integer :: direction
  
    complex(double_p), allocatable, dimension(:) :: in;
    
    complex(double_p), allocatable, dimension(:), public :: out;

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
    class(fft_c2c_1d_type), intent(inout) :: this
    
    call deallocate_array(this%in)
    call deallocate_array(this%out)
    call this%delete_fft_type()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor(this,size,direction)
    class(fft_c2c_1d_type), intent(out) :: this
    integer :: size,direction
    
    call this%init_fft_type()

    if (size<2) then
      call mpi_abort_run("size<2 at fft_c2c_1d_type%ctor")
    end if
    
    if ((direction.ne.fftw_forward).and.&
        (direction.ne.fftw_backward)) then
      call mpi_abort_run("invalid direction at fft_c2c_1d_type%ctor")
    end if
    
    this%direction = direction
    
    call allocate_array(this%in,1,size)
    this%in=0.d0
    
    call allocate_array(this%out,1,size)
    this%out=(0.d0,0.d0)

    call this%build_plan()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine build_plan(this)
    class(fft_c2c_1d_type), intent(inout) :: this
    integer :: i,n
    
    n = size(this%in)

    allocate(this%plan(1:1))
    
    this%plan(1)=fftw_plan_dft_1d(n,this%in,this%out,this%direction,fftw_estimate)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine execute_plan(this)
    class(fft_c2c_1d_type), intent(inout) :: this
    
    call dfftw_execute_dft(this%plan(1),this%in,this%out)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_input(this,x)
    class(fft_c2c_1d_type), intent(inout) :: this
    complex(double_p), dimension(:), intent(in) :: x
    
    if (size(x)==0) then
      call mpi_abort_run("size(x)=0 at fft_c2c_1d_type%set_input")
    else if (size(x).ne.size(this%in)) then
      call mpi_abort_run("wrong x size at fft_c2c_1d_type%set_input")
    end if
    
    this%in = x
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_input(this,x)
    class(fft_c2c_1d_type), intent(in) :: this
    complex(double_p), allocatable, dimension(:), intent(inout) :: x
    
    if (.not.allocated(this%in)) then
      call mpi_abort_run("input array not allocated at fft_c2c_1d_type%get_input")
    end if
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,size(this%in))
    else if (size(x).ne.size(this%in)) then
      call reallocate_array(x,1,size(this%in))
    end if
    
    x = this%in
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_output(this,x)
    class(fft_c2c_1d_type), intent(in) :: this
    complex(double_p), allocatable, dimension(:), intent(inout) :: x
    
    if (.not.allocated(this%out)) then
      call mpi_abort_run("output array not allocated at "//&
                         "fft_c2c_1d_type%get_output")
    end if
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,size(this%out))
    else if (size(x).ne.size(this%out)) then
      call reallocate_array(x,1,size(this%out))
    end if
    
    x = this%out
    
  end subroutine
!========================================================================================!

end module fft_c2c_1d