PROGRAM main

  use hm_test_mod
  
  IMPLICIT NONE
  
  ! ---------------------------------
  type(hm_test) :: for
  ! ---------------------------------
  
  call init_run()
  
  call for%ctor("none","none")
  call for%run_opt()

  call for%write_vit_seq(write_to_disk=.TRUE.)
  
  call for%write_a()
  call for%write_b()
  
  call for%print_a()
  call for%print_b()

  call end_run()

contains
  
END PROGRAM main
