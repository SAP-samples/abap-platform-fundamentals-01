report zdw_lt_key_alias.

types:
  begin of ty_struc,
    a type i,
    b type c length 10,
    c type i,
  end of ty_struc.

data:
  lt type sorted table of ty_struc with non-unique key primary_key alias k1_alias components a
                                   with unique hashed key k2 alias k2_alias components b c,
  lr type ref to data.

field-symbols:
  <lt_any> type any table.

lt = value #( ( a = 25 b = 'ABC' c = 44 )
              ( a = 43 b = 'HJF' c = 33 )
              ( a = 31 b = 'ABC' c = 22 )
              ( a = 12 b = 'XYC' c = 99 )
              ( a = 64 b = 'ZHF' c = 66 )
              ( a = 98 b = 'KFJ' c = 77 )
              ( a = 65 b = 'ZRH' c = 32 ) ).

data(out) = cl_demo_output=>new( ).
out->write( `lt:` ).
out->write( lt ).

out->write( |Access with (primary) key name:| ).
out->write( lt[ key primary_key index 4 ] ).

out->write( |Access with (primary) key alias:| ).
out->write( lt[ key k1_alias index 4 ] ).

out->write( |Access with (secondary) key name:| ).
out->write( lt[ key k2 b = 'XYC' c = 99 ] ).

out->write( |Access with (secondary) key alias:| ).
out->write( lt[ key k2_alias b = 'XYC' c = 99 ] ).

out->display(  ).
