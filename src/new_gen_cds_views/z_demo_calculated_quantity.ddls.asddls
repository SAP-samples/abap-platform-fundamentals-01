@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'CDS view entity, calculated quantity'

define view entity Z_DEMO_CALCULATED_QUANTITY
  as select from demo_rent
{
  key apartment_id                     as ApartmentId,
      apartment_size                   as ApartmentSize,
      apartment_unit                   as ApartmentUnit,
      currency                         as Currency,
      
      // currency field and unit field in arith expression
      @Semantics.quantity.unitOfMeasure: 'calculatedUnit'
      rent_decfloat34 / apartment_size as rent_per_size,
      concat( concat(currency, '/' ), apartment_unit ) 
                                       as calculatedUnit
}
