if ((root<0).or.(root>=mpi_h%nproc)) then
  call mpi_abort_run("invalid root found") 
end if

count = 1

call mpi_bcast(x,count,datatype,root,mpi_comm_world,ierror)