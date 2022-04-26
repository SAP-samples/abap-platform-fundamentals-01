"! <p class="shorttext synchronized" lang="en">Coalesce</p>
"! This example demonstrates the usage of the coalesce function
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
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
    " Left outer joins are known to eventually produce NULL values
    " in the ABAP result set this is not obvious, because NULL values
    " will be transformed to ABAP initial values in the result set.
    " This is due to the fact that the corresponding ABAP type has
    " means to express a NULL value. Nevertheless you can use the
    " coalesce function to replace the NULL value with a meaningful
    " default value. Here the party field will contain the character
    " string '< None >' instead the ABAP initial value.
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
