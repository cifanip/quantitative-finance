module vector_1d_int
#define VEC_TYPE_FORT integer
#define VEC_TYPE_CPP integer(c_int)
#define VEC_TYPE_STRING "int"
#define VEC_DATA_TYPE vector_1d_int_type

#include "vector_1d_template.F90"

#undef VEC_TYPE_FORT
#undef VEC_TYPE_CPP
#undef VEC_TYPE_STRING
#undef VEC_DATA_TYPE
end module vector_1d_int

