#ifndef vector_1d_cpp_H
#define vector_1d_cpp_H

#include <string>
#include <vector>

template <typename Type> 
class vector_1d_cpp
{
private:

protected:

  std::vector<Type> x;

  using iterator = typename std::vector<Type>::iterator;
  
  using const_iterator = typename std::vector<Type>::const_iterator;

public:

  vector_1d_cpp();
  
  vector_1d_cpp(int size);
  
  vector_1d_cpp(int size,Type value);

  vector_1d_cpp(const vector_1d_cpp& rhs);

  ~vector_1d_cpp();
  
  vector_1d_cpp& operator=(const vector_1d_cpp &rhs);
  
  vector_1d_cpp& operator=(const Type& value);
  
  int get_size() const;
  
  bool is_empty() const;
  
  void resize(const int n);
  
  void append(const Type& value);
  
  void append(const vector_1d_cpp& value);
  
  void insert(const int idx,
              const Type& value);
              
  void pop_back();
  
  void clear();

  Type& back();
  
  const Type& back() const;

  Type& operator[](const int idx);

  const Type& operator[](const int idx) const;
  
  Type* get_data_ptr();
  
  void set_all(const Type& x);
  
  void print() const;
  
  static void send(const vector_1d_cpp& x,
                   const int dest,
                   const int tag);
                   
  static void send(const vector_1d_cpp& x,
                   const int dest);
                   
  void send(const int dest,
            const int tag) const;

  void send(const int dest) const;

  static void recv(vector_1d_cpp& x,
                   const int source,
                   const int tag);

  static void recv(vector_1d_cpp& x,
                   const int source);
                   
  void recv(const int source,
            const int tag);
                   
  void recv(const int source);
  
  static void bcast(vector_1d_cpp& x,
                    const int root);
                    
  static void bcast(vector_1d_cpp& x);

  void bcast(const int root);

  void bcast();

};

  // Fortran vector

  // --- integer
  using vector_1d_ptr_int = vector_1d_cpp<int>*;
  extern "C"
  {
    vector_1d_ptr_int v1d_int_init();
    vector_1d_ptr_int v1d_int_init_size(int size);
    vector_1d_ptr_int v1d_int_init_size_val(int size,int val);
    void v1d_int_delete(vector_1d_ptr_int& vptr);
    void v1d_int_deep_copy(vector_1d_ptr_int& lhs,
                           const vector_1d_ptr_int& rhs);
    bool v1d_int_is_empty(const vector_1d_ptr_int& vptr);
    int v1d_int_get_size(const vector_1d_ptr_int& vptr);
    void v1d_int_append(vector_1d_ptr_int& vptr,int val);
    int v1d_int_get_data(const vector_1d_ptr_int& vptr,int idx);
    void v1d_int_set_data(vector_1d_ptr_int& vptr,int idx,int val);
    int v1d_int_get_tail(const vector_1d_ptr_int& vptr);
    void v1d_int_set_tail(vector_1d_ptr_int& vptr,int val);
    void v1d_int_insert(vector_1d_ptr_int& vptr,const int idx,const int val);
    void v1d_int_pop_back(vector_1d_ptr_int& vptr);
    void v1d_int_send_with_tag(const vector_1d_ptr_int& vptr,
                               const int dest,
                               const int tag);
    void v1d_int_send(const vector_1d_ptr_int& vptr,
                      const int dest);
    void v1d_int_recv_with_tag(vector_1d_ptr_int& vptr,
                               const int source,
                               const int tag);
    void v1d_int_recv(vector_1d_ptr_int& vptr,
                      const int source);
    void v1d_int_bcast_with_root(vector_1d_ptr_int& vptr,
                                 const int root);
    void v1d_int_bcast(vector_1d_ptr_int& vptr);
  }
  
  // --- double
  using vector_1d_ptr_double = vector_1d_cpp<double>*;
  extern "C"
  {
    vector_1d_ptr_double v1d_double_init();
    vector_1d_ptr_double v1d_double_init_size(int size);
    vector_1d_ptr_double v1d_double_init_size_val(int size,double val);
    void v1d_double_delete(vector_1d_ptr_double& vptr);
    void v1d_double_deep_copy(vector_1d_ptr_double& lhs,
                              const vector_1d_ptr_double& rhs);
    bool v1d_double_is_empty(const vector_1d_ptr_double& vptr);
    int v1d_double_get_size(const vector_1d_ptr_double& vptr);
    void v1d_double_append(vector_1d_ptr_double& vptr,double val);
    double v1d_double_get_data(const vector_1d_ptr_double& vptr,int idx);
    void v1d_double_set_data(vector_1d_ptr_double& vptr,int idx,double val);
    double v1d_double_get_tail(const vector_1d_ptr_double& vptr);
    void v1d_double_set_tail(vector_1d_ptr_double& vptr,double val);
    void v1d_double_insert(vector_1d_ptr_double& vptr,const int idx,const double val);
    void v1d_double_pop_back(vector_1d_ptr_double& vptr);
    void v1d_double_send_with_tag(const vector_1d_ptr_double& vptr,
                                  const int dest,
                                  const int tag);
    void v1d_double_send(const vector_1d_ptr_double& vptr,
                         const int dest);
    void v1d_double_recv_with_tag(vector_1d_ptr_double& vptr,
                                  const int source,
                                  const int tag);
    void v1d_double_recv(vector_1d_ptr_double& vptr,
                         const int source);
    void v1d_double_bcast_with_root(vector_1d_ptr_double& vptr,
                                    const int root);
    void v1d_double_bcast(vector_1d_ptr_double& vptr);
  }
 
#endif