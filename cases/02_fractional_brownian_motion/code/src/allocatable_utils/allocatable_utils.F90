module allocatable_utils

  use kinds
  use mpi_error_handler

  implicit none
  
  interface init_char_array
    module procedure init_array_1d_char
  end interface
  
  interface allocate_array
      module procedure allocate_array_1d_double
      module procedure allocate_array_2d_double
      module procedure allocate_array_3d_double
      module procedure allocate_array_4d_double
      
      module procedure allocate_array_1d_integer
      module procedure allocate_array_2d_integer
      module procedure allocate_array_3d_integer
      
      module procedure allocate_array_1d_logical
      module procedure allocate_array_2d_logical
      module procedure allocate_array_3d_logical
      
      module procedure allocate_array_1d_char

      module procedure allocate_array_1d_complex_double
      module procedure allocate_array_2d_complex_double
      module procedure allocate_array_3d_complex_double
#ifdef GPU_RUN
      module procedure allocate_array_1d_double_d
      module procedure allocate_array_2d_double_d
      module procedure allocate_array_3d_double_d
      module procedure allocate_array_4d_double_d
      
      module procedure allocate_array_1d_integer_d
      module procedure allocate_array_2d_integer_d
      module procedure allocate_array_3d_integer_d
      
      module procedure allocate_array_1d_logical_d
      module procedure allocate_array_2d_logical_d
      module procedure allocate_array_3d_logical_d
      
      module procedure allocate_array_1d_complex_double_d
      module procedure allocate_array_2d_complex_double_d
      module procedure allocate_array_3d_complex_double_d
#endif
    end interface
    
  interface deallocate_array
      module procedure deallocate_array_1d_double
      module procedure deallocate_array_2d_double
      module procedure deallocate_array_3d_double
      module procedure deallocate_array_4d_double
      
      module procedure deallocate_array_1d_integer
      module procedure deallocate_array_2d_integer
      module procedure deallocate_array_3d_integer
      
      module procedure deallocate_array_1d_logical
      module procedure deallocate_array_2d_logical
      module procedure deallocate_array_3d_logical
      
      module procedure deallocate_array_1d_char

      module procedure deallocate_array_1d_complex_double
      module procedure deallocate_array_2d_complex_double
      module procedure deallocate_array_3d_complex_double
#ifdef GPU_RUN    
      module procedure deallocate_array_1d_double_d
      module procedure deallocate_array_2d_double_d
      module procedure deallocate_array_3d_double_d
      module procedure deallocate_array_4d_double_d
      
      module procedure deallocate_array_1d_integer_d
      module procedure deallocate_array_2d_integer_d
      module procedure deallocate_array_3d_integer_d
      
      module procedure deallocate_array_1d_logical_d
      module procedure deallocate_array_2d_logical_d
      module procedure deallocate_array_3d_logical_d

      module procedure deallocate_array_1d_complex_double_d
      module procedure deallocate_array_2d_complex_double_d
      module procedure deallocate_array_3d_complex_double_d
#endif
    end interface
    
  interface reallocate_array
      module procedure reallocate_array_1d_double
      module procedure reallocate_array_2d_double
      module procedure reallocate_array_3d_double
      module procedure reallocate_array_4d_double
      
      module procedure reallocate_array_1d_integer
      module procedure reallocate_array_2d_integer
      module procedure reallocate_array_3d_integer
      
      module procedure reallocate_array_1d_logical
      module procedure reallocate_array_2d_logical
      module procedure reallocate_array_3d_logical
      
      module procedure reallocate_array_1d_char

      module procedure reallocate_array_1d_complex_double
      module procedure reallocate_array_2d_complex_double
      module procedure reallocate_array_3d_complex_double
#ifdef GPU_RUN
      module procedure reallocate_array_1d_double_d
      module procedure reallocate_array_2d_double_d
      module procedure reallocate_array_3d_double_d
      module procedure reallocate_array_4d_double_d
      
      module procedure reallocate_array_1d_integer_d
      module procedure reallocate_array_2d_integer_d
      module procedure reallocate_array_3d_integer_d
      
      module procedure reallocate_array_1d_logical_d
      module procedure reallocate_array_2d_logical_d
      module procedure reallocate_array_3d_logical_d

      module procedure reallocate_array_1d_complex_double_d
      module procedure reallocate_array_2d_complex_double_d
      module procedure reallocate_array_3d_complex_double_d
