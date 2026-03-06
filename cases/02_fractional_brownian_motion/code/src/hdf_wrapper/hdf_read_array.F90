call hdf_dopen(loc_id,array_name,dset_id)
    
call hdf_dget_space(dset_id,dspace_id)

#if vec_dim==1
call hdf_sget_simple_extent_dims_1d(dspace_id,dims,max_dims)
#endif

#if vec_dim==2
call hdf_sget_simple_extent_dims_2d(dspace_id,dims,max_dims)
#endif

#if vec_dim==3
call hdf_sget_simple_extent_dims_3d(dspace_id,dims,max_dims)
#endif
    
call hdf_dread(dset_id,x,dims)
    
call hdf_dclose(dset_id)