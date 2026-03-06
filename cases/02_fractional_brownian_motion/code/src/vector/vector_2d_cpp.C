#include <iostream>
#include <string>
#include <complex>
#include <vector>
#include <type_traits>
#include <mpi.h>
#include "vector_1d_cpp.H"
#include "vector_2d_cpp.H"

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_2d_cpp<Type>::vector_2d_cpp()
:
  x()
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_2d_cpp<Type>::vector_2d_cpp
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
vector_2d_cpp<Type>::vector_2d_cpp
(
const vector_2d_cpp<Type> &rhs
)
:
  x(rhs.x)
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_2d_cpp<Type>::~vector_2d_cpp()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_2d_cpp<Type>& vector_2d_cpp<Type>::operator=(const vector_2d_cpp<Type> &rhs)
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
vector_2d_cpp<Type>& vector_2d_cpp<Type>::operator=(const Type& value)
{
  this->set_all(value);
  return *this;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_2d_cpp<Type>::get_size() const
{
  return this->x.size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_2d_cpp<Type>::get_size
(
const int irow
) const
{
  return this->x[irow].get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
bool vector_2d_cpp<Type>::is_empty() const
{
  return this->x.empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::resize(const int n)
{
  this->x.resize(n);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::append
(
const vector_1d_cpp<Type>& value
)
{
  this->x.push_back(value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::append
(
const vector_2d_cpp& value
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
void vector_2d_cpp<Type>::extend_row
(
const int irow,
const vector_1d_cpp<Type>& value
)
{
  this->x[irow].append(value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::insert
(
const int idx,
const vector_1d_cpp<Type>& value
)
{
  iterator it = this->x.begin();
  this->x.insert(it+idx,value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::pop_back()
{
  this->x.pop_back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::clear()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
vector_1d_cpp<Type>& vector_2d_cpp<Type>::back()
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
const vector_1d_cpp<Type>& vector_2d_cpp<Type>::back() const
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>& vector_2d_cpp<Type>::operator[](const int idx)
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
const vector_1d_cpp<Type>& vector_2d_cpp<Type>::operator[]
(
const int idx
) const
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
Type* vector_2d_cpp<Type>::get_data_ptr()
{
  return this->x[0].get_data_ptr();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::set_all
(
const Type& x
)
{  
  for (int i = 0; i < this->x.size(); i++)
  {
    for (int j = 0; j < this->x[i].get_size(); j++)
    {
      this->x[i][j]=x;
    }
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
void vector_2d_cpp<Type>::print() const
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

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::send
(
const vector_2d_cpp& x,
const int dest,
const int tag
)
{
  MPI_Datatype sendtype;
  
  if (std::is_same<Type,int>::value)
  {
    sendtype = MPI_INT;
  }
  
  if (std::is_same<Type,double>::value)
  {
    sendtype = MPI_DOUBLE;
  }
  
  int size = x.get_size();
  MPI_Send(&size,1,MPI_INT,dest,tag,MPI_COMM_WORLD);
  if (size==0)
  {
    return;
  }
    
  int *sv = new int[size];
  int count = 0;
  for (int i=0; i<size; i++)
  {
    sv[i] = x[i].get_size();
    count+= sv[i];
  }
  MPI_Send(sv,size,MPI_INT,dest,tag,MPI_COMM_WORLD);
    
  Type *dv = new Type[count];
  int k = 0; 
  for (int i=0; i<size; i++)
  {
    for (int j=0; j<sv[i]; j++)
    {
      dv[k]=x[i][j];
      k++;
    }
  }
  MPI_Send(dv,count,sendtype,dest,tag,MPI_COMM_WORLD);
  
  delete[] sv;
  delete[] dv;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::send
(
const vector_2d_cpp& x,
const int dest
)
{
  send(x,dest,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::send
(
const int dest,
const int tag
) const
{
  send(*this,dest,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::send
(
const int dest
) const
{
  send(*this,dest,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::recv
(
vector_2d_cpp& x,
const int source,
const int tag
)
{
  MPI_Datatype recvtype;
  
  if (std::is_same<Type,int>::value)
  {
    recvtype = MPI_INT;
  }
  
  if (std::is_same<Type,double>::value)
  {
    recvtype = MPI_DOUBLE;
  }
  
  MPI_Status status;
  
  int size;
  MPI_Recv(&size,1,MPI_INT,source,tag,MPI_COMM_WORLD,&status);
  if (size==0)
  {
    x = vector_2d_cpp();
    return;
  }
  if (x.get_size() != size)
  {
    x.resize(size);
  }
    
  int *sv = new int[size];
  int count = 0;
  MPI_Recv(sv,size,MPI_INT,source,tag,MPI_COMM_WORLD,&status);
  for (int i=0; i<size; i++)
  {
    if (x[i].get_size() != sv[i])
    {
      x[i].resize(sv[i]);
    }
    count+= sv[i];
  }
  
  Type *dv = new Type[count];
  MPI_Recv(dv,count,recvtype,source,tag,MPI_COMM_WORLD,&status);
  int k = 0; 
  for (int i=0; i<size; i++)
  {
    for (int j=0; j<sv[i]; j++)
    {
      x[i][j]=dv[k];
      k++;
    }
  }
  
  delete[] sv;
  delete[] dv;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::recv
(
vector_2d_cpp& x,
const int source
)
{
  recv(x,source,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::recv
(
const int source,
const int tag
)
{
  recv(*this,source,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::recv
(
const int source
)
{
  recv(*this,source,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::bcast
(
vector_2d_cpp& x,
const int root
)
{
  vector_1d_cpp<int> size;
  
  vector_1d_cpp<Type> val;
  
  for (int i=0; i<x.get_size(); i++)
  {
    size.append(x[i].get_size());
    
    for (int j=0; j<x[i].get_size(); j++)
    {
      val.append(x[i][j]);
    }
  }
  
  size.bcast(root);
  
  val.bcast(root);
  
  int k = 0;
  
  x.resize(size.get_size());

  for (int i=0; i<size.get_size(); i++)
  {
    x[i].resize(size[i]);

    for (int j=0; j<size[i]; j++)
    {
      x[i][j]=val[k];
      k++;
    }
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::bcast
(
vector_2d_cpp& x
)
{
  bcast(x,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::bcast
(
const int root
)
{
  bcast(*this,root);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_2d_cpp<Type>::bcast()
{
  this->bcast(0);
}
// ------------------------------------------------------------------------------------ //

// explicit instantiations
template class vector_2d_cpp<int>;

template class vector_2d_cpp<double>;

template class vector_2d_cpp<std::complex<double>>;

// --- Fortran vectors

// ------------------------------------------------------------------------------------ //
// --- double
vector_2d_ptr_double v2d_double_init()
{
  vector_2d_ptr_double vptr = new vector_2d_cpp<double>();  
  return vptr;
}
// --- integer
vector_2d_ptr_int v2d_int_init()
{
  vector_2d_ptr_int vptr = new vector_2d_cpp<int>();
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_2d_ptr_double v2d_double_init_size(int size)
{
  vector_2d_ptr_double vptr = new vector_2d_cpp<double>(size);
  return vptr;
}
// --- integer
vector_2d_ptr_int v2d_int_init_size(int size)
{
  vector_2d_ptr_int vptr = new vector_2d_cpp<int>(size);
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_delete(vector_2d_ptr_double& vptr)
{
  delete vptr;
}
// --- integer
void v2d_int_delete(vector_2d_ptr_int& vptr)
{
  delete vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_deep_copy
(
vector_2d_ptr_double& lhs,
const vector_2d_ptr_double& rhs
)
{
  *lhs = *rhs;
}
// --- integer
void v2d_int_deep_copy
(
vector_2d_ptr_int& lhs,
const vector_2d_ptr_int& rhs
)
{
  *lhs = *rhs;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
bool v2d_double_is_empty(const vector_2d_ptr_double& vptr)
{
  return vptr->is_empty();
}
// --- int
bool v2d_int_is_empty(const vector_2d_ptr_int& vptr)
{
  return vptr->is_empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v2d_double_get_size(const vector_2d_ptr_double& vptr)
{
  return vptr->get_size();
}
// --- int
int v2d_int_get_size(const vector_2d_ptr_int& vptr)
{
  return vptr->get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v2d_double_get_row_size(const vector_2d_ptr_double& vptr,const int irow)
{
  return vptr->get_size(irow);
}
// --- int
int v2d_int_get_row_size(const vector_2d_ptr_int& vptr,const int irow)
{
  return vptr->get_size(irow);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_append(vector_2d_ptr_double& vptr,const vector_1d_ptr_double& vec)
{
  vptr->append(*vec);
}
// --- int
void v2d_int_append(vector_2d_ptr_int& vptr,const vector_1d_ptr_int& vec)
{
  vptr->append(*vec);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_extend_row
(
vector_2d_ptr_double& vptr,
const int irow,
const vector_1d_ptr_double& vec
)
{
  vptr->extend_row(irow,*vec);
}
// --- int
void v2d_int_extend_row
(
vector_2d_ptr_int& vptr,
const int irow,
const vector_1d_ptr_int& vec
)
{
  vptr->extend_row(irow,*vec);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
double v2d_double_get_data(const vector_2d_ptr_double& vptr,int i,int j)
{
  return (*vptr)[i][j];
}
// --- int
int v2d_int_get_data(const vector_2d_ptr_int& vptr,int i,int j)
{
  return (*vptr)[i][j];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_set_data(vector_2d_ptr_double& vptr,int i,int j,double val)
{
  (*vptr)[i][j]=val;
}
// --- int
void v2d_int_set_data(vector_2d_ptr_int& vptr,int i,int j,int val)
{
  (*vptr)[i][j]=val;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_1d_ptr_double v2d_double_get_row
(
const vector_2d_ptr_double& vptr,
const int irow
)
{
  return &vptr->operator[](irow);
}
// --- int
vector_1d_ptr_int v2d_int_get_row
(
const vector_2d_ptr_int& vptr,
const int irow
)
{
  return &vptr->operator[](irow);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_set_row
(
vector_2d_ptr_double& vptr,
const int irow,
const vector_1d_ptr_double& vec
)
{
  vptr->operator[](irow) = *vec;
}
// --- int
void v2d_int_set_row
(
vector_2d_ptr_int& vptr,
const int irow,
const vector_1d_ptr_int& vec
)
{
  vptr->operator[](irow) = *vec;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_1d_ptr_double v2d_double_get_tail(const vector_2d_ptr_double& vptr)
{
  return &vptr->back();
}
// --- int
vector_1d_ptr_int v2d_int_get_tail(const vector_2d_ptr_int& vptr)
{
  return &vptr->back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_set_tail(vector_2d_ptr_double& vptr,const vector_1d_ptr_double& vec)
{
  vptr->back() = *vec;
}
// --- int
void v2d_int_set_tail(vector_2d_ptr_int& vptr,const vector_1d_ptr_int& vec)
{
  vptr->back() = *vec;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_print(const vector_2d_ptr_double& vptr)
{
  vptr->print();
}
// --- int
void v2d_int_print(const vector_2d_ptr_int& vptr)
{
  vptr->print();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_insert
(
vector_2d_ptr_double& vptr,
const int idx,
const vector_1d_ptr_double& vec
)
{
  vptr->insert(idx,*vec);
}
// --- int
void v2d_int_insert
(
vector_2d_ptr_int& vptr,
const int idx,
const vector_1d_ptr_int& vec
)
{
  vptr->insert(idx,*vec);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_pop_back
(
vector_2d_ptr_double& vptr
)
{
  vptr->pop_back();
}
// --- int
void v2d_int_pop_back
(
vector_2d_ptr_int& vptr
)
{
  vptr->pop_back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_send_with_tag
(
const vector_2d_ptr_double& vptr,
const int dest,
const int tag
)
{
  vptr->send(dest,tag);
}

// --- int
void v2d_int_send_with_tag
(
const vector_2d_ptr_int& vptr,
const int dest,
const int tag
)
{
  vptr->send(dest,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_send
(
const vector_2d_ptr_double& vptr,
const int dest
)
{
  vptr->send(dest);
}

// --- int
void v2d_int_send
(
const vector_2d_ptr_int& vptr,
const int dest
)
{
  vptr->send(dest);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_recv_with_tag
(
vector_2d_ptr_double& vptr,
const int source,
const int tag
)
{
  vptr->recv(source,tag);
}

// --- int
void v2d_int_recv_with_tag
(
vector_2d_ptr_int& vptr,
const int source,
const int tag
)
{
  vptr->recv(source,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_recv
(
vector_2d_ptr_double& vptr,
const int source
)
{
  vptr->recv(source);
}

// --- int
void v2d_int_recv
(
vector_2d_ptr_int& vptr,
const int source
)
{
  vptr->recv(source);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_bcast_with_root
(
vector_2d_ptr_double& vptr,
const int root
)
{
  vptr->bcast(root);
}

// --- int
void v2d_int_bcast_with_root
(
vector_2d_ptr_int& vptr,
const int root
)
{
  vptr->bcast(root);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v2d_double_bcast
(
vector_2d_ptr_double& vptr
)
{
  vptr->bcast();
}

// --- int
void v2d_int_bcast
(
vector_2d_ptr_int& vptr
)
{
  vptr->bcast();
}
// ------------------------------------------------------------------------------------ //