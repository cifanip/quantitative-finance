#if vec_dim==1
  if (.not.allocated(x)) then
    call allocate_array(x,1,0)
  end if
    
  call allocate_array(tmp,1,size(x)+1)
  tmp(1:size(x))=x
  tmp(size(tmp))=y
  call move_alloc(tmp,x)
#endif