@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'consumption'


@UI.headerInfo.title.value: 'classdescription'

define root view entity Zdemo_C_PARAMS provider contract transactional_query
  as projection on zclass_i_params

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.hidden: true
  key Parguid,

      @UI.lineItem: [ { position: 5, label: 'Description' } ]
      classdescription,

 
         @UI.identification: [ { position: 15, label: 'Global' } ]
      @UI.lineItem: [ { position: 15, label: 'Global' } ]
   
      global_flag,

 //    Variant,

      @UI.hidden: true
      Uname,

      ///////  put your fields here /////

      @UI.identification: [ { position: 20, label: 'Integer1' } ]
      @UI.lineItem: [ { position: 20, label: 'Integer1' } ]

      Int1               as Int1,

      @UI.identification: [ { position: 30, label: 'Integer2' } ]
      @UI.lineItem: [ { position: 30, label: 'Integer2' } ]
      Int2               as Int2,

 
      @UI.identification: [ { position: 41, label: 'Checkbox' } ]
      @UI.lineItem: [ { position: 41, label: 'Checkbox' } ]
      Checkbox,
      @UI.identification: [ { position: 42, label: 'Some date' } ]
      @UI.lineItem: [ { position: 42, label: 'Some date' } ]
      Somedate,
      @UI.identification: [ { position: 43, label: 'Some time' } ]
      @UI.lineItem: [ { position: 43, label: 'Some time' }]
      Sometime,

      ////  end of your fields
    @UI.identification: [ { position: 80, label: 'Last run' } ]
      @UI.lineItem: [ { position: 80, label: 'Last run' }   ]  
      lastrun

}
 where Classname = 'ZDEMO' and ( Uname = $session.user  or Uname = '' )

