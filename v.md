<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<title>Exchange DB Summary Report</title>

<script src="./Scripts/sorttable.js"></script>
</head>

<style>
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
			h3 {text-align: center;}</style>
<body>

<div class="container">
		<div class="header">
		<header><H1 align="center">Information Technology Exchange Database and Journaling Report</H1><H2 align="center">Report Ran on ScriptServerName @ 12/10/2020 06:30:01 and ran for 13 (minutes)</H2>

<p align="center">The full Report can be found here <a href="file:///\\ScriptServerName\Web Pages\Exchange\Journaling\Exchange-Journaling-Report_2020-12-10 06-30-01.html">Exchange Database and Journaling Report</a></p></header>
</TABLE>
</header></div>
<div class="leftSection">

</br><table class="sortable" align="center" frame="box">

<caption>Message Tracking Email Summary</caption>

<th class="subTotals">Item</th><th class="subTotals" colspan="2">Value</th>

<tr><td>Data Capture Start:</td><td colspan="2">12/09/2020 00:00:00</td></tr>

<tr><td>Data Capture End:</td><td colspan="2">12/09/2020 23:58:59</td></tr>

<tr><td>Data Capture Span (Hours):</td>
<td colspan="2" align="center">23.98</td></tr>

<tr><td>Total Emails Captured:</td>
<td class="numTotal" colspan="2" align="center">355,694</td></tr>

<tr><td title="Send from human defined entities in Exchange (I.E. AD User, DL, Contact Emails etc...)">Total Sent from internal (Company.org) Emails:</td>
<td class="numSubTotal">151,712</td>
<td class="percentage">&nbsp;&nbsp;42.65&#37</td></tr>

<tr><td title="Send from interal Exchange System (I.E. triggered by Exchange (routing, Journalling etc...)">Total Sent from internal Exchange System:</td>
<td class="numSubTotal">151,712</td>
<td class="percentage">&nbsp;&nbsp;42.65&#37</td></tr>

<tr><td title="Send from EXTERNAL DNS MX Record sources (I.E. gmail.com, comcast.net, etc...):">Total Sent from external Emails:</td>
<td class="numSubTotal">67,477</td>
<td class="percentage">&nbsp;&nbsp;18.97&#37</td></tr>

<tr><td title="Emails Sent with Journaling@Journal.Company.org in recipients list">Total To Journaling@journal.Company.org:</td>
<td class="numTotal">101,962</td>
<td class="percentage">&nbsp;&nbsp;28.67&#37</td></tr>

<tr><td title="Emails Sent with MimecastJournal.Company.org in recipients list">Total To MimeCastJournal@Company.org:</td>
<td class="numTotal">70,650</td>
<td class="percentage">&nbsp;&nbsp;19.86&#37</td></tr>

<tr><td title="Emails Sent without Journaling@Journal.Company.org and MimecastJournal.Company.org in recipients list">Total To Other Emails:</td>
<td class="numTotal">183,082</td>
<td class="percentage">&nbsp;&nbsp;51.47&#37</td></tr>

<tr><td title="Difference of ((Total Emails Captured) - ((Total To Journaling@journal.Company.org) + (Total To MimeCastJournal@.Company.org) + (Total Other Emails)) was 0">Email Balanced:</td>
<td colspan="2" align="center">Yes</td></tr>

<tr><td>Report Elapse Runtime (Minutes):</td><td colspan="2" align="center">13</td></tr>

</table>

</div>

<div class="mainSection">

<Table class="sortable" width="100%" frame="box">

<caption><h4>Message Tracking Email Totals Grouped by EventID</h4></caption>

<tr><th class="summary">EventID</th><th class="summary">Total</th><th class="summary">Journaling@Journal.Company.org</th><th class="summary">MimeCastJournal@Company.org</th><th class="summary">Other Emails</th></tr>

<tr><td title="A message was sent by SMTP between transport services.">SEND</td><td>28449</td><td>0</td><td>0</td><td>28449</td></tr>

<tr><td title="A shadow message was created.">HAREDIRECT</td><td>23140</td><td>0</td><td>0</td><td>23140</td></tr>

<tr><td title="A message was dropped without a delivery status notification (also known as a DSN, bounce message, non-delivery report, or NDR). For example: 
							• Completed moderation approval request messages. • Spam messages that were silently dropped without an NDR.">DROP</td><td>24863</td><td>0</td><td>23550</td><td>1313</td></tr>

<tr><td title="This event is used by transport agents to log custom data.">AGENTINFO</td><td>47976</td><td>23550</td><td>23550</td><td>47975</td></tr>

