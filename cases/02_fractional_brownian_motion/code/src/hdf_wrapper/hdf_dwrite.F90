#if vec_dim==1
  if (size(x)==0) then
    return
  end if
  
  dims(1) = size(x)

  call h5dwrite_f(dset_id,data_type,x,dims,err)

  if (err.lt.0) then
    call mpi_abort_run("hdf_write_1d failed")
  end if
#endif

#if vec_dim==2
  if (size(x)==0) then
    return
  end if
    
  dims(1) = size(x,1)
  dims(2) = size(x,2)

  call h5dwrite_f(dset_id,data_type,x,dims,err)

  if (err.lt.0) then
    call mpi_abort_run("hdf_write_2d failed")
  end if
#endif

#if vec_dim==3
  if (size(x)==0) then
    return
  end if
    
  dims(1) = size(x,1)
  dims(2) = size(x,2)
  dims(3) = size(x,3)

  call h5dwrite_f(dset_id,data_type,x,dims,err)

  if (err.lt.0) then
    call mpi_abort_run("hdf_write_3d failed")
  end if
#endif