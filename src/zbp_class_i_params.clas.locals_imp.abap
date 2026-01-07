CLASS lhc_zclass_i_paramoutput DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ zclass_i_paramoutput RESULT result.

    METHODS rba_Params FOR READ
      IMPORTING keys_rba FOR READ zclass_i_paramoutput\_Params FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zclass_i_paramoutput IMPLEMENTATION.

  METHOD read.

  data(x) = 'x'.
  ENDMETHOD.

  METHOD rba_Params.
  data(x) = 'x'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_buffer DEFINITION.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE zclass_i_params   AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    CLASS-DATA c_table   TYPE TABLE FOR CREATE zclass_i_params.
    CLASS-DATA mt_buffer TYPE TABLE OF ty_buffer.

    CLASS-METHODS checkEditor IMPORTING parguid         TYPE sysuuid_x16
                              RETURNING VALUE(isEditor) TYPE abap_boolean.

ENDCLASS.


CLASS lcl_buffer IMPLEMENTATION.
  METHOD checkeditor.
  DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    select single uname, editors from zclass_i_params where parguid = @parguid into @data(params).
    iseditor = abap_false.
    if params-uname = myname. iseditor = abap_true. endif.
    FIND |,{ myname },| IN |,{ params-editors },|.
    if sy-subrc = 0. iseditor = abap_true. endif.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zclass_i_params DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zclass_i_params RESULT result.

*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR zclass_i_params RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zclass_i_params.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zclass_i_params.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zclass_i_params.

    METHODS read FOR READ
      IMPORTING keys FOR READ zclass_i_params RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zclass_i_params.

    METHODS execute FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~execute. " RESULT result.
    METHODS initialize FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~initialize.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zclass_i_params RESULT result.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~copy.
    METHODS clear FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~clear.
    METHODS clear_object FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~clear_object
      result result.

    METHODS execute_object FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~execute_object
      result result.

    METHODS initialize_object FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~initialize_object
      result result.
    METHODS rba_outputs FOR READ
      IMPORTING keys_rba FOR READ zclass_i_params\_outputs FULL result_requested RESULT result LINK association_links.
    METHODS execute_object_noinit FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~execute_object_noinit RESULT result.

    methods doInit importing parguid type sysuuid_x16.
    methods doExec importing parguid type sysuuid_x16.
ENDCLASS.

