@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'all outputs'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zclass_all_outputs as select from zclass_params as p
left outer join zclass_output as o
on  p.global_parguid = o.parguid 
{
 //  key p.global_parguid,
   key p.parguid,
   key o.counter,
   o.text,
   o.sequence,
   o.criticality,
   o.written_by,
   o.visible
}
where p.global_parguid is not null //and o.visible = 'X'// and o.written_by = $session.user
