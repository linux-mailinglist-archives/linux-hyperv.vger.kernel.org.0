Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32465AAEE0
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403822AbfIEXBd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:33 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403807AbfIEXBc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKscHNGShPmLrhDsxLYFMwd7V8RCff6hxB96/vqD1ShiFdTJyp2G037jKcnRgiHF553+EanbLZ5jLvDj/1iyp0tziacq4pxHQERGS6EXSN4dY3rB4X4wO/8HCL8JNwM3YQMOL96L3sNY1f3Q4x782xtrFVYDi1nT/vp/FejVOAgsxE3PBsVFgNJmGfTGsGDVqo/6X+VQtMcct7ODHFCNsZ+QOTSXtq+5sR2XlyrrhA3I0xOtWeS48pHPtYwJv+x7k8P1+PapcDcnq6Pw1HeRYvxjs6wXFsC480K5T8bZ+tc31pUnG4n9gjm6BoVLDzmq56NJToDGFUFW/B6wJnRnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrfvPEuolicCsg2rYd9BWrSwue3EU+VQgJNlVqR7dSc=;
 b=LjCPMSYit/8EgLF19M9BhvavOOOPlyVzyvv3tcUxqbb4li8X+CMPLV2RxWmlopFKUmmvZoUghYwUGJJlUpSOPYgPkUjpZAO23WoUD17HmsttogtiqforUrf1SjoR6tojgkCTrZ6LNg1NdRb/t7/RxQNoQQCsjgAhJz71IxVwMDPXRzybeOr5z1B3QMIvGgniEhuubRiO1597aJ0G8GmZ2SGl9ntcXsGkEs1xhjsGndL+XB//hdT4PRkDL6swgeDybdyJWRdJOrJAg0BzkzMYgG6XTnexoRSREi/kkiyFsPqRY7hBqKDE1dQlQsCKW0l+qoYh7v1jYXRBJgzwaHs0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrfvPEuolicCsg2rYd9BWrSwue3EU+VQgJNlVqR7dSc=;
 b=ov3OJjkTqyGE//UfZXOV6nOBY+yHz0G/MByJCjM/4bTiwnVp+KAeM99uBHD7BjMXlbXQXbaRywdHEka8uWwgRRmEwSotvMCy7wDKIeVCnAxVyo7fdVR6SPSsX3xg8f2Fw56IR40cxlVnDV1Rck2e5eiXgXBR+4ehOzTXGZVQLWg=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:22 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:22 +0000
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
Subject: [PATCH v5 9/9] Drivers: hv: vmbus: Resume after fixing up old primary
 channels
Thread-Topic: [PATCH v5 9/9] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVZD3VMytHqgbGXUWE9Y9otIotAw==
Date:   Thu, 5 Sep 2019 23:01:22 +0000
Message-ID: <1567724446-30990-10-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 6cee4cf3-4afd-441b-7849-08d73254f846
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10387843540CED8A79EF0A67BFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ddX0qG+S2T3obCyCW720DuCYo5GVV5oje/i+epCtinjsNJcLcbrMNP7SqFx+zgRMN/BFCc+zGw4OgoTbjDfvArMLSNlocesDBSttns1U6j3BmSC9TNKMijri2kHz/H4+ebxUz+pY2XUKDKrEl36obV0pV+Cdqs98fBj9fDdQ0Q0oBCnxnMBRYzD5hyikTzivHOUSslpHsTbhuRH13b1BQDHRuV3qbzIP5/9NRKOEC8a7JyvKM8fvWIzLf1UJr6CcaZVLG8hmkTWrzZ0vcivytjeAUd2J92gqYdkOMK2NF+LQU7P0lFuKJ5QYLidUB9JNs56ud7RUBZZGkgeBnbPpxCfQA1evkHFAnnU4jW00a6nS/Z6XuwOA3205G+ecCu+EkJaomdxG1iJTyKAisqGpzw4GLEiM8Owu5vseRGbvdiM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cee4cf3-4afd-441b-7849-08d73254f846
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:22.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kv19dNWX6MM/R+IUMw0RlIvlu3crDZOSpU6fZQXBCnWv66U2+yxL9wv0rEuH9KdUUp72Vwq1SoaaEzL66kVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When the host re-offers the primary channels upon resume, the host only
guarantees the Instance GUID  doesn't change, so vmbus_bus_suspend()
should invalidate channel->offermsg.child_relid and figure out the
number of primary channels that need to be fixed up upon resume.

