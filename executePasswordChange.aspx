<script language="C#" runat=server>
        private bool pchange (string txt1, string txt2){
            msg.Text="";
            bool isExecuted = false;
            OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ioq6hahtjs.database.windows.net,1433;Database=mathcomAhfq5rGk1;Uid=qinvfd@ioq6hahtjs;Pwd=kvQ98Jvcsq;Encrypt=yes;Connection Timeout=30;");
        HttpCookie u2cookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(u2cookie!=null){  
        if((String)u2cookie.Values["valid_word"]=="collegebound" && txt1==txt2 && txt1!=(String)u2cookie.Values["username"]){    
        try
        {
  
          
       
     
          dbconn.Open();

         OdbcCommand ocmm = new OdbcCommand("update schools set password=? where school=?",dbconn);
         ocmm.Parameters.AddWithValue("@password", txt1);
         ocmm.Parameters.AddWithValue("@school",(String)u2cookie.Values["username"]);
         ocmm.ExecuteNonQuery();
         ocmm.Dispose();
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