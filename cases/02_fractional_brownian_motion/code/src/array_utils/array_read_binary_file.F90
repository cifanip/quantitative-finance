#if vec_dim==1

  open(unit=s_io_unit,&
       file=trim(adjustl(path_to_file)),&
       form="unformatted",&
       access="stream",&
       status="old",&
       action="read",&
       iostat=reason)
       
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_read_binary_file")
  end if  
  
  read(s_io_unit,iostat=reason) n

  if (reason>0) then
    call mpi_abort_run("reason>0 at array_read_binary_file")
  end if 
  
  if (.not.allocated(x)) then
    call allocate_array(x,1,n)
  else if (size(x).ne.n) then
    call reallocate_array(x,1,n)
  end if
  
  read(s_io_unit,iostat=reason) x(:)
  
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_read_binary_file")
  end if   
  
  close(unit=s_io_unit)

#endif