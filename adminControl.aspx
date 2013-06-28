<%@ Page Language="C#"  runat=server %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>

<html>
   
     <script language="C#" runat="server">
         OdbcConnection dbconn;
         void Page_Load(Object Src, EventArgs E) {
         HttpCookie cookie = Request.Cookies["validation"];
          ViewState["Referer"] = Request.Headers["Referer"];
        if(cookie!=null){
         if((String)cookie.Values["valid_word"]!="allright"){Response.Redirect("adminLogin.aspx", true);} }
        else{Response.Redirect("adminLogin.aspx", true);}
         dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ioq6hahtjs.database.windows.net,1433;Database=mathcomAhfq5rGk1;Uid=qinvfd@ioq6hahtjs;Pwd=kvQ98Jvcsq;Encrypt=yes;Connection Timeout=30;");
         if(!IsPostBack)
         {
          
          }
        }

    </script>
  
   
   <body>
<br />
<b>Control Page </b><br/><br />

<a href="adminAddSchools.aspx">Add Schools</a><br /><br />
<a href="adminDbview.aspx"> Database Snapshot for Participants and Teams </a><br /><br />
<a href="individualg.aspx"> Individual Subject Scores Updating and Editing </a><br /><br />
<a href="teamg.aspx"> Group Scores Updating and Editing </a><br /><br />
<a href="results.aspx"> Complete Competition Results </a>(use this to help determine k) <br /><br />
<a href="winners.aspx"> Top k winners </a>  (default k=5; modify k preceding the function createTopk() in winners.aspx; must do individual/group scores updating/editing before this step!)<br />

          </body>
</html>