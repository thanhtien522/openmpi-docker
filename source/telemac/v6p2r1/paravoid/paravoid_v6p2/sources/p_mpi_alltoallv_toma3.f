!                    *********************************
                     SUBROUTINE  P_MPI_ALLTOALLV_TOMA3
!                    *********************************
!
     &(I1,I2,I3,I4,I5,I6,I7,I8,I9,I10)
!
!***********************************************************************
! PARAVOID   V6P1                                   21/08/2010
!***********************************************************************
!
!brief    CALLS FUNCTION MPI_ALLTOALLV.
!
!warning  EMPTY SHELL IN SCALAR MODE FOR PARALLEL COMPATIBILITY
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
!| I5             |-->| RECEIVE BUFFER
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
      TYPE FONCTION_TYPE
      SEQUENCE
        INTEGER :: MYPID ! PARTITION OF THE TRACEBACK ORIGIN (HEAD)
        INTEGER :: NEPID ! THE NEIGHBOUR PARTITION THE TRACEBACK ENTERS TO
        INTEGER :: INE   ! THE LOCAL 2D ELEMENT NR THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION
        INTEGER :: KNE   ! THE LOCAL LEVEL THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION
        INTEGER :: IOR   ! THE POSITION OF THE TRAJECTORY -HEAD- IN MYPID [THE 2D/3D NODE OF ORIGIN]
        INTEGER :: ISP,NSP ! NUMBERS OF RUNGE-KUTTA PASSED AS COLLECTED AND TO FOLLOW AT ALL
        DOUBLE PRECISION :: XP,YP,ZP                ! THE (X,Y,Z)-POSITION NOW
        DOUBLE PRECISION :: SHP1,SHP2,SHP3,SHZ
        DOUBLE PRECISION :: BP
        DOUBLE PRECISION :: F(6) ! FUNCTION VALUES AT THE 6 POINTS OF THE PRISM
      END TYPE FONCTION_TYPE
!
      TYPE(FONCTION_TYPE), INTENT(IN)  :: I1(*)
      TYPE(FONCTION_TYPE), INTENT(OUT) :: I5(*)
      INTEGER, INTENT(IN)  :: I2(*),I3(*),I4,I6(*),I7(*),I8,I9
      INTEGER, INTENT(OUT) :: I10
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      IF(LNG.EQ.1) WRITE(LU,*) 'APPEL DE  P_MPI_ALLTOALLV  VERSION VIDE'
      IF(LNG.EQ.2) WRITE(LU,*) 'CALL OF P_MPI_ALLTOALLV VOID VERSION'
!
!-----------------------------------------------------------------------
!
      RETURN
      END
