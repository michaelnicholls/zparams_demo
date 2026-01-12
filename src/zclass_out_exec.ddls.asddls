@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'last execution'
@Metadata.ignorePropagatedAnnotations: true
define view entity zclass_out_exec as select distinct from zclass_all_outputs as o join zclass_params as p on o.parguid = p.parguid
{
    key o.written_by as WrittenBy,
    key o.parguid,
    p.classname,
    o.text,
    o.criticality as latest_criticality
    
} where o.visible = '' and o.written_by = $session.user
