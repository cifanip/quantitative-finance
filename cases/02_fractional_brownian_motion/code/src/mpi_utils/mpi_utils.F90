module mpi_utils

  use omp_lib
  use allocatable_utils

  implicit none
  
  type, private :: mpi_utils_type
    
    logical :: is_master, is_parallel
    
    integer :: nproc, rank, nthread
    
    character(len=:), allocatable :: root_dir
    
    contains                                

  end type
  
  ! mpi handler
  type(mpi_utils_type) :: mpi_h
  
  interface
    subroutine fftw_cleanup() &
      bind(c,name='fftw_cleanup')
    end subroutine
  end interface
  
  interface mpi_utils_send
    module procedure mpi_send_integer
    module procedure mpi_send_double
    module procedure mpi_send_complex_double
    module procedure mpi_send_logical
    
    module procedure mpi_send_integer_default_tag
    module procedure mpi_send_double_default_tag
    module procedure mpi_send_complex_double_default_tag
    module procedure mpi_send_logical_default_tag
    
    module procedure mpi_send_array_integer
    module procedure mpi_send_array_double
    module procedure mpi_send_array_complex_double
    module procedure mpi_send_array_logical
    
    module procedure mpi_send_array_integer_default_tag
    module procedure mpi_send_array_double_default_tag
    module procedure mpi_send_array_complex_double_default_tag
    module procedure mpi_send_array_logical_default_tag
  end interface
  
  interface mpi_utils_recv
    module procedure mpi_recv_integer
    module procedure mpi_recv_double
    module procedure mpi_recv_complex_double
    module procedure mpi_recv_logical

    module procedure mpi_recv_integer_default_tag
    module procedure mpi_recv_double_default_tag
    module procedure mpi_recv_complex_double_default_tag
    module procedure mpi_recv_logical_default_tag
    
    module procedure mpi_recv_array_integer
    module procedure mpi_recv_array_double
    module procedure mpi_recv_array_complex_double
    module procedure mpi_recv_array_logical
    
    module procedure mpi_recv_array_integer_default_tag
    module procedure mpi_recv_array_double_default_tag
    module procedure mpi_recv_array_complex_double_default_tag
    module procedure mpi_recv_array_logical_default_tag
  end interface
  
  interface mpi_utils_gather
    module procedure mpi_gather_integer
    module procedure mpi_gather_double
    module procedure mpi_gather_complex_double
    module procedure mpi_gather_logical

    module procedure mpi_gather_integer_default_root
    module procedure mpi_gather_double_default_root
    module procedure mpi_gather_complex_double_default_root
    module procedure mpi_gather_logical_default_root
  end interface
  
  interface mpi_utils_scatter
    module procedure mpi_scatter_integer
    module procedure mpi_scatter_double
    module procedure mpi_scatter_complex_double
    module procedure mpi_scatter_logical

    module procedure mpi_scatter_integer_default_root
    module procedure mpi_scatter_double_default_root
    module procedure mpi_scatter_complex_double_default_root
    module procedure mpi_scatter_logical_default_root
  end interface

  interface mpi_utils_bcast
    module procedure mpi_bcast_integer
    module procedure mpi_bcast_double
    module procedure mpi_bcast_complex_double
    module procedure mpi_bcast_logical

    module procedure mpi_bcast_integer_default_root
    module procedure mpi_bcast_double_default_root
    module procedure mpi_bcast_complex_double_default_root
    module procedure mpi_bcast_logical_default_root

    module procedure mpi_bcast_array_integer
    module procedure mpi_bcast_array_double
    module procedure mpi_bcast_array_complex_double
    module procedure mpi_bcast_array_logical

    module procedure mpi_bcast_array_integer_default_root
    module procedure mpi_bcast_array_double_default_root
    module procedure mpi_bcast_array_complex_double_default_root
    module procedure mpi_bcast_array_logical_default_root
  end interface

  interface mpi_utils_reduce
    module procedure mpi_reduce_integer
    module procedure mpi_reduce_double
    module procedure mpi_reduce_complex_double
    module procedure mpi_reduce_logical

    module procedure mpi_reduce_integer_default_root
    module procedure mpi_reduce_double_default_root
    module procedure mpi_reduce_complex_double_default_root
    module procedure mpi_reduce_logical_default_root
  end interface

contains

