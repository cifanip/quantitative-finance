module fft
  
  use, intrinsic :: iso_c_binding
  use allocatable_utils

  implicit none
  
  integer, parameter :: fftw_estimate = 64
  integer, parameter :: fftw_forward  = -1
  integer, parameter :: fftw_backward = 1
  
  type, abstract, public :: fft_type
    private
    
    type(c_ptr), allocatable, dimension(:), public :: plan

    contains
    
    procedure, public :: destroy_plan_fft_type,&
                         delete_fft_type,&
                         init_fft_type
    
    procedure(build_fft_plan), public, deferred :: build_plan
    
    procedure(execute_fft_plan), public, deferred :: execute_plan
    
  end type

  interface 

    subroutine build_fft_plan(this)
      import fft_type
      class(fft_type), intent(inout) :: this
    end subroutine build_fft_plan

    subroutine execute_fft_plan(this)
      import fft_type
      class(fft_type), intent(inout) :: this
    end subroutine execute_fft_plan
    
    subroutine fftw_destroy_plan(plan) &
      bind(c,name='fftw_destroy_plan')
      import
      type(c_ptr), value :: plan
    end subroutine
    
    function fftw_plan_dft_r2c_1d(size,in,out,flag) result(plan) &
      bind(c,name='fftw_plan_dft_r2c_1d')
      import
      integer(c_int), value :: size
      real(c_double), dimension(*), intent(in) :: in
      complex(c_double), dimension(*), intent(inout) :: out
      integer(c_int), value :: flag
      type(c_ptr) :: plan
    end function

    function fftw_plan_dft_c2r_1d(size,in,out,flag) result(plan) &
      bind(c,name='fftw_plan_dft_c2r_1d')
      import
      integer(c_int), value :: size
      complex(c_double), dimension(*), intent(in) :: in
      real(c_double), dimension(*), intent(inout) :: out
      integer(c_int), value :: flag
      type(c_ptr) :: plan
    end function

    function fftw_plan_dft_1d(size,in,out,direction,flag) result(plan) &
      bind(c,name='fftw_plan_dft_1d')
      import
      integer(c_int), value :: size
      complex(c_double), dimension(*), intent(in) :: in
      complex(c_double), dimension(*), intent(inout) :: out
      integer(c_int), value :: direction
      integer(c_int), value :: flag
      type(c_ptr) :: plan
    end function
    
  end interface
  
  public :: fft_complete_csym_1d

  private :: delete_fft_type,&
             init_fft_type,&
             destroy_plan_fft_type,&
             build_fft_plan,&
             execute_fft_plan

contains

!========================================================================================!
  subroutine delete_fft_type(this) 
    class(fft_type), intent(inout) :: this
    
    call this%destroy_plan_fft_type()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine destroy_plan_fft_type(this) 
    class(fft_type), intent(inout) :: this
    integer :: i
    
    if (.not.allocated(this%plan)) then
      return
    end if
    
    do i=1,size(this%plan)
      call fftw_destroy_plan(this%plan(i))
    end do
    
    deallocate(this%plan)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine init_fft_type(this) 
    class(fft_type), intent(out) :: this
    !nothing to be done here
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine fft_complete_csym_1d(x)
    complex(double_p), allocatable, dimension(:), intent(inout) :: x
    integer :: i,n,nh
    
    if (.not.allocated(x)) then
      call mpi_abort_run("x is not allocated at fft_complete_csym_1d")
    end if
    
    n  = size(x)
    
    if (mod(n,2)==0) then
      nh = n/2+1
      do i=1,nh-2
        x(nh+i)=conjg(x(nh-i))
      end do
    else
      nh = floor(0.5*n)+1
      do i=1,nh-1
        x(nh+i)=conjg(x(nh-i+1))
      end do
    end if
    
  end subroutine
!========================================================================================!

end module fft