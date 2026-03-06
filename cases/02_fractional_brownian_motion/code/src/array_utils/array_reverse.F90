#if vec_dim==1

n = size(x)

if (n==0) then
  call mpi_abort_run("size(x) = 0 at array_reverse")
end if

ih = floor(0.5d0*real(1+n))

do i=1,ih
  tmp = x(i)
  x(i) = x(n-i+1)
  x(n-i+1) = tmp
end do

#endif