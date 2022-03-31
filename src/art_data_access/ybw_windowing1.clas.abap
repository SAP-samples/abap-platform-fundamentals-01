"! <p class="shorttext synchronized" lang="en">Windowing: PARTITION BY clause</p>
"! Demonstrates the ASQL window frame specification
class ybw_windowing1 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing1 implementation.


  method if_oo_adt_classrun~main.
    select from ybw_candidates
           fields firstname,
                  lastname,
                  party,
                  birthyear,
                  min( birthyear ) over( partition by party ) as oldest
           into table @data(result).
    out->write( result ).
  endmethod.

endclass.
