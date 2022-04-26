"! <p class="shorttext synchronized" lang="en">Windowing: PARTITION BY clause</p>
"! Demonstrates how to restrict the window to a certain partition
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_windowing1 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing1 implementation.


  method if_oo_adt_classrun~main.
    select from ybw_candidates
           fields firstname,
                  lastname,
                  party,
                  birthyear,
                  min( birthyear ) over( partition by party ) as oldest
           into table @data(most_senior_candidate_in_party)
           up to 20 rows.
    out->write( 'most_senior_candidate_in_party:' ).
    out->write( most_senior_candidate_in_party ).

    " it is also possible to use arithmetic expressions to specify a "PARTITION"
    select from ybw_candidates
           fields firstname,
                  lastname,
                  party,
                  birthyear,
                  count( * ) over( partition by 2021 - birthyear ) as same_age
           into table @data(candidates_with_same_age)
           up to 20 rows.
    out->write( '---------------------------------------------------------' ).
    out->write( 'candidates_with_same_age:' ).
    out->write( candidates_with_same_age ).
  endmethod.

endclass.
