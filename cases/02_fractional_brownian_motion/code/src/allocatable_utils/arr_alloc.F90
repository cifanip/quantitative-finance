#if vec_dim==1
if (.not. allocated(v)) then
  allocate(v(st:en),stat=err)
  if (err /= 0) then
    call mpi_abort_run("Allocation of v in allocate_array_1d failed ") 
  end if  
else
    call mpi_abort_run("Attempt to allocate allocated array ") 
end if
#endif

#if vec_dim==2
if (.not. allocated(v)) then
  allocate(v(st1:en1,st2:en2),stat=err)
  if (err /= 0) then
    call mpi_abort_run("Allocation of v in allocate_array_2d failed ")
  end if    
else
  call mpi_abort_run("Attempt to allocate allocated array ") 
end if
#endif

#if vec_dim==3
if (.not. allocated(v)) then
  allocate(v(st1:en1,st2:en2,st3:en3),stat=err)
  if (err /= 0) then
    call mpi_abort_run("Allocation of v in allocate_array_3d failed ")
  end if
else
  call mpi_abort_run("Attempt to allocate allocated array ") 
end if
#endif

#if vec_dim==4
if (.not. allocated(v)) then
  allocate(v(st1:en1,st2:en2,st3:en3,st4:en4),stat=err)
  if (err /= 0) then
    call mpi_abort_run("Allocation of v in allocateArray4D failed ")
  end if
else
  call mpi_abort_run("Attempt to allocate allocated array ") 
end if
#endif