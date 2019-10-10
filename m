Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F97D2989
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Oct 2019 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfJJMdW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Oct 2019 08:33:22 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:51810
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfJJMdW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Oct 2019 08:33:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay26mq05w/y77uUjxGA2gU3omDIgyQ1/Hu4+2+kNMdGUaaKMOlVoiS5JB5cEfYkrYeUQnRln4d/mMEiUWH7kK8fPwOgUf+7HcBLg8yh0QQrd9HkDytEGs2xt+FyxqOMV11EzZ0IA3lXid7UBPLDJG5PiKRJ5AwWchFBCr44K2P23kmB86tNxYZmqJPqynZVvrE7EY05pljY+ESX8/VHWWzvUn9vCX2gTJhacWHG2jD9fEVuV+RqBRYUOA0nNzJzHWMqAXvs2xxKx1bAwj5y+Tj0sFe/tRYODen6pdxu1FMHqoLqToSvIz67AxrPIXTLXoaTWPkpi82/hlSDwlyaPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrk0oUG60Jr/2lcLKT0L9p6LapgtXHX/LG9XubPNpmw=;
 b=BWyEfnAmRKUXmxHGEXYexNlr7mon1PLp9niDzr8EPtB8J8ucKIjadZInkz6Kj2ChPOs9CU87TI/IbJTJkylLNyj+RHQYY3GyUTqBVGNJqHy4mHepHfV9ug/IrMnWmeX30+vqnm4w66pdyo5S6U5TVwbRnQGG5OSwTUFD7YjyLrG9kt8Jjo/lU4y3sypHoCMlIfxicwCrQvEHiduyCRimDw6dggHTcxnxgXXruC2C03nGTrm+sU/fC4IYj6SdTtcKA/apRoW9zJ73HTzhm3uKQX9tzBsHyQ7433lOszMas8kO6aASKyJ2BquySpeG4uK6xTrHx7XjJlGizpirUH063w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrk0oUG60Jr/2lcLKT0L9p6LapgtXHX/LG9XubPNpmw=;
 b=lVZ70xQxwNpjxeyoaDa0o1tXnpn8fadRikV+n3XCHcgutql85k1I2ud/XDjMiT58drHl8YrxdCZ9oyrTZ9G9sv4TNkvkH1OX7gqGyZaO5+n1ZgdWFADmL0+h0DIF63GSzPkvK3CGq8V1RkeUVgJLtEBk0rGxW90BmhVqG6qExyY=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (20.179.36.87) by
 AM0PR08MB3953.eurprd08.prod.outlook.com (20.178.117.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 12:33:06 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3%7]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 12:33:05 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [PATCH v4] x86/hyperv: make vapic support x2apic mode
