
define root abstract entity ZPARAM_PROMPTS_NOINIT

{
  @EndUserText.label: 'Clear previous output'

  clear_first : abap_boolean;

  @EndUserText.label: 'Use default values'
  use_default : abap_boolean;
}
