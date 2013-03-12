<%@ Page Language="C#" runat=server debug="true" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data"%>

<html>
<head><link REL="SHORTCUT ICON" HREF="http://www.marshfield.uwc.edu/faculty/jlu/ml/favicon.ico">
<link rel="stylesheet" type="text/css"
href="mystyle.css" />
<title>Math League</title>
<script type="text/javascript">
function startTime()
{
var today=new Date()
var d=today.getDate()
var y=today.getFullYear()
var mon=today.getMonth()+1
var h=today.getHours()
var m=today.getMinutes()
var s=today.getSeconds()
// add a zero in front of numbers<10
m=checkTime(m)
s=checkTime(s)
document.getElementById('timeTxt').innerHTML=mon+"/"+d+"/"+y+" "+h+":"+m+":"+s
t=setTimeout('startTime()',500)
}

function checkTime(i)
{
if (i<10) 
  {i="0" + i}
  return i
}
</script>

</head>


<!-- #include File = "FormHelper.aspx" -->
   
      <script type="text/javascript">
         function noEnter(e){
           var keynum;
           if(window.event){keynum=e.keyCode;}
           else {keynum=e.which;}
           
           if(keynum == 13)
           {e.returnValue=false; e.cancel=true;}
         }
         
      </script>
  
   
   <body onLoad="startTime()" onKeyDown="noEnter(event)">
        <center>
       <table><tr><td align="left">
       <table><tr><td align="left" valign="middle">
       <table><tr><td align="left"><asp:label id="schoolNAME" runat=server /></td></tr>
              <tr><td align="left">Welcome to the Annual MathLeague!</td></tr>
              <tr><td align="left" style="text-decoration: underline">Wednesday</td></tr>
              <tr><td align="left">Current Time: <span id="timeTxt"></span></td></tr></table></td>
        <td align="right"><table class="summary">
 <tr><td align="center" valign="top" class="summ" >STATUS</td></tr><tr><td> <asp:label id="summary" Text="" runat=server /></td></tr></table></td></tr></table> </td>
       <td /></tr></table></center>

        
        <center>
        <form id="form1" method="post" runat="server" autocomplete="off">
        <table><tr><td>
       <table><tr><td align="right"><asp:button text="" onClick="doNothing" disabled="disabled" Style="border-style:solid;width: 0px;  background-color: #FFFFFF;border-color:#FFFFF"  runat="server"/>Principal Contact</td>
              <td><asp:textbox id="cont" class="cont_i" runat="server" /><br />
              <asp:RequiredFieldValidator id="contactValidator" runat="server"
                      ControlToValidate="cont"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> contact field should not be empty
                  </asp:RequiredFieldValidator></td></tr>
                   
                   
      <tr><td align="right">contact email</td><td><asp:textbox id="cont_email" class="cont_i" runat="server"/><br />
              <asp:RequiredFieldValidator id="emailValidator" runat="server"
                      ControlToValidate="cont_email"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> email field should not be empty
                  </asp:RequiredFieldValidator></td></tr>
      <tr><td align="right">contact phone</td><td><asp:textbox id="cont_phone" class="cont_i" runat="server" /><br />
              <asp:RequiredFieldValidator id="phoneValidator" runat="server"
                      ControlToValidate="cont_phone"
                      Display="Dynamic"
                      Font-Name="Verdana" Font-Size="10pt"> phone field should not be empty
                  </asp:RequiredFieldValidator></td></tr>
       </table>
       </td>            
      <td>
       <table><tr><td><asp:button id="cont_b" text="modify the contact" onClick="save_cont" runat="server" />  </td>
           </tr></table>
      </td></tr></table>
            <asp:label id="cont_m" Text="" forecolor="red" runat=server />
       <center><a href="javascript:void(window.open('rules.html','rules','width=280, height=650,left=0,
top=0,location=no,menubar=no,status=no,toolbar=no,scrollbars=yes,resizable=no,fullscreen=no'))">Competition Format and Rules</a>
        &nbsp;<a href="javascript:void(window.open('schedule.html','details','width=270, height=190,left=0,
top=0,location=no,menubar=no,status=no,toolbar=no,scrollbars=yes,resizable=no,fullscreen=no'))">Program Detail and Schedule</a>
      </center> 
     <table>
            <tr><td align="left">You may change the composition of your team(s) as often as you like until <u>noon</u> Monday, April 16th.</td></tr>
            <tr><td align="left">For help with using this form, please click <a href="helpWithForm.doc">here</a>. For other technical questions, contact jinbo.lu@uwc.edu.</td></tr>
            <tr><td align="left"><a href="javascript:void(window.open('idexplained.html','idexplained','width=350, height=200,left=0,
top=0,location=no,menubar=no,status=no,toolbar=no,scrollbars=yes,resizable=no,fullscreen=no'))">Here</a> is an explanation on how id's are assigned.</td></tr>
            <tr><td align="left">If you prefer to receive a paper form via email, please contact kavita.bhatia@uwc.edu or (715)389-6548.</td></tr>
