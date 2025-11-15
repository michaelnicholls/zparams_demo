# zparams_demo
This is a demonstration of using PARAMETERs type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and putting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter, which will be called at runtime from a Fiori app.  

  
We need two new tables to be created.  
The first is for storing the parameters for a global class, similar to the PARAMETERS statement in traditional ABAP reports.
I have called this [ZDEMO_PARAM](zdemo_param_table.txt).  
The second table contains any outputs from the global class. In traditional reports these would be WRITE statements.  
This table I've called [ZCLASS_OUTPUT](zclass_output_table.txt). It can be shared by all your classes.  
The end user will use a Fiori app to maintain the different parameter values, and execute the class logic.

To support this we have 2 interface level views, one for the parameters eg [zdemo_i_param](zdemo_i_param_view.txt) and another for the output eg [zdemo_i_output](zdemo_i_output_view.txt).
The zdemo_i_param view has fields for the class name and a description of the class, which will be used at runtime.  

There are also 2 projection/consumption level views, eg [zdemo_c_param](zdemo_c_param_view.txt) and [zdemo_c_output](zdemo_c_output_view.txt), which provide the main annotations for the Fiori app.  

There are two behaviour files for both the interface and consumption parameter views. There are examples [zdemo_i_param](zdemo_i_param_behaviour.txt) and [zdemo_c_param](zdemo_c_param_behaviour.txt).

After generating the behaviour implementaation class, add the code for the execute and clear actions and the setUser derivation eg [zparam_implementation](zparam_implementation.txt).  



There is a service definition [zdemo_par_svc](zdemo_par_svc.txt) which exposes the two consumption views.  

After building an appropriate service binding, and publishing it, the Fiori app can be tested and then converted into a real Fiori app for deployment through the FLP.  

The source code for a sample class file that uses the parameters can be found at [zdemo_class](zdemo_class.txt).  
There is a helper class [zparam_helper](zparam_helper.txt) which has methods for clearing output, writing a timestamp message, and writing new lines.  



How the app looks on launching  
<img width="1828" height="328" alt="app1" src="https://github.com/user-attachments/assets/d3a063c5-bf4f-46e3-a249-2a7a983c1f21" />
After using the Create option

<img width="1828" height="328" alt="app_create" src="https://github.com/user-attachments/assets/0f3e24cd-ea0f-4516-94da-d563befac31f" />

Multiple sets of parameters can be created, with each one getting a numbered variant.  

AFter Saving, select a line and Execute



<img width="1828" height="328" alt="app_before_execute" src="https://github.com/user-attachments/assets/97509a5c-7d08-4c1a-9dcd-486deb7a4942" />

After execution, select the variant

<img width="1843" height="399" alt="app_after_execute" src="https://github.com/user-attachments/assets/44265071-60ce-46bb-9ce0-32f42531adaa" />
