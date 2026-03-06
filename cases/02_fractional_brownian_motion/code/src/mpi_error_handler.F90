module mpi_error_handler
  
  use mpi
  
  implicit none
  
  contains

!========================================================================================!
  subroutine mpi_abort_run(msg,opt)
    character(len=*), intent(in) :: msg
    integer, optional, intent(in) :: opt
    integer :: error_code, ierror

    if (present(opt)) then
      error_code = opt
    else
      error_code = -1
    end if
    
    write(*,*) "/***************************************************************/"
    write(*,*) "mpi_abort called with ERROR CODE: ", error_code
    write(*,*) "ERROR MESSAGE: ", msg
    write(*,*) "/***************************************************************/"
    
    call mpi_abort(mpi_comm_world,error_code,ierror)
    
  end subroutine
!========================================================================================!

end module mpi_error_handler