!                    *********************************
                     SUBROUTINE P_ORG_FONCTION_TYPE_4D
!                    ********************************* 
! 
     &(NOMB,TRACE,FONCTION_4D)                      
!
!***********************************************************************
! PARALLEL   V6P2                                   21/08/2010
!***********************************************************************
!
!brief    MPI TYPE FOR TYPE CHARAC_TYPE - CHARACTERISTICS /
!+        USED BY TOMAWAC ONLY
!
!history  C. DENIS
!+        01/07/2011
!+        V6P1
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
!| NOMB           |--->| NUMBER OF VARIABLES 
!| TRACE          |<---| IF .TRUE. TRACE EXECUTION
!| CHARACTERISTIC |--->| DATATYPE FOR CHARACTERISTIC 
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!         
      IMPLICIT NONE 
      INCLUDE 'mpif.h' 
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
! 
      INTEGER, INTENT(IN)    :: NOMB 
      INTEGER, INTENT(INOUT) :: FONCTION_4D
      LOGICAL, INTENT(IN)    :: TRACE 
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      INTEGER, PARAMETER :: MAX_BASKET_SIZE=10 
      TYPE FONCTION_TYPE_4D
          INTEGER :: MYPID ! PARTITION OF THE TRACEBACK ORIGIN (HEAD)
          INTEGER :: NEPID ! THE NEIGHBOUR PARTITION THE TRACEBACK ENTERS TO
          INTEGER :: INE   ! THE LOCAL 2D ELEMENT NR THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION
          INTEGER :: KNE   ! THE LOCAL LEVEL THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION
          INTEGER :: FNE   ! THE LOCAL FREQUENCE LEVEL THE TRACEBACK ENTERS IN THE NEIGBOUR PARTITION
          INTEGER :: IOR   ! THE POSITION OF THE TRAJECTORY -HEAD- IN MYPID [THE 2D/3D NODE OF ORIGIN]
          INTEGER :: ISP,NSP ! NUMBERS OF RUNGE-KUTTA PASSED AS COLLECTED AND TO FOLLOW AT ALL
          DOUBLE PRECISION :: XP,YP,ZP,FP               ! THE (X,Y,Z)-POSITION NOW
          DOUBLE PRECISION :: SHP1,SHP2,SHP3,SHZ,SHF
          DOUBLE PRECISION :: BP
          DOUBLE PRECISION :: F(12) ! FUNCTION VALUES AT THE 6 POINT OF THE PRISM
       END TYPE FONCTION_TYPE_4D
!      
       INTEGER, DIMENSION(20) :: FC_BLENGTH_4D=
     &      (/1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1/)
                                ! ARRAY OF DISPLACEMENTS BETWEEN BASIC COMPONENTS, HERE INITIALISED ONLY
       INTEGER(KIND=MPI_ADDRESS_KIND), DIMENSION(20) :: FC_DELTA_4D=
     &                     (/0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0/)
!      ARRAY OF COMPONENT TYPES IN TERMS OF THE MPI COMMUNICATION
       INTEGER, DIMENSION(20) :: FC_TYPES_4D
       INTEGER (KIND=MPI_ADDRESS_KIND)  :: INTEX,ILB,IUB 
       TYPE(FONCTION_TYPE_4D) :: CH 
!          
      INTEGER LNG,LU 
      COMMON/INFO/LNG,LU 
      INTEGER I,IER,IBASE 
!            
      CALL P_MPI_ADDRESS (CH%MYPID,  FC_DELTA_4D(1),  IER)
      CALL P_MPI_ADDRESS (CH%NEPID,  FC_DELTA_4D(2),  IER)
      CALL P_MPI_ADDRESS (CH%INE,    FC_DELTA_4D(3),  IER)
      CALL P_MPI_ADDRESS (CH%KNE,    FC_DELTA_4D(4),  IER)
      CALL P_MPI_ADDRESS (CH%FNE,    FC_DELTA_4D(5),  IER)
      CALL P_MPI_ADDRESS (CH%IOR,    FC_DELTA_4D(6),  IER)
      CALL P_MPI_ADDRESS (CH%ISP,    FC_DELTA_4D(7),  IER)
      CALL P_MPI_ADDRESS (CH%NSP,    FC_DELTA_4D(8),  IER)
      CALL P_MPI_ADDRESS2(CH%XP,     FC_DELTA_4D(9),  IER)
      CALL P_MPI_ADDRESS2(CH%YP,     FC_DELTA_4D(10),  IER)
      CALL P_MPI_ADDRESS2(CH%ZP,     FC_DELTA_4D(11), IER)
      CALL P_MPI_ADDRESS2(CH%FP,     FC_DELTA_4D(12), IER)
      CALL P_MPI_ADDRESS2(CH%SHP1,   FC_DELTA_4D(13), IER)
      CALL P_MPI_ADDRESS2(CH%SHP2,   FC_DELTA_4D(14), IER)
      CALL P_MPI_ADDRESS2(CH%SHP3,   FC_DELTA_4D(15), IER)
      CALL P_MPI_ADDRESS2(CH%SHZ,    FC_DELTA_4D(16), IER)
      CALL P_MPI_ADDRESS2(CH%SHF,    FC_DELTA_4D(17), IER)
      CALL P_MPI_ADDRESS2(CH%BP,     FC_DELTA_4D(18), IER)
      CALL P_MPI_ADDRESS3(CH%F,      FC_DELTA_4D(19), IER)
