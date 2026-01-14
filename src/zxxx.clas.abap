CLASS zxxx DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zxxx IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( |Console output| ).
    zparam_helper=>get_parguid( EXPORTING classname       = 'ZXXX'
                                IMPORTING parguid         = DATA(parguid)
                                          default_parguid = DATA(default_parguid) ).
    out->write( |{ parguid } { default_parguid }| ).
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(is_global) = abap_false.
    IF parguid = default_parguid. is_global = abap_true. ENDIF.

    DATA(params) = zparam_helper=>get_params( parguid = parguid ).
    DATA(default_params) = zparam_helper=>get_params( parguid = default_parguid ).
    out->write( |Default int1 { default_params-Int1 }| ).
    out->write( |User    int1 { params-Int1 }| ).
    " set int2
    params-int2 = 666.
    zparam_helper=>set_params( parguid    = parguid
                               new_params = params ).
  ENDMETHOD.
ENDCLASS.
