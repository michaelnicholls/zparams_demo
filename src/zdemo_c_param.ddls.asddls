@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Parameters demo'
@UI.headerInfo.typeNamePlural: 'Variants for parameters demo'
@UI.headerInfo.title.value: 'class_description'
define root view entity zdemo_c_param
  as projection on zdemo_i_param

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
  key parguid,
    
      class_description,

      @UI.identification: [ { position: 10, label: 'Variant' } ]
     
      Variantname as variantname,
      @UI.lineItem: [ { position: 12, label: 'Variant' } ]
      variant_display        as variant_display,
      @UI.identification: [ { position: 15, label: 'Global' } ]
     
      global_flag,

 

      @UI.hidden: true
      uname,

      ///////  put your fields here /////

      @UI.identification: [ { position: 20, label: 'Integer1' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer1' } ]

      Int1               as Int1,

      @UI.identification: [ { position: 30, label: 'Integer2' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer2' } ]
      Int2               as Int2,

      @UI.identification: [ { position: 40, label: 'Operator' } ]
      @UI.lineItem: [ { position: 40, label: 'Operator' } ]
      Op                 as Op,
      @UI.identification: [ { position: 41, label: 'Checkbox' } ]
      @UI.lineItem: [ { position: 41, label: 'Checkbox' } ]
      checkbox,
    
      @UI.identification: [ { position: 43, label: 'Some date' } ]
      @UI.lineItem: [ { position: 43, label: 'Some date' } ]
      somedate,
      @UI.identification: [ { position: 44, label: 'Some time' } ]
      @UI.lineItem: [ { position: 44, label: 'Some time' } ]
      sometime,
      @UI.identification: [ { position: 45, label: 'Price' } ]
      @UI.lineItem: [ { position: 45, label: 'Price' } ]
      
      price,

      ////  end of your fields
  //    @UI.identification: [ { position: 50, label: 'Last run' } ]
      @UI.lineItem: [ { position: 70, label: 'Last run' } ]
      lastrun,
    
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
      _outputs: redirected to composition child Zdemo_c_OUTPUT
}
