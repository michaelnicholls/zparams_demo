@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Outputs'


@UI.headerInfo.title.value: 'Counter'
@UI.headerInfo.typeNamePlural: 'Output from ZDEMO2'
define root  view entity ZDEMO2_C_OUTPUT
  as projection on zclass_i_output
{
    @UI.hidden: true
    key Parguid,
    @UI.hidden: true
    key Counter,
    Text,
    Sequence,
    criticality,
    global_flag
} where classname = 'ZDEMO2'
