CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE zdemo_i_param   AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.


    CLASS-DATA mt_buffer TYPE TABLE OF ty_buffer.

ENDCLASS.
CLASS lhc_ZDEMO_i_PARAM DEFINITION INHERITING FROM cl_abap_behavior_handler.
pubLIC SECTION.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zdemo_i_param RESULT result.


    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zdemo_i_param.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zdemo_i_param.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zdemo_i_param.

    METHODS read FOR READ
      IMPORTING keys FOR READ zdemo_i_param RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zdemo_i_param.

    METHODS rba_Outputs FOR READ
      IMPORTING keys_rba FOR READ zdemo_i_param\_Outputs FULL result_requested RESULT result LINK association_links.

    METHODS cba_Outputs FOR MODIFY
      IMPORTING entities_cba FOR CREATE zdemo_i_param\_Outputs.
    METHODS clear FOR MODIFY
      IMPORTING keys FOR ACTION ZDEMO_i_PARAM~clear.

    METHODS execute FOR MODIFY
      IMPORTING keys FOR ACTION ZDEMO_i_PARAM~execute.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zdemo_i_param RESULT result.

ENDCLASS.

CLASS lhc_ZDEMO_i_PARAM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.



  METHOD create.
  data(myname) = cl_abap_context_info=>get_user_technical_name(  ).

   LOOP AT entities INTO DATA(ls_create).
   if ls_create-global_flag is initial. ls_create-uname = myname. endif.
   if ls_create-Variantname is INITIAL. ls_create-Variantname = |variant { substring(  val = sy-datlo off = 4 ) } { sy-timlo }|. endif.
   ls_create-parguid = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16(  )..

  insert value #( flag = 'C' lv_data = corrESPONDING #( ls_create-%data ) ) into table lcl_buffer=>mt_buffer.

  endLOOP.


  ENDMETHOD.

  METHOD update.
  LOOP AT entities INTO DATA(ls_update).
     READ TABLE lcl_buffer=>mt_buffer ASSIGNING FIELD-SYMBOL(<ls_buffer>) WITH KEY parguid = ls_update-parguid .
      IF sy-subrc <> 0.
        " not yet in buffer, read from table

        SELECT SINGLE * FROM zdemo_i_param  WHERE parguid = @ls_update-parguid INTO @DATA(ls_db).

        INSERT VALUE #( flag = 'U' lv_data = ls_db ) INTO TABLE lcl_buffer=>mt_buffer ASSIGNING <ls_buffer>.

        "
        <ls_buffer> =  CORRESPONDING #( base ( <ls_buffer> ) ls_update USING CONTROL ).
          if <ls_buffer>-Variantname is INITIAL. <ls_buffer>-Variantname = |variant { substring(  val = sy-datlo off = 4 ) } { sy-timlo }|. endif.


      ENDIF.
  endLOOP.
  ENDMETHOD.

  METHOD delete.
LOOP AT keys INTO DATA(ls_delete)..


  INSERT VALUE #( flag = 'D' parguid = ls_delete-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Outputs.
  ENDMETHOD.

  METHOD cba_Outputs.
  ENDMETHOD.

  METHOD clear.

  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'Z' parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.

  ENDMETHOD.

  METHOD execute.
  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'X' parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.
  ENDMETHOD.

  METHOD get_instance_features.

  data lt_result like line of result.

  select * from zdemo_i_param for all entries in @keys
  where parguid = @keys-parguid into table @data(params).

  loop at params ASSIGNING FIELD-SYMBOL(<param>).
 lt_result-parguid = <param>-parguid.

  if <param>-global_flag is not initial.
   lt_result-%delete = if_abap_behv=>fc-o-disabled.
   else.
   lt_result-%delete = if_abap_behv=>fc-o-enabled.
   endif.

   append lt_result to result.

  ENDLOOP..
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZDEMO_i_OUTPUT DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.





    METHODS read FOR READ
      IMPORTING keys FOR READ zdemo_i_output RESULT result.

    METHODS rba_Params FOR READ
      IMPORTING keys_rba FOR READ zdemo_i_output\_Params FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZDEMO_i_OUTPUT IMPLEMENTATION.




  METHOD read.
  ENDMETHOD.

  METHOD rba_Params.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZDEMO_i_PARAM DEFINITION INHERITING FROM cl_abap_behavior_saver.
pubLIC SECTION.
"class-data tab1 type table of string.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZDEMO_i_PARAM IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zdemo_i_param.
 DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
    " find creations
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'C' )
                       (  row-lv_data ) ).
    DATA table_line TYPE zdemo_param.

    LOOP AT lt_data INTO DATA(lv_data).
      MOVE-CORRESPONDING lv_data TO table_line.
      MODIFY zdemo_param FROM @( table_line ).
    ENDLOOP.
    " find deletions
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'D' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      DELETE FROM zdemo_param WHERE parguid = @lv_data-parguid.
      delete from zclass_output where parguid = @lv_data-parguid and written_by = @myname.
    ENDLOOP.
    " find updates
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'U' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      MOVE-CORRESPONDING lv_data TO table_line.
      MODIFY zdemo_param FROM @table_line.
    ENDLOOP.
    " find clear outputs
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'Z' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      zparam_helper=>clear_output( parguid = lv_data-parguid ).
    ENDLOOP.

    " find executions
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'X' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      "   SELECT SINGLE parguid FROM zdemo_param INTO @DATA(parguid).
      DATA(lastrun) = |{ sy-datlo DATE = USER } { sy-timlo TIME = USER }|.
      SELECT SINGLE counter FROM zclass_output
        WHERE parguid = @lv_data-parguid AND visible = '' AND written_by = @myname
        INTO @DATA(counter).
      IF sy-subrc > 0.
        SELECT SINGLE MAX( counter ) FROM zclass_output
          WHERE parguid = @lv_data-parguid
          INTO @DATA(temp).
        counter = temp + 1.
      ENDIF.
      MODIFY zclass_output FROM @( VALUE #( parguid    = lv_data-parguid
                                            counter    = counter
                                            text       = lastrun
                                            visible    = ''
                                            written_by = myname ) ).

      "
      zdemo=>main( parguid = lv_data-parguid ).
    ENDLOOP.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
