<script language="C#" runat=server>
       
        private bool validator (string un, string pw){
            message.Text="";
            bool isValidated = false;      
        
            OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ioq6hahtjs.database.windows.net,1433;Database=mathcomAhfq5rGk1;Uid=qinvfd@ioq6hahtjs;Pwd=kvQ98Jvcsq;Encrypt=yes;Connection Timeout=30;");

       
            
        try
         {
  
          dbconn.Open();
         
          OdbcCommand myOdbcComm = new OdbcCommand("SELECT password FROM admins WHERE username=?", dbconn);
          myOdbcComm.Parameters.AddWithValue("@username", un);
          OdbcDataReader reader = myOdbcComm.ExecuteReader();
          string lookuppass="";
      
          reader.Read();
          lookuppass= reader.GetString(0);
          
            reader.Close();
           myOdbcComm.Dispose();
          if(lookuppass==pw){isValidated=true;}
         }
        catch(Exception e)
           {
            message.Text+= "Couldn't validate record: " + e.ToString();
           }
        finally
          {
         dbconn.Close();
          }
        return isValidated;  
        }
    </script>