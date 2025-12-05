@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'output'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zclass_i_output

 as select from zclass_output as o inner join zclass_params as p
on o.parguid = p.parguid

{
    key o.parguid as Parguid,
    key o.counter as Counter,
    @UI.lineItem: [{position: 20, label: 'Text', criticality: 'criticality'}]
    
    o.text as Text,
    @UI.hidden: true
    o.written_by as WrittenBy,
    @UI.hidden: true
    o.visible as Visible,
      @UI.lineItem: [{position: 30, label: 'Sequence'}]
    o.sequence as Sequence,
  //  @UI.hidden: true
    p.classname as classname,
    o.criticality as criticality,
     @UI.lineItem: [{position: 40}]
  @UI.selectionField: [{position: 10}]
   cast(case when p.uname = '' then 'X' else '' end as typ_p_adwp_global)    as global_flag
} where o.written_by = $session.user and o.visible = 'X' 
