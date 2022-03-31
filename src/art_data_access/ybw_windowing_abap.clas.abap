"! <p class="shorttext synchronized" lang="en">ABAP program to simulate windowing</p>
"! Demonstrates windowing in ABAP SQL
class ybw_windowing_abap definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing_abap implementation.


  method if_oo_adt_classrun~main.
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
           into table @data(result)
           up to 10 rows.

    select from ybw_votes_party
           fields party, sum( votes ) as votes
           where area <> 'Bundesgebiet'
           group by party
           into table @data(overall_votes).

    loop at result assigning field-symbol(<fs>).
      read table overall_votes with key party = <fs>-Party into data(wa).
      if sy-subrc = 0.
        <fs>-overall_votes = wa-votes.
      else.
        <fs>-overall_votes = 0.
      endif.
    endloop.

    cl_demo_output=>write_data( result ).
    cl_demo_output=>display( ).
  endmethod.

endclass.
