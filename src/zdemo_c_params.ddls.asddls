@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'ZDEMO'  // useful title here
///////
/////  REMEMBER TO UPDATE THE WHERE CONDITION AT THE END
////// and the approprate navigation from zclass_e_params
///////
@UI.headerInfo.typeNamePlural: 'Parameters for zdemo'
@UI.headerInfo.title.value: 'classdescription'

define root view entity Zdemo_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,
      classdescription,
      global_flag,
      Uname,
      lastrun,
      latest_criticality,
     

      ///////  put your fields here /////

       @UI.identification: [ { position: 20 } ]
     @UI.lineItem: [ { position: 20} ]
      Int1               as Int1,

      @UI.identification: [ { position: 30 } ]
      @UI.lineItem: [ { position: 30 } ]
      Int2               as Int2,
 
      @UI.identification: [ { position: 41 }]
      @UI.lineItem: [ { position: 41} ]
      Checkbox,

      @UI.identification: [ { position: 42 } ]
      @UI.lineItem: [ { position: 42 } ]
      Somedate,

      @UI.identification: [ { position: 43 } ]
      @UI.lineItem: [ { position: 43 }]
      Sometime,
    @UI.identification: [ { position: 44 } ]
      @UI.lineItem: [ { position: 44 }]
      Price,
    
      nav_zdemo
  

}
 where Classname = 'ZDEMO' and ( Uname = $session.user  or Uname = '' )

