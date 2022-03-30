*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS limpl_dbapi DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_dbapi.
ENDCLASS.

CLASS api_factory IMPLEMENTATION.
  METHOD create_api.
    ref_dbapi = NEW limpl_dbapi( ).
  ENDMETHOD.
ENDCLASS.

CLASS limpl_dbapi IMPLEMENTATION.
  METHOD lif_dbapi~add_candidate.
    SELECT SINGLE @abap_true FROM ybw_candidates
           WHERE firstname = @firstname AND lastname = @lastname
           INTO @DATA(exists).
    IF exists <> abap_true.
      INSERT ybw_candidates FROM @(
        VALUE #( firstname = firstname
                 lastname = lastname ) ).
    ENDIF.
    wait-for-db.
  ENDMETHOD.
ENDCLASS.
