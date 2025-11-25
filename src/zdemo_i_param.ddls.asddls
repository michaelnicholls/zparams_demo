@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'params'

@Metadata.ignorePropagatedAnnotations: true

//@UI.headerInfo.title.value: 'class_description'

define root view entity zdemo_i_param
  as select from zdemo_param as p left outer join zclass_out_exec as e on
  e.parguid = p.parguid and e.WrittenBy = $session.user

  composition [0..*] of ZDEMO_I_output as _outputs

{
  key p.parguid,

//      variant      as Variant,
      p.variantname  as Variantname,
      case when p.uname = ''then  concat_with_space(p.variantname,' <global>',1) else p.variantname end as variant_display,
     
      cast ( case when p.uname = '' then 'X' else '' end as boole_d ) as global_flag,
      p.uname,

      'demo class' as class_description, // put a description of your class here

      'ZDEMO'      as class_name, // put your class name here
      'TRAIN-00,SYSTEMSETUP' as global_editors, // these are users who can edit global variants

      //  put your parameters below here

      p.int1         as Int1,

      p.int2         as Int2,


      p.op           as Op,
      p.checkbox,
      p.somedate,
      p.sometime,
      p.price,
   

      /// end of your parameters
      
     
      e.text as lastrun,


      _outputs
}

where p.uname = $session.user or p.uname = '' // to make sure we only get our parameters
