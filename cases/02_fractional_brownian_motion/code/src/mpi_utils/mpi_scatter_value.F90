if ((root<0).or.(root>=mpi_h%nproc)) then
  call mpi_abort_run("invalid root at mpi_scatter_value") 
end if

if (mpi_h%rank==root) then

  if (size(v).ne.mpi_h%nproc) then
    call mpi_abort_run("invalid size(v) at mpi_scatter_value")
  end if
  
end if
    
sendcount = 1
recvcount = 1
    
call mpi_scatter(v,sendcount,sendtype,x,recvcount,recvtype,&
                 root,mpi_comm_world,ierror)