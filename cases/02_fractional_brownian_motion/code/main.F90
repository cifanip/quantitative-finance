PROGRAM main
  
  use basic_utils
  use mpi_utils
  use fbm
  
  implicit none
  
  ! ---------------------------------
  type(fbm_type) :: proc
  integer :: ns,nr
  real(double_p) :: tf,h
  character(len=:), allocatable :: fname
  ! ---------------------------------
  
  call init_run()
  
  ns=1000
  nr=1
  tf=1.d0
  h=0.1d0
  
  !file name
  call init_string(fname,"fbm")
  
  call proc%ctor(ns,nr,tf,h)
  
  call proc%compute()
  
  call proc%write_to_disk(fname)
  
  call proc%delete()
  
  call hdf_add_attribute_to_file(fname,"ns",ns)
  call hdf_add_attribute_to_file(fname,"nr",nr)
  call hdf_add_attribute_to_file(fname,"tf",tf)
  call hdf_add_attribute_to_file(fname,"h",h)

  call end_run()

contains
  
END PROGRAM main