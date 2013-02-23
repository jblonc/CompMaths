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

        OleDbDataAdapter topk_team=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Team' AND category='Team' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_team= new DataSet();
        topk_team.Fill(ds_team, "team");
        team.DataSource=ds_team.Tables["team"].DefaultView;
        team.DataBind();

        OleDbDataAdapter topk_ind_algebra=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Individual' AND category='Algebra' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_ind_algebra= new DataSet();
        topk_ind_algebra.Fill(ds_ind_algebra, "ind_algebra");
        ind_algebra.DataSource=ds_ind_algebra.Tables["ind_algebra"].DefaultView;
        ind_algebra.DataBind();

        OleDbDataAdapter topk_ind_geometry=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Individual' AND category='Geometry' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_ind_geometry= new DataSet();
        topk_ind_geometry.Fill(ds_ind_geometry, "ind_geometry");
        ind_geometry.DataSource=ds_ind_geometry.Tables["ind_geometry"].DefaultView;
        ind_geometry.DataBind();

        OleDbDataAdapter topk_ind_precal=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Individual' AND category='Precal' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_ind_precal= new DataSet();
        topk_ind_precal.Fill(ds_ind_precal, "ind_precal");
        ind_precal.DataSource=ds_ind_precal.Tables["ind_precal"].DefaultView;
        ind_precal.DataBind();

        OleDbDataAdapter topk_grp_algebra=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Group' AND  category='Algebra' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_grp_algebra= new DataSet();
        topk_grp_algebra.Fill(ds_grp_algebra, "grp_algebra");
        grp_algebra.DataSource=ds_grp_algebra.Tables["grp_algebra"].DefaultView;
        grp_algebra.DataBind();

        OleDbDataAdapter topk_grp_geometry=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Group' AND category='Geometry' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_grp_geometry= new DataSet();
        topk_grp_geometry.Fill(ds_grp_geometry, "grp_geometry");
        grp_geometry.DataSource=ds_grp_geometry.Tables["grp_geometry"].DefaultView;
        grp_geometry.DataBind();

        OleDbDataAdapter topk_grp_precal=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Group' AND category='Precal' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_grp_precal= new DataSet();
        topk_grp_precal.Fill(ds_grp_precal, "grp_precal");
        grp_precal.DataSource=ds_grp_precal.Tables["grp_precal"].DefaultView;
        grp_precal.DataBind();

        OleDbDataAdapter topk_grp_mixed=new OleDbDataAdapter("SELECT * FROM winners WHERE [type]='Group' AND category='Mixed' ORDER BY score DESC, id ASC", dbconn); 
        DataSet ds_grp_mixed= new DataSet();
        topk_grp_mixed.Fill(ds_grp_mixed, "grp_mixed");
        grp_mixed.DataSource=ds_grp_mixed.Tables["grp_mixed"].DefaultView;
        grp_mixed.DataBind();
                }
                
        int k=5; // k value in "top k"; modify if necessary after consulting complete results on results.aspx
     void createTopk(Object Src, EventArgs E){
        //int k=5
        

        OleDbCommand delAllCmd= new OleDbCommand("DELETE * FROM winners",dbconn);

        // Generic individual
        ArrayList SubjectList= new ArrayList(); ArrayList CommandString= new ArrayList(); 
        SubjectList.Add("Algebra");SubjectList.Add("Geometry");SubjectList.Add("Precal");
        CommandString.Add("SELECT participants.name, participants.student_id, schools.school_name, schools.contact, participants.score FROM participants, schools WHERE participants.school=schools.school AND participants.category='Algebra'  ORDER BY participants.score DESC, participants.student_id ASC");
        CommandString.Add("SELECT participants.name, participants.student_id, schools.school_name, schools.contact, participants.score FROM participants, schools WHERE participants.school=schools.school AND participants.category='Geometry'  ORDER BY participants.score DESC, participants.student_id ASC");
        CommandString.Add("SELECT participants.name, participants.student_id, schools.school_name, schools.contact, participants.score FROM participants, schools WHERE participants.school=schools.school AND participants.category='Precal'  ORDER BY participants.score DESC, participants.student_id ASC");
        dbconn.Open();
        delAllCmd.ExecuteNonQuery();
        for(int p=0;p<3;p++){
        OleDbCommand ind_genericSelCmd= new OleDbCommand((String)CommandString[p],dbconn);
        OleDbCommand ind_genericInsCmd= new OleDbCommand("INSERT INTO winners ([names],[id],[type],category,school_name,contact,score) VALUES(@names,@id, @type,@category, @school_name,@contact,@score)",dbconn); 
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@names", OleDbType.VarChar, 240)); 
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@id", OleDbType.VarChar, 9)); 
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@type", OleDbType.VarChar, 15)); 
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@category", OleDbType.VarChar, 8));
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@school_name", OleDbType.VarChar, 50));
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@contact", OleDbType.VarChar, 50));         
        ind_genericInsCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double, 2));

        int ind_generic=0;
        ArrayList ind_generic_NAME=new ArrayList();
        ArrayList ind_generic_SCORE=new ArrayList();
        ArrayList ind_generic_SCHOOLN=new ArrayList();
        ArrayList ind_generic_CONTACT=new ArrayList();
        ArrayList ind_generic_ID=new ArrayList();
        

    
        OleDbDataReader ind_genericDbread =ind_genericSelCmd.ExecuteReader();
        while(ind_genericDbread.Read() && ind_generic<k){
                       ind_generic++;
                       ind_generic_NAME.Add(ind_genericDbread.GetString(0));
                       ind_generic_SCORE.Add(ind_genericDbread.GetDouble(4));
                       ind_generic_SCHOOLN.Add(ind_genericDbread.GetString(2));
                       ind_generic_CONTACT.Add(ind_genericDbread.GetString(3));
                       ind_generic_ID.Add(ind_genericDbread.GetString(1));
              }
        ind_genericDbread.Close();
        for(int q=0; q<ind_generic; q++){
                       ind_genericInsCmd.Parameters["@names"].Value=ind_generic_NAME[q];
                       ind_genericInsCmd.Parameters["@score"].Value=ind_generic_SCORE[q];
                       ind_genericInsCmd.Parameters["@school_name"].Value=ind_generic_SCHOOLN[q];
                       ind_genericInsCmd.Parameters["@contact"].Value=ind_generic_CONTACT[q];
                       ind_genericInsCmd.Parameters["@type"].Value="Individual";
                       ind_genericInsCmd.Parameters["@category"].Value=SubjectList[p];
                       ind_genericInsCmd.Parameters["@id"].Value=ind_generic_ID[q];
                       ind_genericInsCmd.ExecuteNonQuery();
                          }
        
        
        }
       // dbconn.Close();
         
        //Gneric Group and Team
        
       ArrayList GTCommandString=new ArrayList();ArrayList GTCommandNamesString=new ArrayList();
        GTCommandString.Add("SELECT teams.team_id, schools.school_name, schools.contact, teams.algebra_g FROM teams, schools WHERE teams.school=schools.school AND teams.algebra_g>0 ORDER BY teams.algebra_g DESC, teams.team_id ASC");
        GTCommandString.Add("SELECT teams.team_id, schools.school_name, schools.contact, teams.geometry_g FROM teams, schools WHERE teams.school=schools.school AND teams.geometry_g>0 ORDER BY teams.geometry_g DESC, teams.team_id ASC");
        GTCommandString.Add("SELECT teams.team_id, schools.school_name, schools.contact, teams.precal_g FROM teams, schools WHERE teams.school=schools.school AND teams.precal_g>0 ORDER BY teams.precal_g DESC, teams.team_id ASC");
        GTCommandString.Add("SELECT teams.team_id, schools.school_name, schools.contact, teams.mixed_g FROM teams, schools WHERE teams.school=schools.school AND teams.mixed_g>0 ORDER BY teams.mixed_g DESC, teams.team_id ASC");
        GTCommandString.Add("SELECT teams.team_id, schools.school_name, schools.contact, teams.team_score FROM teams, schools WHERE teams.school=schools.school AND teams.team_score>0 ORDER BY teams.team_score DESC, teams.team_id ASC");
        GTCommandNamesString.Add("SELECT [name]  FROM participants WHERE team_id=@tid AND (category='Algebra' AND [group]='Subject')");
        GTCommandNamesString.Add("SELECT [name]  FROM participants WHERE team_id=@tid AND (category='Geometry' AND [group]='Subject')");
        GTCommandNamesString.Add("SELECT [name]  FROM participants WHERE team_id=@tid AND (category='Precal' AND [group]='Subject')");
        GTCommandNamesString.Add("SELECT [name]  FROM participants WHERE team_id=@tid AND [group]='Mixed'");
        GTCommandNamesString.Add("SELECT [name]  FROM participants WHERE team_id=@tid");
        ArrayList TypeList=new ArrayList();ArrayList CategoryList=new ArrayList();
        TypeList.Add("Group");TypeList.Add("Group");TypeList.Add("Group");TypeList.Add("Group");TypeList.Add("Team");
        CategoryList.Add("Algebra");CategoryList.Add("Geometry");CategoryList.Add("Precal");
        CategoryList.Add("Mixed");CategoryList.Add("Team");
        //dbconn.Open();
        OleDbCommand grp_genericInsCmd= new OleDbCommand("INSERT INTO winners ([names],[id], [type],[category],school_name,contact,score) VALUES (@names,@id, @type,@category, @school_name,@contact,@score)",dbconn); 
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@names", OleDbType.VarChar, 240)); 
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@id", OleDbType.VarChar, 9)); 
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@type", OleDbType.VarChar, 15)); 
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@category", OleDbType.VarChar, 8));
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@school_name", OleDbType.VarChar, 50));
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@contact", OleDbType.VarChar, 50));         
        grp_genericInsCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double, 2));

        for(int p=0; p<5; p++){
        OleDbCommand grp_genericSelCmd= new OleDbCommand((String)GTCommandString[p],dbconn);
        //OleDbCommand grp_genericInsCmd= new OleDbCommand("INSERT INTO winners (names,[id], [type],category,school_name,contact,score) VALUES (@names,@id, @type,@category, @school_name,@contact,@score)",dbconn); 
        //grp_genericInsCmd.Parameters.Add(new OleDbParameter("@names", OleDbType.VarChar, 240)); 
        //grp_genericInsCmd.Parameters.Add(new OleDbParameter("@id", OleDbType.VarChar, 9)); 
       // grp_genericInsCmd.Parameters.Add(new OleDbParameter("@type", OleDbType.VarChar, 15)); 
        //grp_genericInsCmd.Parameters.Add(new OleDbParameter("@category", OleDbType.VarChar, 8));
       // grp_genericInsCmd.Parameters.Add(new OleDbParameter("@school_name", OleDbType.VarChar, 50));
       // grp_genericInsCmd.Parameters.Add(new OleDbParameter("@contact", OleDbType.VarChar, 50));         
        //grp_genericInsCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double, 2));
        
        int grp_generic=0;
        ArrayList grp_generic_NAME=new ArrayList();
        ArrayList grp_generic_SCORE=new ArrayList();
        ArrayList grp_generic_SCHOOLN=new ArrayList();
        ArrayList grp_generic_CONTACT=new ArrayList();
        ArrayList grp_generic_ID=new ArrayList();

        
        OleDbDataReader grp_genericDbread =grp_genericSelCmd.ExecuteReader();
        while(grp_genericDbread.Read() && grp_generic<k){
                       grp_generic++;
                       //grp_generic_NAME.Add(grp_genericDbread.GetString(0));
                       grp_generic_SCORE.Add(grp_genericDbread.GetDouble(3));
                       grp_generic_SCHOOLN.Add(grp_genericDbread.GetString(1));
                       grp_generic_CONTACT.Add(grp_genericDbread.GetString(2));
                       grp_generic_ID.Add(grp_genericDbread.GetString(0));
              }
        grp_genericDbread.Close();
        OleDbCommand grp_genericNamesCmd= new OleDbCommand((String)GTCommandNamesString[p],dbconn);
        grp_genericNamesCmd.Parameters.Add(new OleDbParameter("@tid", OleDbType.VarChar, 4));
        for(int q=0; q<grp_generic; q++){
                  grp_genericNamesCmd.Parameters["@tid"].Value=grp_generic_ID[q];
                  OleDbDataReader grp_genericNameRead=grp_genericNamesCmd.ExecuteReader();
              //with group scores >0 but can't find participants would have null string which SQL can't insert into database
                  String temp="list: ";
                  while(grp_genericNameRead.Read()){temp=temp+"&"+grp_genericNameRead.GetString(0);}
                  grp_generic_NAME.Add(temp);
                  grp_genericNameRead.Close();
                         }
        for(int q=0; q<grp_generic; q++){
                       grp_genericInsCmd.Parameters["@names"].Value=grp_generic_NAME[q];
                       grp_genericInsCmd.Parameters["@score"].Value=grp_generic_SCORE[q];
                       grp_genericInsCmd.Parameters["@school_name"].Value=grp_generic_SCHOOLN[q];
                       grp_genericInsCmd.Parameters["@contact"].Value=grp_generic_CONTACT[q];
                       grp_genericInsCmd.Parameters["@type"].Value=TypeList[p];
                       grp_genericInsCmd.Parameters["@category"].Value=CategoryList[p];
                       grp_genericInsCmd.Parameters["@id"].Value=grp_generic_ID[q];
                       grp_genericInsCmd.ExecuteNonQuery();
                          }
        
        } 


        dbconn.Close();
         

        BindGrid();
        }
    </script>
  

   <body>
  <br />
