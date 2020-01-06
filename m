Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7A131BAA
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2020 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFWky (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jan 2020 17:40:54 -0500
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:22464
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgAFWky (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jan 2020 17:40:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0Q0jJb+kSLiAW93CP9hSC4GwP1558R689b+LfW91AftEfPNrmTDwqHASvB+4v73/MQmaTeB2dxij9mwpYj6MRmBgFfn0vtsX/T85Myz0UB7Qn/6m5iHyStCh7ngl4FZLZXrC9JJQy3B/Yv27eXWa9CCiupTl3sr9W2GsOxJ7zdNyXO/mDagelssvHne3ALqdmTHzy3ssvXdI0uWzXleas9jCA/TPsSsigDPOGrFiolhFzFLbvIxSKm/dFCr+o2+5LFH0yET2gpzp5jYMkB6hfSUTOfALAbPx35oVQMBuomLLBXDbhfZ0FbDHjK0bZQldeOiTHlyHdv/esdpt4MMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMourdQM1ifxJbLoShY1of/Ps/fd9Aqqs+g/RkNk7Mw=;
 b=dqwNESZBrs8hQRKJWfkycKF/yOzLqgaIIbUWTQmt/b/ceRn9wJ2idrpeGqzxMND+CgS0Z/hLZC1toohXQ0xzMNlpkKnwXAmq9yZlrwX9JLW5ee9KKxBN8/zGfMXO45ftqMB0g4ogeCWFEaF4JLKCuUyO6WI0x2LVMgy6xInQc7HGecs20pIRggoL3V6zhMZ3FTm9u43otVLCkpQGWOjSDKw5ykckhLXwselJXjglkH758XLSyHd5dZJJeUsXLL73pnqrwlu2+iwtvQ7H3Z+6p0U7HPDgakKkIff6vw9+BUHftlfF5+aHYs2izOGTAyMRB2tQoT6aoa7h+6h5jP9ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMourdQM1ifxJbLoShY1of/Ps/fd9Aqqs+g/RkNk7Mw=;
 b=E/7XU3z6jKMv2G9gGnvYOy2JusncMRNnllJ18x8Mp0BwUJpEjUNSmMzpyE34V2nW4/ijvZZ95ZbqxLf0zM/nox9uQsG9mPgI3bGiw7dJa0FDS6bSRYKHbXy7HTFrHnHstUut9oVQfBdKz+oOPtmsOHfldKWMKpK6a8+3upNI5sw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.4; Mon, 6 Jan 2020 22:40:51 +0000
Received: from CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b]) by CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b%8]) with mapi id 15.20.2644.002; Mon, 6 Jan 2020
 22:40:51 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, dmitry.torokhov@gmail.com,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH][RESEND] Input: hyperv-keyboard: Add the support of hibernation
Date:   Mon,  6 Jan 2020 14:40:44 -0800
Message-Id: <1578350444-129991-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:300:d4::28) To CY4PR21MB0775.namprd21.prod.outlook.com
 (2603:10b6:903:b8::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR19CA0018.namprd19.prod.outlook.com (2603:10b6:300:d4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 22:40:51 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 447ba918-4c98-49b3-773d-08d792f97bc6
X-MS-TrafficTypeDiagnostic: CY4PR21MB0181:|CY4PR21MB0181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR21MB01815D121863D35B0596F471BF3C0@CY4PR21MB0181.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(6666004)(2616005)(956004)(86362001)(478600001)(10290500003)(6486002)(66556008)(316002)(66476007)(66946007)(966005)(2906002)(3450700001)(107886003)(6636002)(8676002)(81156014)(5660300002)(6512007)(6506007)(81166006)(36756003)(52116002)(26005)(16526019)(186003)(4326008)(8936002)(921003)(21314003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0775.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S28xdM+fdzmRtXZ7gGu3vzd8eb7Bz1GOZyM6Xe62f6MnrkjU8pdVCYRb3h6rzTTdDEm5jc++s6Ut7jHcyLqBwj5PEywHs7g7n6fo0enKDVyE/l4t/3Ydwix+qrYFfDGfv975m89MrB+e3JTHa4abbH1fWXxjhVEPsNkDAqsni+j6wgZBi2MGK6D7YywR9sTMjVqeWX+8vh5lMvt4hGhabOi1UNek46A3073khXFfmp8M1Z11pHauKhQGaUUTj1Tk8hHYusFM2t20tRD4ZY/+Og2pvXmF+TL+NbfdMb/XwI9sHtx+LkVVsK7iu242B281s8ODK/xreHLhp9dIAeOvisNcJOKqebWdSoMklWBaWN8W7R6+n3pUJr6ELUrNHU0L9HsLeYHTfRmuHZ0623uXZTKxS7vqtA6z5657Q2tr5xH1Z8JvH47/XRAh4d4SwSnw6JnHVvvCK4rPWHB+pM55ninEc02wqaUxVWhaf6vPxRqb/0ydL37HdC8mJLVJYLGPpXv6G7ZTOcq+gqJNfUz97yZbh+ORkFwhtTHIsp6KEhv+ZVeoW/R76zgFVjSuW3v6RgEkiKk/bwQ5f575OFEjqWsnLIHN1qe0xSd/WxdFhm0=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ba918-4c98-49b3-773d-08d792f97bc6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 22:40:51.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //y+vIIvUlbtE3M41ASss03uN4ww2dI7kjMINVpCxJ9ulqoog+FsZudPenmhFnspdkOLKRnJtv1zwk2UbLl+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This is a RESEND of https://lkml.org/lkml/2019/11/24/115 .

Please review.

If it looks good, Sasha Levin, can you please pick it up via the
hyperv/linux.git tree, as you did last time for this driver?


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

