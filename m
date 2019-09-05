Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59833AAEE5
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfIEXB0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 19:01:26 -0400
Received: from mail-eopbgr700134.outbound.protection.outlook.com ([40.107.70.134]:14272
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389436AbfIEXB0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 19:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR+4HYbxACE0tvkFVPJnZRzibAUvqhQxO6VuOtvPLpZuJfr90jP0b75rstQ0V/Qu25a5Zd5bwm7xfkzUoplCa5bkKrKIw43eDt9+Av3zEF4dutMb3ygyobjOXSg/CP52c3gHhW2LtIUXTCqcx4xXZkOnYLyoU+6P2W4bwbo6zt/bdUdhTg1Ry8p/QmEix1cKrsbc9RYF9tbUvK2Oy8jDVn9AD91D+eFhGdJZVZzmJPsJ/XKXMe8pj/Dj5PVLzKn0lzRoGyMFx/3S/R0Kz58nJ2SpunxsyvdZtwlluPukF1Bi3HdROGKDWNcmCQS/GW5EIRJmPgumxzUJRUJ+SZdjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZXEjAcyh101NIOzzlYGVBaJwIhWw18sOsKypm2ia7Q=;
 b=mXxtnJJAuLhv1la2BqPQ061RRLHxYY9lcAZCRWWkfOtc4xc+yhpvRaZZpVQ777K5336zcqx9S4IoEuoIgk3HnAZ3eGRwNstXORs9A02Es0WZTFFGbXXkeqUk+jzVCgtVQJukUiPli9SiUuw367EjSN7w4c90pKHZeJQTUt6fX3IzlSy5GE1fzD4hLMbg9SKpy3TPOllt9X3uc+YOozSnH2jrfqbNW/hEFvKCWS5iDRrqdAzUnJGCAPUVkeCRPjmK8gBC5TPbYrM9gLaruo+lVdYxydxszryEcbkA9WPO/oaV7sgFf9qn+vfFLQvG3IgvrhUYQbvcjn5frtjblgojcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZXEjAcyh101NIOzzlYGVBaJwIhWw18sOsKypm2ia7Q=;
 b=A+AK5tIT750USby2nQ1eOLgVuuoBvbAzs5muYuIiTvrmyoXXhuibZTOP5H8UMLAMP4/EM+cyUHrNQr9qotufEq9YVznb59f4Km3qZxpebmkD4M0qfKgzTVYefQ1j88b0FniGrq+GMIX4ZrYySSMVmAOltrDRq1gdVXii3gXt/EQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1038.namprd21.prod.outlook.com (52.132.115.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.4; Thu, 5 Sep 2019 23:01:19 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Thu, 5 Sep 2019
 23:01:19 +0000
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
Subject: [PATCH v5 5/9] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH v5 5/9] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVZD3TVsAGhxP4ckWqLZ9N3zc1Qw==
Date:   Thu, 5 Sep 2019 23:01:18 +0000
Message-ID: <1567724446-30990-6-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: e76cfab2-b9dc-4557-8d29-08d73254f629
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1038;
x-ms-traffictypediagnostic: SN6PR2101MB1038:|SN6PR2101MB1038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1038EFD38C04F357355654FABFBB0@SN6PR2101MB1038.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(6506007)(66446008)(256004)(14444005)(10290500003)(478600001)(476003)(102836004)(186003)(36756003)(52116002)(64756008)(71200400001)(26005)(11346002)(3450700001)(6512007)(71190400001)(305945005)(107886003)(4326008)(446003)(66946007)(316002)(76176011)(7736002)(6436002)(66556008)(386003)(22452003)(66476007)(6486002)(486006)(53936002)(2616005)(25786009)(14454004)(54906003)(110136005)(5660300002)(2501003)(3846002)(2906002)(6116002)(81156014)(8676002)(81166006)(86362001)(50226002)(4720700003)(66066001)(10090500001)(1511001)(99286004)(8936002)(43066004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1038;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QFPdm/gxbONkyameik3rGR2jofu8hZr/rclCq3pjegG98zT1TZR2gxfoY1++++0avfv4tYUBMG/QeHLEM0hHkZC4lqRJLbptAlRdNj5X5rBfT29V98aHl/j/RGwsM7035d4hB6EIVju2NafhwKvY1/TTHBbn6Xz+F4XszAvnWCXld9pesISwXn/qFFogEkC87NK4m8q3dAZ2qw6uJK0oGfeQnWO7SS1kVNk4pI6wHm0xbvhSfVP8TrKOqiadAPvANb2a6vOvBxAH6zAq61ZEk7sZqi1MIn79PxT9QyXDPQSQala0bGN9HsLAsqbahtyHe7rgIGTC9IxpxSGffM4+/eAUM0d9KV3PoAucB3QhkQ3Z4jzcEkM3bL1WMWjTW63iUDyEJHfGgHtooRH4r/NPUxhoTbXGwQWsO/tv+MplGUc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76cfab2-b9dc-4557-8d29-08d73254f629
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 23:01:18.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UfZLVwFtxmDRzOXOy1RNBkiIJi/RTxPcBgdZf76re+2/c83nsieAkvuTyjfRKqnWU18gmkQrPNwoUQW4daKTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1038
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

