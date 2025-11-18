@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'consumption'

@Metadata.ignorePropagatedAnnotations: true

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

      @UI.lineItem: [ { position: 5, label: 'Description' } ]
      class_description,

      @UI.identification: [ { position: 10, label: 'Variant' } ]
      @UI.lineItem: [ { position: 10, label: 'Variant' } ]
   
      Variantname        as Variantname,
         @UI.identification: [ { position: 15, label: 'Global' } ]
      @UI.lineItem: [ { position: 15, label: 'Global' } ]
   
      global_flag,

 //    Variant,

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
      @UI.identification: [ { position: 42, label: 'Some date' } ]
      @UI.lineItem: [ { position: 42, label: 'Some date' } ]
      somedate,
      @UI.identification: [ { position: 43, label: 'Some time' } ]
      @UI.lineItem: [ { position: 43, label: 'Some time' } ]
      sometime,

      ////  end of your fields
      @UI.identification: [ { position: 50, label: 'Last run' } ]
      @UI.lineItem: [ { position: 50, label: 'Last run' } ]
      lastrun,
   
      @UI.lineItem: [ { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'execute',
                        position: 60,
                        label: 'Execute' },
                       
                      { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'clear',
                        position: 70,
                        label: 'Clear last run' } ]

      _outputs: redirected to composition child Zdemo_c_OUTPUT
}
