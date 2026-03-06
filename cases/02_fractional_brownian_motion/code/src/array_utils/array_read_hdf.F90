if (present(array_name_opt)) then
  call allocate_array(array_name,len(array_name_opt))
  array_name = array_name_opt
else
  call allocate_array(array_name,1)
  array_name = "x"      
end if

call hdf_open()
    
call hdf_fopen_rdonly(path_to_file,file_id)
    
call hdf_dopen(file_id,array_name,dset_id)
    
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
    
call hdf_fclose(file_id)

call hdf_close()