

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
  DATA lt_items_upd TYPE TABLE FOR UPDATE zdemo_i_param.
  read ENTITIES of zdemo_i_param
  IN LOCAL MODE ENTITY zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) result data(lt_x).
  "lt_items_upd = CORRESPONDING #( keys ).
 " select single max( variant ) INTO @data(maxvar) from zdemo_param WHERE uname = @sy-uname." GROUP BY variant .
  loop at lt_x ASSIGNING FIELD-SYMBOL(<ls_x>).
  <ls_x>-Uname = sy-uname.
 if <ls_x>-global_flag is not initial. <ls_x>-uname = ''. endif.

  ENDLOOP.
  lt_items_upd = CORRESPONDING #( lt_x ).
  modify entity IN LOCAL MODE zdemo_i_param UPDATE FIELDS ( Uname   ) with lt_items_upd REPORTED data(ls_reported).
  reported = CORRESPONDING #( DEEP ls_reported ).
  ENDMETHOD.

  METHOD execute.
  READ ENTITY IN LOCAL MODE zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_params).
  data(lastrun) = |{ sy-datlo date = user  } { sy-timlo time = user }|.

  loop at lt_params ASSIGNING FIELD-SYMBOL(<ls_params>).
  " find our parameters
  select single * into @data(class_details)
    from zdemo_i_param  where parguid = @<ls_params>-parguid.
    " get any existing history record
    select single counter from zclass_output into @data(counter) where parguid = @<ls_params>-parguid and visible = '' and written_by = @sy-uname.
    if sy-subrc > 0.
    select single max( counter ) into @data(temp) from zclass_output where parguid = @<ls_params>-parguid.
    counter = temp + 1.
    endif.
   modify zclass_output from @( value #( parguid = <ls_params>-parguid counter = counter text = lastrun visible = '' written_by = sy-uname ) ).

    call method (class_details-class_name)=>main EXPORTING parguid = class_details-parguid .
  endloop.


  ENDMETHOD.

  METHOD clear.
    READ ENTITY IN LOCAL MODE zdemo_i_param ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_params).
  loop at lt_params ASSIGNING FIELD-SYMBOL(<ls_params>).
    zparam_helper=>clear_output( parguid = <ls_params>-parguid ).

  endloop.
  ENDMETHOD.

ENDCLASS.
