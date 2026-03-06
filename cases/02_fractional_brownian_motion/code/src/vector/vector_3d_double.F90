module vector_3d_double
use vector_1d_double
use vector_2d_double

#define VEC_TYPE_FORT real(double_p)
#define VEC_TYPE_CPP real(c_double)
#define VEC_TYPE_STRING "double"
#define VEC_RANK1_DATA_TYPE vector_1d_double_type
#define VEC_RANK2_DATA_TYPE vector_2d_double_type
#define VEC_DATA_TYPE vector_3d_double_type

#include "vector_3d_template.F90"

#undef VEC_TYPE_FORT
#undef VEC_TYPE_CPP
#undef VEC_TYPE_STRING
#undef VEC_RANK1_DATA_TYPE
#undef VEC_RANK2_DATA_TYPE
#undef VEC_DATA_TYPE
end module vector_3d_double

