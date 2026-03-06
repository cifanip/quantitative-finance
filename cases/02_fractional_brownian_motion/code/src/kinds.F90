module kinds
  implicit none
	
  !kinds
  integer, parameter :: single_p = kind(0.e0)
  integer, parameter :: double_p = kind(0.d0)
	
  !size (bytes)
  integer, parameter :: real_dp_size = storage_size(0.d0)/8
  integer, parameter :: complex_dp_size = 2*real_dp_size
  integer, parameter :: integer_size = storage_size(0)/8
  integer, parameter :: logical_size = storage_size(.true.)/8

end module kinds