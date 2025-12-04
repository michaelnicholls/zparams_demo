CLASS zparam_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  class-DATA: green type n VALUE 3, orange type n value 2, red type n value 1, normal type n value 0.

    CLASS-METHODS clear_output IMPORTING parguid TYPE sysuuid_x16
                                        !all type boole_d default ' '. " clears existing outputs

    CLASS-METHODS write_timestamp IMPORTING parguid TYPE sysuuid_x16
                                            !text   TYPE string.

    CLASS-METHODS write_line IMPORTING parguid  TYPE sysuuid_x16
                                       !text    TYPE string
                                       !criticality type n default 0
                                       !visible TYPE boole_d DEFAULT 'X'. " writes a line to the end of the outputs

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPARAM_HELPER IMPLEMENTATION.


  METHOD clear_output.
  data(myname) = cl_abap_context_info=>get_user_technical_name(  ).
  select single classname from zclass_params where parguid = @parguid into @data(myclass).
  delete from zclass_output where parguid = @parguid and written_by = @myname.
  if all is not initial.
    select * from zclass_output as o join zclass_params as p on o~parguid = p~parguid
        where p~classname = @myclass
        and o~written_by = @myname
        into table @data(parguids).
     if parguids is not INITIAL.
        delete  zclass_output from table  @parguids.
    endif.
    clear parguids.
   endif.
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
                                          criticality = criticality

                                          sequence   = max_sequence + 1
                                          counter    = max_count + 1  ) ).
  ENDMETHOD.

  METHOD write_timestamp.
    write_line( parguid = parguid
    criticality = zparam_helper=>green
                text    = |{ text }{ sy-datum DATE = USER  } { sy-uzeit TIME = USER }| ).
  ENDMETHOD.
ENDCLASS.
