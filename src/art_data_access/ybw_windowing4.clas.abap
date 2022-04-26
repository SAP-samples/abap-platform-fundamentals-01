"! <p class="shorttext synchronized" lang="en">Windowing: let the database do the work</p>
"! Demonstrates how window functions can be used to simplify the code
"! of class YBW_WINDOWING_ABAP
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_windowing4 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing4 implementation.


  method if_oo_adt_classrun~main.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " select the area, the name of the party, the sum of their 1 and 2 vote
    " per area and their overall votes.
    " Only the top 10 parties with the highest votes should be selected
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    data lt_aggregated_votes type ybw_windowing_abap=>tt_aggregated_votes.

    " this query should produce the same result as method read_votes_aggregated
    " class ybw_windowing_abap. ybw_windowing_abap produces the aggregates classic
    " abap code techniques.
    select from ybw_votes_party
           fields area,
                  party,
                  sum( votes ) as votes,
                  sum( sum( votes ) ) over( partition by party ) as overall_votes " <------------------------------
           where area <> 'Bundesgebiet'
           group by area, party
           order by votes descending
           into table @lt_aggregated_votes
           up to 10 rows.

    assert ybw_windowing_abap=>read_votes_aggregated( ) = lt_aggregated_votes.
    out->write( lt_aggregated_votes ).
  endmethod.

endclass.
