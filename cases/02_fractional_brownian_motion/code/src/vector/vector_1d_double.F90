module vector_1d_double
#define VEC_TYPE_FORT real(double_p)
#define VEC_TYPE_CPP real(c_double)
#define VEC_TYPE_STRING "double"
#define VEC_DATA_TYPE vector_1d_double_type

#include "vector_1d_template.F90"

#undef VEC_TYPE_FORT
#undef VEC_TYPE_CPP
#undef VEC_TYPE_STRING
#undef VEC_DATA_TYPE
end module vector_1d_double

