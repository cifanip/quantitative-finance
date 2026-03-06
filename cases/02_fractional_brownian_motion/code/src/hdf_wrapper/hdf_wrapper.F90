module hdf_wrapper
  
  use allocatable_utils
  use vector_string
  use hdf5
  
  implicit none
  
  integer(hid_t) :: hdf_dtype_integer
  integer(hid_t) :: hdf_dtype_double
  integer(hid_t) :: hdf_dtype_character
  
  ! hdf interface
  public :: hdf_open,&
            hdf_close
            
  ! hdf types
  public :: hdf_tcopy,&
            hdf_tclose
  
  ! hdf file
  public :: hdf_fcreate,&
            hdf_fclose,&
            hdf_fopen_rdonly,&
            hdf_fopen_rdwr
            
  ! hdf group
  public :: hdf_gopen,&
            hdf_gcreate,&
            hdf_gclose,&
            hdf_count_gmembers,&
            hdf_get_gobj_info
      
  ! hdf dataset
  public :: hdf_screate_simple,&
            hdf_dopen,&
            hdf_dcreate,&
            hdf_dclose,&
            hdf_sclose,&
            hdf_dget_space,&
            hdf_sget_simple_extent_dims_1d,&
            hdf_sget_simple_extent_dims_2d,&
            hdf_sget_simple_extent_dims_3d

  interface hdf_dwrite
    module procedure hdf_dwrite_1d_double
    module procedure hdf_dwrite_1d_integer
    module procedure hdf_dwrite_2d_double
    module procedure hdf_dwrite_2d_integer
    module procedure hdf_dwrite_3d_double
    module procedure hdf_dwrite_3d_integer
  end interface
  
  interface hdf_dread
    module procedure hdf_dread_1d_double
    module procedure hdf_dread_1d_integer
    module procedure hdf_dread_2d_double
    module procedure hdf_dread_2d_integer
    module procedure hdf_dread_3d_double
    module procedure hdf_dread_3d_integer
  end interface

  ! hdf attributes
  public :: hdf_aopen,&
            hdf_acreate,&
            hdf_aclose,&
            hdf_aget_space
            
  interface hdf_aread
    module procedure hdf_aread_double
    module procedure hdf_aread_integer
    module procedure hdf_aread_string
  end interface

  interface hdf_awrite
    module procedure hdf_awrite_double
    module procedure hdf_awrite_integer
    module procedure hdf_awrite_string
  end interface
  
  ! higher-level subroutines
  interface hdf_read_array
    module procedure hdf_read_array_1d_double
    module procedure hdf_read_array_1d_integer
    module procedure hdf_read_array_2d_double
    module procedure hdf_read_array_2d_integer
    module procedure hdf_read_array_3d_double
    module procedure hdf_read_array_3d_integer
  end interface
  
  interface hdf_write_array
    module procedure hdf_write_array_1d_double
    module procedure hdf_write_array_1d_integer
    module procedure hdf_write_array_2d_double
    module procedure hdf_write_array_2d_integer
    module procedure hdf_write_array_3d_double
    module procedure hdf_write_array_3d_integer
  end interface

  interface hdf_add_array
    module procedure hdf_add_array_1d_double
    module procedure hdf_add_array_1d_integer
    module procedure hdf_add_array_2d_double
    module procedure hdf_add_array_2d_integer
    module procedure hdf_add_array_3d_double
    module procedure hdf_add_array_3d_integer
  end interface

  interface hdf_read_attribute
    module procedure hdf_read_attribute_double
    module procedure hdf_read_attribute_integer
    module procedure hdf_read_attribute_string
  end interface

  interface hdf_write_attribute
    module procedure hdf_write_attribute_double
    module procedure hdf_write_attribute_integer
    module procedure hdf_write_attribute_string
    module procedure hdf_write_attribute_logical
  end interface
  
  interface hdf_add_attribute_to_file
    module procedure hdf_add_attribute_to_file_double
    module procedure hdf_add_attribute_to_file_integer
  end interface

  interface hdf_read_attribute_from_file
    module procedure hdf_read_attribute_from_file_double
    module procedure hdf_read_attribute_from_file_integer
  end interface
  
  interface hdf_get_keys
    module procedure hdf_get_keys_from_file
    module procedure hdf_get_keys_from_loc
  end interface

