@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Outputs'


@UI.headerInfo.title.value: 'Counter'

define view entity ZDEMO2_C_OUTPUT
  as projection on ZDEMO2_I_output

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
                   
        @UI.hidden: true
                 
  key Parguid,

      // @UI.identification: [{position: 10, label: 'Line number'}]
    //  @UI.lineItem: [ { position: 10, label: 'Line number' } ]
  key Counter,

      @UI.identification: [ { position: 20, label: 'Sequence' } ]
      @UI.lineItem: [ { position: 20, label: 'Sequence' } ]
      sequence,

      @UI.identification: [ { position: 20, label: 'Text' } ]
      @UI.lineItem: [ { position: 20, label: 'Text' } ]
      Text,

      /* Associations */
      _params : redirected to parent zdemo2_c_param
}
