!                    *****************
                     SUBROUTINE ASSVEC
!                    *****************
!
     &(X, IKLE,NPOIN,NELEM,NELMAX,IELM,W,INIT,LV,MSK,MASKEL,NDP)
!
!***********************************************************************
! BIEF   V6P1                                   21/08/2010
!***********************************************************************
!
!brief    VECTOR ASSEMBLY.
!
!warning  THIS VECTOR IS ONLY INITIALISED TO 0 IF INIT = .TRUE.
!
!history  J-M HERVOUET (LNH)
!+        29/02/08
!+        V5P9
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
!| IELM           |-->| ELEMENT TYPE 
!| IKLE           |-->| CONNECTIVITY TABLE
!| INIT           |-->| LOGICAL : IF TRUE X IS INITIALISED TO 0.
!| LV             |-->| VECTOR LENGTH OF THE COMPUTER 
!| MASKEL         |-->| MASKING OF ELEMENTS
!|                |   | =1. : NORMAL   =0. : MASKED ELEMENT
!| MSK            |-->| IF YES, THERE IS MASKED ELEMENTS.
!| NDP            |-->| NUMBER OF POINTS PER ELEMENT
!| NELEM          |-->| NUMBER OF ELEMENTS IN THE MESH
!| NELMAX         |-->| FIRST DIMENSION OF IKLE AND W.
!| NPOIN          |-->| NUMBER OF POINTS IN X
!| W              |-->| WORK ARRAY WITH A NON ASSEMBLED FORM OF THE
!|                |   | RESULT
!|                |   | W HAS DIMENSION NELMAX * NDP(IELM)
!|                |   | NDP IS THE NUMBER OF POINTS IN THE ELEMENT
!| X              |<->| ASSEMBLED VECTOR
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      USE BIEF, EX_ASSVEC => ASSVEC
!
      IMPLICIT NONE
      INTEGER LNG,LU
      COMMON/INFO/LNG,LU
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      DOUBLE PRECISION, INTENT(INOUT) :: X(*)
      INTEGER         , INTENT(IN)    :: NELEM,NELMAX,NPOIN,IELM,LV,NDP
      INTEGER         , INTENT(IN)    :: IKLE(NELMAX,NDP)
      DOUBLE PRECISION, INTENT(IN)    :: W(NELMAX,NDP),MASKEL(NELMAX)
      LOGICAL         , INTENT(IN)    :: INIT,MSK
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      INTEGER IDP
!
!-----------------------------------------------------------------------
!   INITIALISES VECTOR X TO 0 IF(INIT)
!-----------------------------------------------------------------------
!
      IF(INIT) CALL OV( 'X=C     ' , X , X , X , 0.D0 , NPOIN )
!
!-----------------------------------------------------------------------
!   ASSEMBLES, CONTRIBUTION OF LOCAL POINTS 1,... TO NDP
!-----------------------------------------------------------------------
!
      DO IDP = 1 , NDP
!
        CALL ASSVE1(X,IKLE(1,IDP),W(1,IDP),NELEM,NELMAX,LV,MSK,MASKEL)
!
      ENDDO
!
!-----------------------------------------------------------------------
!
      RETURN
      END
