if (size(x)<=0) then
  call mpi_abort_run("attempt to write empty array at arra_write_hdf")
end if

if (present(array_name_opt)) then
  call allocate_array(array_name,len(array_name_opt))
  array_name = array_name_opt
else
  call allocate_array(array_name,1)
  array_name = "x"      
end if
    
call hdf_fcreate(path_to_file,file_id)

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

call hdf_dcreate(file_id,array_name,data_type,dspace_id,dset_id)

call hdf_dwrite(dset_id,x)

call hdf_dclose(dset_id)

call hdf_sclose(dspace_id)

call hdf_fclose(file_id)