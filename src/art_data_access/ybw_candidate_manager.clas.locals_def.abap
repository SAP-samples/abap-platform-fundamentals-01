*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

INTERFACE lif_dbapi.
  METHODS: add_candidate IMPORTING firstname TYPE ybw_candidates-firstname
                                   lastname  TYPE ybw_candidates-lastname.
ENDINTERFACE.

CLASS api_factory DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: create_api RETURNING VALUE(ref_dbapi) TYPE REF TO lif_dbapi.
ENDCLASS.
