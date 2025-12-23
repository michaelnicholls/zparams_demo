@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'class finder'
@Metadata.ignorePropagatedAnnotations: true
define view entity  ZCLASS_USERVH as select  distinct 
from 
zclass_params as p 
join zparam_classes as c on c.classname = p.classname
{

   key p.classname,
  
   @EndUserText.label: 'Description'
    c.classdescription 
    
} where p.uname = $session.user or p.uname is initial
