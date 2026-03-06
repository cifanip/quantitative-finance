#if vec_dim==1
  open(unit=s_io_unit,&
       file=trim(adjustl(path_to_file)),&
       status='old',&
       action='read',&
       iostat=reason)
  
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_read_file")
  end if
  
  count = 0
  do
    read(s_io_unit,read_format,iostat=reason) val
    if (reason>0) then
      call mpi_abort_run("reason>0 at array_read_file")
    else if (reason<0) then
      exit
    else
      count = count + 1
    end if
  end do
  
  rewind(unit=s_io_unit,iostat=reason)
  if (reason>0) then
    call mpi_abort_run("reason>0 at array_read_file")
  end if
  
  if (.not.allocated(x)) then
    call allocate_array(x,1,count)
  else if (size(x).ne.count) then
    call reallocate_array(x,1,count)
  end if

  do i=1,count
    read(s_io_unit,s_double_format) val
    x(i)=val
  end do
  
  close(unit=s_io_unit)
#endif