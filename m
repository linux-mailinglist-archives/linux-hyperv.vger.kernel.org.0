Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB7A5E7F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfICAXc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:23:32 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfICAXb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfPWDR0IMDSdqbVUS66Riq3ikugInHhdburWrpvRwa0kBlmdH3K1tUDpAb9Ab+bLnBnX+TZEiegmODyTK9ZVPbGASx6i1Lq0tQy7UiXj3ALBa+D/BXboTbJr0taq2mxQo6iKypNFtcVB6bWvN0IYMPso+OPgh4Wqw1F4a6ixV+6j4xYVlf+lqP1O3sXqiB94Cesy96ZwcaBD0Zt7IJ9zxwogJzZpIJEvkEvBysqyNiRBHkXEgVuQJtgMlOjEcOXk9VbhQYxSGAbujW0BYcKMoKKhIIVm2U5JQYxtO9u1DDDRqQcrw7OnE7Wbu8y9MhOMQ914qkkf6zFxrPXiUngt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFFFx0pp2PDfN82xOMl48rxCSsjMmLuLhecljYjQsyI=;
 b=D34Yh7SIFBUN1OUM7YvORNJtXmlJMmuXc01clLPMMS/r0iUq+S06NU0wienvuVH59awLDKbPLfkTLTgRjTt0qoMqglwaPGIoi8P+Pj73BiES/rFySCIhLq0BQ6qsKVLrKQmozLY/b98i621WMvfpEW6+KuAMYPLL+oU2joJ22cbwQDtGPZCtFfc2tkHxLAP4bxPLM9Q1lb/Jy55XuodA+qP10nZVT97/850KncX34y3X1FhVFkHeiUcYB+KtNmjg93TLYQuIlk3UJGhjqDxw0JPeQuo0s0dICAhKRB7RNc1AU1e+POI7vtJpMwIM+O+5ycZtUDD5b7+ndQJmxj7odQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFFFx0pp2PDfN82xOMl48rxCSsjMmLuLhecljYjQsyI=;
 b=OVwA78GdWVgis2JkOhBcj67kULcCyRRiFrSEOPAQHOVgKgFQvUuuXmFXMdHe+wgq6RM/M9T59ZiT4LQtprDGKFzQ0tyepPaYfiT/0KoQM/Fps0tEvtIAxq43mijiLMLObu2Jz8/A5kQ3nPHx0cWQuInPb0cyxdPGhwtY+t5MZZA=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:23 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:23 +0000
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
Subject: [PATCH v4 08/12] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH v4 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVYe3LvlwHTq/V6k6K8lKoCGifpQ==
Date:   Tue, 3 Sep 2019 00:23:22 +0000
Message-ID: <1567470139-119355-9-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 3f4ca02e-5a1d-4742-e28b-08d73004ee0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1054B5D7DB64D5BB05DCD004BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hc5bdbkYDkQtKDXBuDwO3X8QER1zGaRwzJyzZCp7YS2cf1vonlvUdzf7FJ5MiPSVL1+zinBwFkgaxHecsTZ3U0ZmYZVpgqx35AioHiJazzW1O1kcu9Xtbft2g6TAg7DfD03fUrLXY5ycCJGU8XoDv4ZkzB9iXbqaI7wgYxYKNEJI2zBPiBZCNecKPBI6Nf1EWAUeFGu21/WdSFWY8iLXU7PfgKt1ZxnUWM6Pu0aAM9eaRlIR1yF/yL5xZdg57w2lG40lO+aJgPUbHgI5QkCu1B8z3y7X8+tu+rwUUA+mG7f5M8SUTfw4ohhy+toqosygbUb/J2Y7ingQ/H2da383mtbf+P/WeuZHQRFZqkheHzSiZarxUwDxqihzrGFvd+UFP0t1l2b4r9XzswleQRPrTpizUNQr1JKs1bgTdI603BA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4ca02e-5a1d-4742-e28b-08d73004ee0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:22.9873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3LKDyJORmTnvS3rj8KXG5xjDVZQCN1uGtE5G169q14v2Yc9gyNSXnmIce8AKqwLf4HkNFcH2kS4xPRhPSxC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When the VM resumes, the host re-sends the offers. We should not add the
offers to the global vmbus_connection.chn_list again.

This patch assumes the RELIDs of the channels don't change across
hibernation. Actually this is not always true, especially in the case of
NIC SR-IOV the VF vmbus device's RELID sometimes can change. A later patch
will address this issue by mapping the new offers to the old channels and
fixing up the old channels, if necessary.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 58 +++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index addcef5..44b92fa 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -848,18 +848,74 @@ void vmbus_initiate_unload(bool crash)
 }
=20
 /*
+ * find_primary_channel_by_offer - Get the channel object given the new of=
fer.
+ * This is only used in the resume path of hibernation.
+ */
+static struct vmbus_channel *
+find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *of=
fer)
+{
+	struct vmbus_channel *channel =3D NULL, *iter;
+	const guid_t *inst1, *inst2;
+
+	/* Ignore sub-channel offers. */
+	if (offer->offer.sub_channel_index !=3D 0)
+		return NULL;
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	list_for_each_entry(iter, &vmbus_connection.chn_list, listentry) {
+		inst1 =3D &iter->offermsg.offer.if_instance;
+		inst2 =3D &offer->offer.if_instance;
+
+		if (guid_equal(inst1, inst2)) {
+			channel =3D iter;
+			break;
+		}
+	}
+
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
+	return channel;
+}
+
+/*
  * vmbus_onoffer - Handler for channel offers from vmbus in parent partiti=
on.
  *
  */
 static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 {
 	struct vmbus_channel_offer_channel *offer;
-	struct vmbus_channel *newchannel;
+	struct vmbus_channel *oldchannel, *newchannel;
+	size_t offer_sz;
=20
 	offer =3D (struct vmbus_channel_offer_channel *)hdr;
=20
 	trace_vmbus_onoffer(offer);
=20
+	oldchannel =3D find_primary_channel_by_offer(offer);
+
+	if (oldchannel !=3D NULL) {
+		atomic_dec(&vmbus_connection.offer_in_progress);
+
+		/*
+		 * We're resuming from hibernation: we expect the host to send
+		 * exactly the same offers that we had before the hibernation.
+		 */
+		offer_sz =3D sizeof(*offer);
+		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
+			return;
+
+		pr_debug("Mismatched offer from the host (relid=3D%d)\n",
+			 offer->child_relid);
+
+		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
+				     16, 4, &oldchannel->offermsg, offer_sz,
+				     false);
+		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
+				     16, 4, offer, offer_sz, false);
+		return;
+	}
+
 	/* Allocate the channel object and save this offer. */
 	newchannel =3D alloc_channel();
 	if (!newchannel) {
--=20
1.8.3.1

