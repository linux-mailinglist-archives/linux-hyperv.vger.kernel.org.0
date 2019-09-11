Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9CB05F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfIKXgZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:36:25 -0400
Received: from mail-eopbgr770109.outbound.protection.outlook.com ([40.107.77.109]:49024
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXgY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGWGYcSmj1kFy8eA9TUOM0Aqrm7IvPgTrhMUr4rq/rxj6Nn2fG5EUwaCrRXSMOEI1DyGaHpHAJvNqD+8982sMFjcu0WMmCyvOp9Bam9hV5TAWz9cn/3VG3uy60adi9Qao/KtML7WaQ6T33TSmuT+ouaqLu9DBU3y2/7KTRGzSjPUVqOO63OSkr86cIRxtRrADgB3keEKxJC5/gYsU4I20LDWvWF5sbCh49oB7aYri6PixGRB7mhsMt6+7gy5DSE+oOmfUoDn22yJSa/uY4YkM8PX5tKMInYu+t/vytQmtb4LnWUeJFVce4eosy0EnRg3L1R6cSC3OykfV/ySI/fAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tjlU0OljVrgHztQJYfWZNuO5bT/qBl3QcXYAUNV/Dk=;
 b=OebsIpBsAH4iSjz8pZ4HCdbMq9QTwVzGeLZPordtBZPfVRW362sO1hVCOpXCWkfZ6X3HjWPb6xhCYjXImPnhIvGhfcqADD1uB3Aw1Lv79bqJFQIvrNryvQ6T0LxERUrOb6cjrAkedy2Eod3OcLtdSqWH/2Gs4IhpQbSuBtSPm6+U1I3t03W7GF8aPgj1Eip4zUZBJPbrj7/MiPaE7/+JFQJgu24mqM6VSfcXqCGKMFppWNltThi9c1QVUZ7yx2aQJFE8+ngKR8tiM62/RBmFuT9PhxlY5g1eClo+Afu48IuJX1XDEnIVq3r3kxF/PNppNhnl9Siif9cItMc5baDSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tjlU0OljVrgHztQJYfWZNuO5bT/qBl3QcXYAUNV/Dk=;
 b=CVgtYY+gUSOKY2AXjmDKlXGqwq3L4qw7G5M6shVsl2drMO04/PMIfuNvgNk2sRX2GLTqHN3vs8Y1rrEw9v1alWT4mbe5x4PhdzO22f8z6CGaeGAo6Ltf0PCz//kt19gpx/WQiIQ6UA+/x0EN0d48UeuGAvnsXXCFVJc2qEk1IDQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:36:20 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:36:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Topic: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Thread-Index: AQHVaPm39kQxgd5AR02N8GdQied+pA==
Date:   Wed, 11 Sep 2019 23:36:20 +0000
Message-ID: <1568244975-66795-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0065.namprd21.prod.outlook.com (10.172.93.155) To
 SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22c4f6c3-bbff-427d-18cf-08d73710d974
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB0909BD4BC84B743D2E72434DBFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(3450700001)(6512007)(6306002)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(966005)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jim8W07laIGi/r8ctVhsMWg3ome5lJoSZGqcFYxPP6RCZv7k0ZYD+uzpKF4qitPyqRJb6id1RT3J6All6zUk3JUZepxTWCrrJ8YRD5J76B1P15bLrpAHGx4O6GakR7GlqLi3XxoQLv+Rz7a/Ycis+DsgIGjlqSZz1k7OAXH4Qyn6Z8nfZSuHTTz8lZMBi9TXVHnTwa1YH0xPJg5BB9Xg7u6jVn9Jsq72B9l/BKE/Wd2LHiltUgbz5lOhHpZfVVMNZxmAWUp3D5hplBwmxc0eIIYnYOItTqUDnrcEYr179vfgAJcbMz+f4yn6pUf7ONUxMUjjyleJP+eoep4KhQnsjUk0khpD0Gfme4XYSSFLX75XonOsphdRjfVpuz9AhJcl8YUWjoKHYDElKOOLOJNwqepjwM5zPp/kV3HMJ7jTylk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c4f6c3-bbff-427d-18cf-08d73710d974
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:36:20.6181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjwdcGbEXvp4reNWaXVpCME61SOU4FisNki3pc1gZgnCYka1cgVz+q2rcntEOiKLeJqzoxvJiz77TLgHyJxomQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We need hv_kbd_pm_notify() to make sure the pm_wakeup_hard_event() call
does not prevent the system from entering hibernation: the hibernation
is a relatively long process, which can be aborted by the call
pm_wakeup_hard_event(), which is invoked upon keyboard events.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
input subsystemi's tree.

Hi Dmitry, can you please Ack?

 drivers/input/serio/hyperv-keyboard.c | 68 +++++++++++++++++++++++++++++++=
+---
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hy=
perv-keyboard.c
index 88ae7c2..277dc4c 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -10,6 +10,7 @@
 #include <linux/hyperv.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
=20
 /*
  * Current version 1.0
@@ -95,6 +96,9 @@ struct hv_kbd_dev {
 	struct completion wait_event;
 	spinlock_t lock; /* protects 'started' field */
 	bool started;
+
+	struct notifier_block pm_nb;
+	bool hibernation_in_progress;
 };
