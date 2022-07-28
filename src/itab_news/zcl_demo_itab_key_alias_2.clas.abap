class zcl_demo_itab_key_alias_2 definition
  public
  final
  create public .

  public section.
    class-data:
      mt_item type zcl_demo_itab_key_alias_1=>tt_item.

    class-methods:
      read_data
        importing
          im_suppl_id   type i
          im_suppl_item type i
        exporting
          ex_item       type zcl_demo_itab_key_alias_1=>ty_item.
  protected section.
  private section.
endclass.

class zcl_demo_itab_key_alias_2 implementation.
  method read_data.
    read table mt_item into ex_item
      with key k1 components suppl_id   = im_suppl_id
                             suppl_item = im_suppl_item.
  endmethod.
endclass.
