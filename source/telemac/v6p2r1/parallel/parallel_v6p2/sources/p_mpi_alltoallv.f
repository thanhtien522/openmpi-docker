!                    **************************
                     SUBROUTINE P_MPI_ALLTOALLV
!                    **************************
!
     &(I1,I2,I3,I4,I5,I6,I7,I8,I9,I10)
!
!***********************************************************************
! PARALLEL   V6P2                                  21/08/2010
!***********************************************************************
!
!brief    CALLS FUNCTION MPI_ALLTOALLV.
!
!history  C. DENIS (SINETICS)
!+        27/10/2009
!+        V6P0
!+
!
!history  N.DURAND (HRW), S.E.BOURBAN (HRW)
!+        13/07/2010
!+        V6P0
!+   Translation of French comments within the FORTRAN sources into
!+   English comments
!
!history  N.DURAND (HRW), S.E.BOURBAN (HRW)
!+        21/08/2010
!+        V6P0
!+   Creation of DOXYGEN tags for automated documentation and
!+   cross-referencing of the FORTRAN sources
!
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!| I1             |-->| SEND BUFFER  
!| I2             |-->| SPECIFIES THE NUMBER OF ELEMENTS TO SEND TO EACH
!|                |   | PROCESSOR 
!| I3             |-->| DISPLACEMENT ARRAY FOR THE SEND BUFFER 
!| I4             |-->| DATA TYPE OF SEND BUFFER ELEMENTS
!| I5             |<--| RECEIVE BUFFER
!| I6             |-->| SPECIFIES THE MAXIMUM NUMBER OF ELEMENTS THAT 
!|                |   | CAN BE RECEIVED FROM EACH PROCESSOR
!| I7             |-->| DISPLACEMENT ARRAY FOR THE RECEIVE BUFFER 
!| I8             |-->| DATA TYPE OF RECEIVE BUFFER ELEMENTS
!| I9             |-->| COMMUNICATOR 
!| I10            |-->| ERROR VALUE 
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      IMPLICIT NONE
      INTEGER LNG,LU
      COMMON/INFO/LNG,LU
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      TYPE CHARAC_TYPE 
        SEQUENCE   ! BUT SEEMS USELESS (HENCE TRICK BELOW WITH VOID)  
        INTEGER :: MYPID ! PARTITION OF THE TRACEBACK ORIGIN (HEAD) 
        INTEGER :: NEPID ! THE NEIGHBOUR PARTITION THE TRACEBACK ENTERS TO  
        INTEGER :: INE   ! THE LOCAL 2D ELEMENT NR THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION    
        INTEGER :: KNE   ! THE LOCAL LEVEL THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION    
        INTEGER :: IOR   ! THE POSITION OF THE TRAJECTORY -HEAD- IN MYPID [THE 2D/3D NODE OF ORIGIN] 
        INTEGER :: ISP,NSP ! NUMBERS OF RUNGE-KUTTA PASSED AS COLLECTED AND TO FOLLOW AT ALL 
        INTEGER :: VOID  ! TRICK FOR ALIGNMENT 
        DOUBLE PRECISION :: XP,YP,ZP                ! THE (X,Y,Z)-POSITION NOW 
        DOUBLE PRECISION :: DX,DY,DZ                ! THE DISPLACEMENTS
        DOUBLE PRECISION :: BASKET(10) ! VARIABLES INTERPOLATED AT THE FOOT   
      END TYPE CHARAC_TYPE 
      INTEGER, INTENT(IN)  :: I2(*),I3(*),I4,I6(*),I7(*),I8,I9
      INTEGER, INTENT(OUT) :: I10
      TYPE(CHARAC_TYPE), INTENT(IN)  :: I1(*)
      TYPE(CHARAC_TYPE), INTENT(OUT) :: I5(*)
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      CALL MPI_ALLTOALLV(I1,I2,I3,I4,I5,I6,I7,I8,I9,I10)
!
      IF(I10.NE.0) THEN
        WRITE(LU,*) 'P_MPI_ALLTOALLV:'
        WRITE(LU,*) 'MPI ERROR ',I10
        STOP
      ENDIF
!
!-----------------------------------------------------------------------
!
      RETURN
      END
