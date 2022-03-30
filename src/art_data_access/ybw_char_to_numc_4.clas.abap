"! <p class="shorttext synchronized" lang="en">Convert C to N</p>
"! This program demonstrates the conversion from char data to numc
class ybw_char_to_numc_4 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_char_to_numc_4 implementation.

  method if_oo_adt_classrun~main.
    delete from ydemos4_numc10.
    commit work.
*   Add leading zeros via LPAD and delete leading spaces via LTRIM
    insert ydemos4_numc10 from ( select from ydemos4_char10 fields k1, cast( lpad( ltrim( f_char10, @space ), 10, '0' ) as numc( 10 ) ) ).
    select from ydemos4_numc10 fields * into table @data(dest_itab).

    out->write( sy-repid ).
    out->write( dest_itab ).
  endmethod.

endclass.
