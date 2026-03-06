if ((source<0).or.(source>=mpi_h%nproc)) then
  call mpi_abort_run("invalid dest found")
end if

call mpi_recv(count,1,mpi_integer,source,0,mpi_comm_world,status,ierror)

if (count==0) then
  return
end if

if (size(x).ne.count) then
  call mpi_abort_run("invalid size(x) at mpi_recv_array")
end if
    
call mpi_recv(x,count,datatype,source,tag,mpi_comm_world,status,ierror)