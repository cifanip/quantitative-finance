  use allocatable_utils
  use, intrinsic :: iso_c_binding

  implicit none
  
  private
  
  interface
    function v3d_init() result(vptr) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_init")
    import
    type(c_ptr) :: vptr
    end function v3d_init

    function v3d_init_size(size) result(vptr) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_init_size")
    import
    integer(c_int), intent(in), value :: size
    type(c_ptr) :: vptr
    end function v3d_init_size

    subroutine v3d_delete(vptr) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_delete")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v3d_delete
    
    subroutine v3d_deep_copy(lhs,rhs) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_deep_copy")
    import
    type(c_ptr), intent(inout) :: lhs
    type(c_ptr), intent(in) :: rhs
    end subroutine v3d_deep_copy

    function v3d_is_empty(vptr) result(r) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_is_empty")
    import
    type(c_ptr), intent(in) :: vptr
    logical(c_bool) :: r
    end function v3d_is_empty

    function v3d_get_list_size(vptr) result(size) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_list_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int) :: size
    end function v3d_get_list_size
    
    function v3d_get_sub_list_size(vptr,i) result(size) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_sub_list_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: i
    integer(c_int) :: size
    end function v3d_get_sub_list_size
    
    function v3d_get_sub_sub_list_size(vptr,i,j) result(size) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_sub_sub_list_size")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: i,j
    integer(c_int) :: size
    end function v3d_get_sub_sub_list_size

    function v3d_get_data(vptr,i,j,k) result(val) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_data")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: i,j,k
    VEC_TYPE_CPP :: val
    end function v3d_get_data

    subroutine v3d_set_data(vptr,i,j,k,val) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_set_data")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: i,j,k
    VEC_TYPE_CPP, intent(in), value :: val
    end subroutine v3d_set_data
    
    subroutine v3d_append(vptr,vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_append")
    import
    type(c_ptr), intent(inout) :: vptr
    type(c_ptr), intent(in) :: vec
    end subroutine v3d_append

    function v3d_get_row(vptr,irow) result(vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_row")
    import
    type(c_ptr), intent(in) :: vptr
    integer(c_int), intent(in), value :: irow
    type(c_ptr) :: vec
    end function v3d_get_row

    subroutine v3d_set_row(vptr,irow,vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_set_row")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: irow
    type(c_ptr), intent(in) :: vec
    end subroutine v3d_set_row

    function v3d_get_tail(vptr) result(vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_get_tail")
    import
    type(c_ptr), intent(in) :: vptr
    type(c_ptr) :: vec
    end function v3d_get_tail

    subroutine v3d_set_tail(vptr,vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_set_tail")
    import
    type(c_ptr), intent(inout) :: vptr
    type(c_ptr), intent(in) :: vec
    end subroutine v3d_set_tail

    subroutine v3d_print(vptr) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_print")
    import
    type(c_ptr), intent(in) :: vptr
    end subroutine v3d_print
    
    subroutine v3d_insert(vptr,idx,vec) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_insert")
    import
    type(c_ptr), intent(inout) :: vptr
    integer(c_int), intent(in), value :: idx
    type(c_ptr), intent(in) :: vec
    end subroutine v3d_insert
    
    subroutine v3d_pop_back(vptr) &
    bind(c,name="v3d_"//VEC_TYPE_STRING//"_pop_back")
    import
    type(c_ptr), intent(inout) :: vptr
    end subroutine v3d_pop_back
  end interface
  
  type, public :: VEC_DATA_TYPE
    private
    
    type(c_ptr), public :: vptr = c_null_ptr

    contains
    
    procedure, public :: delete,&
                         is_empty,&
                         copy,&
                         get_data,&
                         set_data,&
                         append_2d_vec,&
                         append_2d_array,&
                         get_row,&
                         set_row,&
                         get_tail,&
                         set_tail,&
                         write_to_screen,&
                         insert,&
                         pop_back,&
                         get_1d_array,&
                         get_2d_array,&
                         is_matrix
    
    procedure :: ctor_default,&
                 ctor_size,&
                 get_list_size,&
                 get_sub_list_size,&
                 get_sub_sub_list_size,&
                 equal_vec_vec,&
                 equal_vec_vptr
    
    generic, public :: ctor => ctor_default,&
                               ctor_size
                               
    generic, public :: get_size => get_list_size,&
                                   get_sub_list_size,&
                                   get_sub_sub_list_size
                                   
    generic, public :: assignment(=) => equal_vec_vec,&
                                        equal_vec_vptr
                                        
    generic, public :: append => append_2d_vec,&
                                 append_2d_array

    generic, public :: get_array => get_1d_array,&
                                    get_2d_array
    
  end type
  
contains

!========================================================================================!
  subroutine delete(this) 
    class(VEC_DATA_TYPE), intent(inout) :: this

    if (.not.c_associated(this%vptr)) then
      return
    end if
    
    call v3d_delete(this%vptr)
    
    this%vptr = c_null_ptr

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_default(this) 
    class(VEC_DATA_TYPE), intent(out) :: this

    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v3d_init()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,size) 
    class(VEC_DATA_TYPE), intent(out) :: this
    integer, intent(in) :: size

    if (size<=0) then
      call mpi_abort_run("Invalid size found at ctor vector_3d_"//VEC_TYPE_STRING)
    end if

    if (c_associated(this%vptr)) then
      call this%delete()
    end if
    
    this%vptr = v3d_init_size(size)

  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r) 
    class(VEC_DATA_TYPE), intent(in) :: this
    logical :: r

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if

    r = v3d_is_empty(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine copy(this,rhs) 
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_DATA_TYPE), intent(in) :: rhs
    
    if (.not.c_associated(rhs%vptr)) then
      call mpi_abort_run("Attempt to copy empty vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if
    
    call v3d_deep_copy(this%vptr,rhs%vptr)

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
      call mpi_abort_run("rhs_vptr is not associated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.(c_associated(lhs%vptr))) then
      call lhs%ctor()
    end if
    
    call v3d_deep_copy(lhs%vptr,rhs_vptr)

  end subroutine
!========================================================================================!

!========================================================================================!
  function get_list_size(this) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer :: size

    if (.not.c_associated(this%vptr)) then
      ! call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
      size = 0
      return
    end if

    size = v3d_get_list_size(this%vptr)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_sub_list_size(this,i) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    size = v3d_get_sub_list_size(this%vptr,i-1)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_sub_sub_list_size(this,i,j) result(size) 
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i,j
    integer :: size

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    if ((j<1).or.(j>this%get_size(i))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    size = v3d_get_sub_sub_list_size(this%vptr,i-1,j-1)
    
  end function
!========================================================================================!

!========================================================================================!
  function get_data(this,i,j,k) result(val)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i,j,k
    VEC_TYPE_FORT :: val

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    if ((j<1).or.(j>this%get_size(i))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    if ((k<1).or.(k>this%get_size(i,j))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    val = v3d_get_data(this%vptr,i-1,j-1,k-1)
    
  end function
!========================================================================================!

!========================================================================================!
  subroutine set_data(this,i,j,k,val)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: i,j,k
    VEC_TYPE_FORT, intent(in) :: val

    if (.not.c_associated(this%vptr)) then
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((i<1).or.(i>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if

    if ((j<1).or.(j>this%get_size(i))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((k<1).or.(k>this%get_size(i,j))) then
      call mpi_abort_run("Attempt to access out of bounds at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    call v3d_set_data(this%vptr,i-1,j-1,k-1,val)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_2d_vec(this,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_RANK2_DATA_TYPE), intent(in) :: vec
    
    if (vec%is_empty()) then
      call mpi_abort_run("vec%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(this%vptr)) then
      call this%ctor()
    end if

    call v3d_append(this%vptr,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine append_2d_array(this,a)
    class(VEC_DATA_TYPE), intent(inout) :: this
    VEC_TYPE_FORT, dimension(:,:), intent(in) :: a
    type(VEC_RANK2_DATA_TYPE) :: vec
    integer :: i
    
    if (size(a)==0) then
      call mpi_abort_run("attempt to append empty array")
    end if
    
    do i=1,size(a,1)
      call vec%append(a(i,:))
    end do

    call this%append(vec)
    
    call vec%delete()
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_row(this,irow,vec)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: irow
    type(VEC_RANK2_DATA_TYPE), intent(inout) :: vec
    
    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if ((irow<1).or.(irow>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_3d_"//VEC_TYPE_STRING)
    end if

    if (.not.c_associated(vec%vptr)) then
      
      call vec%ctor(this%get_size(irow))
      vec = v3d_get_row(this%vptr,irow-1)
    
    else
    
      if (vec%get_size().ne.this%get_size(irow)) then
        call vec%delete()
        call vec%ctor(this%get_size(irow))
        vec = v3d_get_row(this%vptr,irow-1)
      else
        vec = v3d_get_row(this%vptr,irow-1)
      end if

    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_row(this,irow,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: irow
    type(VEC_RANK2_DATA_TYPE), intent(in) :: vec

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access tail of empty vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.c_associated(vec%vptr)) then
      call mpi_abort_run("Attempt to set row from empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((irow<1).or.(irow>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_3d_"//VEC_TYPE_STRING)
    end if

    call v3d_set_row(this%vptr,irow-1,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_tail(this,vec)
    class(VEC_DATA_TYPE), intent(in) :: this
    type(VEC_RANK2_DATA_TYPE), intent(inout) :: vec
    integer :: irow
    
    irow = this%get_size()
    
    call this%get_row(irow,vec)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_tail(this,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    type(VEC_RANK2_DATA_TYPE), intent(in) :: vec
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
      call mpi_abort_run("this%vptr is not allocated for vector_3d_"//VEC_TYPE_STRING)
    end if
    
    call v3d_print(this%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine insert(this,idx,vec)
    class(VEC_DATA_TYPE), intent(inout) :: this
    integer, intent(in) :: idx
    type(VEC_RANK2_DATA_TYPE), intent(in) :: vec

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (vec%is_empty()) then
      call mpi_abort_run("Attempt to insert empty vector_2d_"//VEC_TYPE_STRING)
    end if
    
    if ((idx<1).or.(idx>this%get_size())) then
      call mpi_abort_run("Attempt to access out of bounds vector_3d_"//VEC_TYPE_STRING)
    end if
    
    call v3d_insert(this%vptr,idx-1,vec%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine pop_back(this)
    class(VEC_DATA_TYPE), intent(inout) :: this

    if (this%is_empty()) then
      call mpi_abort_run("Attempt to access empty vector_3d_"//VEC_TYPE_STRING)
    end if

    if (this%get_size()<2) then
      call mpi_abort_run("size<2 at pop_back vector_3d_"//VEC_TYPE_STRING)
    end if

    call v3d_pop_back(this%vptr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_1d_array(this,i,j,x)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i,j
    VEC_TYPE_FORT, allocatable, dimension(:), intent(inout) :: x
    integer :: k,lb

    if (this%is_empty()) then
      call mpi_abort_run("Vec is empty at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,this%get_size(i,j))
    else if (size(x).ne.this%get_size(i,j)) then
      call reallocate_array(x,1,this%get_size(i,j))
    end if
    
    lb=lbound(x,1)

    do k=1,size(x)
      x(lb+k-1)=this%get_data(i,j,k)
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine get_2d_array(this,i,x)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i
    VEC_TYPE_FORT, allocatable, dimension(:,:), intent(inout) :: x
    integer :: nj,nk,j,k,lbj,lbk

    if (this%is_empty()) then
      call mpi_abort_run("Vec is empty at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (.not.this%is_matrix(i)) then
      call mpi_abort_run("Attempt to get invalid matrix at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    nj = this%get_size(i)
    nk = this%get_size(i,1)
    
    if (.not.allocated(x)) then
      call allocate_array(x,1,nj,1,nk)
    else if ((size(x,1).ne.nj).or.(size(x,1).ne.nk)) then
      call reallocate_array(x,1,nj,1,nk)
    end if
    
    lbj = lbound(x,1)
    lbk = lbound(x,2)
    
    do k=1,nk
      do j=1,nj
        x(lbj+j-1,lbk+k-1)=this%get_data(i,j,k)
      end do
    end do
    
  end subroutine
!========================================================================================!

!========================================================================================!
  function is_matrix(this,i) result(r)
    class(VEC_DATA_TYPE), intent(in) :: this
    integer, intent(in) :: i
    logical :: r
    integer :: j,n
    
    r = .true.

    if (this%is_empty()) then
      call mpi_abort_run("Vec is empty at vector_3d_"//VEC_TYPE_STRING)
    end if
    
    if (i>this%get_size()) then
      call mpi_abort_run("i > this%get_size(i) at vector_3d_"//VEC_TYPE_STRING)
    end if    
    
    if (this%get_size(i)==0) then
      r = .false.
      return
    end if
    
    n = this%get_size(i,1)
    
    do j=2,this%get_size(i)
      if (this%get_size(i,j).ne.n) then
        r = .false.
        return
      end if
    end do
    
  end function
!========================================================================================!