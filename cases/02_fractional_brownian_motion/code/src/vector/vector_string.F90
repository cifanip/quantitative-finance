module vector_string

  use, intrinsic :: iso_c_binding
  use :: allocatable_utils

  implicit none
  
  private
  
  interface
    function v_string_init() result(vptr) &
    bind(c,name="v_string_init")
    import
    type(c_ptr) :: vptr
    end function v_string_init

    function v_string_init_size(size) result(vptr) &
    bind(c,name="v_string_init_size")
    import
    integer(c_int), intent(in), value :: size
    type(c_ptr) :: vptr
    end function v_string_init_size

    subroutine v_string_delete(vptr) &
    bind(c,name="v_string_delete")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v_string_delete

    subroutine v_string_deep_copy(lhs,rhs) &
    bind(c,name="v_string_deep_copy")
    import
    type(c_ptr), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs
    end subroutine v_string_deep_copy

    function v_string_is_empty(vptr) result(r) &
    bind(c,name="v_string_is_empty")
    import
    type(c_ptr), intent(in) :: vptr
    logical(c_bool) :: r
    end function v_string_is_empty

    function v_string_get_size(vptr) result(size) &
    bind(c,name="v_string_get_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int) :: size
    end function v_string_get_size
    
    function v_string_get_size_row(vptr,row) result(size) &
    bind(c,name="v_string_get_size_row")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: row
    integer(c_int) :: size
    end function v_string_get_size_row

    subroutine v_string_get_data(vptr,idx,val) &
    bind(c,name="v_string_get_data")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: idx
    character(len=*), intent(out) :: val
    end subroutine v_string_get_data

    subroutine v_string_set_data(vptr,idx,val,size) &
    bind(c,name="v_string_set_data")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: idx
    character(len=*), intent(in) :: val
    integer, intent(in), value :: size
    end subroutine v_string_set_data
    
    subroutine v_string_append(vptr,val,size) &
    bind(c,name="v_string_append")
    import
    type(c_ptr), intent(inout) :: vptr
    character(len=*), intent(in) :: val
    integer, intent(in), value :: size
    end subroutine v_string_append

    subroutine v_string_get_tail(vptr,val) &
    bind(c,name="v_string_get_tail")
    import
    type(c_ptr), intent(in) :: vptr
    character(len=*), intent(out) :: val
    end subroutine v_string_get_tail

    subroutine v_string_set_tail(vptr,val,size) &
    bind(c,name="v_string_set_tail")
    import
    type(c_ptr), intent(inout) :: vptr
    character(len=*), intent(in) :: val
    integer, intent(in), value :: size
    end subroutine v_string_set_tail

    subroutine v_string_write_to_screen(vptr) &
    bind(c,name="v_string_write_to_screen")
    import
    type(c_ptr), intent(in) :: vptr
    end subroutine v_string_write_to_screen
  end interface
  
  type, public :: vector_string_type
    private
    
    type(c_ptr), public :: vptr = c_null_ptr

    contains
    
    procedure, public :: delete,&
                         copy,&
                         is_empty,&
                         get_data,&
                         set_data,&
                         append,&
                         get_tail,&
                         set_tail,&
                         write_to_screen
                         
    procedure ::  ctor_default,&
                  ctor_size,&
                  get_size_list,&
                  get_size_row,&
                  equal_vec_vec,&
                  equal_vec_vptr
                         
    generic, public :: get_size => get_size_list,&
                                   get_size_row
                               
    generic, public :: ctor => ctor_default,&
                               ctor_size

    generic, public :: assignment(=) => equal_vec_vec,&
                                        equal_vec_vptr
    
  end type
  
contains

!========================================================================================!
  subroutine delete(this) 
    class(vector_string_type), intent(inout) :: this
    
    if (.not.c_associated(this%vptr)) then
      return
    end if
    
    call v_string_delete(this%vptr)
    
    this%vptr = c_null_ptr

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_default(this) 
    class(vector_string_type), intent(out) :: this
    
    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v_string_init()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,size) 
    class(vector_string_type), intent(out) :: this
    integer, intent(in) :: size

    if (size<=0) then
      call mpi_abort_run("Invalid size found at ctor vector_string_type")
    end if
    
    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v_string_init_size(size)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine copy(this,rhs) 
    class(vector_string_type), intent(inout) :: this
    type(vector_string_type), intent(in) :: rhs
    
    if (.not.c_associated(rhs%vptr)) then
      call mpi_abort_run("rhs is not allocated for vector_string_type")
    end if
    
    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    call v_string_deep_copy(this%vptr,rhs%vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine equal_vec_vec(lhs,rhs)
    class(vector_string_type), intent(inout) :: lhs
    type(vector_string_type), intent(in) :: rhs
    
    call lhs%copy(rhs)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine equal_vec_vptr(lhs,rhs_vptr)
    class(vector_string_type), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs_vptr

    if (.not.(c_associated(rhs_vptr))) then
      call mpi_abort_run("rhs_vptr is not associated for vector_string_type")
    end if
    
    if (.not.(c_associated(lhs%vptr))) then
      call lhs%ctor()
    end if
    
    call v_string_deep_copy(lhs%vptr,rhs_vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r) 
    class(vector_string_type), intent(in) :: this
    logical :: r

    if (.not.c_associated(this%vptr)) then
      r = .true.
      return
    end if

    r = v_string_is_empty(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_size_list(this) result(size) 
    class(vector_string_type), intent(in) :: this
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if

    size = v_string_get_size(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_size_row(this,row) result(size) 
    class(vector_string_type), intent(in) :: this
    integer, intent(in) :: row
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if
    
    if ((row<1).or.(row>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_string_type")
    end if

    size = v_string_get_size_row(this%vptr,row-1)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine get_data(this,idx,val)
    class(vector_string_type), intent(in) :: this
    integer, intent(in) :: idx
    character(len=:), allocatable, intent(out) :: val
    integer :: size
    
    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_string_type")
    end if
    
    size = this%get_size(idx)
    
    call allocate_array(val,size)
    
    call v_string_get_data(this%vptr,idx-1,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_data(this,idx,val)
    class(vector_string_type), intent(inout) :: this
    integer, intent(in) :: idx
    character(len=*), intent(in) :: val
    integer :: size
    
    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_string_type")
    end if
    
    size = len(val)
    
    if (size==0) then
      call mpi_abort_run("size=0 at vector_string_type%set_data")
    end if
    
    call v_string_set_data(this%vptr,idx-1,val,size)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append(this,val) 
    class(vector_string_type), intent(inout) :: this
    character(len=*), intent(in) :: val
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    size = len(val)
    
    if (size==0) then
      return
    end if

    call v_string_append(this%vptr,val,size)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_tail(this,val)
    class(vector_string_type), intent(in) :: this
    character(len=:), allocatable, intent(out) :: val
    integer :: size
    
    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if
    
    size = this%get_size(this%get_size())
    
    call allocate_array(val,size)
    
    call v_string_get_tail(this%vptr,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_tail(this,val)
    class(vector_string_type), intent(inout) :: this
    character(len=*), intent(in) :: val
    integer :: size

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_string_type")
    end if
    
    size = len(val)
    
    if (size==0) then
      call mpi_abort_run("size=0 at vector_string_type%set_tail")
    end if

    call v_string_set_tail(this%vptr,val,size)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_to_screen(this) 
    class(vector_string_type), intent(inout) :: this
    integer :: i

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_string_type")
    end if
    
    if (this%is_empty()) then
      write(*,*) "Vector is empty"
    end if

    call v_string_write_to_screen(this%vptr)
    
  end subroutine
!========================================================================================!

end module vector_string