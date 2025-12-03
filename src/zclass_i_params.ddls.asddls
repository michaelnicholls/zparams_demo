@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'parameters used by classes'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.title.value: 'classdescription'
@UI.createHidden: true
define root view entity zclass_i_params as select from zclass_params as p 
left outer join zparam_classes  as c  on c.classname = p.classname left outer join zclass_out_exec as e on e.parguid = p.parguid and e.WrittenBy = $session.user

{
      
      @UI.lineItem: [ { position: 50, label: 'Last run' },
                        { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'execute',
                        position: 60,
                        label: 'Execute' },
                        {type: #FOR_ACTION, dataAction: 'initialize',position: 65, label: 'Initialize'},
                        {type: #FOR_ACTION, dataAction: 'copy',position: 66, label: 'Copy from global'},
                        { type: #FOR_ACTION,   // inline: true,
                        dataAction: 'clear',
                        position: 70,
                        label: 'Clear last run' } ]
                      
    key p.parguid as Parguid,
    p.uname as Uname,
          cast ( case when p.uname = '' then 'X' else '' end as boole_d ) as global_flag,
    p.classname as Classname,
     @UI.hidden: true
    c.classdescription,
    c.editors as editors,
    p.int1 as Int1,
    p.int2 as Int2,
    p.op as Op,
    p.checkbox as Checkbox,
   p.somedate as Somedate,
    p.sometime as Sometime,
    p.int3 as Int3,
    p.int4 as Int4,
    p.price as Price,
    p.changedat as Changedat,
    e.text as lastrun
}


