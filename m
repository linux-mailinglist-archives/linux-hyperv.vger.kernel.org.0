Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7262FF4
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGIF3g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:36 -0400
Received: from mail-eopbgr720099.outbound.protection.outlook.com ([40.107.72.99]:55635
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfGIF3f (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM6LXe21bxfnEOgkjw0esHJy2YH0StPS34KBLCVAbGspzYDQN70ruRjAoMl3D7d0Prf4KRfDT/eHBB5dohlVxaPzWRazy3b9A7zPmW6335VO78OdjYfq/nv/PVvB5d4bG9DVl6F2t4I//1kbNkt3lFI+OBODYpr1MLfTh3IWnHcDBC/VFCaQ1lylQw58K5YrPT3eAQDO5rUlhCVSTBqllfs4fnusRqQ7b7FxuFQe5f2Hj81MpMeFSyHUdw8gdrFMBM69YgQv6nNy+d3tUU8vxFMgaq0q1PFjtNhsqfdylV8u1BZWPukPu6qxY9cajP0MuW103c/v8iVAiomvYIRTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTEl1pTnokh+SyZdo/V29x8OaJfBdakWT+kVgr8Z6fU=;
 b=OtAW5+By9LXuY7dE9c6t1j6hAw+Cn1+3Eo0uDKrjVbIewFjxYwO1aPeFQTVX3v9Iy4FyrN7U1SzCxQoiuAgg+mHjDig3d1f0LLWz8qqIOls43nH6jOt9Cr7A7lG0QoRb8XGHk+U88UNQWCjgWCfL+BZDj04PgE+VlATFzjrZoLLc3Lh8mYhU3dBT/u+QqWJaDAnP5HOxovEINekPfCDuSWSpj6ZH4iIp1MAkmHGNRDT4+5bB8hr71mFGNni4bO6Lm8nZtwRJq6D/sCFtan9JCUZxpR9eXjA7khP3s48K9YKi1kuLm+1QtLIGDse78MJaxGF+CHCkQnqP/VFxCdjMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTEl1pTnokh+SyZdo/V29x8OaJfBdakWT+kVgr8Z6fU=;
 b=J121fhe/atXF5uN7ejjXDSE0SAowbZhOO5kUl4OYHJKiJTLagp5HQPb9loapM2mh4O5lbNTW0xHCx56SkGAL/E/4wDZOhaDoIteHn6FK4gQig3vjUM7vfy7JS1/Ac8Pea1f57kJVgUF+DMQ3egT+hQtRkvMkgLc6y/i/UKuLp6Q=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1358.namprd21.prod.outlook.com (20.178.200.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:29 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:29 +0000
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
Subject: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming from
 hibernation
Thread-Topic: [PATCH 5/7] Drivers: hv: vmbus: Ignore the offers when resuming
 from hibernation
Thread-Index: AQHVNhdH8aFqGiLrTEatSyXrBZPO8Q==
Date:   Tue, 9 Jul 2019 05:29:29 +0000
Message-ID: <1562650084-99874-6-git-send-email-decui@microsoft.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 153fda23-0f81-438b-8cf0-08d7042e6a41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1358;
x-ms-traffictypediagnostic: SN6PR2101MB1358:|SN6PR2101MB1358:
x-microsoft-antispam-prvs: <SN6PR2101MB135899AA17194041409193D4BFF10@SN6PR2101MB1358.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(86362001)(6512007)(4326008)(53936002)(110136005)(25786009)(66066001)(4720700003)(1511001)(107886003)(52116002)(99286004)(6116002)(3846002)(316002)(22452003)(54906003)(43066004)(50226002)(2906002)(3450700001)(6436002)(6486002)(6506007)(386003)(66476007)(68736007)(76176011)(186003)(10090500001)(102836004)(26005)(14444005)(2501003)(256004)(5660300002)(64756008)(66556008)(10290500003)(305945005)(7736002)(36756003)(73956011)(478600001)(66946007)(66446008)(81166006)(8936002)(11346002)(446003)(2616005)(476003)(14454004)(71190400001)(486006)(8676002)(71200400001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1358;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EyTIrqLxZ1p59sZvfdwgPRYu3gt/voj8JFTxKtRXrG5qEgvrFjAm/yMeTSxmxFwssuu3rzMo12FKrDoAAJf4tfskK8vOoJUe8uOFYGtbFwkVI7zLBpageYXAv3iYSMy85M/lc7llIu1hqMadhlCZynq/ffjn7JkpVKpKPOG+hDOm3eu3wJvMV5CWHrXCDnYm8VPHaySH4BOi+jNwKGNpasTZVossYtqcmTQfJRoKciw/p9UUSBaFCiNI/STiZ5gDwj82Ex8M6dGeJ4kdLKRAt8R464IVjxf3qdOSaeHw5Xdq0Imket5LDZVIiPrj78lAAWtmTsKHFlhBTageUR80z7fuYvLv5OLmPi85CkYto+qCvI4sqrN6E/Sh0c8I354ekHI66WG+v/QlNis2NHZhjihXcZqc6NoSKWUSv3wACQo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153fda23-0f81-438b-8cf0-08d7042e6a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:29.6130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1358
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
 drivers/hv/channel_mgmt.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index addcef5..a9aeeab 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -854,12 +854,38 @@ void vmbus_initiate_unload(bool crash)
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
+		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET, 4,
+				     4, &oldchannel->offermsg, offer_sz, false);
+		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET, 4,
+				     4, offer, offer_sz, false);
+		return;
+	}
+
 	/* Allocate the channel object and save this offer. */
 	newchannel =3D alloc_channel();
 	if (!newchannel) {
--=20
1.8.3.1

