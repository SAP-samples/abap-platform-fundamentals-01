"! <p class="shorttext synchronized" lang="en">Convert C to N</p>
"! This program demonstrates the conversion from char data to numc
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_char_to_numc_6 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_char_to_numc_6 implementation.

  method if_oo_adt_classrun~main.
*   Use INSERT FROM SELECT with target table as global temporary table
    insert ydemos4_numc10_g from ( select from ydemos4_char10 fields k1, cast( lpad( ltrim( f_char10, @space ), 10, '0' ) as numc( 10 ) ) ).
    select from ydemos4_numc10_g fields * into table @data(dest_itab).

    out->write( sy-repid ).
    out->write( dest_itab ).
  endmethod.

endclass.