Upon resume, vmbus_onoffer() finds the old channel structs, and maps
the new offers to the old channels, and fixes up the old structs,
and finally the resume callbacks of the VSC drivers will re-open
the channels.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 85 ++++++++++++++++++++++++++++++++++++-------=
----
 drivers/hv/connection.c   |  2 ++
 drivers/hv/hyperv_vmbus.h | 14 ++++++++
 drivers/hv/vmbus_drv.c    | 17 ++++++++++
 include/linux/hyperv.h    |  3 ++
 5 files changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 5518d03..8eb1675 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -407,7 +407,15 @@ void hv_process_channel_removal(struct vmbus_channel *=
channel)
 		cpumask_clear_cpu(channel->target_cpu,
 				  &primary_channel->alloced_cpus_in_node);
=20
-	vmbus_release_relid(channel->offermsg.child_relid);
+	/*
+	 * Upon suspend, an in-use hv_sock channel is marked as "rescinded" and
+	 * the relid is invalidated; after hibernation, when the user-space app
+	 * destroys the channel, the relid is INVALID_RELID, and in this case
+	 * it's unnecessary and unsafe to release the old relid, since the same
+	 * relid can refer to a completely different channel now.
+	 */
+	if (channel->offermsg.child_relid !=3D INVALID_RELID)
+		vmbus_release_relid(channel->offermsg.child_relid);
=20
 	free_channel(channel);
 }
@@ -851,6 +859,36 @@ void vmbus_initiate_unload(bool crash)
 		vmbus_wait_for_unload();
 }
=20
+static void check_ready_for_resume_event(void)
+{
+	/*
+	 * If all the old primary channels have been fixed up, then it's safe
+	 * to resume.
+	 */
+	if (atomic_dec_and_test(&vmbus_connection.nr_chan_fixup_on_resume))
+		complete(&vmbus_connection.ready_for_resume_event);
+}
+
+static void vmbus_setup_channel_state(struct vmbus_channel *channel,
+				      struct vmbus_channel_offer_channel *offer)
+{
+	/*
+	 * Setup state for signalling the host.
+	 */
+	channel->sig_event =3D VMBUS_EVENT_CONNECTION_ID;
+
+	if (vmbus_proto_version !=3D VERSION_WS2008) {
+		channel->is_dedicated_interrupt =3D
+				(offer->is_dedicated_interrupt !=3D 0);
+		channel->sig_event =3D offer->connection_id;
+	}
+
+	memcpy(&channel->offermsg, offer,
+	       sizeof(struct vmbus_channel_offer_channel));
+	channel->monitor_grp =3D (u8)offer->monitorid / 32;
+	channel->monitor_bit =3D (u8)offer->monitorid % 32;
+}
+
 /*
  * find_primary_channel_by_offer - Get the channel object given the new of=
fer.
  * This is only used in the resume path of hibernation.
@@ -902,14 +940,29 @@ static void vmbus_onoffer(struct vmbus_channel_messag=
e_header *hdr)
 		atomic_dec(&vmbus_connection.offer_in_progress);
=20
 		/*
-		 * We're resuming from hibernation: we expect the host to send
-		 * exactly the same offers that we had before the hibernation.
+		 * We're resuming from hibernation: all the sub-channel and
+		 * hv_sock channels we had before the hibernation should have
+		 * been cleaned up, and now we must be seeing a re-offered
+		 * primary channel that we had before the hibernation.
 		 */
+
+		WARN_ON(oldchannel->offermsg.child_relid !=3D INVALID_RELID);
+		/* Fix up the relid. */
+		oldchannel->offermsg.child_relid =3D offer->child_relid;
+
 		offer_sz =3D sizeof(*offer);
-		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
+		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0) {
+			check_ready_for_resume_event();
 			return;
+		}
=20
-		pr_debug("Mismatched offer from the host (relid=3D%d)\n",
+		/*
+		 * This is not an error, since the host can also change the
+		 * other field(s) of the offer, e.g. on WS RS5 (Build 17763),
+		 * the offer->connection_id of the Mellanox VF vmbus device
+		 * can change when the host reoffers the device upon resume.
+		 */
+		pr_debug("vmbus offer changed: relid=3D%d\n",
 			 offer->child_relid);
=20
 		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
@@ -917,6 +970,12 @@ static void vmbus_onoffer(struct vmbus_channel_message=
_header *hdr)
 				     false);
 		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
 				     16, 4, offer, offer_sz, false);
+
+		/* Fix up the old channel. */
+		vmbus_setup_channel_state(oldchannel, offer);
+
+		check_ready_for_resume_event();
+
 		return;
 	}
