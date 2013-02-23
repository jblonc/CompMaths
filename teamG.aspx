<%@ Page Language="C#" runat=server debug="true" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Globalization" %>

<html>
   
     <script language="C#" runat="server">
         OleDbConnection dbconn;
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
     
     
            void teamGrades_Edit(Object sender, DataGridCommandEventArgs e)
        {teams.EditItemIndex = (int)e.Item.ItemIndex; BindGrid(); }
     void teamGrades_Cancel(Object sender, DataGridCommandEventArgs e)
        {teams.EditItemIndex = -1; BindGrid(); }
     void teamGrades_Update(Object sender, DataGridCommandEventArgs e)
        {
         /*String updateCmd="UPDATE teams SET team_id=@tid, team_no=@tno, [count]=@cnt,team_status=@tstat,school=@school, geometry_g=@gg, algebra_g=@ag,precal_g=@pg, mixed_g=@mg WHERE team_id=@tid";*/
         String updateCmd="UPDATE teams SET team_id=@tid,geometry_g=@gg, algebra_g=@ag,precal_g=@pg, mixed_g=@mg WHERE team_id=@tid";

         OleDbCommand myUpdateCmd= new OleDbCommand(updateCmd, dbconn);
         myUpdateCmd.Parameters.Add(new OleDbParameter("@tid", OleDbType.VarChar, 4));
         /*myUpdateCmd.Parameters.Add(new OleDbParameter("@tno", OleDbType.VarChar, 1));  
         myUpdateCmd.Parameters.Add(new OleDbParameter("@cnt", OleDbType.Integer, 10));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@tstat", OleDbType.Boolean));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@school", OleDbType.VarChar, 20));*/
         myUpdateCmd.Parameters.Add(new OleDbParameter("@gg", OleDbType.Double, 2));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@ag", OleDbType.Double, 2));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@pg", OleDbType.Double, 2));
         myUpdateCmd.Parameters.Add(new OleDbParameter("@mg", OleDbType.Double, 2));
         myUpdateCmd.Parameters["@tid"].Value=teams.DataKeys[(int)e.Item.ItemIndex];
         String[] cols={"@tid","@tno","@cnt","@tstat","@school","@gg","@ag","@pg","@mg"};
         int numCols=e.Item.Cells.Count;
         message.Text="";
         for (int i=6; i<numCols-1;i++) //numCols=11.
            {
             String colvalue=((System.Web.UI.WebControls.TextBox) e.Item.Cells[i].Controls[0]).Text;
             myUpdateCmd.Parameters[cols[i-1]].Value = Convert.ToDouble(colvalue);
             //message.Text+=Convert.ToDouble(colvalue)+"<br />";
            }
          myUpdateCmd.Connection.Open();
          try{myUpdateCmd.ExecuteNonQuery();teams.EditItemIndex=-1;}
          catch(Exception ex){message.Text+="Exception with update!";}
          myUpdateCmd.Connection.Close();
          BindGrid();
         // message.Text+="working";
        }
     void BindGrid(){
        OleDbDataAdapter displayComm=new OleDbDataAdapter("SELECT team_id, team_no, [count], team_status, school, geometry_g, algebra_g, precal_g, mixed_g, team_score FROM teams ORDER BY school, team_id", dbconn);
        DataSet ds= new DataSet();
        displayComm.Fill(ds, "teams");
        teams.DataSource=ds.Tables["teams"].DefaultView;
        teams.DataBind();
                }
     void updateTeamScore(Object Src, EventArgs E){
             // OleDbCommand allScoresCmd= new OleDbCommand("UPDATE participants SET student_id=@sid, score=@score WHERE student_id=@sid",dbconn);
              OleDbCommand allGroupScoresCmd= new OleDbCommand("SELECT team_id, algebra_g, geometry_g, precal_g, mixed_g  FROM teams",dbconn);
              OleDbCommand teamScoresUpdCmd= new OleDbCommand("UPDATE teams SET team_id=@tid, team_score=@score WHERE team_id=@tid",dbconn);
              teamScoresUpdCmd.Parameters.Add(new OleDbParameter("@tid", OleDbType.VarChar,4));
              teamScoresUpdCmd.Parameters.Add(new OleDbParameter("@score", OleDbType.Double,2));

              ArrayList TID= new ArrayList(); ArrayList SUM_SCORES = new ArrayList(); int num_teams=0;
              dbconn.Open();
              OleDbDataReader dbread =allGroupScoresCmd.ExecuteReader();
              while(dbread.Read()){TID.Add(dbread.GetString(0)); SUM_SCORES.Add(dbread.GetDouble(1)+dbread.GetDouble(2)+dbread.GetDouble(3)+dbread.GetDouble(4));num_teams++;}
              dbread.Close();
              
              OleDbCommand allIndScoresCmd= new OleDbCommand("SELECT score  FROM participants WHERE team_id=@tid",dbconn);
              allIndScoresCmd.Parameters.Add(new OleDbParameter("@tid", OleDbType.VarChar,4));
              for (int q=0; q<num_teams; q++){
              allIndScoresCmd.Parameters["@tid"].Value=TID[q];
              OleDbDataReader indbread =allIndScoresCmd.ExecuteReader();
              while(indbread.Read()){SUM_SCORES[q] = (Double)SUM_SCORES[q]+indbread.GetDouble(0);}
              indbread.Close();
              }
              
              for (int q=0; q<num_teams; q++){
              teamScoresUpdCmd.Parameters["@tid"].Value=TID[q];
              teamScoresUpdCmd.Parameters["@score"].Value=SUM_SCORES[q];
              teamScoresUpdCmd.ExecuteNonQuery();
              }
              dbconn.Close();
              BindGrid();
     }

    </script>
  

   <body>
<br />
<a href="admincontrol.aspx"> Back to the Control Page </a>
<br /> <br />
    <form method="post" runat=server >
          
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
            OnEditCommand="teamGrades_Edit"
            OnCancelCommand="teamGrades_Cancel"
            OnUpdateCommand="teamGrades_Update"
            DataKeyField="team_id"
            AutoGenerateColumns="false"          
            
          >
          <Columns>
              <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" ItemStyle-Wrap="false" />
              <asp:BoundColumn HeaderText="team_id" SortExpression="team_id" ReadOnly="True" DataField="team_id" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="team_no" SortExpression="team_no" ReadOnly="True" DataField="team_no" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="count" SortExpression="count" ReadOnly="True" DataField="count" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="team_status" SortExpression="team_status" ReadOnly="True" DataField="team_status" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school" SortExpression="school" ReadOnly="True" DataField="school" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="geometry_g" SortExpression="geometry_g" DataField="geometry_g" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="algebra_g" SortExpression="algebra_g" DataField="algebra_g" ItemStyle-Wrap="true"/>
              <asp:BoundColumn HeaderText="precal_g" SortExpression="precal_g" DataField="precal_g" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="mixed_g" SortExpression="mixed_g" DataField="mixed_g" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="team_score" SortExpression="team_score" ReadOnly="True" DataField="team_score" ItemStyle-Wrap="false"/>

          </Columns>
          </ASP:DataGrid> 
<br /> Usually click the following button the last after getting individual scores from excel, editing the table on the page <a href="individualg.aspx">individualg.aspx</a> if necessary, editing/changing group scores in the above table - <font color="red">in this order</font> <br />
       Anytime changes are made in the first 3 steps, this button should be clicked to update the team scores <br /> <br />
<asp:button text="Update team scores after updating individual and group scores"  onClick="updateTeamScore" runat="server"/>
          
   </form><asp:label id="message" forecolor="blue" runat=server />
          </body>
</html>