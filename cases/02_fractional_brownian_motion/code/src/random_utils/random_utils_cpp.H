#ifndef random_utils_H
#define random_utils_H

#include <random>
#include <vector>

class random_utils
{
private:

public:
  
  static std::normal_distribution<double> normal_distr;
  
  static std::uniform_real_distribution<double> uniform_distr;
  
  static void set_seed();
  
  static void default_seed();

  static double randn();
  
  static void randn(const int n,double* const x);

  static double randu();
  
  static void randu(const int n,double* const x);
};

  // Fortran interface

  extern "C"
  {
    void set_random_seed_cpp();
    void default_random_seed_cpp();
    double randn_cpp();
    double randu_cpp();
    void randn_array_cpp(const int n,double* const x);
    void randu_array_cpp(const int n,double* const x);
  }
 
#endif