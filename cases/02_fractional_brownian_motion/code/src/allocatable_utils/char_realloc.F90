#if vec_dim==1
if (allocated(v)) then
  call deallocate_array(v)
  call allocate_array(v,size)   
else
  call allocate_array(v,size)
end if
#endif