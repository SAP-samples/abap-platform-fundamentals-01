"! <p class="shorttext synchronized" lang="en">Demo CTE</p>
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_cte definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.

class ybw_cte implementation.

  method if_oo_adt_classrun~main.
    with +vote as ( select from ybw_vote
                           fields party as partei
                           where vote = '1' and votes > 0 ),
         +party( partei ) as ( select from ybw_party
                                      fields ybw_party~short_name
                                      where ybw_party~kind  = 'PARTEI' ),
         +intersect as ( select from +vote fields partei
                         intersect
                         select from +party fields partei ),
         +join as ( select from ybw_vote inner join ybw_party
                           on ybw_vote~party = ybw_party~short_name and
                              vote = '1' and votes > 0 and
                              ybw_party~kind = 'PARTEI'
                           fields distinct party as partei )
    select from +intersect fields partei
    except
    select from +join fields partei

    union all

    (
      select from +join fields partei
      except
      select from +intersect fields partei
    )

    into table @data(result).

    out->write( result ).
  endmethod.

endclass.
