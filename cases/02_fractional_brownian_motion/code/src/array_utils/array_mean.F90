#if vec_dim==1
  if (size(x)==0) then
    y = 0
    return
  end if
    
  y = sum(x)/dble(size(x))
#endif

#if vec_dim==2
  if (size(x)==0) then
    y = 0
    return
  end if
    
  y = sum(x)/dble(size(x))
#endif