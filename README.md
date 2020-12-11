<h2> Exchange_Journal_Tracker</h2>
<strong><u>Description</u>:</strong> 
  <br/>&nbsp;&nbsp;&nbsp;&nbsp;Exchange 2016 On-Premise DB Journal Message Tracker Script 

<strong><u>Useage</u>:</strong> 
  <br/>Can be launched in a Powershell session on a system that has Exchange Shell also installed on the System. Also great as a task manager task to run on schedule. This will         provide some key insight on number of messages sent and number of messages that were Journaled.

<strong><u>Programmer</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Paul Marcantonio
     
<strong><u>Date</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;October 2 2019
     
<strong><u>Version</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;1.5

<strong><u>Pre-Condition</u>:</strong>
  <br/>&nbsp;&nbsp;&nbsp;&nbsp;Powershell be installed and with execution policy set to remote signed
  Exchange Powershell Shell (version to match Exchange Server version) is installed on this system as well
  User that this script runs under has Exchange enterprise Level rights to retrieve information

<strong><u>Project Title</u>:</strong>
<br/>&nbsp;&nbsp;&nbsp;&nbsp;Exchange Message Tracking Report

<strong><u>Objective</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Collect all message activity between start and end dates (in this case past 24 hours)
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Provide summary breakdowns based on each type of EventID
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Build HTML file of EventID data breakdowns
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Send Email Summary table of key EventID totals

<strong><u>Pre-Condition(s)</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Powershell Execution Policy set to Remove Signed (Get-ExecutionPolicy, Set-ExecutionPolicy RemoteSigned)
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Exchange Management Shell installed on the scripting server (Using the Exchange ISO and choose management console only)
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;User this script executes under should have Exchange Enterprise rights (https://docs.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps)
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Folder structure and right to reading and writing HTML file to
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;The server this script runs on must be on the "allow relay" on any and all load balancers infront of exchange and within exchange

<strong><u>Post-Condition(s)</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;New HTML file with message EventID created on target server
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Email sent to the desired email list with:
          <ul>
            <li>HTML summary table</li>
            <li>Link to HTML file created</li>
            <li>Copy of the HTML file created</li>
          </ul>
 <strong><u>Installation</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Make sure Powershell version 3 or above is installed on the server (Server Role and Features (Windows Powershell)
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Install Exchange 2016 Management tools https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;Copy the script to designated location for execution

<strong><u>Contributing</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;https://docs.microsoft.com/en-us/exchange/mail-flow/transport-logs/message-tracking?view=exchserver-2019
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019

<strong><u>Citations</u>:</strong>
     <br/>&nbsp;&nbsp;&nbsp;&nbsp;None
