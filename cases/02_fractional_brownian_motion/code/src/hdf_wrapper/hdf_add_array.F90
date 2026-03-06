if (size(x)<=0) then
  call mpi_abort_run("attempt to write empty array at hdf_add_array")
end if

#if vec_dim==1
rank=1
dims(1)=size(x,1)
#endif

#if vec_dim==2
rank=2
dims(1)=size(x,1)
dims(2)=size(x,2)
#endif

#if vec_dim==3
rank=3
dims(1)=size(x,1)
dims(2)=size(x,2)
dims(3)=size(x,3)
#endif

call hdf_screate_simple(rank,dims,dspace_id)

call hdf_dcreate(loc_id,array_name,data_type,dspace_id,dset_id)
    
call hdf_dwrite(dset_id,x)
    
call hdf_dclose(dset_id)

call hdf_sclose(dspace_id)