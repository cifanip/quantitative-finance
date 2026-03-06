if ((source<0).or.(source>=mpi_h%nproc)) then
  call mpi_abort_run("invalid dest found") 
end if
    
count = 1
    
call mpi_recv(x,count,datatype,source,tag,mpi_comm_world,status,ierror)