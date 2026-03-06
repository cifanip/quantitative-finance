module prun_mod

  use mpi
  use omp_lib

  implicit none
  
  logical, protected :: IS_MASTER, IS_PARALLEL
  integer, protected :: N_MPI_RANKS, MPI_RANK, N_THREADS
  
  character(len=:), allocatable :: s_main_dir
  
  public :: init_run,&
            abort_run,&
            end_run,&
            set_root_dir
  
contains

!========================================================================================!
  subroutine init_run(call_mpi_init,root)
    integer :: ierror
    logical, intent(in), optional :: call_mpi_init
    character(len=*), intent(in), optional :: root
    
      if (present(call_mpi_init)) then
        if (call_mpi_init) then
          call MPI_INIT(ierror)
        end if
      else
        call MPI_INIT(ierror)
      end if
      
      call set_root_dir(root)

      call MPI_COMM_RANK(MPI_COMM_WORLD, MPI_RANK, ierror)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, N_MPI_RANKS, ierror)

      if (MPI_RANK == 0) then
        IS_MASTER = .TRUE.
      else
        IS_MASTER = .FALSE.
      end if

      if (N_MPI_RANKS == 1) then
        IS_PARALLEL = .FALSE.
      else
        IS_PARALLEL = .TRUE.
      end if
        
      !set number of threads
      !$OMP PARALLEL DEFAULT(none) &
      !$OMP SHARED(N_THREADS)
       N_THREADS = omp_get_num_threads() 
      !$OMP END PARALLEL  
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine abort_run(msg,opt) 
    character(len=*), intent(in) :: msg
    integer, optional :: opt
    integer :: error_code, ierror

    if (present(opt)) then
      error_code = opt
    else
      error_code = -1
    end if
    
    !if (IS_MASTER) then
      write(*,*) '/***************************************************************/'
      write(*,*) 'mpiABORT CALLED with ERROR CODE: ', error_code
      write(*,*) 'ERROR MESSAGE: ', msg
      write(*,*) '/***************************************************************/'
    !end if
    
    call MPI_ABORT(MPI_COMM_WORLD,error_code,ierror)
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine end_run()
    integer :: ierror
    call MPI_FINALIZE(ierror)
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine set_root_dir(root)
    character(len=*), intent(in), optional :: root
    
    if (present(root)) then
      s_main_dir=root//'/data/'
    else
      s_main_dir='data/'
    end if

  end subroutine
!========================================================================================!

end module prun_mod