@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'votes belonging to a specific party'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ybw_votes_party
  as select from ybw_vote
{
  key area  as Area,
  key vote  as Vote,
  key subid as Subid,
      party as Party,
      votes as Votes
}
where
  kind = 'Partei'
