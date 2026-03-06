module array_utils

  use formats
  use hdf_wrapper

  implicit none
  
  interface array_mean
    module procedure array_mean_1d_integer
    module procedure array_mean_1d_double
    module procedure array_mean_1d_complex_double
    module procedure array_mean_2d_double
  end interface
  
  interface array_norm
    module procedure array_norm_1d_double
    module procedure array_norm_1d_complex_double
    module procedure array_norm_2d_double
  end interface
  
  interface array_std
    module procedure array_std_1d_double
    module procedure array_std_1d_complex_double
    module procedure array_std_2d_double
  end interface
  
  interface array_count_val
    module procedure array_count_val_1d_integer
    module procedure array_count_val_1d_double
    module procedure array_count_val_1d_complex_double
    module procedure array_count_val_1d_logical
  end interface

  interface array_get_closest_loc
    module procedure array_get_closest_loc_1d_double
    module procedure array_get_closest_loc_1d_integer
  end interface
  
  interface array_read_file
    module procedure array_read_file_1d_double
    module procedure array_read_file_1d_integer
  end interface

  interface array_read_binary_file
    module procedure array_read_binary_file_1d_double
    module procedure array_read_binary_file_1d_integer
  end interface
  
  interface array_read_hdf
    module procedure array_read_hdf_1d_double
    module procedure array_read_hdf_1d_integer
    module procedure array_read_hdf_2d_double
    module procedure array_read_hdf_2d_integer
    module procedure array_read_hdf_3d_double
    module procedure array_read_hdf_3d_integer
  end interface
  
  interface array_write_file
    module procedure array_write_file_1d_double
    module procedure array_write_file_1d_integer
  end interface

  interface array_write_binary_file
    module procedure array_write_binary_file_1d_double
    module procedure array_write_binary_file_1d_integer
  end interface
  
  interface array_write_hdf
    module procedure array_write_hdf_1d_double
    module procedure array_write_hdf_1d_integer
    module procedure array_write_hdf_2d_double
    module procedure array_write_hdf_2d_integer
    module procedure array_write_hdf_3d_double
    module procedure array_write_hdf_3d_integer
  end interface
  
  interface array_add_hdf
    module procedure array_add_hdf_1d_double
    module procedure array_add_hdf_1d_integer
    module procedure array_add_hdf_2d_double
    module procedure array_add_hdf_2d_integer
    module procedure array_add_hdf_3d_double
    module procedure array_add_hdf_3d_integer
  end interface

  interface array_is_uniform
    module procedure array_is_uniform_1d_double
    module procedure array_is_uniform_1d_integer
  end interface
  
  interface array_reverse
    module procedure array_reverse_1d_integer
    module procedure array_reverse_1d_double
    module procedure array_reverse_1d_complex
    module procedure array_reverse_1d_logical
  end interface
  
  interface array_reverse_row
    module procedure array_reverse_row_integer
    module procedure array_reverse_row_double
    module procedure array_reverse_row_complex
    module procedure array_reverse_row_logical
  end interface

  interface array_reverse_col
    module procedure array_reverse_col_integer
    module procedure array_reverse_col_double
    module procedure array_reverse_col_complex
    module procedure array_reverse_col_logical
  end interface
  
  interface array_sort_asc
    module procedure array_sort_asc_integer
    module procedure array_sort_asc_double
    module procedure array_sort_loc_asc_integer
    module procedure array_sort_loc_asc_double
  end interface

  interface array_sort_desc
    module procedure array_sort_desc_integer
    module procedure array_sort_desc_double
    module procedure array_sort_loc_desc_integer
    module procedure array_sort_loc_desc_double
  end interface
  
  interface array_sort_loc
    module procedure array_sort_loc_1d_integer
    module procedure array_sort_loc_2d_integer
    module procedure array_sort_loc_1d_double
    module procedure array_sort_loc_2d_double
  end interface
  
  public :: rolling_norm

contains

!                     mean
!========================================================================================!
  pure function array_mean_1d_integer(x) result(y)
    integer, dimension(:), intent(in) :: x
    real(double_p) :: y
#   define vec_dim 1
#   include "array_mean.F90"
#   undef vec_dim
  end function

  pure function array_mean_1d_double(x) result(y)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p) :: y
