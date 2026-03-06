module hm_test_mod

  use HM_gen_mod
  
  implicit none
      
  type, extends(HM_gen), public :: hm_test
    private
    
  contains
    private
    
    procedure, public :: delete
    procedure, public :: ctor
    
    procedure, public :: init_model,&
                         write_vit_seq
    
  end type

  private :: ctor,&
             delete,&
             init_model,&
             write_vit_seq

contains

!========================================================================================!
  subroutine delete(this)
    class(hm_test), intent(inout) :: this

    call this%delete_HM_gen()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine ctor(this,lab,samp_int)
    class(hm_test), intent(inout) :: this
    character(len=*), intent(in) :: lab,samp_int
    
    call this%initialize_HM_gen()
    
    call this%init_model()
    
    call this%set_initial_probs()

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine init_model(this)
    class(hm_test), intent(inout) :: this
    integer, allocatable, dimension(:) :: aux
    integer :: i
    
    this%n   = 2
    this%m   = 4

    open(unit=s_io_unit, file="O.txt", status="old")
    read(s_io_unit,s_int_format) this%tau
    call allocate_array(aux,1,this%tau)
    do i=1,this%tau
      read(s_io_unit,s_int_format) aux(i)
    end do
    close(s_io_unit)
    
    !ini HM model array
    call this%allocate_arrays()
    
    this%o = aux

  end subroutine
!========================================================================================!

!========================================================================================!
  subroutine write_vit_seq(this,write_to_disk)
    class(hm_test), intent(inout) :: this
    logical, intent(in), optional :: write_to_disk
    character(len=:), allocatable :: fname
    integer :: i
    
    call this%seq_viterbi()
    
    if (present(write_to_disk)) then
      if (write_to_disk) then
        !print out sequence
        fname=this%dir//'seq_vit'
        open(UNIT=s_io_unit,FILE=fname,STATUS='replace',ACTION='write')
          do i=1,this%tau
            write(s_io_unit,s_int_format) this%vseq(i)
          end do
        close(s_io_unit)
      end if
    end if
    
  end subroutine
!========================================================================================!

end module hm_test_mod