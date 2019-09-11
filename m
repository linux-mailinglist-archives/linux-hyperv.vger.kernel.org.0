Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88633B05F3
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfIKXgC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:36:02 -0400
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:46365
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXgC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:36:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVN5cyqoZSpKwq8zpvuHQHtfdi3v6KCgrim7CxZXhyRVH6gr3DLO1MKQe+HyZbp+mb9+/afqbGjr8EJ5gtQfJHSZTdGL05gDH9bVq3Gry9Cl4hT1gwKeclvo4OdknATQnTBiuXlncL33CliRvG1PlJ2Mc6OGH5dB50NJaoSspTQeQOQu7Y6Zv/gPDs8e+kjqXOvgSWTtRQBOtexNccrv4IqBD/E8WoHpM5U9G5poFIb95qYVIWtRCPMP/k33FZa29sI5x7mGOAk/i66rJlkUXLeYK0KeYo6xvCjuFJKQEqeVrHrKKWDaYPnmYNMxnO0XSYN2XW3OXUxrpfocFfcilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGlLQSaKbLPu/mvZP8n0Hme4O3hwQ22jtSmdZ991FI8=;
 b=oV3E4KRhlOfHEZplNzjDtH1ScgJ7wonOd6/MJwO3Yfs4B/YRz0K/jRWXqT3s3Dz5Ds0izS4gnhKB/CpBua3kaBPUfFT/eEurO4y1jG0K3IMCO/apQo1xGnjW67tClgtMhePlTFNLyIl7HptKQLv6t5VdRd8/SADZR/FMnFqy+yUX7Pk0Z1FyksGRM3Ks4K/9P24UMI4kuLDDi1yys4sBjGYN+ZCcDK9u4l/j7ZrlVgZ1Xnt+2n1B6FvgaNRoX9MutoXmjbxg+s8eOFI6cAHhYFCPejMt+HHs/QhwbfhXV2tvz51dTEFP+efP9EtjkwsyP0iwwKNvCzmBlfIdYwSVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGlLQSaKbLPu/mvZP8n0Hme4O3hwQ22jtSmdZ991FI8=;
 b=DXvxMVEHSG1VNO+TUcZxBuYcBV0xY+yja5edBC3GaQxMKBwAJMOeDunfWBU9/nu+tpn5eZVYxfP5zGl9sQI9Ekomn6u7yCAmf+lgweRqRRGv5ZMJfSeDaBfo6Bzp36UzoalU6XgTrLLlr7hyfxaS71sKPNDYoY1QEi01pr5Z70o=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:36:00 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:36:00 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Topic: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Index: AQHVaPmqZINIgyUXxE2R4/KRfEe4og==
Date:   Wed, 11 Sep 2019 23:35:59 +0000
Message-ID: <1568244952-66716-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0021.namprd12.prod.outlook.com
 (2603:10b6:301:4a::31) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6320e56e-a5b5-4e38-5e03-08d73710ccc8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB090936E78FF488D49B4A02D7BFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(3450700001)(6512007)(6306002)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(966005)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HQhFXQLUGKA7uG7ShdNtumihTRKx82K/OLqm9Xx30/TshE35JN1LlVsINflcxO3i9FiQo93rEw/raamUOciN3srai90sk8lzzpbrXqlvhWPhX227MvNIj2TK4nZDXA8+ilqMt2lSScnTc4F/BhWEWxmA/Z14t5GkNYgF6ChMs0yvSE1tZGF8EFmQ5FSiWVamXwXrwYYwgk8VTU5c5wVdqpaIAMsj6O+20d7IZ0Up6l8fVL5zxkrkH33tObtbHp67QFTskL+gCFQByWTxaph8g2Q7RuTWgp6wMB2WzlR7Xxc3jUiyko6fgMR7DqW+bBV4cZ9aUr4JoWhwuIQwt7jqzf3A8pdJR6az1Ft09hq6eFM2/nC4XMT108p5M+oNV3Y1+OsAk1WKX059flGUmBaA0I0UKiPXqUIak3HkvZjS3Tw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6320e56e-a5b5-4e38-5e03-08d73710ccc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:35:59.4879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgCtwSTZoGgJQY8YCz/wQ1l92+vMf9NK2mKNgItgtXjDgA0FyXpXdXWMN8ZMBsWfJGZBSfEC2t1a3xteovau/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We need mousevsc_pm_notify() to make sure the pm_wakeup_hard_event() call
does not prevent the system from entering hibernation: the hibernation
is a relatively long process, which can be aborted by the call
pm_wakeup_hard_event(), which is invoked upon mouse events.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
input subsystem's tree.

Hi Jiri, Benjamin, can you please Ack?

 drivers/hid/hid-hyperv.c | 71 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index cc5b09b8..e798740 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -12,6 +12,7 @@
 #include <linux/hid.h>
 #include <linux/hiddev.h>
 #include <linux/hyperv.h>
