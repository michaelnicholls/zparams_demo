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

      @UI.identification: [ { position: 20, label: 'Integer1' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer1' } ]
      Int1               as Int1,

      @UI.identification: [ { position: 30, label: 'Integer2' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer2' } ]
      Int2               as Int2,
  
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
      lastrun,
    
      _outputs: redirected to composition child Zdemo_c_OUTPUT
}
