<script language="C#" runat=server>
        private bool pchange (string txt1, string txt2){
            msg.Text="";
            bool isExecuted = false;
            OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=xyzstart_db;Uid=xyzdb@ufwryy6r0y;Pwd=virAf89Hda;Encrypt=yes;Connection Timeout=30;");
        HttpCookie u2cookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(u2cookie!=null){  
        if((String)u2cookie.Values["valid_word"]=="collegebound" && txt1==txt2 && txt1!=(String)u2cookie.Values["username"]){    
        try
         {
  
          dbconn.Open();
          OdbcCommand myOleDbComm = new OdbcCommand("UPDATE schools SET school=@sch, [password]=@pss WHERE school=?", dbconn);
          
          myOleDbComm.Parameters.Add( "@school", OdbcType.VarChar, 20 );
	    myOleDbComm.Parameters["@school"].Value = (String)u2cookie.Values["username"];
          myOleDbComm.Parameters.Add( "@pss", OdbcType.VarChar, 20 );
	    myOleDbComm.Parameters["@pss"].Value = txt1;
          myOleDbComm.ExecuteNonQuery();
          //myOleDbComm.Dispose();
          isExecuted=true;
        
         }
        catch(Exception e)
           {
            msg.Text+= "Couldn't change password: " + e.ToString();
           }
        finally
          {
         dbconn.Close();
          }
          }
         } else{msg.Text="You working session has expired. Please sign in.";}

        return isExecuted;  
        }
    </script>