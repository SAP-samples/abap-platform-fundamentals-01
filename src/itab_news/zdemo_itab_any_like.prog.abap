report zdemo_itab_any_like.
types:
  tt_int type standard table of i with empty key.

start-of-selection.
  data:
    lt_int        type tt_int,
    lt_int_any    type tt_int,
    lt_int_src    type tt_int,
    ltr_int_any   type ref to data.

  field-symbols:
    <any> type any.

  lt_int     = value #( ( 3 ) ( 4 ) ).
  lt_int_any = lt_int.
  lt_int_src = value #( ( 1 ) ( 2 ) ).

  assign lt_int_src to <any>.
  get reference of lt_int_any into ltr_int_any.

  " Source table:      field-symbol of type ANY
  " Destination table: data reference of type REF TO DATA
  "------------------------------------------------------
  insert lines of lt_int_src into table lt_int.
  insert lines of <any> into table ltr_int_any->*.
  assert lt_int = lt_int_any.

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
