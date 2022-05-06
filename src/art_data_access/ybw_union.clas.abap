"! <p class="shorttext synchronized" lang="en">Demonstrates set operation UNION</p>
"!
"! UNION is a set operation. Here we demonstrate the UNION ALL, which does not
"! eliminate duplicates.
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_union definition
  public
  final
  create public .

  public section.
    interfaces: if_oo_adt_classrun.
  protected section.
  private section.
endclass.

class ybw_union implementation.

  method if_oo_adt_classrun~main.
    " In this example two result sets of the party view
    " and the person view get merged.
    " The UNION ALL operation will not eliminate duplicates.
    " However in this example UNION DISTINCT is not necessary
    " as both queries produce distinct result sets.
    " In general UNION ALL should be faster than UNION DISTINCT
    select from ybw_votes_party
           fields sum( votes ) as Stimmen,
                  'Partei' as Gruppe,
                  party as Partei
           where vote = 1
           group by party
    union all
    select from ybw_votes_person
           fields sum( votes ) as Stimmen,
                  'Person' as Gruppe,
                  party as partei
           where vote = 1
           group by party
    order by Stimmen descending
    into table @data(result).

    out->write( result ).
    out->write( |{ lines( result ) } lines selected.| ).
  endmethod.

endclass.
