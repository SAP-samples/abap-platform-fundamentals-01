class zcl_demo_itab_key_alias_1 definition
  public
  final
  create public .

  public section.
    types:
      begin of ty_item,
        item_int   type i,  " unique
        suppl_id   type i,  " suppl_id + suppl_item unique
        suppl_item type i,
      end of ty_item,
      tt_item type sorted table of ty_item with unique key item_int
                   with non-unique sorted key k1 components suppl_id suppl_item.

    class-data:
      mt_item type tt_item.

    class-methods:
      read_data
        importing
          im_suppl_id   type i
          im_suppl_item type i
        exporting
          ex_item       type ty_item.
  protected section.
  private section.
endclass.

class zcl_demo_itab_key_alias_1 implementation.
  method read_data.
    read table mt_item into ex_item
      with key k1 components suppl_id   = im_suppl_id
                             suppl_item = im_suppl_item.
  endmethod.
endclass.
