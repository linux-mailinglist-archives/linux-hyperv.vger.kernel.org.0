Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD18AAAEDF
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfIEXBc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:32 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389436AbfIEXBa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ1/mRd3APgawOLUR9v5WKrr8RJSJjZDBfVosb6th1NkzVLfdCrHwrAQ0spYOtC2a8EzL4JV2gOzeK2BBrrtX6NP+ZTH1+O2KwkQ6eCJR11vgWT975jRtVfPWuk5mUczcdNjM6p47VmVaxXjntGR7vzqM3dI3gI4HZLDc1BbJXloGk9Cp05rYVJyPwScbOIH41GpYxyl9kz/+P2hyDgT79Ho9hVfe7X8eLVkXoynjw5V4dP5KNlMQmDsPbDjaRpG1zXHqoyZkYx5tsSXHfLfDzr22gU5jmnmnA1mPzZw/TuBSqTanLR7mi8N44FFqMd7YLst9M0elGcqU/1SKNptAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKo5TMMZ0ELvRbQxSQWahNaKZFZBAEOVM0pz4KTHwB8=;
 b=Vw1U9Vo9q71DoCginMp/WcNAJwaECKLkHTWO+zbLiFaT96rCFeqPjshXKlA6Y1i4E02u2BzmTBwZdPcPFbrwthvqMtlksbU70XgOa4KhugZ/jHHLTVaWHDZJC+Kv58Ewunuoyp5p3Xti3BSwzRmj4UfocRR3zH5c6E/zteGqKbOjo0srF0E8JzBPbHLoWjFeUeBiCI5HBloSaLeDKAIFq8zISwhOF2j896bwFdtB/4hsVXtJsWrkLNOM5pVRbhIdfnlzADMLB2pg76eEv3qUtyOGXIyS/BXXvxYwVNWyA+ag/kOEJiIfprST73055uHKJfI/gDoH3+5YzE3q5iPF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKo5TMMZ0ELvRbQxSQWahNaKZFZBAEOVM0pz4KTHwB8=;
 b=JC66QLP292JoqcIMztnjWsm9B6XovxpqaOKov77m1DNWVIM0OqOFy/lzzlYWTdgPee0cL+EyfyeFMD2rcwSL1t7+lg2dkmgPuHjnwO7UGDIXpuO346hwIFkOmXimCBj2MXINuBf+ybpZQjgZ+zBFEhqyqf/0pgCfnSmerty9opM=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:21 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 8/9] Drivers: hv: vmbus: Suspend after cleaning up hv_sock
 and sub channels
Thread-Topic: [PATCH v5 8/9] Drivers: hv: vmbus: Suspend after cleaning up
 hv_sock and sub channels
Thread-Index: AQHVZD3V3TlxdOtERUa8lkWyHvJEYg==
Date:   Thu, 5 Sep 2019 23:01:21 +0000
Message-ID: <1567724446-30990-9-git-send-email-decui@microsoft.com>
References: <1567724446-30990-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567724446-30990-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:301:73::25) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab12af26-1dee-49e8-5ea2-08d73254f7c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB103889769A6288F5EFDC81D5BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(15650500001)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sfm3cnZ5gAuOP8dGdEny54y9fO8oKK4Ld/Ryzu3BbYpE34Ps3ql+H9ijRgGoeU+1UsQb4PG6rvt1CJlPfLPQfOTyHvE26RHAfE++/q4j6bbA+KNrbAjkvSEfgCkuMVQ9IHKOgA6+hIEfxL2I6ifAlVykkJ1vsFznvSMTfibYdsXPzUKFgU6XidOt/Qg41c1/R3NVkIkYynJc3aBnOyqBw8zvBWatz3uEDnhaVwFwhACjG1ySggjSxnAmtb8lUGausDwxCZmZkdaHSqbEnZ0RoG/sCpT1RhsMY3YwueUFwJ/ztJ2aGq7IjbtZKpZJE/tggBhfhIi8WI56fSdvzk1YCxUpvRclNZdDkNwQhvLbE2LehhI2zSwAwM4PXlEt7bZlN+H4uqQxkdhfF06z/3N4u+5q+7OZBh2aQVqnzPwtSGA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab12af26-1dee-49e8-5ea2-08d73254f7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:21.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJEqA0KcUD9UGQU7SQVdJArb52+R9KiWYEqi3K4Iegmbr1a50ynuzmKBIjkaTpYHfM0vFkGT8r9435r9vUz0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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
index e657197..974b747 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -260,6 +260,18 @@ struct vmbus_connection {
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

