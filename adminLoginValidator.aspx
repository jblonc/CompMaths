<script language="C#" runat=server>
        private bool validator (string un, string pw){
            message.Text="";
            bool isValidated = false;
        using System.Data.Odbc;
          using(  OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=[xyzstart_db];Uid=xyzdb@ufwryy6r0y;Pwd={virAf89Hda};Encrypt=yes;Connection Timeout=30;")){dbconn.open();}

          /*  OleDbConnection dbconn = new OleDbConnection("Provider=SQLOLEDB; Data Provider = SQLNCLI10; Server=ufwryy6r0y.database.windows.net,1433; Database =xyzstart_db; User id =xyzdb@ufwryy6r0y; Password=virAf89Hda;");*/
   //         
        try
         {
  
         // dbconn.Open();
         /* OleDbCommand myOleDbComm = new OleDbCommand("SELECT password FROM xyzstart_db.dbo.admins WHERE username=?", dbconn);
          
          myOleDbComm.Parameters.Add( "@username", OleDbType.VarChar, 25 );
	    myOleDbComm.Parameters["@username"].Value = un;
          string lookuppass= (string) myOleDbComm.ExecuteScalar();
          myOleDbComm.Dispose();*/
          OdbcCommand myOdbcComm = new OdbcCommand("SELECT password FROM xyzstart_db.dbo.admins WHERE username=?", dbconn);
          myOdbcComm.Parameters.AddWithValue("@username", un);
          OdbcDataReader reader = myOdbcComm.ExecuteReader();
          string lookuppass="";
          while( reader.Read()){lookuppass= reader.GetString(0);};
          
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