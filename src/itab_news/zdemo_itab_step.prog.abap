report zdemo_itab_step.

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

selection-screen begin of block operation with frame title t_title1.
  parameters:
    loop  radiobutton group oper,
    del   radiobutton group oper,
    ins   radiobutton group oper,
    app   radiobutton group oper,
    for   radiobutton group oper,
    lines radiobutton group oper.
selection-screen end of block operation.

selection-screen begin of block trmsgtxt with frame title t_title2.
  parameters:
    linno type i default 20,
    step  type i default 1,
    von   type i default 1,
    bis   type i default 20.
selection-screen end of block trmsgtxt.

initialization.
  t_title1 = 'Operation'(001).
  t_title2 = 'Parameters'(002).
  perform init_tables.

at selection-screen output.
  perform handle_buttons.

start-of-selection.
  if loop = 'X'.
    loop at itab assigning field-symbol(<fs_loop>)
      step step from von to bis.
      tabix = sy-tabix.
      result = value #( base result ( tabix = tabix value = <fs_loop> ) ).
    endloop.
    perform display.
  elseif del = 'X'.
    result = itab_with_tabix.
    delete result
      step step from von to bis.
    perform display.
  elseif ins = 'X'.
    insert lines of itab_with_tabix
      step step from von to bis into result index 1.
    perform display.
  elseif app = 'X'.
    append lines of itab_with_tabix
      step step from von to bis to result.
    perform display.
  elseif for = 'X'.
    result = value #( for <fs_for> in itab index into indx
                        step step from von to bis
                          ( tabix = indx value = <fs_for> ) ).
    perform display.
  elseif lines = 'X'.
    result = value #( ( lines of itab_with_tabix
                          step step from von to bis ) ).
    perform display.
  endif.

form init_tables.
  " Initialize tables
  itab = value #( for i = 1 until i > linno ( linno + 1 - i ) ).
  itab_with_tabix = value #( for <fs> in itab index into indx
                               ( tabix = indx value = <fs> ) ).
endform.

form display.
  " Display result
  cl_demo_output=>write( result ).
  cl_demo_output=>display( ).

  " Clear result for next test
  clear result.
endform.

form handle_buttons.
  if loop = 'X'.
    del   = ' '.
    ins   = ' '.
    app   = ' '.
    for   = ' '.
    lines = ' '.
  elseif del = 'X'.
    loop  =  ' '.
    ins   = ' '.
    app   = ' '.
    for   = ' '.
    lines = ' '.
  elseif ins = 'X'.
    loop  =  ' '.
    del   = ' '.
    app   = ' '.
    for   = ' '.
    lines = ' '.
  elseif app = 'X'.
    loop  =  ' '.
    del   = ' '.
    ins   = ' '.
    for   = ' '.
    lines = ' '.
  elseif for = 'X'.
    loop  =  ' '.
    del   = ' '.
    ins   = ' '.
    app   = ' '.
    lines = ' '.
  elseif lines = 'X'.
    loop  =  ' '.
    del   = ' '.
    ins   = ' '.
    app   = ' '.
    for   = ' '.
  endif.
endform.