#   define vec_dim 1
#   include "array_mean.F90"
#   undef vec_dim
  end function

  pure function array_mean_1d_complex_double(x) result(y)
    complex(double_p), dimension(:), intent(in) :: x
    complex(double_p) :: y
#   define vec_dim 1
#   include "array_mean.F90"
#   undef vec_dim
  end function

  pure function array_mean_2d_double(x) result(y)
    real(double_p), dimension(:,:), intent(in) :: x
    real(double_p) :: y
#   define vec_dim 2
#   include "array_mean.F90"
#   undef vec_dim
  end function
!========================================================================================!

!                     norm
!========================================================================================!
  pure function array_norm_1d_double(x) result(y)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p) :: y

    if (size(x)==0) then
      y = 0.d0
      return
    end if
    
    y = norm2(x)

  end function

  pure function array_norm_1d_complex_double(x) result(y)
    complex(double_p), dimension(:), intent(in) :: x
    real(double_p) :: y

    if (size(x)<=0) then
      y = 0.d0
      return
    end if
    
    y = sqrt(sum(x*conjg(x)))
    
  end function

  pure function array_norm_2d_double(x) result(y)
    real(double_p), dimension(:,:), intent(in) :: x
    real(double_p) :: y

    if (size(x)==0) then
      y = 0.d0
      return
    end if
    
    y = norm2(x)

  end function
!========================================================================================!

!                     std
!========================================================================================!
  pure function array_std_1d_double(x) result(y)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p) :: y

    if (size(x)==0) then
      y = 0.d0
      return
    end if
    
    y = array_norm(x-array_mean(x))/sqrt(dble(size(x)))

  end function

  pure function array_std_1d_complex_double(x) result(y)
    complex(double_p), dimension(:), intent(in) :: x
    complex(double_p) :: y

    if (size(x)==0) then
      y = (0.d0,0.d0)
      return
    end if
    
    y = array_norm(x-array_mean(x))/sqrt(dble(size(x)))

  end function

  pure function array_std_2d_double(x) result(y)
    real(double_p), dimension(:,:), intent(in) :: x
    real(double_p) :: y

    if (size(x)==0) then
      y = 0.d0
      return
    end if
    
    y = array_norm(x-array_mean(x))/sqrt(dble(size(x)))

  end function
!========================================================================================!

!                     count_val
!========================================================================================!
  pure function array_count_val_1d_integer(x,val) result(count)
    integer, dimension(:), intent(in) :: x
    integer, intent(in) :: val
    integer :: i,count
#   define vec_dim 1
#   include "array_count_val.F90"
#   undef vec_dim
  end function

  pure function array_count_val_1d_double(x,val) result(count)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p), intent(in) :: val
    integer :: i,count
#   define vec_dim 1
#   include "array_count_val.F90"
#   undef vec_dim
  end function

  pure function array_count_val_1d_complex_double(x,val) result(count)
    complex(double_p), dimension(:), intent(in) :: x
    complex(double_p), intent(in) :: val
    integer :: i,count
#   define vec_dim 1
#   include "array_count_val.F90"
#   undef vec_dim
  end function

  pure function array_count_val_1d_logical(x,val) result(count)
    logical, dimension(:), intent(in) :: x
    logical, intent(in) :: val
    integer :: i,count

    if (size(x)==0) then
      count = 0
      return
    end if
  
    count = 0

    do i=1,size(x)
      if (x(i).eqv.val) then
        count = count + 1
      end if
    end do

  end function
!========================================================================================!

!                     get_closest_loc
!========================================================================================!
  function array_get_closest_loc_1d_double(x,val,lb) result(idx)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p), intent(in) :: val
    integer, intent(in), optional :: lb
    integer :: idx,i0
#   define vec_dim 1
#   include "array_get_closest_loc.F90"
#   undef vec_dim
  end function

  function array_get_closest_loc_1d_integer(x,val,lb) result(idx)
    integer, dimension(:), intent(in) :: x
    integer, intent(in) :: val
    integer, intent(in), optional :: lb
    integer :: idx,i0
#   define vec_dim 1
#   include "array_get_closest_loc.F90"
#   undef vec_dim
  end function
!========================================================================================!

