Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF17CAF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfGaRwH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 Jul 2019 13:52:07 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:44032
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726514AbfGaRwH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj9njEHrGCZsPkpkyuhLmQASH0PviScpMxfKfOrWJPaH6FNjgeBuI4R3DEzHExNKAEAgq/POh9NHy3YaDjqT2La5sfP4dTJPgaMxYJVSTh9i/8hHbyk7OtT1Gb4mTv9rzFb3dwduqGIabS2O6Wc10eO9dwGsYbmx+cUxpmSANj01XdbPXwZBZwwZ+PurlOZ9V2GK5Dj0vCF4BxCm5eFs9LgC/T2Q1TllnEdxopalw6ebO/NWw2H9925foDwaC5oVsiUcacidco3pc0Fm7MpeI2aAnfghf0hZeztNkDqwYpWiof7XSS82pYzSjTAdWUehi65ydMJMSiTAJLAngnJMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3/LpI6GzC0G8JJlb9sSCM3Rh3OhQ0IrZOdOtv8ufSI=;
 b=Yoi6eTOsGFx1vqqWSZtutWST2RoIFNuoVutdN7K3QWT2AGd+IfWIRGW0wKShbhpHKz0MLkCu5FL1kyaF7k8Hwge9FxpG2zQA7RWZXXPpNXNDSxuYymsQTms/DoCNfecf+cKfHPS2BmzL+hlZi5ViWW+dL0V7bfSsqExzITUh9xvh66ICxDQWjcp6Cm+RJcLD6dWdIa0iCrHV/eyedt3nfgWtJof445LmRaJv6AIBLEA4kXetDbIt84mKvaNSPnKtHGxpSTVf9ErCua+fLnhnkTWptXycOz2JunD7Ikd3xnxaa6QiRBBnet9EcCECeOPNpMhnZcpbyf5yVtimWH0WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3/LpI6GzC0G8JJlb9sSCM3Rh3OhQ0IrZOdOtv8ufSI=;
 b=UwhbOjKWmMzrEelHCG7TBO7x9RXrTlzD/JbT0izXQK63kZXCni3CTcSwq26VHGTHwBexjbjvyFO1zfUF6aPOJWN75AEgyBuni3SVJN4RnsXqnIneSmRuqrkvYXzMgTbEIAYXbcjFeriDZdGJHLYTGg7whluZGlSUtxNIr5qVdQQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 31 Jul 2019 17:52:03 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::d0c3:ba8d:dfe7:12f9%7]) with mapi id 15.20.2157.001; Wed, 31 Jul 2019
 17:52:03 +0000
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
Subject: [PATCH v2 2/7] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH v2 2/7] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVR8iouPBk654/00attUBlTQo7kA==
Date:   Wed, 31 Jul 2019 17:52:02 +0000
Message-ID: <1564595464-56520-3-git-send-email-decui@microsoft.com>
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
x-ms-office365-filtering-correlation-id: 5dc709f5-268c-4e93-9708-08d715dfcb31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1120;
x-ms-traffictypediagnostic: SN6PR2101MB1120:|SN6PR2101MB1120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB11202BC6B3B10010A16C8120BFDF0@SN6PR2101MB1120.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(68736007)(10090500001)(36756003)(76176011)(53936002)(6512007)(54906003)(3846002)(305945005)(52116002)(4720700003)(8676002)(3450700001)(14454004)(6436002)(6486002)(99286004)(8936002)(107886003)(25786009)(81156014)(71200400001)(81166006)(71190400001)(6116002)(446003)(66946007)(10290500003)(22452003)(486006)(7736002)(86362001)(11346002)(476003)(1511001)(15650500001)(50226002)(316002)(102836004)(478600001)(66446008)(66556008)(66476007)(64756008)(256004)(4326008)(14444005)(2616005)(186003)(110136005)(66066001)(6506007)(43066004)(26005)(386003)(2501003)(5660300002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1120;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MVxvzh03fiqkR/zAtotFAH8kbm3yC/YnLZymZZw+LHohGoevchH9wgXvPg2jBfMQ41/jT1aurWDk2wSvsjeFrOD1NcpYkrZt+G4G2sEUXxuTcqv97a7vASpoilJgSVqvlZxG6EEk6YCI3qe9G8iEV0q1uAQPdnGjiXKauwpnfpiJnKSgwTYXXjupwJaCtgr819UiI0RMddHW/RXipHUJZppFR0A9CLhFuxs2wWMmX6hWD0U4OUJ7hnp1yc+3gGh2omFt9xJ5m8xtDpacGQarEFKNGToQY9s/kQVp/+Rnq9WXKLR11v6j3FuCTSDpOdXexRq3CpU3XZAnzZKXuqbFLVP6SdjUnIre9VvGd1cSB/QUImp7Mhw2VTafhZpZhxyP30LP3A9zIu8HckflmR9ZRpdm0oBeRpUzv+n/0wIloYM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc709f5-268c-4e93-9708-08d715dfcb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 17:52:02.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPU9EUMyj8BfvhtNYDUDuWZyKfuzsTLL6SHxMaIRRWnPhamzP/yBPGowrGROV0fvj0BiDdpKZ/Bf9YKV9+uJMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1120
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
index ba2c79e6..41c31a7 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -237,12 +237,37 @@ static u64 read_hv_clock_tsc(struct clocksource *arg)
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

