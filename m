Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A97953CC
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfHTBwR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:17 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729068AbfHTBwQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLSKTMtReT8mgV4sXuUshlvaLMbFIuBkZZCd81GQy7NyxsFJtbfbC055JFAkRM1Q8Am7v4SozmEukel/ClCpZFySQ0Tv37BXNWvLCKii5/+JwhRw9duyznw0fCzZmmK+KovMZ12SW312EK5E/6VwUdbYeYjaf2DUmrjF5dc4Ym0W6NdvzJDnp1/uFhl41A+6hK1GnLTHwJgkTaPbCIReiBb6g0u511f42xnmM0kNhNLhbdFtBEgqLu7jNzgZgasUkIpjBd8huJJMAKbQpezkjadRcACaynsLov6nRRx4CdhOKYLBU8YBtEljA3B4pKsub25M3MjUZxPgthTCdMHRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2qplFNyP/VrxF8GiHF2HPNaGNydfgpiEk92zrrXI+I=;
 b=J1fD2QPSiBfDKp9P5Jo2R6lHTbwM+WjJ8zSAarHaZmQ6lQhpXxx6U5C8kCaIdbr+yyTenlnzmJg7Wlokgr+pIOcO7QMVTVPKRtgg4jmHHDZc8cW6rJM1Bs+7ZdHbmiW2izM8w1o3DXXbVbz6iDJv/SFjo+EFgY2YH6dTba5NlYgPkB0zAcngKeJNQjktMASmZBOd8AZAxYriVs+SzKFl9HUn4YbaiLTBCAqAzAbCavyY8BvGQSg1OvFtCTsx+VSEADysUMydJ0YeTQ3LmA2KpJX355ZAgvMFa/2bybSg/yfBRo8jx+P6Izj26RqtCrNwyuZYixQkkUgxCIE1HmPswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2qplFNyP/VrxF8GiHF2HPNaGNydfgpiEk92zrrXI+I=;
 b=fnHKjkTzvldMRFDn+EkzMmGQBhcod5ZmpcpJl82cafoWieOBtjknO4AvyHQZJhrVNf3FZxfRKpE2eVcuO8Ss7ffO0nXceGEerpSM6nJmI4IYsuBuPsrdItG+KmsSaZmpKsAdItmX7Sbo5/1523P3ngOJPN5lOfAfCLq1M03gIU8=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:09 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:09 +0000
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
Subject: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v3 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVVvng/GEwjAPMWk+c5MDiqY851Q==
Date:   Tue, 20 Aug 2019 01:52:09 +0000
Message-ID: <1566265863-21252-13-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: f7aed2b9-09ae-42fe-6c1b-08d7251102d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11339B38908D0FBE9A04E819BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BHBQjNyqZ+C5oloGezhbVoQ/chcP35gHKKodSQ4+vP5pCOuF1Z4D4GsOquk1n50zNqbXCuGbqlHgnuqBgiv9ZmVo3OeIHivbbBw9AVXFhDLwGqmJvWaBWTWWHXaaJs1cmCsbdUn0W6LOrFAqU8Mb2atshRXXzWZ06QTZJx/rsMcJhPApY+DzbsGq+T20VLGv6lBwiGykW63N/sKEw8BfTGs+ZTeKbNlSrO0ZI+FfRnzogolCW+7uB9n7O2vaUyDuvElmaGBb3RKPhg1rb/RljYUe3PO0Etvdosy1zccYkY6s1luom/io/4vR4M9IDDaOkcJri9Fwfto6BalTgdrpJyAtRT6njv5GJVlSQReuP7eYBhTHRLTDwcFQ31HMLJwASv61Zzh5YLr4isP3ZJsPHE/PsmJY4ohWiFP+BQUhtSw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aed2b9-09ae-42fe-6c1b-08d7251102d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:09.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK1NmwtnWUdT4ic8WgWKFt7mPuYswB7o4bnJzBVufHdNEpXZXtAiU1ec6GMvmdIw/viryzW1qGVOATXihd7Nzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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
---
 drivers/hv/channel_mgmt.c | 76 +++++++++++++++++++++++++++++++++++--------=
----
 drivers/hv/connection.c   |  2 ++
 drivers/hv/hyperv_vmbus.h | 14 +++++++++
 drivers/hv/vmbus_drv.c    | 17 +++++++++++
 include/linux/hyperv.h    |  3 ++
 5 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 8491d1b..61b6288 100644
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
@@ -853,6 +861,36 @@ void vmbus_initiate_unload(bool crash)
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
  * vmbus_onoffer - Handler for channel offers from vmbus in parent partiti=
on.
  *
@@ -875,12 +913,21 @@ static void vmbus_onoffer(struct vmbus_channel_messag=
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
 		pr_debug("Mismatched offer from the host (relid=3D%d)\n",
 			 offer->child_relid);
@@ -890,6 +937,11 @@ static void vmbus_onoffer(struct vmbus_channel_message=
_header *hdr)
 				     false);
 		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
 				     16, 4, offer, offer_sz, false);
+
+		vmbus_setup_channel_state(oldchannel, offer);
+
+		check_ready_for_resume_event();
+
 		return;
 	}
=20
@@ -902,21 +954,7 @@ static void vmbus_onoffer(struct vmbus_channel_message=
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
index f15d3115..ebfa9aa 100644
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
index 9f96e23..fb00ffd 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -270,6 +270,20 @@ struct vmbus_connection {
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
index 0507157..edec984 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2161,9 +2161,17 @@ static int vmbus_bus_suspend(struct device *dev)
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
@@ -2178,6 +2186,8 @@ static int vmbus_bus_suspend(struct device *dev)
 			WARN_ON_ONCE(1);
 		}
 		spin_unlock_irqrestore(&channel->lock, flags);
+
+		atomic_inc(&vmbus_connection.nr_chan_fixup_on_resume);
 	}
=20
 	mutex_unlock(&vmbus_connection.channel_mutex);
@@ -2186,6 +2196,9 @@ static int vmbus_bus_suspend(struct device *dev)
=20
 	vmbus_connection.conn_state =3D DISCONNECTED;
=20
+	/* Reset the event for the next resume. */
+	reinit_completion(&vmbus_connection.ready_for_resume_event);
+
 	return 0;
 }
=20
@@ -2220,8 +2233,12 @@ static int vmbus_bus_resume(struct device *dev)
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

