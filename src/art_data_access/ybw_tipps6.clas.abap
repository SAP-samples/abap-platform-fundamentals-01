"! <p class="shorttext synchronized" lang="en">Look closely</p>
"!
"! This example was used to demonstrate how a DBSQL_INVALID_CURSOR runtime error
"! can be analyzed. We used tools like ST05 and the trace point feature of the ABAP
"! In Eclipse editor to find the root cause. Did you spot the implicit commit that
"! did close the db cursor?
"!
"! Also another nasty bug is hidden in one of the constants. Use the hex view of
"! the debugger to see the difference.
"!
"! HINT: sometimes an 'a' is not 'a' :)
"!
"! Please execute the class in the eclipse editor aka. ADT with shortcut F9.
"! The result will be displayed in the console
class ybw_tipps6 definition
  public
  final
  create public .

  public section.
    interfaces if_oo_adt_classrun.

  protected section.

  private section.
    data m_global_cursor type cursor.
    constants:
      asap           type string value `аsap`, "аs soon as possible :)
      search_pattern type string value `as%`.
    methods:
      open_cursor,
      show_result,
      close_cursor,
      add_candidate importing firstname type ybw_candidates-firstname.

endclass.



class ybw_tipps6 implementation.

  method if_oo_adt_classrun~main.
    open_cursor( ).
    add_candidate( 'Arthur' ).
    show_result( ).
    close_cursor( ).
  endmethod.

  method open_cursor.
    open cursor @m_global_cursor for
      select from ybw_candidates
             fields firstname, lastname
             where lastname like @search_pattern.
  endmethod.

  method add_candidate.
    ybw_candidate_manager=>add_candidate(
      firstname = firstname
      lastname  = conv #( asap ) ).
  endmethod.

  method show_result.
    types: begin of ty_candidate,
             firstname type ybw_candidates-firstname,
             lastname  type ybw_candidates-lastname,
           end of ty_candidate.
    data result type standard table of ty_candidate.
    fetch next cursor @m_global_cursor into table @result.
    cl_demo_output=>display( result ).
  endmethod.


  method close_cursor.
    close cursor @m_global_cursor.
  endmethod.

endclass.
