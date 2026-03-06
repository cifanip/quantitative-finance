#if vec_dim==1
if (size(x)==0) then
  call mpi_abort_run("size(x) = 0 at array_sort_loc")
end if

n = size(x)

if (size(loc).ne.n) then
  call mpi_abort_run("size(loc) not equal to size(x) at array_sort_loc")
end if

call allocate_array(tmp,1,n)

do i=1,n
  tmp(i)=x(loc(i))
end do

x=tmp
#endif

#if vec_dim==2
if (size(x)==0) then
  call mpi_abort_run("size(x) = 0 at array_sort_loc")
end if

n1 = size(x,1)
n2 = size(x,2)

if (size(loc,1).ne.n1) then
  if (size(loc,1).ne.n2) then
    call mpi_abort_run("size(loc) not equal to size(x) at array_sort_loc")
  end if
end if

call allocate_array(tmp,1,n1,1,n2)

if (size(loc,1).eq.n1) then
  do i=1,n1
    tmp(i,:)=x(loc(i),:)
  end do
end if

if (size(loc,1).eq.n2) then
  do i=1,n2
    tmp(:,i)=x(:,loc(i))
  end do
end if

x=tmp
#endif