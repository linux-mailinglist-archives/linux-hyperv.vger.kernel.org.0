Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7FB0612
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfIKXjB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:39:01 -0400
Received: from mail-eopbgr770133.outbound.protection.outlook.com ([40.107.77.133]:6560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728820AbfIKXjA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:39:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvvSm/pVM2OoC6b6oUBqHn4Tkibz1YrItJKTTiuQHKpZMLO+UmoNpWbb8frTtL7RO9z05dxS1OdKvOHvCg9QUpELJpW4Hfhfc4DLxj7T1ZBpVGusJckZD3mA7hB4s4/sSTv1TgM+bvYjPdS9x5CJpfA2ztVuPmUjuros1uKsvgG7qPzGMMLJIU0ei2MrfRffNrEdqU176dD8OjiSkIYJrsLhfDSZ6Rf7rdIkGEK1iAXcnY2yu3jtR9GVEld9wBMHPwkPYdDAq9EfKKQqS4wXY8OYy0Lp9BmhXRj0QKCwhvxpm5r7XhSvszVGvpTC7A5dJ6VH9ZFM2wkHC+SC+IJkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAIwLUHO8QOxfdn2RKHjEztHVS+gDpcR5fzG2NP3fr0=;
 b=XBbiCokBUkOnr9rVt8wpQ3CsMje6f2YDVpXgn0N4zAM9x59OHM/IQNUtjCr8zc6RC/xMfhwCC/7nhxMrzJ3OOmOvVL7yKwjAsGVTR4AnpKlr8kao8S7HnLVXxLZ8vb3AX3Xp9kkXr56RG2V0+8uQCP0IcG15Vi3IWUqAjEa9IE9nnBKgjhZ0r20tr1bZHpGjDbF6m5aSWMmdRAxZV9spSeHOQJT1kkIl+3s1S2iktrbsNDsBt33MM855rIyGZSSbDR2HiMfxtDBGQqD2OUkO01R5p+kXl1dl7zgfeEtisOqn9fAMTZhz4/sA4zALZDNsSYxpPoYKNCBx8+D20+G/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAIwLUHO8QOxfdn2RKHjEztHVS+gDpcR5fzG2NP3fr0=;
 b=HaUEEX51SD2pG5jFx10VuoI6r5ehJXpmbRgyUWoxbZ6KlPNMERnH3rEJOof23XB1LI5sGaexw2COAX3wFAFsq6iUx5fvQiqzcdRWf/mnpsaQ4WrZxvCNlinJm2Sg9n3T2eLUmy9Gw0SSHcKSTsUtDlkNZ3+G7qNbtU5jB6ezm7Q=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:38:58 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH 1/3] hv_utils: Add the support of hibernation
Thread-Index: AQHVaPoV8yavNSVWP0W715wgr0SGwA==
Date:   Wed, 11 Sep 2019 23:38:58 +0000
Message-ID: <1568245130-70712-2-git-send-email-decui@microsoft.com>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245130-70712-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b306b2ee-ab55-41ff-a962-08d737113793
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB090982840028588CE72AD4C3BFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(446003)(11346002)(3450700001)(6512007)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(76176011)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eo+d4PH/KveSBHuVHJSDg44W3eNcoBl/4/PKgfBpbV1QCGkL+3Hj7AW+qOOdmgfTyy2OfuC5JTgwnpCYcx+gpbgH545tMWFkW6x8m418rOi9S2AJI161DGt5omH1cJn2R69tjfvziMguIPQg7ymkhEtv3aY9TpXni2wCSqcggViY6VWFeDpNgFVwE2AeY3Gb2N2MYJ0LP8pUG/BMEiFbDRfSOC9d6cxz1msfzfE1YqtGCW1I7GsNoEN+mFokegN//apX6kvswjTcEGyYuyHRkwhdoxnOKUhDbOPBVYA/tGZ8kWMLN0dDqVhKs91tc7vWy/+w/nb8zEZvG63FWs85fQ3haEsdn3V/nu7HivdQLdRSyEt7ix7digr6rGfsGScZS3PF3SR3qNRdakjAOpfnc7es0uxbOHxtmi2sDzw9d9o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b306b2ee-ab55-41ff-a962-08d737113793
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:58.5278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1gkeI4pOWrNemMKc+eVAX1ZmyiSeBvkJhwWES/VPhpe288f8FkvrepnsprBtsAmi8WXItW7+2dL8qwgfYqn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On hibernation, Linux can not guarantee the host side utils operations
still succeed without any issue, so let's simply cancel the work items.
The host is supposed to retry the operations, if necessary.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_fcopy.c     |  9 ++++++++-
 drivers/hv/hv_kvp.c       | 11 +++++++++--
 drivers/hv/hv_snapshot.c  | 11 +++++++++--
 drivers/hv/hv_util.c      | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/hv/hyperv_vmbus.h |  3 +++
 include/linux/hyperv.h    |  1 +
 6 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 7e30ae0..f44df3d 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -345,9 +345,16 @@ int hv_fcopy_init(struct hv_util_service *srv)
 	return 0;
 }
