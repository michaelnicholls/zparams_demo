# zparams_demo
This is a demonstration of using PARAMETERs type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and putting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter, which will be called at runtime from a Fiori app.  

  
We need two new tables to be created.  

The first is for storing the parameters for a global class, similar to the PARAMETERS statement in traditional ABAP reports.
I have called this [ZCLASS_PARAMS](zclass_params.txt).  It can be shared by all classes.
The second table contains any outputs from the global class. In traditional reports these would be WRITE statements.  
This table I've called [ZCLASS_OUTPUT](zclass_output_table.txt). It can be shared by all your classes.  
The end user will use a Fiori app to maintain the different parameter values, and execute the class logic.

To support this we have 2 interface level views, one for the parameters eg [zdemo_i_param](zdemo_i_param_view.txt) and another for the output eg [zdemo_i_output](zdemo_i_output_view.txt).
The zdemo_i_param view has fields for the class name and a description of the class, which will be used at runtime.  There is also a list of users who can create global variants.  

There are also 2 projection/consumption level views, eg [zdemo_c_param](zdemo_c_param_view.txt) and [zdemo_c_output](zdemo_c_output_view.txt), which provide the main annotations for the Fiori app.  

To keep track of the last execution, we have another view [zclass_out_exec](zclass_out_exec_view.txt).  

There are two unmanaged behaviour files for both the interface and consumption parameter views. There are examples [zdemo_i_param](zdemo_i_param_behaviour.txt) and [zdemo_c_param](zdemo_c_param_behaviour.txt).

After generating the behaviour implementaation class, add the code for the execute and clear actions and the setUser derivation eg [zparam_implementation](zparam_implementation.txt).  



There is a service definition [zdemo_par_svc](zdemo_par_svc.txt) which exposes the two consumption views.  

After building an appropriate service binding, and publishing it, the Fiori app can be tested and then converted into a real Fiori app for deployment through the FLP.  

The source code for a sample class file that uses the parameters can be found at [zdemo_class](zdemo_class.txt).  
The main method is required, and an optional init method can be used to set values.  If present, it will be available from the Fiori app.  

There is a helper class [zparam_helper](src/zparam_helper.clas.abap) which has methods for clearing output, writing a timestamp message, and writing new lines.  

These objects are also available in an abapGit repository.  



How the app looks on launching  <img width="1841" height="855" alt="app1" src="https://github.com/user-attachments/assets/25d4d7c6-8361-4259-b33c-00688251f9ee" />

After using the Create option
<img width="1841" height="855" alt="app_create" src="https://github.com/user-attachments/assets/dfd2c30f-dd34-4d80-a169-fe79fcf518e9" />


Multiple sets of parameters can be created, with each one getting a named variant.  

AFter Saving, select a line and Execute
<img width="1844" height="855" alt="app_before_execute" src="https://github.com/user-attachments/assets/f3fb860f-5963-4591-ad6c-8be36341396c" />




After execution, select the variant  <img width="1844" height="855" alt="app_after_execute" src="https://github.com/user-attachments/assets/7ab18a61-c1e7-45e1-823e-49b7e3f1d984" />


<img width="1854" height="855" alt="app see output" src="https://github.com/user-attachments/assets/27c4d296-065e-46d2-a3ec-e31a23bb2e86" />
