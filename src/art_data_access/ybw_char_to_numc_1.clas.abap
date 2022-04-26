"! <p class="shorttext synchronized" lang="en">Convert C to N</p>
"! This program demonstrates the conversion from char data to numc
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_char_to_numc_1 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_char_to_numc_1 implementation.

  method if_oo_adt_classrun~main.
*   Select data from database
    select from ydemos4_char10 fields * into table @data(itab).
    data dest_itab type table of ydemos4_numc10.
*   Move data von char to numc
    dest_itab = itab.
*   Save data
    modify ydemos4_numc10 from table @dest_itab.
*   Read "converted" data
    select from ydemos4_numc10 fields * into table @dest_itab.

    out->write( sy-repid ).
    out->write( dest_itab ).
  endmethod.

endclass.
