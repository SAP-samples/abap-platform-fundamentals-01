"! <p class="shorttext synchronized" lang="en">Demo CTE</p>
"!
"! Common Table Expression aka. CTEs can be used to modularize you query.
"! You define a set of ad-hoc view starting with name +... .
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
    " This example integrates the already known queries from
    " the set operation demos.
    " The result of the whole query is empty. Play with the statement
    " to see why that is. Maybe start by selecting from each ad-hoc view +..
    " one by one to see each result set separately.
    with +vote as ( select from ybw_vote
                           fields party as partei_name
                           where vote = '1' and votes > 0 ),
         +party( partei_name ) as ( select from ybw_party
                                           fields short_name
                                           where kind = 'Partei' ),
         +intersect as ( select from +vote fields partei_name
                         intersect
                         select from +party fields partei_name ),
         +join as ( select from ybw_vote inner join ybw_party
                           on ybw_vote~party = ybw_party~short_name and
                              ybw_vote~vote = '1' and
                              ybw_vote~votes > 0 and
                              ybw_party~kind = 'Partei'
                           fields distinct party as partei_name )
    select from +intersect fields partei_name
    except
    select from +join fields partei_name

    union all

    (
      select from +join fields partei_name
      except
      select from +intersect fields partei_name
    )

    into table @data(result).

    out->write( result ).
  endmethod.

endclass.
