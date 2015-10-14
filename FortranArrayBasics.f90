! // Author: Kevin D. O'Mara //
! Version: 1.0.0
! Date of Last Change: 10/14/15

!This document should help you learn the basics and intermediate Fortran array syntax.

! Each subroutine contains an example showcasing a specific aspect of arrays.

program FortranArrayBasics

	call arrayBasics()
	call twoDimensionalArrays()
	call allocatableArrays()
	call bonusStuff()

end program FortranArrayBasics


subroutine arrayBasics()
	implicit none

    !// ignore me //
    integer :: i
    !// ignore me //

    !Two ways to declare an array:
    integer :: myArray(5) !this is an array of integers, it holds *5* values
    integer, dimension(5) :: myOtherArray !same as "myArray"

    !Bonus:
    integer, dimension(5) :: anArray1, anArray2, anArray3 !this makes three arrays, each holding 5 values
    integer :: thatArray1(5), thatArray2(15), thatArray(2) !these three arrays each have different sizes

    print '(/,A)', "Example 1"

! initializing an array
    ! to zero:
    myArray = 0  !ALL values are set to 0 in the array (i.e. each element)

    ! with individual values
    thatArray(1) = -2 !this is how you access individual elements
    thatArray(2) = 7

    ! in a loop (part A)
    do i = 1, 5
        myOtherArray(i) = i
    end do

! print out arrays
    ! individual elements
    print *, "Printing individual elements:"
    print '(A,I1)', "thatArray(1) = ", myArray(1)
    print '(A,I1)', "thatArray(2) = ", myArray(2)

    ! the whole array
    print *, "Printing an entire array:"
    do i = 1, 5
        print '(A,I1,A,I1)', "myOtherArray(", i, ") = ", myOtherArray(i)
    end do
    
return; end subroutine arrayBasics



subroutine twoDimensionalArrays()
    implicit none

    !// ignore me //
    integer :: i, j
    !// ignore me //

    ! let's make some 2d arrays, i.e. matrices
    integer :: matrixOne(5,5) ! this is a 5 by 5 matrix.  The first index is rows, second is columns
    integer, dimension(2,4) :: matrixTwo ! 2 by 4 (2 rows and 4 columns)

    print '(/,A)', "Example 2"

    ! let's initialize and print "matrixTwo"
    print *, "Contents of matrixTwo:"
    do i = 1, 2
        do j = 1, 4
            matrixTwo(i,j) = i + j
            write(*,'(I2)',advance='no') matrixTwo(i,j)
        end do
        print *, '' !blank line
    end do

    !Bonus: "implicit do loops"
    matrixOne = 0 !initialize

    print *, "Contents of matrixOne:"
    do i = 1, 5 !put the outer loop here (i.e. rows)
        write(*,'(5(I1))') (matrixOne(i,j),j=1,5) !put the second loop index inside here; pay careful attention to the parenthesis
    end do

return; end subroutine twoDimensionalArrays



subroutine allocatableArrays()
    implicit none

    ! what if you don't know how big you want your array to be?
    ! make it "allocatable", that's what!
    integer, allocatable, dimension(:) :: myAllocatableArray
    integer, allocatable :: myOtherAllocatableArray(:), evenAnotherArray(:)

    integer, allocatable, dimension(:,:) :: myArray
    integer, allocatable, dimension(:,:,:) :: myCube

    print '(/,A)', "Example 3"

    ! allocating a single array
    allocate(myAllocatableArray(10))
    
    ! allocating multiple arrays on the same line
    allocate(myOtherAllocatableArray(5),evenAnotherArray(7))

    ! allocating a multi-dimensional array
    allocate(myArray(7,4))
    allocate(myCube(1,2,3))

    ! what if you've forgoten how big your array is?
    print *, "Size of myAllocatableArray:"
    print *, shape(myAllocatableArray) !size of array (i.e. # of elements in each dimension)
    print '(A,I2,1x,I2)', "myArray; dimension 1 and 2: ", shape(myArray)
  
    ! individual bounds
    print *, "lower bound: ", lbound(evenAnotherArray) !lower bound
    print *, "upper bound: ", ubound(evenAnotherArray) !upper bound

    ! individual bounds in multi-dimensional arrays
    print *, "upper bound, dimension 1: ", ubound(myArray,1)
    print *, "upper bound, dimension 2: ", ubound(myArray,2)

return; end subroutine allocatableArrays



subroutine bonusStuff()
    implicit none

    !// ignore me //
    integer :: i, j
    !// ignore me //

    integer, allocatable, dimension(:,:) :: bonusArray

    print '(/,A)', "Example 4"

    allocate(bonusArray(3,10))

    ! this is most generic way of looping through a two dimensional matrix
    ! note: the bound are calculated for you, so you don't have to worry about them
    print *, 'Contents of bonusArray:'
    do i=lbound(bonusArray,1),ubound(bonusArray,1)
        do j=lbound(bonusArray,2),ubound(bonusArray,2)
            bonusArray(i,j) = i + j
            write(*,'(I2,1x)',advance='no'), bonusArray(i,j)
        end do
        print *, ''
    end do

return; end subroutine bonusStuff

