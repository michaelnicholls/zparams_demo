CLASS zdemo2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      " make sure you have a MAIN method with this importing parameter
      main IMPORTING parguid TYPE sysuuid_x16,
      " optionally you can have an INIT method with the same importing parameter
      init importing parguid type sysuuid_x16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDEMO2 IMPLEMENTATION.
  METHOD main.
    " do your work here
    DATA(myname) = cl_abap_context_info=>get_user_technical_name( ).

    " get the parameters
  data(params) = zparam_helper=>get_params( parguid ).
    " make local variables
  data(global) = cond #( when params-global_flag is initial then `` else `<Global>` ). " use back tickcs

    FINAL(int3) = params-Int3.
    FINAL(int4) = params-int4.

    zparam_helper=>write_line( parguid = parguid
                                    text    = |int3: { int3 }, int4: { int4  } | ).
     data(crit) = zparam_helper=>green.
     if  params-startdate > params-enddate.      crit = zparam_helper=>red. endif.
          if  params-startdate = params-enddate.      crit = zparam_helper=>orange. endif.

    zparam_helper=>write_line(  parguid = parguid
    text = |Difference between { params-startdate date = user } and { params-enddate date = user } is {  params-enddate - params-startdate } days |
    criticality = crit
     ).
         zparam_helper=>set_latest_criticality( parguid = parguid criticality = crit ).


  ENDMETHOD.
  METHOD INIT.
    zparam_helper=>write_timestamp( parguid = parguid
                                    text    = |Values initialized at | ).
    data(params) = zparam_helper=>get_params( parguid ).
    params-int3  = substring( val = sy-uzeit off = 2 len = 2 ).
    params-int4  = substring( val = sy-uzeit off = 4 len = 2 ).
     zparam_helper=>set_params( parguid = parguid new_params = params ).

  ENDMETHOD.

ENDCLASS.