<tr><td title="Recipients were moved to a forked message because of content conversion, message recipient limits, or agents. Sources include ROUTING or QUEUE.">TRANSFER</td><td>34427</td><td>31300</td><td>0</td><td>3127</td></tr>

<tr><td title="NOT OFFICAL but I think is means Message was sent by SMTP sent Externally.">SENDEXTERNAL</td><td>25504</td><td>23550</td><td>0</td><td>1954</td></tr>

<tr><td title="A distribution group was expanded.">EXPAND</td><td>25103</td><td>23550</td><td>0</td><td>1551</td></tr>

<tr><td title="A message was received by the SMTP receive component of the transport service or from the Pickup or Replay directories (source: SMTP), or a message was submitted from a mailbox to the Mailbox Transport Submission service (source: STOREDRIVER).">RECEIVE</td><td>54356</td><td>0</td><td>23550</td><td>30805</td></tr>

<tr><td title="A shadow message was discarded after the primary copy was delivered to the next hop.">HADISCARD</td><td>23140</td><td>0</td><td>0</td><td>23140</td></tr>

<tr><td title="A shadow message was received by the server in the local database availability group (DAG) or Active Directory site.">HARECEIVE</td><td>23140</td><td>0</td><td>0</td><td>23140</td></tr>

<tr><td title="Message delivery failed. Sources include SMTP, DNS, QUEUE, and ROUTING.">FAIL</td><td>909</td><td>0</td><td>0</td><td>906</td></tr>

<tr><td title="A delivery status notification (DSN) was generated.">DSN</td><td>852</td><td>0</td><td>0</td><td>852</td></tr>

<tr><td title="A message submitted by the Pickup directory or the Replay directory that can't be delivered or returned.">BADMAIL</td><td>60</td><td>0</td><td>0</td><td>60</td></tr>

<tr><td title="Message delivery was delayed.">DEFER</td><td>13</td><td>12</td><td>0</td><td>1</td></tr>

<tr><td title="A message was automatically resubmitted from Safety Net.">RESUBMIT</td><td>6</td><td>0</td><td>0</td><td>6</td></tr>

<tr><td title="A message was delivered to a local mailbox.">DELIVER</td><td>28333</td><td>0</td><td>0</td><td>28333</td></tr>

<tr><td title="A meeting message was processed by the Mailbox Transport Delivery service.">PROCESSMEETINGMESSAGE</td><td>904</td><td>0</td><td>0</td><td>0</td></tr>

<tr><td title="An agent tried to deliver the message to a folder that doesn't exist in the mailbox.">DELIVERFAIL</td><td>114</td><td>0</td><td>0</td><td>114</td></tr>

<tr><td title="A duplicate message was delivered to the recipient. Duplication may occur if a recipient is a member of multiple nested distribution groups. Duplicate messages are detected and removed by the information store.">DUPLICATEDELIVER</td><td>242</td><td>0</td><td>0</td><td>242</td></tr>

<tr><td title="The Mailbox Transport Submission service successfully transmitted the message to the Transport service. For SUBMIT events, the source-context property contains the following details: 
									MDB: The mailbox database GUID. 
									Mailbox: The mailbox GUID. 
									Event: The event sequence number. 
									MessageClass: The type of message. For example, IPM.Note. 
									CreationTime: Date-time of the message submission. 
									ClientType: For example, User, OWA, or ActiveSync.">SUBMIT</td><td>7056</td><td>0</td><td>0</td><td>7056</td></tr>

<tr><td title="A message was detected in the Outbox of a mailbox on the local server.">NOTIFYMAPI</td><td>7062</td><td>0</td><td>0</td><td>0</td></tr>

<tr><td title="A message was redirected to an alternative recipient after an Active Directory lookup.">REDIRECT</td><td>6</td><td>0</td><td>0</td><td>6</td></tr>

<tr><td title="A message's recipients were resolved to a different email address after an Active Directory lookup.">RESOLVE</td><td>11</td><td>0</td><td>0</td><td>11</td></tr>

<tr><td title="The message was throttled.">THROTTLE</td><td>4</td><td>0</td><td>0</td><td>0</td></tr>

<tr><td title="The message transmission from the Mailbox Transport Submission service to the Transport service failed.">SUBMITFAIL</td><td>2</td><td>0</td><td>0</td><td>0</td></tr>

<tr><td title="During the expansion of the distribution group, a duplicate recipient was detected.">DUPLICATEEXPAND</td><td>22</td><td>0</td><td>0</td><td>22</td></tr>

</TABLE>

</div></body></HTML>
