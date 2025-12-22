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
                        label: 'Add global params' },
                        {type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'checkMethods',
                        position: 60,
                        label: 'Check existance of methods'
                        }]
                       
      dummy,
      @UI.lineItem: [{ position: 42, label: 'Instructions', type: #WITH_URL, url: 'instructionsURL' }]
      instructions,
      @UI.identification: [ { position: 50, label: 'Editors' } ]
      @UI.lineItem: [ { position: 50, label: 'Editors' } ]
      editors,
      @UI.identification: [ { position: 64, label: 'Has MAIN' } ]
      @UI.lineItem: [ { position: 64, label: 'Has MAIN' } ]
 
      has_main,
      @UI.identification: [ { position: 66, label: 'Has INIT' } ]
      @UI.lineItem: [ { position: 66, label: 'Has INIT' } ]
     has_init,
     instructionsURL

      
      
}
