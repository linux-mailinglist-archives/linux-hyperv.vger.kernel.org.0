Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA914995E
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgAZFua (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:50:30 -0500
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:58464
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgAZFua (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:50:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRz5VD1nzPOBcEQoCZTbEaCNEOxveVgHgwL+JYs3rZ6UnPziceg6LmsJ0oBOTcrAhbE7CAQPTB8Hdo3i5VzTMV3m9mHFNZbHnbHwklNl9j0v/OmBmTilcNpi/1RXSz2lITIMqnFXmpREfWMQ1PxpLeuLHRCXVIgTPh4RBXEClfUxvyau+rO4nzkd37epzjIONUQDlz9cbzS6tRlVwbEM6Ef4GshwXpBBI9RXpxpQUMaRDtc6nxusH63mk4x2IWnua4VvQIuTR5SdAIYLl/RfoRgzr/jSreGf6veoMDILawGVeRjWDLXkVuMNk7NxNWsZK7L3MhLhBu2svEOC3XB6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUuoyj3eZOlEIPwNFMvGg+zH9DO4xBLxYGWn6zPpAqk=;
 b=ljuCv3gghzT1BRDfPpt758J3a1gLMPiKQV6tKB6AKsw5i9LozsBG65L5n9dr9DaaH+uWUZv50X3WqF++s/Bu2gI2n/fiDBtqWeyAiFjw6eIzAIhIG42ZgI7lc7VF7PWAU6bFh8tc+0vg0Iro9MDpkc+ekYVIYKJvfZfiwdN9i5t78dZSAYn5cTu9tGqEoz8WWuKZYahV5p+CL3+zVxmVP4IvZNBtApbI4W2WyzHf7sJuJi9vyOzLmw44laVDjuyO57i4BU7bv3OpIgtKPj1RfARdvUeqOisuBGY+rS5fC/PzbQGOL4FiUk+BGfEFUwZdqfQC3Ciqp+3CgotW29OCaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUuoyj3eZOlEIPwNFMvGg+zH9DO4xBLxYGWn6zPpAqk=;
 b=bQfmkfQP+RvDy3+GyIw88aG+EphKgoXtVoErMsEL8RXlVVXMKySwz3ohtqJOyKp+nM6oadCfCvNirTWUkUyf2dgDflR+uPKA4Wmf4Xn4Lz2lpSCn4SaXVxzb3jOqLZvxWMh/7sOQ8xn0PxmHJ3xWYitI39FEcKQ4iLdh3uC+wi4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1203.namprd21.prod.outlook.com (20.179.73.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Sun, 26 Jan 2020 05:50:26 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.019; Sun, 26 Jan 2020
 05:50:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 2/4] hv_utils: Support host-initiated restart request
Date:   Sat, 25 Jan 2020 21:49:42 -0800
Message-Id: <1580017784-103557-3-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580017784-103557-1-git-send-email-decui@microsoft.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:300:12b::14) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Sun, 26 Jan 2020 05:50:24 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 842a4002-3163-4f42-9ab1-08d7a223a421
X-MS-TrafficTypeDiagnostic: BN8PR21MB1203:|BN8PR21MB1203:|BN8PR21MB1203:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1203D0F2C2D5C12C78923AC5BF080@BN8PR21MB1203.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02945962BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(316002)(2906002)(66556008)(6512007)(66946007)(66476007)(86362001)(107886003)(3450700001)(6486002)(36756003)(8936002)(26005)(5660300002)(4326008)(2616005)(956004)(478600001)(186003)(52116002)(6506007)(6666004)(16526019)(81166006)(81156014)(8676002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1203;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTgHi/D/ZUixLlqGcUbGMxqImO6T6E1fZl4ZLlqBCnQYObI+Aj71v1pjFgekL1U/oxA1501ZhzYKX/oiNGIBHzXXxymGurtPy7ItM5tZchjRSsmSfU43FqslPne2J7y2MpkE42cmT1/RFJqZloi6xOM9oNlgHAgU6Pt2l/GKSPOAfieeLgB3xe6AjTHQyFTWQfAX5KMwBXlm8A90khubTqxYrpLtyy1YtXffaasZfNvg3It2QH+2Un3uykgL5v25qY7OrSXC9tVeIDaE4zoZxOiNwV5/UFLz0xxX0KPn/j78J7JY288GR8UydB+4F+ldq059zci6jvRFq/Tz1P7CzBEHkCxXJ/YfG5s2JfZ/QyijR06MP+V2sdNokkVDc18tzS8epBry0++35YCATamstDsZ9H0wE7zUb7rV/MMTmtUEG/SVwKydEoB1bV27RYvR
X-MS-Exchange-AntiSpam-MessageData: r7ajW52JHJV0rXa4NZMY4y5ipJUUBBzlFgCHgDI4wYk75+LMzHzHVRSRWp8oCtpgsEQz46eTa05KSbM/IqFtOFfxGU68i3foWUHare2sixcqzzVuIqlVPyFzOzRhehhxLzRvLdTG90FCGzLi6Ef2mw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842a4002-3163-4f42-9ab1-08d7a223a421
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2020 05:50:26.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgtgqOcS0DkVCwzkxMoltTLEX0tcl+8RFd5HDEonFyEuLDuA96YEgycBDTF2tQiG6Ch9Uw66WY+zsAsxvZc95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The hv_utils driver currently supports a "shutdown" operation initiated
from the Hyper-V host. Newer versions of Hyper-V also support a "restart"
operation. So add support for the updated protocol version that has
"restart" support, and perform a clean reboot when such a message is
received from Hyper-V.

To test the restart functionality, run this PowerShell command on the
Hyper-V host:

Restart-VM  <vmname>  -Type Reboot

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
Changes in v2:
   It's the same as v1.

Changes in v3 (I addressed Michael's comments):
    Used a better version of changelog from  Michael.
    Added a comment about the meaning of shutdown_msg->flags.
    Call schedule_work() at the end of the function for consistency.

Changes in v4 (Thanks to Michael!):
    Used a compact way to handle the work items.

 drivers/hv/hv_util.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd8457346..32d96af67522 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -24,6 +24,8 @@
 
 #define SD_MAJOR	3
 #define SD_MINOR	0
+#define SD_MINOR_1	1
+#define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
 
 #define SD_MAJOR_1	1
@@ -50,8 +52,9 @@ static int sd_srv_version;
 static int ts_srv_version;
 static int hb_srv_version;
 
-#define SD_VER_COUNT 2
+#define SD_VER_COUNT 3
 static const int sd_versions[] = {
+	SD_VERSION_3_1,
 	SD_VERSION,
 	SD_VERSION_1
 };
@@ -118,17 +121,27 @@ static void perform_shutdown(struct work_struct *dummy)
 	orderly_poweroff(true);
 }
 
+static void perform_restart(struct work_struct *dummy)
+{
+	orderly_reboot();
+}
+
 /*
  * Perform the shutdown operation in a thread context.
  */
 static DECLARE_WORK(shutdown_work, perform_shutdown);
 
+/*
+ * Perform the restart operation in a thread context.
+ */
+static DECLARE_WORK(restart_work, perform_restart);
+
 static void shutdown_onchannelcallback(void *context)
 {
 	struct vmbus_channel *channel = context;
+	struct work_struct *work = NULL;
 	u32 recvlen;
 	u64 requestid;
-	bool execute_shutdown = false;
 	u8  *shut_txf_buf = util_shutdown.recv_buffer;
 
 	struct shutdown_msg_data *shutdown_msg;
@@ -157,19 +170,29 @@ static void shutdown_onchannelcallback(void *context)
 					sizeof(struct vmbuspipe_hdr) +
 					sizeof(struct icmsg_hdr)];
 
+			/*
+			 * shutdown_msg->flags can be 0(shut down), 2(reboot),
+			 * or 4(hibernate). It may bitwise-OR 1, which means
+			 * performing the request by force. Linux always tries
+			 * to perform the request by force.
+			 */
 			switch (shutdown_msg->flags) {
 			case 0:
 			case 1:
 				icmsghdrp->status = HV_S_OK;
-				execute_shutdown = true;
-
+				work = &shutdown_work;
 				pr_info("Shutdown request received -"
 					    " graceful shutdown initiated\n");
 				break;
+			case 2:
+			case 3:
+				icmsghdrp->status = HV_S_OK;
+				work = &restart_work;
+				pr_info("Restart request received -"
+					    " graceful restart initiated\n");
+				break;
 			default:
 				icmsghdrp->status = HV_E_FAIL;
-				execute_shutdown = false;
-
 				pr_info("Shutdown request received -"
 					    " Invalid request\n");
 				break;
@@ -184,8 +207,8 @@ static void shutdown_onchannelcallback(void *context)
 				       VM_PKT_DATA_INBAND, 0);
 	}
 
-	if (execute_shutdown == true)
-		schedule_work(&shutdown_work);
+	if (work)
+		schedule_work(work);
 }
 
 /*
-- 
2.19.1