CLASS lhc_zclass_i_params IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  DATA table_line TYPE zclass_params.
  LOOP AT entities INTO DATA(ls_update).

        SELECT SINGLE * FROM zclass_i_params  WHERE parguid = @ls_update-parguid INTO @DATA(ls_db).

           ls_db =  CORRESPONDING #( base ( ls_db ) ls_update USING CONTROL ).
          move-CORRESPONDING ls_db to table_line.
             MODIFY zclass_params FROM @table_line.

      endloOP.
  ENDMETHOD.

  METHOD delete.
  loop at keys ASSIGNING FIELD-SYMBOL(<key>).
       DELETE FROM zclass_params WHERE parguid = @<key>-parguid.

  endloop.
  ENDMETHOD.

  METHOD read.
   DATA l_result LIKE LINE OF result.
  LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
  select single * from zclass_i_params where parguid = @<key>-parguid into @data(ls_db).
  move-CORRESPONDING ls_db to l_result.
  append l_result to result.
   endloop.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.


  METHOD execute.

  "   remember there's a version of this at execute_object
  "
    LOOP AT keys INTO DATA(ls_exec).

      IF ls_exec-%param-clear_first IS NOT INITIAL.
        zparam_helper=>clear_output( parguid = ls_exec-parguid  ).
      ENDIF.
      IF ls_exec-%param-initialize_first IS NOT INITIAL.
        doinit( parguid = ls_exec-parguid ).
      ENDIF.
      doexec( parguid = ls_exec-parguid ).
    ENDLOOP.

  ENDMETHOD.

  METHOD initialize.

  " remember there is an object version
  "
    LOOP AT keys INTO DATA(ls_init).
    doinit(  parguid = ls_init-parguid ).

    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
     DATA lt_result LIKE LINE OF result.

    SELECT * FROM zclass_i_params
      FOR ALL ENTRIES IN @keys
      WHERE parguid = @keys-parguid
      INTO TABLE @DATA(params).

    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    LOOP AT params ASSIGNING FIELD-SYMBOL(<param>).
        select count( * ) from zclass_i_params where Classname = @<param>-Classname and ( uname is initial or uname = @myname ) into @data(matching).
        data(editor) = lcl_buffer=>checkeditor( parguid = <param>-parguid ).
    clear lt_result.
      lt_result-parguid = <param>-parguid.
      lt_result-%action-execute = if_abap_behv=>fc-o-enabled.

       if matching = 1. " just global variant

          lt_result-%action-copy = if_abap_behv=>fc-o-enabled.
          if editor = abap_true.
             lt_result-%action-initialize = if_abap_behv=>fc-o-enabled.
          else.
            lt_result-%action-initialize = if_abap_behv=>fc-o-disabled.
            endif.
       else. " more than 1
          lt_result-%action-copy = if_abap_behv=>fc-o-disabled.
          if <param>-Uname = myname or editor = abap_true.
            lt_result-%action-initialize = if_abap_behv=>fc-o-enabled.
          else.
          lt_result-%action-initialize = if_abap_behv=>fc-o-disabled.
          ENDIF.

        ENDIF.
     lt_result-%delete = if_abap_behv=>fc-o-disabled.
     if <param>-Uname is not initial. lt_result-%delete = if_abap_behv=>fc-o-enabled. endif.
    lt_result-%update = lt_result-%action-initialize.
    if <param>-has_main <> abap_true.
      lt_result-%action-execute = if_abap_behv=>fc-o-disabled.
      endif.
    if <param>-has_init <> abap_true.
      lt_result-%action-initialize = if_abap_behv=>fc-o-disabled.
    endif.
     lt_result-%action-execute_object    = lt_result-%action-execute.
     lt_result-%action-execute_object_noinit = if_abap_behv=>fc-o-disabled.
    if lt_result-%action-initialize = if_abap_behv=>fc-o-disabled.
            lt_result-%action-execute_object_noinit = if_abap_behv=>fc-o-enabled.
            lt_result-%action-execute_object = if_abap_behv=>fc-o-disabled.
     endif.
   "   lt_result-%action-execute_object    = lt_result-%action-execute.
      lt_result-%action-initialize_object = lt_result-%action-initialize.

     APPEND lt_result TO result.

    ENDLOOP..


  ENDMETHOD.

  METHOD copy.
   DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    LOOP AT keys INTO DATA(lv_data).
 select single * from zclass_params where parguid = @lv_data-Parguid into  @data(current).

      current-parguid = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16(  ).
      current-uname = myname.
      MODIFY zclass_params FROM @( current ).

    ENDLOOP.
  ENDMETHOD.

  METHOD clear.

  " remember there is an object version
  "
    LOOP AT keys INTO DATA(ls_clear).
zparam_helper=>clear_output( parguid = ls_clear-parguid  ).

    ENDLOOP.


  ENDMETHOD.

  METHOD clear_object.
  "
  " remember there is a normal version of this
  "
    LOOP AT keys INTO DATA(ls_clear).

