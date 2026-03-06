if ((size(x,1)==0).or.(size(x,2)==0)) then
  call mpi_abort_run("size(x) = 0 at array_reverse_row")
end if

n = size(x,2)
ih = floor(0.5d0*real(1+n))

call allocate_array(tmp,1,size(x,1))

do i=1,ih
  tmp = x(:,i)
  x(:,i) = x(:,n-i+1)
  x(:,n-i+1) = tmp
end do