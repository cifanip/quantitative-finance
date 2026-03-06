  use mpi_utils
  use, intrinsic :: iso_c_binding

  implicit none
  
  private
  
  interface
    function v2d_init() result(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_init")
    import
    type(c_ptr) :: vptr
    end function v2d_init

    function v2d_init_size(size) result(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_init_size")
    import
    integer(c_int), intent(in), value :: size
    type(c_ptr) :: vptr
    end function v2d_init_size

    subroutine v2d_delete(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_delete")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v2d_delete
    
    subroutine v2d_deep_copy(lhs,rhs) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_deep_copy")
    import
    type(c_ptr), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs
    end subroutine v2d_deep_copy

    function v2d_is_empty(vptr) result(r) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_is_empty")
    import
    type(c_ptr), intent(in) :: vptr
    logical(c_bool) :: r
    end function v2d_is_empty

    function v2d_get_size(vptr) result(size) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_get_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int) :: size
    end function v2d_get_size
    
    function v2d_get_row_size(vptr,irow) result(size) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_get_row_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: irow
    integer(c_int) :: size
    end function v2d_get_row_size

    function v2d_get_data(vptr,i,j) result(val) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_get_data")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: i,j
    VEC_TYPE_CPP :: val
    end function v2d_get_data

    subroutine v2d_set_data(vptr,i,j,val) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_set_data")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: i,j
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v2d_set_data
    
    subroutine v2d_append(vptr,vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_append")
    import
    type(c_ptr), intent(inout) :: vptr
    type(c_ptr), intent(in) :: vec
    end subroutine v2d_append

    subroutine v2d_extend_row(vptr,irow,vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_extend_row")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: irow
    type(c_ptr), intent(in) :: vec
    end subroutine v2d_extend_row

    function v2d_get_row(vptr,irow) result(vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_get_row")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: irow
    type(c_ptr) :: vec
    end function v2d_get_row

    subroutine v2d_set_row(vptr,irow,vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_set_row")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: irow
    type(c_ptr), intent(in) :: vec
    end subroutine v2d_set_row

    function v2d_get_tail(vptr) result(vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_get_tail")
    import
    type(c_ptr), intent(in) :: vptr
    type(c_ptr) :: vec
    end function v2d_get_tail

    subroutine v2d_set_tail(vptr,vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_set_tail")
    import
    type(c_ptr), intent(inout) :: vptr
    type(c_ptr), intent(in) :: vec
    end subroutine v2d_set_tail

    subroutine v2d_print(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_print")
    import
    type(c_ptr), intent(in) :: vptr
    end subroutine v2d_print
    
    subroutine v2d_insert(vptr,idx,vec) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_insert")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: idx
    type(c_ptr), intent(in) :: vec
    end subroutine v2d_insert
    
    subroutine v2d_pop_back(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_pop_back")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v2d_pop_back

    subroutine v2d_send_with_tag(vptr,dest,tag) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_send_with_tag")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: dest,tag
    end subroutine v2d_send_with_tag
    
    subroutine v2d_send(vptr,dest) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_send")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: dest
    end subroutine v2d_send

    subroutine v2d_recv_with_tag(vptr,source,tag) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_recv_with_tag")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: source,tag
    end subroutine v2d_recv_with_tag

    subroutine v2d_recv(vptr,source) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_recv")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: source
    end subroutine v2d_recv
    
    subroutine v2d_bcast_with_root(vptr,root) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_bcast_with_root")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: root
    end subroutine v2d_bcast_with_root

    subroutine v2d_bcast(vptr) &
    bind(c,name="v2d_"//VEC_TYPE_STRING//"_bcast")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v2d_bcast
  end interface
  
  type, public :: VEC_DATA_TYPE
    private
    
    type(c_ptr), public :: vptr = c_null_ptr

    contains
    
    procedure, public :: delete,&
                         is_empty,&
                         copy,&
                         copy_data,&
                         get_data,&
                         get_data_array,&
                         set_data,&
                         get_row_vec,&
                         get_row_array,&
                         get_col,&
                         set_row,&
                         get_tail_vec,&
                         get_tail_array,&
                         set_tail,&
                         write_to_screen,&
                         insert,&
                         pop_back,&
                         extend_row
                         
    procedure :: ctor_default,&
                 ctor_size,&
                 get_list_size,&
                 get_row_size,&
                 equal_vec_vec,&
                 equal_vec_vptr,&
                 send_with_tag,&
                 send_default_tag,&
                 recv_with_tag,&
                 recv_default_tag,&
                 bcast_with_root,&
                 bcast_default_root,&
                 append_1d_vec,&
                 append_2d_vec,&
                 append_1d_array
                         
    generic, public :: ctor => ctor_default,&
                               ctor_size
                               
    generic, public :: get_size => get_list_size,&
                                   get_row_size
                                   
    generic, public :: assignment(=) => equal_vec_vec,&
                                        equal_vec_vptr

    generic, public :: send => send_with_tag,&
                               send_default_tag
                               
    generic, public :: recv => recv_with_tag,&
                               recv_default_tag
                               
    generic, public :: bcast => bcast_with_root,&
                                bcast_default_root
                                
    generic, public :: append => append_1d_vec,&
                                 append_2d_vec,&
                                 append_1d_array
                                 
    generic, public :: get_row => get_row_vec,&
                                  get_row_array

    generic, public :: get_tail => get_tail_vec,&
                                   get_tail_array
    
  end type
  
contains

!========================================================================================!
  subroutine delete(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this

    if (.not.c_associated(this%vptr)) then
      return
    end if
    
    call v2d_delete(this%vptr)
    
    this%vptr = c_null_ptr

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_default(this) 
    class(VEC_DATA_TYPE), intent(out) :: this

    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v2d_init()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,size) 
    class(VEC_DATA_TYPE), intent(out) :: this
    integer, intent(in) :: size

    if (size<=0) then
      call mpi_abort_run("Invalid size found at ctor vector_2d_"//VEC_TYPE_STRING)
    end if

    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v2d_init_size(size)

  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    logical :: r

    if (.not.c_associated(this%vptr)) then
      !call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
      r = .true.
      return
    end if

    r = v2d_is_empty(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine copy(this,rhs) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_DATA_TYPE), intent(in) :: rhs
    
    if (.not.c_associated(rhs%vptr)) then
      call mpi_abort_run("Attempt to copy empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    call v2d_deep_copy(this%vptr,rhs%vptr)

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
      call mpi_abort_run("rhs_vptr is not associated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.(c_associated(lhs%vptr))) then
      call lhs%ctor()
    end if
    
    call v2d_deep_copy(lhs%vptr,rhs_vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine copy_data(this,x)
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT, allocatable, dimension(:,:), intent(inout) :: x
    integer :: i,j,nrow,ncol,lbi,lbj

    if (this%is_empty()) then
      call mpi_abort_run("this is empty at equal_alloc_vec")
    end if
    
    nrow = this%get_size()

    do i=2,nrow
      if (this%get_size(i).ne.this%get_size(i-1)) then
        call mpi_abort_run("ncol in copy_data should be constant")
      end if
    end do
    
    ncol = this%get_size(1)
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,ncol,1,nrow)
    else if ((size(x,1).ne.ncol).or.(size(x,2).ne.nrow)) then
      call reallocate_array(x,1,ncol,1,nrow)
    end if
    
    lbi = lbound(x,1)
    lbj = lbound(x,2)
    
    do j=1,nrow
      do i=1,ncol
        x(lbi+i-1,lbj+j-1)=this%get_data(j,i)
      end do
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  function get_list_size(this) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer :: size

    if (.not.c_associated(this%vptr)) then
      !call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
      size = 0 
      return
    end if

    size = v2d_get_size(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_row_size(this,irow) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: irow
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((irow<1).or.(irow>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if

    size = v2d_get_row_size(this%vptr,irow-1)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_data(this,i,j) result(val)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i,j
    VEC_TYPE_FORT :: val

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if

    if ((j<1).or.(j>this%get_size(i))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if
    
    val = v2d_get_data(this%vptr,i-1,j-1)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine get_data_array(this,i,a)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i
    VEC_TYPE_FORT, allocatable, dimension(:), intent(inout) :: a
    integer :: j,lb

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if

    if (.not.allocated(a)) then
      call allocate_array(a,1,this%get_size(i))
    else if (size(a).ne.this%get_size(i)) then
      call reallocate_array(a,1,this%get_size(i))
    end if
    
    lb = lbound(a,1)
    
    do j=1,size(a)
      a(lb+j-1)=this%get_data(i,j)
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_data(this,i,j,val)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: i,j
    VEC_TYPE_FORT, intent(in) :: val

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if

    if ((j<1).or.(j>this%get_size(i))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_2d_"//VEC_TYPE_STRING)
    end if
    
    call v2d_set_data(this%vptr,i-1,j-1,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_1d_vec(this,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_RANK1_DATA_TYPE), intent(in) :: vec
    
    if (vec%is_empty()) then
      call mpi_abort_run("vec%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if

    call v2d_append(this%vptr,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_2d_vec(this,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_DATA_TYPE), intent(in) :: vec
    type(VEC_RANK1_DATA_TYPE) :: aux
    integer :: i
    
    if (vec%is_empty()) then
      call mpi_abort_run("vec%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    do i=1,vec%get_size()
      call vec%get_row(i,aux)
      call this%append(aux)
    end do

    call aux%delete()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_1d_array(this,a)
    class(VEC_DATA_TYPE), intent(inout) :: this
    VEC_TYPE_FORT, dimension(:), intent(in) :: a
    type(VEC_RANK1_DATA_TYPE) :: vec
    integer :: i
    
    if (size(a)==0) then
      call mpi_abort_run("attempt to append empty array")
    end if
    
    do i=1,size(a)
      call vec%append(a(i))
    end do

    call this%append(vec)
    
    call vec%delete()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine extend_row(this,irow,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: irow
    type(VEC_RANK1_DATA_TYPE), intent(in) :: vec
    
    if (vec%is_empty()) then
      call mpi_abort_run("vec%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if

    call v2d_extend_row(this%vptr,irow-1,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_row_vec(this,irow,vec)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: irow
    type(VEC_RANK1_DATA_TYPE), intent(inout) :: vec
    
    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((irow<1).or.(irow>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_2d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(vec%vptr)) then
      
      call vec%ctor(this%get_size(irow))
      vec = v2d_get_row(this%vptr,irow-1)
    
    else
    
      if (vec%get_size().ne.this%get_size(irow)) then
        call vec%delete()
        call vec%ctor(this%get_size(irow))
        vec = v2d_get_row(this%vptr,irow-1)
      else
        vec = v2d_get_row(this%vptr,irow-1)
      end if

    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_row_array(this,irow,arr)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: irow
    VEC_TYPE_FORT, allocatable, dimension(:), intent(inout) :: arr
    type(VEC_RANK1_DATA_TYPE) :: vec
    
    call this%get_row(irow,vec)
    
    call vec%copy_data(arr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_col(this,icol,vec) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: icol
    type(VEC_RANK1_DATA_TYPE), intent(inout) :: vec
    integer :: i,n
    
    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    n = this%get_size()
    
    if (.not.c_associated(vec%vptr)) then
      call vec%ctor(n)
    else if (vec%get_size().ne.n) then
      call vec%delete()
      call vec%ctor(n)
    end if
    
    do i=1,n
      if (this%get_size(i)<icol) then
        call mpi_abort_run("get_col out of bounds vector_2d_"//VEC_TYPE_STRING)
      end if
      call vec%set_data(i,this%get_data(i,icol))
    end do

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_row(this,irow,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: irow
    type(VEC_RANK1_DATA_TYPE), intent(in) :: vec

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.c_associated(vec%vptr)) then
      call mpi_abort_run("Attempt to set row from empty vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((irow<1).or.(irow>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_2d_"//VEC_TYPE_STRING)
    end if

    call v2d_set_row(this%vptr,irow-1,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_tail_vec(this,vec)
    class(VEC_DATA_TYPE), intent(in) :: this
    type(VEC_RANK1_DATA_TYPE), intent(inout) :: vec
    integer :: irow
    
    irow = this%get_size()
    
    call this%get_row(irow,vec)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_tail_array(this,arr)
    class(VEC_DATA_TYPE), intent(in) :: this
    VEC_TYPE_FORT, allocatable, dimension(:), intent(inout) :: arr
    type(VEC_RANK1_DATA_TYPE) :: vec
    
    call this%get_tail(vec)
    
    call vec%copy_data(arr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_tail(this,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_RANK1_DATA_TYPE), intent(in) :: vec
    integer :: irow

    irow = this%get_size()
    
    call this%set_row(irow,vec)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_to_screen(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer :: i

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    call v2d_print(this%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine insert(this,idx,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: idx
    type(VEC_RANK1_DATA_TYPE), intent(in) :: vec

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if (vec%is_empty()) then
      call mpi_abort_run("Attempt to insert empty vector_1d_"//VEC_TYPE_STRING)
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_2d_"//VEC_TYPE_STRING)
    end if

    call v2d_insert(this%vptr,idx-1,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine pop_back(this)
    class(VEC_DATA_TYPE), intent(inout) :: this

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_2d_"//VEC_TYPE_STRING)
    end if

    if (this%get_size()<2) then
      call mpi_abort_run("size<2 at pop_back vector_2d_"//VEC_TYPE_STRING)
    end if

    call v2d_pop_back(this%vptr)
    
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

    call v2d_send_with_tag(this%vptr,dest,tag)
    
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

    call v2d_send(this%vptr,dest)
    
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

    call v2d_recv_with_tag(this%vptr,source,tag)
    
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

    call v2d_recv(this%vptr,source)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine bcast_with_root(this,root) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: root

    if ((root<0).or.(root>=mpi_h%nproc)) then
      call mpi_abort_run("invalid dest at vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank==root).and.(.not.c_associated(this%vptr))) then
      call mpi_abort_run("this%vptr not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank.ne.root).and.(.not.c_associated(this%vptr))) then
      call this%ctor()
    end if

    call v2d_bcast_with_root(this%vptr,root)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine bcast_default_root(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    
    if ((mpi_h%rank==0).and.(.not.c_associated(this%vptr))) then
      call mpi_abort_run("this%vptr not allocated for vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((mpi_h%rank.ne.0).and.(.not.c_associated(this%vptr))) then
      call this%ctor()
    end if

    call v2d_bcast(this%vptr)
    
  end subroutine
!========================================================================================!