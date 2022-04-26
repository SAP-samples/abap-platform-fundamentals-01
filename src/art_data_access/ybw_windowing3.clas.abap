"! <p class="shorttext synchronized" lang="en">Windowing: frame specification</p>
"! Demonstrates the ASQL window frame specification
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
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

    " this example demonstrates a window frame specification that contains max. 5 rows. 2 rows before
    " and 2 rows after the current row. The query calculates the average age of those 5 rows.
    with +ages as ( select from ybw_candidates fields firstname, lastname, 2021 - birthyear as age )
      select from +ages
             fields firstname,
                    lastname,
                    age,
                    avg( age as dec( 18,2 ) ) over( order by age
                                     rows between 2 preceding and 2 following ) as avg_age
      into table @data(candidate_surrounding_average)
      up to 50 rows.
    out->write( 'candidate_surrounding_average:' ).
    out->write( candidate_surrounding_average ).
  endmethod.

endclass.
