@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'output'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCLASS_I_PARAMOUTPUT

 as select from zclass_all_outputs as o inner join zclass_params as p
on o.parguid = p.parguid
association to parent zclass_i_params as _params
on $projection.Parguid = _params.Parguid

{
     @UI.selectionField: [{position: 5}]
     @EndUserText.label: 'Parameter UUID'
       @Consumption.valueHelpDefinition: [{entity: { name: 'zclass_output_userVH', 
                                                      element: 'parguid'  }  }]
     
    key o.parguid as Parguid,
    key o.counter as Counter,
    @UI.lineItem: [{position: 20, label: 'Text', cssDefault.width: '60%' ,criticality: 'criticality', criticalityRepresentation: #WITHOUT_ICON}]
    
    o.text as Text,
    @UI.hidden: true
    o.written_by as WrittenBy,
    @UI.hidden: true
    o.visible as Visible,
      @UI.lineItem: [{position: 30, label: 'Sequence'}]
    o.sequence as Sequence,
  //  @UI.hidden: true
  
   // @UI.selectionField: [{position: 10}]
    @Consumption.valueHelpDefinition: [{entity: { name: 'zclass_output_userVH', 
                                                      element: 'classname'  }  }]
    p.classname as classname,
    o.criticality as criticality,
    @UI.lineItem: [{position: 40}]
 //   @UI.selectionField: [{position: 20}]
   cast(case when p.uname = '' then 'X' else '' end as typ_p_adwp_global)    as global_flag,
   _params
} where o.written_by = $session.user and o.visible = 'X' 
