@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'params'

@Metadata.ignorePropagatedAnnotations: true

//@UI.headerInfo.title.value: 'class_description'

define root view entity zdemo_i_param
  as select from zdemo_param

  composition [0..*] of ZDEMO_I_output as _outputs

{
  key parguid,

      variant      as Variant,
      uname,

      'demo class' as class_description, // put a description of your class here

      'ZDEMO'      as class_name, // put your class name here
      
//  put your parameters below here

      int1         as Int1,

      int2         as Int2,


      op           as Op,

      _outputs
}

where uname = $session.user // to make sure we only get our parameters
