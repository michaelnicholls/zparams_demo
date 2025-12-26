@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'parameters used by all classes'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.title.value: 'lastrun'
@UI.createHidden: true
define root view entity zclass_i_params as select from zclass_params as p 
left outer join zparam_classes  as c  on c.classname = p.classname left outer join zclass_out_exec as e on e.parguid = p.parguid and e.WrittenBy = $session.user

{
        @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
  
        @UI.identification: [ { type: #FOR_ACTION, dataAction: 'execute_object', position: 60, label: 'Execute' },
                         {type: #FOR_ACTION, dataAction: 'initialize_object',position: 65, label: 'Initialize'},
                        {type: #FOR_ACTION, dataAction: 'copy',position: 66, label: 'Copy from global'} ,
                        { type: #FOR_ACTION,   dataAction: 'clear_object', position: 70, label: 'Clear output' }
          ]
        @UI.lineItem: [ { position: 50, label: 'Last run' },
                        { type: #FOR_ACTION, inline: true, dataAction: 'execute', position: 60, label: 'Execute' },
                        {type: #FOR_ACTION, dataAction: 'initialize',position: 65, label: 'Initialize'},
                        {type: #FOR_ACTION, dataAction: 'copy',position: 66, label: 'Copy from global'},
                        { type: #FOR_ACTION,   dataAction: 'clear', position: 70, label: 'Clear output' }
                         ]
    @UI.hidden: true    
    @EndUserText.label: 'Parameter UUID'           
    key p.parguid as Parguid,
    
    @UI.hidden
    p.uname as Uname,
    
    @UI.lineItem: [ { position: 15, label: 'Global' } ]
    cast ( case when p.uname = '' then 'X' else '' end as boole_d ) as global_flag,
  @UI.selectionField: [{position: 5}]
    
      @Consumption.valueHelpDefinition: [{entity: { name: 'zclass_userVH',
                                                      element: 'classname'  }  }]
    p.classname as Classname,
   
     @UI.lineItem: [ { position: 20, label: 'Description' } ]
    concat_with_space(c.classdescription,
         case when p.uname  = '' then '<global>' else '' end ,1) as classdescription,
    @UI.hidden
    c.editors as editors,
    c.has_init as has_init,
    c.has_main as has_main,
    
    
 
    @UI.identification: [ { position: 80, label: 'Last run',  criticality: 'latest_criticality' , criticalityRepresentation: #WITHOUT_ICON}  ]
    @UI.lineItem: [ { position: 80, label: 'Last run', criticality: 'latest_criticality' , criticalityRepresentation: #WITHOUT_ICON}   ]  
    case when e.text is null then '-' else e.text end as lastrun,
    @UI.hidden: true
    e.latest_criticality
    
   
}


