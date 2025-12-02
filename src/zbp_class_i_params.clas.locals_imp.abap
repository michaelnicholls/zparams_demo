CLASS lhc_zclass_i_params DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zclass_i_params RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zclass_i_params RESULT result.

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

    METHODS copy FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~copy.

    METHODS execute FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~execute.

    METHODS initialize FOR MODIFY
      IMPORTING keys FOR ACTION zclass_i_params~initialize.

ENDCLASS.

CLASS lhc_zclass_i_params IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD clear.
  ENDMETHOD.

  METHOD copy.
  ENDMETHOD.

  METHOD execute.
  ENDMETHOD.

  METHOD initialize.
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
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
