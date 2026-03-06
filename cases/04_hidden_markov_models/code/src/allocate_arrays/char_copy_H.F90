#if vec_dim==1
size=len(v2)
call deallocate_array(v1)
call allocate_array(v1,size)
v1=v2
#endif