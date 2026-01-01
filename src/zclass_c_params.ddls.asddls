@AccessControl.authorizationCheck: #NOT_REQUIRED


define root view entity ZCLASS_C_PARAMS
  provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,
//      @UI.selectionField: [{position: 5}]
//    
//      @Consumption.valueHelpDefinition: [{entity: { name: 'zclass_userVH',
//                                                      element: 'classname'  }  }]
      Classname,
  
      classdescription,
      global_flag,
      Uname,
      lastrun,
      latest_criticality,


      ///////  put all the  fields here /////

      Int1 as Int1,
      Int2 as Int2,
      Int3 as Int3,
      Op,
      startdate,
      enddate,
      Price,
      Checkbox,

      Int4,
      Sometime,
      Somedate,
      firstname,
      lastname,
      
      ////leave the _outputs
      _outputs: redirected to composition child ZCLASS_C_PARAMOUTPUT
}

where
  (
       Uname = $session.user
    or Uname = ''
  )
