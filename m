Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326A814995D
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAZFub (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:50:31 -0500
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:58464
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAZFub (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzCC9ggT5t1ci22xM62vAOav4ZIxnij+BU08M+IJlzqo7FMtQMD7dbB5ZpDlSy1dDhv+1kEr/2DNNhLzrSfyU1ivPQBgJTTOmQC/ZNVsvcGesjExrAjm+6rm1Yj0deE97suMy5PBsZ6CPFL27l1qdUEcm8naRud996tveeNjQB1UtFVZD8QxgOk5uqyRZVNI7syh9IMg3epBAPJuMfCWvWtiZnTM2ouLEHZxn4Ovbg1VwkY47nKVxxNkrv61E4U3OtXNLez+DwjrEwt6amjez3s44X/GWdlJaNhaJ2edZJtMLWG5sVCVMtHI2Op2FJIxsC4U4uVib2paJUzQJl/E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/HFVJy1Nwt4dFkQN02272ks5Z15k7IayHbgkwepc1U=;
 b=NqHD4+tne2TgZ+alP7LTtt2YbCj9FOSFFAYFXT6d4Cn+ybInndm6gLAznOnSFloyDFvQAYqZh/pk5OG41KQzuf/SP6CQqhD0UoGi2u+ZKcpEYd6gBOsrrwCMq+1mfTN+LGqWJs2tQjanDsWbmsahv2sTcnXZzNB2KQzWgxn7pVmTUSMB0Npb7ziJLNg/yWMkVpyk7pIAhEa4nDJD4cQ4gaHBmAIwlCa3LCCMZ6Uh9KsV0OruCxUbQcCRCLhjGeldQcPNiwlM3KCIIxzwWczGbVz37Wt4ozxzOgT38duUQIICP7DZkMKBx2SUqrkMZZ7GYBNJEB6XPcB6XJSYZ3Vxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/HFVJy1Nwt4dFkQN02272ks5Z15k7IayHbgkwepc1U=;
 b=L2hyB+YHaklY+nUz8i52eXUf1p9QLWZ3Is+QrHQbtXPKi/1C6VqQ3npnBV6fCKHha0JdBKU0KvMRN/6Kn30y6Di/s3wKSybpcn4WthUicEP4Arc2spKHpf79Z3dAsmqBfGCFKntTeAhKt/HDRRr7a9jV4SnHQ1cWX9UhVjvXBEc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1203.namprd21.prod.outlook.com (20.179.73.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Sun, 26 Jan 2020 05:50:27 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.019; Sun, 26 Jan 2020
 05:50:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 3/4] hv_utils: Support host-initiated hibernation request
Date:   Sat, 25 Jan 2020 21:49:43 -0800
Message-Id: <1580017784-103557-4-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1580017784-103557-1-git-send-email-decui@microsoft.com>
References: <1580017784-103557-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:300:12b::14) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Sun, 26 Jan 2020 05:50:26 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77e21ef2-c44f-4de1-0ef8-08d7a223a4eb
X-MS-TrafficTypeDiagnostic: BN8PR21MB1203:|BN8PR21MB1203:|BN8PR21MB1203:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1203A55BF5D97C47666653C1BF080@BN8PR21MB1203.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02945962BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(316002)(2906002)(66556008)(6512007)(66946007)(66476007)(86362001)(107886003)(3450700001)(6486002)(36756003)(8936002)(26005)(5660300002)(4326008)(2616005)(956004)(478600001)(186003)(52116002)(6506007)(6666004)(16526019)(81166006)(81156014)(8676002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1203;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iz+df+QFlcIwl6CBhOhyrdE69oB/XbuzhEpIAlryLMneQCvRRetM3EJ7LBByouQbz8qk4fS+dnJNxvPhUyADNuRyp1QBuc5RwthKCw6Tuit6JGPyeUjzpNxyBPCWoQwu8r4S4bDY3ZsYiOjC0u/CYKbou1z80jh0JzYl/VhdGExCjJ2g2J3Zy/uPh37K9noQk5D7RZvVJE8ajAWSdd7tPmX5N1Czs1kM8mypCZmXuXpF/ZXJwh4hdzDFYvrn2jmt20qShwclCqkAczzflSf/Pc65LdDwAB3vfD5z9yDSYW+kKCIythfdFnBjuslV7itza3aqj4Xije3sTBsBMEEtJJx5MumFvQvKWW2j3a10PP/iDX4itNV82tMz14abDYMlATdEWH35bRITzR8xXX7c5Op3u4k4F0ywuiv/71/DktpWNogYSEpaFTlDT8cLZCGE
X-MS-Exchange-AntiSpam-MessageData: bNw8C5gwxO+cWj2v8u31YH0vFE8Y0kRVmoodjjU/tPOuGWQ4gpVUQE83egT0IUNj2Yn2LLmacIZ3jH1VXn7ALg0YjX6xCONAbnLXlL3o8s6X+BVEJ7RUJ+yCOGlweEbr54eax5RGDf7k/zFJZrQOVg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e21ef2-c44f-4de1-0ef8-08d7a223a4eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2020 05:50:27.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WadDVHSIak+lqngmAfbD4OMNBFIsuXXtkZI0KkgNhtefscj2xNA+OqGP3DdLX/3nI4GKUh67Hb/z+Ybdeo1Uqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Update the Shutdown IC version to 3.2, which is required for the host to
send the hibernation request.

The user is expected to create the below udev rule file, which is applied
upon the host-initiated hibernation request:

root@localhost:~# cat /usr/lib/udev/rules.d/40-vm-hibernation.rules
SUBSYSTEM=="vmbus", ACTION=="change", DRIVER=="hv_utils", ENV{EVENT}=="hibernate", RUN+="/usr/bin/systemctl hibernate"

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
Changes in v2:
    Send the host-initiated hibernation request to the user space via udev.
    (v1 used call_usermodehelper() and "/sbin/hyperv-hibernate".)

Changes in v3 (I addressed Michael's comoments):
    Fixed the order issue in sd_versions[].
    Moved schedule_work() to a later place for consistency.

Changes in v4 (Thanks to Michael!):
    Used a compact way to handle the work item.

 drivers/hv/hv_util.c | 49 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 32d96af67522..64fbf4ac80f9 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -25,7 +25,9 @@
 #define SD_MAJOR	3
 #define SD_MINOR	0
 #define SD_MINOR_1	1
+#define SD_MINOR_2	2
 #define SD_VERSION_3_1	(SD_MAJOR << 16 | SD_MINOR_1)
+#define SD_VERSION_3_2	(SD_MAJOR << 16 | SD_MINOR_2)
 #define SD_VERSION	(SD_MAJOR << 16 | SD_MINOR)
 
 #define SD_MAJOR_1	1
@@ -52,8 +54,9 @@ static int sd_srv_version;
 static int ts_srv_version;
 static int hb_srv_version;
 
-#define SD_VER_COUNT 3
+#define SD_VER_COUNT 4
 static const int sd_versions[] = {
+	SD_VERSION_3_2,
 	SD_VERSION_3_1,
 	SD_VERSION,
 	SD_VERSION_1
@@ -78,9 +81,45 @@ static const int fw_versions[] = {
 	UTIL_WS2K8_FW_VERSION
 };
 
+/*
+ * Send the "hibernate" udev event in a thread context.
+ */
+struct hibernate_work_context {
+	struct work_struct work;
+	struct hv_device *dev;
+};
+
+static struct hibernate_work_context hibernate_context;
+static bool hibernation_supported;
+
+static void send_hibernate_uevent(struct work_struct *work)
+{
+	char *uevent_env[2] = { "EVENT=hibernate", NULL };
+	struct hibernate_work_context *ctx;
+
+	ctx = container_of(work, struct hibernate_work_context, work);
+
+	kobject_uevent_env(&ctx->dev->device.kobj, KOBJ_CHANGE, uevent_env);
+
+	pr_info("Sent hibernation uevent\n");
+}
+
+static int hv_shutdown_init(struct hv_util_service *srv)
+{
+	struct vmbus_channel *channel = srv->channel;
+
+	INIT_WORK(&hibernate_context.work, send_hibernate_uevent);
+	hibernate_context.dev = channel->device_obj;
+
+	hibernation_supported = hv_is_hibernation_supported();
+
+	return 0;
+}
+
 static void shutdown_onchannelcallback(void *context);
 static struct hv_util_service util_shutdown = {
 	.util_cb = shutdown_onchannelcallback,
+	.util_init = hv_shutdown_init,
 };
 
 static int hv_timesync_init(struct hv_util_service *srv);
@@ -191,6 +230,14 @@ static void shutdown_onchannelcallback(void *context)
 				pr_info("Restart request received -"
 					    " graceful restart initiated\n");
 				break;
+			case 4:
+			case 5:
+				pr_info("Hibernation request received\n");
+				icmsghdrp->status = hibernation_supported ?
+					HV_S_OK : HV_E_FAIL;
+				if (hibernation_supported)
+					work = &hibernate_context.work;
+				break;
 			default:
 				icmsghdrp->status = HV_E_FAIL;
 				pr_info("Shutdown request received -"
-- 
2.19.1