!
      CALL P_MPI_TYPE_GET_EXTENT(MPI_REAL8,ILB,INTEX,IER)
          ! MARKING THE END OF THE TYPE
      FC_DELTA_4D(20) = FC_DELTA_4D(19) + 12*INTEX ! MPI_UB POSITION
      IBASE = FC_DELTA_4D(1)
      FC_DELTA_4D = FC_DELTA_4D - IBASE ! RELATIVE ADDRESSES
      IF (NOMB>0.AND.NOMB<=12) THEN
         FC_BLENGTH_4D(19) = NOMB ! CH%BASKET RANGE APPLIED FOR COMMUNICATION
      ELSE
         WRITE(LU,*) ' @STREAMLINE::ORG_CHARAC_TYPE::',
     &        ' NOMB NOT IN RANGE [1..MAX_BASKET_SIZE]'
         WRITE(LU,*) ' MAX_BASKET_SIZE, NOMB: ',6
         CALL PLANTE(1)
         STOP
      ENDIF
      FC_TYPES_4D(1)=MPI_INTEGER
      FC_TYPES_4D(2)=MPI_INTEGER
      FC_TYPES_4D(3)=MPI_INTEGER
      FC_TYPES_4D(4)=MPI_INTEGER
      FC_TYPES_4D(5)=MPI_INTEGER
      FC_TYPES_4D(6)=MPI_INTEGER
      FC_TYPES_4D(7)=MPI_INTEGER
      FC_TYPES_4D(8)=MPI_INTEGER
      FC_TYPES_4D(9)=MPI_REAL8
      FC_TYPES_4D(10)=MPI_REAL8
      FC_TYPES_4D(11)=MPI_REAL8
      FC_TYPES_4D(12)=MPI_REAL8
      FC_TYPES_4D(13)=MPI_REAL8
      FC_TYPES_4D(14)=MPI_REAL8
      FC_TYPES_4D(15)=MPI_REAL8
      FC_TYPES_4D(16)=MPI_REAL8
      FC_TYPES_4D(17)=MPI_REAL8
      FC_TYPES_4D(18)=MPI_REAL8
      FC_TYPES_4D(19)=MPI_REAL8
      FC_TYPES_4D(20)=MPI_UB    ! THE TYPE UPPER BOUND MARKER
      CALL P_MPI_TYPE_CREATE_STRUCT(20,FC_BLENGTH_4D,FC_DELTA_4D,
     &     FC_TYPES_4D,FONCTION_4D,IER)
      CALL P_MPI_TYPE_COMMIT(FONCTION_4D,IER)
      CALL P_MPI_TYPE_GET_EXTENT(FONCTION_4D,ILB,INTEX,IER)
      IUB=INTEX+ILB
      IF (TRACE) THEN
         WRITE(LU,*) ' @STREAMLINE::ORG_CHARAC_TYPE:'
         WRITE(LU,*) ' MAX_BASKET_SIZE: ', 12
         WRITE(LU,*) ' SIZE(CH%BASKET): ',SIZE(CH%F)
         WRITE(LU,*) ' CH_DELTA_4D: ',FC_DELTA_4D
         WRITE(LU,*) ' CH_BLENGTH_4D: ',FC_BLENGTH_4D
         WRITE(LU,*) ' CH_TYPES_4D: ',FC_TYPES_4D
         WRITE(LU,*) ' COMMITING MPI_TYPE_STRUCT: ', FONCTION_4D
         WRITE(LU,*) ' MPI_TYPE_LB, MPI_TYPE_UB: ',ILB, IUB
      ENDIF
      IF (TRACE) WRITE(LU,*) ' -> LEAVING ORG_FONCTION_TYPE_4D'       
!     
!----------------------------------------------------------------------
!     
      RETURN  
      END 
 
 
