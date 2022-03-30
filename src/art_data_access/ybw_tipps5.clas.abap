"! <p class="shorttext synchronized" lang="en">New SQL syntax</p>
"! Demonstrate better syntax checks for new SQL syntax
class ybw_tipps5 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps5 implementation.

  method if_oo_adt_classrun~main.
    " using new ABAP SQL syntax will lead to stricter checks
    " effectively allowing ABAP to provide errors instead of
    " warnings. Using new syntax means escaping host variables
    " with @ and separating list entries by comma. Try what happens here
    data result type table of ybw_infra.
    select * from ybw_party into corresponding fields of table result.

    out->write( result ).
  endmethod.

endclass.
