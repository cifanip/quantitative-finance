if ((dest<0).or.(dest>=mpi_h%nproc)) then
  call mpi_abort_run("invalid dest found") 
end if
    
count = 1
    
call mpi_send(x,count,datatype,dest,tag,mpi_comm_world,ierror)