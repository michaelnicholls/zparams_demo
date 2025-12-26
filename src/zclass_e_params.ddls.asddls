//
// add all parameters here
//

extend view entity zclass_i_params with

{
  @EndUserText.label: 'Integer 1'
  p.int1        as Int1,

  @EndUserText.label: 'Integer 2'
  p.int2        as Int2,

  @EndUserText.label: 'Operator'
  p.op          as Op,

  @EndUserText.label: 'Checkbox'
  p.checkbox    as Checkbox,

  @EndUserText.label: 'Date example'
  p.somedate    as Somedate,

  @EndUserText.label: 'Time example'
  p.sometime    as Sometime,

  @EndUserText.label: 'Integer 3'
  p.int3        as Int3,

  @EndUserText.label: 'Integer 4'
  p.int4        as Int4,

  @EndUserText.label: 'Price'
  p.price       as Price,

  @EndUserText.label: 'Start date'
  p.startdate   as startdate,

  @EndUserText.label: 'End date'
  p.enddate     as enddate,
  @EndUserText.label: 'First name'
 p.firstname,
  @EndUserText.label: 'Last name'
 p.lastname,

  ////////// leave nav_all below
  //////////
  @Consumption.semanticObject: 'zparams'
  @UI.lineItem: [ { type: #WITH_INTENT_BASED_NAVIGATION,
                    semanticObjectAction: 'showall',
                    position: 90,
                    label: 'Show output' } ]
  'Show output' as nav_all
}
