"! <p class="shorttext synchronized" lang="en">Windowing: frame specification</p>
"! Demonstrates the ASQL window frame specification
class ybw_windowing3 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.
  private section.
endclass.



class ybw_windowing3 implementation.


  method if_oo_adt_classrun~main.

    with +ages as ( select from ybw_candidates fields firstname, lastname, 2021 - birthyear as age )
      select from +ages
             fields firstname,
                    lastname,
                    age,
                    avg( age as dec( 18,2 ) ) over( order by age
                                     rows between 2 preceding and 2 following ) as avg_age
      into table @data(result)
      up to 50 rows.
    out->write( result ).

    select from ybw_vote
           fields area,
                  party,
                  kind,
                  vote,
                  votes,
                  avg( votes as dec( 16, 0 ) ) over( partition by party ) as all_per_party1,
                  avg( votes as dec( 16, 0 ) ) over( partition by party
                                     order by votes descending
                                     rows between unbounded preceding and unbounded following ) as all_per_party2
           into table @data(result2)
           up to 50 rows.
    out->write( result2 ).
  endmethod.

endclass.
