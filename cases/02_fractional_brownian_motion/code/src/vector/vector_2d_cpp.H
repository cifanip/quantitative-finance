#ifndef vector_2d_cpp_H
#define vector_2d_cpp_H

#include <string>
#include <vector>
#include "vector_1d_cpp.H"

template <typename Type> 
class vector_2d_cpp
{
private:

protected:

  std::vector<vector_1d_cpp<Type>> x;
  
  using iterator = typename std::vector<vector_1d_cpp<Type>>::iterator;

public:

  vector_2d_cpp();
  
  vector_2d_cpp(int size);

  vector_2d_cpp(const vector_2d_cpp& rhs);
  
  ~vector_2d_cpp();
  
  vector_2d_cpp& operator=(const vector_2d_cpp &rhs);
  
  vector_2d_cpp& operator=(const Type& value);

  int get_size() const;
  
  int get_size(const int irow) const;
  
  bool is_empty() const;
  
  void resize(const int n);
  
  void append(const vector_1d_cpp<Type>& value);
  
  void append(const vector_2d_cpp& value);
  
  void extend_row(const int irow,
                  const vector_1d_cpp<Type>& value);
  
  void insert(const int idx,
              const vector_1d_cpp<Type>& value);
              
  void pop_back();
  
  void clear();

  vector_1d_cpp<Type>& back();
  
  const vector_1d_cpp<Type>& back() const;

  vector_1d_cpp<Type>& operator[](const int idx);

  const vector_1d_cpp<Type>& operator[](const int idx) const;
  
  Type* get_data_ptr();
  
  void set_all(const Type& x);
  
  void print() const;
  
  static void send(const vector_2d_cpp& x,
                   const int dest,
                   const int tag);
                   
  static void send(const vector_2d_cpp& x,
                   const int dest);

  void send(const int dest) const;
  
  void send(const int dest,
            const int tag) const;
            
  static void recv(vector_2d_cpp& x,
                   const int source,
                   const int tag);

  static void recv(vector_2d_cpp& x,
                   const int source);

  void recv(const int source,
            const int tag);

  void recv(const int source);

  static void bcast(vector_2d_cpp& x,
                    const int root);
                      
  static void bcast(vector_2d_cpp& x);

  void bcast(const int root);

  void bcast(); 

};

  // Fortran vector

  // --- int
  using vector_2d_ptr_int = vector_2d_cpp<int>*;
  extern "C"
  {
    vector_2d_ptr_int v2d_int_init();

    vector_2d_ptr_int v2d_int_init_size(int size);

    void v2d_int_delete(vector_2d_ptr_int& vptr);

    void v2d_int_deep_copy(vector_2d_ptr_int& lhs,
                           const vector_2d_ptr_int& rhs);
                  
    bool v2d_int_is_empty(const vector_2d_ptr_int& vptr);

    int v2d_int_get_size(const vector_2d_ptr_int& vptr);

    int v2d_int_get_row_size(const vector_2d_ptr_int& vptr,const int irow);

    void v2d_int_append(vector_2d_ptr_int& vptr,
                        const vector_1d_ptr_int& vec);

    void v2d_int_extend_row(vector_2d_ptr_int& vptr,
                            const int irow,
                            const vector_1d_ptr_int& vec);

    int v2d_int_get_data(const vector_2d_ptr_int& vptr,
                         int i,int j);

    void v2d_int_set_data(vector_2d_ptr_int& vptr,
                          int i,int j,int val);

    vector_1d_ptr_int v2d_int_get_row(const vector_2d_ptr_int& vptr,
                                      const int irow);

    void v2d_int_set_row(vector_2d_ptr_int& vptr,
                         const int irow,
                         const vector_1d_ptr_int& vec);

    vector_1d_ptr_int v2d_int_get_tail(const vector_2d_ptr_int& vptr);

    void v2d_int_set_tail(vector_2d_ptr_int& vptr,
                          const vector_1d_ptr_int& vec);
                          
    void v2d_int_print(const vector_2d_ptr_int& vptr);
    
    void v2d_int_insert(vector_2d_ptr_int& vptr,
                        const int idx,
                        const vector_1d_ptr_int& vec);

    void v2d_int_pop_back(vector_2d_ptr_int& vptr);
    
    void v2d_int_send_with_tag(const vector_2d_ptr_int& vptr,
                               const int dest,
                               const int tag);
                               
    void v2d_int_send(const vector_2d_ptr_int& vptr,
                      const int dest);
                      
    void v2d_int_recv_with_tag(vector_2d_ptr_int& vptr,
                               const int source,
                               const int tag);
                               
    void v2d_int_recv(vector_2d_ptr_int& vptr,
                      const int source);
                      
    void v2d_int_bcast_with_root(vector_2d_ptr_int& vptr,
                                 const int root);
                                 
    void v2d_int_bcast(vector_2d_ptr_int& vptr);
  }

  // --- double
  using vector_2d_ptr_double = vector_2d_cpp<double>*;
  extern "C"
  {
    vector_2d_ptr_double v2d_double_init();

    vector_2d_ptr_double v2d_double_init_size(int size);

    void v2d_double_delete(vector_2d_ptr_double& vptr);

    void v2d_double_deep_copy(vector_2d_ptr_double& lhs,
                              const vector_2d_ptr_double& rhs);

    bool v2d_double_is_empty(const vector_2d_ptr_double& vptr);

    int v2d_double_get_size(const vector_2d_ptr_double& vptr);

    int v2d_double_get_row_size(const vector_2d_ptr_double& vptr,const int irow);

    void v2d_double_append(vector_2d_ptr_double& vptr,
                           const vector_1d_ptr_double& vec);

    void v2d_double_extend_row(vector_2d_ptr_double& vptr,
                               const int irow,
                               const vector_1d_ptr_double& vec);

    double v2d_double_get_data(const vector_2d_ptr_double& vptr,
                               int i,int j);

    void v2d_double_set_data(vector_2d_ptr_double& vptr,
                             int i,int j,double val);

    vector_1d_ptr_double v2d_double_get_row(const vector_2d_ptr_double& vptr,
                                            const int irow);

    void v2d_double_set_row(vector_2d_ptr_double& vptr,
                            const int irow,
                            const vector_1d_ptr_double& vec);

    vector_1d_ptr_double v2d_double_get_tail(const vector_2d_ptr_double& vptr);

    void v2d_double_set_tail(vector_2d_ptr_double& vptr,
                             const vector_1d_ptr_double& vec);
                             
    void v2d_double_print(const vector_2d_ptr_double& vptr);
    
    void v2d_double_insert(vector_2d_ptr_double& vptr,
                           const int idx,
                           const vector_1d_ptr_double& vec);

    void v2d_double_pop_back(vector_2d_ptr_double& vptr);
    
    void v2d_double_send_with_tag(const vector_2d_ptr_double& vptr,
                                  const int dest,
                                  const int tag);

    void v2d_double_send(const vector_2d_ptr_double& vptr,
                         const int dest);

    void v2d_double_recv_with_tag(vector_2d_ptr_double& vptr,
                                  const int source,
                                  const int tag);

    void v2d_double_recv(vector_2d_ptr_double& vptr,
                         const int source);

    void v2d_double_bcast_with_root(vector_2d_ptr_double& vptr,
                                    const int root);

    void v2d_double_bcast(vector_2d_ptr_double& vptr);
  }
 
#endif
