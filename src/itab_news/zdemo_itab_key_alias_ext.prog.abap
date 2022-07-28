report zdw_lt_key_alias.

types:
  begin of ty_struc,
    a type i,
    b type c length 10,
    c type i,
  end of ty_struc.

data:
  lt               type sorted table of ty_struc with non-unique key primary_key alias k1_alias components a
                                   with unique hashed key k2 alias k2_alias components b c,
  lr               type ref to data,
  lr_tab_descr     type ref to cl_abap_tabledescr,
  lr_tab_descr_new type ref to cl_abap_tabledescr.

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

" Create a new table with a new alias using RTTI
lr_tab_descr ?= cl_abap_tabledescr=>describe_by_data( lt ).

data(lt_key_aliases) = lr_tab_descr->get_key_aliases( ).

lt_key_aliases[ name = 'K2' ]-alias = 'NEW_ALIAS'.

lr_tab_descr_new = lr_tab_descr->get_with_keys(
  p_line_type   = conv #( lr_tab_descr->get_table_line_type( ) )
  p_keys        = lr_tab_descr->get_keys( )
  p_key_aliases = lt_key_aliases ).

create data lr type handle lr_tab_descr_new.
assign lr->* to <lt_any>.
insert lines of lt into table <lt_any>.

out->write( |Access with new (secondary) key alias:| ).
out->write( <lt_any>[ key (`NEW_ALIAS`) (`b`) = 'XYC' (`c`) = 99 ] ).

out->display(  ).
