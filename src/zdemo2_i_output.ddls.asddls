@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'output'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDEMO2_I_OUTPUT as select from zclass_output
association to parent ZDEMO2_I_PARAM as _params
    on $projection.Parguid = _params.parguid
{
    key parguid as Parguid,
    key counter as Counter,
    text as Text,
    sequence,
    _params
}
where written_by = $session.user and visible = 'X'
