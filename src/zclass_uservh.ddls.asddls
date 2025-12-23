@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'class finder'
@Metadata.ignorePropagatedAnnotations: true
define view entity  ZCLASS_USERVH as select  distinct 
from ///zclass_output as o join 
zclass_params as p //on o.parguid = p.parguid join 
join zparam_classes as c on c.classname = p.classname
{

   key p.classname,
   // key p.uname ,
   @EndUserText.label: 'Description'
    c.classdescription //,    cast(case when p.uname = '' then 'X' else '' end as typ_p_adwp_global)    as global_flag 
    
} where p.uname = $session.user or p.uname is initial
