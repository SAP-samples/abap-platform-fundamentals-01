"! <p class="shorttext synchronized" lang="en">Demonstrates the INNER JOIN</p>
"!
"! This example produces the same result as the intersect example in YBW_INTERSECT
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_join definition
  public
  final
  create public .

  public section.
    interfaces: if_oo_adt_classrun.
  protected section.
  private section.
endclass.

class ybw_join implementation.

  method if_oo_adt_classrun~main.
    select from ybw_vote inner join ybw_party
             on ybw_vote~party = ybw_party~short_name and
                ybw_vote~vote = '1' and
                ybw_vote~votes > 0 and
                ybw_vote~party like 'P%' and
                ybw_party~kind  = 'Partei' and
                ybw_party~short_name like 'P%'
           fields distinct party as partei_name
           order by partei_name
           into table @data(join_result).
    assert join_result = ybw_intersect=>execute_intersect( ).
    out->write( join_result ).
  endmethod.

endclass.
