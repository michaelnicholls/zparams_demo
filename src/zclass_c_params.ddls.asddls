@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI.headerInfo.title.value: 'Classname'
@UI.headerInfo.description.value: 'classdescription'
@UI.headerInfo.typeNamePlural: 'Parameter sets'


define root view entity ZCLASS_C_PARAMS
  provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,
    Classname,
  
      classdescription,
      global_flag,
      Uname,
      lastrun,
      latest_criticality,
      global_parguid,
      instructions, proceed,instructionsURL,


      ///////  put all the  fields here /////
    @UI.identification: [{ position:  20 }]
      Int1 as Int1,
      @UI.identification: [{ position : 24 }]
      Int2 as Int2,
      Int3 as Int3,
      @UI.identification: [{ position: 22 }]
      Op,
      startdate,
      enddate,
      Price,
      Currency,
      Mass,
      Unit,
      massTarget,
      
      
      targetunit,
      Checkbox,

      Int4,
      Sometime,
      Somedate,
      firstname,
      lastname,
      
      
filler1,filler2,
      _outputs: redirected to composition child ZCLASS_C_PARAMOUTPUT
}

where
  (
       Uname = $session.user
    or Uname = ''
  )
