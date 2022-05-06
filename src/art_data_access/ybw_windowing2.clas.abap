"! <p class="shorttext synchronized" lang="en">Windowing: ORDER BY clause</p>
"! Demonstrates the ASQL ORDER BY clause
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_windowing2 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing2 implementation.


  method if_oo_adt_classrun~main.
    " the order by clause allows us to enforce a certain order within
    " our window. The effect can be seen with the row_number() function.
    select from ybw_candidates
       fields row_number( ) over( order by birthyear ascending ) as row,
              firstname,
              lastname,
              birthyear
       into table @data(enumerate_by_ascending_age)
       up to 50 rows.
    out->write( 'enumerate_by_ascending_age:' ).
    out->write( enumerate_by_ascending_age ).

    " using a partition you can see that the enumeration starts by one
    " for each party
    select from ybw_candidates
           fields row_number( ) over( partition by party order by birthyear ascending, lastname ascending ) as row,
                  firstname,
                  lastname,
                  party,
                  birthyear
           where not party like 'EB:%' and lastname like 'W%'
           order by row descending, birthyear
           into table @data(order_by_age_for_each_party)
           up to 50 rows.
    out->write( '---------------------------------------------------------' ).
    out->write( 'order_by_age_for_each_party:' ).
    out->write( order_by_age_for_each_party ).
  endmethod.

endclass.
