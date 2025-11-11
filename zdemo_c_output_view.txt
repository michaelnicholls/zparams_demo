@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'composition'

@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo.title.value: 'Counter'

define view entity Zdemo_c_OUTPUT
  as projection on ZDEMO_I_output

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
  key Parguid,

      // @UI.identification: [{position: 10, label: 'Line number'}]
      @UI.lineItem: [ { position: 10, label: 'Line number' } ]
  key Counter,

      @UI.identification: [ { position: 20, label: 'Text' } ]
      @UI.lineItem: [ { position: 20, label: 'Text', cssDefault.width: '80%' } ]
      Text,

      /* Associations */
      _params : redirected to parent zdemo_c_param
}
