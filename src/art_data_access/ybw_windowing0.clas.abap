"! <p class="shorttext synchronized" lang="en">The window frame specification</p>
"! Demonstrates the ASQL window frame specification
class ybw_windowing0 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing0 implementation.


  method if_oo_adt_classrun~main.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " select the area, the name of the party, the sum of their 1 and 2 vote
    " and their overall votes.
    " Only the top 10 parties with the highest votes should be selected
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " build projection and limit result to 10
    select from ybw_votes_party
           fields area,
                  party,
                  votes
           into table @data(result)
           up to 10 rows.   " <------------------------------
    out->write( result ).

    " show parties with highest votes on top
    select from ybw_votes_party
           fields area,
                  party,
                  votes
           order by votes descending   " <------------------------------
           into table @data(result2)
           up to 10 rows.
    out->write( result2 ).

    " sum votes per area and party
    select from ybw_votes_party
           fields area,
                  party,
                  sum( votes ) as votes  " <------------------------------
           group by area, party  " <------------------------------
           order by votes descending
           into table @data(result3)
           up to 10 rows.
    out->write( result3 ).
  endmethod.

endclass.
