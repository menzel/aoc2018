      PROGRAM cycle
          implicit none
          INTEGER :: values(1021)
          INTEGER :: n
          INTEGER :: freq
          INTEGER , allocatable :: known(:)
          INTEGER , allocatable :: tmp(:)
          INTEGER :: knownp

          open(unit=10, file="input.txt", status='old', action="read")
          read(10, *) values 

          freq = 0
          knownp = 1
          allocate(known(1000))

          !endless loop 
          DO
              DO n = 1,size(values)
                  freq = freq + values(n) 
    
                  IF (knownp == size(known)-1) THEN 
                      allocate(tmp(2*size(known)))
                      tmp(1:size(known)) = known
                      deallocate(known)
                      call move_alloc(tmp, known)
                  END IF
    
                  !contains check
                  IF (contains(known,knownp-1,freq)) THEN
                      print *, "First repeat: ", freq 
                      call EXIT(0)
                  END IF
    
                  known(knownp) = freq
                  knownp = knownp + 1
              END DO
          END DO

          CONTAINS 
              FUNCTION contains(list, s, e)
                  LOGICAL :: contains
                  INTEGER :: e
                  INTEGER :: s
                  INTEGER :: i
                  INTEGER :: list(s)

                  contains = .FALSE.
                  DO i = 1,size(list)
                      IF (list(i) == e) THEN
                          contains = .TRUE.
                      END IF 
                  END DO

                  RETURN 
              END FUNCTION
      END PROGRAM
