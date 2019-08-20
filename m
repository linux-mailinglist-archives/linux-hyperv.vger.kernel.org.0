Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBB953D6
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Aug 2019 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfHTBwe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 21:52:34 -0400
Received: from mail-eopbgr820091.outbound.protection.outlook.com ([40.107.82.91]:42832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbfHTBwK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 21:52:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMiUthZx17BnCPLWM7Rf/oPjWGxS8pQbrKgKspMfZMGYwGFM72wbjqNK3uBOeoAVo0RjyuUtghFje/ek6Rmpb9BS0nGYF/tU1S1KoTzos5lMwuJgDgrfDCr3E2i6BMJdaouptrQ3hcdwwctNUMy3OX82ztuf/nq8PD20RWqxHoZUPS1Uk2GMcbIkwFMfEONj4F4PspZOONUsyqg43wioRe0zKUBZQlZCF+4hk4ndac5kEdmT6K8XMvYCQxW4zSawaaxhA5bJ88MVLFi/0lq6AX2roOSxcv0XrDx3XN9g9eQHKoo0OHDCJ/4jK3avWnU9o3ytIFFdl3MoLMnJanv6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/j0SPCVOuWj1vBiU0PeyLWjlpFjS+FHl7WxPY16arA=;
 b=AGwg7WaI3ULDYs2ZA9HtrecQDxON9+vuFrDZ86/rLX6I1EYUSdorPommNY6zdGBUYntQwUkgKoCzy02eAsW7lHPHfpCGw7viUvT0DsXSA8INAGd/5sA8WKZfImTTAtH/4IPpic143QZt2A171ZeZM1CP+QJ/uWbMIrYvAJVQsYptDUa/XUBVdc/Xh093jLUZuWcXBjslYGrSqCJ3s7YkjfVLMGrzOqHxMOHDpDqgW/aZgpePqu2O1h6eCwF9S5S7EKy9Kmo+TC6lx/Yf2mCdYy6FF128YJaX72x0TJ6tk2PqR2lYvcEetK3lVS5MmJUyEBj83+eTKj2iphxMI9Kr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/j0SPCVOuWj1vBiU0PeyLWjlpFjS+FHl7WxPY16arA=;
 b=n3Oaa6+PZBPdbc4QCtdszMH8X4ir7d6Q9t0DdiOX9Pp0017xjpopIYKysUSGsqyJPga7mPUSvZnF+RCdqP2h7W2vPPB/o8qfs5meeON0Juv0hiBKE/x+BUuJS6jNNTiHaHxU8TE00RW/pGLJ6G+QuAxGUI0N6HPs7Cal2BF02TA=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1133.namprd21.prod.outlook.com (52.132.114.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.8; Tue, 20 Aug 2019 01:52:05 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::f9d7:f678:4131:e0e5%8]) with mapi id 15.20.2199.004; Tue, 20 Aug 2019
 01:52:05 +0000
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
Subject: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVVvneBz9FpimYJEm+cyfPg4kMgQ==
Date:   Tue, 20 Aug 2019 01:52:05 +0000
Message-ID: <1566265863-21252-9-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 7a3acb55-35ae-4d08-cd5a-08d725110069
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1133;
x-ms-traffictypediagnostic: SN6PR2101MB1133:|SN6PR2101MB1133:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11330B53F66BD44CCCC1FFE1BFAB0@SN6PR2101MB1133.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(189003)(199004)(64756008)(6436002)(3450700001)(1511001)(50226002)(14444005)(81166006)(256004)(6486002)(2501003)(36756003)(66556008)(66476007)(76176011)(4720700003)(8676002)(8936002)(66066001)(25786009)(66946007)(22452003)(26005)(10290500003)(53936002)(99286004)(478600001)(43066004)(386003)(2906002)(6506007)(3846002)(6116002)(102836004)(186003)(54906003)(476003)(486006)(10090500001)(81156014)(5660300002)(316002)(110136005)(2616005)(446003)(107886003)(11346002)(6512007)(7736002)(14454004)(52116002)(305945005)(86362001)(4326008)(66446008)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1133;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YXRnbfM205/3oWoIqcb6A3gWS8DM+RG1ILhSC8N/LyUlQlAvafdObu4wQDesELYc1dP2gK5X8OxgwkINwtnRcqhHlxtbUE6YdB6BhFVuAjgnc0RNe7S+t0udXDkUou7CUzh/ohX9Yd98UVGO8p32IQSvEas8RjixsPnN+4YPa93x9Aq17pgldEPjip5s8KoEMiN3HaYPJtPGQSiboIMSYLvnbgvEiCySrunmzQmeMR8bvFYEU4qBty6cMvBxEyMa9k1pUXUCe/bH9qOrmwTrdA3XrVinZQ+oAIDaRauoXi7e/oyi3DQVp7yV4XKU0EOsow4QJPqg5k7xQLhd8+hLjcuZS6i/A8mv4ms1uLdhbs37KU7MYnVZpe8n8Hsn2Bz92O68WLmoK8snEQ5JGO5SwsGGIBqjJNl+uBA6HJeyfG4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3acb55-35ae-4d08-cd5a-08d725110069
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 01:52:05.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiFE+gC7vBlBI5/Ljp1XfmasBbqietvTNJmTXlKTsAULXH7NF9/XsTYNZaf8kYI+B7Md59ZISESVvMGuhY08tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1133
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
 drivers/hv/channel_mgmt.c | 29 ++++++++++++++++++++++++++++-
 drivers/hv/connection.c   | 27 +++++++++++++++++++++++++++
 drivers/hv/hyperv_vmbus.h |  3 +++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index addcef5..f7a1184 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -854,12 +854,39 @@ void vmbus_initiate_unload(bool crash)
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
+	mutex_lock(&vmbus_connection.channel_mutex);
+	oldchannel =3D find_primary_channel_by_offer(offer);
+	mutex_unlock(&vmbus_connection.channel_mutex);
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
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 09829e1..6c7a983 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -337,6 +337,33 @@ struct vmbus_channel *relid2channel(u32 relid)
 }
=20
 /*
+ * find_primary_channel_by_offer - Get the channel object given the new of=
fer.
+ * This is only used in the resume path of hibernation.
+ */
+struct vmbus_channel *
+find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *of=
fer)
+{
+	struct vmbus_channel *channel;
+	const guid_t *inst1, *inst2;
+
+	WARN_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
+
+	/* Ignore sub-channel offers. */
+	if (offer->offer.sub_channel_index !=3D 0)
+		return NULL;
+
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		inst1 =3D &channel->offermsg.offer.if_instance;
+		inst2 =3D &offer->offer.if_instance;
+
+		if (guid_equal(inst1, inst2))
+			return channel;
+	}
+
+	return NULL;
+}
+
+/*
  * vmbus_on_event - Process a channel event notification
  *
  * For batched channels (default) optimize host to guest signaling
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 9f7fb6d..c42b46d 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -310,6 +310,9 @@ int vmbus_add_channel_kobj(struct hv_device *device_obj=
,
=20
 struct vmbus_channel *relid2channel(u32 relid);
=20
+struct vmbus_channel *
+find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *of=
fer);
+
 void vmbus_free_channels(void);
=20
 /* Connection interface */
--=20
1.8.3.1

