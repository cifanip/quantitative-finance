call hdf_screate_simple(rank,dims,space_id)
    
call hdf_acreate(loc_id,a_name,data_type,space_id,a_id)
    
call hdf_awrite(a_id,x)
    
call hdf_aclose(a_id)
    
call hdf_sclose(space_id)