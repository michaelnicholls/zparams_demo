@AccessControl.authorizationCheck: #NOT_REQUIRED


define root view entity ZDEMO2_I_PARAM
  as select from zclass_params as p left outer join zclass_out_exec as e on
  e.parguid = p.parguid and e.WrittenBy = $session.user

  composition [0..*] of ZDEMO2_I_OUTPUT as _outputs

{

     @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE },
                   { id: 'Results',
                     purpose: #STANDARD,
                     position: 20,
                     label: 'Results',
                     type: #LINEITEM_REFERENCE,
                     targetElement: '_outputs' } ]
  @UI.hidden: true
  key p.parguid,

       @UI.identification: [ { position: 10, label: 'Variant' } ]
       p.variantname  as Variantname,
          
          
       @UI.lineItem: [ { position: 12, label: 'Variant' } ]
       case when p.uname = ''then  concat_with_space(p.variantname,' <global>',1) else p.variantname end as variant_display,
       @UI.identification: [ { position: 15, label: 'Global' } ]
      cast ( case when p.uname = '' then 'X' else '' end as boole_d ) as global_flag,
      @UI.hidden: true
      p.uname,

      'demo class2' as class_description, // put a description of your class here

      'TRAIN-00,SYSTEMSETUP' as global_editors, // these are users who can edit global variants

      //  put your parameters below here

      p.int3         as Int3,

      p.int4         as Int4,
 
   

      /// end of your parameters
      
       @UI.lineItem: [ { position: 70, label: 'Last run' } ]
     
      e.text as lastrun,
   @UI.lineItem: [ { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'execute',
                        position: 60,
                        
                        label: 'Execute' },
                        { type: #FOR_ACTION,
                       // inline: true,
                        dataAction: 'copyVariant',
                        position: 60,
                        
                        label: 'Copy' },
                       
                        { type: #FOR_ACTION,
                       // inline: true,
                        dataAction: 'init',
                        position: 85,
                        
                        label: 'Initialize' },
                       
                      { type: #FOR_ACTION,
                   //     inline: true,
                        dataAction: 'clear',
                        position: 70,
                        label: 'Clear last run' } ]
 

      _outputs
}

where p.classname = 'ZDEMO2' and 
(p.uname = $session.user or p.uname = '') // to make sure we only get our parameters
