"! <p class="shorttext synchronized" lang="en">Windowing: ORDER BY clause</p>
"! Demonstrates the ASQL ORDER BY clause
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
    select from ybw_candidates
       fields row_number( ) over( order by birthyear ascending ) as row,
              firstname,
              lastname,
              birthyear
       into table @data(result)
       up to 50 rows.
    out->write( result ).

    select from ybw_candidates
           fields row_number( ) over( partition by party order by birthyear ascending ) as row,
                  firstname,
                  lastname,
                  party,
                  birthyear
           where not party like 'EB:%'
           order by row descending, birthyear
           into table @data(result2)
           up to 50 rows.
    out->write( result2 ).
  endmethod.

endclass.
