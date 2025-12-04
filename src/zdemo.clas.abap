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
    SELECT SINGLE * FROM zclass_i_params  WHERE parguid = @parguid INTO @DATA(params).
    " make local variables
   data(global) = cond #( when params-global_flag is initial then `` else `<Global>` ). " use back tickcs

    FINAL(int1) = params-Int1.
    FINAL(int2) = params-int2.
    "    data(op) = params-op.
    " delete old outputs
    " zparam_helper=>clear_output(   parguid = parguid ).

    DATA result TYPE p LENGTH 9 DECIMALS 2.
    DATA status TYPE string.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |{ myname } : Started at | ).
    DATA(ops) = '+-*/'.
    DO strlen( ops ) TIMES.
      DATA(op) = substring( val = ops
                            off = sy-index - 1
                            len = 1 ).
      DATA(prefix) = |The result of { int1 } { op } { int2 } is |.

      CASE Op.
        WHEN '+'. result = Int1 + Int2.
        WHEN '-'. result = Int1 - Int2.
        WHEN '*'. result = Int1 * Int2.
        WHEN '/'. IF int2 = 0. status = 'No division by zero'. ELSE. result = Int1 / Int2. ENDIF.
        WHEN OTHERS. status = |Bad or missing operator { op }|.
      ENDCASE.

      IF status IS INITIAL.
        zparam_helper=>write_line( parguid = parguid
                                   text    = |{  global }{ prefix } { result }| ).
      ELSE.
        zparam_helper=>write_line( parguid = parguid
                                   text    = |  { global } { status }| criticality = zparam_helper=>red  ).
      ENDIF.
    ENDDO.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Finished at | ).
  ENDMETHOD.
  METHOD INIT.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Values initialized at | ).
    SELECT SINGLE * FROM zclass_params  WHERE parguid = @parguid INTO @DATA(params).
    params-somedate = sy-datum + params-int1.
    params-sometime = sy-uzeit - params-int2.
    modify zclass_params from params.

  ENDMETHOD.

ENDCLASS.