=20
 static void hv_kbd_on_receive(struct hv_device *hv_dev,
@@ -168,7 +172,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		 * "echo freeze > /sys/power/state" can't really enter the
 		 * state because the Enter-UP can trigger a wakeup at once.
 		 */
-		if (!(info & IS_BREAK))
+		if (!(info & IS_BREAK) && !kbd_dev->hibernation_in_progress)
 			pm_wakeup_hard_event(&hv_dev->device);
=20
 		break;
@@ -179,10 +183,10 @@ static void hv_kbd_on_receive(struct hv_device *hv_de=
v,
 	}
 }
=20
-static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
-					  struct vmpacket_descriptor *desc,
-					  u32 bytes_recvd,
-					  u64 req_id)
+static void
+hv_kbd_handle_received_packet(struct hv_device *hv_dev,
+			      const struct vmpacket_descriptor *desc,
+			      u32 bytes_recvd, u64 req_id)
 {
 	struct synth_kbd_msg *msg;
 	u32 msg_sz;
@@ -282,6 +286,8 @@ static int hv_kbd_connect_to_vsp(struct hv_device *hv_d=
ev)
 	u32 proto_status;
 	int error;
=20
+	reinit_completion(&kbd_dev->wait_event);
+
 	request =3D &kbd_dev->protocol_req;
 	memset(request, 0, sizeof(struct synth_kbd_protocol_request));
 	request->header.type =3D __cpu_to_le32(SYNTH_KBD_PROTOCOL_REQUEST);
@@ -332,6 +338,29 @@ static void hv_kbd_stop(struct serio *serio)
 	spin_unlock_irqrestore(&kbd_dev->lock, flags);
 }
=20
+static int hv_kbd_pm_notify(struct notifier_block *nb,
+			    unsigned long val, void *ign)
+{
+	struct hv_kbd_dev *kbd_dev;
+
+	kbd_dev =3D container_of(nb, struct hv_kbd_dev, pm_nb);
+
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		kbd_dev->hibernation_in_progress =3D true;
+		return NOTIFY_OK;
+
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		kbd_dev->hibernation_in_progress =3D false;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int hv_kbd_probe(struct hv_device *hv_dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -380,6 +409,9 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
=20
 	device_init_wakeup(&hv_dev->device, true);
=20
+	kbd_dev->pm_nb.notifier_call =3D hv_kbd_pm_notify;
+	register_pm_notifier(&kbd_dev->pm_nb);
+
 	return 0;
=20
 err_close_vmbus:
@@ -394,6 +426,7 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 {
 	struct hv_kbd_dev *kbd_dev =3D hv_get_drvdata(hv_dev);
=20
+	unregister_pm_notifier(&kbd_dev->pm_nb);
 	serio_unregister_port(kbd_dev->hv_serio);
 	vmbus_close(hv_dev->channel);
 	kfree(kbd_dev);
@@ -403,6 +436,29 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	return 0;
 }
=20
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
+	ret =3D vmbus_open(hv_dev->channel,
+			 KBD_VSC_SEND_RING_BUFFER_SIZE,
+			 KBD_VSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 hv_kbd_on_channel_callback,
+			 hv_dev);
+	if (ret =3D=3D 0)
+		ret =3D hv_kbd_connect_to_vsp(hv_dev);
+
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Keyboard guid */
 	{ HV_KBD_GUID, },
@@ -416,6 +472,8 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 	.id_table =3D id_table,
 	.probe =3D hv_kbd_probe,
 	.remove =3D hv_kbd_remove,
+	.suspend =3D hv_kbd_suspend,
+	.resume =3D hv_kbd_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1

