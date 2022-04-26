"! <p class="shorttext synchronized" lang="en">code completion</p>
"!
"! Here we would like to demonstrate the ABAP SQL code completion
"! and how to best use it.
"!
class ybw_tipps0 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.
  protected section.
  private section.
endclass.



class ybw_tipps0 implementation.

  method if_oo_adt_classrun~main.
    " with the new ABAP SQL syntax you can
    " start the statement with the from clause
    " this allows you to get code completion results
    " in all of ABAP SQLs field lists.
    " just try to add another field and trigger the
    " code completion with STRG+SPACE
    select from ybw_votes_person
           fields Area, Party
           into table @data(result).

    out->write( result ).
  endmethod.

endclass.
