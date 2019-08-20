Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C99953D0
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfHTBwP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:15 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729052AbfHTBwO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbbYkb+iGDMffidJYj2FpHTEFurTZ/1sXreWOTF6FyaF1igMzV4x5qiXql0B/mtw5yPCp5rH0IwYDQTHCnJBS+S4JfQPXoa5qC65HO/eQxXFF6hDDe8uxaljhkoWWAimYc/6E+jneMmvaE6K5kS7nav5exfIlJjOytM0PZ7E6mt6I/qTBBbW7Axve39dnw3hFMz6kIE3JWyNUAANAjdHzsr3FR3paTbkSb5IT95ZUEpwHdu+UxS9ylawbaCuXOGi+yXAd2fwcHJYosi0DyJsY+jByYMZ56BeKjI3qnLzTjCAzWJ5KOutzyDOe7J17Ry1+06m1/11htdKgL1FufCvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nv1s4C0f7825+HegiUiIHEgpWzu17OFkXLKemsvU0M=;
 b=DEmsiSrYbfeURM1J/0qvDNA/Znj1qde7DG5LvG4Dpzg0nPfadkGVLJwqEYTxSOwyAxXlA7MtkeHGpiuL/6zr17fC+pGD/p/NJPgSVJ0/ZyafBgT1N+ZBDUBqrRiWp1iGuqnKJ6jA/FD9cJHBsVZ5EL22RkdL/meTpj4aYAjZDkU9V2/MNyUS3C1rG6XKEiv/FYNmmrHa9QudxJb2BZVVwCJnCBy1/5J2jVDLPEXkqtM59HT/TIQxEruNDiLcpYquYGyN9htrKvKiCtZJqCb+n6WbvJ+xGPgprbN4YeUNPjlK8tMTBIIloL/NZMZO4uE98zrTBQPwYATXdNo85j2MWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Nv1s4C0f7825+HegiUiIHEgpWzu17OFkXLKemsvU0M=;
 b=XyI/l3UjQc7Mcu3B5bkyHaNoJboNdRq46QXTQRR+rOkjiRs2XNeM+vG5ySOXBsnqHSGovGRq67EOmVZDuHWZdbuP1V+z+pd72GkHwM1hq1A75inuMiQmgPP+ghyhuiLbql7RMRkJKqZxE3+vUZwQu9HHxtnBRPzhyu7VAHuQ/CI=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:08 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Topic: [PATCH v3 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVVvnf0xPU+Om7L0SScBvoM7ZBOg==
Date:   Tue, 20 Aug 2019 01:52:08 +0000
Message-ID: <1566265863-21252-12-git-send-email-decui@microsoft.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0056.namprd21.prod.outlook.com
 (2603:10b6:300:db::18) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 492ebbee-ba65-41f4-4d66-08d72511024c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11332D560471BDD7081A542DBFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(15650500001)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1KGzWTsKi5KuNGKAOzDiXD7xE//5q4yReAngJH7ynl0/g+t4vuM4WGosnyk8eUnqPQVd/kwOWxY9OSFcDTrcjwcQpocZmVXy5uboZXiy7dM8m8BmJU0rZXX7hpS+aA6nflkgsTmk2Kd0yi/7LJ/CDcg31yyUo9AEh9yCAAwq0LjMBLx0GjHuVRXgCkcAcRMkGuiOUP8QvSrvldb96ukRpwntjRQbz6LyNApvdkJk3+kNiE4IOye3G9TDxcqDC6vVyYQURhGt2mtQfB8/HO0Ny9UU3HfQ8ZfxiO6nDwNxmYE8+f9bcsnfD8LkwcSK3iQsGQwdfAHlVIxdFeqFpLTrV8yxDHQrh/ZQuB13piDMky1Iarrs943O0d7pFIxpOej0S4J1qX6lPymBb/UQRZpZEO7sMO6jLqNqdJqLe1JOpSw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ebbee-ba65-41f4-4d66-08d72511024c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:08.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPVLW/MP6Z9KV7qdzQAnrQR10kE3ya/ZNkhTXOhhvi39F6mSRYldY6S1luzj9DkKlPAwvZsgdTAoDND4jZbMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Before suspend, Linux must make sure all the hv_sock channels have been
properly cleaned up, because a hv_sock connection can not persist across
hibernation, and the user-space app must be properly notified of the
state change of the connection.

Before suspend, Linux also must make sure all the sub-channels have been
destroyed, i.e. the related channel structs of the sub-channels must be
properly removed, otherwise they would cause a conflict when the
sub-channels are recreated upon resume.

Add a counter to track such channels, and vmbus_bus_suspend() should wait
for the counter to drop to zero.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 28 ++++++++++++++++++++++++++++
 drivers/hv/connection.c   |  3 +++
 drivers/hv/hyperv_vmbus.h | 12 ++++++++++++
 drivers/hv/vmbus_drv.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f7a1184..8491d1b 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -499,6 +499,8 @@ static void vmbus_add_channel_work(struct work_struct *=
work)
 	return;
=20
 err_deq_chan:
+	WARN_ON_ONCE(1);
+
 	mutex_lock(&vmbus_connection.channel_mutex);
=20
 	/*
@@ -545,6 +547,10 @@ static void vmbus_process_offer(struct vmbus_channel *=
newchannel)
=20
 	mutex_lock(&vmbus_connection.channel_mutex);
=20
+	/* Remember the channels that should be cleaned up upon suspend. */
+	if (is_hvsock_channel(newchannel) || is_sub_channel(newchannel))
+		atomic_inc(&vmbus_connection.nr_chan_close_on_suspend);
+
 	/*
 	 * Now that we have acquired the channel_mutex,
 	 * we can release the potentially racing rescind thread.
@@ -915,6 +921,16 @@ static void vmbus_onoffer(struct vmbus_channel_message=
_header *hdr)
 	vmbus_process_offer(newchannel);
 }
=20
+static void check_ready_for_suspend_event(void)
+{
+	/*
+	 * If all the sub-channels or hv_sock channels have been cleaned up,
+	 * then it's safe to suspend.
+	 */
+	if (atomic_dec_and_test(&vmbus_connection.nr_chan_close_on_suspend))
+		complete(&vmbus_connection.ready_for_suspend_event);
+}
+
 /*
  * vmbus_onoffer_rescind - Rescind offer handler.
  *
@@ -925,6 +941,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_=
message_header *hdr)
 	struct vmbus_channel_rescind_offer *rescind;
 	struct vmbus_channel *channel;
 	struct device *dev;
+	bool clean_up_chan_for_suspend;
=20
 	rescind =3D (struct vmbus_channel_rescind_offer *)hdr;
=20
@@ -964,6 +981,8 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_=
message_header *hdr)
 		return;
 	}
=20
+	clean_up_chan_for_suspend =3D is_hvsock_channel(channel) ||
+				    is_sub_channel(channel);
 	/*
 	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
 	 * should make sure the channel callback is not running any more.
@@ -989,6 +1008,10 @@ static void vmbus_onoffer_rescind(struct vmbus_channe=
l_message_header *hdr)
 	if (channel->device_obj) {
 		if (channel->chn_rescind_callback) {
 			channel->chn_rescind_callback(channel);
+
+			if (clean_up_chan_for_suspend)
+				check_ready_for_suspend_event();
+
 			return;
 		}
 		/*
@@ -1021,6 +1044,11 @@ static void vmbus_onoffer_rescind(struct vmbus_chann=
el_message_header *hdr)
 		}
 		mutex_unlock(&vmbus_connection.channel_mutex);
 	}
+
+	/* The "channel" may have been freed. Do not access it any longer. */
+
+	if (clean_up_chan_for_suspend)
+		check_ready_for_suspend_event();
 }
