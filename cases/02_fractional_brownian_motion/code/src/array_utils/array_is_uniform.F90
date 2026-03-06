#if vec_dim==1
  
  if (size(x)==0) then
    call mpi_abort_run("x has zise zero at array_is_uniform")
  end if

  if (size(x)==1) then
    r = .true.
    return
  end if
  
  do i=2,size(x)
    if (x(i).ne.x(i-1)) then
      r = .false.
      return
    end if
  end do
  
  r = .true.
  
#endif