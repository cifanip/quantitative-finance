module scalar_tseries
  
  use array_utils

  implicit none
  
  type, public :: scalar_tseries_type
    private
    
    ! (i,j) -> i = time id, j = realisation id
    real(double_p), allocatable, dimension(:,:), public :: x 

    contains
    
    procedure, public :: delete,&
                         is_empty,&
                         get_ntime,&
                         get_nreal,&
                         write_to_disk
                         
    procedure :: ctor_size,&
                 ctor_size_value,&
                 ctor_read_from_disk,&
                 equal
                         
    generic, public :: ctor => ctor_size,&
                               ctor_size_value,&
                               ctor_read_from_disk

    generic, public :: assignment(=) => equal
    
  end type

  private :: delete,&
             ctor_size,&
             ctor_size_value,&
             ctor_read_from_disk,&
             is_empty,&
             equal,&
             get_ntime,&
             get_nreal,&
             write_to_disk

contains

!========================================================================================!
  subroutine delete(this) 
    class(scalar_tseries_type), intent(inout) :: this
    
    call deallocate_array(this%x)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size(this,nt,nr) 
    class(scalar_tseries_type), intent(out) :: this
    integer, intent(in) :: nt,nr
    
    if (nt<=0) then
      call mpi_abort_run("invalid nt at scalar_tseries%ctor_size")
    end if

    if (nr<=0) then
      call mpi_abort_run("invalid nr at scalar_tseries%ctor_size")
    end if
    
    call allocate_array(this%x,1,nt,1,nr)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_size_value(this,nt,nr,val) 
    class(scalar_tseries_type), intent(out) :: this
    integer, intent(in) :: nt,nr
    real(double_p), intent(in) :: val
    
    call this%ctor(nt,nr)
    
    this%x = val
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor_read_from_disk(this,path_to_file,dset_name) 
    class(scalar_tseries_type), intent(out) :: this
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: dset_name
    
    call array_read_hdf(this%x,path_to_file,dset_name)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  function is_empty(this) result(r)
    class(scalar_tseries_type), intent(in) :: this
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
    class(scalar_tseries_type), intent(inout) :: lhs
    type(scalar_tseries_type), intent(in) :: rhs
    
    if (.not.allocated(lhs%x)) then
      call mpi_abort_run("lhs%x not allocated at scalar_tseries%equal")
    end if

    if (.not.allocated(rhs%x)) then
      call mpi_abort_run("rhs%x not allocated at scalar_tseries%equal")
    end if
    
    if ((size(lhs%x,1).ne.size(rhs%x,1)).or.& 
        (size(lhs%x,2).ne.size(rhs%x,2))) then
      call mpi_abort_run("size(lhs).ne.size(rhs) at scalar_tseries%equal")
    end if
    
    lhs%x = rhs%x

  end subroutine
!========================================================================================!

!========================================================================================!
  function get_ntime(this) result(n)
    class(scalar_tseries_type), intent(in) :: this
    integer :: n
    
    if (.not.allocated(this%x)) then
      call mpi_abort_run("this%x not allocated at scalar_tseries%get_ntime")
    end if
    
    n = size(this%x,1)

  end function
!========================================================================================!

!========================================================================================!
  function get_nreal(this) result(n)
    class(scalar_tseries_type), intent(in) :: this
    integer :: n
    
    if (.not.allocated(this%x)) then
      call mpi_abort_run("this%x not allocated at scalar_tseries%get_nreal")
    end if
    
    n = size(this%x,2)

  end function
!========================================================================================!

!========================================================================================!
  subroutine write_to_disk(this,path_to_file)
    class(scalar_tseries_type), intent(in) :: this
    character(len=*), intent(in) :: path_to_file

    if (this%is_empty()) then
      return
    end if
    
    call array_write_hdf(this%x,path_to_file,"s_ts")

  end subroutine
!========================================================================================!

end module scalar_tseries