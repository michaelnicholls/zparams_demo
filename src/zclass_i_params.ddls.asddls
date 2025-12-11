@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'parameters used by classes'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.title.value: 'classdescription'
@UI.createHidden: true
define root view entity zclass_i_params as select from zclass_params as p 
left outer join zparam_classes  as c  on c.classname = p.classname left outer join zclass_out_exec as e on e.parguid = p.parguid and e.WrittenBy = $session.user

{
       @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
  
      @UI.lineItem: [ { position: 50, label: 'Last run' },
                        { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'execute',
                        position: 60,
                        label: 'Execute' },
                        {type: #FOR_ACTION, dataAction: 'initialize',position: 65, label: 'Initialize'},
                        {type: #FOR_ACTION, dataAction: 'copy',position: 66, label: 'Copy from global'},
                        { type: #FOR_ACTION,   dataAction: 'clear', position: 70, label: 'Clear output' }
                         ]
    @UI.hidden: true               
    key p.parguid as Parguid,
    
    @UI.hidden
    p.uname as Uname,
    
 //   @UI.identification: [ { position: 15, label: 'Global' } ]
    @UI.lineItem: [ { position: 15, label: 'Global' } ]
    cast ( case when p.uname = '' then 'X' else '' end as boole_d ) as global_flag,
   // @UI.hidden: true
    p.classname as Classname,
    @UI.hidden: true
        concat_with_space(c.classdescription,
      case when p.uname  = '' then '<global>' else '' end ,1) as classdescription,
    @UI.hidden
    c.editors as editors,
    
 
 //    @UI.identification: [ { position: 80, label: 'Last run' } ]
      @UI.lineItem: [ { position: 80, label: 'Last run', criticality: 'latest_criticality' , criticalityRepresentation: #WITHOUT_ICON}   ]  
    e.text as lastrun,
    e.latest_criticality,
    
    'See output' as navigation
}


