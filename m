Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2B1497A6
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAYTzH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 14:55:07 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:55905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729133AbgAYTzG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7IcgUOcDt3M9rDYWsBfVtaC48RZe5WfBYeU04uxFMhGrSDrTkqBDI5SUjpN51gyTE34d9o5olYSjK8hhxEPPqnJyCO7r/OZv1U+fgRRxap5skcwPdi0e5csT6AG5+VFkmp9zj2WEkOFoHFTL+9PjNHKIJrk7Z9X8pQ8+GReoshRlmhXRDqwCZ0qZcAC8tKEmyEU0VakR+NZ46VtdsY5lMSmGwo/dl8JKd43LR7IQ2ENGCtntSIH0I4FOQXKGTcz0BE7z2Gz1JVc05az1FCGN9I0IrltLtyNyKnaj9sGRIxsSPFq9oX7xh4TUg0xqVPEDNFhDmsiu8TuSy0OxgqEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+DwemVLLvrPF18BKmR1SYx+uPta8tV831EwdaXdJ/k=;
 b=EydmXY7v5R1fcjYkPGVqtVLACQcHr8AdhBBQiRVuF1NpzqsH5pspxYxVgBq2XY5he70bk2HSvIaBbHj1dv6tWKMiPCrv4kLrUFBZtkmRHwnW7YT8nWftWpnQTj0c67klx6cFSBuHO6xIQzX7Df75d4igz1oXru2wMCna5Gvy1vKo7/skF2wJskcPV5Z+FbpX6vdo11eEburSr5Nn71ZYVz2UKfGOi7es4CmZtxssCtLkDRt0Uj3dwOs8WlFDoWoTmgsGlOAAf5O7ILLlL9jbGCwamsME/iNW1EzT17CKWagUMA0FAZYNV0WmYtpBwtz97VKjskhmh9HWQ4GfXNTLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+DwemVLLvrPF18BKmR1SYx+uPta8tV831EwdaXdJ/k=;
 b=YCqmTo1VciPM/N5Q07cT4+s83C7tfUWnQetWM/UMmR/kLY69tkmAawhlmUC6yVTKHFqcC3ngHm3HuU7rxpDd7nBVN6aM0kam1a74TEscHUwtdD0CQtXJAR549QT5a4n1+i7t8Ixl1+2MhwNfdxr9NrJBuOTY04QSHaUz2wJnv1o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1202.namprd21.prod.outlook.com (20.179.73.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.7; Sat, 25 Jan 2020 19:55:04 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.007; Sat, 25 Jan 2020
 19:55:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 2/4] hv_utils: Support host-initiated restart request
Date:   Sat, 25 Jan 2020 11:53:54 -0800
Message-Id: <1579982036-121722-3-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579982036-121722-1-git-send-email-decui@microsoft.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 19:55:02 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 244ffbdd-9201-4652-e0ca-08d7a1d07819
X-MS-TrafficTypeDiagnostic: BN8PR21MB1202:|BN8PR21MB1202:|BN8PR21MB1202:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1202A5428902AF1F3B6BA97CBF090@BN8PR21MB1202.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0293D40691
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(2906002)(8676002)(86362001)(6486002)(186003)(4326008)(26005)(6506007)(36756003)(5660300002)(10290500003)(16526019)(3450700001)(52116002)(66476007)(6512007)(956004)(66946007)(2616005)(316002)(66556008)(107886003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1202;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6mNvbJnIoHdL+s/hqnx7PuHoVzN3wRcm3RPD+2G2CwoWxcmpycXyyrU76gr98V0I+nVc9T2SvdIJGfKA/QzOIBy0c57zO12pQnkEdd1hztguv1o2ESLLF6U2Ptyd8Et8d53UmaqqOSsSd2Z55pGn5yTnkdyfx2UL3kYl+DceH0wQXgwBqY+g1ZvxV9HvkqhM16r2MF/8403PjxwV9pqltS1jjdmYpfMEIgSuBhL1KX+h/KdzC4pPwFNB1TsUXMklM1mQxJZ7+L7cd8IMo3jFaq//8M/IGIJ2uyDT8Q0wFPzho0eQ6bfOPQ8dB4MNkGpZi8K3+EAPoQHEdtWSYzkj2iN6qaohBtkafY3TILr9Oa+rc+YvRRQeW/z7/6oRfo8Diuqf8JeyX68UtBrvwxN4bo/qqOjpGOvQB9ofuEgG5oFSzK3f556+GxNuP9KaE7F
X-MS-Exchange-AntiSpam-MessageData: Hn6l8ubsz+qZxWx6cNTAZ90Mva1JoJ0ezF9BRlP/1CIfKP5NnH/ciQeqKkx6IOrF8V81Tlhid3OuOs9trfWoV/eupdkNFqdhgDVM8fLcclmrILRL38xAFVhmscnkPqe1yAjK1nq05OZjsq2kio1nOw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244ffbdd-9201-4652-e0ca-08d7a1d07819
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2020 19:55:03.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSmgNBFUVA9LZL2QcM/565jrMAaKtvOxO87bYeHXpFdHcjrA13G/Ygw0asAhWf906n85BFdS3jDN598onPiaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1202
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

 drivers/hv/hv_util.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 766bd8457346..d815bea0fda3 100644
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
@@ -118,17 +121,28 @@ static void perform_shutdown(struct work_struct *dummy)
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
 	u32 recvlen;
 	u64 requestid;
 	bool execute_shutdown = false;
+	bool execute_reboot = false;
 	u8  *shut_txf_buf = util_shutdown.recv_buffer;
 
 	struct shutdown_msg_data *shutdown_msg;
@@ -157,6 +171,12 @@ static void shutdown_onchannelcallback(void *context)
 					sizeof(struct vmbuspipe_hdr) +
 					sizeof(struct icmsg_hdr)];
 
+			/*
+			 * shutdown_msg->flags can be 0 (shut down), 2(reboot),
+			 * or 4(hibernate). It may bitwise-OR 1, which means
+			 * performing the request by force. Linux always tries
+			 * to perform the request by force.
+			 */
 			switch (shutdown_msg->flags) {
 			case 0:
 			case 1:
@@ -166,6 +186,14 @@ static void shutdown_onchannelcallback(void *context)
 				pr_info("Shutdown request received -"
 					    " graceful shutdown initiated\n");
 				break;
+			case 2:
+			case 3:
+				icmsghdrp->status = HV_S_OK;
+				execute_reboot = true;
+
+				pr_info("Restart request received -"
+					    " graceful restart initiated\n");
+				break;
 			default:
 				icmsghdrp->status = HV_E_FAIL;
 				execute_shutdown = false;
@@ -186,6 +214,8 @@ static void shutdown_onchannelcallback(void *context)
 
 	if (execute_shutdown == true)
 		schedule_work(&shutdown_work);
+	if (execute_reboot == true)
+		schedule_work(&restart_work);
 }
 
 /*
-- 
2.19.1

