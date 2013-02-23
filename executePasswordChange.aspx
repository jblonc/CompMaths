<script language="C#" runat=server>
        private bool pchange (string txt1, string txt2){
            msg.Text="";
            bool isExecuted = false;
            OleDbConnection dbconn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source=" + "E:\\Inetpub\\websites\\msf.uwc.edu\\fpdb\\mathleague\\ml.mdb");
        HttpCookie u2cookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(u2cookie!=null){  
        if((String)u2cookie.Values["valid_word"]=="collegebound" && txt1==txt2 && txt1!=(String)u2cookie.Values["username"]){    
        try
         {
  
          dbconn.Open();
          OleDbCommand myOleDbComm = new OleDbCommand("UPDATE schools SET school=@sch, [password]=@pss WHERE school=@sch", dbconn);
          
          myOleDbComm.Parameters.Add( "@sch", OleDbType.VarChar, 20 );
	    myOleDbComm.Parameters["@sch"].Value = (String)u2cookie.Values["username"];
          myOleDbComm.Parameters.Add( "@pss", OleDbType.VarChar, 20 );
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