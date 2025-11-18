



CLASS lhc_zdemo_i_param DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zdemo_i_param RESULT result.
    METHODS setuser FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zdemo_i_param~setuser.
    METHODS execute FOR MODIFY
      IMPORTING keys FOR ACTION zdemo_i_param~execute.
    METHODS clear FOR MODIFY
      IMPORTING keys FOR ACTION zdemo_i_param~clear.


ENDCLASS.

CLASS lhc_zdemo_i_param IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setUser.
   data(myname) = cl_abap_context_info=>get_user_technical_name(  ).


  DATA lt_items_upd TYPE TABLE FOR UPDATE zdemo_i_param.
  read ENTITIES of zdemo_i_param
  IN LOCAL MODE ENTITY zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) result data(lt_x).

  loop at lt_x ASSIGNING FIELD-SYMBOL(<ls_x>).
  <ls_x>-Uname = myname.
 if <ls_x>-global_flag is not initial. <ls_x>-uname = ''. endif.

  ENDLOOP.
  lt_items_upd = CORRESPONDING #( lt_x ).
  modify entity IN LOCAL MODE zdemo_i_param UPDATE FIELDS ( Uname   ) with lt_items_upd REPORTED data(ls_reported).
  reported = CORRESPONDING #( DEEP ls_reported ).
  ENDMETHOD.

  METHOD execute.
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    READ ENTITY IN LOCAL MODE zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_params).
    DATA(lastrun) = |{ sy-datlo DATE = USER  } { sy-timlo TIME = USER }|.

    LOOP AT lt_params ASSIGNING FIELD-SYMBOL(<ls_params>).
      " find our parameters
      SELECT SINGLE * INTO @DATA(class_details)
        FROM zdemo_i_param
        WHERE parguid = @<ls_params>-parguid.
      " get any existing history record
      SELECT SINGLE counter FROM zclass_output
        INTO @DATA(counter)
        WHERE parguid = @<ls_params>-parguid AND visible = '' AND written_by = @myname.
      IF sy-subrc > 0.
        SELECT SINGLE MAX( counter ) INTO @DATA(temp) FROM zclass_output WHERE parguid = @<ls_params>-parguid.
        counter = temp + 1.
      ENDIF.
      MODIFY zclass_output FROM @( VALUE #( parguid    = <ls_params>-parguid
                                            counter    = counter
                                            text       = lastrun
                                            visible    = ''
                                            written_by = myname ) ).

      CALL METHOD (class_details-class_name)=>main
        EXPORTING parguid = class_details-parguid.
    ENDLOOP.
  ENDMETHOD.

  METHOD clear.
    READ ENTITY IN LOCAL MODE zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_params).
  loop at lt_params ASSIGNING FIELD-SYMBOL(<ls_params>).
    zparam_helper=>clear_output( parguid = <ls_params>-parguid ).

  endloop.
  ENDMETHOD.


ENDCLASS.
