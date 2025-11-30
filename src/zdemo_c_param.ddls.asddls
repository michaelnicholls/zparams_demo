@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Parameters demo'
@UI.headerInfo.typeNamePlural: 'Variants for parameters demo'
@UI.headerInfo.title.value: 'class_description'
define root view entity zdemo_c_param
  as projection on zdemo_i_param

{
  key parguid,
    
      class_description,
      Variantname as variantname,
      variant_display        as variant_display,
      global_flag,
      global_editors,
      uname,

      ///////  put your fields here /////

        @UI.fieldGroup: [{label: 'Integer1', position: 40, qualifier: 'VALUES' }]
      @UI.lineItem: [ { position: 40, label: 'Integer1' } ]
      Int1               as Int1,

      @UI.lineItem: [ { position: 42, label: 'Integer2' } ]
      @UI.fieldGroup: [{label: 'Integer2', position: 42, qualifier: 'VALUES' }]
      Int2               as Int2,
  
      @UI.lineItem: [ { position: 44, label: 'Checkbox' } ]
      @UI.fieldGroup: [{label: 'Checkbox', position: 44, qualifier: 'VALUES' }]
      
      checkbox,
    
      @UI.lineItem: [ { position: 46, label: 'Some date' } ]
      @UI.fieldGroup: [{label: 'Some date', position: 46, qualifier: 'VALUES' }]
      somedate,
      
      @UI.lineItem: [ { position: 48, label: 'Some time' } ]
      @UI.fieldGroup: [{label: 'Some time', position: 48, qualifier: 'VALUES' }]
      sometime,
      
      @UI.lineItem: [ { position: 50, label: 'Price' } ]
      @UI.fieldGroup: [{label: 'Price', position: 50, qualifier: 'VALUES' }]
       price,


      ////  end of your fields
      lastrun,
    
      _outputs: redirected to composition child Zdemo_c_OUTPUT
}
