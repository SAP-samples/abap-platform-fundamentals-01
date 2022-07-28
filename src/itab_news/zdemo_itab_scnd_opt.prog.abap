*-------------------------------------------------------------------------------
* Goal: Improve the performance of this report with secondary keys.
*       Currently: - sequential READ ... WITH KEY
*                  - sequential LOOP ... WHERE
*-------------------------------------------------------------------------------
program zdemo_itab_scnd_opt.

types:
  begin of ty_item,
    item_int   type i,  " unique
    suppl_id   type i,  " suppl_id + suppl_item unique
    suppl_item type i,
  end of ty_item,

  begin of ty_result,   " --> result table (small)
    item_int type i,
    count    type i,
  end of ty_result.


class lcl_test definition.
  public section.
    methods:
      fill_item,
      fill_order,

      process
        importing
          customer type i,
      process_part_opt
        importing
          customer type i,
      process_full_opt
        importing
          customer type i.

  private section.
    constants:
      co_item_cnt  type i value 200000,
      co_order_cnt type i value 300000.

    data:
      mt_order type zdemo_itab_order_tab,     "DDIC table
      mt_item  type sorted table of ty_item with unique key item_int,
*                    with non-unique sorted key suppl components suppl_id suppl_item,
      mt_res   type standard table of ty_result ##NEEDED.
endclass.


class lcl_test implementation.

  method fill_item.
    "---------------------------------------------------------------------------
    " Fill a mapping table with co_item_cnt item ids. Mapping is very
    " primitive
    do co_item_cnt times.
      append value #( item_int   = sy-index
                      suppl_id   = ( co_item_cnt - sy-index ) div 100 + 1
                      suppl_item = ( co_item_cnt - sy-index ) mod 100 + 1 )
        to mt_item.
    enddo.
    write: / 'Lines MT_ITEM:  ' ##NO_TEXT,
             co_item_cnt.
  endmethod.

  method fill_order.
    "---------------------------------------------------------------------------
    " Fill a mock table with co_order_cnt orders. There should be several
    " orders for a customer (here about 30)
    data(lr_random_int) = cl_abap_random_int=>create( seed = 12345 ).
    data(lv_dup)        = co_order_cnt / 30.

    do co_order_cnt times.
      data(lv_int) = lr_random_int->get_next( ).

      append value #( order      = sy-index
                      count      = lv_int mod 42
                      suppl_id   = lv_int mod 999 + 1
                      suppl_item = lv_int mod 99 + 1
                      customer   = sy-index mod lv_dup + 1 )
        to mt_order.
    enddo.
    write: / 'Lines MT_ORDER: ' ##NO_TEXT,
             co_order_cnt.
  endmethod.

  method process.
    "---------------------------------------------------------------------------
    " Fill a result table for a customer with given id
    " - Get all orders of the customer
    " - Get the internal item id
    " - Write the new item_id and the count to the result table
    clear mt_res.

    get run time field data(lv_t1).

    loop at mt_order assigning field-symbol(<ls_order>) where customer = customer ##PRIMKEY[CUST].
      " Get the new item id
      read table mt_item assigning field-symbol(<ls_item>)
        with key suppl_id   = <ls_order>-suppl_id
                 suppl_item = <ls_order>-suppl_item ##PRIMKEY[SUPPL].
      check sy-subrc = 0.
      append value #( item_int = <ls_item>-item_int
                      count    = <ls_order>-count )
        to mt_res.
    endloop.

    get run time field data(lv_t2).
    data(lv_t0) = lv_t2 - lv_t1.
    write: / lv_t0 .

  endmethod.

  method process_part_opt.
    "---------------------------------------------------------------------------
    " Fill a result table for a customer with given id
    " - Get all orders of the customer
    " - Get the internal item id
    " - Write the new item_id and the count to the result table
    clear mt_res.

    get run time field data(lv_t1).

    loop at mt_order assigning field-symbol(<ls_order>) where customer = customer ##PRIMKEY[CUST].
      " Get the new item id
      read table mt_item assigning field-symbol(<ls_item>)
        with key suppl_id   = <ls_order>-suppl_id
                 suppl_item = <ls_order>-suppl_item.
      check sy-subrc = 0.
      append value #( item_int = <ls_item>-item_int
                      count    = <ls_order>-count )
        to mt_res.
    endloop.

    get run time field data(lv_t2).
    data(lv_t0) = lv_t2 - lv_t1.
    write: / lv_t0 .

  endmethod.

  method process_full_opt.
    "---------------------------------------------------------------------------
    " Fill a result table for a customer with given id
    " - Get all orders of the customer
    " - Get the internal item id
    " - Write the new item_id and the count to the result table
    clear mt_res.

    get run time field data(lv_t1).

    loop at mt_order assigning field-symbol(<ls_order>) where customer = customer.
      " Get the new item id
      read table mt_item assigning field-symbol(<ls_item>)
        with key suppl_id   = <ls_order>-suppl_id
                 suppl_item = <ls_order>-suppl_item.
      check sy-subrc = 0.
      append value #( item_int = <ls_item>-item_int
                      count    = <ls_order>-count )
        to mt_res.
    endloop.

    get run time field data(lv_t2).
    data(lv_t0) = lv_t2 - lv_t1.
    write: / lv_t0 .

  endmethod.

endclass.


start-of-selection.

  parameters:
    rep_cnt type i default 1.

  data:
    cust_id type i value 1234 ##NEEDED.

  data(lr_test) = new lcl_test( ) ##NEEDED.

  " Initialize tables
  lr_test->fill_item( ).
  lr_test->fill_order( ).

  " Process tables non-optimized
  skip.
  write: / 'Time PROCESS( ):' ##NO_TEXT.
  do rep_cnt times.
    lr_test->process( cust_id ).
  enddo.

  " Process tables partly optimized
  skip.
  write: / 'Time PROCESS_PART_OPT( ):' ##NO_TEXT.
  do rep_cnt times.
    lr_test->process_part_opt( cust_id ).
  enddo.

  " Process tables fully optimized
  skip.
  write: / 'Time PROCESS_FULL_OPT( ):' ##NO_TEXT.
  do rep_cnt times.
    lr_test->process_full_opt( cust_id ).
  enddo.
