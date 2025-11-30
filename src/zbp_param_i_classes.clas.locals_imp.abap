CLASS lhc_zparam_i_classes DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zparam_i_classes RESULT result.

ENDCLASS.

CLASS lhc_zparam_i_classes IMPLEMENTATION.

  METHOD get_instance_authorizations.
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
      MODIFY zparam_classes FROM @buff.

    ENDLOOP.

    loop at update-zparam_i_classes aSSIGNING fIELD-SYMBOL(<item_u>).
        select single * from zparam_classes where classname = @<item_u>-Classname into @data(ls_db).
        ls_db-classdescription = <item_u>-ClassDescription.
        modify zparam_classes from @ls_db.
    endloop.

  ENDMETHOD.

ENDCLASS.
