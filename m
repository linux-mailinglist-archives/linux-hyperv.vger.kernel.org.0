Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB2108856
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfKYFdo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:33:44 -0500
Received: from mail-eopbgr680102.outbound.protection.outlook.com ([40.107.68.102]:34126
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfKYFdo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:33:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyoDFRoIcf0FV1iaZKA2ojLBOUzDQb/H+3bl6lS+sBrOLdKcbmz7h+v9TVQUyXn02Y5UMWkR/W3jnLJKTqmGoe7HoikMJu/8zeM2xdCOXPeALZxNjQRcb5D9VCC+2wLeKKepgmQESP++9cQ8tXoWTqLpakdHK8iGFI0No5I0+TI96AWMkv2EdmJxESUWcuB8DdzL0yz9C9ZLqpMgj0fahv8UksZNjJVGNGkfhMDhctQoLP24yWxFqxu6CcBAoAPZg6fCQVabxJHTdnm1vG385ylqKNB2+ovBKprVf1m5kGLB1tDuRgeRlVcNi/hbYHxENHE7HCfqKgRZaas+z/4gSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emoDvgV3p33yQCPO9kcsuRIANc2/IX5OrvL2c65U+pM=;
 b=ariZxVhHARO57qdDsB2nkZbQkJObpMCh7HzehRZLQpCFNxW1HLeDPlHiOpMm4tu1Q2qtoBSO/YHC6fWZbkcxvp0pUJoku4Lty3AAzfv083lYNF45QsKny7SI/22U/qm+laDrlBMJA1sX/8CmmIk4rBN9pB+P5hSWIp8hQr2fZuSWanpEzFJ3a6/efdKydgDubI3oRQVjrl5mVPQ10XlC6QaR2DMcH2Ko+oABk/nv6m8aBAHQH7hJDXFIqMOZtNruuqrqrtjVpDu4pnN5Fer/jxCp49bS0YmlVAGuxxF4sbEjwtqQGXF0zglf4L8KBi2vGTmWzOFsPk3QrmFcX8vV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emoDvgV3p33yQCPO9kcsuRIANc2/IX5OrvL2c65U+pM=;
 b=Lnl5iPdNq+uP5Mhybso3ImQvp4oEm8HLc/O4W0mJSRZ46WBYSUGidmMEpN381uMflyDf4GGUo+50smYJVV8IEQXND8gD6YDpe17fF5vsOsYCM19IvjpdqKY5hXks7HIimdtBvI8TKNyw1xmg8e4QZ9/oQqZ2n7Olk1l8PezB54U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:33:27 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:33:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, dmitry.torokhov@gmail.com,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3] Input: hyperv-keyboard: Add the support of hibernation
Date:   Sun, 24 Nov 2019 21:33:03 -0800
Message-Id: <1574659983-98668-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR21CA0041.namprd21.prod.outlook.com (2603:10b6:300:129::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.0 via Frontend Transport; Mon, 25 Nov 2019 05:33:26 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c82ddeaf-4f8e-4221-3a33-08d77168ff56
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB11898E55DCB1DAD8F44AC88FBF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6306002)(6436002)(10090500001)(3450700001)(2906002)(14444005)(50466002)(48376002)(25786009)(6512007)(26005)(6506007)(386003)(51416003)(52116002)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(966005)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(21314003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1E1OGb14WzMUZxyFHp6k/IHvOgoqSX/Gj8eDvhroZk09W+EUH3V9lLrucNj5iqKLv46QFP/uRYppGhIN8NV32ipkCK9vmyqZP9mlIAtVUbj1v6nE084dAVplDP38O6uHVp7tprdQsqBJV0y3OaaGfI3/s7HDVWeUI6/H3SaTlSr3KmyaBanbuK3CBs0NuGJJpXYG+EOY+6kHhH0TBwQ/CyDCKmCWP/fClos5EI7pK2LsuIgadvU4JitsoR7psDjC2ggdiGzma1SP92y7bS35u05QoTwtLAtXZm4JNTe7B9qpieB76QJ1cAV7YCcea0NE6j79t751pU2rQYUMpAjzk3+9wqg1nlFrjcoxJzK8mgbnTbx/QffREz2lDRZwCeEct9HN/itBVbur/4EN8Ds30CTnZDRsFHs6JnOugK3i/2EReffkxcnscQU4zMd1v2bc4QgcBvet0ziJtoBWBRO4eTkjLqPp+ti0dV06XvwmV4=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ddeaf-4f8e-4221-3a33-08d77168ff56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:33:27.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6FrtTbKCzlEFLcx1HahhILYSEwyPCSaiJpWUKbqHY6+Bh9loyG/Qth/xt8n+7Okw6ZUsSWacSn68MPfAIdCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add suspend() and resume() functions so the Hyper-V virtual keyboard
can participate in VM hibernation.

Note that the keyboard is a "wakeup" device that could abort an in-progress
hibernation if there is keyboard event.  No attempt is made to suppress this
behavior.  If desired, a sysadmin can disable the keyboard as a wakeup device
using standard mechanisms such as:

echo disabled > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
(where XXX is the device's GUID)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change. I suggest it should
go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next

Changes in v2:
  I removed the "struct notifier_block pm_nb;" after the discussion
with Dmitry Torokhov:
  https://lore.kernel.org/lkml/PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM/T/#m8948c711301220a36a1a413eead74cd2fb6dcac1

Changes in v3:
  Made the commit message more descriptive by using the version from Michael.
  Added Michael's Reviewed-by.

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

