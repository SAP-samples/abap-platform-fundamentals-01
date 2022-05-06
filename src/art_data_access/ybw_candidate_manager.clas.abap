CLASS ybw_candidate_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS: add_candidate
      IMPORTING firstname TYPE ybw_candidates-firstname
                lastname  TYPE ybw_candidates-lastname.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ybw_candidate_manager IMPLEMENTATION.
  METHOD add_candidate.
    api_factory=>create_api( )->add_candidate(
      firstname = firstname
      lastname  = lastname
    ).
  ENDMETHOD.
ENDCLASS.
