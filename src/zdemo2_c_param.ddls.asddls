@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Parameters demo2'
@UI.headerInfo.typeNamePlural: 'Variants for parameters demo2'
@UI.headerInfo.title.value: 'class_description'
define root view entity ZDEMO2_C_PARAM
  as projection on ZDEMO2_I_PARAM

{
  key parguid,
    
      class_description,
      Variantname as variantname,
      variant_display        as variant_display,
      global_flag,
      global_editors,
      uname,

      ///////  put your fields here /////

      @UI.identification: [ { position: 20, label: 'Integer3' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer3' } ]
      Int3               as Int3,

      @UI.identification: [ { position: 30, label: 'Integer4' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer4' } ]
      Int4               as Int4,
        ////  end of your fields
      lastrun
}