!                     read_file
!========================================================================================!
  subroutine array_read_file_1d_double(x,path_to_file)
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    real(double_p) :: val
    integer :: i,count,reason
    character(len=:), allocatable :: read_format
    
    call allocate_array(read_format,len(s_double_format))
    read_format = s_double_format
#   define vec_dim 1
#   include "array_read_file.F90"
#   undef vec_dim

  end subroutine

  subroutine array_read_file_1d_integer(x,path_to_file)
    integer, allocatable, dimension(:), intent(inout) :: x
    character(len=:), allocatable, intent(in) :: path_to_file
    integer :: val
    integer :: i,count,reason
    character(len=:), allocatable :: read_format
    
    call allocate_array(read_format,len(s_int_format))
    read_format = s_int_format
#   define vec_dim 1
#   include "array_read_file.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     read binary file
!========================================================================================!
  subroutine array_read_binary_file_1d_double(x,path_to_file)
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    integer :: n,reason
    
#   define vec_dim 1
#   include "array_read_binary_file.F90"
#   undef vec_dim

  end subroutine

  subroutine array_read_binary_file_1d_integer(x,path_to_file)
    integer, allocatable, dimension(:), intent(inout) :: x
    character(len=:), allocatable, intent(in) :: path_to_file
    integer :: n,reason
    
#   define vec_dim 1
#   include "array_read_binary_file.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     read_hdf
!========================================================================================!
  subroutine array_read_hdf_1d_double(x,path_to_file,array_name_opt)
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(1) :: dims,max_dims

