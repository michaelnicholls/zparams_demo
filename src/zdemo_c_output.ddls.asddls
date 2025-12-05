@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Outputs'


@UI.headerInfo.typeNamePlural: 'Output from ZDEMO'
define root view entity zdemo_c_output as projection on zclass_i_output
{
    @UI.hidden: true
    key Parguid,
    @UI.hidden: true
    key Counter,
    Text,
    Sequence,
    criticality,
    classname,
    global_flag
} where classname = 'ZDEMO'
