report zdemo_itab_step_syntax.

types:
  begin of ty_line,
    tabix type sy-tabix,
    value type i,
  end of ty_line,
  tt_type type table of ty_line with empty key,
  begin of enum itab_operation structure opcode,
    loop,
    delete,
    insert,
    append,
    for,
    lines,
  end of enum itab_operation structure opcode.

data:
  itab            type table of i with empty key,
  itab_with_tabix type tt_type,
  result          type tt_type,
  tabix           type sy-tabix.


start-of-selection.
  " Initialize tables
  itab = value #( for i = 1 until i > 20 ( 20 + 1 - i ) ).
  itab_with_tabix = value #( for <fs> in itab index into indx
                               ( tabix = indx value = <fs> ) ).

  " LOOP ... STEP
  loop at itab assigning field-symbol(<fs_loop>)
    step 1.
    tabix = sy-tabix.
    result = value #( base result ( tabix = tabix value = <fs_loop> ) ).
  endloop.

  " DELETE ... STEP
  result = itab_with_tabix.
  delete result step 1.

  " INSERT ... STEP
  insert lines of itab_with_tabix
    step 1 into result index 1.

  " APPEND ... STEP
  append lines of itab_with_tabix
    step 1 to result.

  " FOR ... STEP
  result = value #( for <fs_for> in itab index into indx
                      step 1
                        ( tabix = indx value = <fs_for> ) ).

  " LINES OF ... STEP
  result = value #( ( lines of itab_with_tabix step 1 ) ).
