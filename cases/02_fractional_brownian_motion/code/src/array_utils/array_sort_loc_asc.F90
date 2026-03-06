if (size(x)==0) then
  call mpi_abort_run("size(x) = 0 at array_sort_loc_asc")
end if

n = size(x)

if (.not.allocated(loc)) then
  call allocate_array(loc,1,n)
else if ((lbound(loc,1).ne.1).or.(ubound(loc,1).ne.n)) then
  call reallocate_array(loc,1,n)
end if

call allocate_array(tmp,1,n)
call allocate_array(msk,1,n)
msk=.true.

do i=1,n
  tmp(i)=minval(x,1,msk)
  loc(i)=minloc(x,1,msk)
  msk(loc(i))=.false.
end do

x=tmp