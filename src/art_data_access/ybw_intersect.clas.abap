"! <p class="shorttext synchronized" lang="en">Demonstrates set operation INTERSECT</p>
"!
"! Here we demonstrate the INTERSECT, which only returns those rows that are
"! part of both query results.
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_intersect definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

    types: begin of ty_intersect,
             partei type ybw_vote-party,
           end of ty_intersect,
           tt_intersect type standard table of ty_intersect with empty key.

    class-methods:
      execute_intersect
        returning value(rt_intersect) type tt_intersect.

  protected section.
  private section.
endclass.



class ybw_intersect implementation.
  method if_oo_adt_classrun~main.
    " selects all parties or persons from the vote table
    " whose first vote is larger than 0
    select from ybw_vote
           fields distinct party as partei_name
           where vote = '1' and
                 votes > 0 and
                 party like 'P%'
           order by partei_name
           into table @data(parties_of_vote_table).
    out->write( 'parties_of_vote_table:' ).
    out->write( parties_of_vote_table ).

    " selects only real parties from the party table
    select from ybw_party
           fields distinct short_name as partei_name
           where kind = 'Partei' and
                 short_name like 'P%'
           order by partei_name
    into table @data(parties).
    out->write( '---------------------------------------------------------' ).
    out->write( 'parties:' ).
    out->write( parties ).

    " the intersect of both previous queries will be those real parties
    " whose votes are > 0
    data(intersect) = execute_intersect( ).
    out->write( '---------------------------------------------------------' ).
    out->write( 'intersect:' ).
    out->write( intersect ).
  endmethod.

  method execute_intersect.
    select from ybw_vote
           fields distinct party as partei_name
           where vote = '1' and
                 votes > 0 and
                 party like 'P%'
    intersect
    select from ybw_party
           fields distinct short_name as partei_name
           where kind = 'Partei' and
                 short_name like 'P%'
    order by partei_name
    into table @rt_intersect.
  endmethod.

endclass.
