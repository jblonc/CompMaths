<%@ Page Language="C#" runat=server %>
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
         dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ioq6hahtjs.database.windows.net,1433;Database=mathcomAhfq5rGk1;Uid=qinvfd@ioq6hahtjs;Pwd= kvQ98Jvcsq;Encrypt=yes;Connection Timeout=30;");
         if(!IsPostBack)
         {
         BindGrid();
         Page.DataBind(); 
          }
        }
     
     

      
     void BindGrid(){
        OdbcDataAdapter display_algebra=new OdbcDataAdapter("SELECT student_id, name, school, score FROM participants WHERE category='Algebra' ORDER BY score DESC", dbconn);// 
        DataSet ds_algebra= new DataSet();
        display_algebra.Fill(ds_algebra, "algebra");
        algebra_results.DataSource=ds_algebra.Tables["algebra"].DefaultView;
        algebra_results.DataBind();

        OdbcDataAdapter display_geometry=new OdbcDataAdapter("SELECT student_id, name, school, score FROM participants WHERE category='Geometry' ORDER BY score DESC", dbconn);// 
        DataSet ds_geometry= new DataSet();
        display_geometry.Fill(ds_geometry, "geometry");
        geometry_results.DataSource=ds_geometry.Tables["geometry"].DefaultView;
        geometry_results.DataBind();
        
        OdbcDataAdapter display_precal=new OdbcDataAdapter("SELECT student_id, name, school, score FROM participants WHERE category='Precal' ORDER BY score DESC", dbconn);// 
        DataSet ds_precal= new DataSet();
        display_precal.Fill(ds_precal, "precal");
        precal_results.DataSource=ds_precal.Tables["precal"].DefaultView;
        precal_results.DataBind();

        OdbcDataAdapter display_algebraGrp=new OdbcDataAdapter("SELECT team_id, school, algebra_g FROM teams ORDER BY algebra_g DESC", dbconn);// 
        DataSet ds_algebraGrp= new DataSet();
        display_algebraGrp.Fill(ds_algebraGrp, "algebraGrp");
        algebraGrp_results.DataSource=ds_algebraGrp.Tables["algebraGrp"].DefaultView;
        algebraGrp_results.DataBind();
 
        OdbcDataAdapter display_geometryGrp=new OdbcDataAdapter("SELECT team_id, school, geometry_g FROM teams ORDER BY geometry_g DESC", dbconn);// 
        DataSet ds_geometryGrp= new DataSet();
        display_geometryGrp.Fill(ds_geometryGrp, "geometryGrp");
        geometryGrp_results.DataSource=ds_geometryGrp.Tables["geometryGrp"].DefaultView;
        geometryGrp_results.DataBind();

        OdbcDataAdapter display_precalGrp=new OdbcDataAdapter("SELECT team_id, school, precal_g FROM teams ORDER BY precal_g DESC", dbconn);// 
        DataSet ds_precalGrp= new DataSet();
        display_precalGrp.Fill(ds_precalGrp, "precalGrp");
        precalGrp_results.DataSource=ds_precalGrp.Tables["precalGrp"].DefaultView;
        precalGrp_results.DataBind();

        OdbcDataAdapter display_mixedGrp=new OdbcDataAdapter("SELECT team_id, school, mixed_g FROM teams ORDER BY mixed_g DESC", dbconn);// 
        DataSet ds_mixedGrp= new DataSet();
        display_mixedGrp.Fill(ds_mixedGrp, "mixedGrp");
        mixedGrp_results.DataSource=ds_mixedGrp.Tables["mixedGrp"].DefaultView;
        mixedGrp_results.DataBind();

        OdbcDataAdapter display_team=new OdbcDataAdapter("SELECT team_id, school, team_score FROM teams ORDER BY team_score DESC", dbconn);// 
        DataSet ds_team= new DataSet();
        display_team.Fill(ds_team, "team");
        team_results.DataSource=ds_team.Tables["team"].DefaultView;
        team_results.DataBind();

                }
    </script>
  
   <% Session.Timeout=60; %>
   <body>
<br />
<a href="admincontrol.aspx"> Back to the Control Page </a><br /><br />
   <table><tr>
    <td valign="top"><table><tr><td align="center" >Algebra Group</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="algebraGrp_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>

<td valign="top"><table><tr><td align="center" >Geometry Group</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="geometryGrp_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>
   
 <td valign="top"><table><tr><td align="center" >Precal Group</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="precalGrp_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>
   
   <td valign="top"><table><tr><td align="center" >Mixed Group</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="mixedGrp_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>

   <td valign="top"><table><tr><td align="center" >Team Results</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="team_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>
  
   </tr></table>
   
   
   
  <table><tr>
  <td valign="top"><table><tr><td align="center">Algebra Individual</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="algebra_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>
   
   <td valign="top"><table><tr><td align="center">Geometry Individual</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="geometry_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>

<td valign="top"><table><tr><td align="center">Precal Individual</td></tr>
       <tr>
<td>
          <ASP:DataGrid id="precal_results" runat="server"
            Width="200"
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
       

   </td></tr></table></td>
   
  
  </tr></table>


          </body>
</html>