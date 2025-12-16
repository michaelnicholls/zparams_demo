@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption'
@UI.headerInfo.typeNamePlural: 'Outputs from class executions'
define root view entity zclass_c_output as projection on zclass_i_output
{
 //   @UI.hidden: true
    key Parguid,
    @UI.hidden: true
    key Counter,
    Text,
    Sequence,
    criticality,
  //  global_flag,
    classname
}
