<%@ Page Language="C#" runat=server %>
<%@ Import Namespace="System.Data.OleDb" %>


<html>
   <head><link REL="SHORTCUT ICON" HREF="http://www.marshfield.uwc.edu/faculty/jlu/ml/favicon.ico">
<link rel="stylesheet" type="text/css"
href="mystyle.css" />
<title>Math League</title></head>
     <script language="C#" runat="server">
        
        void Page_Load(Object Src, EventArgs E) {
         HttpCookie ucookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(ucookie!=null){  
            if((String)ucookie.Values["valid_word"]=="collegebound"){usnm.Text=(String) ucookie.Values["username"];}
            else{Response.Redirect("uLogin.aspx",true);}}
          else{Response.Redirect("uLogin.aspx",true);}
        }
     </script>
     <!-- #include File = "executePasswordChange.aspx" -->
    <script language="C#" runat=server>
      void passchange (Object Src, EventArgs E){
             HttpCookie u1cookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          
             msg.Text="";
             Page.Validate();//without this line seems to be fine
             if(Page.IsValid){bool isExecuted=pchange(pass1.Text, pass2.Text);
                 if(u1cookie!=null){  
                 if (isExecuted && (String)u1cookie.Values["valid_word"]=="collegebound"){
                 msg.Text = "Password changed!<br /> Please log on with the new password next time.<br />";
                 msg.Text = msg.Text+"Please wait ... you will be redirected in 10 seconds";
                 //long sec= (new DateTime()).Ticks+1;
                 //msg.Text+= (new DateTime()).Hour;
                 //System.Threading.Thread.Sleep(2000); this one works for waiting only
                 //while((new DateTime()).Second<=sec){}
                 Response.Redirect("uMLForm.aspx",true);
               //Session["validation"]="collegebound";
               //Session["username"]=username.Text;
               //if(username.Text!=password.Text){Response.Redirect("uMLForm.aspx",true);}
               //else { Response.Redirect("uPassChange.aspx",true);
               //      }
            //message.Text+=username.Text + password.Text;
            //Server.Transfer("session_in.aspx");
             }
          else{msg.Text = "password not changed;<br /> please make sure you typed the same password (different from your username) in the above two boxes";}}
            else{msg.Text ="Your working session has expired. Please sign in.";}
             }
          }
    </script>

   <body>
  <br /><br />
       <center>Please choose a password using a combination of letters and digits of at least 6 characters long<br /> The password is recommended to contain both letters and digits<br /> <br /><font color="blue">You will be automatically redirected to the registration page after you press Enter or click 'change password' button, if the change is successful</font> <br /> <font color="red">please use the new passwork next time you sign in</red> </center><br />
       <center><form method="post" runat=server >
          <table bgcolor="#eeeeee" cellpadding=10>
          <tr><td align="right">your school username:</td>
             <td align="left"> <asp:textbox ReadOnly="True" id="usnm" class="no-edit" runat="server" /></td>
             <td />
             </tr>
          <tr> 
              <td align=right>Enter your new password:</td>
              <td><asp:textbox textmode="password" id="pass1"  Columns="20" align="left" runat="server" /></td>
              <td> <asp:RequiredFieldValidator id="RequiredPass1Validator"
            ControlToValidate="pass1"
            Display="dynamic"
            InitialValue="" Width="100%" runat=server>
            *
        </asp:RequiredFieldValidator> <br />
          <asp:RegularExpressionValidator id="pass1RegValidator" runat="server"
                      ControlToValidate="pass1"
                      ValidationExpression="^([a-zA-Z0-9]){6}[a-zA-Z0-9]*$"
                      Display="Static"
                      Font-Name="Verdana" Font-Size="10pt">password should consist of only letters and digits and at least 6 characters long
                  </asp:RegularExpressionValidator></td>
          </tr>
          <tr> 
              <td align=right>Retype the new password:</td>
              <td><asp:textbox textmode="password" id="pass2" Columns="20" align="left" runat="server" /></td>
            <td><asp:RequiredFieldValidator id="RequiredPass2Validator"
            ControlToValidate="pass2"
            Display="static"
            InitialValue="" Width="100%" runat=server>
            *
             </asp:RequiredFieldValidator>  <br />
           <asp:RegularExpressionValidator id="pass2RegValidator" runat="server"
                      ControlToValidate="pass2"
                      ValidationExpression="^([a-zA-Z0-9]){6}[a-zA-Z0-9]*$"
                      Display="Static"
                      Font-Name="Verdana" Font-Size="10pt">password should consist of only letters and digits and at least 6 characters long
                  </asp:RegularExpressionValidator> </td>
          </tr>
           </table>
           
           

              &nbsp;&nbsp;&nbsp;<asp:button text="change password" class="change_pass" onClick="passchange" runat="server"/>

          
       </form></center>
      <center> <asp:label id="msg" forecolor=red runat=server />

       </center>
       
          </body>
</html>