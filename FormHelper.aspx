     <script language="C#" runat="server">
         OdbcConnection dbconn;
           
         String SchoolID;String pass;String uname; 
         String[] teamno;//{"","2","6","8"} team1.Text=teamno[1]; etc.
         void Page_Load(Object Src, EventArgs E) {
          HttpCookie uFormcookie = Request.Cookies["uvalidation"];
          ViewState["Referer"] = Request.Headers["Referer"];
          
          

         dbconn = new OdbcConnection("Driver={SQL Server Native Client 10.0};Server=tcp:ufwryy6r0y.database.windows.net,1433;Database=xyzstart_db;Uid=xyzdb@ufwryy6r0y;Pwd=virAf89Hda;Encrypt=yes;Connection Timeout=30;");               teamno=new String[4]; teamno[0]="";teamno[1]="2";teamno[2]="6";teamno[3]="8";
         if(uFormcookie!=null){
           if((String)uFormcookie.Values["valid_word"]!="collegebound"){Response.Redirect("uLogin.aspx", true);}}
         else{Response.Redirect("uLogin.aspx", true);}

         uname=(String)uFormcookie.Values["username"];

         OdbcCommand findSchoolInfoCmd= new OdbcCommand("SELECT school_id,[password], school_name FROM schools WHERE school=?",dbconn);
         
         findSchoolInfoCmd.Parameters.Add(new OdbcParameter("@school",OdbcType.VarChar,20));
         findSchoolInfoCmd.Parameters["@school"].Value=uname;

         dbconn.Open();
         OdbcDataReader dbread =findSchoolInfoCmd.ExecuteReader();
         if(dbread.Read()){SchoolID=dbread.GetString(0);pass=dbread.GetString(1);schoolNAME.Text=dbread.GetString(2);}
         dbread.Close();
         dbconn.Close();
         
         //String uname=(String)uFormcookie.Values["username"];
         if((String)uFormcookie.Values["mstr"]=="mstrmobb13g"){}
         else{
         if(uname==pass){Response.Redirect("uPassChange.aspx", true);}}

         if (SchoolID.Length==1)
            {SchoolID="00"+SchoolID;}
         else if(SchoolID.Length==2)
            {SchoolID="0"+SchoolID;}
         int schoolInt=Convert.ToInt16(SchoolID.Substring(0,1))+Convert.ToInt16(SchoolID.Substring(1,1))+Convert.ToInt16(SchoolID.Substring(2,1));

          
        if(!IsPostBack){ int tempInt=0;
         String tempString="";
         
         String[] s={"","111","121","131","140","717","727","737","740","313","323","333","340"}; 
         ArrayList al=new ArrayList(); al.Add("");
         for(int j=1; j<=3;j++){
         for (int i=1; i<=12; i++){
               tempInt=schoolInt+Convert.ToInt16(teamno[j])+Convert.ToInt16(s[i].Substring(0,1))
                 +Convert.ToInt16(s[i].Substring(1,1))+Convert.ToInt16(s[i].Substring(2,1));
               tempString=tempInt.ToString();
               if(tempString.Length==1){tempString="0"+tempString;}
         
               al.Add(SchoolID+teamno[j]+s[i].Substring(0,2)+tempString+s[i].Substring(2,1));
         
              
             } }
          
          team1_1_id.Text=(String)al[1];team1_2_id.Text=(String)al[2];team1_3_id.Text=(String)al[3];team1_4_id.Text=(String)al[4];
          team1_5_id.Text=(String)al[5];team1_6_id.Text=(String)al[6];team1_7_id.Text=(String)al[7];team1_8_id.Text=(String)al[8];
          team1_9_id.Text=(String)al[9];team1_10_id.Text=(String)al[10];team1_11_id.Text=(String)al[11];team1_12_id.Text=(String)al[12];

          team2_1_id.Text=(String)al[13];team2_2_id.Text=(String)al[14];team2_3_id.Text=(String)al[15];team2_4_id.Text=(String)al[16];
          team2_5_id.Text=(String)al[17];team2_6_id.Text=(String)al[18];team2_7_id.Text=(String)al[19];team2_8_id.Text=(String)al[20];
          team2_9_id.Text=(String)al[21];team2_10_id.Text=(String)al[22];team2_11_id.Text=(String)al[23];team2_12_id.Text=(String)al[24];

          /* team3_1_id.Text=(String)al[25];team3_2_id.Text=(String)al[26];team3_3_id.Text=(String)al[27];team3_4_id.Text=(String)al[28];
          team3_5_id.Text=(String)al[29];team3_6_id.Text=(String)al[30];team3_7_id.Text=(String)al[31];team3_8_id.Text=(String)al[32];
          team3_9_id.Text=(String)al[33];team3_10_id.Text=(String)al[34];team3_11_id.Text=(String)al[35];team3_12_id.Text=(String)al[36];*/

         populateForm(); 
           } 
          //after postback, message1 reports the progress in filling the form; 
          //without this, after deleting a team, message1 always displays the alert javascript     
          //message1.Text="";
        }
     
     
    void participate_save_1(Object Src, EventArgs E){participate_save(1);message1.Text=messageHidden.Text;}
    void participate_save_2(Object Src, EventArgs E){participate_save(2);message2.Text=messageHidden.Text;}
    //void participate_save_3(Object Src, EventArgs E){participate_save(3);message3.Text=messageHidden.Text;}
    void participate_save_all(Object Src, EventArgs E){participate_save(1);participate_save(2);//participate_save(3); 
       messageAll.Text=""; 
     message1.Text=messageHidden.Text;message2.Text=messageHidden.Text; //message3.Text=messageHidden.Text;
       }
    void participate_save(int j){
         
        
         OdbcCommand insComm = new OdbcCommand("INSERT INTO participants ( student_id,name, category, [roup], school,team_id) Values (@sdt_id,@name, @cat, @group, @school,@team_id)", dbconn);
         OdbcCommand insTeamComm = new OdbcCommand("INSERT INTO teams ( team_id,team_no,school) Values (?,?, ?)", dbconn);
         OdbcCommand updComm=new OdbcCommand("UPDATE participants SET student_id=@s_id, name=@s_name WHERE student_id=@s_id",dbconn); 
         OdbcCommand delCmd=new OdbcCommand("DELETE FROM participants WHERE student_id=@s_id",dbconn);                                              
         OdbcCommand selComm=new OdbcCommand("SELECT student_id FROM participants WHERE student_id=?",dbconn);
         OdbcCommand selTeamComm=new OdbcCommand("SELECT team_id FROM teams WHERE team_id=?",dbconn); 
             insComm.Parameters.Add(new OdbcParameter("@sdt_id", OdbcType.VarChar, 9));
             insComm.Parameters.Add(new OdbcParameter("@name", OdbcType.VarChar, 20));
             insComm.Parameters.Add(new OdbcParameter("@cat", OdbcType.VarChar, 8));
             insComm.Parameters.Add(new OdbcParameter("@group", OdbcType.VarChar, 8));

             insComm.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
             insComm.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
             insTeamComm.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
             insTeamComm.Parameters.Add(new OdbcParameter("@team_no", OdbcType.VarChar, 1));
             insTeamComm.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
             updComm.Parameters.Add(new OdbcParameter("@s_id", OdbcType.VarChar, 9));
             updComm.Parameters.Add(new OdbcParameter("@s_name", OdbcType.VarChar, 20));
             delCmd.Parameters.Add(new OdbcParameter("@s_id", OdbcType.VarChar, 9));
             selComm.Parameters.Add(new OdbcParameter("@student_id", OdbcType.VarChar, 9));
             selTeamComm.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));

             insComm.Parameters["@school"].Value = uname;

             insComm.Parameters["@team_id"].Value = SchoolID+teamno[j];

             insTeamComm.Parameters["@team_id"].Value = SchoolID+teamno[j];

             insTeamComm.Parameters["@team_no"].Value = teamno[j];

             insTeamComm.Parameters["@school"].Value = uname;
             selTeamComm.Parameters["@team_id"].Value = SchoolID+teamno[j];
             
             
             OdbcDataReader selread, selTeamRead;
            
             for(int i=1; i<=12; i++){
             if(i<=4){insComm.Parameters["@cat"].Value = "Algebra";}
             else if (i<=8){insComm.Parameters["@cat"].Value = "Geometry";}
             else {insComm.Parameters["@cat"].Value = "PreCal";}
             
             if(i%4==0){insComm.Parameters["@group"].Value = "Mixed";}
             else {insComm.Parameters["@group"].Value = "Subject";}
             
             /*if(i==4 || i==8 || i==12){insComm.Parameters["@group"].Value = "Mixed";}
             else {insComm.Parameters["@group"].Value = "Subject";}*/
             
             insComm.Parameters["@sdt_id"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()+"_id"];//

             insComm.Parameters["@name"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()];//alg1.Text;

 
             dbconn.Open();

             updComm.Parameters["@s_id"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()+"_id"];

             updComm.Parameters["@s_name"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()];

             delCmd.Parameters["@s_id"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()+"_id"];

             selComm.Parameters["@student_id"].Value = Request.Form["team"+j.ToString()+"_"+i.ToString()+"_id"];

             
             selread =selComm.ExecuteReader();
             if(selread.Read()){selread.Close();
                              if ((Request.Form["team"+j.ToString()+"_"+i.ToString()]).Trim()!="")  
                                {updComm.ExecuteNonQuery();}
                              else {delCmd.ExecuteNonQuery();}
                                dbconn.Close();//populateForm();
                               }
             else if ((Request.Form["team"+j.ToString()+"_"+i.ToString()]).Trim()!="")
                {selread.Close();selTeamRead=selTeamComm.ExecuteReader();
                  if(!selTeamRead.Read()){selTeamRead.Close();insTeamComm.ExecuteNonQuery();}
                   else{ selTeamRead.Close();}
                  insComm.ExecuteNonQuery();dbconn.Close();
                   //populateForm();
                  } 
               else{selread.Close();dbconn.Close();//populateForm();
                   }
               }
            //delete team if there is no participant in the team; record/update how many in the team
         OdbcCommand selPFromT=new OdbcCommand("SELECT student_id FROM participants WHERE team_id=?",dbconn); 
         selPFromT.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
         selPFromT.Parameters["@team_id"].Value = SchoolID+teamno[j];
         OdbcCommand deleteT=new OdbcCommand("DELETE FROM teams WHERE team_id=?",dbconn);
         deleteT.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
         deleteT.Parameters["@team_id"].Value = SchoolID+teamno[j];
         OdbcCommand udSCount=new OdbcCommand("UPDATE teams SET team_id=@tid,team_status=@tstatus, [ount]=@pcount  WHERE team_id=@tid",dbconn);//count is a reserved word?!
         udSCount.Parameters.Add(new OdbcParameter("@tid", OdbcType.VarChar, 4));
         udSCount.Parameters["@tid"].Value = SchoolID+teamno[j]; 
         udSCount.Parameters.Add(new OdbcParameter("@tstatus", OdbcType.Bit));
         udSCount.Parameters["@tstatus"].Value = false; 
         udSCount.Parameters.Add(new OdbcParameter("@pcount", OdbcType.Int, 2));
               
         dbconn.Open();
         OdbcDataReader selPinTReader=selPFromT.ExecuteReader();
         int PinT=0;
         while(selPinTReader.Read()){PinT++;} selPinTReader.Close();
         udSCount.Parameters["@pcount"].Value =PinT;
         if(PinT==0){deleteT.ExecuteNonQuery();}
         else{udSCount.ExecuteNonQuery();}
             
         
         dbconn.Close();
         messageHidden.Text="Changes to this team SAVED!";
         populateForm();
        }
    void populateForm(){//message1.Text="<script language='javascript'"+">"+"alert('what');"+"</scri"+"pt>";
                    OdbcCommand populateFormCmd= new OdbcCommand("SELECT student_id, name FROM participants WHERE school=?",dbconn);
         
         populateFormCmd.Parameters.Add(new OdbcParameter("@school",OdbcType.VarChar,20));
         populateFormCmd.Parameters["@school"].Value=uname;

          // decide how many teams confirmed, and working on how many teams? somewhat!
         OdbcCommand numConfirmedCmd= new OdbcCommand("SELECT * FROM teams WHERE team_status= 'true' AND school=?",dbconn);
         numConfirmedCmd.Parameters.Add(new OdbcParameter("@school",OdbcType.VarChar,20));
         numConfirmedCmd.Parameters["@school"].Value=uname;  

         OdbcCommand numConsideredCmd= new OdbcCommand("SELECT [ount] FROM teams WHERE team_status= 'false' AND school=?",dbconn);
         numConsideredCmd.Parameters.Add(new OdbcParameter("@school",OdbcType.VarChar,20));
         numConsideredCmd.Parameters["@school"].Value=uname;       

        OdbcCommand contInfoCmd= new OdbcCommand("SELECT contact, email, phone FROM schools WHERE school=?",dbconn);
         contInfoCmd.Parameters.Add(new OdbcParameter("@school",OdbcType.VarChar,20));
         contInfoCmd.Parameters["@school"].Value=uname; 
         
          //these gurrantee those not in database to appear blank; otherwise cancel_changes only cancel changes to those already in database.
          team1_1.Text="";team1_2.Text="";team1_3.Text="";team1_4.Text="";
          team1_5.Text="";team1_6.Text="";team1_7.Text="";team1_8.Text="";
          team1_9.Text="";team1_10.Text="";team1_11.Text="";team1_12.Text="";

          team2_1.Text="";team2_2.Text="";team2_3.Text="";team2_4.Text="";
          team2_5.Text="";team2_6.Text="";team2_7.Text="";team2_8.Text="";
          team2_9.Text="";team2_10.Text="";team2_11.Text="";team2_12.Text=""; 

          /*team3_1.Text="";team3_2.Text="";team3_3.Text="";team3_4.Text="";
          team3_5.Text="";team3_6.Text="";team3_7.Text="";team3_8.Text="";
          team3_9.Text="";team3_10.Text="";team3_11.Text="";team3_12.Text=""; */        

         dbconn.Open();
         OdbcDataReader popuread =populateFormCmd.ExecuteReader();         
         while(popuread.Read()){
                  String sid=popuread.GetString(0);
                  String sname=popuread.GetString(1);
                  if(sid==team1_1_id.Text){team1_1.Text=sname;}
                  else if(sid==team1_2_id.Text){team1_2.Text=sname;}
                  else if(sid==team1_3_id.Text){team1_3.Text=sname;}
                  else if(sid==team1_4_id.Text){team1_4.Text=sname;}
                  else if(sid==team1_5_id.Text){team1_5.Text=sname;}
                  else if(sid==team1_6_id.Text){team1_6.Text=sname;}
                  else if(sid==team1_7_id.Text){team1_7.Text=sname;}
                  else if(sid==team1_8_id.Text){team1_8.Text=sname;}
                  else if(sid==team1_9_id.Text){team1_9.Text=sname;}
                  else if(sid==team1_10_id.Text){team1_10.Text=sname;}
                  else if(sid==team1_11_id.Text){team1_11.Text=sname;}
                  else if(sid==team1_12_id.Text){team1_12.Text=sname;}

                  if(sid==team2_1_id.Text){team2_1.Text=sname;}
                  else if(sid==team2_2_id.Text){team2_2.Text=sname;}
                  else if(sid==team2_3_id.Text){team2_3.Text=sname;}
                  else if(sid==team2_4_id.Text){team2_4.Text=sname;}
                  else if(sid==team2_5_id.Text){team2_5.Text=sname;}
                  else if(sid==team2_6_id.Text){team2_6.Text=sname;}
                  else if(sid==team2_7_id.Text){team2_7.Text=sname;}
                  else if(sid==team2_8_id.Text){team2_8.Text=sname;}
                  else if(sid==team2_9_id.Text){team2_9.Text=sname;}
                  else if(sid==team2_10_id.Text){team2_10.Text=sname;}
                  else if(sid==team2_11_id.Text){team2_11.Text=sname;}
                  else if(sid==team2_12_id.Text){team2_12.Text=sname;}

                 /* if(sid==team3_1_id.Text){team3_1.Text=sname;}
                  else if(sid==team3_2_id.Text){team3_2.Text=sname;}
                  else if(sid==team3_3_id.Text){team3_3.Text=sname;}
                  else if(sid==team3_4_id.Text){team3_4.Text=sname;}
                  else if(sid==team3_5_id.Text){team3_5.Text=sname;}
                  else if(sid==team3_6_id.Text){team3_6.Text=sname;}
                  else if(sid==team3_7_id.Text){team3_7.Text=sname;}
                  else if(sid==team3_8_id.Text){team3_8.Text=sname;}
                  else if(sid==team3_9_id.Text){team3_9.Text=sname;}
                  else if(sid==team3_10_id.Text){team3_10.Text=sname;}
                  else if(sid==team3_11_id.Text){team3_11.Text=sname;}
                  else if(sid==team3_12_id.Text){team3_12.Text=sname;}*/
                 
                  }
         popuread.Close();

         //decide how many teams confirmed
         OdbcDataReader confirmedR =numConfirmedCmd.ExecuteReader();
         int nconfirmed =0;
         while(confirmedR.Read()){nconfirmed++;}
         confirmedR.Close();
         summary.Text="You have "+nconfirmed.ToString()+" complete team(s).<br />Incomplete teams:<br />";
         //decide how many teams being worked on
         OdbcDataReader consideredR =numConsideredCmd.ExecuteReader();
         int nConsidered=0;
         while(consideredR.Read()){int nShort=12-consideredR.GetInt32(0);nConsidered++;
                                   summary.Text+="one team needs "+nShort.ToString()+" student(s) to complete<br />";}
         summary.Text+="Totally "+nConsidered.ToString()+" incomplete team(s)";
         consideredR.Close();

         OdbcDataReader contInfoR =contInfoCmd.ExecuteReader();
         if(contInfoR.Read()){cont.Text=contInfoR.GetString(0);cont_email.Text=contInfoR.GetString(1);
                              cont_phone.Text=contInfoR.GetString(2);}
          contInfoR.Close();

         dbconn.Close();
         HttpCookie extcookie = Request.Cookies["uvalidation"];
         extcookie.Expires=DateTime.Now.AddMinutes(60);
         Response.AppendCookie(extcookie);
                      }
    void participate_confirm_1(Object Src, EventArgs E){
                  //allow confirmation of a team if 12 participants;anytime usng save or cancel etc.
                  // should reconfirm
                 participate_save(1);
                 participate_confirm(1);
                 //no need to populateForm() again
                 message1.Text=messageHidden.Text;messageHidden.Text="";
             }
    void participate_confirm_2(Object Src, EventArgs E){participate_save(2);participate_confirm(2);message2.Text=messageHidden.Text;messageHidden.Text="";}
    /*void participate_confirm_3(Object Src, EventArgs E){participate_save(3);participate_confirm(3);message3.Text=messageHidden.Text;messageHidden.Text="";}*/

    void participate_confirm_all(Object Src, EventArgs E){
                 participate_save(1);
                 participate_confirm(1);message1.Text=messageHidden.Text;messageHidden.Text="";
                 
                 participate_save(2);
                 participate_confirm(2);message2.Text=messageHidden.Text;messageHidden.Text="";
             }

    void participate_confirm(int j){
              OdbcCommand countInT=new OdbcCommand("SELECT [ount] FROM teams WHERE team_id=?",dbconn);
         countInT.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
         countInT.Parameters["@team_id"].Value = SchoolID+teamno[j]; 
         OdbcCommand confirmUpd=new OdbcCommand("UPDATE teams SET team_id=@team_id, team_status=@team_status WHERE team_id=@team_id",dbconn);
         confirmUpd.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
         confirmUpd.Parameters["@team_id"].Value = SchoolID+teamno[j]; 
         confirmUpd.Parameters.Add(new OdbcParameter("@team_status", OdbcType.Bit));//change to Bit
         confirmUpd.Parameters["@team_status"].Value = true; 
               //need change true to? True; no need to consider "False" situation.default is false unless manually changed in db.
         dbconn.Open();
         OdbcDataReader countRead =countInT.ExecuteReader();
         if(countRead.Read()){int shortOfT=12-countRead.GetInt32(0); countRead.Close();// int is treated as int32; GetInt16 doesn't work
                             if(shortOfT!=0){
                            
                            messageHidden.Text="SAVED! You need "+shortOfT.ToString()+" more students to make this a complete team (12 participants)!";
                                     }
                              else{
                            
                            confirmUpd.ExecuteNonQuery();
                            messageHidden.Text="This team (with 12 participants) is complete! Congratulations!";
                                  }
                            } else{countRead.Close(); messageHidden.Text="This team does not exist! Please add participants!";}
         dbconn.Close();
         //need this because participate_save (first in participate_confirm_1 etc) changes team status   
         populateForm(); 
            }

    void delete_team_1(Object Src, EventArgs E){delete_team(1);  message1.Text=messageHidden.Text;messageHidden.Text="";}
    void delete_team_2(Object Src, EventArgs E){delete_team(2);  message2.Text=messageHidden.Text;messageHidden.Text="";}
   // void delete_team_3(Object Src, EventArgs E){delete_team(3);  message3.Text=messageHidden.Text;messageHidden.Text="";}

    void delete_team(int j){
                 
                  OdbcCommand delTComm = new OdbcCommand("DELETE FROM teams WHERE team_id=@team_id", dbconn);
                  delTComm.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
                  delTComm.Parameters["@team_id"].Value=SchoolID+teamno[j];
                  OdbcCommand selTComm = new OdbcCommand("SELECT team_id FROM teams WHERE team_id=?", dbconn);
                  selTComm.Parameters.Add(new OdbcParameter("@team_id", OdbcType.VarChar, 4));
                  selTComm.Parameters["@team_id"].Value=SchoolID+teamno[j];
                  dbconn.Open();
                  OdbcDataReader tReader=selTComm.ExecuteReader();
                  if(tReader.Read()){tReader.Close();delTComm.ExecuteNonQuery();messageHidden.Text="This team deleted!";}
                    else{
                          tReader.Close();
                          messageHidden.Text= "This team doesnt exist";
                          // "<script language='javascript'"+">"+"alert('The team doesnt exist!');"+"</scri"+"pt>";
                           }
                  dbconn.Close();
                  populateForm(); //should work instead of the following but populateForm() requires dbconn
         /* team1_1.Text="";team1_2.Text="";team1_3.Text="";team1_4.Text="";
          team1_5.Text="";team1_6.Text="";team1_7.Text="";team1_8.Text="";
          team1_9.Text="";team1_10.Text="";team1_11.Text="";team1_12.Text="";  */              
                  
                     }
    void cancel_all_changes(Object Src, EventArgs E){
                populateForm();messageAll.Text="";
                message1.Text="Changes cancelled!";message2.Text="Changes cancelled!";
                //message3.Text="Changes cancelled!";
                 }
    void cancel_changes_1(Object Src, EventArgs E){populateForm();message1.Text="Changes cancelled!";}
    void cancel_changes_2(Object Src, EventArgs E){populateForm();message2.Text="Changes cancelled!";}
    //void cancel_changes_3(Object Src, EventArgs E){populateForm();message3.Text="Changes cancelled!";}
    void doNothing(Object Src, EventArgs E){}
    void logout(Object Src, EventArgs E){
       Session.Abandon();//uFormcookie=null;
       HttpCookie uFcookie = Request.Cookies["uvalidation"];
       uFcookie["username"]="";
       uFcookie["valid_word"]="";
       uFcookie["mstr"]="";
       Response.AppendCookie(uFcookie);//need this line
       uFcookie.Expires=DateTime.Now.AddMinutes(-1);
       Response.Redirect("uLogin.aspx", true);
       }
    void changePassword(Object Src, EventArgs E){
         Response.Redirect("uPassChange.aspx", true);
      }
    void save_cont(Object Src, EventArgs E){
         OdbcCommand contUpd=new OdbcCommand("UPDATE schools SET school=@school, contact=@cont, email=@email, phone=@phone WHERE school=@school",dbconn);
         contUpd.Parameters.Add(new OdbcParameter("@school", OdbcType.VarChar, 20));
         contUpd.Parameters["@school"].Value = uname;
         contUpd.Parameters.Add(new OdbcParameter("@cont", OdbcType.VarChar, 20));
         contUpd.Parameters["@cont"].Value = cont.Text; 
         contUpd.Parameters.Add(new OdbcParameter("@email", OdbcType.VarChar, 50));
         contUpd.Parameters["@email"].Value =cont_email.Text;
         contUpd.Parameters.Add(new OdbcParameter("@phone", OdbcType.VarChar, 20));
         contUpd.Parameters["@phone"].Value = cont_phone.Text;
         dbconn.Open();
         contUpd.ExecuteNonQuery();
         cont_m.Text="Thank you for the update!<br />Please let the new contact know the username and current password for this website.";
         dbconn.Close();
         populateForm();            
         
      }
    </script>     