module vector_tseries
  
  use scalar_tseries

  implicit none
  
  type, public :: vector_tseries_type
    private
    
    ! (i,j,k) -> i = time id, j = dimension id, k = realisation id
    real(double_p), allocatable, dimension(:,:,:), public :: x

    contains
    
    procedure, public :: delete,&
                         is_empty,&
                         get_ntime,&
                         get_ndim,&
                         get_nreal,&
                         set_scalar_tseries,&
                         write_to_disk
                         
    procedure, private :: ctor_size,&
                          ctor_size_value,&
                          equal
                         
    generic, public :: ctor => ctor_size,&
                               ctor_size_value

    generic, public :: assignment(=) => equal
    
  end type

  private :: delete,&
             ctor_size,&
             ctor_size_value,&
             is_empty,&
             equal,&
             get_ntime,&
             get_ndim,&
             get_nreal,&
             set_scalar_tseries,&
             write_to_disk

contains

!========================================================================================!
  subroutine delete(this) 
    class(vector_tseries_type), intent(inout) :: this
    
    call deallocate_array(this%x)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,ntime,ndim,nreal) 
    class(vector_tseries_type), intent(out) :: this
    integer, intent(in) :: ntime,ndim,nreal
    
    if (ntime<=0) then
      call mpi_abort_run("invalid ntime at vector_tseries%ctor_size")
    end if

    if (ndim<=0) then
      call mpi_abort_run("invalid ndim at vector_tseries%ctor_size")
    end if

    if (nreal<=0) then
      call mpi_abort_run("invalid nreal at vector_tseries%ctor_size")
    end if
    
    call allocate_array(this%x,1,ntime,1,ndim,1,nreal)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size_value(this,ntime,ndim,nreal,val) 
    class(vector_tseries_type), intent(out) :: this
    integer, intent(in) :: ntime,ndim,nreal
    real(double_p), intent(in) :: val
    
    call this%ctor(ntime,ndim,nreal)
    
    this%x = val
    
  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r)
    class(vector_tseries_type), intent(in) :: this
    logical :: r
    
    if (.not.allocated(this%x)) then
      r = .true.
      return
    end if
    
    if (size(this%x)==0) then
      r = .true.
      return      
    end if
    
    r = .false.

  end function
!========================================================================================!

!========================================================================================!
  subroutine equal(lhs,rhs)
    class(vector_tseries_type), intent(inout) :: lhs
    type(vector_tseries_type), intent(in) :: rhs
    
    if (.not.allocated(lhs%x)) then
      call mpi_abort_run("lhs%x not allocated at vector_tseries%equal")
    end if

    if (.not.allocated(rhs%x)) then
      call mpi_abort_run("rhs%x not allocated at vector_tseries%equal")
    end if
    
    if ((size(lhs%x,1).ne.size(rhs%x,1)).or.&
        (size(lhs%x,2).ne.size(rhs%x,2)).or.&
        (size(lhs%x,3).ne.size(rhs%x,3))) then
      call mpi_abort_run("size(lhs).ne.size(rhs) at vector_tseries%equal")
    end if
    
    lhs%x = rhs%x

  end subroutine
!========================================================================================!

!========================================================================================!
  function get_ntime(this) result(n)
    class(vector_tseries_type), intent(in) :: this
    integer :: n
    
    if (.not.allocated(this%x)) then
      call mpi_abort_run("this%x not allocated at vector_tseries%get_ntime")
    end if
    
    n = size(this%x,1)

  end function
!========================================================================================!

!========================================================================================!
  function get_ndim(this) result(n)
    class(vector_tseries_type), intent(in) :: this
    integer :: n
    
    if (.not.allocated(this%x)) then
      call mpi_abort_run("this%x not allocated at vector_tseries%get_ndim")
    end if
    
    n = size(this%x,2)

  end function
!========================================================================================!

!========================================================================================!
  function get_nreal(this) result(n)
    class(vector_tseries_type), intent(in) :: this
    integer :: n
    
    if (.not.allocated(this%x)) then
      call mpi_abort_run("this%x not allocated at vector_tseries%get_nreal")
    end if
    
    n = size(this%x,3)

  end function
!========================================================================================!

!========================================================================================!
  subroutine set_scalar_tseries(this,dim_loc,s)
    class(vector_tseries_type), intent(inout) :: this
    integer, intent(in) :: dim_loc
    type(scalar_tseries_type), intent(in) :: s
    
    if (this%is_empty()) then
      call mpi_abort_run("this%is_empty at vector_tseries%set_scalar_tseries")
    end if
    
    if ((dim_loc<1).or.(dim_loc>this%get_ndim())) then
      call mpi_abort_run("invalid dim_loc at vector_tseries%set_scalar_tseries")
    end if
    
    if (s%get_ntime().ne.this%get_ntime()) then
      call mpi_abort_run("invalid s%get_ntime() at vector_tseries%set_scalar_tseries")
    end if
    
    this%x(:,dim_loc,:)=s%x

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_to_disk(this,fname)
    class(vector_tseries_type), intent(inout) :: this
    character(len=*), intent(in) :: fname
    
    if (this%is_empty()) then
      return
    end if
    
    call array_write_hdf(this%x,fname,"v_ts")

  end subroutine
!========================================================================================!

end module vector_tseries