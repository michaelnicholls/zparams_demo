@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'projection'

@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPARAm_C_CLASSES
  provider contract transactional_query
  as projection on zparam_i_classes

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.identification: [ { position: 10, label: 'Class name' } ]
      @UI.lineItem: [ { position: 10, label: 'Class name' } ]
  key Classname,

      @UI.identification: [ { position: 20, label: 'Description' } ]
      @UI.lineItem: [ { position: 20, label: 'Description' } ]
      ClassDescription,
 
         @UI.lineItem: [ { type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'addVariant',
                        position: 60,
                        label: 'Add global params' }]
                       
      dummy,
      
      @UI.identification: [ { position: 40, label: 'Editors' } ]
      @UI.lineItem: [ { position: 40, label: 'Editors' } ]
      editors,
      @UI.identification: [ { position: 40, label: 'Navigation to output' } ]
      @UI.lineItem: [ { position: 40, label: 'Navigation to output' } ]
      navigation
 
      
      
}
