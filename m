Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E76D11034E7
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 08:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKTHOq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 02:14:46 -0500
Received: from mail-eopbgr720113.outbound.protection.outlook.com ([40.107.72.113]:23819
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfKTHOq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 02:14:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWtDa1m9+2BcOlsvikbjNX9D/qrELXhDBjvkRg2Thb8C9Ey4Wx3orvNmCbLMg0hPbVlwBvXlSWu4nhyXQ59KMkJlcfVcDn07CFuYbL4NXzoDYyupIdQOb9HfGplyyKjp7S2dBKdBA4cdBlEBUXOVvsc0uxGclgEU1OU+B3M0TRVw1YGpRPkm06aYwF4hZbcwqtKf9FmWWnM4kD2/UB/1bP2qDJe5yir2fxVhvVAN7WggcIeapNg/guaKPeMunubmGw6ekvtgE9P88lw2oEI46U10empQPRxaj0hTY0SwL6UbXMBkhvYbIKLs2nuAzfAQB0jBif9U/aUkJxh/iivbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgcVxtO3KLOQJcxWEXA9hHLBDz1orP/CqMSKeAsR+60=;
 b=IYjWP9qsv84O4WrlvLVyMmCMWAu5neqtTQ0X3KXLJ3OLHxTvi5Xn/Qv6iCm/dDt05WVp0QOjhFTxNawMYANy+tJScirU/79pgROzCxg20u0bcWzY+wOqN9QwwCjVpbc4EodLgi4lPkGVjZ/iTZguXPx1dl+x3UjNWBYFTufzgIMJyLi0pB6Lg/Dk5BCths8A28Q+U7Jj+NLgyLqWvaw8Jyt3MggzA3/RzYQnGATkuxcN6H2hZWC5LsXWqmnFAaWD4VzLRrZWuUMID7CB4EfZWmUvdh/4poVGpUqV1WmGEXiRaFTzjwP2N2kFEMVcCnSfSzzV/Qnm5myCyJ5XJMHUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgcVxtO3KLOQJcxWEXA9hHLBDz1orP/CqMSKeAsR+60=;
 b=MNKIPhcV9iaVJnLQzC7a/MLASyzXfLDfTF5DrjTA8A9g6xs/D9y5iwDGum2Cik8kfMcZXpmjyDMFx+zDiHU8LpZF8hBb4Cdns/WqpSmZNk+uaeO8gvBFwWBRHPH1P60pxH2Fmlx9RGbW3hC1SHTQ2uDYKrpX9bFBSsqQ/VHwt0k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1251.namprd21.prod.outlook.com (20.179.74.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:14:38 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:14:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, dmitry.torokhov@gmail.com,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] Input: hyperv-keyboard: Add the support of hibernation
Date:   Tue, 19 Nov 2019 23:14:28 -0800
Message-Id: <1574234068-48688-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:301:15::33) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0023.namprd20.prod.outlook.com (2603:10b6:301:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:14:37 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66367cdd-67ed-4122-b2ea-08d76d894e1e
X-MS-TrafficTypeDiagnostic: BN8PR21MB1251:|BN8PR21MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR21MB1251C8E4424B993F4CAF53D2BF4F0@BN8PR21MB1251.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(10090500001)(36756003)(8936002)(50226002)(81166006)(81156014)(8676002)(14444005)(6436002)(6486002)(1511001)(86362001)(7736002)(2906002)(5660300002)(478600001)(10290500003)(966005)(4720700003)(6636002)(3846002)(6116002)(25786009)(3450700001)(66946007)(66556008)(66476007)(305945005)(316002)(386003)(6666004)(4326008)(6506007)(22452003)(26005)(16586007)(186003)(16526019)(107886003)(51416003)(52116002)(66066001)(48376002)(47776003)(50466002)(43066004)(956004)(2616005)(476003)(486006)(6512007)(6306002)(921003)(21314003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1251;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fKyLFlHPdP5+GUVrgMrgopeLn45ZxWd7KousDbm0bU8jOzu49CmbrtQ1v3BBeOkoZhcCZEDA+zWxoj9KeoNsx3AecFuOGAgJAv10Fq0IAgJVHvHDS1GCzWKqQJxTJRgYn9lIIB09KWHww+4wNP1r7ypgNFxmhELxpM/8TP7DGN9FFCGXexsjYpxF2N3SWev0QODIg/pii42YSP1jNtojYg1uPF1tFdqbduLAc/MslMFEVmOCku4lxBChSDOxHFm3EDaogyb/PY9FLn4Z9lg7jZ4oJ8jExVOKKQc49p/2+kf/Tx4iClOjU/+KMApWtHrDRUjft/sZLNJ2aNwcPEEz8+IRkOOvrUuLG9iqQccS8Pi3gbhnZeaBnFD57+KqbR8I8w69tX9yMfzCmsafHJv9f9dGTOJIqAo6n8Wlkgx2uEJcxuU98VciTtBGZLt9K8pNYKbCDKM/LUYTxCbLeKTpPjJlaqNnpUY0c7zRFIH7DI=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66367cdd-67ed-4122-b2ea-08d76d894e1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:14:38.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrFZDb9oD8Iy0NV3c6JmrKMk7MNuP+EGcyeTDjQUfg7lI3kXp9uqZFV04SyDSOneUT/IzqhPqbM/0L4HgPt/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1251
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

During the suspend process and resume process, if there is any keyboard
event, there is a small chance the suspend and the resume process can be
aborted because of hv_kbd_on_receive() -> pm_wakeup_hard_event().

This behavior can be avoided by disabling the Hyper-V keyboard device as
a wakeup source:

echo disabled > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
(XXX is the device's GUID).

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change. I suggest it should
go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Changes in v2:
  Removed the "struct notifier_block pm_nb;" after the discussion
with Dmitry Torokhov:
  https://lore.kernel.org/lkml/PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM/T/#m8948c711301220a36a1a413eead74cd2fb6dcac1

 drivers/input/serio/hyperv-keyboard.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index e486a8a74c40..df4e9f6f4529 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -259,6 +259,8 @@ static int hv_kbd_connect_to_vsp(struct hv_device *hv_dev)
 	u32 proto_status;
 	int error;
 
+	reinit_completion(&kbd_dev->wait_event);
+
 	request = &kbd_dev->protocol_req;
 	memset(request, 0, sizeof(struct synth_kbd_protocol_request));
 	request->header.type = __cpu_to_le32(SYNTH_KBD_PROTOCOL_REQUEST);
@@ -380,6 +382,29 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	return 0;
 }
 
+static int hv_kbd_suspend(struct hv_device *hv_dev)
+{
+	vmbus_close(hv_dev->channel);
+
+	return 0;
+}
+
+static int hv_kbd_resume(struct hv_device *hv_dev)
+{
+	int ret;
+
+	ret = vmbus_open(hv_dev->channel,
+			 KBD_VSC_SEND_RING_BUFFER_SIZE,
+			 KBD_VSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 hv_kbd_on_channel_callback,
+			 hv_dev);
+	if (ret == 0)
+		ret = hv_kbd_connect_to_vsp(hv_dev);
+
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Keyboard guid */
 	{ HV_KBD_GUID, },
@@ -393,6 +418,8 @@ static struct  hv_driver hv_kbd_drv = {
 	.id_table = id_table,
 	.probe = hv_kbd_probe,
 	.remove = hv_kbd_remove,
+	.suspend = hv_kbd_suspend,
+	.resume = hv_kbd_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.19.1