+#include <linux/suspend.h>
=20
=20
 struct hv_input_dev_info {
@@ -150,6 +151,9 @@ struct mousevsc_dev {
 	struct hv_input_dev_info hid_dev_info;
 	struct hid_device       *hid_device;
 	u8			input_buf[HID_MAX_BUFFER_SIZE];
+
+	struct notifier_block	pm_nb;
+	bool			hibernation_in_progress;
 };
=20
=20
@@ -192,6 +196,9 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 	if (desc->bLength =3D=3D 0)
 		goto cleanup;
=20
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->hid_desc !=3D NULL)
+		kfree(input_device->hid_desc);
 	input_device->hid_desc =3D kmemdup(desc, desc->bLength, GFP_ATOMIC);
=20
 	if (!input_device->hid_desc)
@@ -203,6 +210,9 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 		goto cleanup;
 	}
=20
+	/* The pointer is not NULL when we resume from hibernation */
+	if (input_device->report_desc !=3D NULL)
+		kfree(input_device->report_desc);
 	input_device->report_desc =3D kzalloc(input_device->report_desc_size,
 					  GFP_ATOMIC);
=20
@@ -243,7 +253,7 @@ static void mousevsc_on_receive_device_info(struct mous=
evsc_dev *input_device,
 }
=20
 static void mousevsc_on_receive(struct hv_device *device,
-				struct vmpacket_descriptor *packet)
+				const struct vmpacket_descriptor *packet)
 {
 	struct pipe_prt_msg *pipe_msg;
 	struct synthhid_msg *hid_msg;
@@ -301,7 +311,8 @@ static void mousevsc_on_receive(struct hv_device *devic=
e,
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
=20
-		pm_wakeup_hard_event(&input_dev->device->device);
+		if (!input_dev->hibernation_in_progress)
+			pm_wakeup_hard_event(&input_dev->device->device);
=20
 		break;
 	default:
@@ -378,6 +389,8 @@ static int mousevsc_connect_to_vsp(struct hv_device *de=
vice)
 	struct mousevsc_prt_msg *request;
 	struct mousevsc_prt_msg *response;
=20
+	reinit_completion(&input_dev->wait_event);
+
 	request =3D &input_dev->protocol_req;
 	memset(request, 0, sizeof(struct mousevsc_prt_msg));
=20
@@ -475,6 +488,29 @@ static int mousevsc_hid_raw_request(struct hid_device =
*hid,
=20
 static struct hid_driver mousevsc_hid_driver;
=20
+static int mousevsc_pm_notify(struct notifier_block *nb,
+			      unsigned long val, void *ign)
+{
+	struct mousevsc_dev *input_dev;
+
+	input_dev =3D container_of(nb, struct mousevsc_dev, pm_nb);
+
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		input_dev->hibernation_in_progress =3D true;
+		return NOTIFY_OK;
+
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		input_dev->hibernation_in_progress =3D false;
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -549,6 +585,9 @@ static int mousevsc_probe(struct hv_device *device,
 	input_dev->connected =3D true;
 	input_dev->init_complete =3D true;
=20
+	input_dev->pm_nb.notifier_call =3D mousevsc_pm_notify;
+	register_pm_notifier(&input_dev->pm_nb);
+
 	return ret;
=20
 probe_err2:
@@ -568,6 +607,8 @@ static int mousevsc_remove(struct hv_device *dev)
 {
 	struct mousevsc_dev *input_dev =3D hv_get_drvdata(dev);
=20
+	unregister_pm_notifier(&input_dev->pm_nb);
+
 	device_init_wakeup(&dev->device, false);
 	vmbus_close(dev->channel);
 	hid_hw_stop(input_dev->hid_device);
@@ -577,6 +618,30 @@ static int mousevsc_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int mousevsc_suspend(struct hv_device *dev)
+{
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int mousevsc_resume(struct hv_device *dev)
+{
+	int ret;
+
+	ret =3D vmbus_open(dev->channel,
+			 INPUTVSC_SEND_RING_BUFFER_SIZE,
+			 INPUTVSC_RECV_RING_BUFFER_SIZE,
+			 NULL, 0,
+			 mousevsc_on_channel_callback,
+			 dev);
+	if (ret)
+		return ret;
+
+	ret =3D mousevsc_connect_to_vsp(dev);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Mouse guid */
 	{ HV_MOUSE_GUID, },
@@ -590,6 +655,8 @@ static int mousevsc_remove(struct hv_device *dev)
 	.id_table =3D id_table,
 	.probe =3D mousevsc_probe,
 	.remove =3D mousevsc_remove,
+	.suspend =3D mousevsc_suspend,
+	.resume =3D mousevsc_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
--=20
1.8.3.1

