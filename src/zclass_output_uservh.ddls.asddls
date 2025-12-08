@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'output classes'
@Metadata.ignorePropagatedAnnotations: true
define view entity  zclass_output_userVH as select  distinct 
from zclass_output as o join zclass_params as p on
o.parguid = p.parguid join zparam_classes as c on c.classname = p.classname
{
//    o.parguid,
   key p.classname,
    c.classdescription,
    o.written_by
} where o.written_by = $session.user
