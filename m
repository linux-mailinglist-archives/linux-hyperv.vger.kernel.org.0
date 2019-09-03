Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112C7A5E8A
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfICAXq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:46 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728120AbfICAXn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4yXXmAU6p2tfUM/weZ2YvG6KGr43E0BsKWeKTKTtiwYUoWL3le4crcmLLtWiZg+t3dpjryiH1WcAm9i5fpoO55OAJiYcd+rnxX3PBa3ulsjKTW8Kv1ZPzwIJFCZV50PoVrUBqSvun7NhOBnnzkkGk8mYN/2x4rC9UKMbr4tlKL6kEtsrasEjIbbVXvu1JSJ0BUNREJ37SJvguxk91meOFe0UQuDVIFhGoV2YAYpHemAVnnyU8eQHkvu2a2EchAVfEazurtiTazPJu/AqZmzxCWzIXIdGuXJBgoKsQHEBwoBHsB+Ey6u3WnlZPx9OklxgvuhpktQm+hPPFTBoxs28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpN1XO/Qp4aivU0XRANQDs8pn/XS5R2ZQXIjAD2XNEA=;
 b=FU0t70/A1Gjszv/+A6Wgx2TgoKkKSWYbriay7+Mh4OkTtpsEhWQMzp3obPPbvPbt3+6V1xy/o/YU47DxFT1omcNueK0fA7eVSDpLDglq6DbAqRfMJf3e2MEhRnfeDuLI8eRrgYbROH4Y4NXbETl23dAugRfauivLgcVHOfPSX9RjVCG+d+TvsAAlX+cI0ckU0xIOo3CJ/KnCllfaLGRCrCFd5vgefsSXdV932TvSMETvsJoFXmYlNqQeRLIp1vKVol381R9GViiq6CCAaZEtP5xMbRnRa4jElw3dR2C/OP3XHfTlPl8/2xs1Nltfji0w2yzoX0iutj7xtSbL7C0Reg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpN1XO/Qp4aivU0XRANQDs8pn/XS5R2ZQXIjAD2XNEA=;
 b=Z5yelB55b5bCN3MbJdwu03WmhRjMn5bKht1MyJOWb436aFaXVMPbZlJYUsPoh3Ikdwk0CK9j1ul3BnrYS5+tJw21WW9OSu7s0WmYAPCpARUWwk4pT5nzWCYleE+qx2wopq0qLwVoQPL2Iujspra4vBI/ek/qj8yqwWwehAbQdQg=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:26 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:26 +0000
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
Subject: [PATCH v4 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v4 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVYe3NVHJgGTzXdEaA392Xpk+yBw==
Date:   Tue, 3 Sep 2019 00:23:26 +0000
Message-ID: <1567470139-119355-13-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 0776feb9-8d1c-44e8-589d-08d73004f018
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10547DF9624B08D9A3A18B69BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nqn0f3Jh0F8Za6ens8R9utlwiZiPd8mF43Mn8neEDIDcnxcY7M2e2DumzDfK0Kb1Zc3ZKJQQvw0kLB5NeaH8eJoochlzf25fbzFjcbxsaU9BZ7CEyt+EEDvNboEuZkqGmPi8MCfkWoRfABEDUUCAvgatkRsT8BQtV7BTDEREzEHw//4Di8TeFtG/XbqE3QVwhV9idVLfJVzfZYQlyhTMs1U3hpDGl/1ek0Ge16S/1fDmT8VuchNYY6+dNHX4d88LsAl4kaR/dEvH/hJf6/15f4R754/3wSQMCtUWY4mH57pxwaVC4ufYR4M6ExdZ41Pt7aWmbB2zif4C2c++EjyxMJWl4rh+3wrRC9hWBR+a6CQAlklqqLYLlgi9PZI4KyjKiJLSxtRXSh0sW5zwrX0q2/YBQKoKc1Hdi++/NeObNog=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776feb9-8d1c-44e8-589d-08d73004f018
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:26.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9KtU7lC3cCrsjL1mcy6zuCNGJGsG4Dvu0amHS13fVmd6nTsxESXgZFtCNJmnqcRchxE0IF0UjvYzMDome+/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
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
index eedbe59..ca9ef7c 100644
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

