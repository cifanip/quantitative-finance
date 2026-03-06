#include <iostream>
#include <string>
#include <complex>
#include <vector>
#include <mpi.h>
#include "vector_1d_cpp.H"

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>::vector_1d_cpp()
:
  x()
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>::vector_1d_cpp
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
vector_1d_cpp<Type>::vector_1d_cpp
(
int size,
Type value
)
:
  x(size,value)
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>::vector_1d_cpp
(
const vector_1d_cpp<Type> &rhs
)
:
  x(rhs.x)
{
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>::~vector_1d_cpp()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
vector_1d_cpp<Type>& vector_1d_cpp<Type>::operator=(const vector_1d_cpp<Type> &rhs)
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
vector_1d_cpp<Type>& vector_1d_cpp<Type>::operator=(const Type& value)
{
  this->set_all(value);
  return *this;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::resize(const int n)
{
  this->x.resize(n);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
int vector_1d_cpp<Type>::get_size() const
{
  return this->x.size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
bool vector_1d_cpp<Type>::is_empty() const
{
  return this->x.empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::append(const Type& value)
{
  this->x.push_back(value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::append(const vector_1d_cpp& value)
{
  for (int i=0; i < value.get_size(); i++)
  {
    this->x.push_back(value[i]);
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::insert
(
const int idx,
const Type& value
)
{
  iterator it = this->x.begin();
  this->x.insert(it+idx,value);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::pop_back()
{
  this->x.pop_back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::clear()
{
  this->x.clear();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
Type& vector_1d_cpp<Type>::back()
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
const Type& vector_1d_cpp<Type>::back() const
{
  return this->x.back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
Type& vector_1d_cpp<Type>::operator[](const int idx)
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
const Type& vector_1d_cpp<Type>::operator[](const int idx) const
{
  return this->x[idx];
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
Type* vector_1d_cpp<Type>::get_data_ptr()
{
  return this->x.data();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::set_all
(
const Type& x
)
{  
  for (int i = 0; i < this->x.size(); i++)
  {
    this->x[i]=x;
  }
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type> 
void vector_1d_cpp<Type>::print() const
{
  if (this->x.empty())
  {
    std::cout << " Vector list is empty " << std::endl;
    return;
  }
  
  std::cout << "[";
  for (int i=0; i < this->x.size()-1; i++)
  {
    std::cout << this->x[i] << " ";
  }
  std::cout << this->x.back() << "]";
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::send
(
const vector_1d_cpp& x,
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
  
  int x_size = x.get_size();
  
  MPI_Send(&x_size,1,MPI_INT,dest,tag,MPI_COMM_WORLD);
  MPI_Send(x.x.data(),x.get_size(),sendtype,dest,tag,MPI_COMM_WORLD);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::send
(
const vector_1d_cpp& x,
const int dest
)
{
  send(x,dest,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::send
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
void vector_1d_cpp<Type>::send
(
const int dest
) const
{
  send(*this,dest,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::recv
(
vector_1d_cpp& x,
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
  
  int x_size;
  
  MPI_Recv(&x_size,1,MPI_INT,source,tag,MPI_COMM_WORLD,&status);
  
  if (x.get_size() != x_size)
  {
    x.resize(x_size);
  }
  
  MPI_Recv(x.x.data(),x_size,recvtype,source,tag,MPI_COMM_WORLD,&status);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::recv
(
vector_1d_cpp& x,
const int source
)
{
  recv(x,source,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::recv
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
void vector_1d_cpp<Type>::recv
(
const int source
)
{
  recv(*this,source,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::bcast
(
vector_1d_cpp& x,
const int root
)
{
  MPI_Datatype datatype;

  if (std::is_same<Type,int>::value)
  {
    datatype = MPI_INT;
  }
  
  if (std::is_same<Type,double>::value)
  {
    datatype = MPI_DOUBLE;
  }
  
  int n = x.get_size();
  
  MPI_Bcast(&n,1,MPI_INT,root,MPI_COMM_WORLD);
  
  int rank;
  
  MPI_Comm_rank(MPI_COMM_WORLD,&rank);
  
  if (rank != root)
  {
    if (x.get_size() != n)
    {
      x.resize(n);
    }
  }

  MPI_Bcast(x.x.data(),x.get_size(),datatype,root,MPI_COMM_WORLD);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::bcast
(
vector_1d_cpp& x
)
{
  bcast(x,0);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::bcast
(
const int root
)
{
  bcast(*this,root);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
template <typename Type>
void vector_1d_cpp<Type>::bcast()
{
  this->bcast(0);
}
// ------------------------------------------------------------------------------------ //

// explicit instantiations
template class vector_1d_cpp<int>;

template class vector_1d_cpp<double>;

template class vector_1d_cpp<std::complex<double>>;

// --- Fortran vectors

// ------------------------------------------------------------------------------------ //
// --- double
vector_1d_ptr_double v1d_double_init()
{
  vector_1d_ptr_double vptr = new vector_1d_cpp<double>();
  return vptr;
}
// --- integer
vector_1d_ptr_int v1d_int_init()
{
  vector_1d_ptr_int vptr = new vector_1d_cpp<int>();
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_1d_ptr_double v1d_double_init_size(int size)
{
  vector_1d_ptr_double vptr = new vector_1d_cpp<double>(size);
  return vptr;
}
// --- integer
vector_1d_ptr_int v1d_int_init_size(int size)
{
  vector_1d_ptr_int vptr = new vector_1d_cpp<int>(size);
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
vector_1d_ptr_double v1d_double_init_size_val(int size,double val)
{
  vector_1d_ptr_double vptr = new vector_1d_cpp<double>(size,val);
  return vptr;
}
// --- integer
vector_1d_ptr_int v1d_int_init_size_val(int size,int val)
{
  vector_1d_ptr_int vptr = new vector_1d_cpp<int>(size,val);
  return vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_delete(vector_1d_ptr_double& vptr)
{
  delete vptr;
}
// --- integer
void v1d_int_delete(vector_1d_ptr_int& vptr)
{
  delete vptr;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_deep_copy
(
vector_1d_ptr_double& lhs,
const vector_1d_ptr_double& rhs
)
{
  *lhs = *rhs;
}
// --- integer
void v1d_int_deep_copy
(
vector_1d_ptr_int& lhs,
const vector_1d_ptr_int& rhs
)
{
  *lhs = *rhs;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
bool v1d_double_is_empty(const vector_1d_ptr_double& vptr)
{
  return vptr->is_empty();
}
// --- int
bool v1d_int_is_empty(const vector_1d_ptr_int& vptr)
{
  return vptr->is_empty();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
int v1d_double_get_size(const vector_1d_ptr_double& vptr)
{
  return vptr->get_size();
}
// --- int
int v1d_int_get_size(const vector_1d_ptr_int& vptr)
{
  return vptr->get_size();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_append(vector_1d_ptr_double& vptr,double val)
{
  vptr->append(val);
}
// --- int
void v1d_int_append(vector_1d_ptr_int& vptr,int val)
{
  vptr->append(val);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
double v1d_double_get_data(const vector_1d_ptr_double& vptr,int idx)
{
  return vptr->operator[](idx);
}
// --- int
int v1d_int_get_data(const vector_1d_ptr_int& vptr,int idx)
{
  return vptr->operator[](idx);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_set_data(vector_1d_ptr_double& vptr,int idx,double val)
{
  vptr->operator[](idx)=val;
}
// --- int
void v1d_int_set_data(vector_1d_ptr_int& vptr,int idx,int val)
{
  vptr->operator[](idx)=val;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
double v1d_double_get_tail(const vector_1d_ptr_double& vptr)
{
  return vptr->back();
}
// --- int
int v1d_int_get_tail(const vector_1d_ptr_int& vptr)
{
  return vptr->back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_set_tail(vector_1d_ptr_double& vptr,double val)
{
  vptr->back()=val;
}
// --- int
void v1d_int_set_tail(vector_1d_ptr_int& vptr,int val)
{
  vptr->back()=val;
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_insert
(
vector_1d_ptr_double& vptr,
const int idx,
const double val
)
{
  vptr->insert(idx,val);
}
// --- int
void v1d_int_insert
(
vector_1d_ptr_int& vptr,
const int idx,
const int val
)
{
  vptr->insert(idx,val);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_pop_back
(
vector_1d_ptr_double& vptr
)
{
  vptr->pop_back();
}
// --- int
void v1d_int_pop_back
(
vector_1d_ptr_int& vptr
)
{
  vptr->pop_back();
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_send_with_tag
(
const vector_1d_ptr_double& vptr,
const int dest,
const int tag
)
{
  vptr->send(dest,tag);
}

// --- int
void v1d_int_send_with_tag
(
const vector_1d_ptr_int& vptr,
const int dest,
const int tag
)
{
  vptr->send(dest,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_send
(
const vector_1d_ptr_double& vptr,
const int dest
)
{
  vptr->send(dest);
}

// --- int
void v1d_int_send
(
const vector_1d_ptr_int& vptr,
const int dest
)
{
  vptr->send(dest);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_recv_with_tag
(
vector_1d_ptr_double& vptr,
const int source,
const int tag
)
{
  vptr->recv(source,tag);
}

// --- int
void v1d_int_recv_with_tag
(
vector_1d_ptr_int& vptr,
const int source,
const int tag
)
{
  vptr->recv(source,tag);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_recv
(
vector_1d_ptr_double& vptr,
const int source
)
{
  vptr->recv(source);
}

// --- int
void v1d_int_recv
(
vector_1d_ptr_int& vptr,
const int source
)
{
  vptr->recv(source);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_bcast_with_root
(
vector_1d_ptr_double& vptr,
const int root
)
{
  vptr->bcast(root);
}

// --- int
void v1d_int_bcast_with_root
(
vector_1d_ptr_int& vptr,
const int root
)
{
  vptr->bcast(root);
}
// ------------------------------------------------------------------------------------ //

// ------------------------------------------------------------------------------------ //
// --- double
void v1d_double_bcast
(
vector_1d_ptr_double& vptr
)
{
  vptr->bcast();
}

// --- int
void v1d_int_bcast
(
vector_1d_ptr_int& vptr
)
{
  vptr->bcast();
}
// ------------------------------------------------------------------------------------ //