=20
+void hv_fcopy_cancel_work(void)
+{
+	cancel_delayed_work_sync(&fcopy_timeout_work);
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
index 5054d11..064c384 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -757,11 +757,18 @@ static void kvp_on_reset(void)
 	return 0;
 }
=20
-void hv_kvp_deinit(void)
+void hv_kvp_cancel_work(void)
 {
-	kvp_transaction.state =3D HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&kvp_host_handshake_work);
 	cancel_delayed_work_sync(&kvp_timeout_work);
 	cancel_work_sync(&kvp_sendkey_work);
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
index 20ba95b..0eb718a 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -378,10 +378,17 @@ static void vss_on_reset(void)
 	return 0;
 }
=20
-void hv_vss_deinit(void)
+void hv_vss_cancel_work(void)
 {
-	vss_transaction.state =3D HVUTIL_DEVICE_DYING;
 	cancel_delayed_work_sync(&vss_timeout_work);
 	cancel_work_sync(&vss_handle_request_work);
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
index e32681e..039c752 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -81,12 +81,14 @@
 };
=20
 static int hv_timesync_init(struct hv_util_service *srv);
+static void hv_timesync_cancel_work(void);
 static void hv_timesync_deinit(void);
=20
 static void timesync_onchannelcallback(void *context);
 static struct hv_util_service util_timesynch =3D {
 	.util_cb =3D timesync_onchannelcallback,
 	.util_init =3D hv_timesync_init,
+	.util_cancel_work =3D hv_timesync_cancel_work,
 	.util_deinit =3D hv_timesync_deinit,
 };
=20
@@ -98,18 +100,21 @@
 static struct hv_util_service util_kvp =3D {
 	.util_cb =3D hv_kvp_onchannelcallback,
 	.util_init =3D hv_kvp_init,
+	.util_cancel_work =3D hv_kvp_cancel_work,
 	.util_deinit =3D hv_kvp_deinit,
 };
=20
 static struct hv_util_service util_vss =3D {
 	.util_cb =3D hv_vss_onchannelcallback,
 	.util_init =3D hv_vss_init,
+	.util_cancel_work =3D hv_vss_cancel_work,
 	.util_deinit =3D hv_vss_deinit,
 };
=20
 static struct hv_util_service util_fcopy =3D {
 	.util_cb =3D hv_fcopy_onchannelcallback,
 	.util_init =3D hv_fcopy_init,
+	.util_cancel_work =3D hv_fcopy_cancel_work,
 	.util_deinit =3D hv_fcopy_deinit,
 };
=20
@@ -440,6 +445,28 @@ static int util_remove(struct hv_device *dev)
 	return 0;
 }
=20
+static int util_suspend(struct hv_device *dev)
+{
+	struct hv_util_service *srv =3D hv_get_drvdata(dev);
+
+	if (srv->util_cancel_work)
+		srv->util_cancel_work();
+
+	vmbus_close(dev->channel);
+
+	return 0;
+}
+
+static int util_resume(struct hv_device *dev)
+{
+	struct hv_util_service *srv =3D hv_get_drvdata(dev);
+	int ret;
+
+	ret =3D vmbus_open(dev->channel, 4 * PAGE_SIZE, 4 * PAGE_SIZE,
+			 NULL, 0, srv->util_cb, dev->channel);
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] =3D {
 	/* Shutdown guid */
 	{ HV_SHUTDOWN_GUID,
@@ -476,6 +503,8 @@ static int util_remove(struct hv_device *dev)
 	.id_table =3D id_table,
 	.probe =3D  util_probe,
 	.remove =3D  util_remove,
+	.suspend =3D util_suspend,
+	.resume =3D  util_resume,
 	.driver =3D {
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
@@ -545,11 +574,17 @@ static int hv_timesync_init(struct hv_util_service *s=
rv)
 	return 0;
 }
=20
+static void hv_timesync_cancel_work(void)
+{
+	cancel_work_sync(&adj_time_work);
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
index f7a5f56..dc280fa 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -353,14 +353,17 @@ int vmbus_add_channel_kobj(struct hv_device *device_o=
bj,
 void vmbus_on_msg_dpc(unsigned long data);
=20
 int hv_kvp_init(struct hv_util_service *srv);
+void hv_kvp_cancel_work(void);
 void hv_kvp_deinit(void);
 void hv_kvp_onchannelcallback(void *context);
=20
 int hv_vss_init(struct hv_util_service *srv);
+void hv_vss_cancel_work(void);
 void hv_vss_deinit(void);
 void hv_vss_onchannelcallback(void *context);
=20
 int hv_fcopy_init(struct hv_util_service *srv);
+void hv_fcopy_cancel_work(void);
 void hv_fcopy_deinit(void);
 void hv_fcopy_onchannelcallback(void *context);
 void vmbus_initiate_unload(bool crash);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a3aa9e9..b4e2768 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1412,6 +1412,7 @@ struct hv_util_service {
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
 	void (*util_deinit)(void);
+	void (*util_cancel_work)(void);
 };
=20
 struct vmbuspipe_hdr {
--=20
1.8.3.1

