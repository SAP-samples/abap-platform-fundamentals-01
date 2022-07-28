report zdemo_itab_any_like_ext.
types:
  tt_int  type standard table of i with empty key
               with non-unique sorted key k1 components table_line.

types:
  begin of ty_struc,
    a type c length 3,
    b type c length 3,
    c type i,
    d type i,
  end of ty_struc,
  begin of ty_deep_struc,
    int     type i,
    int_tab type tt_int,
  end of ty_deep_struc,
  tt_struc type standard table of ty_struc with key a b.

class lcl definition abstract final.
  public section.
    class-methods:
      append_lines importing im_tab type any
                   changing  ch_tab type index table,
      collect importing im_wa  type ty_struc
              changing  ch_tab type data.
endclass.


class lcl implementation.

  method append_lines.
    append lines of im_tab to ch_tab.
  endmethod.

  method collect.
    collect im_wa into ch_tab.
  endmethod.
endclass.

start-of-selection.
  data:
    ls_struc      type ty_struc,
    lt_struc      type tt_struc,
    lt_struc_any  type tt_struc,
    lt_int        type tt_int,
    lt_int_any    type tt_int,
    lt_int_src    type tt_int,
    ltr_int_any   type ref to data,
    ls_deep_struc type ty_deep_struc,
    lr_deep_struc type ref to data.

  field-symbols:
    <any>     type any,
    <any_src> type any.

  ls_struc   = value #( a = 'ABC' b = 'DEF' c = 1 d = 2 ).
  lt_int     = value #( ( 3 ) ( 4 ) ).
  lt_int_any = lt_int.
  lt_int_src = value #( ( 1 ) ( 2 ) ).


  assign lt_int_any to <any>.
  assign lt_int_src to <any_src>.
  get reference of lt_int_any into ltr_int_any.

  " Source table:      field-symbol of type ANY
  " Destination table: data reference of type REF TO DATA
  "------------------------------------------------------
  insert lines of lt_int_src into table lt_int.
  insert lines of <any_src> into table ltr_int_any->*.
  assert lt_int = lt_int_any.

  " Source table: parameter of type any
  "------------------------------------
  append lines of lt_int_src to lt_int.
  lcl=>append_lines( exporting im_tab = lt_int_src
                     changing  ch_tab = lt_int_any ).
  assert lt_int = lt_int_any.

  " Destination table: parameter of type data
  "------------------------------------------
  collect ls_struc into lt_struc.
  lcl=>collect( exporting im_wa  = ls_struc
                changing  ch_tab = lt_struc_any ).
  assert lt_struc = lt_struc_any.

  " Table: dref->('name') data reference of type REF TO DATA
  "---------------------------------------------------------
  sort lt_int by table_line descending.
  ls_deep_struc-int_tab = lt_int_any.
  lr_deep_struc = ref #( ls_deep_struc ).
  sort lr_deep_struc->('int_tab') by ('table_line') descending.
  assert lt_int = ls_deep_struc-int_tab.

  " Rabax: ITAB_ILLEGAL_OPERAND (New)
  "----------------------------------
  data(lv_string) = `I am not a number`.
  assign lv_string to <any>.

*  delete table lv_string from 1.
*  delete table <any> from 1.

  " Rabax: OBJECTS_WA_NOT_COMPATIBLE
  "---------------------------------
  assign lt_int_any to <any>.

*  insert lv_string into table lt_int_any.
*  insert lv_string into table <any>.
