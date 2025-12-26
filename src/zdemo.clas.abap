CLASS zdemo DEFINITION
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



CLASS ZDEMO IMPLEMENTATION.
  METHOD main.
    " do your work here
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the parameters
    DATA(params) = zparam_helper=>get_params( parguid ).
    " make local variables
    DATA(global) = COND #( WHEN params-global_flag IS INITIAL THEN `` ELSE `<Global>` ). " use back ticks

    FINAL(int1) = params-Int1.
    FINAL(int2) = params-int2.
    final(op) = params-op.
    " delete old outputs
    " zparam_helper=>clear_output(   parguid = parguid ).

    DATA result TYPE p LENGTH 9 DECIMALS 2.
    DATA status TYPE string.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |{ global }{ myname } : Started at | ).
    data(criticality) = zparam_helper=>normal.
      DATA(prefix) = |The result of { int1 } { op } { int2 } is |.

      CASE Op.
        WHEN '+'. result = Int1 + Int2.
        WHEN '-'. result = Int1 - Int2.
        WHEN '*'. result = Int1 * Int2.
        WHEN '/'.
            IF int2 = 0.
             status = 'No division by zero allowed'. criticality = zparam_helper=>red.
           ELSE.
           result = Int1 / Int2.
         ENDIF.
        WHEN OTHERS.
        status = |Bad or missing operator: { op }. Please select from +-*/.|.
        criticality = zparam_helper=>orange.
      ENDCASE.

      IF status IS INITIAL.
        zparam_helper=>write_line( parguid = parguid
                                   text    = |{ prefix } { result }| ).
        zparam_helper=>set_result(  parguid = parguid text = |{ prefix } { result }| ).
      ELSE.
        zparam_helper=>write_line( parguid     = parguid
                                   text        = | { status }|
                                   criticality = zparam_helper=>red  ).
       zparam_helper=>set_result(  parguid = parguid text = status ).
       ENDIF.
    zparam_helper=>set_latest_criticality( parguid = parguid criticality = criticality ).
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Finished at | ).
  ENDMETHOD.
  METHOD INIT.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Values initialized at | ).
    data(params) = zparam_helper=>get_params( parguid ).
    params-startdate = sy-datum + params-int1.
    params-enddate = sy-Datum + params-int2.
    zparam_helper=>set_params( parguid = parguid new_params = params ).

  ENDMETHOD.

ENDCLASS.
