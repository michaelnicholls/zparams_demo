CLASS zparam_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS clear_output IMPORTING parguid TYPE sysuuid_x16. " clears existing outputs

    CLASS-METHODS write_timestamp IMPORTING parguid TYPE sysuuid_x16
                                            !text   TYPE string.

    CLASS-METHODS write_line IMPORTING parguid  TYPE sysuuid_x16
                                       !text    TYPE string
                                       !visible TYPE boole_d DEFAULT 'X'. " writes a line to the end of the outputs

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPARAM_HELPER IMPLEMENTATION.


  METHOD clear_output.
  data(myname) = cl_abap_context_info=>get_user_technical_name(  ).
  delete from zclass_output where parguid = @parguid and written_by = @myname.
  ENDMETHOD.

  METHOD write_line.
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    " get the highest line number so far
    SELECT SINGLE MAX( counter ) INTO @DATA(max_count) FROM zclass_output WHERE parguid = @parguid. "
    " get the highest sequence so far
    SELECT SINGLE MAX( sequence ) INTO @DATA(max_sequence)
      FROM zclass_output
      WHERE parguid = @parguid AND written_by = @myname.

    MODIFY zclass_output FROM @( VALUE #( parguid    = parguid
                                          text       = text
                                          visible    = visible
                                          written_by = myname
                                          sequence   = max_sequence + 1
                                          counter    = max_count + 1  ) ).
  ENDMETHOD.

  METHOD write_timestamp.
    write_line( parguid = parguid
                text    = |{ text }{ sy-datum DATE = USER  } { sy-uzeit TIME = USER }| ).
  ENDMETHOD.
ENDCLASS.
