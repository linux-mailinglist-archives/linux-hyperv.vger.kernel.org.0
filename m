Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C03A5E88
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfICAXl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:41 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbfICAXk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXrhLj/eQwWLDV9nLaJOl1tOuJS+0+NKE8EejnOXIE5X7Fo9H2HIqOOUNaAIaMsof3PE9U80ewRHEQ3vdBH1ejcpA+9W0ni7TyNBJgY6sPxp2VFR3SMZZUNqSzTsmys78l1CmPQCBnaL0OO2bF8I1JDVkln9OxQLayWigy7G6di7qUFANGrZQKNQGme+zry5s/Yv09vlBetRbuqMLwupUJUo0AZXL7qkdWidpbJcwjNIp/lP1hqggzvjjiaVuGPPKpaxz8YrHEpIvHQfkrHRgFjFnrMJ8qOLwQ1dV0/3tP5vC7xlCG2gQOK6VB66Og34ZG5P5nIelLzY36gNTnsT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bb4A7FgXRuzXVmaWrjHX0XWoRTjqGHzYJryse8v3f0=;
 b=HL0QqYqDNrxkN2jmyFKmFDBK2w3vKjqZOvvXn43aVXkXBN7SqyrnnJ7GIiCt9tYASzU767FurvP6AM9qX/09ru2LZvxTSmhmOoyT7Z/PuLO7Sx6H4pnc0QJOMVNOMLHB9ao9BWqX0TkegLs03U1LlZIEJS7/6M/Ev32pazJJ85kJhouvrT9/W0mKwagZ/xuyBNrOY/yk5llV0G1TXubuWEMBgTAk8tO2O8JPu15/3sJ6YwO3uT7Szdju40+/fXSk1y2XsDPWw9NEM6fWcDv2JsMaLOdggHQiid8HPki+XHKs77k3E8FOe8i3voig6nSH+84cNCaz+2v2/BdI2K+Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Bb4A7FgXRuzXVmaWrjHX0XWoRTjqGHzYJryse8v3f0=;
 b=JUjA1P1+jbWcLXNHBnjb8gu8qu3I3k2rWdjNx7PuabRNPf6wDpVRFXsOf68Xl1dcnD+MPY5Qp7ru7g3ddnCnRkW8j56Qq8ZTRHb2KI0v3+BlG1dkkygXaWyfKVxvyTbuKbfQw2NlB+Hxdcsv75bfFld66j+0SPrMWfEaH9Tx92M=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:25 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:25 +0000
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
Subject: [PATCH v4 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Topic: [PATCH v4 11/12] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVYe3NUQOl2onkl0upFty2aXlCiQ==
Date:   Tue, 3 Sep 2019 00:23:25 +0000
Message-ID: <1567470139-119355-12-git-send-email-decui@microsoft.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:301:1::15) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e87f15f9-d447-4022-88d9-08d73004ef9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054D8602DC356A89AD85671BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ud/4Lssn4115BBITlBYeEk5wsAMNrxLex8CCKrvzyimMRLllIR+sdRkE3W7jYDGPB9mNHbHv0yt4Cl1+dp3POZL7uGy+ye1iQjtCcLudbrJWgPZQ/JkJ9CCVfH9qAxCBCdmIqfrgYk4tlB5CoJ2QzIYhM7erbBMMkEDDmsj8N8E4CPxFZImTt5C73dFL/QcksTlmmPw3Xj9sIwaNL6V9da89XQkkRIcRvXKu+Hj+LsLPC9LO0LD9sfSBIWuoJ5/Cq1KNrRTDX6wijqOYWHEF0uwfcAgaedPvRQIKdw/0+EZ/1o907/d6dBGbSXL3ufFWis91HJtNMnquX78YGBG5W6uycJhgPxYIRbLGec4HVwdEQLhLb8QuAkAkakZkltyZhmCT3MvwLfuOwYLNf4ZqgXVhb9lKsFXt0la2VRyCGoo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f15f9-d447-4022-88d9-08d73004ef9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:25.5468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZSZtQi4PpYUCC46TSiCxJKclYNkJj4nG62GsxCNOANVN+n/j6X3O+yFg3JzMxGQqjBE2g2D3Nn9TQVYR8A1lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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
 drivers/hv/channel_mgmt.c | 26 ++++++++++++++++++++++++++
 drivers/hv/connection.c   |  3 +++
 drivers/hv/hyperv_vmbus.h | 12 ++++++++++++
 drivers/hv/vmbus_drv.c    | 44 +++++++++++++++++++++++++++++++++++++++++++=
-
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 44b92fa..5518d03 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -545,6 +545,10 @@ static void vmbus_process_offer(struct vmbus_channel *=
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
@@ -944,6 +948,16 @@ static void vmbus_onoffer(struct vmbus_channel_message=
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
@@ -954,6 +968,7 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_=
message_header *hdr)
 	struct vmbus_channel_rescind_offer *rescind;
 	struct vmbus_channel *channel;
 	struct device *dev;
+	bool clean_up_chan_for_suspend;
=20
 	rescind =3D (struct vmbus_channel_rescind_offer *)hdr;
=20
@@ -993,6 +1008,8 @@ static void vmbus_onoffer_rescind(struct vmbus_channel=
_message_header *hdr)
 		return;
 	}
=20
+	clean_up_chan_for_suspend =3D is_hvsock_channel(channel) ||
+				    is_sub_channel(channel);
 	/*
 	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
 	 * should make sure the channel callback is not running any more.
@@ -1018,6 +1035,10 @@ static void vmbus_onoffer_rescind(struct vmbus_chann=
el_message_header *hdr)
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
@@ -1050,6 +1071,11 @@ static void vmbus_onoffer_rescind(struct vmbus_chann=
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
index 806319c..99851ea 100644
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
index 613888e..eedbe59 100644
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
index 45b976e..32ec951 100644
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
@@ -2146,6 +2147,44 @@ static int vmbus_bus_suspend(struct device *dev)
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
+	 *
+	 * Note: the counter nr_chan_close_on_suspend may never go above 0 if
+	 * the VM has no sub-channel and hv_sock channel, e.g. a 1-vCPU VM.
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
@@ -2186,6 +2225,9 @@ static int vmbus_bus_resume(struct device *dev)
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

