#include <iostream>
#include <string>
#include <complex>
#include <vector>
#include <type_traits>
#include "vector_1d_cpp.H"
#include "vector_2d_cpp.H"
#include "vector_3d_cpp.H"

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>::vector_3d_cpp()
:
  x()
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>::vector_3d_cpp
(
int size
)
:
  x(size)
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>::vector_3d_cpp
(
const vector_3d_cpp<Type> &rhs
)
:
  x(rhs.x)
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>::~vector_3d_cpp()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>& vector_3d_cpp<Type>::operator=(const vector_3d_cpp<Type> &rhs)
{

  if (this==&rhs)
  {
    return *this;
  }

  this->x = rhs.x;
  
  return *this;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_3d_cpp<Type>& vector_3d_cpp<Type>::operator=(const Type& value)
{
  this->set_all(value);
  return *this;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_3d_cpp<Type>::get_size() const
{
  return this->x.size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_3d_cpp<Type>::get_size
(
const int irow
) const
{
  return this->x[irow].get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_3d_cpp<Type>::get_size
(
const int i,
const int j
) const
{
  return this->x[i][j].get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
bool vector_3d_cpp<Type>::is_empty() const
{
  return this->x.empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::resize(const int n)
{
  this->x.resize(n);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::append
(
const vector_2d_cpp<Type>& value
)
{
  this->x.push_back(value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::append
(
const vector_3d_cpp& value
)
{
  for (int i=0; i < value.get_size(); i++)
  {
    this->x.push_back(value[i]);
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::insert
(
const int idx,
const vector_2d_cpp<Type>& value
)
{
  iterator it = this->x.begin();
  this->x.insert(it+idx,value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::pop_back()
{
  this->x.pop_back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::clear()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
vector_2d_cpp<Type>& vector_3d_cpp<Type>::back()
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
const vector_2d_cpp<Type>& vector_3d_cpp<Type>::back() const
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_2d_cpp<Type>& vector_3d_cpp<Type>::operator[](const int idx)
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
const vector_2d_cpp<Type>& vector_3d_cpp<Type>::operator[]
(
const int idx
) const
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
Type* vector_3d_cpp<Type>::get_data_ptr()
{
  return this->x[0].get_data_ptr();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_3d_cpp<Type>::set_all
(
const Type& x
)
{  
  for (int i = 0; i < this->x.size(); i++)
  {
    for (int j = 0; j < this->x[i].get_size(); j++)
    {
      for (int k = 0; k < this->x[i][j].get_size(); k++)
      {
        this->x[i][j][k]=x;
      }  
    }
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
void vector_3d_cpp<Type>::print() const
{
  if (this->x.empty())
  {
    std::cout << " Vector list is empty " << std::endl;
    return;
  }
  
  std::cout << "[";
  for (int i=0; i < this->x.size(); i++)
  {
    this->x[i].print();
  }
  std::cout << "]";
}
// ------------------------------------------------------------------------------------ //

// explicit instantiations
template class vector_3d_cpp<int>;

template class vector_3d_cpp<double>;

template class vector_3d_cpp<std::complex<double>>;

// --- Fortran vectors

// ------------------------------------------------------------------------------------ //
// --- double
vector_3d_ptr_double v3d_double_init()
{
  vector_3d_ptr_double vptr = new vector_3d_cpp<double>();  
  return vptr;
}
// --- integer
vector_3d_ptr_int v3d_int_init()
{
  vector_3d_ptr_int vptr = new vector_3d_cpp<int>();
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_3d_ptr_double v3d_double_init_size(int size)
{
  vector_3d_ptr_double vptr = new vector_3d_cpp<double>(size);
  return vptr;
}
// --- integer
vector_3d_ptr_int v3d_int_init_size(int size)
{
  vector_3d_ptr_int vptr = new vector_3d_cpp<int>(size);
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_delete(vector_3d_ptr_double& vptr)
{
  delete vptr;
}
// --- integer
void v3d_int_delete(vector_3d_ptr_int& vptr)
{
  delete vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_deep_copy
(
vector_3d_ptr_double& lhs,
const vector_3d_ptr_double& rhs
)
{
  *lhs = *rhs;
}
// --- integer
void v3d_int_deep_copy
(
vector_3d_ptr_int& lhs,
const vector_3d_ptr_int& rhs
)
{
  *lhs = *rhs;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
bool v3d_double_is_empty(const vector_3d_ptr_double& vptr)
{
  return vptr->is_empty();
}
// --- int
bool v3d_int_is_empty(const vector_3d_ptr_int& vptr)
{
  return vptr->is_empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v3d_double_get_list_size(const vector_3d_ptr_double& vptr)
{
  return vptr->get_size();
}
// --- int
int v3d_int_get_list_size(const vector_3d_ptr_int& vptr)
{
  return vptr->get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v3d_double_get_sub_list_size(const vector_3d_ptr_double& vptr,const int i)
{
  return vptr->get_size(i);
}
// --- int
int v3d_int_get_sub_list_size(const vector_3d_ptr_int& vptr,const int i)
{
  return vptr->get_size(i);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v3d_double_get_sub_sub_list_size
(
const vector_3d_ptr_double& vptr,
const int i,
const int j
)
{
  return vptr->get_size(i,j);
}
// --- int
int v3d_int_get_sub_sub_list_size
(
const vector_3d_ptr_int& vptr,
const int i,
const int j
)
{
  return vptr->get_size(i,j);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_append(vector_3d_ptr_double& vptr,const vector_2d_ptr_double& vec)
{
  vptr->append(*vec);
}
// --- int
void v3d_int_append(vector_3d_ptr_int& vptr,const vector_2d_ptr_int& vec)
{
  vptr->append(*vec);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
double v3d_double_get_data(const vector_3d_ptr_double& vptr,int i,int j,int k)
{
  return (*vptr)[i][j][k];
}
// --- int
int v3d_int_get_data(const vector_3d_ptr_int& vptr,int i,int j,int k)
{
  return (*vptr)[i][j][k];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_set_data(vector_3d_ptr_double& vptr,int i,int j,int k,double val)
{
  (*vptr)[i][j][k]=val;
}
// --- int
void v3d_int_set_data(vector_3d_ptr_int& vptr,int i,int j,int k,int val)
{
  (*vptr)[i][j][k]=val;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_2d_ptr_double v3d_double_get_row
(
const vector_3d_ptr_double& vptr,
const int irow
)
{
  return &vptr->operator[](irow);
}
// --- int
vector_2d_ptr_int v3d_int_get_row
(
const vector_3d_ptr_int& vptr,
const int irow
)
{
  return &vptr->operator[](irow);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_set_row
(
vector_3d_ptr_double& vptr,
const int irow,
const vector_2d_ptr_double& vec
)
{
  vptr->operator[](irow) = *vec;
}
// --- int
void v3d_int_set_row
(
vector_3d_ptr_int& vptr,
const int irow,
const vector_2d_ptr_int& vec
)
{
  vptr->operator[](irow) = *vec;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_2d_ptr_double v3d_double_get_tail(const vector_3d_ptr_double& vptr)
{
  return &vptr->back();
}
// --- int
vector_2d_ptr_int v3d_int_get_tail(const vector_3d_ptr_int& vptr)
{
  return &vptr->back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_set_tail(vector_3d_ptr_double& vptr,const vector_2d_ptr_double& vec)
{
  vptr->back() = *vec;
}
// --- int
void v3d_int_set_tail(vector_3d_ptr_int& vptr,const vector_2d_ptr_int& vec)
{
  vptr->back() = *vec;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_print(const vector_3d_ptr_double& vptr)
{
  vptr->print();
}
// --- int
void v3d_int_print(const vector_3d_ptr_int& vptr)
{
  vptr->print();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_insert
(
vector_3d_ptr_double& vptr,
const int idx,
const vector_2d_ptr_double& vec
)
{
  vptr->insert(idx,*vec);
}
// --- int
void v3d_int_insert
(
vector_3d_ptr_int& vptr,
const int idx,
const vector_2d_ptr_int& vec
)
{
  vptr->insert(idx,*vec);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v3d_double_pop_back
(
vector_3d_ptr_double& vptr
)
{
  vptr->pop_back();
}
// --- int
void v3d_int_pop_back
(
vector_3d_ptr_int& vptr
)
{
  vptr->pop_back();
}
// ------------------------------------------------------------------------------------ //