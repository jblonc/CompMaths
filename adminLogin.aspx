<%@ Page Language="C#" runat=server%>
<%@ Import Namespace="System.Data.OleDb" %>

<html>
   
     <script language="C#" runat="server">
        
        void Page_Load(Object Src, EventArgs E) {
            welcome.Text = "Welcome to Math League!<br>"+ DateTime.Now;
        }
     </script>
     <!-- #include File = "adminLoginValidator.aspx" -->
    <script language="C#" runat=server>
      void transfer (Object Src, EventArgs E){
             bool isValidated=validator(username.Text, password.Text);
             if (isValidated){
               HttpCookie cookie = new HttpCookie("validation");
               cookie.Values.Add("valid_word","allright");
               cookie.Expires = DateTime.Now.AddMinutes(120);//cookie.Expires = DateTime.MaxValue;
               Response.AppendCookie(cookie);
               Response.Redirect("adminControl.aspx",true);
            
             }
          else{message.Text +=message.Text+ "Invalid credentials!";}
          }
    </script>
  
   <body>

       <center><asp:label id="welcome"  runat=server />

       <form method="post" runat=server >
          <table bgcolor="#eeeeee" cellpadding=10>
          <tr> 
              <td align=right>username:</td>
              <td><asp:textbox id="username" align="left" runat="server" /></td>
              <td align=middle> <asp:RequiredFieldValidator id="RequiredUsernameValidator"
            ControlToValidate="username"
            Display="dynamic"
            InitialValue="" Width="100%" runat=server>
            *
        </asp:RequiredFieldValidator>  </td>
          </tr>
          <tr> 
              <td align=right>password:</td>
              <td><asp:textbox textmode="password" id="password" align="left" runat="server" /></td>
           <td align=middle> <asp:RequiredFieldValidator id="RequiredPasswordValidator"
            ControlToValidate="password"
            Display="static"
            InitialValue="" Width="100%" runat=server>
            *
             </asp:RequiredFieldValidator>  </td>
          </tr>
           </table>
           

              &nbsp;&nbsp;&nbsp;<asp:button text="login" onClick="transfer" runat="server"/>
           
       </form>
       <asp:label id="message" forecolor=red runat=server />

       </center>
          </body>
</html>