#endif    
    end interface
    
    interface copy_array
      module procedure copy_array_1d_double
      module procedure copy_array_2d_double
      module procedure copy_array_3d_double
      module procedure copy_array_4d_double
      
      module procedure copy_array_1d_integer
      module procedure copy_array_2d_integer
      module procedure copy_array_3d_integer
      
      module procedure copy_array_1d_logical
      module procedure copy_array_2d_logical
      module procedure copy_array_3d_logical
      
      module procedure copy_array_1d_char

      module procedure copy_array_1d_complex_double
      module procedure copy_array_2d_complex_double
      module procedure copy_array_3d_complex_double
#ifdef GPU_RUN
      module procedure copy_array_1d_double_d
      module procedure copy_array_2d_double_d
      module procedure copy_array_3d_double_d
      module procedure copy_array_4d_double_d
      
      module procedure copy_array_1d_integer_d
      module procedure copy_array_2d_integer_d
      module procedure copy_array_3d_integer_d
      
      module procedure copy_array_1d_logical_d
      module procedure copy_array_2d_logical_d
      module procedure copy_array_3d_logical_d

      module procedure copy_array_1d_complex_double_d
      module procedure copy_array_2d_complex_double_d
      module procedure copy_array_3d_complex_double_d
#endif 
    end interface
    
    interface append_to_array
      module procedure append_to_array_1d_integer
      module procedure append_to_array_1d_double
      module procedure append_to_array_1d_complex_double
      module procedure append_to_array_1d_logical
    end interface
  
contains

