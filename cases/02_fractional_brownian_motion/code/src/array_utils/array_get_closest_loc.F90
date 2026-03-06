#if vec_dim==1
  if (present(lb)) then
    i0=lb
  else
    i0=1
  end if

  if (size(x)==0) then
    call mpi_abort_run("x of size zero at array_get_closest_loc")
  end if

  idx = minloc(abs(x-val),1)+i0-1
#endif