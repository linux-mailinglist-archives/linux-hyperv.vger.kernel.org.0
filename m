Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC9138BDA
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgAMGcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 01:32:31 -0500
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:59839
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAMGcb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 01:32:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbKoZoikGySRH2odw9atDPo5XvEuoXLRpw09rMTUXvovmf3dEzigg3B4bn1JkAJPQQ8efn8ekJ2iudj5zIMFMAjuE2q3c1Ih13zctaF9ASu7VfGbXQV6NFaC8x+dWDcLmpQwBTvqO1yhbggThIrQSKIuI43ffeMaUCrGBKA8R17z+WxVquJ10P3TyNAaBXSnNi1d+fiFBGCrV3w9SEMBiOQMs3qWg8Uvdb5zJGMog2gcVY6XUaS1lLfS2z495n5jsQS+l8ROM4VXPpj285EZap3hs5Y14bxowZY+TGXt2/Ggeas1aj7+Uc5coim+v3DwHKY6KL8WhlmQBdWDMxX0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luiZ7kOgHIVxFovFJ9p89+8qP+GAR6hKj9C4JOQTJA8=;
 b=FrMrb7A4W92lNkDTs3Uy1WEjZ5I/fuB228hQ7z/TpUZA3i+51uSvrhVCfllycNYVcoiGMPXDD9OTsfaSM1eZoLkNfVBL1o6AzJSsIHfB53wggWKKYIhvc0IjUvSjRMrvpUuqdslwK+CmPvYhkJXuBnZlvOqf70v20kKP8VXlzXXYLgTZ587b/XuMNIDRH9776n3Ie1PzK6pKEW/gO3bSZ0ZZaGPiH2dztbijWmWvifhHRqmZRFJddyd934NttjdesUMqBitHVOaIFi8B2ADqnMFw9zFzYQ4MSpFOHeQJPv7QBJyZBZqPrxPWk8ICCPK5sXu0NNp6k3VQJ9R5WqCOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luiZ7kOgHIVxFovFJ9p89+8qP+GAR6hKj9C4JOQTJA8=;
 b=FwxWd66YtU7VS5eEBm1dxC5TbXcJCbwtwrGOHebFrPRbWRNvu3hU9lltVAR8EVGNYgTA9clHIc4d0R10nf9yD3FQc/TDwauEKGpI8xnjZNz+TVrFdwF5C7i07gEZGL8l1EGK85Ma+GTjMfzRqYuFaDfYx3cmg9ACdP4Id3b/UTc=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0324.APCP153.PROD.OUTLOOK.COM (52.132.237.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.2; Mon, 13 Jan 2020 06:32:23 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 06:32:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Index: AdXJ2zJbjzKVVIRATtCsfhHYStD+UQ==
Date:   Mon, 13 Jan 2020 06:32:22 +0000
Message-ID: <HK0P153MB0148B7D12E62DD559A5D2B9DBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:32:21.2927925Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4db3c986-4f1e-4eb3-944c-2fd501d37986;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:fa69:ae29:32b9:aa46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 252343ae-8088-4950-1272-08d797f25964
x-ms-traffictypediagnostic: HK0P153MB0324:|HK0P153MB0324:|HK0P153MB0324:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB032419C705BFFEB95C20C4F6BF350@HK0P153MB0324.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(5660300002)(10290500003)(33656002)(186003)(30864003)(7696005)(86362001)(2906002)(6506007)(52536014)(478600001)(81166006)(81156014)(110136005)(316002)(76116006)(8936002)(9686003)(64756008)(55016002)(8990500004)(66556008)(66476007)(66946007)(66446008)(8676002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0324;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKYL5y34IgIKVvANQgI/K0wM6z7sKa1CoCX/lJGMlCzVwPfyia4GXQt4SzlZ5S29i8BUQjKNiYKn8GI9P27xVbgf1iNsw+V2wbGcFsf7riGnSQxzSeoG5qL/b53VkF7bg6e3wPiHgsucvn+Hwl0bOkqfOgHmzmwx7ArrL3BdZ8LedpaAiuSTmBGAX7tOCjSCeO4dHbsbensB16ti5bfZoYg1A1VVSrgQNYy6t9U4Vp4khefdka11VRQuvYDqG/tcFNn+B4+l36eggiIz3nEsUqYSBpD9PRQKy+RxXktnMvtbLRIWwPPhUjkRkWPoocuQTJMEWQTwXfgroJ1F8XL53n/rceRHRk8zIVm+xPY1JVHiKOJpnRQJ+0EeNPGw4MFaZ4FwK93lKWye6dm+z9/c9RSmssqp1OSEWQj71jDEDgrlmAxy3u5SaeBWxYigrG1l
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252343ae-8088-4950-1272-08d797f25964
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:32:22.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oc5DdUmk6jBK5FzmGumuZd8wzRyItY2k0ztamRk2pboT3O/hMW8JQOwjav7iSJNnFcp5MdxJJAYgABVAWyXWjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0324
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Add util_pre_suspend() and util_pre_resume() for some hv_utils devices
(e.g. kvp/vss/fcopy), because they need special handling before
util_suspend() calls vmbus_close().

For kvp, all the possible pending work items should be cancelled.

For vss and fcopy, extra clean-up needs to be done, i.e. fake a THAW
message for hv_vss_daemon and fake a CANCEL_FCOPY message for
hv_fcopy_daemonemon, otherwise when the VM resums back, the daemons
can end up in an inconsistent state (i.e. the file systems are
frozen but will never be thawed; the file transmitted via fcopy
may not be complete). Note: there is an extra patch for the daemons:
"Tools: hv: Reopen the devices if read() or write() returns errors",
because the hv_utils driver can not guarantee the whole transaction
finishes completely once util_suspend() starts to run (at this time,
all the userspace processes are frozen).

util_probe() disables channel->callback_event to avoid the race with
the the channel callback.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_fcopy.c     | 58 ++++++++++++++++++++++++++++++++++++-
 drivers/hv/hv_kvp.c       | 44 ++++++++++++++++++++++++++--
 drivers/hv/hv_snapshot.c  | 60 +++++++++++++++++++++++++++++++++++++--
 drivers/hv/hv_util.c      | 60 ++++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h |  6 ++++
 include/linux/hyperv.h    |  2 ++
 6 files changed, 224 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 08fa4a5de644..d63853f16356 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -346,9 +346,65 @@ int hv_fcopy_init(struct hv_util_service *srv)
 	return 0;
 }
=20
+static void hv_fcopy_cancel_work(void)
+{
+	cancel_delayed_work_sync(&fcopy_timeout_work);
+	cancel_work_sync(&fcopy_send_work);
+}
+
+int hv_fcopy_pre_suspend(void)
+{
+	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
+	struct hv_fcopy_hdr *fcopy_msg;
+
+	tasklet_disable(&channel->callback_event);
+
+	/*
+	 * Fake a CANCEL_FCOPY message to the user space daemon in case the
+	 * daemon is in the middle of copying some file. It doesn't matter if
+	 * there is already a message pending to be delivered to the user
+	 * space: we force fcopy_transaction.state to be HVUTIL_READY, so the
+	 * user space daemon's write() will fail with -EINVAL (see
+	 * fcopy_on_msg()), and the daemon will reset the device by closing and
+	 * re-opening it.
+	 */
+	fcopy_msg =3D kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
+	if (!fcopy_msg)
+		goto err;
+
+	fcopy_msg->operation =3D CANCEL_FCOPY;
+
+	hv_fcopy_cancel_work();
+
+	/* We don't care about the return value. */
+	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
+
+	kfree(fcopy_msg);
+
+	fcopy_transaction.state =3D HVUTIL_READY;
+
+	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
+
+	return 0;
+err:
+	tasklet_enable(&channel->callback_event);
+	return -ENOMEM;
+}
+
+int hv_fcopy_pre_resume(void)
+{
+	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
 void hv_fcopy_deinit(void)
 {
 	fcopy_transaction.state =3D HVUTIL_DEVICE_DYING;
-	cancel_delayed_work_sync(&fcopy_timeout_work);
+
+	hv_fcopy_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index ae7c028dc5a8..ca03f68df5d0 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -758,11 +758,51 @@ hv_kvp_init(struct hv_util_service *srv)
 	return 0;
 }
=20
-void hv_kvp_deinit(void)
+static void hv_kvp_cancel_work(void)
 {
-	kvp_transaction.state =3D HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&kvp_host_handshake_work);
 	cancel_delayed_work_sync(&kvp_timeout_work);
 	cancel_work_sync(&kvp_sendkey_work);
+}
+
+int hv_kvp_pre_suspend(void)
+{
+	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
+
+	tasklet_disable(&channel->callback_event);
+
+	/*
+	 * If there is a pending transtion, it's unnecessary to tell the host
+	 * that the tranction will fail, becasue that is implied when
+	 * util_suspend() calls vmbus_close() later.
+	 */
+	hv_kvp_cancel_work();
+
+	/*
+	 * Forece the state to READY to handle the ICMSGTYPE_NEGOTIATE message
+	 * later. The user space daemon may go out of order and its write()
+	 * may get an EINVAL error: this doesn't matter since the daemon will
+	 * reset the device by closing and re-opening the device.
+	 */
+	kvp_transaction.state =3D HVUTIL_READY;
+
+	return 0;
+}
+
+int hv_kvp_pre_resume(void)
+{
+	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
+void hv_kvp_deinit(void)
+{
+	kvp_transaction.state =3D HVUTIL_DEVICE_DYING;
+
+	hv_kvp_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 03b6454268b3..eb766ff8841b 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -229,6 +229,7 @@ static void vss_handle_request(struct work_struct *dumm=
y)
 		vss_transaction.state =3D HVUTIL_HOSTMSG_RECEIVED;
 		vss_send_op();
 		return;
+
 	case VSS_OP_GET_DM_INFO:
 		vss_transaction.msg->dm_info.flags =3D 0;
 		break;
@@ -379,10 +380,65 @@ hv_vss_init(struct hv_util_service *srv)
 	return 0;
 }
=20
-void hv_vss_deinit(void)
+static void hv_vss_cancel_work(void)
 {
-	vss_transaction.state =3D HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&vss_timeout_work);
 	cancel_work_sync(&vss_handle_request_work);
+}
+
+int hv_vss_pre_suspend(void)
+{
+	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
+	struct hv_vss_msg *vss_msg;
+
+	tasklet_disable(&channel->callback_event);
+
+	/*
+	 * Fake a THAW message for the user space daemon in case the daemon
+	 * has frozen the file systems. It doesn't matter if there is already
+	 * a message pending to be delivered to the user space: we force
+	 * vss_transaction.state to be HVUTIL_READY, so the user space daemon's
+	 * write() will fail with -EINVAL (see vss_on_msg()), and the daemon
+	 * will reset the device by closing and re-opening it.
+	 */
+	vss_msg =3D kzalloc(sizeof(*vss_msg), GFP_KERNEL);
+	if (!vss_msg)
+		goto err;
+
+	vss_msg->vss_hdr.operation =3D VSS_OP_THAW;
+
+	/* Cancel any possible pending work. */
+	hv_vss_cancel_work();
+
+	/* We don't care about the return value. */
+	hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
+
+	kfree(vss_msg);
+
+	vss_transaction.state =3D HVUTIL_READY;
+
+	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
+
+	return 0;
+err:
+	tasklet_enable(&channel->callback_event);
+	return -ENOMEM;
+}
+
+int hv_vss_pre_resume(void)
+{
+	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
+
+	tasklet_enable(&channel->callback_event);
+
+	return 0;
+}
+
+void hv_vss_deinit(void)
+{
+	vss_transaction.state =3D HVUTIL_DEVICE_DYING;
+
+	hv_vss_cancel_work();
+
 	hvutil_transport_destroy(hvt);
 }
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index d5216af62788..255faa3d657c 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -123,12 +123,14 @@ static struct hv_util_service util_shutdown =3D {
 };
=20
 static int hv_timesync_init(struct hv_util_service *srv);
+static int hv_timesync_pre_suspend(void);
 static void hv_timesync_deinit(void);
=20
 static void timesync_onchannelcallback(void *context);
 static struct hv_util_service util_timesynch =3D {
 	.util_cb =3D timesync_onchannelcallback,
 	.util_init =3D hv_timesync_init,
+	.util_pre_suspend =3D hv_timesync_pre_suspend,
 	.util_deinit =3D hv_timesync_deinit,
 };
=20
@@ -140,18 +142,24 @@ static struct hv_util_service util_heartbeat =3D {
 static struct hv_util_service util_kvp =3D {
 	.util_cb =3D hv_kvp_onchannelcallback,
 	.util_init =3D hv_kvp_init,
+	.util_pre_suspend =3D hv_kvp_pre_suspend,
+	.util_pre_resume =3D hv_kvp_pre_resume,
 	.util_deinit =3D hv_kvp_deinit,
 };
=20
 static struct hv_util_service util_vss =3D {
 	.util_cb =3D hv_vss_onchannelcallback,
 	.util_init =3D hv_vss_init,
+	.util_pre_suspend =3D hv_vss_pre_suspend,
+	.util_pre_resume =3D hv_vss_pre_resume,
 	.util_deinit =3D hv_vss_deinit,
 };
=20
 static struct hv_util_service util_fcopy =3D {
 	.util_cb =3D hv_fcopy_onchannelcallback,
 	.util_init =3D hv_fcopy_init,
+	.util_pre_suspend =3D hv_fcopy_pre_suspend,
+	.util_pre_resume =3D hv_fcopy_pre_resume,
 	.util_deinit =3D hv_fcopy_deinit,
 };
=20
@@ -512,6 +520,41 @@ static int util_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int util_suspend(struct hv_device *dev)
+{
+	struct hv_util_service *srv =3D hv_get_drvdata(dev);
+	int ret =3D 0;
+
+	if (srv->util_pre_suspend) {
+		ret =3D srv->util_pre_suspend();
+
+		if (ret)
+			return ret;
+	}
+
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int util_resume(struct hv_device *dev)
+{
+	struct hv_util_service *srv =3D hv_get_drvdata(dev);
+	int ret =3D 0;
+
+	if (srv->util_pre_resume) {
+		ret =3D srv->util_pre_resume();
+
+		if (ret)
+			return ret;
+	}
+
+	ret =3D vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
+			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
+			 dev->channel);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Shutdown guid */
 	{ HV_SHUTDOWN_GUID,
@@ -548,6 +591,8 @@ static  struct hv_driver util_drv =3D {
 	.id_table =3D id_table,
 	.probe =3D  util_probe,
 	.remove =3D  util_remove,
+	.suspend =3D util_suspend,
+	.resume =3D  util_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
@@ -617,11 +662,24 @@ static int hv_timesync_init(struct hv_util_service *s=
rv)
 	return 0;
 }
=20
+static void hv_timesync_cancel_work(void)
+{
+	cancel_work_sync(&adj_time_work);
+}
+
+static int hv_timesync_pre_suspend(void)
+{
+	hv_timesync_cancel_work();
+
+	return 0;
+}
+
 static void hv_timesync_deinit(void)
 {
 	if (hv_ptp_clock)
 		ptp_clock_unregister(hv_ptp_clock);
-	cancel_work_sync(&adj_time_work);
+
+	hv_timesync_cancel_work();
 }
=20
 static int __init init_hyperv_utils(void)
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 20edcfd3b96c..f5fa3b3c9baf 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -352,14 +352,20 @@ void vmbus_on_msg_dpc(unsigned long data);
=20
 int hv_kvp_init(struct hv_util_service *srv);
 void hv_kvp_deinit(void);
+int hv_kvp_pre_suspend(void);
+int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
=20
 int hv_vss_init(struct hv_util_service *srv);
 void hv_vss_deinit(void);
+int hv_vss_pre_suspend(void);
+int hv_vss_pre_resume(void);
 void hv_vss_onchannelcallback(void *context);
=20
 int hv_fcopy_init(struct hv_util_service *srv);
 void hv_fcopy_deinit(void);
+int hv_fcopy_pre_suspend(void);
+int hv_fcopy_pre_resume(void);
 void hv_fcopy_onchannelcallback(void *context);
 void vmbus_initiate_unload(bool crash);
=20
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 41c58011431e..692c89ccf5df 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1435,6 +1435,8 @@ struct hv_util_service {
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
 	void (*util_deinit)(void);
+	int (*util_pre_suspend)(void);
+	int (*util_pre_resume)(void);
 };
=20
 struct vmbuspipe_hdr {
--=20
2.19.1

