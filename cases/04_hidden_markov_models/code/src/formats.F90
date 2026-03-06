module formats_mod
  
  implicit none

  integer, parameter :: s_io_unit = 50
  character(len=4), parameter  :: s_int_format = '(I6)'
  character(len=3), parameter  :: s_char_format = '(A)'
  character(len=4), parameter  :: s_logical_format = '(L7)'
  character(len=11), parameter :: s_double_format = '(ES25.15E3)'
  character(len=10), parameter :: s_output_format = '(ES11.4E2)'
  
end module formats_mod