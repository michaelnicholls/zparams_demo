CLASS zdemo2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      " make sure you have a MAIN method with this importing parameter
      main IMPORTING parguid TYPE sysuuid_x16,
      " optionally you can have an INIT method with the same importing parameter
      init importing parguid type sysuuid_x16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDEMO2 IMPLEMENTATION.
  METHOD main.
    " do your work here
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the parameters
    SELECT SINGLE * FROM zclass_i_params  WHERE parguid = @parguid INTO @DATA(params).
    " make local variables
  data(global) = cond #( when params-global_flag is initial then `` else `<Global>` ). " use back tickcs

    FINAL(int3) = params-Int3.
    FINAL(int4) = params-int4.

    zparam_helper=>write_line( parguid = parguid
                                    text    = |int3: { int3 }, int4: { int4  } | ).

  ENDMETHOD.
  METHOD INIT.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Values initialized at | ).
    SELECT SINGLE * FROM zclass_params  WHERE parguid = @parguid INTO @DATA(params).
    params-int3  = substring( val = sy-uzeit off = 2 len = 2 ).
    params-int4  = substring( val = sy-uzeit off = 4 len = 2 ).
    modify zclass_params from params.

  ENDMETHOD.

ENDCLASS.
