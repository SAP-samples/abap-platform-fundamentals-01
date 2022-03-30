"! <p class="shorttext synchronized" lang="en">Coalesce</p>
"! This example demonstrates the usage of the coalesce function
class ybw_tipps3 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps3 implementation.

  method if_oo_adt_classrun~main.
    select from ybw_candidates as c
           left outer join ybw_party as p
           on c~party = p~short_name and
              p~kind = 'PARTEI'
           fields c~lastname, coalesce( p~long_name, '< None >' ) as party
           where c~lastname like 'Bul%'
           into table @data(result).

    out->write( result ).
  endmethod.

endclass.
