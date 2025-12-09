@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'ZDEMO2' // useful title here

@UI.headerInfo.typeNamePlural: 'Parameters for zdemo2'
@UI.headerInfo.title.value: 'classdescription'

define root view entity ZDEMO2_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
  key Parguid,
      classdescription,

      global_flag,
      Uname,
     

      ///////  put your fields here /////

      @UI.identification: [ { position: 20, label: 'Integer3' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer3' } ]
      Int3               as Int3,

      @UI.identification: [ { position: 30, label: 'Integer4' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer4' } ]
      Int4               as Int4,
      
     @UI.identification: [ { position: 40, label: 'Start date' } ]
      @UI.lineItem: [ { position: 40, label: 'Start date' } ]
        
 
    startdate,
     @UI.identification: [ { position: 42, label: 'End date' } ]
      @UI.lineItem: [ { position: 42, label: 'End date' } ]
    enddate,
      ////  end of your fields
      lastrun,
       @UI.lineItem: [{position: 100, type: #FOR_INTENT_BASED_NAVIGATION, label : 'See output',  inline: true,
     semanticObjectAction: 'output_zdemo2' }]  // put your action here
       @Consumption.semanticObject: 'params'  // put your semantic object here
      navigation

}
 where Classname = 'ZDEMO2' and ( Uname = $session.user  or Uname = '' )

