@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'consumption'

@UI.headerInfo.typeNamePlural: 'Parameters for zdemo2'
@UI.headerInfo.title.value: 'classdescription'

define root view entity ZDEMO2_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.hidden: true
  key Parguid,

  //    @UI.lineItem: [ { position: 5, label: 'Description' } ]
 
      classdescription,

 
         @UI.identification: [ { position: 15, label: 'Global' } ]
      @UI.lineItem: [ { position: 15, label: 'Global' } ]
   
      global_flag,

 //    Variant,

      @UI.hidden: true
      Uname,

      ///////  put your fields here /////

      @UI.identification: [ { position: 20, label: 'Integer3' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer3' } ]

      Int3               as Int3,

      @UI.identification: [ { position: 30, label: 'Integer4' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer4' } ]
      Int4               as Int4,

 
 

      ////  end of your fields
    @UI.identification: [ { position: 80, label: 'Last run' } ]
      @UI.lineItem: [ { position: 80, label: 'Last run' }   ]  
      lastrun,
      navigation

}
 where Classname = 'ZDEMO2' and ( Uname = $session.user  or Uname = '' )

