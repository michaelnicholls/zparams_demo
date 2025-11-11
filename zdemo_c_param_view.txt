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
      @UI.lineItem: [ { position: 10, type: #FOR_ACTION, dataAction: 'execute', label: 'Execute' } ]
  key parguid,

      @UI.identification: [ { position: 10, label: 'Variant' } ]
      @UI.lineItem: [ { position: 10, label: 'Variant' } ]

      Variant            as Variant,

      @UI.hidden: true
      uname,

      @UI.lineItem: [ { position: 5, label: 'Description' } ]
      class_description,

      @UI.identification: [ { position: 20, label: 'Integer1' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer1' } ]

      Int1               as Int1,

      @UI.identification: [ { position: 30, label: 'Integer2' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer2' } ]
      Int2               as Int2,

      @UI.identification: [ { position: 40, label: 'Operator' } ]
      @UI.lineItem: [ { position: 40, label: 'Operator' } ]
      Op                 as Op,

      _outputs: redirected to composition child Zdemo_c_OUTPUT
}
