"! <p class="shorttext synchronized" lang="en">ABAP program to simulate windowing</p>
"! Demonstrates windowing in ABAP SQL
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_windowing_abap definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

    types: begin of ty_aggregated_votes,
             area type ybw_votes_party-Area,
             party type ybw_votes_party-party,
             votes type int8,
             overall_votes type int8,
           end of ty_aggregated_votes,
           tt_aggregated_votes type standard table of ty_aggregated_votes with default key.

    class-methods:
      read_votes_aggregated
        returning value(et_aggregated_votes) type tt_aggregated_votes.

  protected section.
  private section.
endclass.



class ybw_windowing_abap implementation.


  method if_oo_adt_classrun~main.
    out->write( read_votes_aggregated(  ) ).
  endmethod.

  method read_votes_aggregated.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " select the area, the name of the party, the sum of their 1 and 2 vote
    " and their overall votes.
    " Only the top 10 parties with the highest votes should be selected
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    select from ybw_votes_party
           fields area,
                  party,
                  sum( votes ) as votes,
                  int8`0` as overall_votes
           where area <> 'Bundesgebiet'
           group by area, party
           order by votes descending
           into table @et_aggregated_votes
           up to 10 rows.

    select from ybw_votes_party
           fields party, sum( votes ) as votes
           where area <> 'Bundesgebiet'
           group by party
           into table @data(overall_votes).

    loop at et_aggregated_votes assigning field-symbol(<fs>).
      read table overall_votes with key party = <fs>-Party into data(wa).
      if sy-subrc = 0.
        <fs>-overall_votes = wa-votes.
      else.
        <fs>-overall_votes = 0.
      endif.
    endloop.
  endmethod.

endclass.
