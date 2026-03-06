if ((root<0).or.(root>=mpi_h%nproc)) then
  call mpi_abort_run("invalid root at mpi_bcast_array") 
end if

count = size(x)

call mpi_bcast(count,1,mpi_integer,root,mpi_comm_world,ierror)

if (count==0) then
  return
end if

if (size(x).ne.count) then
  call mpi_abort_run("invalid size(x) at mpi_bcast_array")  
end if

call mpi_bcast(x,count,datatype,root,mpi_comm_world,ierror)