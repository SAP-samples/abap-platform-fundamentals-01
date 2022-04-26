"! <p class="shorttext synchronized" lang="en">Existence check</p>
"!
"! This example demonstrates an efficient way to do an existence check with ABAP SQL
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_tipps1 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps1 implementation.

  method if_oo_adt_classrun~main.
    get run time field data(begin2).
    do 100 times.
      select single @abap_true
             from ybw_candidates
             where voting_date = '20210926'
             into @data(exists2).
    enddo.
    get run time field data(end2).
    out->write( |select single @abap_true: { end2 - begin2 }| ).

    get run time field data(begin).
    do 100 times.
      select 'X'
             from ybw_candidates
             where voting_date = '20210926'
             into @data(exists) up to 1 rows.
        exit.
      endselect.
    enddo.
    get run time field data(end).
    out->write( |             select loop: { end - begin }| ).
  endmethod.

endclass.
