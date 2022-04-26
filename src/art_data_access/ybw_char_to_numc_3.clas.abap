"! <p class="shorttext synchronized" lang="en">Convert C to N</p>
"! This program demonstrates the conversion from char data to numc
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_char_to_numc_3 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_char_to_numc_3 implementation.

  method if_oo_adt_classrun~main.
    delete from ydemos4_numc10.
    commit work.
*   Convert data char to numc via CAST
    insert ydemos4_numc10 from ( select from ydemos4_char10 fields k1, cast( f_char10 as numc( 10 ) ) ).
    select from ydemos4_numc10 fields * into table @data(dest_itab).

    out->write( sy-repid ).
    out->write( dest_itab ).
  endmethod.

endclass.
