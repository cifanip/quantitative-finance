  use mpi_utils
  use, intrinsic :: iso_c_binding

  implicit none
  
  private
  
  interface
    function v1d_init() result(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_init")
    import
    type(c_ptr) :: vptr
    end function v1d_init

    function v1d_init_size(size) result(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_init_size")
    import
    integer(c_int), intent(in), value :: size
    type(c_ptr) :: vptr
    end function v1d_init_size

    function v1d_init_size_val(size,val) result(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_init_size_val")
    import
    integer(c_int), intent(in), value :: size
    VEC_TYPE_CPP, intent(in), value :: val
    type(c_ptr) :: vptr
    end function v1d_init_size_val

    subroutine v1d_delete(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_delete")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v1d_delete

    subroutine v1d_deep_copy(lhs,rhs) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_deep_copy")
    import
    type(c_ptr), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs
    end subroutine v1d_deep_copy

    function v1d_is_empty(vptr) result(r) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_is_empty")
    import
    type(c_ptr), intent(in) :: vptr
    logical(c_bool) :: r
    end function v1d_is_empty

    function v1d_get_size(vptr) result(size) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_get_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int) :: size
    end function v1d_get_size

    function v1d_get_data(vptr,idx) result(val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_get_data")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: idx
    VEC_TYPE_CPP :: val
    end function v1d_get_data

    subroutine v1d_set_data(vptr,idx,val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_set_data")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: idx
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v1d_set_data
    
    subroutine v1d_append(vptr,val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_append")
    import
    type(c_ptr), intent(inout) :: vptr
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v1d_append

    function v1d_get_tail(vptr) result(val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_get_tail")
    import
    type(c_ptr), intent(in) :: vptr
    VEC_TYPE_CPP :: val
    end function v1d_get_tail

    subroutine v1d_set_tail(vptr,val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_set_tail")
    import
    type(c_ptr), intent(inout) :: vptr
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v1d_set_tail

    subroutine v1d_insert(vptr,idx,val) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_insert")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: idx
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v1d_insert

    subroutine v1d_pop_back(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_pop_back")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v1d_pop_back
    
    subroutine v1d_send_with_tag(vptr,dest,tag) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_send_with_tag")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: dest,tag
    end subroutine v1d_send_with_tag
    
    subroutine v1d_send(vptr,dest) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_send")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: dest
    end subroutine v1d_send

    subroutine v1d_recv_with_tag(vptr,source,tag) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_recv_with_tag")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: source,tag
    end subroutine v1d_recv_with_tag

    subroutine v1d_recv(vptr,source) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_recv")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: source
    end subroutine v1d_recv
    
    subroutine v1d_bcast_with_root(vptr,root) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_bcast_with_root")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: root
    end subroutine v1d_bcast_with_root

    subroutine v1d_bcast(vptr) &
    bind(c,name="v1d_"//VEC_TYPE_STRING//"_bcast")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v1d_bcast
  end interface
  
  type, public :: VEC_DATA_TYPE
    private
    
    type(c_ptr), public :: vptr = c_null_ptr

    contains
    
    procedure, public :: delete,&
                         copy,&
                         copy_data,&
                         is_empty,&
                         get_size,&
                         get_data,&
                         set_data,&
                         append_val,&
                         append_array,&
                         get_tail,&
                         set_tail,&
                         insert,&
                         pop_back,&
                         write_to_screen,&
                         get_max_loc,&
                         get_max_val,&
                         get_min_val,&
                         get_min_loc
                         
    procedure ::  ctor_default,&
                  ctor_size,&
                  ctor_size_val,&
                  equal_vec_vec,&
                  equal_vec_vptr,&
                  send_with_tag,&
                  send_default_tag,&
                  recv_with_tag,&
                  recv_default_tag,&
                  bcast_with_root,&
                  bcast_default_root
                         
    generic, public :: ctor => ctor_default,&
                               ctor_size,&
                               ctor_size_val

    generic, public :: assignment(=) => equal_vec_vec,&
                                        equal_vec_vptr
                                        
    generic, public :: send => send_with_tag,&
                               send_default_tag
                               
    generic, public :: recv => recv_with_tag,&
                               recv_default_tag
                               
    generic, public :: bcast => bcast_with_root,&
                                bcast_default_root
                                
    generic, public :: append => append_val,&
                                 append_array
    
  end type
  
contains

!========================================================================================!
  subroutine delete(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    
    if (.not.c_associated(this%vptr)) then
      return
    end if
    
    call v1d_delete(this%vptr)
    
    this%vptr = c_null_ptr

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_default(this) 
    class(VEC_DATA_TYPE), intent(out) :: this
    
    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v1d_init()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,size) 
    class(VEC_DATA_TYPE), intent(out) :: this
    integer, intent(in) :: size

    if (size<=0) then
      call mpi_abort_run("Invalid size found at ctor vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v1d_init_size(size)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size_val(this,size,val) 
    class(VEC_DATA_TYPE), intent(out) :: this
    integer, intent(in) :: size
    VEC_TYPE_FORT, intent(in) :: val

    if (size<=0) then
      call mpi_abort_run("Invalid size found at ctor vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v1d_init_size_val(size,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine copy(this,rhs) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_DATA_TYPE), intent(in) :: rhs
    
    if (.not.c_associated(rhs%vptr)) then
      call mpi_abort_run("rhs is not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    call v1d_deep_copy(this%vptr,rhs%vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine equal_vec_vec(lhs,rhs)
    class(VEC_DATA_TYPE), intent(inout) :: lhs
    type(VEC_DATA_TYPE), intent(in) :: rhs
    
    call lhs%copy(rhs)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine equal_vec_vptr(lhs,rhs_vptr)
    class(VEC_DATA_TYPE), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs_vptr

    if (.not.(c_associated(rhs_vptr))) then
      call mpi_abort_run("rhs_vptr is not associated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.(c_associated(lhs%vptr))) then
      call lhs%ctor()
    end if
    
    call v1d_deep_copy(lhs%vptr,rhs_vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine copy_data(this,x)
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT, allocatable, dimension(:), intent(inout) :: x
    integer :: i,n

    if (this%is_empty()) then
      call mpi_abort_run("this is empty at equal_alloc_vec")
    end if
    
    n = this%get_size()
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,n)
    else if (size(x).ne.n) then
      call reallocate_array(x,1,n)
    end if
    
    do i=1,n
      x(i)=this%get_data(i)
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    logical :: r

    if (.not.c_associated(this%vptr)) then
      !call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
      r = .true.
      return
    end if

    r = v1d_is_empty(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_size(this) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer :: size

    if (.not.c_associated(this%vptr)) then
      ! call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
      size = 0
      return
    end if

    size = v1d_get_size(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_data(this,idx) result(val)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: idx
    VEC_TYPE_FORT :: val
    
    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_1d_"//VEC_TYPE_STRING)
    end if
    
    val = v1d_get_data(this%vptr,idx-1)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine set_data(this,idx,val)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: idx
    VEC_TYPE_FORT, intent(in) :: val
    
    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_1d_"//VEC_TYPE_STRING)
    end if
    
    call v1d_set_data(this%vptr,idx-1,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_val(this,val) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    VEC_TYPE_FORT, intent(in) :: val

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if

    call v1d_append(this%vptr,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_array(this,x) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    VEC_TYPE_FORT, dimension(:), intent(in) :: x
    integer :: i,n
    
    n = size(x)
    
    if (n==0) then
      return
    end if
    
    do i=1,n
      call this%append(x(i))
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  function get_tail(this) result(val)
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT :: val
    
    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_1d_"//VEC_TYPE_STRING)
    end if

    val = v1d_get_tail(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine set_tail(this,val)
    class(VEC_DATA_TYPE), intent(inout) :: this
    VEC_TYPE_FORT, intent(in) :: val

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_set_tail(this%vptr,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine insert(this,idx,val)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: idx
    VEC_TYPE_FORT, intent(in) :: val

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_insert(this%vptr,idx-1,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine pop_back(this)
    class(VEC_DATA_TYPE), intent(inout) :: this

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (this%get_size()<2) then
      call this%delete()
      return
    end if

    call v1d_pop_back(this%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_to_screen(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer :: i

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if (this%is_empty()) then
      write(*,*) "Vector is empty"
    end if

    do i=1,this%get_size()
      write(*,*) this%get_data(i)
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine send_with_tag(this,dest,tag) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: dest,tag

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((dest<0).or.(dest>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_send_with_tag(this%vptr,dest,tag)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine send_default_tag(this,dest) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: dest

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((dest<0).or.(dest>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_send(this%vptr,dest)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine recv_with_tag(this,source,tag) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: source,tag

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    if ((source<0).or.(source>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_recv_with_tag(this%vptr,source,tag)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine recv_default_tag(this,source) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: source

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    if ((source<0).or.(source>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_1d_"//VEC_TYPE_STRING)
    end if

    call v1d_recv(this%vptr,source)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine bcast_with_root(this,root) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: root
    
    if ((root<0).or.(root>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank==root).and.(.not.c_associated(this%vptr))) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank.ne.root).and.(.not.c_associated(this%vptr))) then
      call this%ctor()
    end if

    call v1d_bcast_with_root(this%vptr,root)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine bcast_default_root(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    
    if ((mpi_h%rank==0).and.(.not.c_associated(this%vptr))) then
      call mpi_abort_run("this%vptr not allocated for vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank.ne.0).and.(.not.c_associated(this%vptr))) then
      call this%ctor()
    end if

    call v1d_bcast(this%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  function get_max_loc(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT :: v1,v2
    integer :: i,r
      
    if (this%is_empty()) then
      write(*,*) "Vector is empty at get_max_loc"
    end if
    
    v1=this%get_data(1)
    r=1
    
    do i=2,this%get_size()
      v2=max(v1,this%get_data(i))
      if (v2>v1) then
        r=i
      end if
      v1=v2
    end do

  end function
!========================================================================================!

!========================================================================================!
  function get_max_val(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT :: r
    integer :: i
      
    if (this%is_empty()) then
      write(*,*) "Vector is empty at get_max_loc"
    end if
    
    r=this%get_data(1)
    
    do i=2,this%get_size()
      r=max(r,this%get_data(i))
    end do

  end function
!========================================================================================!

!========================================================================================!
  function get_min_loc(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT :: v1,v2
    integer :: i,r
      
    if (this%is_empty()) then
      write(*,*) "Vector is empty at get_max_loc"
    end if
    
    v1=this%get_data(1)
    r=1
    
    do i=2,this%get_size()
      v2=min(v1,this%get_data(i))
      if (v2<v1) then
        r=i
      end if
      v1=v2
    end do

  end function
!========================================================================================!

!========================================================================================!
  function get_min_val(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT :: r
    integer :: i
      
    if (this%is_empty()) then
      write(*,*) "Vector is empty at get_max_loc"
    end if
    
    r=this%get_data(1)
    
    do i=2,this%get_size()
      r=min(r,this%get_data(i))
    end do

  end function
!========================================================================================!