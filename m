Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59F1497A7
	for <lists+linux-hyperv@lfdr.de>; Sat, 25 Jan 2020 20:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAYTzI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 25 Jan 2020 14:55:08 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:55905
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729145AbgAYTzI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgrUvk1Bu3xFJIKB8AyZyqQ+wCBVhy+6ZvS1tUh2GnhfffykAcuil/7B0YOKCCrjGYXBXwCMkcA0y24wiu6+bEZxtfi3Oal1aUCBfztAooSafM6sa81fzchkJhS2DMtVWzbcVlY4A9fNjRm+FJPJsnr9LdK8jW8vSx4dpXCVCEZEx5HFaxitbZtZqG4THTjFQ6zAXd9fH8BEHAfmOqAxsF2DgTNQul01LccPT7YZRsMTg3gz+E1rCPbutCu5m1vkTVHw1llVVxmXmK6RaP2XNegVdyHgkMncOSTneDAENJggXFWtXbnDawuQN3fDxbTiWCzVGx2Ii2JdLKFDieYj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmJ+eioFeMQTZe3Gv7zcWmUnfoC/NB94uVjyctnD3Aw=;
 b=V4J6D6wsRPnn5LH78E4YrOjB9JtpEHgbWzL222Rz7ilHoVdK+JjjVKwDFs+6g0fWNLsaU9L0QybOWwHxlY5N3zdP7XRwDzB0JmnClFVH7RPMS7igONvRz5ycLnAdyg7TunwCTl88Y7UvupTlw90PJ/Wmo6/CH7eExWnbYmlU7rF1ASWL40CaeoMbeuvzOSEEtbqeqi4l3coStAqI65Oxv/ycZfpdCFKCPc/PgwCQtq2G2EkgKkPFB9VZ4SMH90W3ItOqHmJOv63iQJrnayzN9dsET7iBn/hietPIqUo/oQgmbORSd9oa7lZuZ3JkrKVbpyJ3COoRO7/d31H1gCFQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmJ+eioFeMQTZe3Gv7zcWmUnfoC/NB94uVjyctnD3Aw=;
 b=DpBB4M+441Js9aQMVlxTiGy3XfO9vN9LrZy3hobeBCVT9+WtLpXXwSTA344bkfd0RsVVlsR0l4NRLldOWjuUK455DhWc/mMOpswai6O2XgXFrp4WzogXiRtfCnduXTd6iblUZoH+yvSRKNwRJKaiMMa2rubWQ45/5ojHC1uoyUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1202.namprd21.prod.outlook.com (20.179.73.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.7; Sat, 25 Jan 2020 19:55:05 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.007; Sat, 25 Jan 2020
 19:55:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 3/4] hv_utils: Support host-initiated hibernation request
Date:   Sat, 25 Jan 2020 11:53:55 -0800
Message-Id: <1579982036-121722-4-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579982036-121722-1-git-send-email-decui@microsoft.com>
References: <1579982036-121722-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BN8PR21MB1139.namprd21.prod.outlook.com (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Sat, 25 Jan 2020 19:55:04 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc8e3d56-2979-43ed-6b3b-08d7a1d078e2
X-MS-TrafficTypeDiagnostic: BN8PR21MB1202:|BN8PR21MB1202:|BN8PR21MB1202:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB12023823636C15E3E1678FB8BF090@BN8PR21MB1202.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0293D40691
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(81166006)(8936002)(478600001)(2906002)(8676002)(86362001)(6486002)(186003)(4326008)(26005)(6506007)(36756003)(5660300002)(10290500003)(16526019)(3450700001)(52116002)(66476007)(6512007)(956004)(66946007)(2616005)(316002)(66556008)(107886003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1202;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8SXNnWcl0f61wC/fFYawXEGFWfr/J4quQAny0KVRiqzGqqRyI4O7MvTZboTl8L1iMK/ajf6zxPmQnrgRyf1h0B1y2wQ/AWyB550C1C7ltzBXVfljBjfEQl7VKWM0dUF9iefuh/bfKfuKs/CIkXziaPMUOPD3uGgUoedvf+3FAsiG0i5ZFtDxUJlgW6ssAuJ85d4zYCLhYMFWi0bp8UsHMe7xHzQM1ycYasgxaiOPBwr+S8cMQeckalvcoSOHDJsmM9crbz0+U73M+iSYyQVY+hiLdewxMNTjuwhVGCLcav8DCCq4x79eJcTWgiJSknPd0VquKlM5mVLG295ibiuHbYi4up3x9mK+OQISzTMEgqUQO4Jqo9YGebPOYdbGZlcsDkoq2/odjw2MQuLOV14a0wG/PFDypwC7neEG/oRldamnrb7Ve/ckoUDaEH4xjUj
X-MS-Exchange-AntiSpam-MessageData: zoHKg0reZkdE0pu0bXIIN24r64Uq5wj4SwhMb2juHqIZA9a8JQjnbo/sDDF/yT4TcpODvMMBBVR8GO/UHK8ILi61xlbXTdakl9L1GRszc4gaXEpLVJERP/UEUGZ8VoXFwRTZfEm78dcC9ZTKcMr/Sw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e3d56-2979-43ed-6b3b-08d7a1d078e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2020 19:55:05.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxHoSKANocyF7/p3RsBLklF3s+rw4F+7QIyJJSGWEfxTx8Nys+a/W/FqGEsY0NSxIJHiYo8vI7CbiBwZsu9aMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1202
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

 drivers/hv/hv_util.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index d815bea0fda3..e07197dfb4a2 100644
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
@@ -143,6 +182,7 @@ static void shutdown_onchannelcallback(void *context)
 	u64 requestid;
 	bool execute_shutdown = false;
 	bool execute_reboot = false;
+	bool execute_hibernate = false;
 	u8  *shut_txf_buf = util_shutdown.recv_buffer;
 
 	struct shutdown_msg_data *shutdown_msg;
@@ -194,6 +234,14 @@ static void shutdown_onchannelcallback(void *context)
 				pr_info("Restart request received -"
 					    " graceful restart initiated\n");
 				break;
+			case 4:
+			case 5:
+				pr_info("Hibernation request received\n");
+
+				icmsghdrp->status = hibernation_supported ?
+					HV_S_OK : HV_E_FAIL;
+				execute_hibernate = hibernation_supported;
+				break;
 			default:
 				icmsghdrp->status = HV_E_FAIL;
 				execute_shutdown = false;
@@ -216,6 +264,8 @@ static void shutdown_onchannelcallback(void *context)
 		schedule_work(&shutdown_work);
 	if (execute_reboot == true)
 		schedule_work(&restart_work);
+	if (execute_hibernate == true)
+		schedule_work(&hibernate_context.work);
 }
 
 /*
-- 
2.19.1

