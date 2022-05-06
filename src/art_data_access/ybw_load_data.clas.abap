class ybw_load_data definition
  public
  final
  create public .

  public section.
    interfaces: if_oo_adt_classrun.

    constants:
      c_url_votes_csv      type string value `https://www.bundeswahlleiter.de/bundestagswahlen/2021/ergebnisse/opendata/daten/kerg2_00287.csv`,
      c_url_parties_csv    type string value `Set URL`, "`https://www.bundeswahlleiter.de/dam/jcr/9c660d9e-ef9f-4ec4-8f06-da1d031a2057/btw21_parteien.csv`,
      c_url_candidates_zip type string value `Set URL`. "`https://www.bundeswahlleiter.de/dam/jcr/cd399859-b73c-4d72-afb7-0b3c46793c56/btw21_gewaehlte_utf8.zip`.

  protected section.
  private section.
    methods:
      licence_hint returning value(rv_msg) type string,
      load_csw_via_url importing iv_url             type string
                                 iv_is_zip          type abap_bool default abap_false
                       returning value(rv_csv_data) type string,
      load_votes returning value(rv_msg) type string,
      load_parties returning value(rv_msg) type string,
      load_candidates returning value(rv_msg) type string.
endclass.



class ybw_load_data implementation.

  method if_oo_adt_classrun~main.

    if c_url_candidates_zip = `Set URL` or c_url_parties_csv = `Set URL`.
      out->write( licence_hint( ) ).
    else.
      out->write( 'Start loading votes' ).
      out->write( load_votes( ) ).

      out->write( 'Start loading parties' ).
      out->write( load_parties( ) ).

      out->write( 'Start loading candidates' ).
      out->write( load_candidates( ) ).
    endif.

  endmethod.


  method licence_hint.
    rv_msg = |Dear User, \n|.
    rv_msg &&= |\n|.
    rv_msg &&= |SAP does not ship the table contents for the YBW_.. tables directly. However this \n|.
    rv_msg &&= |program is able to parse the offical "CSV" files of the german elections 2021 and \n|.
    rv_msg &&= |insert the data into the corresponding database tables. \n|.
    rv_msg &&= |\n|.
    rv_msg &&= |The URLs for the CSV-files are not stable however. Therefore you need to update them yourself. \n|.
    rv_msg &&= |\n|.
    rv_msg &&= |The URLs can be found via web site "https://www.bundeswahlleiter.de/bundestagswahlen/2021/ergebnisse/opendata.html". \n|.
    rv_msg &&= |Following constants in this program have to be updated with the current URL: \n|.
    rv_msg &&= |  1. c_url_votes_csv      (https://www.bundeswahlleiter.de/.../kerg2_VVVVV.csv) \n|.
    rv_msg &&= |  2. c_url_parties_csv    (https://www.bundeswahlleiter.de/.../btw21_parteien.csv) \n|.
    rv_msg &&= |  3. c_url_candidates_zip (https://www.bundeswahlleiter.de/.../btw21_gewaehlte_utf8.zip) \n|.
    rv_msg &&= |\n|.
    rv_msg &&= |By using this program you acknoledge to have read and understood the \n|.
    rv_msg &&= |"Data licence Germany – attribution – version 2.0" under which opendata is provided.\n |.
  endmethod.

  method load_csw_via_url.
    cl_http_client=>create_by_url(
      exporting
        url                = iv_url
      importing
        client             = data(client)
      exceptions
        argument_not_found = 1
        others             = 2
    ).
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
          into data(rmsg)
          with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      assert fields rmsg condition sy-subrc = 0.
    endif.

    client->send(
      exceptions
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        http_invalid_timeout       = 4
        others                     = 5
    ).
    client->get_last_error( importing message = rmsg ).
    assert fields rmsg condition sy-subrc = 0.

    client->receive(
      exceptions
        http_communication_failure = 1
        http_invalid_state         = 2
        http_processing_failed     = 3
        others                     = 4
    ).
    client->get_last_error( importing message = rmsg ).
    assert fields rmsg condition sy-subrc = 0.

    if iv_is_zip = abap_true.
      data(zip) = new cl_abap_zip( ).
      zip->load( client->response->get_data( ) ).
      zip->get(
        exporting
          name    = `btw21_gewaehlte-fortschreibung_utf8.csv`
        importing
          content = data(raw_string)
      ).
      data(string_converter) = cl_abap_conv_in_ce=>create( ).
      string_converter->convert( exporting input = raw_string importing data = rv_csv_data ).
    else.
      rv_csv_data = client->response->get_cdata( ).
    endif.

    client->close(
      exceptions
        http_invalid_state = 1
        others             = 2
    ).
    client->get_last_error( importing message = rmsg ).
    assert fields rmsg condition sy-subrc = 0.
  endmethod.

  method load_votes.
    data(csv) = load_csw_via_url( c_url_votes_csv ).
    split csv at cl_abap_char_utilities=>newline into table data(rows).
    delete from ybw_vote.
    loop at rows assigning field-symbol(<row>) from 11.
      split <row> at ';' into table data(cols).
      insert ybw_vote from @(
        value #( area  = cols[ 5 ]
                 vote  = cols[ 11 ]
                 subid = cols[ 10 ]
                 kind  = cols[ 8 ]
                 party = cols[ 9 ]
                 votes = cols[ 12 ] ) ).
    endloop.
    commit work.
    rv_msg = |Votes successfully loaded into table ybw_vote|.
  endmethod.

  method load_parties.
    data(csv) = load_csw_via_url( c_url_parties_csv ).
    split csv at cl_abap_char_utilities=>newline into table data(rows).
    delete from ybw_party.
    loop at rows assigning field-symbol(<row>) from 6.
      split <row> at ';' into table data(cols).
      insert ybw_party from @(
        value #( id         = cols[ 1 ]
                 kind       = cols[ 3 ]
                 short_name = cols[ 4 ]
                 long_name  = cols[ 5 ] ) ).
    endloop.
    commit work.
    rv_msg = |Parties successfully loaded into table ybw_party|.
  endmethod.

  method load_candidates.
    data(csv) = load_csw_via_url( iv_url = c_url_candidates_zip iv_is_zip = abap_true ).
    split csv at cl_abap_char_utilities=>newline into table data(rows).
    delete from ybw_candidates.
    loop at rows assigning field-symbol(<row>) from 10.
      split <row> at ';' into table data(cols).
      data(voting_date) = cols[ 2 ].
      voting_date = voting_date+6(4) && voting_date+3(2) && voting_date(2).
      insert ybw_candidates from @(
        value #( voting_date    = voting_date
                 lastname       = cols[ 5 ]
                 firstname      = cols[ 6 ]
                 title          = cols[ 3 ]
                 addition       = cols[ 4 ]
                 gender         = cols[ 8 ]
                 birthyear      = cols[ 9 ]
                 postcode       = cols[ 10 ]
                 residence      = cols[ 11 ]
                 birthplace     = cols[ 14 ]
                 profession     = cols[ 15 ]
                 profession_key = cols[ 16 ]
                 area_code      = cols[ 19 ]
                 area_name      = cols[ 20 ]
                 party          = cols[ 22 ] ) ).
    endloop.
    commit work.
    rv_msg = |Candidates successfully loaded into table ybw_candidates|.
  endmethod.

endclass.
