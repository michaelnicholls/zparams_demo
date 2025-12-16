@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UUID finder'
@Metadata.ignorePropagatedAnnotations: true
define view entity  zclass_output_userVH as select  distinct 
from zclass_output as o join zclass_params as p on
o.parguid = p.parguid join zparam_classes as c on c.classname = p.classname
{
@EndUserText.label: 'UUID'
   key p.parguid,
     p.classname ,
   @EndUserText.label: 'Description'
    c.classdescription,
 cast(case when p.uname = '' then 'X' else '' end as typ_p_adwp_global)    as global_flag 
    
} where o.written_by = $session.user
