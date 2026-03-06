count = size(x)

call mpi_send(count,1,mpi_integer,dest,0,mpi_comm_world,ierror)

if (count==0) then
  return
end if

call mpi_send(x,count,datatype,dest,tag,mpi_comm_world,ierror)