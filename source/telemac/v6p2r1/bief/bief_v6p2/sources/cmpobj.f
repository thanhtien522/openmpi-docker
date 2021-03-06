!                    ***********************
                     LOGICAL FUNCTION CMPOBJ
!                    ***********************
!
     &( OBJ1 , OBJ2 )
!
!***********************************************************************
! BIEF   V6P2                                   21/08/2010
!***********************************************************************
!
!brief    COMPARES 2 OBJECTS.
!
!history  J-M HERVOUET (LNH)
!+        01/03/90
!+        V5P1
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
!| OBJ1           |-->| BIEF_OBJ STRUCTURE TO BE COMPARED WITH THE OTHER
!| OBJ2           |-->| BIEF_OBJ STRUCTURE TO BE COMPARED WITH THE OTHER
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      USE BIEF, EX_CMPOBJ => CMPOBJ
!
      IMPLICIT NONE
      INTEGER LNG,LU
      COMMON/INFO/LNG,LU
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      TYPE(BIEF_OBJ), INTENT(IN) ::  OBJ1,OBJ2
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      INTEGER IELM1,IELM2,TYP1,TYP2
!
!-----------------------------------------------------------------------
!
      CMPOBJ = .FALSE.
!
      TYP1 = OBJ1%TYPE
      TYP2 = OBJ2%TYPE
!
      IF(TYP1.EQ.TYP2) THEN
!
        IF(TYP1.EQ.2) THEN
!
!         VECTORS: CHECKS THE DISCRETISATION
!
          IELM1 = OBJ1%ELM
          IELM2 = OBJ2%ELM
          IF(IELM1.EQ.IELM2) THEN
            IF(OBJ1%DIM1.NE.OBJ2%DIM1) THEN
              IF(LNG.EQ.1) THEN
                WRITE(LU,*) 'CMPOBJ (BIEF) :' 
                WRITE(LU,*) 'OBJET 1 : ',OBJ1%NAME,
     &          ' DE TYPE ',TYP1,' ET TAILLE ',OBJ1%DIM1
                WRITE(LU,*) 'OBJET 2 : ',OBJ2%NAME,
     &          ' DE TYPE ',TYP2,' ET TAILLE ',OBJ2%DIM1
                WRITE(LU,*) 'DIMENSIONS DIFFERENTES'
              ENDIF
              IF(LNG.EQ.2) THEN
                WRITE(LU,*) 'CMPOBJ (BIEF): '
                WRITE(LU,*) 'OBJECT 1 : ',OBJ1%NAME,
     &          ' OF TYPE ',TYP1,' AND SIZE ',OBJ1%DIM1
                WRITE(LU,*) 'OBJECT 2 : ',OBJ2%NAME,
     &          ' OF TYPE ',TYP2,' AND SIZE ',OBJ2%DIM1
                WRITE(LU,*) 'DIFFERENT DIMENSIONS'
              ENDIF
              CALL PLANTE(1)
              STOP
            ENDIF
            CMPOBJ = .TRUE.
          ENDIF
!
        ELSEIF(TYP1.EQ.4) THEN
!
!         BLOCKS: CHECKS THE NUMBER OF OBJECTS
!
          IF(OBJ1%N.EQ.OBJ2%N) CMPOBJ=.TRUE.
!
        ELSE
!
          IF(LNG.EQ.1) THEN
            WRITE(LU,*) 'CMPOBJ (BIEF) : OBJET 1 : ',OBJ1%NAME,
     &                  ' DE TYPE ',TYP1,' CAS NON PREVU'
          ENDIF
          IF(LNG.EQ.2) THEN
            WRITE(LU,*) 'CMPOBJ (BIEF): OBJECT 1 : ',OBJ1%NAME,
     &                  ' OF TYPE ',TYP1,' UNEXPECTED CASE'
          ENDIF
          CALL PLANTE(1)
          STOP
!
        ENDIF
!
      ENDIF
!
!-----------------------------------------------------------------------
!
      RETURN
      END