</table>   

        <table><tr><td>
        <table>
        <tr><td /> <td align="right"><span class="team_name"><asp:Literal id="team1"  Text="1st team" runat="server" /></span></td> <td /> <td /> <td align="center" ><span class="mixed_text">Mixed Group (this column)</span></td></tr>
        <tr><td align="right">Algebra<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True" id="team1_1_id" Text="111" Columns="20" MaxLength="20"  runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_1"  class="teamone algebra" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_2_id" Text="121" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_2"  class="teamone algebra" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_3_id" Text="131" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_3"  class="teamone algebra" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True" id="team1_4_id" Text="140" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_4"  class="teamone mixed_a" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>           
           </tr>
        <tr><td align="right">Geometry<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_5_id" Text="717" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_5"  class="teamone geometry" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_6_id" Text="727" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_6"  class="teamone geometry" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_7_id" Text="737" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_7"  class="teamone geometry" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True"  id="team1_8_id" Text="740" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_8"  class="teamone mixed_g" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>   
           </tr>
        <tr><td align="right">PreCal<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_9_id" Text="313" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_9"  class="teamone prec" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_10_id" Text="323" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_10"  class="teamone prec" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team1_11_id" Text="333" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_11"  class="teamone prec" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True"  id="team1_12_id" Text="340" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team1_12"  class="teamone mixed_p" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>   
           </tr>
        </table>
        </td>
        <td>
        <table>
        <tr><td>Build the first team 
          </td></tr>        
        <tr><td><asp:button text="log out" class="log_out" onClick="logout" runat="server"/></td></tr>
        <tr><td /></tr>
        <tr><td><asp:button text="delete this team" class="delete_team" onClick="delete_team_1" runat="server"/></td></tr>
        <tr><td /></tr>
       
        <tr><td /></tr>
        <tr><td><asp:button text="save this team" class="confirm" onClick="participate_confirm_1" runat="server"/></td></tr>
        
        </table>
        </td>
        </tr><tr><td align="right">NOTE: <asp:label id="message1" Text="Add/modify students. You must click 'save this team' to save any change." forecolor="red" runat=server /></td><td /></tr></table>
        <br />


                <table><tr><td>
                <table>
        <tr><td /><td align="right"><span class="team_name"><asp:Literal id="team2" Text="2nd team" runat="server" /></span></td>  <td /> <td /> <td align="center" ><span class="mixed_text">Mixed Group (this column)</span></td></tr>
        <tr><td align="right">Algebra<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True" id="team2_1_id" Text="111" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_1" class="teamtwo algebra"  align="center" Columns="20" MaxLength="20"  runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_2_id" Text="121" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_2" class="teamtwo algebra"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_3_id" Text="131" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_3" class="teamtwo algebra"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True" id="team2_4_id" Text="140" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_4"  class="teamtwo mixed_a" align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>           
           </tr>
        <tr><td align="right">Geometry<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_5_id" Text="717" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_5" class="teamtwo geometry"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_6_id" Text="727" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_6" class="teamtwo geometry"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_7_id" Text="737" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_7" class="teamtwo geometry"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True"  id="team2_8_id" Text="740" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_8" class="teamtwo mixed_g"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>   
           </tr>
        <tr><td align="right">PreCal<br />(this row)</td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_9_id" Text="313" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_9" class="teamtwo prec"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_10_id" Text="323" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_10" class="teamtwo prec"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit" ReadOnly="True"  id="team2_11_id" Text="333" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_11" class="teamtwo prec"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>
            <td><table>
                <tr><td align="center"><asp:textbox class="no-edit mixed_v" ReadOnly="True"  id="team2_12_id" Text="340" Columns="20" MaxLength="20" runat="server" /></td></tr>
                <tr><td align="center"><asp:textbox id="team2_12" class="teamtwo mixed_p"  align="center" Columns="20" MaxLength="20" runat="server" /></td></tr>
            </table></td>   
           </tr>
        </table>
        </td><td>
        <table>
        <tr><td>Second team if needed</td></tr>
        <tr><td><asp:button text="log out" class="log_out" onClick="logout" runat="server"/></td></tr>
        <tr><td /></tr>
        <tr><td><asp:button text="delete this team" class="delete_team" onClick="delete_team_2" runat="server"/></td></tr>
        <tr><td /></tr>
        
        <tr><td /></tr>
        <tr><td><asp:button text="save this team" class="confirm" onClick="participate_confirm_2" runat="server"/></td></tr>
        
        </table>
         </td></tr><tr><td align="right">NOTE: <asp:label id="message2" Text="Add/modify students. You must click 'save this team' to save any change." forecolor="red" runat=server /></td><td /></tr>
        </table>
        <br />    


       
       
        <asp:label id="messageHidden" Visible="False" Text="" runat=server />
<table><tr><td align="left"><asp:button class="change_pass" text="change password"  onClick="changePassword" runat="server"/></td>
           <td align="left"><asp:button class="log_out" text="log out"  onClick="logout" runat="server"/></td></tr>
       <tr><td align="left"><asp:button class="save_all" text="save all teams"  onClick="participate_confirm_all" runat="server"/></td>
           <td align="left"><asp:button class="cancel_all" text="cancel all changes"  onClick="cancel_all_changes" runat="server"/></td></tr>
       </table>
        <asp:label id="messageAll" Text="" forecolor="red" runat=server />
        
        </form>
        </center>

          </body>
</html>