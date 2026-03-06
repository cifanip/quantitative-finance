module random_utils

  use allocatable_utils
  use, intrinsic :: iso_c_binding
  
  implicit none
  
  interface
  
    subroutine set_random_seed_cpp() &
    bind(c,name="set_random_seed_cpp")
    end subroutine set_random_seed_cpp

    subroutine default_random_seed_cpp() &
    bind(c,name="default_random_seed_cpp")
    end subroutine default_random_seed_cpp
  
    pure function randn_cpp() result(r) &
    bind(c,name="randn_cpp")
      import c_double
      real(c_double) :: r
    end function randn_cpp

    pure function randu_cpp() result(r) &
    bind(c,name="randu_cpp")
      import c_double
      real(c_double) :: r
    end function randu_cpp

    subroutine randn_array_cpp(n,x) &
    bind(c,name="randn_array_cpp")
      import c_int,c_double
      integer(c_int), intent(in), value :: n
      real(c_double), dimension(*), intent(out) :: x
    end subroutine randn_array_cpp

    subroutine randu_array_cpp(n,x) &
    bind(c,name="randu_array_cpp")
      import c_int,c_double
      integer(c_int), intent(in), value :: n
      real(c_double), dimension(*), intent(out) :: x
    end subroutine randu_array_cpp

  end interface

contains

!========================================================================================!
  subroutine set_random_seed()
    
    call set_random_seed_cpp()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine default_random_seed()
    
    call default_random_seed_cpp()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  pure function randn() result(r)
    real(double_p) :: r
    
    r = randn_cpp()
    
  end function
!========================================================================================!

!========================================================================================!
  pure function randu() result(r)
    real(double_p) :: r
    
    r = randu_cpp()
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine randn_array(x)
    real(double_p), dimension(:), intent(inout), contiguous :: x
    
    if (size(x)==0) then
      call mpi_abort_run("size(x)=0 at randn_array")
    end if
    
    call randn_array_cpp(size(x),x)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine randu_array(x)
    real(double_p), dimension(:), intent(inout), contiguous :: x
    
    if (size(x)==0) then
      call mpi_abort_run("size(x)=0 at randu_array")
    end if
    
    call randu_array_cpp(size(x),x)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine wiener_proc(x,dt,ic_opt)
    real(double_p), dimension(:), intent(inout), contiguous :: x
    real(double_p), intent(in) :: dt
    real(double_p), optional :: ic_opt
    real(double_p), dimension(:), allocatable :: n
    real(double_p) :: ic
    integer :: i
    
    if (present(ic_opt)) then
      ic = ic_opt
    else
      ic = 0.d0
    end if
    
    if (size(x)==0) then
      call mpi_abort_run("size(x)=0 at wiener_proc")
    end if
    
    call allocate_array(n,1,size(x)-1)
    
    call randn_array(n)
    n=sqrt(dt)*n
    
    x(1)=ic
    
    do i=2,size(x)
      x(i)=x(i-1)+n(i-1)
    end do
    
  end subroutine
!========================================================================================!
    
end module random_utils