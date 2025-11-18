CLASS zdemo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      " make sure you have a MAIN method with this importing parameter
      main IMPORTING parguid TYPE sysuuid_x16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDEMO IMPLEMENTATION.
  METHOD main.
    " do your work here
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the parameters
    SELECT SINGLE * FROM zdemo_i_param INTO @DATA(params) WHERE parguid = @parguid.
    " make local variables

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
                                   text    = |{ prefix } { result }| ).
      ELSE.
        zparam_helper=>write_line( parguid = parguid
                                   text    = |{ status }|   ).
      ENDIF.
    ENDDO.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Finished at | ).
  ENDMETHOD.
ENDCLASS.
