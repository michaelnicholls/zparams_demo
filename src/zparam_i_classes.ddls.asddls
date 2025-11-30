@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'classes entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zparam_i_classes as select from zparam_classes
{
    key classname as Classname,
    classdescription as ClassDescription
}
