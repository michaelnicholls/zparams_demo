CLASS zparam_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-DATA green  TYPE n LENGTH 1 VALUE 3.
    CLASS-DATA orange TYPE n LENGTH 1 VALUE 2.
    CLASS-DATA red    TYPE n LENGTH 1 VALUE 1.
    CLASS-DATA normal TYPE n LENGTH 1 VALUE 0.

    CLASS-METHODS get_params IMPORTING parguid       TYPE sysuuid_x16
                             RETURNING VALUE(params) TYPE zclass_i_params.

    CLASS-METHODS set_params IMPORTING parguid    TYPE sysuuid_x16
                                       new_params TYPE zclass_i_params.

    CLASS-METHODS clear_output IMPORTING parguid TYPE sysuuid_x16
                                         !all    TYPE boole_d DEFAULT ' '. " clears existing outputs

    CLASS-METHODS write_timestamp IMPORTING parguid TYPE sysuuid_x16
                                            !text   TYPE string.

    CLASS-METHODS write_line IMPORTING parguid     TYPE sysuuid_x16
                                       !text       TYPE string
                                       criticality TYPE n       DEFAULT 0
                                       !visible    TYPE boole_d DEFAULT 'X'. " writes a line to the end of the outputs

    CLASS-METHODS set_latest_criticality IMPORTING parguid     TYPE sysuuid_x16
                                                   criticality TYPE n DEFAULT 0.
   CLASS-METHODS set_result IMPORTING parguid     TYPE sysuuid_x16
                                                   text TYPE string.
     class-methods get_global_param importing parguid type sysuuid_x16
            RETURNING VALUE(g_parguid) type sysuuid_x16.
     class-METHODS get_parguid importing classname type string
                exporting parguid type sysuuid_x16
                            default_parguid type sysuuid_x16.
ENDCLASS.



CLASS ZPARAM_HELPER IMPLEMENTATION.
  METHOD clear_output.
  data(g_parguid) = get_global_param( parguid = parguid ).

    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    SELECT SINGLE classname FROM zclass_params WHERE parguid = @g_parguid INTO @DATA(myclass).
    DELETE FROM zclass_output WHERE parguid = @g_parguid AND written_by = @myname.
    IF all IS NOT INITIAL.
      SELECT *
        FROM zclass_output AS o
               JOIN
                 zclass_params AS p ON o~parguid = p~parguid
        WHERE p~classname  = @myclass
          AND o~written_by = @myname
        INTO TABLE @DATA(parguids).
      IF parguids IS NOT INITIAL.
        DELETE zclass_output FROM TABLE @parguids.
      ENDIF.
      CLEAR parguids.
    ENDIF.
  ENDMETHOD.

  METHOD write_line.
   data(g_parguid) = get_global_param( parguid = parguid ).
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the highest line number so far
    SELECT SINGLE MAX( counter ) INTO @DATA(max_count) FROM zclass_output WHERE parguid = @g_parguid. "
    " get the highest sequence so far
    SELECT SINGLE MAX( sequence ) INTO @DATA(max_sequence)
      FROM zclass_output
      WHERE parguid = @g_parguid AND written_by = @myname.

    MODIFY zclass_output FROM @( VALUE #( parguid    = g_parguid
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
  METHOD GET_PARAMS.

  select single * from zclass_i_params where Parguid = @parguid into @params.

  ENDMETHOD.

  METHOD SET_PARAMS.
  data p type zclass_params.
  move-CORRESPONDING new_params to p.

  modify zclass_params from @p.

  ENDMETHOD.

  METHOD set_latest_criticality.
    DATA(g_parguid) = get_global_param( parguid = parguid ).
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    SELECT SINGLE counter,text  FROM zclass_output
      WHERE parguid = @g_parguid AND visible = ' ' AND written_by = @myname
      INTO ( @DATA(counter),@data(text) ).

    MODIFY zclass_output FROM @( VALUE #( criticality = criticality
                                          parguid     = g_parguid
                                          counter     = counter
                                          text = text
                                          visible     = ' '
                                          written_by  = myname ) ).
  ENDMETHOD.

  METHOD set_result.
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    DATA(g_parguid) = get_global_param( parguid = parguid ).
    SELECT SINGLE counter,criticality FROM zclass_output
      WHERE parguid = @g_parguid AND visible = ' ' AND written_by = @myname
      INTO (  @DATA(counter),@data(criticality) ).
    " data(result) = |{ sy-datlo DATE = USER } { sy-timlo TIME = USER } { text }|.
    DATA(result) = text.
    MODIFY zclass_output FROM @( VALUE #( text       = result
                                          parguid    = g_parguid
                                          counter    = counter
                                          criticality = criticality
                                          visible    = ' '
                                          written_by = myname ) ).
  ENDMETHOD.

  METHOD GET_GLOBAL_PARAM.
        select single from zclass_params fields global_parguid where parguid = @parguid into @g_parguid.
  ENDMETHOD.

  METHOD get_parguid.
    " try to find the non-default parameters
    CLEAR: parguid,
           default_parguid.
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    SELECT SINGLE FROM zclass_params
      FIELDS parguid, global_parguid
      WHERE classname = @classname
        AND uname     = @myname
      INTO @DATA(params).

    IF sy-subrc = 0.
      parguid = params-parguid.
      default_parguid = params-global_parguid.
    ELSE.
      " else, get the defaults
      SELECT SINGLE FROM zclass_params
        FIELDS parguid, global_parguid
        WHERE classname  = @classname
          AND uname     IS INITIAL
        INTO @params.
      IF sy-subrc = 0.
        parguid = params-parguid.
        default_parguid = params-global_parguid.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
