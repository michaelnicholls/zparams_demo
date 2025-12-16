# zparams_demo
This is a demonstration of using PARAMETERs type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and putting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter, which will be called at runtime from a Fiori app.  
Optionally, there can also be a second method, called INIT, which can be used to set some stabdard values.
  
We need three new tables to be created.  

The first is for storing the parameters for a global class, similar to the PARAMETERS statement in traditional ABAP reports.
I have called this [ZCLASS_PARAMS](zclass_params.txt).  It can be shared by all classes.  
It is a base table, and parameters should be added to [ZCLASS_PARAMS_LOCAL](zclass_params_local.txt).  
The second table contains any outputs from the global class. In traditional reports these would be WRITE statements.  
This table I've called [ZCLASS_OUTPUT](zclass_output_table.txt). It can be shared by all your classes.  
The third table is used to define all the classes that use this mechanism. It includes a description, plus a list of users who are allowed to change default parameters.  
This is called [ZPARAM_CLASSES](zparam_classes.txt).

The end user will use a Fiori app to maintain the different parameter values, and execute the class logic.

To support this we have 2 interface level views, one for the parameters eg [zdemo_i_param](src/zdemo_i_param.ddls.asddls) and another for the output eg [zdemo_i_output](src/zdemo_i_output.ddls.asddls).
The zdemo_i_param view has fields for the class name and a description of the class, which will be used at runtime.  There is also a comma separated list of users who can create global variants.  

There are also 2 projection/consumption level views, eg [zdemo_c_param](src/zdemo_c_param.ddls.asddls) and [zdemo_c_output](src/zdemo_c_output.ddls.asddls), which provide the main annotations for the Fiori app.  

To keep track of the last execution, we have another view [zclass_out_exec](src/zclass_out_exec.ddls.asddls).  

There are two unmanaged behaviour files for both the interface and consumption parameter views. There are examples [zdemo_i_param](src/zdemo_i_param.bdef.asbdef) and [zdemo_c_param](src/zdemo_c_param.bdef.asbdef).

After generating the behaviour implementaation class, add the code for the execute, copy, initialize,  and clear actions and the setUser derivation eg [zparam_implementation](src/zbp_demo_i_param.clas.locals_imp.abap).  



There is a service definition [zdemo_par_svc](zdemo_par_svc.txt) which exposes the two consumption views.  

After building an appropriate service binding, and publishing it, the Fiori app can be tested and then converted into a real Fiori app for deployment through the FLP.  

The source code for a sample class file that uses the parameters can be found at [zdemo_class](src/zdemo.clas.abap).  
The main method is required, and an optional init method can be used to set values.  If present, it will be available from the Fiori app.  

There is a helper class [zparam_helper](src/zparam_helper.clas.abap) which has methods for clearing output, writing a timestamp message, and writing new lines.  

These objects are also available in an abapGit repository.  



How the app looks on launching  
<img width="1872" height="855" alt="app1" src="https://github.com/user-attachments/assets/a4fe42d3-be0d-4f7b-85c6-e4b0acd82454" />

Selecting create: 

<img width="1872" height="855" alt="app_create" src="https://github.com/user-attachments/assets/a447c39e-3fcc-4bf5-9f7b-25d13cb91e10" />


After using the Create option  


<img width="1872" height="855" alt="app_after_create" src="https://github.com/user-attachments/assets/65ed9db6-3404-43e5-930a-d7a68a97bff4" />

Multiple sets of parameters can be created, with each one getting a named variant.  

AFter Saving, select a line and Execute  

<img width="1872" height="855" alt="app_after_execute" src="https://github.com/user-attachments/assets/3d8cc4d8-c250-42ee-ba07-de75131df5f4" />





After execution, select the variant  
<img width="1872" height="855" alt="app see output" src="https://github.com/user-attachments/assets/44846cdf-3ddf-4b67-b657-2c0ea5be3894" />
