# Exchange_Journal_Tracker
<strong><u>Description</u>:</strong> 
  Exchange 2016 On-Premise DB Journal Message Tracker Script 

<strong><u>Useage</u>:</strong> 
  Can be launched in a Powershell session on a system that has Exchange Shell also installed on the System. Also great as a task manager task to run on schedule. This will         provide some key insight on number of messages sent and number of messages that were Journaled.

<strong><u>Pre-Condition</u>:</strong>
  Powershell be installed and with execution policy set to remote signed
  Exchange Powershell Shell (version to match Exchange Server version) is installed on this system as well
  User that this script runs under has Exchange enterprise Level rights to retrieve information

<strong><u>Project Title</u>:</strong> Exchange Message Tracking Report

<strong><u>Programmer</u>:</strong>
     Paul Marcantonio
     
<strong><u>Date</u>:</strong>
     October 2 2019
     
<strong><u>Version</u>:</strong>
     1.5
     
<strong><u>Objective</u>:</strong>
     - Collect all message activity between start and end dates (in this case past 24 hours)
     - Provide summary breakdowns based on each type of EventID
     - Build HTML file of EventID data breakdowns
     - Send Email Summary table of key EventID totals

<strong><u>Pre-Condition(s)</u>:</strong>
     - Powershell Execution Policy set to Remove Signed (Get-ExecutionPolicy, Set-ExecutionPolicy RemoteSigned)
     - Exchange Management Shell installed on the scripting server (Using the Exchange ISO and choose management console only)
     - User this script executes under should have Exchange Enterprise rights (https://docs.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps)
     - Folder structure and right to reading and writing HTML file to
     - The server this script runs on must be on the "allow relay" on any and all load balancers infront of exchange and within exchange

<strong><u>Post-Condition(s)</u>:</strong>
     - New HTML file with message EventID created on target server
     - Email sent to the desired email list with:
          * HTML summary table
          * Link to HTML file created
          * Copy of the HTML file

<strong><u>Installation</u>:</strong>
     - Make sure Powershell version 3 or above is installed on the server (Server Role and Features (Windows Powershell)
     - Install Exchange 2016 Management tools https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019
     - Copy the script to designated location for execution

<strong><u>Contributing</u>:</strong>
     - https://docs.microsoft.com/en-us/exchange/mail-flow/transport-logs/message-tracking?view=exchserver-2019
     - https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019

<strong><u>Citations</u>:</strong>
     None
