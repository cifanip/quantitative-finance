#if vec_dim==1
  n = dims(1)
    
  if (n==0) then
    return
  end if

  if (.not.allocated(x)) then
    call allocate_array(x,1,n)
  else if (size(x).ne.n) then
    call reallocate_array(x,1,n)
  end if
    
  call h5dread_f(dset_id,data_type,x,dims,err)
    
  if (err.lt.0) then
    call mpi_abort_run("hdf_dread_1d failed")
  end if
#endif

#if vec_dim==2
  n1 = dims(1)
  n2 = dims(2)
    
  if (n1*n2==0) then
    return
  end if

  if (.not.allocated(x)) then
    call allocate_array(x,1,n1,1,n2)
  else if ((size(x,1).ne.n1).or.(size(x,2).ne.n2)) then
    call reallocate_array(x,1,n1,1,n2)
  end if
    
  call h5dread_f(dset_id,data_type,x,dims,err)
    
  if (err.lt.0) then
    call mpi_abort_run("hdf_dread_2d failed")
  end if
#endif

#if vec_dim==3
  n1 = dims(1)
  n2 = dims(2)
  n3 = dims(3)
    
  if (n1*n2*n3==0) then
    return
  end if

  if (.not.allocated(x)) then
    call allocate_array(x,1,n1,1,n2,1,n3)
  else if ((size(x,1).ne.n1).or.&
           (size(x,2).ne.n2).or.&
           (size(x,3).ne.n3)) then
    call reallocate_array(x,1,n1,1,n2,1,n3)
  end if
    
  call h5dread_f(dset_id,data_type,x,dims,err)
    
  if (err.lt.0) then
    call mpi_abort_run("hdf_dread_3d failed")
  end if
#endif