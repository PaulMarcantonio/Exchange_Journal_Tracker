<#
Project Title => Exchange Message Tracking Report
Programmer:
     Paul Marcantonio 781-727-4262
Date:
     October 2 2020
Version:
     1.5
Objective:
     - Collect all message activity between start and end dates (in this case past 24 hours)
     - Provide summary breakdowns based on each type of EventID
     - Build HTML file of EventID data breakdowns
     - Send Email Summary table of key EventID totals
Pre-Condition(s):
     - Powershell Execution Policy set to Remove Signed (Get-ExecutionPolicy, Set-ExecutionPolicy RemoteSigned)
     - Exchange Management Shell installed on the scripting server (Using the Exchange ISO and choose management console only)
     - User this script executes under should have Exchange Enterprise rights (https://docs.microsoft.com/en-us/powershell/exchange/find-exchange-cmdlet-permissions?view=exchange-ps)
     - Folder structure and right to reading and writing HTML file to
     - The server this script runs on must be on the "allow relay" on any and all load balancers infront of exchange and within exchange
Post-Condition(s):
     - New HTML file with message EventID created on target server
     - Email sent to the desired email list with:
          * HTML summary table
          * Link to HTML file created
          * Copy of the HTML file
Installation:
     - Make sure Powershell version 3 or above is installed on the server (Server Role and Features (Windows Powershell)
     - Install Exchange 2016 Management tools https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019
     - Copy the script to designated location for execution
Contributing:
     - https://docs.microsoft.com/en-us/exchange/mail-flow/transport-logs/message-tracking?view=exchserver-2019
     - https://docs.microsoft.com/en-us/Exchange/plan-and-deploy/post-installation-tasks/install-management-tools?view=exchserver-2019
Citations:
     None
Contact:
     Paul Marcantonio
          Email => paulmarcantonio@yahoo.com
          Phone => 781-727-4262
#>
 
<#
.SYNOPSIS => Initalize Exchange DLL for use to connect to Exchange Server Farm
.PARAMETER
     None Needed
.INPUTS
     $env:ExchangeInstallPath\bin\RemoteExchange.ps1
.OUTPUTS
    Console writeline when there is an issue accessing RemoteExchange.ps1
#>
FUNCTION INITIALIZE ()
{
     if (Test-Path $env:ExchangeInstallPath\bin\RemoteExchange.ps1)
    {
         . $env:ExchangeInstallPath\bin\RemoteExchange.ps1
         Connect-ExchangeServer -auto -AllowClobber
    }
    else
    {
        Write-Warning "Exchange Server management tools are not installed on this computer."
    }
}
 
<#
.SYNOPSIS => Build HTML Header for HTML.
 
    .DESCRIPTION
        Provide standard w3.org header, CSS layout and top level DIV with Company Information
    .PARAMETER $runtime
        A time stamp in format that shows when this script was executed
    .PARAMETER $duration
        Amount of time this script ran for
    .OUTPUTS
        Global Object is updated with this information to be used to write to the HTML file and email body.
#>
FUNCTION BUILD_HTML_HEADER ($runtime,$duration)
{
     $global:htmlHeader += '<!DOCTYPE html>'+"`n"
     $global:htmlHeader += '<html xmlns="http://www.w3.org/1999/xhtml">'+"`n"
     $global:htmlHeader += '<head>'+"`n"
     $global:htmlHeader += '<title>Exchange DB Summary Report</title>'+"`n"
     $global:htmlHeader += '<script src="./Scripts/sorttable.js"></script>'
     $global:htmlHeader += '</head>'+"`n"
     $global:htmlHeader += '<style>
              div.container {width: 95%; border: 1px solid gray; margin: auto;}
              div.header {background-color:#b5dcb3;}
              div.leftSection {background-color:#ffffff; height:auto;width:22%;float:left;}
              div.mainHeaderSection {background-color:#D4DFDA; height:auto; width:76%; float:right;}
              div.mainSection {background-color:#D4DFDA; height:auto; width:73%; display: block; margin-left: auto; margin-right: auto;  overflow: scroll;}
              div.footer {background-color:#b5dcb3; height:auto; width:100%;}
              header, footer {padding: 1em; clear: left;text-align: center;}
              nav {float: left;max-width: 160px;margin: 0;padding: 1em;}
              nav ul {list-style-type: none;padding: 0;}
              nav ul a {text-decoration: none;}
              article {margin-left: 170px; border-left: 1px solid gray;padding: 1em;overflow: hidden;}
              th.noPing {background-color: #AD2A1A; font-weight: #ffffff;}
              th.subTotals {background-color: #43ABC9; font-weight: #ffffff;}
              th.summary {background-color: #107896; font-weight: #ffffff;}
              td.numTotal {font-weight: bold; text-align: left; padding-right: 25px;}
              td.numSubTotal {padding-left: 15px; text-align: right}
              td.perfectage {padding-left: 5px; text-align: right}
              caption {font-weight: bold;}
              h3 {text-align: center;}</style>'
     $global:htmlHeader += '<body>'+"`n"
     $global:htmlHeader += '<div class="container">
          <div class="header">
          <header><H1 align="center">Information Technology Exchange Database and Journaling Report</H1><H2 align="center">Report Ran on '+$env:COMPUTERNAME+' @ '+$runtime+' and ran for '+$duration+' (minutes)</H2>'+"`n"
     $global:htmlHeader += '<p align="center">The full Report can be found here <a href="file:///'+$global:htmlFile+'">Exchange Database and Journaling Report</a></p></header>'
     $global:htmlHeader += '</TABLE>'
     $global:htmlHeader += '</header></div>'
}   
 
<#
.SYNOPSIS => Send Email to Target Group of Recipients
 
    .DESCRIPTION
    Send Email with
          HTML Summary Table
          Copy of HTML File
          Link to source location of the HTML File
     .INPUTS
        $timeStamp => Grab current time system.
          $smtpServer => SMTP URL for authentication
          $emailToSuccess => Array of smtp addresses to send email to
          $global:bodyTextSuccess => object used to insert data into email message body
          $global:htmlHeader => global header of in HTML data used to populate Email body
          $global:htmlLeftSection => global left summary detail providing main HTML table used for Email body
#>
FUNCTION SENDEMAIL ()
{
     # --- Set Email Variables ---
     # Email Server
     $timeStamp = Get-Date
     $smtpServer = "owa.company.org"                                                              #Email server used to process email
     $smtp = New-Object Net.Mail.SmtpClient($smtpServer)                                     #
 
     # Email Addresses
     $emailFrom = "Exchange_DB_Journal_Report_"+$env:COMPUTERNAME+"@company.org"                  #from email address shown in the email
     $emailToSuccess = @("InformationTechnology@company.org","InformationSecurity@company.org")
     $subjectTextSuccess = "Daily Exchange DB Summary Report Script completed on server "+$env:COMPUTERNAME+" at $timeStamp"    #subject text for success messages
     $global:bodyTextSuccess += $global:htmlHeader
     $global:bodyTextSuccess += $global:htmlLeftSection
     $global:bodyTextSuccess += '</div></body></HTML>'
     foreach ($rcp in $emailToSuccess)
     {
          Send-MailMessage -from "$emailFrom" -to "$rcp" -subject "$subjectTextSuccess" -body "$global:bodyTextSuccess" -BodyAsHtml -smtpServer "$smtpServer"
          #Send-MailMessage -from "$emailFrom" -to "$rcp" -subject "$subjectTextSuccess" -body "$global:bodyTextSuccess" -BodyAsHtml -smtpServer "$smtpServer"
     }
}
 
<#
.SYNOPSIS => Obtain details of EventID that is passed to it
 
    .DESCRIPTION
    An object is passed into this function and based on the switch statement returns the meaning of the Event ID
 
    .PARAMETER $source
        The EventID only that we want a description for.
 
    .INPUTS
        Description of objects that can be piped to the script.
 
    .OUTPUTS
        Description of EventID that is used in the HTML file to describe what it means
#>
FUNCTION GET_SOURCE_DEFINITIONS ($source)
{
     SWITCH ($source) {
          "AGENTINFO"    {$results = "This event is used by transport agents to log custom data."; break}
          "BADMAIL" {$results = "A message submitted by the Pickup directory or the Replay directory that can't be delivered or returned."; break}
          "CLIENTSUBMISSION"  {$results = "A message was submitted from the Outbox of a mailbox."; break}
          "DEFER"   {$results = "Message delivery was delayed."; break}
          "DELIVER" {$results = "A message was delivered to a local mailbox."; break}
          "DELIVERFAIL"  {$results = "An agent tried to deliver the message to a folder that doesn't exist in the mailbox."; break}
          "DROP"    {$results = "A message was dropped without a delivery status notification (also known as a DSN, bounce message, non-delivery report, or NDR). For example:
                                  • Completed moderation approval request messages. • Spam messages that were silently dropped without an NDR."; break}
          "DSN"     {$results = "A delivery status notification (DSN) was generated."; break}
          "DUPLICATEDELIVER"  {$results = "A duplicate message was delivered to the recipient. Duplication may occur if a recipient is a member of multiple nested distribution groups. Duplicate messages are detected and removed by the information store."; break}
          "DUPLICATEEXPAND"   {$results = "During the expansion of the distribution group, a duplicate recipient was detected."; break}
          "DUPLICATEREDIRECT" {$results = "An alternate recipient for the message was already a recipient."; break}
          "EXPAND"  {$results = "A distribution group was expanded."; break}
          "FAIL"    {$results = "Message delivery failed. Sources include SMTP, DNS, QUEUE, and ROUTING."; break}
          "HADISCARD"    {$results = "A shadow message was discarded after the primary copy was delivered to the next hop."; break}
          "HARECEIVE"    {$results = "A shadow message was received by the server in the local database availability group (DAG) or Active Directory site."; break}
          "HAREDIRECT"   {$results = "A shadow message was created."; break}
          "HAREDIRECTFAIL"    {$results = "A shadow message failed to be created. The details are stored in the source-context field."; break}
          "INITMESSAGECREATED"     {$results = "A message was sent to a moderated recipient, so the message was sent to the arbitration mailbox for approval."; break}
          "LOAD"    {$results = "A message was successfully loaded at boot."; break}
          "MODERATIONEXPIRE"  {$results = "A moderator for a moderated recipient never approved or rejected the message, so the message expired."; break}
          "MODERATORAPPROVE"  {$results = "A moderator for a moderated recipient approved the message, so the message was delivered to the moderated recipient."; break}
          "MODERATORREJECT"   {$results = "A moderator for a moderated recipient rejected the message, so the message wasn't delivered to the moderated recipient."; break}
          "MODERATORSALLNDR"  {$results = "All approval requests sent to all moderators of a moderated recipient were undeliverable, and resulted in non-delivery reports (also known as NDRs or bounce messages)."; break}
          "NOTIFYMAPI"   {$results = "A message was detected in the Outbox of a mailbox on the local server."; break}
          "NOTIFYSHADOW" {$results = "A message was detected in the Outbox of a mailbox on the local server, and a shadow copy of the message needs to be created."; break}
          "POISONMESSAGE"     {$results = "A message was put in the poison message queue or removed from the poison message queue."; break}
          "PROCESS" {$results = "The message was successfully processed."; break}
          "PROCESSMEETINGMESSAGE"  {$results = "A meeting message was processed by the Mailbox Transport Delivery service."; break}
          "RECEIVE" {$results = "A message was received by the SMTP receive component of the transport service or from the Pickup or Replay directories (source: SMTP), or a message was submitted from a mailbox to the Mailbox Transport Submission service (source: STOREDRIVER)."; break}
          "REDIRECT"     {$results = "A message was redirected to an alternative recipient after an Active Directory lookup."; break}
          "RESOLVE" {$results = "A message's recipients were resolved to a different email address after an Active Directory lookup."; break}
          "RESUBMIT"     {$results = "A message was automatically resubmitted from Safety Net."; break}
          "RESUBMITDEFER"     {$results = "A message resubmitted from Safety Net was deferred."; break}
          "RESUBMITFAIL" {$results = "A message resubmitted from Safety Net failed."; break}
          "SEND"    {$results = "A message was sent by SMTP between transport services."; break}
          "SENDEXTERNAL" {$results = "NOT OFFICAL but I think is means Message was sent by SMTP sent Externally."; break}
          "SUBMIT"  {$results = "The Mailbox Transport Submission service successfully transmitted the message to the Transport service. For SUBMIT events, the source-context property contains the following details:
                                           MDB: The mailbox database GUID.
                                           Mailbox: The mailbox GUID.
                                           Event: The event sequence number.
                                           MessageClass: The type of message. For example, IPM.Note.
                                           CreationTime: Date-time of the message submission.
                                           ClientType: For example, User, OWA, or ActiveSync."; break}
          "SUBMITDEFER"  {$results = "The message transmission from the Mailbox Transport Submission service to the Transport service was deferred. "; break}
          "SUBMITFAIL"   {$results = "The message transmission from the Mailbox Transport Submission service to the Transport service failed."; break}
          "SUPPRESSED"   {$results = "The message transmission was suppressed."; break}
          "THROTTLE"     {$results = "The message was throttled."; break}
          "TRANSFER"     {$results = "Recipients were moved to a forked message because of content conversion, message recipient limits, or agents. Sources include ROUTING or QUEUE."; break}
          default   {$results = "No definition for this source"; break}
     }
     RETURN $results
}
 
<#
.SYNOPSIS => Main trigger of script
 
.DESCRIPTION
     - GLOBAL VARIABLES
     - LOCAL VARIABLES
     - INTIALIZE EXCHANGE SHELL TO BE ABLE TO RUN EXCHANGE SHELL FUNCTIONS
     - GET TRANSPORT SERVERS AND MESSAGE TRACKING LOG FROM EXCHANGE
     - ASSEMBLE GROUP TOTALS FOR PRESENTATION
     - DETERMINE IF EMAIL TOTAL ARE BALANCED (YES if total emails = Journaled + MimeCast + OtherEmails   otherwise NO)
     - BUILD LEFT SUMMARY SECTION OF THE HTML FILE
     - BUILD EVENTID DETAILS HTML TABLE OBJECT IN THE MAIN FILE BODY
     - BUILD_HTML_HEADER STANDARD HEADER VIA W3.ORG STANDARDS
     - CLOSE OUT THE HTML LEFTSECTION OBJECT
     - BUILD HTML FILE
     - SEND EMAIL TO ARRAY OF EMAIL ADDRESSES
#>
FUNCTION MAIN ()
{
     #GLOBAL VARIABLES
          $global:htmlHeader = @()
          $global:htmlLeftSection = @()
          $global:eventIDDetails = @()
          $global:htmlFile = "\\"+$env:COMPUTERNAME+"\Web Pages\Exchange\Journaling\Database-Journaling-Report_$timeStamp.html"
    
     #LOCAL VARIABLES
          $timeStamp = Get-Date -UFormat "%Y-%m-%d %H-%M-%S"
          $runtimeDate = Get-Date
          $startDate = (Get-date).Adddays(-1).Date
          $EndDate = $startDate.AddDays(0.9993)
    
     #INTIALIZE EXCHANGE SHELL
          INITIALIZE
    
     #GET TRANSPORT SERVERS AND MESSAGE TRACKING LOG
          $a = Get-TransportServer | Get-MessageTrackingLog -ResultSize unlimited -start $startDate -End $EndDate
    
     #ASSEMBLE GROUP TOTALS
          $eventIDTotals = $a.EventId | Sort-Object EventId | Group-Object
          $totalJournalingEmails = ($a | Where-Object {$_.Recipients -like "Journaling@journal.company.org"}).Count
          $totalMimeCastJournalEmails = ($a | Where-Object {$_.Recipients -like "MimeCastJournal@company.org"}).Count
          $totalOtherEmails = $a.count - ($totalJournalingEmails + $totalMimeCastJournalEmails)
          #$totalSentFromCompanySouces = ($a | Where-Object {$_.Sender -like "*@company.org"}).Count
          $totalSentFromCompanySouces = ($a | Where-Object {($_.Sender -like "*@company.org") -and ($_.Sender -like "MicrosoftExchange*@company.org")}).Count
          $totalSentFromExchangeSystem = ($a | Where-Object {$_.Sender -like "MicrosoftExchange*@company.org"}).Count
          $totalSentFromExternalSources = ($a | Where-Object {$_.Sender -Notlike "*@company.org"}).Count
    
     #DETERMINE IF BALANCED (YES if total emails = Journaled + MimeCast + OtherEmails   otherwise NO)
          $balanced = ""
              if (($a.count - ($totalJournalingEmails + $totalMimeCastJournalEmails + $totalOtherEmails)) -eq 0){$balanced = "Yes"} Else {$balanced = "No"}
    
     #BUILD LEFT SUMMARY SECTION
          $global:htmlLeftSection += '<div class="leftSection">'+"`n"
          #$global:htmlLeftSection += '<table class="sortable" align="center" frame="box">'+"`n"
          $global:htmlLeftSection += '</br><table class="sortable" align="center" frame="box">'+"`n"
          $global:htmlLeftSection += '<caption>Message Tracking Email Summary</caption>'+"`n"
          $global:htmlLeftSection += '<th class="subTotals">Item</th><th class="subTotals" colspan="2">Value</th>'+"`n"
          $global:htmlLeftSection += '<tr><td>Data Capture Start:</td><td colspan="2">'+$startDate+ '</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td>Data Capture End:</td><td colspan="2">'+$EndDate + '</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td>Data Capture Span (Hours):</td>'
          $global:htmlLeftSection += '<td colspan="2" align="center">'+[Math]::Round((($EndDate.Ticks - $startDate.Ticks)/10000000)/3600,2) + '</td></tr>'+"`n"
 
          $global:htmlLeftSection += '<tr><td>Total Emails Captured:</td>'
          $global:htmlLeftSection += '<td class="numTotal" colspan="2" align="center">'+'{0:N0}' -f ($a.count)+'</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Send from human defined entities in Exchange (I.E. AD User, DL, Contact Emails etc...)">Total Sent from internal (company.org) Emails:</td>'
          $global:htmlLeftSection += '<td class="numSubTotal">'+'{0:N0}' -f ($totalSentFromCompanySouces)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalSentFromCompanySouces)/($a.count))*100,2)+'&#37</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Send from interal Exchange System (I.E. triggered by Exchange (routing, Journalling etc...)">Total Sent from internal Exchange System:</td>'
          $global:htmlLeftSection += '<td class="numSubTotal">'+'{0:N0}' -f ($totalSentFromExchangeSystem)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalSentFromExchangeSystem)/($a.count))*100,2)+'&#37</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Send from EXTERNAL DNS MX Record sources (I.E. gmail.com, comcast.net, etc...):">Total Sent from external Emails:</td>'
          $global:htmlLeftSection += '<td class="numSubTotal">'+'{0:N0}' -f ($totalSentFromExternalSources)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalSentFromExternalSources)/($a.count))*100,2)+"&#37"+'</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Emails Sent with Journaling@Journal.company.org in recipients list">Total To Journaling@journal.company.org:</td>'
          $global:htmlLeftSection += '<td class="numTotal">'+'{0:N0}' -f ($totalJournalingEmails)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalJournalingEmails)/($a.count))*100,2)+"&#37"+'</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Emails Sent with MimecastJournal.company.org in recipients list">Total To MimeCastJournal@company.org:</td>'
          $global:htmlLeftSection += '<td class="numTotal">'+'{0:N0}' -f ($totalMimeCastJournalEmails)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalMimeCastJournalEmails)/($a.count))*100,2)+"&#37"+'</td></tr>'+"`n"
          $global:htmlLeftSection += '<tr><td title="Emails Sent without Journaling@Journal.company.org and MimecastJournal.company.org in recipients list">Total To Other Emails:</td>'
          $global:htmlLeftSection += '<td class="numTotal">'+'{0:N0}' -f ($totalOtherEmails)+'</td>'
          $global:htmlLeftSection += '<td class="percentage">&nbsp;&nbsp;'+[Math]::Round((($totalOtherEmails)/($a.count))*100,2)+"&#37"+'</td></tr>'+"`n"
 
          $global:htmlLeftSection += '<tr><td title="Difference of ((Total Emails Captured) - ((Total To Journaling@journal.company.org) + (Total To MimeCastJournal@.company.org) + (Total Other Emails)) was 0">Email Balanced:</td>'
          $global:htmlLeftSection += '<td colspan="2" align="center">'+$balanced+'</td></tr>'+"`n"
    
     #BUILD EVENTID DETAILS HTML TABLE OBJECT
          $global:eventIDDetails += '<div class="mainSection">'+"`n"
          $global:eventIDDetails += '<Table class="sortable" width="100%" frame="box">'+"`n"
          #$summary += '<caption><b>Aggragate Totals&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>Journaling@Journal.company.org</u> ('+ $totalJournalingEmails+ ')</b>&nbsp;&nbsp;&nbsp;<b>MimeCastJournal@company.org ('+$totalMimeCastJournalEmails+ ')&nbsp;&nbsp;&nbsp;Other Emails ('+$totalOtherEmails+ ')</b></caption>'
          $global:eventIDDetails += '<caption><h4>Message Tracking Email Totals Grouped by EventID</h4></caption>'+"`n"
          $global:eventIDDetails += '<tr><th class="summary">EventID</th><th class="summary">Total</th><th class="summary">Journaling@Journal.Metocu.org</th><th class="summary">MimeCastJournal@company.org</th><th class="summary">Other Emails</th></tr>'+"`n"
          #$global:eventIDDetails += '<tr><th class="summary">EventID</th><th class="summary">Total</th><th class="summary">Description</th><th class="summary">Journaling@Journal.Metocu.org</th><th class="summary">MimeCastJournal@company.org</th><th class="summary">Other Emails</th></tr>'
          FOREACH ($eID in $eventIDTotals.Name)
          {
              $definition = GET_SOURCE_DEFINITIONS $eID.ToString()
              $subArray = $a |Where-Object {$_.EventId -like $eID.ToString()}
              $senderSubTotals = $subArray | sort-object Sender | Group-object Sender
              $JournalingTotalEmails = ($subArray | Where-Object {$_.Recipients -like "Journaling@journal.company.org"}).Count
              $mimeCastTotalEmails = ($subArray | Where-Object {$_.Recipients -like "MimeCastJournal@company.org"}).Count
              $nonJournaledTotalEmails = ($subArray | Where-Object {($_.Recipients -notlike "MimeCastJournal@company.org") -and ($_.Recipients -notlike "Journaling@journal.company.org")}).Count
              $element = '<tr><td title="'+$definition+'">'+$eID +'</td><td>'+$subArray.count+'</td><td>'+$JournalingTotalEmails +'</td><td>'+$mimeCastTotalEmails +'</td><td>'+$nonJournaledTotalEmails+'</td></tr>'+"`n"
              $global:eventIDDetails += $element
          }
          $global:eventIDDetails += '</TABLE>'+"`n"
         
          #Obtain report elapse time in minutes and build HTML HEADER
              $reportduration = (New-TimeSpan -Start $runtimeDate -End (Get-Date)).Minutes
              BUILD_HTML_HEADER $runtimeDate $reportduration
     #CLOSE OUT THE HTML LEFTSECTION OBJECT
          $global:htmlLeftSection += '<tr><td>Report Elapse Runtime (Minutes):</td><td colspan="2" align="center">'+(New-TimeSpan -Start $runtimeDate -End (Get-Date)).Minutes + '</td></tr>'+"`n"
          $global:htmlLeftSection += '</table>'+"`n"
          $global:htmlLeftSection += '</div>'+"`n"
     #BUILD HTML FILE
          Add-Content $global:htmlFile $global:htmlHeader
          Add-Content $global:htmlFile $global:htmlLeftSection
          Add-Content $global:htmlFile $global:eventIDDetails
          Add-Content $global:htmlFile '</div></body></HTML>'
     #SEND EMAIL
          SENDEMAIL
}
MAIN