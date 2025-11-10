# zparams_demo
This is a demonstration of using parameters type capabilites when there is no SAP GUI available for the users.  
It is based on moving the ABAP processing logic from a traditional report and outting it into a global class.  
I have attached an example called ZDEMO. It needs a static method called MAIN with a specially named importing parameter.  
We then need two new tables.  
The first is for storing the parameters for a global class, similar to the PARAMETERS statement in traditional ABAP reports.
I have called this ZDEMO_PARAM.  
The second table contains any outputs from the global class. In traditional reports these would be WRITE statements.
The two table definitions can be found in this repository.
