"! <p class="shorttext synchronized" lang="en">on condition vs where clause</p>
"! This example demonstrates the different effect of using a predicate in
"! the on condition or the where condition of the statement
class ybw_tipps2 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps2 implementation.

  method if_oo_adt_classrun~main.
    select from ybw_candidates as c
           left outer join ybw_party as p
           on c~party = p~short_name and
              p~kind = 'PARTEI'
           fields c~lastname, p~long_name
           where c~lastname like 'Bul%'
           into table @data(filter_in_on_condition).

    out->write( filter_in_on_condition ).


    select from ybw_candidates as c
           left outer join ybw_party as p
           on c~party = p~short_name
           fields c~lastname, p~long_name
           where c~lastname like 'Bul%' and
             p~kind = 'PARTEI'
           into table @data(filter_in_where).

    out->write( filter_in_where ).
  endmethod.

endclass.
