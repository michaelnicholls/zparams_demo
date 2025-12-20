@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'ZDEMO'  // useful title here
///////
/////  REMEMBER TO UPDATE THE WHERE CONDITION AT THE END
///////
@UI.headerInfo.typeNamePlural: 'Parameters for zdemo'
@UI.headerInfo.title.value: 'classdescription'

define root view entity ZDEMO_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,

      classdescription,
      global_flag,
      Uname,
      lastrun,
      //    classname,
      latest_criticality,


      ///////  put your fields here /////

      @UI.identification: [ { position: 20 } ]
      @UI.lineItem: [ { position: 20 } ]
      Int1                as Int1,

      @UI.identification: [ { position: 30 } ]
      @UI.lineItem: [ { position: 30 } ]
      Int2                as Int2,

      @UI.identification: [ { position: 33 } ]
      @UI.lineItem: [ { position: 33 } ]
      Int3                as Int3,

      @UI.identification: [ { position: 41 } ]
      @UI.lineItem: [ { position: 41 } ]
      Op,

      @UI.identification: [ { position: 42 } ]
      @UI.lineItem: [ { position: 42 } ]
      startdate,

      @UI.identification: [ { position: 43 } ]
      @UI.lineItem: [ { position: 43 } ]
      enddate,

      @UI.identification: [ { position: 44 } ]
      @UI.lineItem: [ { position: 44 } ]
      Price,

      /////// leave nav_all below - it prvides the link to see the output
      nav_all
}

where Classname = 'ZDEMO' and (Uname = $session.user or Uname = '')
