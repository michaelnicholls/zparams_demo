CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE zclass_i_params   AS lv_data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

  claSS-DATA c_table type table for CREATE zclass_i_params.
    CLASS-DATA mt_buffer TYPE TABLE OF ty_buffer.


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
    METHODS clear FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~clear.

    METHODS execute FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~execute.
    METHODS initialize FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~initialize.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zclass_i_params RESULT result.

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~copy.

ENDCLASS.

CLASS lhc_zclass_i_params IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  LOOP AT entities INTO DATA(ls_update).
     READ TABLE lcl_buffer=>mt_buffer ASSIGNING FIELD-SYMBOL(<ls_buffer>) WITH KEY parguid = ls_update-parguid .
      IF sy-subrc <> 0.
        " not yet in buffer, read from table

        SELECT SINGLE * FROM zclass_i_params  WHERE parguid = @ls_update-parguid INTO @DATA(ls_db).

        INSERT VALUE #( flag = 'U' lv_data = ls_db ) INTO TABLE lcl_buffer=>mt_buffer ASSIGNING <ls_buffer>.

          <ls_buffer> =  CORRESPONDING #( base ( <ls_buffer> ) ls_update USING CONTROL ).


      ENDIF.
      endloOP.
  ENDMETHOD.

  METHOD delete.
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

  METHOD clear.
  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'Z' parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.
  endlOOP.
  ENDMETHOD.

  METHOD execute.
  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'X'  parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.
  ENDMETHOD.

  METHOD initialize.
  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'I' parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.
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
      DATA(editor) = abap_false.
      FIND |,{ myname },| IN |,{ <param>-editors },|.

      IF sy-subrc = 0. editor = abap_true.ENDIF.
      " check if init method exists
      DATA r_classdescr TYPE REF TO cl_abap_classdescr.
      DATA(initclass_ok) = if_abap_behv=>fc-o-disabled.
      DATA(mainclass_ok) = if_abap_behv=>fc-o-disabled.
      TRY.
          r_classdescr ?= cl_abap_typedescr=>describe_by_name( <param>-Classname ).
          " look for INIT method

          IF line_exists( r_classdescr->methods[ name = 'INIT' ] ). initclass_ok = if_abap_behv=>fc-o-enabled. ENDIF.
       IF line_exists( r_classdescr->methods[ name = 'MAIN' ] ). mainclass_ok = if_abap_behv=>fc-o-enabled. ENDIF.

        CATCH cx_root.
      ENDTRY.
      lt_result-parguid = <param>-parguid.

       if matching = 1. " just one varaint

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

    if mainclass_ok <> if_abap_behv=>fc-o-enabled.
      lt_result-%action-execute = if_abap_behv=>fc-o-disabled.
      endif.
   if initclass_ok <> if_abap_behv=>fc-o-enabled.
      lt_result-%action-initialize = if_abap_behv=>fc-o-disabled.
      endif.

      APPEND lt_result TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD copy.
  LOOP AT keys INTO DATA(ls_clear)..


  INSERT VALUE #( flag = 'C' parguid = ls_clear-parguid  ) INTO TABLE lcl_buffer=>mt_buffer.

  endLOOP.
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
   DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).
  DATA lt_data TYPE STANDARD TABLE OF zclass_i_params.
    " find copy
    data(x) = lcl_buffer=>mt_buffer.
     lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'C' )
                       (  row-lv_data ) ).
    DATA table_line TYPE zclass_params.
    loop at lt_data into data(lv_data).
   select single * from zclass_params where parguid = @lv_data-Parguid into  @data(current).

      current-parguid = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16(  ).
      current-uname = myname.
      MODIFY zclass_params FROM @( current ).
    ENDLOOP.
    " find deletions
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'D' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      DELETE FROM zclass_params WHERE parguid = @lv_data-parguid.
    ENDLOOP.
    " find updates
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'U' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      MOVE-CORRESPONDING lv_data TO table_line.
      MODIFY zclass_params FROM @table_line.
    ENDLOOP.
    " find clear outputs
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'Z' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      zparam_helper=>clear_output( parguid = lv_data-parguid all = abap_true ).
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

     select single classname from zclass_i_params where Parguid = @lv_data-Parguid into @data(myclassname).
     DATA(meth) = 'MAIN'.
      CALL METHOD (myclassname)=>(meth)
        EXPORTING parguid = lv_data-parguid.
    ENDLOOP.
       " find initializations
    lt_data = VALUE #(  FOR row IN lcl_buffer=>mt_buffer WHERE ( flag = 'I' )
                       (  row-lv_data ) ).
    LOOP AT lt_data INTO lv_data.
      "   SELECT SINGLE parguid FROM zdemo_param INTO @DATA(parguid).
      select single classname from zclass_i_params where Parguid = @lv_data-Parguid into @myclassname.
    meth = 'INIT'.
      CALL METHOD (myclassname)=>(meth)
        EXPORTING parguid = lv_data-parguid.
    ENDLOOP.
      clear lcl_buffer=>mt_buffer.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
