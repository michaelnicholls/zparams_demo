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
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the parameters
    DATA(params) = zparam_helper=>get_params( parguid ).
    " make local variables
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(global) = COND #( WHEN params-global_flag IS INITIAL THEN `` ELSE `<Global>` ). " use back tickcs

    FINAL(int3) = params-Int3.
    FINAL(int4) = params-int4.

    zparam_helper=>write_line( parguid = parguid
                               text    = |int3: { int3 }, int4: { int4  } | ).
    DATA(crit) = zparam_helper=>green.
    IF params-startdate > params-enddate. crit = zparam_helper=>red. ENDIF.
    IF params-startdate = params-enddate. crit = zparam_helper=>orange. ENDIF.
    data(daystext) = cond string( when params-enddate - params-startdate = 1 then 'day' else 'days'  ).
    data(result) = |Difference between { params-startdate DATE = USER } and { params-enddate DATE = USER } is {  params-enddate - params-startdate } { daystext } |.
    zparam_helper=>write_line(
        parguid     = parguid
        text        = result
        criticality = crit ).
    zparam_helper=>set_latest_criticality( parguid     = parguid
                                           criticality = crit ).
           zparam_helper=>set_result(  parguid = parguid text = result ).

  ENDMETHOD.
  METHOD INIT.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Values initialized at | ).
    data(params) = zparam_helper=>get_params( parguid ).
    params-int3  = substring( val = sy-uzeit off = 2 len = 2 ).
    params-int4  = substring( val = sy-uzeit off = 4 len = 2 ).
     zparam_helper=>set_params( parguid = parguid new_params = params ).

  ENDMETHOD.

ENDCLASS.
