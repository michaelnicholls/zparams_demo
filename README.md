# zparams_demo
This is a demonstration of using parameters type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and outting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter.  
We then need two new tables.  
The first is for storing the parameters for a global class, similar to the PARAMETERS statement in traditional ABAP reports.
I have called this ZDEMO_PARAM.  
The second table contains any outputs from the global class. In traditional reports these would be WRITE statements.
The two table definitions can be found in this repository.  
The end user will use a Fiori app to maintain the different parameter values, and execute the class logic.

To support this we have 2 interface level views, one for the parameters eg zdemo_i_param and another for the output  zdemo_i_output.
The zdemo_i_param view has fields for the class name and a description of the class, which will be used at runtime.  

There are also 2 projection/consumption level views, eg Zdemo_c_param and zdemo_c_output, which provide the main annotations for the Fiori app.  

There are two behaviour files for both the interface and consumption parameter views.  

There is a service definition zdemo_par_svc which exposes the two consumption views.  

After building an appropriate service binding, and publishing it, the Fiori app can be tested and then converted into a real Fiori app for deployment through the FLP.

