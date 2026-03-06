if ((root<0).or.(root>=mpi_h%nproc)) then
  call mpi_abort_run("invalid root found") 
end if

count = 1

call mpi_reduce(x,y,count,datatype,operation,root,mpi_comm_world,ierror)

if (mpi_h%rank==root) then
  x = y
end if