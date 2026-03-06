#if vec_dim==1
  if (size(x)==0) then
    return
  end if
  
  open(unit=s_io_unit,&
       file=adjustl(trim(path_to_file)),&
       status='replace',&
       action='write',&
       iostat=reason)
  
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_write_file")
  end if
  
  do i=1,size(x)
    write(s_io_unit,write_format,iostat=reason) x(i)
    if (reason>0) then
      call mpi_abort_run("reason>0 at array_write_file")
    end if
  end do
  
  close(unit=s_io_unit)
#endif