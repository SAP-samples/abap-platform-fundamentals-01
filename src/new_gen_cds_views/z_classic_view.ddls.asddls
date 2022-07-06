@AbapCatalog.sqlViewName: 'ZJIFFOIT'  //name of CDS-managed DDIC view
@bla.blue: true --no DDLA file, but valid in classic view
@ClientHandling.type: #INHERITED
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #CHECK
//@AbapCatalog.buffering:
//{ status: #ACTIVE,
//type: #GENERIC,
//numberOfKeyFields: 3 }
@AbapCatalog.compiler.compareFilter: false
@AbapCatalog.preserveKey
define view z_classic_view 
with parameters
    @EndUserText.label: 'Parameter for Carrid with data element'
    p_carrid    : s_carr_id,
    @EndUserText.label: 'Parameter for abap.int test'
    p_abap_int4 : abap.int4,
    @EndUserText.label: 'Parameter for dec test'
    p_abap_dec  : abap.dec( 8, 2 )
  as select from sflight as a
    inner join   spfli   as b on  a.carrid = b.carrid
                              and a.connid = b.connid
  //                              and 1        = 1 -- Expression: this is not possible in CDS View
  association to scarr as _scarr on a.carrid = $parameters.p_carrid
  //                                 and 1        = 1 -- Expression: this is not possible in CDS View
{
  key a.carrid,
  key a.connid             as CarridCamelCase,
      deptime, -- no prefix required
      $parameters.p_carrid as param_carrid
      //      $session.user_date                                                                                                                                                   as session_user_date, -- new session variable
      //      $session.user_timezone      as UserTimezone

      -- Expression: this combination not possible in CDS View                                                                                                                                    as session_user_timezone, -- new session variable
      //      case cast( a.carrid as char3)
      //      when substring( cast( 'AA' as char2), 1, 2)  then 'American Airlines'  -- this combination not possible in CDS View
      //      when substring( cast( 'LH' as char2), 1, 2)  then 'Lufthansa'
      //      else                                              'Others'
      //      end as CaseCast,

      //This is not supported                                                                                                                                                         as Airline,
      //       substring(  $session.user_timezone, $parameters.p_abap_int4,1*2)                                                                                                                          as func_session_timezone,

      //not supported
      //      case when a.seatsmax * 2 = case 500 when 7 then 1 end
      //      then 'x'
      //      else null
      //      end                                                                                                                                                                as Arith_on_left_side_of_case,


      //      abap.dec'.15'                                                                                                                                                        as dec_literal
}
where
  a.carrid = $parameters.p_carrid
//
//  and $parameters.p_abap_dec = abap.d16n'123.45'
// and b.distance * 5         = case a.price when 500 then 0 else 1 end
//   and cast(111 as int1)        = 256 -- Stricter check
//  and cast( '0000' as numc4  )            = '00000' -- NUMC4 compared with CHAR5 Stricter check
