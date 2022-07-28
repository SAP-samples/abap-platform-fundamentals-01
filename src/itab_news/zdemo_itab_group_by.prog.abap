report zdemo_itab_group_by.

types:
  begin of ty_order_item,
    key1 type i,
    key2 type i,
    num  type i,
  end of ty_order_item,
  tt_order_items type standard table of ty_order_item with empty key.

data(items) = value tt_order_items(
  ( key1 = 1 key2 = 3 num = 1 )
  ( key1 = 3 key2 = 1 num = 2 )
  ( key1 = 2 key2 = 2 num = 3 )
  ( key1 = 2 key2 = 1 num = 4 )
  ( key1 = 1 key2 = 3 num = 5 )
  ( key1 = 3 key2 = 3 num = 6 )
  ( key1 = 1 key2 = 2 num = 7 )
  ( key1 = 3 key2 = 2 num = 8 )
  ( key1 = 2 key2 = 1 num = 9 ) ).

data(out) = cl_demo_output=>new( ).

" AT
out->write( `AT` ).
data(items_at) = items.
*sort items_at by key1.
loop at items_at into data(item).
  at end of key1.
    sum.
    data(output) = |Groupkey: { item-key1 } Sum: { item-num }|.
*    data(output) = |Groupkey: { item-key1 } { item-key2 } Sum: { item-num }|.
    out->write( output ).
  endat.
endloop.

out->line( ).
" GROUP BY
out->write( `GROUP BY` ).
loop at items assigning field-symbol(<item>)
     group by <item>-key1 ascending.
  data(sum) = 0.
  loop at group <item> assigning field-symbol(<member>).
    sum = sum + <member>-num.
  endloop.
  output = |Groupkey: { <item>-key1 } Sum: { sum }|.
  out->write( output ).
endloop.

out->display( ).
