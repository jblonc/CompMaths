<%@ Page Language="C#" runat=server %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>

<html>
   
     <script language="C#" runat="server">
         OleDbConnection dbconn;
         /*void Page_Load(Object Src, EventArgs E) {
         //if(Session["validation"]!="allright"){Response.Redirect("adminLogin.aspx", true);} 
         dbconn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source=" +                                 "E:\\Inetpub\\websites\\msf.uwc.edu\\fpdb\\mathleague\\ml.mdb");*/
         void Page_Load(Object Src, EventArgs E) {
         HttpCookie cookie = Request.Cookies["validation"];
          ViewState["Referer"] = Request.Headers["Referer"];
        if(cookie!=null){
         if((String)cookie.Values["valid_word"]!="allright"){Response.Redirect("adminLogin.aspx", true);} }
        else{Response.Redirect("adminLogin.aspx", true);}
         dbconn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source=" +                                 "E:\\Inetpub\\websites\\msf.uwc.edu\\fpdb\\mathleague\\ml.mdb");
         if(!IsPostBack)
         {
         BindGrid();
         Page.DataBind(); 
          }
        }
     
     

      
     void BindGrid(){
        OleDbDataAdapter displayComm_p=new OleDbDataAdapter("SELECT * FROM participants ORDER BY school, student_id", dbconn);// 
        DataSet ds_p= new DataSet();
        displayComm_p.Fill(ds_p, "participants");
        participants.DataSource=ds_p.Tables["participants"].DefaultView;
        participants.DataBind();

        OleDbDataAdapter displayComm_t=new OleDbDataAdapter("SELECT * FROM teams ORDER BY school, team_id", dbconn);
        DataSet ds_t= new DataSet();
        displayComm_t.Fill(ds_t, "teams");
        teams.DataSource=ds_t.Tables["teams"].DefaultView;
        teams.DataBind();
                }
    </script>
  
   <% Session.Timeout=60; %>
   <body>
  <br />
<a href="admincontrol.aspx"> Back to the Control Page </a><br /><br />
   <table>
       <tr><td align="center">Participants</td></tr>
       <tr>
<td valign="top">
          <ASP:DataGrid id="participants" runat="server"
            Width="700"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="8pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       

   </td></tr><tr><td align="center" >Teams</td></tr>
      
<tr><td valign="top">
          <ASP:DataGrid id="teams" runat="server"
            Width="700"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="8pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       

   </td></tr>
   </table>

          </body>
</html>