!========================================================================================!
  subroutine init_run(root,call_mpi_init)
    character(len=*), intent(in), optional :: root
    logical, intent(in), optional :: call_mpi_init
    integer :: ierror
    
      if (present(call_mpi_init)) then
        if (call_mpi_init) then
          call mpi_init(ierror)
        end if
      else
        call mpi_init(ierror)
      end if
      
      call set_root_dir(root)

      call mpi_comm_rank(mpi_comm_world, mpi_h%rank, ierror)
      call mpi_comm_size(mpi_comm_world, mpi_h%nproc, ierror)

      if (mpi_h%rank == 0) then
        mpi_h%is_master = .true.
      else
        mpi_h%is_master = .false.
      end if

      if (mpi_h%nproc == 1) then
        mpi_h%is_parallel = .false.
      else
        mpi_h%is_parallel = .true.
      end if
        
      !set number of threads
      !$omp parallel default(none) &
      !$omp shared(mpi_h)
       mpi_h%nthread = omp_get_num_threads() 
      !$omp end parallel  
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine end_run()
    integer :: ierror
    call fftw_cleanup()
    call mpi_finalize(ierror)    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_root_dir(root)
    character(len=*), intent(in), optional :: root
    
    if (present(root)) then
      mpi_h%root_dir=root
    else
      mpi_h%root_dir='./'
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_send_integer(x,dest,tag)
    integer, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype  
    
    datatype = mpi_integer
      
#   include "mpi_send_value.F90"

  end subroutine

  subroutine mpi_send_double(x,dest,tag)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_double_precision
      
#   include "mpi_send_value.F90"

  end subroutine

  subroutine mpi_send_complex_double(x,dest,tag)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_double_complex
      
#   include "mpi_send_value.F90"

  end subroutine

  subroutine mpi_send_logical(x,dest,tag)
    logical, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_logical
      
