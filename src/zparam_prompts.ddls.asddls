
define root abstract entity zparam_prompts
  
{

  @EndUserText.label : 'Clear previous output'
 
    clear_first : abap_boolean;
  @EndUserText.label: 'Initialize before execution'
    initialize_first : abap_boolean;
}
