@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'classes with outputs for the user'
@Metadata.ignorePropagatedAnnotations: true
define view entity  zclass_output_userVH as select  distinct 
from zclass_output as o join zclass_params as p on
o.parguid = p.parguid join zparam_classes as c on c.classname = p.classname
{
@EndUserText.label: 'Class'
   key p.classname,
   @EndUserText.label: 'Description'
    c.classdescription,
      o.written_by
} where o.written_by = $session.user
