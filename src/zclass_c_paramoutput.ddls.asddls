@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption'
@UI.headerInfo.typeNamePlural: 'Outputs from class executions'
define view entity ZCLASS_C_PARAMOUTPUT as projection on ZCLASS_I_PARAMOUTPUT
{
 //   @UI.hidden: true
    key Parguid,
    @UI.hidden: true
    key Counter,
    Text,
    Sequence,
    criticality,
  //  global_flag,
    classname,
    _params: redirected to parent ZCLASS_C_PARAMS
}