#   include "mpi_send_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_send_integer_default_tag(x,dest)
    integer, intent(inout) :: x
    integer, intent(in) :: dest
    integer :: count,ierror,datatype
    
    call mpi_send_integer(x,dest,0)

  end subroutine

  subroutine mpi_send_double_default_tag(x,dest)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: dest
    integer :: count,ierror,datatype
    
    call mpi_send_double(x,dest,0)

  end subroutine

  subroutine mpi_send_complex_double_default_tag(x,dest)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: dest
    integer :: count,ierror,datatype
    
    call mpi_send_complex_double(x,dest,0)

  end subroutine
  
  subroutine mpi_send_logical_default_tag(x,dest)
    logical, intent(inout) :: x
    integer, intent(in) :: dest
    integer :: count,ierror,datatype
    
    call mpi_send_logical(x,dest,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_recv_integer(x,source,tag)
    integer, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_integer
      
#   include "mpi_recv_value.F90"

  end subroutine

  subroutine mpi_recv_double(x,source,tag)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_double_precision
      
#   include "mpi_recv_value.F90"

  end subroutine

  subroutine mpi_recv_complex_double(x,source,tag)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_double_complex
      
#   include "mpi_recv_value.F90"

  end subroutine

  subroutine mpi_recv_logical(x,source,tag)
    logical, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_logical
      
#   include "mpi_recv_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_recv_integer_default_tag(x,source)
    integer, intent(inout) :: x
    integer, intent(in) :: source
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    call mpi_recv_integer(x,source,0)

  end subroutine

  subroutine mpi_recv_double_default_tag(x,source)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: source
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    call mpi_recv_double(x,source,0)

  end subroutine

  subroutine mpi_recv_complex_double_default_tag(x,source)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: source
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    call mpi_recv_complex_double(x,source,0)

  end subroutine

  subroutine mpi_recv_logical_default_tag(x,source)
    logical, intent(inout) :: x
    integer, intent(in) :: source
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    call mpi_recv_logical(x,source,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_send_array_integer(x,dest,tag)
    integer, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_integer
      
#   include "mpi_send_array.F90"

  end subroutine

  subroutine mpi_send_array_double(x,dest,tag)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_double_precision
      
#   include "mpi_send_array.F90"

  end subroutine

  subroutine mpi_send_array_complex_double(x,dest,tag)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_double_complex
      
#   include "mpi_send_array.F90"

  end subroutine

  subroutine mpi_send_array_logical(x,dest,tag)
    logical, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest,tag
    integer :: count,ierror,datatype
    
    datatype = mpi_logical
      
#   include "mpi_send_array.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_send_array_integer_default_tag(x,dest)
    integer, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest
    
    call mpi_utils_send(x,dest,0)

  end subroutine

  subroutine mpi_send_array_double_default_tag(x,dest)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest
    
    call mpi_utils_send(x,dest,0)

  end subroutine

  subroutine mpi_send_array_complex_double_default_tag(x,dest)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest
    
    call mpi_utils_send(x,dest,0)

  end subroutine

  subroutine mpi_send_array_logical_default_tag(x,dest)
    logical, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: dest
    
    call mpi_utils_send(x,dest,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_recv_array_integer(x,source,tag)
    integer, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_integer
      
#   include "mpi_recv_array.F90"

  end subroutine

  subroutine mpi_recv_array_double(x,source,tag)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_double_precision
      
#   include "mpi_recv_array.F90"

  end subroutine
  
  subroutine mpi_recv_array_complex_double(x,source,tag)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_double_complex
      
#   include "mpi_recv_array.F90"

  end subroutine

  subroutine mpi_recv_array_logical(x,source,tag)
    logical, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source,tag
    integer :: count,ierror,datatype
    integer, dimension(mpi_status_size) :: status
    
    datatype = mpi_logical
      
#   include "mpi_recv_array.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_recv_array_integer_default_tag(x,source)
    integer, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source
    
    call mpi_utils_recv(x,source,0)

  end subroutine

  subroutine mpi_recv_array_double_default_tag(x,source)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source
    
    call mpi_utils_recv(x,source,0)

  end subroutine
  
  subroutine mpi_recv_array_complex_double_default_tag(x,source)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source
    
    call mpi_utils_recv(x,source,0)

  end subroutine

  subroutine mpi_recv_array_logical_default_tag(x,source)
    logical, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: source
    
    call mpi_utils_recv(x,source,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_gather_integer(x,v,root)
    integer, intent(in) :: x
    integer, dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_integer
    recvtype = mpi_integer
      
#   include "mpi_gather_value.F90"

  end subroutine

  subroutine mpi_gather_double(x,v,root)
    real(double_p), intent(in) :: x
    real(double_p), dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_double_precision
    recvtype = mpi_double_precision
      
#   include "mpi_gather_value.F90"

  end subroutine

  subroutine mpi_gather_complex_double(x,v,root)
    complex(double_p), intent(in) :: x
    complex(double_p), dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_double_complex
    recvtype = mpi_double_complex
      
#   include "mpi_gather_value.F90"

  end subroutine
  
  subroutine mpi_gather_logical(x,v,root)
    logical, intent(in) :: x
    logical, dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_logical
    recvtype = mpi_logical
      
#   include "mpi_gather_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_gather_integer_default_root(x,v)
    integer, intent(in) :: x
    integer, dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_gather(x,v,0)

  end subroutine

  subroutine mpi_gather_double_default_root(x,v)
    real(double_p), intent(in) :: x
    real(double_p), dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_gather(x,v,0)

  end subroutine

  subroutine mpi_gather_complex_double_default_root(x,v)
    complex(double_p), intent(in) :: x
    complex(double_p), dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_gather(x,v,0)

  end subroutine
  
  subroutine mpi_gather_logical_default_root(x,v)
    logical, intent(in) :: x
    logical, dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_gather(x,v,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_scatter_integer(x,v,root)
    integer, intent(inout) :: x
    integer, dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_integer
    recvtype = mpi_integer
      
#   include "mpi_scatter_value.F90"

  end subroutine
  
  subroutine mpi_scatter_double(x,v,root)
    real(double_p), intent(inout) :: x
    real(double_p), dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_double_precision
    recvtype = mpi_double_precision
      
#   include "mpi_scatter_value.F90"

  end subroutine
  
  subroutine mpi_scatter_complex_double(x,v,root)
    complex(double_p), intent(inout) :: x
    complex(double_p), dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_double_complex
    recvtype = mpi_double_complex
      
#   include "mpi_scatter_value.F90"

  end subroutine
  
  subroutine mpi_scatter_logical(x,v,root)
    logical, intent(inout) :: x
    logical, dimension(:), contiguous, intent(inout) :: v
    integer, intent(in) :: root
    integer :: sendcount,recvcount
    integer :: sendtype,recvtype
    integer :: ierror
    
    sendtype = mpi_logical
    recvtype = mpi_logical
      
#   include "mpi_scatter_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_scatter_integer_default_root(x,v)
    integer, intent(inout) :: x
    integer, dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_scatter(x,v,0)

  end subroutine
  
  subroutine mpi_scatter_double_default_root(x,v)
    real(double_p), intent(inout) :: x
    real(double_p), dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_scatter(x,v,0)

  end subroutine
  
  subroutine mpi_scatter_complex_double_default_root(x,v)
    complex(double_p), intent(inout) :: x
    complex(double_p), dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_scatter(x,v,0)

  end subroutine
  
  subroutine mpi_scatter_logical_default_root(x,v)
    logical, intent(inout) :: x
    logical, dimension(:), contiguous, intent(inout) :: v
    
    call mpi_utils_scatter(x,v,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_bcast_integer(x,root)
    integer, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_integer
      
#   include "mpi_bcast_value.F90"

  end subroutine

  subroutine mpi_bcast_double(x,root)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_double_precision
      
#   include "mpi_bcast_value.F90"

  end subroutine

  subroutine mpi_bcast_complex_double(x,root)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_double_complex
      
#   include "mpi_bcast_value.F90"

  end subroutine
  
  subroutine mpi_bcast_logical(x,root)
    logical, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_logical
      
#   include "mpi_bcast_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_bcast_integer_default_root(x)
    integer, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine

  subroutine mpi_bcast_double_default_root(x)
    real(double_p), intent(inout) :: x
    integer :: count,datatype,ierror
    
    call mpi_utils_bcast(x,0)

  end subroutine

  subroutine mpi_bcast_complex_double_default_root(x)
    complex(double_p), intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine
  
  subroutine mpi_bcast_logical_default_root(x)
    logical, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_bcast_array_integer(x,root)
    integer, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_integer
      
#   include "mpi_bcast_array.F90"

  end subroutine

  subroutine mpi_bcast_array_double(x,root)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_double_precision
      
#   include "mpi_bcast_array.F90"

  end subroutine

  subroutine mpi_bcast_array_complex_double(x,root)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_double_complex
      
#   include "mpi_bcast_array.F90"

  end subroutine
  
  subroutine mpi_bcast_array_logical(x,root)
    logical, dimension(:), contiguous, intent(inout) :: x
    integer, intent(in) :: root
    integer :: count,datatype,ierror
    
    datatype = mpi_logical
      
#   include "mpi_bcast_array.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_bcast_array_integer_default_root(x)
    integer, dimension(:), contiguous, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine

  subroutine mpi_bcast_array_double_default_root(x)
    real(double_p), dimension(:), contiguous, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine

  subroutine mpi_bcast_array_complex_double_default_root(x)
    complex(double_p), dimension(:), contiguous, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine
  
  subroutine mpi_bcast_array_logical_default_root(x)
    logical, dimension(:), contiguous, intent(inout) :: x
    
    call mpi_utils_bcast(x,0)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_reduce_integer(x,operation,root)
    integer, intent(inout) :: x
    integer, intent(in) :: operation
    integer, intent(in) :: root
    integer :: y
    integer :: count,datatype,ierror
    
    datatype = mpi_integer
      
#   include "mpi_reduce_value.F90"

  end subroutine

  subroutine mpi_reduce_double(x,operation,root)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: operation
    integer, intent(in) :: root
    real(double_p) :: y
    integer :: op,count,datatype,ierror
    
    datatype = mpi_double_precision
      
#   include "mpi_reduce_value.F90"

  end subroutine

  subroutine mpi_reduce_complex_double(x,operation,root)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: operation
    integer, intent(in) :: root
    complex(double_p) :: y
    integer :: op,count,datatype,ierror
    
    datatype = mpi_double_complex
      
#   include "mpi_reduce_value.F90"

  end subroutine

  subroutine mpi_reduce_logical(x,operation,root)
    logical, intent(inout) :: x
    integer, intent(in) :: operation
    integer, intent(in) :: root
    logical :: y
    integer :: op,count,datatype,ierror
    
    datatype = mpi_logical
      
#   include "mpi_reduce_value.F90"

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine mpi_reduce_integer_default_root(x,operation)
    integer, intent(inout) :: x
    integer, intent(in) :: operation
    
    call mpi_utils_reduce(x,operation,0)

  end subroutine

  subroutine mpi_reduce_double_default_root(x,operation)
    real(double_p), intent(inout) :: x
    integer, intent(in) :: operation
    
    call mpi_utils_reduce(x,operation,0)

  end subroutine

  subroutine mpi_reduce_complex_double_default_root(x,operation)
    complex(double_p), intent(inout) :: x
    integer, intent(in) :: operation
    
    call mpi_utils_reduce(x,operation,0)

  end subroutine

  subroutine mpi_reduce_logical_default_root(x,operation)
    logical, intent(inout) :: x
    integer, intent(in) :: operation
    
    call mpi_utils_reduce(x,operation,0)

  end subroutine
!========================================================================================!

end module mpi_utils