// @AbapCatalog.sqlViewName: 'NOT_REQUIRED' // not required anymore
//@bla.blue: true --Stricter check
//@ClientHandling.algorithm: #SESSION_VARIABLE   //not allowed
@AccessControl.authorizationCheck: #CHECK







define view entity z_demo_no_1 
with parameters
    @EndUserText.label: 'Parameter for Carrid with data element'
    p_carrid      : s_carr_id,
    @EndUserText.label: 'Parameter for abap.int test'
    p_abap_int4   : abap.int4,
    @EndUserText.label: 'Parameter for dec test'
    p_abap_dec    : abap.dec( 8, 2 )
  as select from sflight as a
    inner join   spfli   as b on  a.carrid = b.carrid
                              and a.connid = b.connid
                              and 1        = 1           -- literal on left side of ON condition
  association to scarr as _scarr on  a.carrid = $parameters.p_carrid
                                 and 1        = 1 --- literal on left side of ON condition
{
  key a.carrid, 
  key a.connid,
      b.deptime, -- prefix mandatory
      $parameters.p_carrid        as param_carrid,
      $session.user_date          as session_user_date, -- new session variable
      $session.user_timezone      as sessionTime,
      
      //case expression with expressions and functions as operands
      case cast( a.carrid as char3) 
      when substring( cast( 'AA'  as char2), 1, 2)  then 'American Airlines' 
      when substring( cast( 'LH'  as char2), 1, 2)  then 'Lufthansa'
      else                                              'Others'
      end                         as Airline,
      
      //substring with session variable, parameter, and arith_exp as operands                                                                                         
      substring(  $session.user_timezone, $parameters.p_abap_int4,1*2)                            
                                  as func_session_timezone,
      
      // complex case with expressions as operands and with new statement ELSE NULL
      case when a.seatsmax * 2 = case 500 when 7 then 1 end
      then 'x'
      else null
      end                         as Arith_on_left_side_of_case,

//new feature: typed literal
      abap.dec'.15'               as dec_literal
}
//expressions as operands of WHERE clause
where
      a.carrid               = $parameters.p_carrid
  and $parameters.p_abap_dec = abap.d16n'123.45'
  and b.distance * 5         = case a.price when 500 then 0 else 1 end
//   and cast(111 as int1)        = 256 -- Stricter check
//  and cast( '0000' as numc4  )            = '00000' -- NUMC4 compared with CHAR5 Stricter check
