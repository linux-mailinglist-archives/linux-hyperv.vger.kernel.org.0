Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F1A5E93
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Sep 2019 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfICAYB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Sep 2019 20:24:01 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5728
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727975AbfICAXY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Sep 2019 20:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REHKbJt1RdMQsvulKU487tNj5UQOFuHDmyCRZ7WrlWc9FVeAJ7HPo2jqIkgQw+5VCofZmQLor0Hz3l9/oTxpP0o9i8RuMYXHkPhEoJIlDShZrtFcLn9lvevIeaW1YSyEBDwvHHJcgcMqLBADCqXwYc3YOFgJ2boI8JrBZIy4B43ce/gobPjjqKpaPH7uEvCqBQTkb5xYj74tDyA0hB75DNRVgeZBhxugAj3Z9Exw01UQ0UH2bqvez47dn0RxB/txVL8ij6aw8qrmkSgbP0c6OOqdN/Du2Qgk40UmS7GxuWwFwc7yQg4qmmpeM1vcjP6B29lrfAngI0inMBLJiVP/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z+u/v8C8a0GLr0IhEtkFheT/AVc0rnj126BVkAvsCA=;
 b=UKqAdn0Br7qYZTjDq0PrBejRJ05Jq/vLj5S8tIx1Xbm4Is+qdu4jxKjTfReQjyliU4mA2m6qGi5JMgKN5D0MBcqZHkmhk2zWzumXdQiJkgZwK7vbKjGsYxM0Ho6+db9VdWUUyT6nrLeewHPkJLOtHoQdkEY6dQ/drW/5+5EXUU5YV9D91PUgzL+aDNW6Nb68VCbZ1shlXtvqgITgmgoIlg4ra+azOr2wk9KEGoeAzm967jILqVfhOVTKYRANwUmdR7zj7gYK7ScCD3BQl/Ji4kq605UVz91agNYavUZagZeFIEsB5E140e6eeRGCTla/Un7Z0iO2j9hE05SBhKA/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z+u/v8C8a0GLr0IhEtkFheT/AVc0rnj126BVkAvsCA=;
 b=ePGh8Qb9mLdWenkqBj6cypweCwl3z/j7PuQzKrD3v9AUJjvfV/Z9kIfissPt4C5e1rzib1z+qrLReUkLk9kHDKrKIl5FDhjZGvYcp1DJFicjYKqVm00q9vH//ZCkTc1Se/Rjf2Lu2SRWomX1GjEG5JF6hlmZyCGg4IoP6bzQusc=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1054.namprd21.prod.outlook.com (52.132.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.2; Tue, 3 Sep 2019 00:23:18 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Tue, 3 Sep 2019
 00:23:18 +0000
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
Subject: [PATCH v4 03/12] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v4 03/12] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVYe3JFM9YmiWmnEOL4URgoQofWg==
Date:   Tue, 3 Sep 2019 00:23:18 +0000
Message-ID: <1567470139-119355-4-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 2a4eb402-5857-4a6b-b702-08d73004eb82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1054;
x-ms-traffictypediagnostic: SN6PR2101MB1054:|SN6PR2101MB1054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB105483089A0047C516818987BFB90@SN6PR2101MB1054.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(199004)(189003)(6512007)(66476007)(66556008)(478600001)(10290500003)(8936002)(3450700001)(52116002)(15650500001)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(8676002)(50226002)(53936002)(446003)(76176011)(107886003)(2906002)(71200400001)(3846002)(1511001)(2616005)(476003)(71190400001)(6116002)(486006)(11346002)(2501003)(66066001)(86362001)(36756003)(22452003)(110136005)(64756008)(386003)(6506007)(316002)(186003)(54906003)(10090500001)(4720700003)(102836004)(6436002)(6486002)(43066004)(4326008)(5660300002)(99286004)(256004)(14444005)(66446008)(66946007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1054;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J4aNvw+2wADlA3EzqMKoXOhTL3B34AT3IFu2O4RqXuDPRiOO958pB7dp7gtrehnkEt7Uc1Ny85zdURin+X1QPEWVJHCHTw0tWx2GAOcIC42uIszQt3xKmhqGYEL6GXwLtr9FZaO4XQ/lEJLiukr/foO1ojaKRBtKVYzlyWeZjBrIPKHzaCgIZT1o+WqYsX6kB0CBqtwvmQiuqhN78Z6f/VrTLMkWpDu5TygnBrb6hlQvnLPsKpgH4Trx6Z1DesGnak9goXp2+3B8seQtTKbEFXCSbj+3fsfZ68EGiKcB6rtLQHUu0DLVNlEuXmwFVZJwaOHvaZo1zPY3a570gJcDJcEI6/wJaBm9hFXuKv5yW6v+ldIHsJpvFPwPYzCMf5BJ24kyDA/niNbaTnDkwzdAEvTyAdVd5mAS67HKto1BgYA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4eb402-5857-4a6b-b702-08d73004eb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 00:23:18.7168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iYyHHhQWYQgDnDCrQ9JbOyuzGGEjOPkyq5ZmXolUW1QIFKLGQ8rLOUPX176VRHrbhIOwGQ4JuJrr5bd8ZLX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1054
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's=
.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 17b96f9..8f3422c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -238,12 +238,37 @@ static u64 read_hv_clock_tsc(struct clocksource *arg)
 	return read_hv_sched_clock_tsc();
 }
=20
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D GENMASK_ULL(11, 0);
+	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc =3D {
 	.name	=3D "hyperv_clocksource_tsc_page",
 	.rating	=3D 400,
 	.read	=3D read_hv_clock_tsc,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend=3D suspend_hv_clock_tsc,
+	.resume	=3D resume_hv_clock_tsc,
 };
 #endif
=20
--=20
1.8.3.1

