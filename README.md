# zparams_demo
## General information
This is a demonstration of using PARAMETERs type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and putting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter, which will be called at runtime from a Fiori app.  
Optionally, there can also be a second method, called INIT, which can be used to set some standard values.
  
It is based on three tables: 
- ZPARAM_CLASSES, which contains the classes which use this capability, including the classname, a description, who is allowed to edit the global parameters, and whether there is a MAIN and/or INIT method
- ZCLASS_PARAMS, which has the different parameters to be used by the classes. This is keyed by a unique id (parguid). Each class has a global set of parameter values, and users can copy this to theier own version.
- ZCLASS_OUTPUT, which has all the outputs from when the class is executed

The superset of parameters are maintained in the table ZCLASS_PARAMS, which is where new parameters should be added.

There are CDS views which support a Fiori app to maintain ZPARAM_CLASSES. These are named ZPARAM_I/C_CLASSES. There are similarly named behavior definitions, plus a service definition, ZPARAM_CLASSES, and a service binding.  
To make life easier, the service binding name should be called ZPARAM_CLASSES_O2, as this aligns with the Fiori app ZPARAMS_CLASS. The implementation code is in class ZBP_PARAM_I_CLASSES.

The ZCLASS_OUTPUT contents are viewed as part of the object page for a set of parameters.  


The actual parameters are maintained by the end user through a Fiori app which is used by all classes.

The repository objects for this app include:
- view ZCLASS_I_PARAMS, which has some control parameters
- view ZCLASS_E_PARAMS - this is where extra parameters are added. The parameters are persisted in the append structure ZCLASS_PARAMS_LOCAL, and exposed through view ZCLASS_E_PARAMS. This is where labels should be maintained for the parameters.
- behaviour definition ZCLASS_I_PARAMS, which has the main logic
- class ZBP_CLASS_I_PARAMS, which has the implementation code for the runtime
- class ZPARAM_HELPER, which has some methods to read/write parameter values, and store text in the ZCLASS_OUTPUT table

## For each class
Each class that uses this capability needs to do the following.  
- check the existing fields in ZCLASS_PARAMS, and add any extra parameter fields
- add the fields to ZCLASS_E_PARAMS and ZCLASS_C_PARAMS, which is a projection of ZDEMO_I_PARAMS
- create a Fiori UI adaption for the object page, which should be named with the name of the class. For example, for class ZDEMO, create an adaptation named ZDEMO.
- the generated adaptation will have an id, which can be addde to the ZPARAM_CLASSES table

  New classes need to be added to the master table by using the ZPARAM_CLASSES binding, either as a Fiori app, or in Preview mode in ADT.  

## The end user Fiori app
This app, named ZCLASS_PARAMS, is based on a list item and object page, which also has a table of outputs.  



## FLP configuration
A new technical catalog should be created. It can contain all of the end user apps (ZDEMO_PARAMS etc), plus the output, ZCLASS_OUTPUT. The ZCLASS_OUTPUT app tile does not need to be added to a user's space.  

I'd suggest the semantic object zparams for all the apps, and the following actions:

- classes, for ZPARAM_CLASSES. By default this uses the component `zparamclasses`
- standard, which can be used to set class specific adaptations
- an action for each class. This uses the adaptation specific component, such as customer.zclassparams.id_1766470811448_815.
- The app has a parameter called Classname, which has a value for the class, such as ZDEMO etc
- the tile should have a label etc which specifies the class name and description.

- 
## Examples of the app running

Can be found  [here](params_example.pdf)

## Hints
- remove existing VANs using /n/IWBEP/REG_VOCAN
- remove old gateway services using /n/iwbep/reg_Service
- cleanup cache using /n/IWBEP/CACHE_CLEANUP and 
/n/IWFND/CACHE_CLEANUP





  


