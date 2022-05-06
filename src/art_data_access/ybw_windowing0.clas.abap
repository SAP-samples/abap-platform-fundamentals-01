"! <p class="shorttext synchronized" lang="en">Windowing: OVER clause</p>
"! Demonstrates the over clause.
"!
"! An "empty" over( ) means the window spans the whole table.
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_windowing0 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing0 implementation.

  method if_oo_adt_classrun~main.
    " without a window we need a cross join to
    " get the overall number of parties in each row
    with +overall as ( select from ybw_party fields count(*) as overall )
    select from ybw_party cross join +overall
           fields ybw_party~short_name,
                  ybw_party~kind,
                  +overall~overall
           into table @data(overall_no_window)
           up to 10 rows.
    out->write( 'overall_no_window:' ).
    out->write( overall_no_window ).

    " the same query result can be achieved with a window
    " function whose window spans the whole table
    select from ybw_party
           fields short_name,
                  kind,
                  count(*) over( ) as overall
           into table @data(overall_with_window)
           up to 10 rows.
    out->write( '-------------------------------------------------------' ).
    out->write( 'overall_with_window:' ).
    out->write( overall_with_window ).

    " leveraging window function row_number() makes
    " it easy to enumerate the rows in our result set
    select from ybw_party
           fields row_number( ) over( ) as row,
                  short_name,
                  kind,
                  count(*) over( ) as overall
           into table @data(enumerate_each_row)
           up to 10 rows.
    out->write( '-------------------------------------------------------' ).
    out->write( 'enumerate_each_row:' ).
    out->write( enumerate_each_row ).
  endmethod.

endclass.