contains

!--------->                interface
!========================================================================================!
  subroutine hdf_open()
    integer :: err

    call h5open_f(err)

    if (err.lt.0) then
      call mpi_abort_run("h5open_f failed")
    end if

    ! set basic datatypes
    call hdf_tcopy(h5t_native_double,hdf_dtype_double)
    call hdf_tcopy(h5t_native_integer,hdf_dtype_integer)
    call hdf_tcopy(h5t_native_character,hdf_dtype_character)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_close()
    integer :: err

    call h5close_f(err)

    if (err.lt.0) then
      call mpi_abort_run("h5close_f failed")
    end if

    call hdf_tclose(hdf_dtype_double)
    call hdf_tclose(hdf_dtype_integer)
    call hdf_tclose(hdf_dtype_character)

  end subroutine
!========================================================================================!

!--------->                types
!========================================================================================!
  subroutine hdf_tcopy(type_id,new_type_id)
    integer(hid_t), intent(in) :: type_id
    integer(hid_t), intent(out) :: new_type_id
    integer :: err
    
    call h5tcopy_f(type_id,new_type_id,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5tcopy_f failed")
    end if    

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_tclose(type_id)
    integer(hid_t), intent(in) :: type_id
    integer :: err
    
    call h5tclose_f(type_id,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5tclose_f failed")
    end if    

  end subroutine
!========================================================================================!

!--------->                file
!========================================================================================!
  subroutine hdf_fcreate(path_to_file,file_id)
    character(len=*), intent(in) :: path_to_file
    integer(hid_t), intent(out) :: file_id
    integer :: err

    call h5fcreate_f(path_to_file,h5f_acc_trunc_f,file_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5fcreate_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_fopen_rdonly(path_to_file,file_id)
    character(len=*), intent(in) :: path_to_file
    integer(hid_t), intent(out) :: file_id
    integer :: err

    call h5fopen_f(path_to_file,h5f_acc_rdonly_f,file_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5fopen_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_fopen_rdwr(path_to_file,file_id)
    character(len=*), intent(in) :: path_to_file
    integer(hid_t), intent(out) :: file_id
    integer :: err

    call h5fopen_f(path_to_file,h5f_acc_rdwr_f,file_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5fopen_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_fclose(file_id)
    integer(hid_t), intent(in) :: file_id
    integer :: err

    call h5fclose_f(file_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5fclose_f failed")
    end if

  end subroutine
!========================================================================================!

!--------->                group
!========================================================================================!
  subroutine hdf_gopen(file_id,grp_path,grp_id)
    integer(hid_t), intent(in) :: file_id
    character(len=*), intent(in) :: grp_path
    integer(hid_t), intent(out) :: grp_id
    integer :: err
    
    call h5gopen_f(file_id,grp_path,grp_id,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5gopen_f failed")
    end if   

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_gcreate(file_id,g_path,g_id)
    integer(hid_t), intent(in) :: file_id
    character(len=*), intent(in) :: g_path
    integer(hid_t), intent(out) :: g_id
    integer :: err
    
    call h5gcreate_f(file_id,g_path,g_id,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5gcreate_f failed")
    end if   

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_gclose(grp_id)
    integer(hid_t), intent(in) :: grp_id
    integer :: err
    
    call h5gclose_f(grp_id,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5gclose_f failed")
    end if   

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_count_gmembers(grp_id,grp_name,nmembers)
    integer(hid_t), intent(in) :: grp_id
    character(len=*), intent(in) :: grp_name
    integer, intent(out) :: nmembers
    integer :: hdferr
    
    call h5gn_members_f(grp_id,grp_name,nmembers,hdferr)
    
    if (hdferr.lt.0) then
      call mpi_abort_run("h5gn_members_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_get_gobj_info(grp_id,grp_name,member_index,obj_name,obj_type)
    integer(hid_t), intent(in) :: grp_id
    character(len=*), intent(in) :: grp_name
    integer, intent(in) :: member_index
    character(len=*), intent(out) :: obj_name
    integer, intent(out) :: obj_type
    integer :: hdferr
    
    call h5gget_obj_info_idx_f(grp_id,grp_name,member_index,obj_name,obj_type,hdferr)
    
    if (hdferr.lt.0) then
      call mpi_abort_run("h5gget_obj_info_idx_f failed")
    end if

  end subroutine
!========================================================================================!

!--------->                dataset
!========================================================================================!
  subroutine hdf_screate_simple(rank,dims,dspace_id)
    integer, intent(in) :: rank
    integer(hsize_t), dimension(:), intent(in) :: dims
    integer(hid_t), intent(out) :: dspace_id
    integer :: err

    call h5screate_simple_f(rank,dims,dspace_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5screate_simple_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dopen(obj_id,dname,dset_id)
    integer(hid_t), intent(in) :: obj_id
    character(len=*), intent(in) :: dname
    integer(hid_t), intent(out) :: dset_id
    integer :: err
    
    call h5dopen_f(obj_id,dname,dset_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5dopen_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dcreate(obj_id,dname,data_type,dspace_id,dset_id)
    integer(hid_t), intent(in) :: obj_id
    character(len=*), intent(in) :: dname
    integer(hid_t), intent(in) :: data_type,dspace_id
    integer(hid_t), intent(out) :: dset_id
    integer :: err

    call h5dcreate_f(obj_id,dname,data_type,dspace_id,dset_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5dcreate_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dwrite_1d_double(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), dimension(:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(1) :: dims
    integer(hid_t) :: data_type
    integer :: err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dwrite_1d_integer(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    integer, dimension(:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(1) :: dims
    integer(hid_t) :: data_type
    integer :: err
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dwrite_2d_double(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), dimension(:,:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(2) :: dims
    integer(hid_t) :: data_type
    integer :: err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dwrite_2d_integer(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    integer, dimension(:,:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(2) :: dims
    integer(hid_t) :: data_type
    integer :: err

    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dwrite_3d_double(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), dimension(:,:,:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(3) :: dims
    integer(hid_t) :: data_type
    integer :: err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dwrite_3d_integer(dset_id,x)
    integer(hid_t), intent(in) :: dset_id
    integer, dimension(:,:,:), contiguous, intent(in) :: x
    integer(hsize_t), dimension(3) :: dims
    integer(hid_t) :: data_type
    integer :: err

    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "hdf_dwrite.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dget_space(dset_id,dspace_id)
    integer(hid_t), intent(in) :: dset_id
    integer(hid_t), intent(out) :: dspace_id
    integer :: err
    
    call h5dget_space_f(dset_id,dspace_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5dget_space_f failed")
    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_sget_simple_extent_dims_1d(dspace_id,dims,max_dims)
    integer(hid_t), intent(in) :: dspace_id
    integer(hsize_t), dimension(1), intent(out) :: dims,max_dims
    integer :: err
    
    call h5sget_simple_extent_dims_f(dspace_id,dims,max_dims,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5sget_simple_extent_dims_f failed")
    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_sget_simple_extent_dims_2d(dspace_id,dims,max_dims)
    integer(hid_t), intent(in) :: dspace_id
    integer(hsize_t), dimension(2), intent(out) :: dims,max_dims
    integer :: err
    
    call h5sget_simple_extent_dims_f(dspace_id,dims,max_dims,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5sget_simple_extent_dims_f failed")
    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_sget_simple_extent_dims_3d(dspace_id,dims,max_dims)
    integer(hid_t), intent(in) :: dspace_id
    integer(hsize_t), dimension(3), intent(out) :: dims,max_dims
    integer :: err
    
    call h5sget_simple_extent_dims_f(dspace_id,dims,max_dims,err)
    
    if (err.lt.0) then
      call mpi_abort_run("h5sget_simple_extent_dims_f failed")
    end if
    
  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dread_1d_double(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    integer(hsize_t), dimension(1), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n,err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
  
  subroutine hdf_dread_1d_integer(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    integer, allocatable, dimension(:), intent(inout) :: x
    integer(hsize_t), dimension(1), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n,err
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_dread_2d_double(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), allocatable, dimension(:,:), intent(inout) :: x
    integer(hsize_t), dimension(2), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n1,n2,err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
  
  subroutine hdf_dread_2d_integer(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    integer, allocatable, dimension(:,:), intent(inout) :: x
    integer(hsize_t), dimension(2), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n1,n2,err
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
  
  subroutine hdf_dread_3d_double(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: x
    integer(hsize_t), dimension(3), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n1,n2,n3,err
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
  
  subroutine hdf_dread_3d_integer(dset_id,x,dims)
    integer(hid_t), intent(in) :: dset_id
    integer, allocatable, dimension(:,:,:), intent(inout) :: x
    integer(hsize_t), dimension(3), intent(in) :: dims
    integer(hid_t) :: data_type
    integer :: n1,n2,n3,err
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "hdf_dread.F90"
#   undef vec_dim
    call hdf_tclose(data_type)    

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_dclose(dset_id)
    integer(hid_t), intent(in) :: dset_id
    integer :: err

    call h5dclose_f(dset_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5dclose_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_sclose(dspace_id)
    integer(hid_t), intent(in) :: dspace_id
    integer :: err

    call h5sclose_f(dspace_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5sclose_f failed")
    end if

  end subroutine
!========================================================================================!

!--------->                attributes
!========================================================================================!
  subroutine hdf_aopen(obj_id,a_name,a_id)
    integer(hid_t), intent(in) :: obj_id
    character(len=*), intent(in) :: a_name
    integer(hid_t), intent(out) :: a_id
    integer :: err
    
    call h5aopen_f(obj_id,a_name,a_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aopen_f failed")
    end if    

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_acreate(obj_id,a_name,data_type,space_id,a_id)
    integer(hid_t), intent(in) :: obj_id
    character(len=*), intent(in) :: a_name
    integer(hid_t), intent(in) :: data_type,space_id
    integer(hid_t), intent(out) :: a_id
    integer :: err
    
    call h5acreate_f(obj_id,a_name,data_type,space_id,a_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5acreate_f failed")
    end if

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_aread_double(a_id,x)
    integer(hid_t), intent(in) :: a_id
    real(double_p), intent(out) :: x
    integer(hsize_t), dimension(1) :: dims
    integer :: err
    
    dims=1
    
    call h5aread_f(a_id,hdf_dtype_double,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aread_f failed")
    end if    

  end subroutine

  subroutine hdf_aread_integer(a_id,x)
    integer(hid_t), intent(in) :: a_id
    integer, intent(out) :: x
    integer(hsize_t), dimension(1) :: dims
    integer :: err
    
    dims=1
    
    call h5aread_f(a_id,hdf_dtype_integer,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aread_f failed")
    end if    

  end subroutine

  subroutine hdf_aread_string(a_id,x)
    integer(hid_t), intent(in) :: a_id
    character(len=:), allocatable, intent(out) :: x
    integer(hid_t) :: space_id
    integer(hsize_t), dimension(1) :: dims,max_dims
    integer :: n,err
    
    call hdf_aget_space(a_id,space_id)

    call hdf_sget_simple_extent_dims_1d(space_id,dims,max_dims)
    
    n = dims(1)
    
    call allocate_array(x,n)

    call h5aread_f(a_id,hdf_dtype_character,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aread_f failed")
    end if    

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_awrite_double(a_id,x)
    integer(hid_t), intent(in) :: a_id
    real(double_p), intent(in) :: x
    integer(hsize_t), dimension(1) :: dims
    integer :: err
    
    dims=1
    
    call h5awrite_f(a_id,hdf_dtype_double,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5awrite_f failed")
    end if    

  end subroutine

  subroutine hdf_awrite_integer(a_id,x)
    integer(hid_t), intent(in) :: a_id
    integer, intent(in) :: x
    integer(hsize_t), dimension(1) :: dims
    integer :: err
    
    dims=1
    
    call h5awrite_f(a_id,hdf_dtype_integer,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5awrite_f failed")
    end if    

  end subroutine

  subroutine hdf_awrite_string(a_id,x)
    integer(hid_t), intent(in) :: a_id
    character(len=*), intent(in) :: x
    integer(hsize_t), dimension(1) :: dims
    integer :: err
    
    dims=len(x)
    
    call h5awrite_f(a_id,hdf_dtype_character,x,dims,err)

    if (err.lt.0) then
      call mpi_abort_run("h5awrite_f failed")
    end if    

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_aclose(a_id)
    integer(hid_t), intent(in) :: a_id
    integer :: err
    
    call h5aclose_f(a_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aclose_f failed")
    end if     

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_aget_space(a_id,space_id)
    integer(hid_t), intent(in) :: a_id
    integer(hid_t), intent(out) :: space_id
    integer :: err
    
    call h5aget_space_f(a_id,space_id,err)

    if (err.lt.0) then
      call mpi_abort_run("h5aget_space_f failed")
    end if

  end subroutine
!========================================================================================!

!--------->                higher-level subroutines 
!========================================================================================!
  subroutine hdf_read_array_1d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), allocatable, dimension(:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(1) :: dims,max_dims

#   define vec_dim 1   
#   include "hdf_read_array.F90"
#   undef vec_dim

  end subroutine

  subroutine hdf_read_array_1d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, allocatable, dimension(:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(1) :: dims,max_dims

#   define vec_dim 1  
#   include "hdf_read_array.F90"
#   undef vec_dim
    
  end subroutine

  subroutine hdf_read_array_2d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), allocatable, dimension(:,:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(2) :: dims,max_dims

#   define vec_dim 2
#   include "hdf_read_array.F90"
#   undef vec_dim

  end subroutine

  subroutine hdf_read_array_2d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, allocatable, dimension(:,:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(2) :: dims,max_dims

#   define vec_dim 2  
#   include "hdf_read_array.F90"
#   undef vec_dim

  end subroutine

  subroutine hdf_read_array_3d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), allocatable, dimension(:,:,:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(3) :: dims,max_dims

#   define vec_dim 3
#   include "hdf_read_array.F90"
#   undef vec_dim

  end subroutine

  subroutine hdf_read_array_3d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, allocatable, dimension(:,:,:), intent(inout) :: x
    integer(hid_t) :: dset_id,dspace_id
    integer(hsize_t), dimension(3) :: dims,max_dims

#   define vec_dim 3
#   include "hdf_read_array.F90"
#   undef vec_dim

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_write_array_1d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_array_1d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_array_2d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_array_2d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_array_3d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:,:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_array_3d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:,:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "hdf_write_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_add_array_1d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 1
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_add_array_1d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 1
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_add_array_2d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 2
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_add_array_2d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(2) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 2
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_add_array_3d_double(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    real(double_p), dimension(:,:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   define vec_dim 3
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_add_array_3d_integer(loc_id,array_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: array_name
    integer, dimension(:,:,:), contiguous, intent(in) :: x
    integer(hid_t) :: dset_id,dspace_id,data_type
    integer(hsize_t), dimension(3) :: dims
    integer :: rank
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   define vec_dim 3
#   include "hdf_add_array.F90"
#   undef vec_dim
    call hdf_tclose(data_type)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_read_attribute_double(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    real(double_p), intent(out) :: x
    integer(hid_t) :: a_id
    
    call hdf_aopen(loc_id,a_name,a_id)
    
    call hdf_aread(a_id,x)
    
    call hdf_aclose(a_id)

  end subroutine

  subroutine hdf_read_attribute_integer(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    integer, intent(out) :: x
    integer(hid_t) :: a_id
    
    call hdf_aopen(loc_id,a_name,a_id)
    
    call hdf_aread(a_id,x)
    
    call hdf_aclose(a_id)

  end subroutine

  subroutine hdf_read_attribute_string(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    character(len=:), allocatable, intent(out) :: x
    integer(hid_t) :: a_id
    
    call hdf_aopen(loc_id,a_name,a_id)
    
    call hdf_aread(a_id,x)
    
    call hdf_aclose(a_id)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_write_attribute_double(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    real(double_p), intent(in) :: x
    integer(hid_t) :: space_id,a_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    rank = 1
    dims(1) = 1
    
    call hdf_tcopy(hdf_dtype_double,data_type)
#   include "hdf_write_attribute.F90"
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_attribute_integer(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    integer, intent(in) :: x
    integer(hid_t) :: space_id,a_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    rank = 1
    dims(1) = 1
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   include "hdf_write_attribute.F90"
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_attribute_string(loc_id,a_name,x)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    character(len=*), intent(in) :: x
    integer(hid_t) :: space_id,a_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank
    
    rank = 1
    dims(1) = len(x)
    
    call hdf_tcopy(hdf_dtype_character,data_type)
#   include "hdf_write_attribute.F90"
    call hdf_tclose(data_type)

  end subroutine

  subroutine hdf_write_attribute_logical(loc_id,a_name,x_bool)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: a_name
    logical, intent(in) :: x_bool
    integer(hid_t) :: space_id,a_id,data_type
    integer(hsize_t), dimension(1) :: dims
    integer :: rank,x
    
    rank = 1
    dims(1) = 1
    
    if (x_bool) then
      x=1
    else
      x=0
    end if
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
#   include "hdf_write_attribute.F90"
    call hdf_tclose(data_type)

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_add_attribute_to_file_double(file_path,a_name,x)
    character(len=*), intent(in) :: file_path,a_name
    real(double_p), intent(in) :: x
    integer(hid_t) :: file_id,data_type
    
    call hdf_open()
    
    call hdf_tcopy(hdf_dtype_double,data_type)
    
    call hdf_fopen_rdwr(file_path,file_id)
    
    call hdf_write_attribute(file_id,a_name,x)
    
    call hdf_fclose(file_id)
    
    call hdf_tclose(data_type)
    
    call hdf_close()

  end subroutine
  
  subroutine hdf_add_attribute_to_file_integer(file_path,a_name,x)
    character(len=*), intent(in) :: file_path,a_name
    integer, intent(in) :: x
    integer(hid_t) :: file_id,data_type
    
    call hdf_open()
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
    
    call hdf_fopen_rdwr(file_path,file_id)
    
    call hdf_write_attribute(file_id,a_name,x)
    
    call hdf_fclose(file_id)
    
    call hdf_tclose(data_type)
    
    call hdf_close()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_read_attribute_from_file_double(file_path,a_name,x)
    character(len=*), intent(in) :: file_path,a_name
    real(double_p), intent(out) :: x
    integer(hid_t) :: file_id,data_type
    
    call hdf_open()
    
    call hdf_tcopy(hdf_dtype_double,data_type)
    
    call hdf_fopen_rdonly(file_path,file_id)
    
    call hdf_read_attribute(file_id,a_name,x)
    
    call hdf_fclose(file_id)
    
    call hdf_tclose(data_type)
    
    call hdf_close()

  end subroutine
  
  subroutine hdf_read_attribute_from_file_integer(file_path,a_name,x)
    character(len=*), intent(in) :: file_path,a_name
    integer, intent(out) :: x
    integer(hid_t) :: file_id,data_type
    
    call hdf_open()
    
    call hdf_tcopy(hdf_dtype_integer,data_type)
    
    call hdf_fopen_rdonly(file_path,file_id)
    
    call hdf_read_attribute(file_id,a_name,x)
    
    call hdf_fclose(file_id)
    
    call hdf_tclose(data_type)
    
    call hdf_close()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_get_keys_from_file(file_path,grp_name,keys)
    character(len=*), intent(in) :: file_path,grp_name
    type(vector_string_type), intent(out) :: keys
    integer(hid_t) :: file_id
    
    call hdf_open()
    
    call hdf_fopen_rdonly(file_path,file_id)
    
    call hdf_get_keys_from_loc(file_id,grp_name,keys)

    call hdf_fclose(file_id)
    
    call hdf_close()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine hdf_get_keys_from_loc(loc_id,grp_name,keys)
    integer(hid_t), intent(in) :: loc_id
    character(len=*), intent(in) :: grp_name
    type(vector_string_type), intent(out) :: keys
    integer :: i,nmembers,obj_type
    character(len=:), allocatable :: obj_name
    
    call allocate_array(obj_name,20)
    
    call hdf_count_gmembers(loc_id,grp_name,nmembers)
    
    do i=0,nmembers-1
      call hdf_get_gobj_info(loc_id,grp_name,i,obj_name,obj_type)
      call keys%append(trim(obj_name))
    end do

  end subroutine
!========================================================================================!

end module hdf_wrapper