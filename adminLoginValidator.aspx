<script language="C#" runat=server>
        private bool validator (string un, string pw){
            message.Text="";
            bool isValidated = false;
            OleDbConnection dbconn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source=" + "E:\\Inetpub\\websites\\msf.uwc.edu\\fpdb\\mathleague\\ml.mdb");
            
        try
         {
  
          dbconn.Open();
          OleDbCommand myOleDbComm = new OleDbCommand("SELECT password FROM admins WHERE username=@uname", dbconn);
          
          myOleDbComm.Parameters.Add( "@uname", OleDbType.VarChar, 25 );
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