=20
 void vmbus_hvsock_device_unregister(struct vmbus_channel *channel)
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 701d9a8..f15d3115 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -26,6 +26,9 @@
 struct vmbus_connection vmbus_connection =3D {
 	.conn_state		=3D DISCONNECTED,
 	.next_gpadl_handle	=3D ATOMIC_INIT(0xE1E10),
+
+	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
+				  vmbus_connection.ready_for_suspend_event),
 };
 EXPORT_SYMBOL_GPL(vmbus_connection);
=20
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 4610277..9f96e23 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -258,6 +258,18 @@ struct vmbus_connection {
 	struct workqueue_struct *work_queue;
 	struct workqueue_struct *handle_primary_chan_wq;
 	struct workqueue_struct *handle_sub_chan_wq;
+
+	/*
+	 * The number of sub-channels and hv_sock channels that should be
+	 * cleaned up upon suspend: sub-channels will be re-created upon
+	 * resume, and hv_sock channels should not survive suspend.
+	 */
+	atomic_t nr_chan_close_on_suspend;
+	/*
+	 * vmbus_bus_suspend() waits for "nr_chan_close_on_suspend" to
+	 * drop to zero.
+	 */
+	struct completion ready_for_suspend_event;
 };
=20
=20
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2bea669..0507157 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2127,7 +2127,8 @@ static int vmbus_acpi_add(struct acpi_device *device)
=20
 static int vmbus_bus_suspend(struct device *dev)
 {
-	struct vmbus_channel *channel;
+	struct vmbus_channel *channel, *sc;
+	unsigned long flags;
=20
 	while (atomic_read(&vmbus_connection.offer_in_progress) !=3D 0) {
 		/*
@@ -2146,6 +2147,41 @@ static int vmbus_bus_suspend(struct device *dev)
 	}
 	mutex_unlock(&vmbus_connection.channel_mutex);
=20
+	/*
+	 * Wait until all the sub-channels and hv_sock channels have been
+	 * cleaned up. Sub-channels should be destroyed upon suspend, otherwise
+	 * they would conflict with the new sub-channels that will be created
+	 * in the resume path. hv_sock channels should also be destroyed, but
+	 * a hv_sock channel of an established hv_sock connection can not be
+	 * really destroyed since it may still be referenced by the userspace
+	 * application, so we just force the hv_sock channel to be rescinded
+	 * by vmbus_force_channel_rescinded(), and the userspace application
+	 * will thoroughly destroy the channel after hibernation.
+	 */
+	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
+		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (is_hvsock_channel(channel)) {
+			if (!channel->rescind) {
+				pr_err("hv_sock channel not rescinded!\n");
+				WARN_ON_ONCE(1);
+			}
+			continue;
+		}
+
+		spin_lock_irqsave(&channel->lock, flags);
+		list_for_each_entry(sc, &channel->sc_list, sc_list) {
+			pr_err("Sub-channel not deleted!\n");
+			WARN_ON_ONCE(1);
+		}
+		spin_unlock_irqrestore(&channel->lock, flags);
+	}
+
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
 	vmbus_initiate_unload(false);
=20
 	vmbus_connection.conn_state =3D DISCONNECTED;
@@ -2186,6 +2222,9 @@ static int vmbus_bus_resume(struct device *dev)
=20
 	vmbus_request_offers();
=20
+	/* Reset the event for the next suspend. */
+	reinit_completion(&vmbus_connection.ready_for_suspend_event);
+
 	return 0;
 }
=20
--=20
1.8.3.1