!                     allocate 
!========================================================================================!
!---------                real double
  subroutine allocate_array_1d_double(v,st,en) 
    integer, intent(in) :: st, en
    real(double_p), allocatable, dimension(:), intent(inout) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_1d_double_d(v,st,en) 
    integer, intent(in) :: st, en
    real(double_p), allocatable, dimension(:), intent(inout), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_2d_double(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_2d_double_d(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_3d_double(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_3d_double_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_4d_double(v,st1,en1,st2,en2,st3,en3,st4,en4) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 4
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_3d_double_d(v,st1,en1,st2,en2,st3,en3,st4,en4) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 4
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                integer
  subroutine allocate_array_1d_integer(v,st,en) 
    integer, intent(in) :: st, en
    integer, allocatable, dimension(:), intent(inout) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_1d_integer_d(v,st,en) 
    integer, intent(in) :: st, en
    integer, allocatable, dimension(:), intent(inout), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_2d_integer(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_2d_integer_d(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_3d_integer(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_3d_integer_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                logical
  subroutine allocate_array_1d_logical(v,st,en) 
    integer, intent(in) :: st, en
    logical, allocatable, dimension(:), intent(inout) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_1d_logical_d(v,st,en) 
    integer, intent(in) :: st, en
    logical, allocatable, dimension(:), intent(inout), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine allocate_array_2d_logical(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_2d_logical_d(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine allocate_array_3d_logical(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_3d_logical_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                character
  subroutine allocate_array_1d_char(v,size) 
    integer, intent(in) :: size
    character(len=:), allocatable, intent(inout) :: v
    integer :: err
#   define vec_dim 1
#   include "char_alloc.F90"
#   undef vec_dim
  end subroutine
  
  subroutine init_array_1d_char(v,x) 
    character(len=:), allocatable, intent(out) :: v
    character(len=*), intent(in) :: x
    
    call allocate_array(v,len(x))
    v = x

  end subroutine

!---------                complex double
  subroutine allocate_array_1d_complex_double(v,st,en) 
    integer, intent(in) :: st, en
    complex(double_p), allocatable, dimension(:), intent(inout) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_1d_complex_double_d(v,st,en) 
    integer, intent(in) :: st, en
    complex(double_p), allocatable, dimension(:), intent(inout), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_2d_complex_double(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    complex(double_p), allocatable, dimension(:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_2d_complex_double_d(v,st1,en1,st2,en2) 
    integer, intent(in) :: st1, en1, st2, en2
    complex(double_p), allocatable, dimension(:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array_3d_complex_double(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    complex(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array_3d_complex_double_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    complex(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc.F90"
#   undef vec_dim
  end subroutine
#endif
!========================================================================================!

!                     deallocate 
!========================================================================================!
!---------                real double
  subroutine deallocate_array_1d_double(v) 
    real(double_p), allocatable, dimension(:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_1d_double_d(v) 
    real(double_p), allocatable, dimension(:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_2d_double(v) 
    real(double_p), allocatable, dimension(:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_2d_double_d(v) 
    real(double_p), allocatable, dimension(:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_3d_double(v) 
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_3d_double_d(v) 
    real(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_4d_double(v) 
    real(double_p), allocatable, dimension(:,:,:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_4d_double_d(v) 
    real(double_p), allocatable, dimension(:,:,:.:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

!---------                integer
  subroutine deallocate_array_1d_integer(v) 
    integer, allocatable, dimension(:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_1d_integer_d(v) 
    integer, allocatable, dimension(:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif
  
  subroutine deallocate_array_2d_integer(v) 
    integer, allocatable, dimension(:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_2d_integer_d(v) 
    integer, allocatable, dimension(:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_3d_integer(v) 
    integer, allocatable, dimension(:,:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_3d_integer_d(v) 
    integer, allocatable, dimension(:,:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

!---------                logical
  subroutine deallocate_array_1d_logical(v) 
    logical, allocatable, dimension(:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_1d_logical_d(v) 
    logical, allocatable, dimension(:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif
  
  subroutine deallocate_array_2d_logical(v) 
    logical, allocatable, dimension(:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_2d_logical_d(v) 
    logical, allocatable, dimension(:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_3d_logical(v) 
    logical, allocatable, dimension(:,:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_3d_logical_d(v) 
    logical, allocatable, dimension(:,:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

!---------                character
  subroutine deallocate_array_1d_char(v) 
    character(len=:), allocatable, intent(OUT) :: v
#   include "deallocate_arr.F90"
  end subroutine

!---------                complex double
  subroutine deallocate_array_1d_complex_double(v) 
    complex(double_p), allocatable, dimension(:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_1d_complex_double_d(v) 
    complex(double_p), allocatable, dimension(:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_2d_complex_double(v) 
    complex(double_p), allocatable, dimension(:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_2d_complex_double_d(v) 
    complex(double_p), allocatable, dimension(:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif

  subroutine deallocate_array_3d_complex_double(v) 
    complex(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
#   include "deallocate_arr.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array_3d_complex_double_d(v) 
    complex(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
#   include "deallocate_arr.F90"
  end subroutine
#endif
!========================================================================================!

!                     re-allocate 
!========================================================================================!
!---------                real double
  subroutine reallocate_array_1d_double(v,st,en) 
    integer, intent(in) :: st, en
    real(double_p), allocatable, dimension(:), intent(inout) :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_1d_double_d(v,st,en) 
    integer, intent(in) :: st, en
    real(double_p), allocatable, dimension(:), intent(inout), device :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_2d_double(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(inout) :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_2d_double_d(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(inout), device :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_3d_double(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_3d_double_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_4d_double(v,st1,en1,st2,en2,st3,en3,st4,en4)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(inout) :: v
#   define vec_dim 4
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_3d_double_d(v,st1,en1,st2,en2,st3,en3,st4,en4)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(inout), device :: v
#   define vec_dim 4
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                integer
  subroutine reallocate_array_1d_integer(v,st,en) 
    integer, intent(in) :: st, en
    integer, allocatable, dimension(:), intent(inout) :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_1d_integer_d(v,st,en) 
    integer, intent(in) :: st, en
    integer, allocatable, dimension(:), intent(inout), device :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine reallocate_array_2d_integer(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(inout) :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_2d_integer_d(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(inout), device :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_3d_integer(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(inout) :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_3d_integer_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(inout), device :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                logical
  subroutine reallocate_array_1d_logical(v,st,en)
    integer, intent(in) :: st, en
    logical, allocatable, dimension(:), intent(inout) :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_1d_logical_d(v,st,en)
    integer, intent(in) :: st, en
    logical, allocatable, dimension(:), intent(inout), device :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_2d_logical(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(inout) :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_2d_logical_d(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(inout), device :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_3d_logical(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(inout) :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_3d_logical_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(inout), device :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                character
  subroutine reallocate_array_1d_char(v,size) 
    integer, intent(in) :: size
    character(len=:), allocatable, intent(inout) :: v
#   define vec_dim 1
#   include "char_realloc.F90"
#   undef vec_dim
  end subroutine
  
!---------                complex double
  subroutine reallocate_array_1d_complex_double(v,st,en) 
    integer, intent(in) :: st, en
    complex(double_p), allocatable, dimension(:), intent(inout) :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_1d_complex_double_d(v,st,en) 
    integer, intent(in) :: st, en
    complex(double_p), allocatable, dimension(:), intent(inout), device :: v
#   define vec_dim 1
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_2d_complex_double(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    complex(double_p), allocatable, dimension(:,:), intent(inout) :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_2d_complex_double_d(v,st1,en1,st2,en2)
    integer, intent(in) :: st1, en1, st2, en2
    complex(double_p), allocatable, dimension(:,:), intent(inout), device :: v
#   define vec_dim 2
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array_3d_complex_double(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    complex(double_p), allocatable, dimension(:,:,:), intent(inout) :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array_3d_complex_double_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(in) :: st1, en1, st2, en2, st3, en3
    complex(double_p), allocatable, dimension(:,:,:), intent(inout), device :: v
#   define vec_dim 3
#   include "arr_realloc.F90"
#   undef vec_dim
  end subroutine
#endif
!========================================================================================!

!                     copy 
!========================================================================================!
!---------                real double
  subroutine copy_array_1d_double(v1,v2) 
    real(double_p), allocatable, dimension(:), intent(OUT) :: v1
    real(double_p), allocatable, dimension(:), intent(in)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_1d_double_d(v1,v2) 
    real(double_p), allocatable, dimension(:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:), intent(in), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_2d_double(v1,v2)
    real(double_p), allocatable, dimension(:,:), intent(OUT) :: v1
    real(double_p), allocatable, dimension(:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_2d_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_3d_double(v1,v2)
    real(double_p), allocatable, dimension(:,:,:), intent(OUT)  :: v1
    real(double_p), allocatable, dimension(:,:,:), intent(in) :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_3d_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_4d_double(v1,v2)
    real(double_p), allocatable, dimension(:,:,:,:), intent(OUT)  :: v1
    real(double_p), allocatable, dimension(:,:,:,:), intent(in) :: v2
    integer :: st1, en1, st2, en2, st3, en3, st4, en4
#   define vec_dim 4
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_3d_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:,:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:,:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3, st4 , en4
#   define vec_dim 4
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                integer
  subroutine copy_array_1d_integer(v1,v2) 
    integer, allocatable, dimension(:), intent(OUT) :: v1
    integer, allocatable, dimension(:), intent(in)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_1d_integer_d(v1,v2) 
    integer, allocatable, dimension(:), intent(OUT), device :: v1
    integer, allocatable, dimension(:), intent(in), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine copy_array_2d_integer(v1,v2)
    integer, allocatable, dimension(:,:), intent(OUT) :: v1
    integer, allocatable, dimension(:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_2d_integer_d(v1,v2)
    integer, allocatable, dimension(:,:), intent(OUT), device :: v1
    integer, allocatable, dimension(:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_3d_integer(v1,v2)
    integer, allocatable, dimension(:,:,:), intent(OUT) :: v1
    integer, allocatable, dimension(:,:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_3d_integer_d(v1,v2)
    integer, allocatable, dimension(:,:,:), intent(OUT), device :: v1
    integer, allocatable, dimension(:,:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                logical
  subroutine copy_array_1d_logical(v1,v2)
    logical, allocatable, dimension(:), intent(OUT) :: v1
    logical, allocatable, dimension(:), intent(in)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_1d_logical_d(v1,v2)
    logical, allocatable, dimension(:), intent(OUT), device :: v1
    logical, allocatable, dimension(:), intent(in), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_2d_logical(v1,v2)
    logical, allocatable, dimension(:,:), intent(OUT) :: v1
    logical, allocatable, dimension(:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_2d_logical_d(v1,v2)
    logical, allocatable, dimension(:,:), intent(OUT), device :: v1
    logical, allocatable, dimension(:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_3d_logical(v1,v2)
    logical, allocatable, dimension(:,:,:), intent(OUT) :: v1
    logical, allocatable, dimension(:,:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_3d_logical_d(v1,v2)
    logical, allocatable, dimension(:,:,:), intent(OUT), device :: v1
    logical, allocatable, dimension(:,:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                character
  subroutine copy_array_1d_char(v1,v2) 
    character(len=:), allocatable, intent(OUT) :: v1
    character(len=:), allocatable, intent(in)  :: v2
    integer :: size
#   define vec_dim 1
#   include "char_copy.F90"
#   undef vec_dim
  end subroutine
  
!---------                complex double
  subroutine copy_array_1d_complex_double(v1,v2) 
    complex(double_p), allocatable, dimension(:), intent(OUT) :: v1
    complex(double_p), allocatable, dimension(:), intent(in)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_1d_complex_double_d(v1,v2) 
    complex(double_p), allocatable, dimension(:), intent(OUT), device :: v1
    complex(double_p), allocatable, dimension(:), intent(in), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_2d_complex_double(v1,v2)
    complex(double_p), allocatable, dimension(:,:), intent(OUT) :: v1
    complex(double_p), allocatable, dimension(:,:), intent(in)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_2d_complex_double_d(v1,v2)
    complex(double_p), allocatable, dimension(:,:), intent(OUT), device :: v1
    complex(double_p), allocatable, dimension(:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array_3d_complex_double(v1,v2)
    complex(double_p), allocatable, dimension(:,:,:), intent(OUT)  :: v1
    complex(double_p), allocatable, dimension(:,:,:), intent(in) :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array_3d_complex_double_d(v1,v2)
    complex(double_p), allocatable, dimension(:,:,:), intent(OUT), device :: v1
    complex(double_p), allocatable, dimension(:,:,:), intent(in), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy.F90"
#   undef vec_dim
  end subroutine
#endif
!========================================================================================!

!                     append to array 
!========================================================================================!
!---------                integer
  subroutine append_to_array_1d_integer(x,y)
    integer, allocatable, dimension(:), intent(inout) :: x
    integer, intent(in) :: y
    integer, allocatable, dimension(:) :: tmp
#   define vec_dim 1
#   include "append_to_array.F90"
#   undef vec_dim
  end subroutine
  
!---------                real double
  subroutine append_to_array_1d_double(x,y)
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    real(double_p), intent(in) :: y
    real(double_p), allocatable, dimension(:) :: tmp
#   define vec_dim 1
#   include "append_to_array.F90"
#   undef vec_dim
  end subroutine
  
  !---------                complex double
  subroutine append_to_array_1d_complex_double(x,y)
    complex(double_p), allocatable, dimension(:), intent(inout) :: x
    complex(double_p), intent(in) :: y
    complex(double_p), allocatable, dimension(:) :: tmp
#   define vec_dim 1
#   include "append_to_array.F90"
#   undef vec_dim
  end subroutine

  !---------                logical
  subroutine append_to_array_1d_logical(x,y)
    logical, allocatable, dimension(:), intent(inout) :: x
    logical, intent(in) :: y
    logical, allocatable, dimension(:) :: tmp
#   define vec_dim 1
#   include "append_to_array.F90"
#   undef vec_dim
  end subroutine
!========================================================================================!
  
end module allocatable_utils