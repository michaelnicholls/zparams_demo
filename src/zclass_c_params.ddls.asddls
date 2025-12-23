@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'All parameters'  // useful title here
///////
/////  REMEMBER TO UPDATE THE WHERE CONDITION AT THE END
///////
@UI.headerInfo.typeNamePlural: 'All parameters'
@UI.headerInfo.title.label: 'All parameters'

define root view entity ZCLASS_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,
     @UI.selectionField: [{position: 5}]
      @Consumption.valueHelpDefinition: [{entity: { name: 'zclass_userVH', 
                                                      element: 'classname'  }  }]
    Classname,
    
      classdescription,
      global_flag,
      Uname,
      lastrun,
      //    classname,
      latest_criticality,


      ///////  put your fields here /////

      Int1                as Int1,
      Int2                as Int2,
      Int3                as Int3,
      Op,
      startdate,
      enddate,
      Price,
Checkbox,

Int4,
Sometime,
Somedate,
      /////// leave nav_all below - it prvides the link to see the output
      nav_all
}

where //Classname = 'ZDEMO' and 
(Uname = $session.user or Uname = '')
