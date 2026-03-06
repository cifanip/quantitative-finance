if (size(x)==0) then
  call mpi_abort_run("size(x) = 0 at array_sort_desc")
end if

n = size(x)

call allocate_array(tmp,1,n)
call allocate_array(msk,1,n)
msk=.true.

do i=1,n
  tmp(i)=maxval(x,msk)
  msk(maxloc(x,msk))=.false.
end do

x=tmp