Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E307CAF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfGaRwZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:25 -0400
Received: from mail-eopbgr810135.outbound.protection.outlook.com ([40.107.81.135]:36140
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbfGaRwI (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU/MOEsBC3fOlHZZlMC5OEpa076SxUscpj4AHwc3aFHIIwXL9R1e0bBDJXhIM7FnuHjq0aaEaFa07dLMlrP47vQJ2kj3nmeBYeHD1NGhJcuDDNP9Q0IxToownjEpd76CKIVlDKyzHwQGx7b7KM8+COwakTGhHT6ieY6v77WKGP0sMNfWzDI1qFiGCptLCgTyZ5FZoUPvC5ept3uR3dlVN9t+U2R3Q646DLeestqJ0vTtoGnJ8HtsHqKKaBerx3jhemBcNM6ODBCe/8RkHWH4oE6uCv+HvYaGmum5ffZH5mGziHLUhjX3VvdUpvNnJ/RA3YoGQlH4PlPEifh2vY2l0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVcI9bUhKAYLl0I9z/Uowmj9Vdb5mXK72gMVzAWHNTw=;
 b=XoTHglSWlej0ud+l0ffW4YzkaO09OYZPK/SJUkJdSG9f3ErsTBECYHWfC9siGuKLJUluhjc4SYkfGTukPiSlfSQtBnXYn3+ffZVaUdzKC2OX0PD11iL3fhO02sEAjqJwckujKR4jOehl5K8SARVmC6jhwGqCwt7UWpoW3NOFtYF4a9g7UkFaCrv9C01Cle2wssIYcyrIGfsx6R0BUDenNXiZXIu6XQp/ZCFWI4jVy6Vm7zz9yqouGzHm+2D4jmHtv2lx0fbju3aJ56kSmdZ0G3OnZzHOf7GX732vo0+kjkFF1goXF4tsHHq2RUkoCEjaTF8pM1xIOsrya7A9GcPjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVcI9bUhKAYLl0I9z/Uowmj9Vdb5mXK72gMVzAWHNTw=;
 b=Z1ZbeNPFw7XA6X2dibmlA07YNcfeuJLfXyBYB2kcedgMGnMIHtKV9CTwnaea2r8wOlEcrGLP2wO+tHehXy8mLpEYEukAMDyZZY1LLogHIIzKqgz49aPWH3wf1UJXddA6GKw1Ic+p03OkwP/t9+Kg2jzq2kJsvlTb0CIgZowGPLE=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1085.namprd21.prod.outlook.com (52.132.115.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:05 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:05 +0000
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
Subject: [PATCH v2 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Topic: [PATCH v2 5/7] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVR8iqydG6y7QVck+W+UIqKY/h9w==
Date:   Wed, 31 Jul 2019 17:52:05 +0000
Message-ID: <1564595464-56520-6-git-send-email-decui@microsoft.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0011.namprd13.prod.outlook.com
 (2603:10b6:301:29::24) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09a9c489-84a7-4050-9622-08d715dfccdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1085;
x-ms-traffictypediagnostic: SN6PR2101MB1085:|SN6PR2101MB1085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB10855B7B9C6AF33F312814A8BFDF0@SN6PR2101MB1085.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8676002)(5660300002)(4326008)(305945005)(10090500001)(8936002)(107886003)(53936002)(81156014)(81166006)(7736002)(14444005)(50226002)(66946007)(256004)(478600001)(10290500003)(66066001)(66556008)(64756008)(66476007)(66446008)(68736007)(86362001)(11346002)(2616005)(476003)(486006)(446003)(1511001)(4720700003)(71190400001)(71200400001)(6512007)(2906002)(3846002)(110136005)(99286004)(2501003)(386003)(52116002)(6506007)(54906003)(102836004)(26005)(43066004)(76176011)(6116002)(14454004)(186003)(316002)(6436002)(25786009)(3450700001)(36756003)(22452003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1085;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VR/XCv1EhqFgSqtpwPWbWyRVWWAPjtmAhZQjngwOdo0EimnuERlOc/pkmHreA2gmbBvaAknqWG3On5vnNnre8W1BHAuED4E45/bce0FSUVMkj/+/w1LdoAkpjfkJxlgHXe9c4Mbq/PdnhDyEGd5r9XktghhlMdVnzDVdIMsK3wlrc+7LrOMuaz8007sWmyqWw9q7QWVpmDHiQ2DM7q84Fkvadp5thpu/XAg+4wPsf/5SZW7lgzDChEf77Uvf3Ly4swfN99VPaAM/NK3nwJ+HYQ0tVR4jmAjEoFZ6pgmidEiHRaeE8y6DYA4nehSa1sRntbjxZ+QG0R82DJioz5U9H3s9YvFva0j+Q9ehOQ+415CcVv6zWoeb134EPH8cVSWsi4Y0Vf5kp/LY9iO2FnmQmo5s3g5v/3+jJYLA5V9k2z4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a9c489-84a7-4050-9622-08d715dfccdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:05.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKwqdjAyKvtQtBPuZQzs9XcRAQnGlKBt1pcnZ4AYpEqmlLj7t2MrE5yVhtEyV76LEm0tsT1BoWto+YfUSvG/gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1085
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When the VM resumes, the host re-sends the offers. We should not add the
offers to the global vmbus_connection.chn_list again.

Added some debug code, in case the host screws up the exact info related to
the offers.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index addcef5..165f125 100644
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
+	oldchannel =3D relid2channel(offer->child_relid);
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
+		pr_err("Mismatched offer from the host (relid=3D%d)!\n",
+		       offer->child_relid);
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

