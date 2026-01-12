@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'status of class executions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zclass_tile_status as select from zclass_i_params as p 
left outer join zparam_classes  as c on p.Classname = c.classname
{
    key p.Classname as title,
        c.classdescription as subtitle,
        p.lastrun as info,
        case min(p.latest_status)
        when 1 then 'Critical' //red
        when 2 then 'Negative'//orange
        when 3 then 'Positive' //green
        else 'Neutral' //neutral
        end as infoState,
        @OData.property.name: 'number'
        '<RESET>' as numbervalue
} where p.Uname = $session.user
group by p.Classname,c.classdescription,p.lastrun
