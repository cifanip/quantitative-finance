#if vec_dim==1
  if (size(x)==0) then
    return
  end if
  
  open(unit=s_io_unit,&
       file=adjustl(trim(path_to_file)),&
       form="unformatted",&
       access="stream",&
       status="replace",&
       action="write",&
       iostat=reason)
  
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_write_binary_file")
  end if
  
  write(s_io_unit,iostat=reason) size(x)

  if (reason>0) then
    call mpi_abort_run("reason>0 at array_write_binary_file")
  end if
  
  write(s_io_unit,iostat=reason) x(:)
  
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_write_binary_file")
  end if
  
  close(unit=s_io_unit)
#endif