zparam_helper=>clear_output( parguid = ls_clear-parguid  ).

    ENDLOOP.
    read entities of zclass_i_params in local mode ENTITY zclass_i_params
    all FIELDS WITH CORRESPONDING #( keys )
    result data(vals).
    result = value #(  for val in vals (  %tky = val-%tky %param = val ) ).
    reported-zclass_i_params = value #(
      (   %msg = new_message_with_text(  severity = if_abap_behv_message=>severity-success text = |Output cleared| ) ) ).

  ENDMETHOD.

  METHOD execute_object.
    " there's also a version at execute

    LOOP AT keys INTO DATA(ls_exec).

      IF ls_exec-%param-clear_first IS NOT INITIAL.
        zparam_helper=>clear_output( parguid = ls_exec-parguid  ).
      ENDIF.
      IF ls_exec-%param-initialize_first IS NOT INITIAL.
        doinit( parguid = ls_exec-parguid ).
      ENDIF.
      doexec( parguid = ls_exec-parguid ).

    ENDLOOP.
    read entities of zclass_i_params in local mode ENTITY zclass_i_params
    all FIELDS WITH CORRESPONDING #( keys )
    result data(vals).
    result = value #(  for val in vals (  %tky = val-%tky %param = val ) ).
    reported-zclass_i_params = VALUE #(
        ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                        text     = |Class executed| ) ) ).
  ENDMETHOD.

  METHOD initialize_object.
    " remember there is a non-object version
    "
    LOOP AT keys INTO DATA(ls_init).
      doinit( parguid = ls_init-Parguid ).
    ENDLOOP.
    READ ENTITIES OF zclass_i_params IN LOCAL MODE ENTITY zclass_i_params
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(vals).
    result = VALUE #(  FOR val IN vals
                      (  %tky = val-%tky %param = val ) ).
*    reported-zclass_i_params = VALUE #(
*        ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
*                                        text     = |Psrameters initialized - use Refresh to see values| ) ) ).
  ENDMETHOD.



  METHOD doexec.
  DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
        DATA(lastrun) = |{ sy-datlo DATE = USER } { sy-timlo TIME = USER }|.
      SELECT SINGLE counter FROM zclass_output
        WHERE parguid = @parguid AND visible = '' AND written_by = @myname
        INTO @DATA(counter).
      IF sy-subrc > 0.
        SELECT SINGLE MAX( counter ) FROM zclass_output
          WHERE parguid = @parguid
          INTO @DATA(temp).
        counter = temp + 1.
      ENDIF.
      MODIFY zclass_output FROM @( VALUE #( parguid    = parguid
                                            counter    = counter
                                            text       = lastrun
                                            visible    = ''
                                            written_by = myname ) ).

     select single classname from zclass_i_params where Parguid = @Parguid into @data(myclassname).
     data(meth) = 'MAIN'.
      CALL METHOD (myclassname)=>(meth)
        EXPORTING parguid = parguid.


  ENDMETHOD.

  METHOD doinit.
     select single * from zclass_i_params where Parguid = @Parguid into @data(params).
      DATA(editor) = lcl_buffer=>checkeditor(  parguid = Parguid ).

      " we are either an editor or we're using a user specific variant
    if params-has_init = abap_true.
      if editor = abap_true or params-global_flag = abap_false.
        data(meth) = 'INIT'.
        CALL METHOD (params-Classname)=>(meth)
            EXPORTING parguid = parguid.
       endif.
     endif.

  ENDMETHOD.

  METHOD rba_Outputs.
  data(x) = 'x'.
  ENDMETHOD.


  METHOD execute_object_noinit.
     LOOP AT keys INTO DATA(ls_exec).

      IF ls_exec-%param-clear_first IS NOT INITIAL.
        zparam_helper=>clear_output( parguid = ls_exec-parguid  ).
      ENDIF.
      doexec( parguid = ls_exec-parguid ).

    ENDLOOP.
    read entities of zclass_i_params in local mode ENTITY zclass_i_params
    all FIELDS WITH CORRESPONDING #( keys )
    result data(vals).
    result = value #(  for val in vals (  %tky = val-%tky %param = val ) ).
    reported-zclass_i_params = VALUE #(
        ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                        text     = |Class executed| ) ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCLASS_I_PARAMS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCLASS_I_PARAMS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    CLEAR lcl_buffer=>mt_buffer.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
