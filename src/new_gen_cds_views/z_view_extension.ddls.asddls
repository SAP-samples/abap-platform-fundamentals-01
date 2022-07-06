@AbapCatalog.sqlViewAppendName: 'ZERWEITERUNG'
@EndUserText.label: 'CDS view extension'
extend view z_classic_view with z_view_extension {
  _scarr,
  
  @EndUserText.label: 'This is my Carrid'
  a.carrid                 as my_carrid
}