=20
@@ -929,21 +988,7 @@ static void vmbus_onoffer(struct vmbus_channel_message=
_header *hdr)
 		return;
 	}
=20
-	/*
-	 * Setup state for signalling the host.
-	 */
-	newchannel->sig_event =3D VMBUS_EVENT_CONNECTION_ID;
-
-	if (vmbus_proto_version !=3D VERSION_WS2008) {
-		newchannel->is_dedicated_interrupt =3D
-				(offer->is_dedicated_interrupt !=3D 0);
-		newchannel->sig_event =3D offer->connection_id;
-	}
-
-	memcpy(&newchannel->offermsg, offer,
-	       sizeof(struct vmbus_channel_offer_channel));
-	newchannel->monitor_grp =3D (u8)offer->monitorid / 32;
-	newchannel->monitor_bit =3D (u8)offer->monitorid % 32;
+	vmbus_setup_channel_state(newchannel, offer);
=20
 	vmbus_process_offer(newchannel);
 }
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 99851ea..6e4c015 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -29,6 +29,8 @@ struct vmbus_connection vmbus_connection =3D {
=20
 	.ready_for_suspend_event=3D COMPLETION_INITIALIZER(
 				  vmbus_connection.ready_for_suspend_event),
+	.ready_for_resume_event	=3D COMPLETION_INITIALIZER(
+				  vmbus_connection.ready_for_resume_event),
 };
 EXPORT_SYMBOL_GPL(vmbus_connection);
=20
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 974b747..f7a5f56 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -272,6 +272,20 @@ struct vmbus_connection {
 	 * drop to zero.
 	 */
 	struct completion ready_for_suspend_event;
+
+	/*
+	 * The number of primary channels that should be "fixed up"
+	 * upon resume: these channels are re-offered upon resume, and some
+	 * fields of the channel offers (i.e. child_relid and connection_id)
+	 * can change, so the old offermsg must be fixed up, before the resume
+	 * callbacks of the VSC drivers start to further touch the channels.
+	 */
+	atomic_t nr_chan_fixup_on_resume;
+	/*
+	 * vmbus_bus_resume() waits for "nr_chan_fixup_on_resume" to
+	 * drop to zero.
+	 */
+	struct completion ready_for_resume_event;
 };
=20
=20
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 32ec951..391f0b2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2164,9 +2164,17 @@ static int vmbus_bus_suspend(struct device *dev)
 	if (atomic_read(&vmbus_connection.nr_chan_close_on_suspend) > 0)
 		wait_for_completion(&vmbus_connection.ready_for_suspend_event);
=20
+	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) !=3D 0);
+
 	mutex_lock(&vmbus_connection.channel_mutex);
=20
 	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		/*
+		 * Invalidate the field. Upon resume, vmbus_onoffer() will fix
+		 * up the field, and the other fields (if necessary).
+		 */
+		channel->offermsg.child_relid =3D INVALID_RELID;
+
 		if (is_hvsock_channel(channel)) {
 			if (!channel->rescind) {
 				pr_err("hv_sock channel not rescinded!\n");
@@ -2181,6 +2189,8 @@ static int vmbus_bus_suspend(struct device *dev)
 			WARN_ON_ONCE(1);
 		}
 		spin_unlock_irqrestore(&channel->lock, flags);
+
+		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
 	}
=20
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -2189,6 +2199,9 @@ static int vmbus_bus_suspend(struct device *dev)
=20
 	vmbus_connection.conn_state =3D DISCONNECTED;
=20
+	/* Reset the event for the next resume. */
+	reinit_completion(&vmbus_connection.ready_for_resume_event);
+
 	return 0;
 }
=20
@@ -2223,8 +2236,12 @@ static int vmbus_bus_resume(struct device *dev)
 	if (ret !=3D 0)
 		return ret;
=20
+	WARN_ON(atomic_read(&vmbus_connection.nr_chan_fixup_on_resume) =3D=3D 0);
+
 	vmbus_request_offers();
=20
+	wait_for_completion(&vmbus_connection.ready_for_resume_event);
+
 	/* Reset the event for the next suspend. */
 	reinit_completion(&vmbus_connection.ready_for_suspend_event);
=20
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 8a60e77..a3aa9e9 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -426,6 +426,9 @@ enum vmbus_channel_message_type {
 	CHANNELMSG_COUNT
 };
=20
+/* Hyper-V supports about 2048 channels, and the RELIDs start with 1. */
+#define INVALID_RELID	U32_MAX
+
 struct vmbus_channel_message_header {
 	enum vmbus_channel_message_type msgtype;
 	u32 padding;
--=20
1.8.3.1

