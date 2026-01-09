//
// add all parameters here
//

extend view entity zclass_i_params with

{
  @EndUserText.label: 'Integer 1'
  p.int1                                                as Int1,

  @EndUserText.label: 'Integer 2'
  p.int2                                                as Int2,

  @EndUserText.label: 'Operator'
  p.op                                                  as Op,

  @EndUserText.label: 'Checkbox'
  p.checkbox                                            as Checkbox,

  @EndUserText.label: 'Date example'
  p.somedate                                            as Somedate,

  @EndUserText.label: 'Time example'
  p.sometime                                            as Sometime,

  @EndUserText.label: 'Integer 3'
  p.int3                                                as Int3,

  @EndUserText.label: 'Integer 4'
  p.int4                                                as Int4,

  @EndUserText.label: 'Price'
  @Semantics.amount.currencyCode: 'Currency'
  p.price                                               as Price,

  @EndUserText.label: 'Currency'
  @Consumption.valueHelpDefinition: [
    {
        entity: {
            name: 'I_Currency',  // The CDS entity providing currency codes
            element: 'Currency'  // The element in I_Currency holding the code
        }
    }
]
  p.currency                                            as Currency,

  @EndUserText.label: 'Mass'
  @Semantics.quantity.unitOfMeasure: 'Unit'
  p.mass                                                as Mass,

  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_UnitOfMeasureStdVH', element: 'UnitOfMeasure' } } ]
  @EndUserText.label: 'Unit'

  p.unit as Unit,  @Semantics.quantity.unitOfMeasure: 'targetUnit'  @EndUserText.label: 'Mass (target)'    
  unit_conversion( quantity=>p.mass, source_unit=>p.unit, target_unit=>p.targetunit, error_handling=> 'KEEP_UNCONVERTED') as massTarget,  
     // cast ('KG' as abap.unit(3)) as targetUnit,   
   @EndUserText.label: 'Target unit'  
   @Consumption.valueHelpDefinition: [{    
   entity: {        name: 'I_UnitOfMeasureStdVH',        
    element: 'UnitOfMeasure'    }}]     
   p.targetunit,



  @EndUserText.label: 'Start date'
  p.startdate                                           as startdate,

  @EndUserText.label: 'End date'
  p.enddate                                             as enddate,

  @EndUserText.label: 'First name'
  p.firstname,

  @EndUserText.label: 'Last name'
  p.lastname,
  '' as filler1,
  '' as filler2
}
