<script language="C#" runat=server>
        private bool validator (string un, string pw){
            message.Text="";
            bool isValidated = false;
            OleDbConnection dbconn = new OleDbConnection("Provider=SQLOLEDB; Data Provider = SQLNCLI10; Server=ufwryy6r0y.database.windows.net,1433; Database =xyzstart_db; User id =xyzdb@ufwryy6r0y; Password=virAf89Hda;");
            
        try
         {
  
          dbconn.Open();
          OleDbCommand myOleDbComm = new OleDbCommand("SELECT password FROM schools WHERE school=@uname", dbconn);
          
          myOleDbComm.Parameters.Add( "@uname", OleDbType.VarChar, 20 );
	    myOleDbComm.Parameters["@uname"].Value = un;
          string lookuppass= (string) myOleDbComm.ExecuteScalar();
          myOleDbComm.Dispose();
          
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