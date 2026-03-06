#if vec_dim==1
  if (size(x)==0) then
    count = 0
    return
  end if
  
  count = 0

  do i=1,size(x)
    if (x(i)==val) then
      count = count + 1
    end if
  end do
#endif