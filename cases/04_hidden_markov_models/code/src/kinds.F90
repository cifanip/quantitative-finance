module kinds_mod
  implicit none
	
  !kinds
  integer, parameter :: single_p = KIND(0.e0)
  integer, parameter :: double_p = KIND(0.d0)
	
  !size (bytes)
  integer, parameter :: real_dp_size = STORAGE_SIZE(0.d0)/8
  integer, parameter :: complex_dp_size = 2*real_dp_size
  integer, parameter :: integer_size = STORAGE_SIZE(0)/8
  integer, parameter :: logical_size = STORAGE_SIZE(.TRUE.)/8

end module kinds_mod