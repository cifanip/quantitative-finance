#if vec_dim==1
if (.not. allocated(v)) then
  allocate(character(len=size) :: v, stat=err)  
  if (err /= 0) then
    call mpi_abort_run("Allocation of v in allocate_array_1d_char failed ") 
  end if
else
  call mpi_abort_run("Attempt to allocate allocated array ") 
end if
#endif