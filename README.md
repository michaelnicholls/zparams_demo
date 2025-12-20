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

The superset of parameters are maintained in a structure, ZCLASS_PARAMS_LOCAL, which is where new parameters should be added.

There are CDS views which support a Fiori app to maintain ZPARAM_CLASSES. These are named ZPARAM_I/C_CLASSES. There are similarly named behavior definitions, plus a service definition, ZPARAM_CLASSES, and a service binding.  
To make life easier, the service binding name should be called ZPARAM_CLASSES_O2, as this aligns with the Fiori app ZPARAMS_CLASS. The implementation code is is class ZBP_PARAM_I_CLASSES.

The ZCLASS_OUTPUT contents are viewed through a Fiori app that is based on CDS views ZCLASS_I/C_OUTPUT, and a service ZCLASS_OUTPUT. A service binding named ZCLASS_OUTPUT_O2 is assumed by the Fiori app ZCLASS_OUTPUT.  

The app is passed a parameter Parguid at run time. There is a value help view, ZCLASS_OUTPUT_USERVH, to provide a list of available outputs.  
Another view, ZCLASS_OUT_EXEC, provides the most recent run time and criticality for a particular Parguid.  

The actual parameters are maintained by the end user through a Fiori app which is created for each class.

There are some generic repository objects which are required for all classes. 
These include:
- view ZCLASS_I_PARAMS, which has some control parameters
- view ZCLASS_E_PARAMS - this is where extra parameters are added. The parameters are persisted in the append structure ZCLASS_PARAMS_LOCAL, and exposed through view ZCLASS_E_PARAMS. This is where labels should be maintained for the parameters.
- behaviour definition ZCLASS_I_PARAMS, which has the main logic
- class ZBP_CLASS_I_PARAMS, which has the implementation code for the runtime
- class ZPARAM_HELPER, which has some methods to read/write parameter values, and store text in the ZCLASS_OUTPUT table

## For each class
Each class that uses this capability needs the following objects. They should be named according to the class. In the following, I assume a class called ZDEMO.
- ZDEMO_C_PARAMS, which is a projection of ZDEMO_I_PARAMS. This is where the specific parameters for the class are specified. Setting a value for  `@UI.headerInfo.typeNamePlural`  
  such as `'Parameters for zdemo'`, will assist the end user.
- There is a WHERE condition at the end of the selection list which specifies the relevent class name. For example,

  > where Classname = 'ZDEMO' and (Uname = $session.user or Uname = '')

  which finds the parameters for ZDEMO, and finds global and user-specific variants.
- unmanaged behaviour definition projection ZDEMO_C_PARAMS, baed on the view with the same name. It's probably easiest to copy ZDEMO_PARAMS.

- service definition ZDEMO_PARAMS, which exposes ZDEMO_C_PARAMS
- service binding ZDEMO_PARAMS_O2, of type Odata 2
- a Fiori app, ZDEMO_PARAMS,  that uses the serviec binding ZDEMO_PARAMS_O2

  New classes need to be added to the master tabble by using the ZPARAM_CLASSES binding, either as a Fiori app, or in Preview mode in ADT.  

## The end user Fiori app
This app is based on a list item and object page.  
The app ZDEMO_PARAMS has some extension code beyond that of the standard Fiori list template. It is probably easiest to copy the app code to a new app and replace the component name, `demoparams`, and the Odata service and VAN names, ZDEMO_C_PARAMS. 
The standard program `/ui5/ui5_repository_load` can be used to download/upload the objects for the Fiori app. 

## FLP configuration
A new technical catalog should be created. It can contain all of the end user apps (ZDEMO_PARAMS etc), plus the output, ZCLASS_OUTPUT. The ZCLASS_OUTPUT app tile does not need to be added to a user's space.  

I'd suggest the semantic object zparams for all the apps, and the following actions:
- showall, for ZCLASS_OUTPUT. By default this uses the component `classoutput`
- classes, for ZPARAM_CLASSES. By default this uses the component `paramclasses`
- zdemo, for the specific ZDEMO app. The component will be as specified in component.js of the app.

## Hints
- remove existing VANs using /n/IWBEP/REG_VOCAN
- remove old gateway services using /n/iwbep/reg_Service
- cleanup cache using /n/IWBEP/CACHE_CLEANUP and 
/n/IWFND/CACHE_CLEANUP





  


