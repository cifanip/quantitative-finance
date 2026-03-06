#ifndef vector_3d_cpp_H
#define vector_3d_cpp_H

#include <string>
#include <vector>
#include "vector_1d_cpp.H"
#include "vector_2d_cpp.H"

template <typename Type> 
class vector_3d_cpp
{
private:

protected:

  std::vector<vector_2d_cpp<Type>> x;
  
  using iterator = typename std::vector<vector_2d_cpp<Type>>::iterator;

public:

  vector_3d_cpp();
  
  vector_3d_cpp(int size);

  vector_3d_cpp(const vector_3d_cpp& rhs);
  
  ~vector_3d_cpp();
  
  vector_3d_cpp& operator=(const vector_3d_cpp &rhs);
  
  vector_3d_cpp& operator=(const Type& value);

  int get_size() const;
  
  int get_size(const int irow) const;
  
  int get_size(const int i, const int j) const;
  
  bool is_empty() const;
  
  void resize(const int n);
  
  void append(const vector_2d_cpp<Type>& value);
  
  void append(const vector_3d_cpp& value);
  
  void insert(const int idx,
              const vector_2d_cpp<Type>& value);
              
  void pop_back();
  
  void clear();

  vector_2d_cpp<Type>& back();
  
  const vector_2d_cpp<Type>& back() const;

  vector_2d_cpp<Type>& operator[](const int idx);

  const vector_2d_cpp<Type>& operator[](const int idx) const;
  
  Type* get_data_ptr();
  
  void set_all(const Type& x);
  
  void print() const;   

};

  // Fortran vector

  // --- int
  using vector_3d_ptr_int = vector_3d_cpp<int>*;
  extern "C"
  {
    vector_3d_ptr_int v3d_int_init();

    vector_3d_ptr_int v3d_int_init_size(int size);

    void v3d_int_delete(vector_3d_ptr_int& vptr);

    void v3d_int_deep_copy(vector_3d_ptr_int& lhs,
                           const vector_3d_ptr_int& rhs);
                  
    bool v3d_int_is_empty(const vector_3d_ptr_int& vptr);

    int v3d_int_get_list_size(const vector_3d_ptr_int& vptr);

    int v3d_int_get_sub_list_size(const vector_3d_ptr_int& vptr,const int i);
    
    int v3d_int_get_sub_sub_list_size(const vector_3d_ptr_int& vptr,
                                      const int i,
                                      const int j);

    void v3d_int_append(vector_3d_ptr_int& vptr,
                        const vector_2d_ptr_int& vec);

    int v3d_int_get_data(const vector_3d_ptr_int& vptr,
                         int i,int j,int k);

    void v3d_int_set_data(vector_3d_ptr_int& vptr,
                          int i,int j,int k,int val);

    vector_2d_ptr_int v3d_int_get_row(const vector_3d_ptr_int& vptr,
                                      const int irow);

    void v3d_int_set_row(vector_3d_ptr_int& vptr,
                         const int irow,
                         const vector_2d_ptr_int& vec);

    vector_2d_ptr_int v3d_int_get_tail(const vector_3d_ptr_int& vptr);

    void v3d_int_set_tail(vector_3d_ptr_int& vptr,
                          const vector_2d_ptr_int& vec);
                          
    void v3d_int_print(const vector_3d_ptr_int& vptr);
    
    void v3d_int_insert(vector_3d_ptr_int& vptr,
                        const int idx,
                        const vector_2d_ptr_int& vec);

    void v3d_int_pop_back(vector_3d_ptr_int& vptr);
  }

  // --- double
  using vector_3d_ptr_double = vector_3d_cpp<double>*;
  extern "C"
  {
    vector_3d_ptr_double v3d_double_init();

    vector_3d_ptr_double v3d_double_init_size(int size);

    void v3d_double_delete(vector_3d_ptr_double& vptr);

    void v3d_double_deep_copy(vector_3d_ptr_double& lhs,
                              const vector_3d_ptr_double& rhs);

    bool v3d_double_is_empty(const vector_3d_ptr_double& vptr);

    int v3d_double_get_list_size(const vector_3d_ptr_double& vptr);

    int v3d_double_get_sub_list_size(const vector_3d_ptr_double& vptr,const int i);
    
    int v3d_double_get_sub_sub_list_size(const vector_3d_ptr_double& vptr,
                                         const int i,
                                         const int j);

    void v3d_double_append(vector_3d_ptr_double& vptr,
                           const vector_2d_ptr_double& vec);

    double v3d_double_get_data(const vector_3d_ptr_double& vptr,
                               int i,int j,int k);

    void v3d_double_set_data(vector_3d_ptr_double& vptr,
                             int i,int j,int k,double val);

    vector_2d_ptr_double v3d_double_get_row(const vector_3d_ptr_double& vptr,
                                            const int irow);

    void v3d_double_set_row(vector_3d_ptr_double& vptr,
                            const int irow,
                            const vector_2d_ptr_double& vec);

    vector_2d_ptr_double v3d_double_get_tail(const vector_3d_ptr_double& vptr);

    void v3d_double_set_tail(vector_3d_ptr_double& vptr,
                             const vector_2d_ptr_double& vec);
                             
    void v3d_double_print(const vector_3d_ptr_double& vptr);

    void v3d_double_insert(vector_3d_ptr_double& vptr,
                           const int idx,
                           const vector_2d_ptr_double& vec);

    void v3d_double_pop_back(vector_3d_ptr_double& vptr);
  }
 
#endif
