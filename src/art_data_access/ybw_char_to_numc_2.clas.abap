"! <p class="shorttext synchronized" lang="en">Convert C to N</p>
"! This program demonstrates the conversion from char data to numc
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_char_to_numc_2 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_char_to_numc_2 implementation.

  method if_oo_adt_classrun~main.
    delete from ydemos4_numc10.
    commit work.

*    Convert data from char to numc in SQL statement
*    insert ydemos4_numc10 from ( select from ydemos4_char10 fields ).
    select from ydemos4_numc10 fields * into table @data(dest_itab).

    out->write( sy-repid ).
    out->write( dest_itab ).
  endmethod.

endclass.
