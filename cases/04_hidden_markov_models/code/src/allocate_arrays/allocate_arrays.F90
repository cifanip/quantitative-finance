module allocate_arrays_mod

  use kinds_mod
  use prun_mod

  implicit none
  
  interface allocate_array
      module PROCEDURE allocate_array1D_double
      module PROCEDURE allocate_array2D_double
      module PROCEDURE allocate_array3D_double
      module PROCEDURE allocate_array4D_double
      
      module PROCEDURE allocate_array1D_integer
      module PROCEDURE allocate_array2D_integer
      module PROCEDURE allocate_array3D_integer
      
      module PROCEDURE allocate_array1D_logical
      module PROCEDURE allocate_array2D_logical
      module PROCEDURE allocate_array3D_logical
      
      module PROCEDURE allocate_array1D_char
#ifdef GPU_RUN
      module PROCEDURE allocate_array1D_double_d
      module PROCEDURE allocate_array2D_double_d
      module PROCEDURE allocate_array3D_double_d
      module PROCEDURE allocate_array4D_double_d
      
      module PROCEDURE allocate_array1D_integer_d
      module PROCEDURE allocate_array2D_integer_d
      module PROCEDURE allocate_array3D_integer_d
      
      module PROCEDURE allocate_array1D_logical_d
      module PROCEDURE allocate_array2D_logical_d
      module PROCEDURE allocate_array3D_logical_d
#endif
    end interface
    
  interface deallocate_array
      module PROCEDURE deallocate_array1D_double
      module PROCEDURE deallocate_array2D_double
      module PROCEDURE deallocate_array3D_double
      module PROCEDURE deallocate_array4D_double
      
      module PROCEDURE deallocate_array1D_integer
      module PROCEDURE deallocate_array2D_integer
      module PROCEDURE deallocate_array3D_integer
      
      module PROCEDURE deallocate_array1D_logical
      module PROCEDURE deallocate_array2D_logical
      module PROCEDURE deallocate_array3D_logical
      
      module PROCEDURE deallocate_array1D_char
#ifdef GPU_RUN    
      module PROCEDURE deallocate_array1D_double_d
      module PROCEDURE deallocate_array2D_double_d
      module PROCEDURE deallocate_array3D_double_d
      module PROCEDURE deallocate_array4D_double_d
      
      module PROCEDURE deallocate_array1D_integer_d
      module PROCEDURE deallocate_array2D_integer_d
      module PROCEDURE deallocate_array3D_integer_d
      
      module PROCEDURE deallocate_array1D_logical_d
      module PROCEDURE deallocate_array2D_logical_d
      module PROCEDURE deallocate_array3D_logical_d
#endif
    end interface
    
  interface reallocate_array
      module PROCEDURE reallocate_array1D_double
      module PROCEDURE reallocate_array2D_double
      module PROCEDURE reallocate_array3D_double
      module PROCEDURE reallocate_array4D_double
      
      module PROCEDURE reallocate_array1D_integer
      module PROCEDURE reallocate_array2D_integer
      module PROCEDURE reallocate_array3D_integer
      
      module PROCEDURE reallocate_array1D_logical
      module PROCEDURE reallocate_array2D_logical
      module PROCEDURE reallocate_array3D_logical
      
      module PROCEDURE reallocate_array1D_char
#ifdef GPU_RUN
      module PROCEDURE reallocate_array1D_double_d
      module PROCEDURE reallocate_array2D_double_d
      module PROCEDURE reallocate_array3D_double_d
      module PROCEDURE reallocate_array4D_double_d
      
      module PROCEDURE reallocate_array1D_integer_d
      module PROCEDURE reallocate_array2D_integer_d
      module PROCEDURE reallocate_array3D_integer_d
      
      module PROCEDURE reallocate_array1D_logical_d
      module PROCEDURE reallocate_array2D_logical_d
      module PROCEDURE reallocate_array3D_logical_d