<center><a href="admincontrol.aspx"> Back to the Control Page </a></center><br /><br />
<form method="post" runat=server >
<center><asp:button text="Click to Create Winners Table"  onClick="createTopk" runat="server"/>
<br /> each click clears the 'winners' table and regenerates</br> but doesn't affect any other tables in database</center><br />
  <center> <table>

       <tr><td align="center"><font color=#0000FF><b>Teams: Top  <%=k%> </b></font> (excluding score = 0) </td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="team" runat="server"
            Width="800"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       
   </td></tr>
    </table><br /><table>
       <tr><td align="center"><font color=#FF8C00><b>Algebra Individual: Top <%=k%></b></font> </td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="ind_algebra" runat="server"
            Width="800"
            BackColor="#eee8aa" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#ffa500"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>
       <tr><td align="center"><font color=#00CED1><b>Geometry Individual: Top <%=k%></b></font> </td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="ind_geometry" runat="server"
            Width="800"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>
       <tr><td align="center"><font color=#9400D3><b>Precal Individual: Top <%=k%></b></font></td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="ind_precal" runat="server"
            Width="800"
            BackColor="#eee8aa" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#ffa500"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>

       <tr><td align="center"><font color=#FF1493><b>Algebra Group: Top <%=k%></b></font> (excluding score = 0)</td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="grp_algebra" runat="server"
            Width="800"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>
       <tr><td align="center"><font color=#00FA9A><b>Geometry Group: Top <%=k%></b></font> (excluding score = 0)</td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="grp_geometry" runat="server"
            Width="800"
            BackColor="#eee8aa" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#ffa500"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>
       <tr><td align="center"><font color=#FF00FF><b>Precal Group: Top <%=k%></b></font> (excluding score = 0)</td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="grp_precal" runat="server"
            Width="800"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#aaaadd"
            EnableViewState="false"
          />
       
   </td></tr>
</table><br /><table>
       <tr><td align="center"><font color=#32CD32><b>Mixed Group: Top <%=k%></b></font> (excluding score = 0)</td></tr>
       <tr><td valign="top">
          <ASP:DataGrid id="grp_mixed" runat="server"
            Width="800"
            BackColor="#eee8aa" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="10pt"
            HeaderStyle-BackColor="#ffa500"
            EnableViewState="false"
          />
       
   </td></tr>
   </table></center>
  </form>
          </body>
</html>