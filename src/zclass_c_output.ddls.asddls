@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption'
@UI.headerInfo.typeNamePlural: 'Output from ZDEMO'
define root view entity zclass_c_output as projection on zclass_i_output
{
    @UI.hidden: true
    key Parguid,
    @UI.hidden: true
    key Counter,
@UI.lineItem: [{position: 20, label: 'Text', criticality: 'criticality'}]
    Text,
    @UI.lineItem: [{ position: 30 }]
    Sequence,
  //  @UI.selectionField: [{ position: 10 }]
  //  @UI.lineItem: [{position: 10, label: 'Class name'}]
    classname,
  //  @UI.hidden: true
    criticality
} where classname = 'ZDEMO'
