if ((root<0).or.(root>=mpi_h%nproc)) then
  call mpi_abort_run("invalid root at mpi_gather_value") 
end if

if (mpi_h%rank==root) then

  if (size(v).ne.mpi_h%nproc) then
    call mpi_abort_run("invalid size(v) at mpi_gather_value") 
  end if

end if
    
sendcount = 1
recvcount = 1
    
call mpi_gather(x,sendcount,sendtype,v,recvcount,recvtype,&
                root,mpi_comm_world,ierror)