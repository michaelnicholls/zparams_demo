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
   data(myname) = cl_abap_context_info=>get_user_technical_name(  ).
  " get the highest line number so far
select single  max( counter )  into @data(max_count) from zclass_output where parguid = @parguid.

modify zclass_output from @( value #(    parguid = parguid text = text visible = visible written_by = myname counter = max_count + 1  ) ).
  ENDMETHOD.

  METHOD write_timestamp.
    write_line( parguid = parguid
                text    = |{ text }{ sy-datum DATE = USER  } { sy-uzeit TIME = USER }| ).
  ENDMETHOD.
ENDCLASS.
