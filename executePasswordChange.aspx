<script language="C#" runat=server>
        private bool pchange (string txt1, string txt2){
            msg.Text="";
            bool isExecuted = false;
            OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=xyzstart_db;Uid=xyzdb@ufwryy6r0y;Pwd=virAf89Hda;Encrypt=yes;Connection Timeout=30;");
        HttpCookie u2cookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(u2cookie!=null){  
        if((String)u2cookie.Values["valid_word"]=="collegebound" && txt1==txt2 && txt1!=(String)u2cookie.Values["username"]){    
       //* try
     //*    {
  
          dbconn.Open();
          OdbcDataAdapter adapter = new OdbcDataAdapter(
        "select school, [password] from schools", dbconn);
         adapter.UpdateCommand =  new OdbcCommand("UPDATE schools SET  [password]=? WHERE school=?", dbconn);//school=?,
        //  OdbcCommand myOleDbComm = new OdbcCommand("UPDATE schools SET school=?, [password]=? WHERE school=?", dbconn);
          
           adapter.UpdateCommand.Parameters.Add( "@school", OdbcType.VarChar, 20 );
	     adapter.UpdateCommand.Parameters["@school"].Value = (String)u2cookie.Values["username"];
           adapter.UpdateCommand.Parameters.Add( "@password", OdbcType.VarChar, 20 );
	     adapter.UpdateCommand.Parameters["@password"].Value = txt1;
           adapter.UpdateCommand.ExecuteNonQuery();
       /* myOleDbComm.Parameters.Add( "@school", OdbcType.VarChar, 20 );
	    myOleDbComm.Parameters["@school"].Value = (String)u2cookie.Values["username"];
          myOleDbComm.Parameters.Add( "@password", OdbcType.VarChar, 20 );
	    myOleDbComm.Parameters["@password"].Value = txt1;
          myOleDbComm.ExecuteNonQuery();
       */
          //myOleDbComm.Dispose();
          isExecuted=true;
        
    //*     }
   //*     catch(Exception e)
    //*       {
   //*         msg.Text+= "Couldn't change password: " + e.ToString();
   //*        }
   //*     finally
  //*        {
         dbconn.Close();
  //*        }
          }
         } else{msg.Text="You working session has expired. Please sign in.";}

        return isExecuted;  
        }
    </script>