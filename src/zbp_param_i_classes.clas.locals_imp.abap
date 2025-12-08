CLASS lhc_zparam_i_classes DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zparam_i_classes RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zparam_i_classes RESULT result.

    METHODS addvariant FOR MODIFY
      IMPORTING keys FOR ACTION zparam_i_classes~addvariant.

ENDCLASS.

CLASS lhc_zparam_i_classes IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zparam_i_classes IN LOCAL MODE ENTITY zparam_i_classes
         FIELDS ( Classname )
         WITH CORRESPONDING #( keys )
         RESULT DATA(classes).

    LOOP AT classes ASSIGNING FIELD-SYMBOL(<s_class>).
      APPEND CORRESPONDING #( <s_class> ) TO result ASSIGNING FIELD-SYMBOL(<result>).
      SELECT COUNT( * ) FROM zclass_params WHERE classname = @<s_class>-Classname INTO @DATA(matching).
      IF matching = 0.
        <result>-%action-addVariant = if_abap_behv=>fc-o-enabled.

      ELSE.
        <result>-%action-addVariant = if_abap_behv=>fc-o-disabled.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD addVariant.
  read entitIES OF zparam_i_classes in LOCAL MODE entity zparam_i_classes all fields witH corRESPONDING #(  keys ) reSULT data(t_classes).
  loop at t_classes into data(s_class).
  modify    ENTITIES OF zparam_i_classes in LOCAL MODE entity zparam_i_classes update fIELDS ( dummy )
  with VALUE #( ( %tky = s_class-%tky dummy = 'X' ) ).
  endloop.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPARAM_I_CLASSES DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

 "   METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lsc_zparam_i_classes IMPLEMENTATION.
  METHOD save_modified.
    DATA buff TYPE zparam_classes.

    LOOP AT delete-zparam_i_classes ASSIGNING FIELD-SYMBOL(<item_d>).
      DELETE FROM zparam_classes WHERE classname = @<item_d>-Classname.
    ENDLOOP.

    LOOP AT create-zparam_i_classes ASSIGNING FIELD-SYMBOL(<item_c>).

      buff = CORRESPONDING #( <item_c> ).
      buff-classname = to_upper( buff-classname ).
      IF substring( val = buff-classname
                    off = 0
                    len = 1 ) <> 'Z'.
        buff-classname = |Z{ buff-classname }|.
      ENDIF.
      if buff-editors is initial.
        buff-editors = cl_abap_context_info=>get_user_technical_name( ).
      endif.
      MODIFY zparam_classes FROM @buff.

    ENDLOOP.
 loop at update-zparam_i_classes aSSIGNING fIELD-SYMBOL(<item_u>).
        select single * from zparam_classes where classname = @<item_u>-Classname into @data(ls_db).
    "    ls_db-classdescription = <item_u>-ClassDescription.
        ls_db = corRESPONDING #(  base ( ls_db ) <item_u>  using control ).
        modify zparam_classes from @ls_db.
        if <item_u>-dummy  = 'X'.
       data: p type zclass_params..
   p = value #( classname = <item_u>-Classname parguid =  cl_uuid_factory=>create_system_uuid( )->create_uuid_x16(  ) ).
    modiFY zclass_params FROM @p.

        endif.
    endloop.


  ENDMETHOD.

ENDCLASS.