#   define vec_dim 1
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine
  
  subroutine array_read_hdf_1d_integer(x,path_to_file,array_name_opt)
    integer, allocatable, dimension(:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(1) :: dims,max_dims

#   define vec_dim 1
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine
  
  subroutine array_read_hdf_2d_double(x,path_to_file,array_name_opt)
    real(double_p), allocatable, dimension(:,:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(2) :: dims,max_dims

#   define vec_dim 2
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine
  
  subroutine array_read_hdf_2d_integer(x,path_to_file,array_name_opt)
    integer, allocatable, dimension(:,:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(2) :: dims,max_dims

#   define vec_dim 2
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine

  subroutine array_read_hdf_3d_double(x,path_to_file,array_name_opt)
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(3) :: dims,max_dims

#   define vec_dim 3
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine
  
  subroutine array_read_hdf_3d_integer(x,path_to_file,array_name_opt)
    integer, allocatable, dimension(:,:,:), intent(inout) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id
    integer(hsize_t), dimension(3) :: dims,max_dims

#   define vec_dim 3
#   include "array_read_hdf.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     write_file
!========================================================================================!
  subroutine array_write_file_1d_double(x,path_to_file)
    real(double_p), dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    real(double_p) :: val
    integer :: i,count,reason
    character(len=:), allocatable :: write_format

    call allocate_array(write_format,len(s_double_format))
    write_format = s_double_format
#   define vec_dim 1
#   include "array_write_file.F90"
#   undef vec_dim

  end subroutine

  subroutine array_write_file_1d_integer(x,path_to_file)
    integer, dimension(:), contiguous, intent(in) :: x
    character(len=:), allocatable, intent(in) :: path_to_file
    integer :: i,reason
    character(len=:), allocatable :: write_format

    call allocate_array(write_format,len(s_int_format))
    write_format = s_int_format
#   define vec_dim 1
#   include "array_write_file.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     write binary file
!========================================================================================!
  subroutine array_write_binary_file_1d_double(x,path_to_file)
    real(double_p), dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    integer :: reason

#   define vec_dim 1
#   include "array_write_binary_file.F90"
#   undef vec_dim

  end subroutine

  subroutine array_write_binary_file_1d_integer(x,path_to_file)
    integer, dimension(:), contiguous, intent(in) :: x
    character(len=:), allocatable, intent(in) :: path_to_file
    integer :: reason

#   define vec_dim 1
#   include "array_write_binary_file.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     write_hdf
!========================================================================================!
  subroutine array_write_hdf_1d_double(x,path_to_file,array_name_opt)
    real(double_p), dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_write_hdf_1d_integer(x,path_to_file,array_name_opt)
    integer, dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_write_hdf_2d_double(x,path_to_file,array_name_opt)
    real(double_p), dimension(:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_write_hdf_2d_integer(x,path_to_file,array_name_opt)
    integer, dimension(:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_write_hdf_3d_double(x,path_to_file,array_name_opt)
    real(double_p), dimension(:,:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_write_hdf_3d_integer(x,path_to_file,array_name_opt)
    integer, dimension(:,:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in), optional :: array_name_opt
    character(len=:), allocatable :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "array_write_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine
!========================================================================================!

!                     add_hdf
!========================================================================================!
  subroutine array_add_hdf_1d_double(x,path_to_file,array_name)
    real(double_p), dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_add_hdf_1d_integer(x,path_to_file,array_name)
    integer, dimension(:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_add_hdf_2d_double(x,path_to_file,array_name)
    real(double_p), dimension(:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_add_hdf_2d_integer(x,path_to_file,array_name)
    integer, dimension(:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_add_hdf_3d_double(x,path_to_file,array_name)
    real(double_p), dimension(:,:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine

  subroutine array_add_hdf_3d_integer(x,path_to_file,array_name)
    integer, dimension(:,:,:), contiguous, intent(in) :: x
    character(len=*), intent(in) :: path_to_file
    character(len=*), intent(in) :: array_name
    integer(hid_t) :: file_id,dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_open()
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "array_add_hdf.F90"
#   undef vec_dim
    call hdf_tclose(data_type)
    call hdf_close()

  end subroutine
!========================================================================================!

!                     is_uniform
!========================================================================================!
  function array_is_uniform_1d_double(x) result(r)
    real(double_p), dimension(:), intent(in) :: x
    logical :: r
    integer :: i

#   define vec_dim 1
#   include "array_is_uniform.F90"
#   undef vec_dim

  end function

  function array_is_uniform_1d_integer(x) result(r)
    integer, dimension(:), intent(in) :: x
    logical :: r
    integer :: i

#   define vec_dim 1
#   include "array_is_uniform.F90"
#   undef vec_dim

  end function
!========================================================================================!

!                     reverse
!========================================================================================!
  subroutine array_reverse_1d_integer(x)
    integer, dimension(:), intent(inout) :: x
    integer :: tmp
    integer :: i,n,ih

#   define vec_dim 1
#   include "array_reverse.F90"
#   undef vec_dim

  end subroutine

  subroutine array_reverse_1d_double(x)
    real(double_p), dimension(:), intent(inout) :: x
    real(double_p) :: tmp
    integer :: i,n,ih

#   define vec_dim 1
#   include "array_reverse.F90"
#   undef vec_dim

  end subroutine

  subroutine array_reverse_1d_complex(x)
    complex(double_p), dimension(:), intent(inout) :: x
    complex(double_p) :: tmp
    integer :: i,n,ih

#   define vec_dim 1
#   include "array_reverse.F90"
#   undef vec_dim

  end subroutine

  subroutine array_reverse_1d_logical(x)
    logical, dimension(:), intent(inout) :: x
    logical :: tmp
    integer :: i,n,ih

#   define vec_dim 1
#   include "array_reverse.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     reverse row
!========================================================================================!
  subroutine array_reverse_row_integer(x)
    integer, dimension(:,:), intent(inout) :: x
    integer, allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_row.F90"

  end subroutine

  subroutine array_reverse_row_double(x)
    real(double_p), dimension(:,:), intent(inout) :: x
    real(double_p), allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_row.F90"

  end subroutine

  subroutine array_reverse_row_complex(x)
    complex(double_p), dimension(:,:), intent(inout) :: x
    complex(double_p), allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_row.F90"

  end subroutine

  subroutine array_reverse_row_logical(x)
    logical, dimension(:,:), intent(inout) :: x
    logical, allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_row.F90"

  end subroutine
!========================================================================================!

!                     reverse col
!========================================================================================!
  subroutine array_reverse_col_integer(x)
    integer, dimension(:,:), intent(inout) :: x
    integer, allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_col.F90"

  end subroutine

  subroutine array_reverse_col_double(x)
    real(double_p), dimension(:,:), intent(inout) :: x
    real(double_p), allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_col.F90"

  end subroutine

  subroutine array_reverse_col_complex(x)
    complex(double_p), dimension(:,:), intent(inout) :: x
    complex(double_p), allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_col.F90"

  end subroutine

  subroutine array_reverse_col_logical(x)
    logical, dimension(:,:), intent(inout) :: x
    logical, allocatable, dimension(:) :: tmp
    integer :: i,n,ih

#   include "array_reverse_col.F90"

  end subroutine
!========================================================================================!

!                     sort ascending
!========================================================================================!
  subroutine array_sort_asc_integer(x)
    integer, dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_asc.F90"

  end subroutine
  
  subroutine array_sort_asc_double(x)
    real(double_p), dimension(:), intent(inout) :: x
    real(double_p), allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_asc.F90"

  end subroutine
!========================================================================================!

!                     sort descending
!========================================================================================!
  subroutine array_sort_desc_integer(x)
    integer, dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_desc.F90"

  end subroutine
  
  subroutine array_sort_desc_double(x)
    real(double_p), dimension(:), intent(inout) :: x
    real(double_p), allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_desc.F90"

  end subroutine
!========================================================================================!

!                     sort ascending (returns also locations)
!========================================================================================!
  subroutine array_sort_loc_asc_integer(x,loc)
    integer, dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:), intent(inout) :: loc
    integer, allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_loc_asc.F90"

  end subroutine
  
  subroutine array_sort_loc_asc_double(x,loc)
    real(double_p), dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:), intent(inout) :: loc
    real(double_p), allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_loc_asc.F90"

  end subroutine
!========================================================================================!

!                     sort ascending (returns also locations)
!========================================================================================!
  subroutine array_sort_loc_desc_integer(x,loc)
    integer, dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:), intent(inout) :: loc
    integer, allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_loc_desc.F90"

  end subroutine
  
  subroutine array_sort_loc_desc_double(x,loc)
    real(double_p), dimension(:), intent(inout) :: x
    integer, allocatable, dimension(:), intent(inout) :: loc
    real(double_p), allocatable, dimension(:) :: tmp
    logical, allocatable, dimension(:) :: msk
    integer :: i,n

#   include "array_sort_loc_desc.F90"

  end subroutine
!========================================================================================!

!                     sort based on loc
!========================================================================================!
  subroutine array_sort_loc_1d_integer(x,loc)
    integer, dimension(:), intent(inout) :: x
    integer, dimension(:), intent(in) :: loc
    integer, allocatable, dimension(:) :: tmp
    integer :: i,n
    
#   define vec_dim 1
#   include "array_sort_loc.F90"
#   undef vec_dim

  end subroutine

  subroutine array_sort_loc_2d_integer(x,loc)
    integer, dimension(:,:), intent(inout) :: x
    integer, dimension(:), intent(in) :: loc
    integer, allocatable, dimension(:,:) :: tmp
    integer :: i,n1,n2
    
#   define vec_dim 2
#   include "array_sort_loc.F90"
#   undef vec_dim

  end subroutine

  subroutine array_sort_loc_1d_double(x,loc)
    real(double_p), dimension(:), intent(inout) :: x
    integer, dimension(:), intent(in) :: loc
    real(double_p), allocatable, dimension(:) :: tmp
    integer :: i,n

#   define vec_dim 1
#   include "array_sort_loc.F90"
#   undef vec_dim

  end subroutine
  
  subroutine array_sort_loc_2d_double(x,loc)
    real(double_p), dimension(:,:), intent(inout) :: x
    integer, dimension(:), intent(in) :: loc
    real(double_p), allocatable, dimension(:,:) :: tmp
    integer :: i,n1,n2
    
#   define vec_dim 2
#   include "array_sort_loc.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!                     sort based on loc
!========================================================================================!
  subroutine rolling_norm(x,s)
    real(double_p), dimension(:), intent(in) :: x
    real(double_p), dimension(:), intent(inout) :: s
    integer :: i,n
    
    n = size(x)
    
    if (n==0) then
      call mpi_abort_run("size(x)=0 at rolling_norm")
    end if
    
    if (size(s).ne.n) then
      call mpi_abort_run("size(s).ne.n at rolling_norm")
    end if
    
    s(1)=x(1)*x(1)
    do i=2,n
      s(i)=s(i-1)+x(i)*x(i)
    end do
    
    do i=1,n
      s(i)=sqrt(s(i)/dble(i))
    end do

  end subroutine
!========================================================================================!

  
end module array_utils