#endif    
    end interface
    
    interface copy_array
      module PROCEDURE copy_array1D_double
      module PROCEDURE copy_array2D_double
      module PROCEDURE copy_array3D_double
      module PROCEDURE copy_array4D_double
      
      module PROCEDURE copy_array1D_integer
      module PROCEDURE copy_array2D_integer
      module PROCEDURE copy_array3D_integer
      
      module PROCEDURE copy_array1D_logical
      module PROCEDURE copy_array2D_logical
      module PROCEDURE copy_array3D_logical
      
      module PROCEDURE copy_array1D_char
#ifdef GPU_RUN
      module PROCEDURE copy_array1D_double_d
      module PROCEDURE copy_array2D_double_d
      module PROCEDURE copy_array3D_double_d
      module PROCEDURE copy_array4D_double_d
      
      module PROCEDURE copy_array1D_integer_d
      module PROCEDURE copy_array2D_integer_d
      module PROCEDURE copy_array3D_integer_d
      
      module PROCEDURE copy_array1D_logical_d
      module PROCEDURE copy_array2D_logical_d
      module PROCEDURE copy_array3D_logical_d
#endif 
    end interface
  
contains

!                     allocate 
!========================================================================================!
!---------                REAL(DP)
  subroutine allocate_array1D_double(v,st,en) 
    integer, intent(IN) :: st, en
    real(double_p), allocatable, dimension(:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array1D_double_d(v,st,en) 
    integer, intent(IN) :: st, en
    real(double_p), allocatable, dimension(:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array2D_double(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array2D_double_d(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array3D_double(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array3D_double_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array4D_double(v,st1,en1,st2,en2,st3,en3,st4,en4) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 4
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array3D_double_d(v,st1,en1,st2,en2,st3,en3,st4,en4) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 4
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                INTEGER
  subroutine allocate_array1D_integer(v,st,en) 
    integer, intent(IN) :: st, en
    integer, allocatable, dimension(:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array1D_integer_d(v,st,en) 
    integer, intent(IN) :: st, en
    integer, allocatable, dimension(:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array2D_integer(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array2D_integer_d(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine allocate_array3D_integer(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array3D_integer_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                LOGICAL
  subroutine allocate_array1D_logical(v,st,en) 
    integer, intent(IN) :: st, en
    logical, allocatable, dimension(:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array1D_logical_d(v,st,en) 
    integer, intent(IN) :: st, en
    logical, allocatable, dimension(:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 1
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine allocate_array2D_logical(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array2D_logical_d(v,st1,en1,st2,en2) 
    integer, intent(IN) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 2
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine allocate_array3D_logical(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(INOUT) :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine allocate_array3D_logical_d(v,st1,en1,st2,en2,st3,en3) 
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(INOUT), device :: v
    integer :: err
#   define vec_dim 3
#   include "arr_alloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                CHARACTER
  subroutine allocate_array1D_char(v,size) 
    integer, intent(IN) :: size
    character(len=:), allocatable, intent(INOUT) :: v
    integer :: err
#   define vec_dim 1
#   include "char_alloc_H.F90"
#   undef vec_dim
  end subroutine
!========================================================================================!

!                     deallocate 
!========================================================================================!
!---------                REAL(DP)
  subroutine deallocate_array1D_double(v) 
    real(double_p), allocatable, dimension(:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array1D_double_d(v) 
    real(double_p), allocatable, dimension(:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

  subroutine deallocate_array2D_double(v) 
    real(double_p), allocatable, dimension(:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array2D_double_d(v) 
    real(double_p), allocatable, dimension(:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

  subroutine deallocate_array3D_double(v) 
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array3D_double_d(v) 
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

  subroutine deallocate_array4D_double(v) 
    real(double_p), allocatable, dimension(:,:,:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array4D_double_d(v) 
    real(double_p), allocatable, dimension(:,:,:.:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

!---------                INTEGER
  subroutine deallocate_array1D_integer(v) 
    integer, allocatable, dimension(:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array1D_integer_d(v) 
    integer, allocatable, dimension(:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif
  
  subroutine deallocate_array2D_integer(v) 
    integer, allocatable, dimension(:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array2D_integer_d(v) 
    integer, allocatable, dimension(:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

  subroutine deallocate_array3D_integer(v) 
    integer, allocatable, dimension(:,:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array3D_integer_d(v) 
    integer, allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

!---------                LOGICAL
  subroutine deallocate_array1D_logical(v) 
    logical, allocatable, dimension(:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array1D_logical_d(v) 
    logical, allocatable, dimension(:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif
  
  subroutine deallocate_array2D_logical(v) 
    logical, allocatable, dimension(:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array2D_logical_d(v) 
    logical, allocatable, dimension(:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

  subroutine deallocate_array3D_logical(v) 
    logical, allocatable, dimension(:,:,:), intent(INOUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#ifdef GPU_RUN
  subroutine deallocate_array3D_logical_d(v) 
    logical, allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   include "deallocate_arr_H.F90"
  end subroutine
#endif

!---------                CHARACTER
  subroutine deallocate_array1D_char(v) 
    character(len=:), allocatable, intent(OUT) :: v
#   include "deallocate_arr_H.F90"
  end subroutine
!========================================================================================!

!                     reAllocate 
!========================================================================================!
!---------                REAL(DP)
  subroutine reallocate_array1D_double(v,st,en) 
    integer, intent(IN) :: st, en
    real(double_p), allocatable, dimension(:), intent(INOUT) :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array1D_double_d(v,st,en) 
    integer, intent(IN) :: st, en
    real(double_p), allocatable, dimension(:), intent(INOUT), device :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array2D_double(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(INOUT) :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array2D_double_d(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    real(double_p), allocatable, dimension(:,:), intent(INOUT), device :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array3D_double(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT) :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array3D_double_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    real(double_p), allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array4D_double(v,st1,en1,st2,en2,st3,en3,st4,en4)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(INOUT) :: v
#   define vec_dim 4
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array3D_double_d(v,st1,en1,st2,en2,st3,en3,st4,en4)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3, st4, en4
    real(double_p), allocatable, dimension(:,:,:,:), intent(INOUT), device :: v
#   define vec_dim 4
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                INTEGER
  subroutine reallocate_array1D_integer(v,st,en) 
    integer, intent(IN) :: st, en
    integer, allocatable, dimension(:), intent(INOUT) :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array1D_integer_d(v,st,en) 
    integer, intent(IN) :: st, en
    integer, allocatable, dimension(:), intent(INOUT), device :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine reallocate_array2D_integer(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(INOUT) :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array2D_integer_d(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    integer, allocatable, dimension(:,:), intent(INOUT), device :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array3D_integer(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(INOUT) :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array3D_integer_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    integer, allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                LOGICAL
  subroutine reallocate_array1D_logical(v,st,en)
    integer, intent(IN) :: st, en
    logical, allocatable, dimension(:), intent(INOUT) :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array1D_logical_d(v,st,en)
    integer, intent(IN) :: st, en
    logical, allocatable, dimension(:), intent(INOUT), device :: v
#   define vec_dim 1
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array2D_logical(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(INOUT) :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array2D_logical_d(v,st1,en1,st2,en2)
    integer, intent(IN) :: st1, en1, st2, en2
    logical, allocatable, dimension(:,:), intent(INOUT), device :: v
#   define vec_dim 2
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine reallocate_array3D_logical(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(INOUT) :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine reallocate_array3D_logical_d(v,st1,en1,st2,en2,st3,en3)
    integer, intent(IN) :: st1, en1, st2, en2, st3, en3
    logical, allocatable, dimension(:,:,:), intent(INOUT), device :: v
#   define vec_dim 3
#   include "arr_realloc_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                CHARACTER
  subroutine reallocate_array1D_char(v,size) 
    integer, intent(IN) :: size
    character(len=:), allocatable, intent(INOUT) :: v
#   define vec_dim 1
#   include "char_realloc_H.F90"
#   undef vec_dim
  end subroutine
!========================================================================================!

!                     copy 
!========================================================================================!
!---------                REAL(DP)
  subroutine copy_array1D_double(v1,v2) 
    real(double_p), allocatable, dimension(:), intent(OUT) :: v1
    real(double_p), allocatable, dimension(:), intent(IN)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array1D_double_d(v1,v2) 
    real(double_p), allocatable, dimension(:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:), intent(IN), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array2D_double(v1,v2)
    real(double_p), allocatable, dimension(:,:), intent(OUT) :: v1
    real(double_p), allocatable, dimension(:,:), intent(IN)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array2D_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array3D_double(v1,v2)
    real(double_p), allocatable, dimension(:,:,:), intent(OUT)  :: v1
    real(double_p), allocatable, dimension(:,:,:), intent(IN) :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array3D_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array4D_double(v1,v2)
    real(double_p), allocatable, dimension(:,:,:,:), intent(OUT)  :: v1
    real(double_p), allocatable, dimension(:,:,:,:), intent(IN) :: v2
    integer :: st1, en1, st2, en2, st3, en3, st4, en4
#   define vec_dim 4
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array3D_double_d(v1,v2)
    real(double_p), allocatable, dimension(:,:,:,:), intent(OUT), device :: v1
    real(double_p), allocatable, dimension(:,:,:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3, st4 , en4
#   define vec_dim 4
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                INTEGER
  subroutine copy_array1D_integer(v1,v2) 
    integer, allocatable, dimension(:), intent(OUT) :: v1
    integer, allocatable, dimension(:), intent(IN)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array1D_integer_d(v1,v2) 
    integer, allocatable, dimension(:), intent(OUT), device :: v1
    integer, allocatable, dimension(:), intent(IN), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif
  
  subroutine copy_array2D_integer(v1,v2)
    integer, allocatable, dimension(:,:), intent(OUT) :: v1
    integer, allocatable, dimension(:,:), intent(IN)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array2D_integer_d(v1,v2)
    integer, allocatable, dimension(:,:), intent(OUT), device :: v1
    integer, allocatable, dimension(:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array3D_integer(v1,v2)
    integer, allocatable, dimension(:,:,:), intent(OUT) :: v1
    integer, allocatable, dimension(:,:,:), intent(IN)  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array3D_integer_d(v1,v2)
    integer, allocatable, dimension(:,:,:), intent(OUT), device :: v1
    integer, allocatable, dimension(:,:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                LOGICAL
  subroutine copy_array1D_logical(v1,v2)
    logical, allocatable, dimension(:), intent(OUT) :: v1
    logical, allocatable, dimension(:), intent(IN)  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array1D_logical_d(v1,v2)
    logical, allocatable, dimension(:), intent(OUT), device :: v1
    logical, allocatable, dimension(:), intent(IN), device  :: v2
    integer :: st, en
#   define vec_dim 1
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array2D_logical(v1,v2)
    logical, allocatable, dimension(:,:), intent(OUT) :: v1
    logical, allocatable, dimension(:,:), intent(IN)  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array2D_logical_d(v1,v2)
    logical, allocatable, dimension(:,:), intent(OUT), device :: v1
    logical, allocatable, dimension(:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2
#   define vec_dim 2
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

  subroutine copy_array3D_logical(v1,v2)
    logical, allocatable, dimension(:,:,:), intent(OUT) :: v1
    logical, allocatable, dimension(:,:,:), intent(IN)  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#ifdef GPU_RUN
  subroutine copy_array3D_logical_d(v1,v2)
    logical, allocatable, dimension(:,:,:), intent(OUT), device :: v1
    logical, allocatable, dimension(:,:,:), intent(IN), device  :: v2
    integer :: st1, en1, st2, en2, st3, en3
#   define vec_dim 3
#   include "arr_copy_H.F90"
#   undef vec_dim
  end subroutine
#endif

!---------                CHARACTER
  subroutine copy_array1D_char(v1,v2) 
    character(len=:), allocatable, intent(OUT) :: v1
    character(len=:), allocatable, intent(IN)  :: v2
    integer :: size
#   define vec_dim 1
#   include "char_copy_H.F90"
#   undef vec_dim
  end subroutine
!========================================================================================!
  
end module allocate_arrays_mod