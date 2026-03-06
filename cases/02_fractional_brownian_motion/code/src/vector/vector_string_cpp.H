#ifndef vector_string_cpp_H
#define vector_string_cpp_H

#include <string>
#include <vector>

class vector_string_cpp
{
private:

protected:

  std::vector<std::string> x;

public:

  vector_string_cpp();
  
  vector_string_cpp(int size);

  vector_string_cpp(const vector_string_cpp& rhs);

  ~vector_string_cpp();
  
  vector_string_cpp& operator=(const vector_string_cpp &rhs);
  
  int get_size() const;

  int get_size(const int row) const;
  
  bool is_empty() const;
  
  void resize(const int n);
  
  void append(const std::string& value);
  
  void clear();

  std::string& back();
  
  const std::string& back() const;

  std::string& operator[](const int idx);

  const std::string& operator[](const int idx) const;
  
  void print() const;

};

  // Fortran vector

  using vector_string_ptr = vector_string_cpp*;
  extern "C"
  {
    vector_string_ptr v_string_init();
    
    vector_string_ptr v_string_init_size(int size);

    void v_string_delete(vector_string_ptr& vptr);
    
    void v_string_deep_copy(vector_string_ptr& lhs,
                           const vector_string_ptr& rhs);
                           
    bool v_string_is_empty(const vector_string_ptr& vptr);
    
    int v_string_get_size(const vector_string_ptr& vptr);
    
    int v_string_get_size_row(const vector_string_ptr& vptr,const int row);
    
    void v_string_append(vector_string_ptr& vptr,
                         const char** val,
                         const int size);
    
    void v_string_get_data(const vector_string_ptr& vptr,
                           int idx,
                           char** val);
    
    void v_string_set_data(vector_string_ptr& vptr,
                           int idx,
                           const char** val,
                           const int size);
    
    void v_string_get_tail(const vector_string_ptr& vptr,
                           char** val);
    
    void v_string_set_tail(vector_string_ptr& vptr,
                           const char** val,
                           const int size);
    
    void v_string_write_to_screen(const vector_string_ptr& vptr);
  }
 
#endif