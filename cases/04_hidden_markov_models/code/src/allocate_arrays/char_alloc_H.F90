#if vec_dim==1
if (.not. allocated(v)) then
  allocate(character(len=size) :: v, STAT=err)  
  if (err /= 0) then
    call abort_run('Allocation of v in allocateArray1D_char failed ') 
  end if
else
  call abort_run('Attempt to allocate allocated array ') 
end if
#endif