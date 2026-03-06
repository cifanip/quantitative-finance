module vector_3d_int
use vector_1d_int
use vector_2d_int

#define VEC_TYPE_FORT integer
#define VEC_TYPE_CPP integer(c_int)
#define VEC_TYPE_STRING "int"
#define VEC_RANK1_DATA_TYPE vector_1d_int_type
#define VEC_RANK2_DATA_TYPE vector_2d_int_type
#define VEC_DATA_TYPE vector_3d_int_type

#include "vector_3d_template.F90"

#undef VEC_TYPE_FORT
#undef VEC_TYPE_CPP
#undef VEC_TYPE_STRING
#undef VEC_RANK1_DATA_TYPE
#undef VEC_RANK2_DATA_TYPE
#undef VEC_DATA_TYPE
end module vector_3d_int

