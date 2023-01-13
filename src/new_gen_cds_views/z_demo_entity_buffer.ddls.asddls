@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.entityBuffer.definitionAllowed: true

define view entity z_demo_entity_buffer 
  as select from sairport
{

  key id        as Id,
  key name      as Name,
      time_zone as Time_Zone
}
