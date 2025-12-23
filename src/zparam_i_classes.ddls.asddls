@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'classes entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zparam_i_classes as select from zparam_classes
{
    key classname as Classname,
    classdescription as ClassDescription,
    editors as editors,
    navigation as navigation,
    has_init,
    has_main,
    @UI.hidden: true
    concat('javascript:window.open("https://michaelnicholls.github.io/zparams/adding_class.html?class=',  
    concat(  
    concat( classname,
    concat('&desc=',classdescription )),'")')) as instructionsURL,
    
    ' ' as dummy // used to pass information at run time
}
