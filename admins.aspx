<%@ Import Namespace="System.Data.OleDb" %>

<script  language= "C#" runat="server">
protected void Page_Load(Object Src, EventArgs E) {
         HttpCookie cookie = Request.Cookies["validation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          if(cookie!=null){
if((String)cookie.Values["valid_word"]!="allright"){Response.Redirect("adminLogin.aspx", true);}}
          else{Response.Redirect("adminLogin.aspx", true);}
OdbcConnection dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ioq6hahtjs.database.windows.net,1433;Database=mathcomAhfq5rGk1;Uid=qinvfd@ioq6hahtjs;Pwd=kvQ98Jvcsq;Encrypt=yes;Connection Timeout=30;");
OdbcCommand myOleDbComm = new OdbcCommand("SELECT * FROM admins", dbconn);

try
 {
  
  dbconn.Open();
  OdbcDataReader dbread = myOleDbComm.ExecuteReader();
  admins.DataSource=dbread;
  admins.DataBind();
  dbread.Close();
   }
catch(Exception e)
    {
      Message.Text= "Couldn't insert record: " + e.ToString();
    }
    finally
    {
      dbconn.Close();
    }
}

</script>

<html>
<% Session.Timeout=60; %>
<body>

      <asp:Repeater id="admins" runat=server>
<HeaderTemplate>
<table border="1" width="100%">
<tr bgcolor="#b0c4de">
<th>username</th>
<th>password</th>
<th>role</th>
<th>email</th>
<th>phone</th>
</tr>
</HeaderTemplate>

<ItemTemplate>
<tr bgcolor="#f0f0f0">
<td> <%# DataBinder.Eval(Container.DataItem, "username") %> </td>
<td> <%# DataBinder.Eval(Container.DataItem, "password") %>  </td>
<td> <%# DataBinder.Eval(Container.DataItem, "role") %> </td>
<td> <%# DataBinder.Eval(Container.DataItem, "email") %> </td>
<td> <%# DataBinder.Eval(Container.DataItem, "phone") %>  </td>


</tr>
</ItemTemplate>

<FooterTemplate>
</table>
</FooterTemplate>

      </asp:Repeater>
<p />
<hr />
<asp:label id="Message" forecolor="blue" font-size="12" runat=server/>
</body>
</html>