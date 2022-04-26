"! <p class="shorttext synchronized" lang="en">Buffered table</p>
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_tipps4 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps4 implementation.

  method if_oo_adt_classrun~main.
    modify ybw_party from @( value #( id = 1000 kind = 'PARTEI' short_name = 'Die Bestesten' ) ).
    modify ybw_party from @( value #( id = 1000 kind = 'PARTEI' short_name = 'Uebermotiviert2021' ) ).

    data newParties type standard table of ybw_party.
    append value #( id = 1000 kind = 'PARTEI' short_name = 'Die Bestesten' ) to newParties.
    append value #( id = 1000 kind = 'PARTEI' short_name = 'Uebermotiviert2021' ) to newParties.
    modify ybw_party from table newParties.
  endmethod.

endclass.
