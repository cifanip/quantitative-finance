#if vec_dim==1
st=lbound(v2,1)
en=ubound(v2,1)
if (.not.allocated(v1)) then
  call allocate_array(v1,st,en)
else if ((lbound(v1,1).ne.st).or.(ubound(v1,1).ne.en)) then
  call reallocate_array(v1,st,en)
end if
v1=v2
#endif

#if vec_dim==2
st1=lbound(v2,1)
en1=ubound(v2,1)
st2=lbound(v2,2)
en2=ubound(v2,2)
if (.not.allocated(v1)) then
  call allocate_array(v1,st1,en1,st2,en2)
else if ((lbound(v1,1).ne.st1).or.&
         (ubound(v1,1).ne.en1).or.&
         (lbound(v1,2).ne.st2).or.&
         (ubound(v1,2).ne.en2)) then
      call reallocate_array(v1,st1,en1,st2,en2)
end if
v1=v2
#endif

#if vec_dim==3
st1=lbound(v2,1)
en1=ubound(v2,1)
st2=lbound(v2,2)
en2=ubound(v2,2)
st3=lbound(v2,3)
en3=ubound(v2,3)
if (.not.allocated(v1)) then
  call allocate_array(v1,st1,en1,st2,en2,st3,en3)
else if ((lbound(v1,1).ne.st1).or.&
         (ubound(v1,1).ne.en1).or.&
         (lbound(v1,2).ne.st2).or.&
         (ubound(v1,2).ne.en2).or.&
         (lbound(v1,3).ne.st3).or.&
         (ubound(v1,3).ne.en3)) then
      call reallocate_array(v1,st1,en1,st2,en2,st3,en3)
end if
v1=v2
#endif

#if vec_dim==4
st1=lbound(v2,1)
en1=ubound(v2,1)
st2=lbound(v2,2)
en2=ubound(v2,2)
st3=lbound(v2,3)
en3=ubound(v2,3)
st4=lbound(v2,4)
en4=ubound(v2,4)
if (.not.allocated(v1)) then
  call allocate_array(v1,st1,en1,st2,en2,st3,en3,st4,en4)
else if ((lbound(v1,1).ne.st1).or.&
         (ubound(v1,1).ne.en1).or.&
         (lbound(v1,2).ne.st2).or.&
         (ubound(v1,2).ne.en2).or.&
         (lbound(v1,3).ne.st3).or.&
         (ubound(v1,3).ne.en3).or.&
         (lbound(v1,4).ne.st4).or.&
         (ubound(v1,4).ne.en4)) then
      call reallocate_array(v1,st1,en1,st2,en2,st3,en3,st4,en4)
end if
v1=v2
#endif