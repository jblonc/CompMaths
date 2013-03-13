<%@ Page Language="C#" runat=server debug="true" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>
<%@ Import Namespace="System.Globalization" %>

<html>  
   
     <script language="C#" runat="server">
         OdbcConnection dbconn;
         void Page_Load(Object Src, EventArgs E) {
         //if(Session["validation"]!="allright"){Response.Redirect("adminLogin.aspx", true);} 
         dbconn = dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=xyzstart_db;Uid=xyzdb@ufwryy6r0y;Pwd=virAf89Hda;Encrypt=yes;Connection Timeout=30;");
         if(!IsPostBack)
         {
         BindGrid();
         Page.DataBind(); 
          }
        }
     
     
           //insert school not already in database with all info on the form
           // change password for school already in database, ignore other info entered on the form
      /* void schoolInsert (Object Src, EventArgs E){
            Page.Validate();
            if(!Page.IsValid){return;}
            

             
             OdbcCommand myOleDbInsComm = new OdbcCommand("INSERT INTO schools ( school,[password], school_id, school_name,contact,contact_detail, address) Values (?,?, ?, ?,?,?,?)", dbconn);
             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
             myOleDbInsComm.Parameters["@school"].Value = school.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@password", OdbcType.VarChar, 20));
             myOleDbInsComm.Parameters["@password"].Value = password.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school_id", OdbcType.Int));
             myOleDbInsComm.Parameters["@school_id"].Value = school_id.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school_name", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@school_name"].Value = school_name.Text;


             myOleDbInsComm.Parameters.Add(new OdbcParameter("@contact", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@contact"].Value = contact.Text;


             myOleDbInsComm.Parameters.Add(new OdbcParameter("@contact_det", OdbcType.VarChar, 50));
             myOleDbInsComm.Parameters["@contact_det"].Value = contact_det.Text;

             myOleDbInsComm.Parameters.Add(new OdbcParameter("@school_addr", OdbcType.VarChar, 100));
             myOleDbInsComm.Parameters["@school_addr"].Value = school_addr.Text;

             message.Text="";
             
             try
               {
  
               dbconn.Open();
               myOleDbInsComm.ExecuteNonQuery();
               
               //myOleDbCleanupComm.ExecuteNonQuery();
               
               
               }
            catch(Exception e)
                 {
                   message.Text= "Couldn't insert record: " + e.ToString();
                 }
            finally
              {
             dbconn.Close();
              }
             school.Text="";password.Text="";school_id.Text="";
             contact.Text="";contact_det.Text="";school_name.Text="";school_addr.Text="";
             BindGrid();
          }*/
     void schools_Edit(Object sender, DataGridCommandEventArgs e)
        {schools.EditItemIndex = (int)e.Item.ItemIndex; BindGrid(); }
     void schools_Cancel(Object sender, DataGridCommandEventArgs e)
        {schools.EditItemIndex = -1; BindGrid(); }
     void schools_Update(Object sender, DataGridCommandEventArgs e)
        {
         String updateCmd="UPDATE schools SET [password]=?, school_id=?,school_name=?,last_login=?, contact=?, contact_detail=?,part_status=?, address=? WHERE school=?";
         OdbcCommand myUpdateCmd= new OdbcCommand(updateCmd, dbconn);
         
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Npassword", OdbcType.VarChar, 20));  
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Nschool_id", OdbcType.Int));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Nschool_name", OdbcType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Nlast_login", OdbcType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Ncontact", OdbcType.VarChar, 50));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Ncontact_det", OdbcType.VarChar));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Npart_status", OdbcType.Bit));
         myUpdateCmd.Parameters.Add(new OdbcParameter("@Nschool_addr", OdbcType.VarChar, 100));
        myUpdateCmd.Parameters.Add(new OdbcParameter("@Nschool", OdbcType.VarChar, 20));
         myUpdateCmd.Parameters["@Nschool"].Value=schools.DataKeys[(int)e.Item.ItemIndex];
         String[] cols={"@Nschool","@Npassword","@Nschool_id","@Nschool_name","@Nlast_login","@Ncontact","@Ncontact_det","@Npart_status","@Nschool_addr"};
         int numCols=e.Item.Cells.Count;
         message.Text="";
         for (int i=2; i<numCols-1;i++)
            {
             String colvalue=((System.Web.UI.WebControls.TextBox) e.Item.Cells[i].Controls[0]).Text;
             myUpdateCmd.Parameters[cols[i-1]].Value = colvalue;
             message.Text+=colvalue+"<br />";
            }
          myUpdateCmd.Connection.Open();
          try{myUpdateCmd.ExecuteNonQuery();schools.EditItemIndex=-1;}
          catch(Exception ex){message.Text+="what's going on?";}
          myUpdateCmd.Connection.Close();
          BindGrid();
          message.Text+="working";
        }
     void BindGrid(){
        OdbcDataAdapter displayComm=new OdbcDataAdapter("SELECT * FROM schools", dbconn);
        DataSet ds= new DataSet();
        displayComm.Fill(ds, "schools");
        schools.DataSource=ds.Tables["schools"].DefaultView;
        schools.DataBind();
                }
    </script>
  
   <% Session.Timeout=60; %>
   <body>
    <form method="post" runat=server >
   
          <ASP:DataGrid id="schools" runat="server"
            Width="700"
            BackColor="#ccccff" 
            BorderColor="black"
            ShowFooter="false" 
            CellPadding=3 
            CellSpacing="0"
            Font-Name="Verdana"
            Font-Size="8pt"
            HeaderStyle-BackColor="#aaaadd"
            OnEditCommand="schools_Edit"
            OnCancelCommand="schools_Cancel"
            OnUpdateCommand="schools_Update"
            DataKeyField="school"
            AutoGenerateColumns="false"          
            
          >
          <Columns>
              <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update" ItemStyle-Wrap="false" />
              <asp:BoundColumn HeaderText="school" SortExpression="school" ReadOnly="True" DataField="school" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="password" SortExpression="password" DataField="password" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school_id" SortExpression="school_id" DataField="school_id" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="school_name" SortExpression="school_name" DataField="school_name" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="last_login" SortExpression="last_login"  DataField="last_login" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="contact" SortExpression="contact" DataField="contact" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="contact_detail" SortExpression="contact_detail" DataField="contact_detail" ItemStyle-Wrap="true"/>
              <asp:BoundColumn HeaderText="part_status" SortExpression="part_status" DataField="part_status" ItemStyle-Wrap="false"/>
              <asp:BoundColumn HeaderText="address" SortExpression="address" DataField="address" ItemStyle-Wrap="true"/>
          </Columns>
          </ASP:DataGrid>
          
   </form><asp:label id="message" forecolor="blue" runat=server />
          </body>
</html>