Thread-Topic: [PATCH v4] x86/hyperv: make vapic support x2apic mode
Thread-Index: AQHVf2bd3sDcAG/lCUuldIC8p8n4Qw==
Date:   Thu, 10 Oct 2019 12:33:05 +0000
Message-ID: <20191010123258.16919-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::14)
 To AM0PR08MB5537.eurprd08.prod.outlook.com (2603:10a6:208:148::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c6076ea-86bb-4fd6-ee67-08d74d7e0001
x-ms-traffictypediagnostic: AM0PR08MB3953:
x-microsoft-antispam-prvs: <AM0PR08MB3953803B65CFE212FAAB4BF5C9940@AM0PR08MB3953.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39850400004)(376002)(396003)(366004)(199004)(189003)(71200400001)(14444005)(478600001)(66556008)(81156014)(316002)(5660300002)(99286004)(71190400001)(52116002)(2906002)(110136005)(81166006)(8676002)(66066001)(66446008)(6436002)(26005)(6486002)(6506007)(1511001)(256004)(8936002)(386003)(64756008)(1076003)(6512007)(2501003)(66476007)(102836004)(186003)(50226002)(66946007)(25786009)(4326008)(2616005)(486006)(6116002)(2201001)(86362001)(3846002)(14454004)(7736002)(305945005)(36756003)(7416002)(476003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3953;H:AM0PR08MB5537.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QgMTUgx10hm4a7+gr7C7Nstc9JegdK7eKzYtERDa66Z9Yx1JUXMqS4NOLrNaYFrZCYae5D2bHcw/wpZGm3KYfVTAtCrnSNRKIpKU9MzAuljrK10ASvbkiZo7253615E/5nuzFygk7IguPeBT/worZ4Din2UeveW86/DT0F15Tr5hoJbbKxB1iGLTLX/trnRNNhzoiLYGYdudy8UJ66JdtAS/ItsOuOMwPLo9FBHxHZrxxpqnDS16WvXdWzK53PcxK15p5WY0FUjrF2w2Ldl45w24wmfZoH1iOcSgtsOA3AWXS5HmXRhBzFUJg20uZuMmqqIrfu5quES+c0+B1CNA1e17NjlLUoo8zQKhITFpFYynnDVzzlknztJ2frTyJAEDsHiQPom1wPUXYjrmAOUKqHi1O29yaqLHkXY6RjF0Xk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6076ea-86bb-4fd6-ee67-08d74d7e0001
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 12:33:05.8738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUrkhrEgdL6NseTTYaDK8cvu5MWPf+5NuF/xnluFppJdyRNHZI+oUnywM4SW0KaHawQO++85kjuZUA09NNVMew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3953
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now that there's Hyper-V IOMMU driver, Linux can switch to x2apic mode
when supported by the vcpus.

However, the apic access functions for Hyper-V enlightened apic assume
xapic mode only.

As a result, Linux fails to bring up secondary cpus when run as a guest
in QEMU/KVM with both hv_apic and x2apic enabled.

According to Michael Kelley, when in x2apic mode, the Hyper-V synthetic
apic MSRs behave exactly the same as the corresponding architectural
x2apic MSRs, so there's no need to override the apic accessors.  The
only exception is hv_apic_eoi_write, which benefits from lazy EOI when
available; however, its implementation works for both xapic and x2apic
modes.

Fixes: 29217a474683 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
Fixes: 6b48cb5f8347 ("X86/Hyper-V: Enlighten APIC access")
Cc: stable@vger.kernel.org
Suggested-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v3 -> v4:
- adjust the log message [Vitaly, Michael]

v2 -> v3:
- do not introduce x2apic-capable hv_apic accessors; leave original
  x2apic accessors instead

v1 -> v2:
- add ifdefs to handle !CONFIG_X86_X2APIC

 arch/x86/hyperv/hv_apic.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5c056b8aebef..e01078e93dd3 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -260,11 +260,21 @@ void __init hv_apic_init(void)
 	}
=20
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
-		pr_info("Hyper-V: Using MSR based APIC access\n");
+		pr_info("Hyper-V: Using enlightened APIC (%s mode)",
+			x2apic_enabled() ? "x2apic" : "xapic");
+		/*
+		 * With x2apic, architectural x2apic MSRs are equivalent to the
+		 * respective synthetic MSRs, so there's no need to override
+		 * the apic accessors.  The only exception is
+		 * hv_apic_eoi_write, because it benefits from lazy EOI when
+		 * available, but it works for both xapic and x2apic modes.
+		 */
 		apic_set_eoi_write(hv_apic_eoi_write);
-		apic->read      =3D hv_apic_read;
-		apic->write     =3D hv_apic_write;
-		apic->icr_write =3D hv_apic_icr_write;
-		apic->icr_read  =3D hv_apic_icr_read;
+		if (!x2apic_enabled()) {
+			apic->read      =3D hv_apic_read;
+			apic->write     =3D hv_apic_write;
+			apic->icr_write =3D hv_apic_icr_write;
+			apic->icr_read  =3D hv_apic_icr_read;
+		}
 	}
 }
--=20
2.21.0

