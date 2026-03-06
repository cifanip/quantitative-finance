module basic_utils

  use kinds
  use formats
  use allocatable_utils
  
  implicit none
  
  abstract interface
    function compare_integers(lhs,rhs) result(r)
      integer, intent(in) :: lhs
      integer, intent(in) :: rhs
      logical :: r
    end function compare_integers

    function compare_doubles(lhs,rhs) result(r)
      import double_p
      real(double_p), intent(in) :: lhs
      real(double_p), intent(in) :: rhs
      logical :: r
    end function compare_doubles
  end interface

  interface greater_than
      module procedure greater_than_integer
      module procedure greater_than_double
  end interface
  
  interface greater_equal_than
      module procedure greater_equal_than_integer
      module procedure greater_equal_than_double
  end interface
  
  interface lower_than
      module procedure lower_than_integer
      module procedure lower_than_double
  end interface
  
  interface lower_equal_than
      module procedure lower_equal_than_integer
      module procedure lower_equal_than_double
  end interface
  
  interface split_range
      module procedure split_default_range
      module procedure split_bounded_range
  end interface

contains

!                     greater than
!========================================================================================!
  function greater_than_integer(lhs,rhs) result(r)
    integer, intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs>rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function

  function greater_than_double(lhs,rhs) result(r)
    real(double_p), intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs>rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function
!========================================================================================!

!                     greater or equal than
!========================================================================================!
  function greater_equal_than_integer(lhs,rhs) result(r)
    integer, intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs>=rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function

  function greater_equal_than_double(lhs,rhs) result(r)
    real(double_p), intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs>=rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function
!========================================================================================!

!                     lower than
!========================================================================================!
  function lower_than_integer(lhs,rhs) result(r)
    integer, intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs<rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function

  function lower_than_double(lhs,rhs) result(r)
    real(double_p), intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs<rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function
!========================================================================================!

!                     lower or equal than
!========================================================================================!
  function lower_equal_than_integer(lhs,rhs) result(r)
    integer, intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs<=rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function

  function lower_equal_than_double(lhs,rhs) result(r)
    real(double_p), intent(in) :: lhs,rhs
    logical :: r
    
    if (lhs<=rhs) then
      r = .true.
    else
      r = .false.
    end if
  
  end function
!========================================================================================!

!========================================================================================!
! splits i0..i1 into m intervals
  subroutine split_bounded_range(i0,i1,m,x)
    integer, intent(in) :: i0,i1,m
    integer, allocatable, dimension(:,:), intent(out) :: x
    integer :: i,n,nc,n1,n2,r,n_rem,np_rem
    
    if (i1<i0) then
      call mpi_abort_run("i1<i0 at split_bounded_range")
    end if
    
    n = i1-i0+1
    
    if (m<1) then
      call mpi_abort_run("m<1 at split_bounded_range")
    end if
    
    nc = min(n,m)
    
    call allocate_array(x,1,2,1,nc)
    
    r = ceiling(real(n)/real(nc))
    
    n1 = i0
    n2 = n1+r-1
    
    x(1,1)=n1
    x(2,1)=n2
    
    n_rem  = n-r
    np_rem = nc-1
    
    i=1
    do while (np_rem>0)
      
      r = ceiling(real(n_rem)/real(np_rem))
      
      i = i+1
      n1=n2+1
      n2=n2+r
      
      x(1,i)=n1
      x(2,i)=n2
      
      n_rem  = n_rem-r
      np_rem = np_rem-1
    
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
! splits 1..n into m intervals
  subroutine split_default_range(n,m,x)
    integer, intent(in) :: n,m
    integer, allocatable, dimension(:,:), intent(out) :: x
    
    call split_range(1,n,m,x)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine int_to_string(i,str)
    integer, intent(in) :: i
    character(len=:), allocatable, intent(out) :: str
    character(len=20) :: ichar
    integer :: s
    
    write(ichar,s_int_format) i
    
    s = len(trim(adjustl(ichar)))
    
    call allocate_array(str,s)
    
    str = trim(adjustl(ichar))

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine init_string(x,str)
    character(len=:), allocatable, intent(out) :: x
    character(len=*), intent(in) :: str
    
    call allocate_array(x,len(str))
    x = str

  end subroutine
!========================================================================================!

end module basic_utils