Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA419C4B3E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Oct 2019 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfJBKUP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Oct 2019 06:20:15 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com ([40.107.2.115]:31977
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfJBKUP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Oct 2019 06:20:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQTKo4470sUFZP3UCvS/oH3lOU4uyRGSu5xTmuT1/NRKrdMoJM6x7xclWF0UATdRk57tUbo+IohzNHYRX8cP8ryHyt9dbcKOMGUfMmFhxzJRW724Niop8O3pXJrhW4c54ak9kfFqk44LCeVHjGreUS06WBwY4Fo9cfV63UO2XX04cF5i92em6MFwGxb6efOujx1R/r42VmZ5lejzy07Dhj7mHXUrmtHLpEfZrgQW3mKQZEQLBxVOvJPXeoLGN5A2EeDSiXvH3W5WgW5UPNOd2YUfbncsjr/nqu/TK3Gzn7FXClumUcq2NC9pkn3JmuapQXbmIJcqth+yo3BKPWIGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teYjUxnfLXRvMoHaB7k3rl6IWtZWWierVtlYdyFJjZ0=;
 b=GZgZ7NiDavF83c1frYRjdJpnsdCarYqxwipIz5DrPajVErMB3HyRB02PlPG+PC8OTUHFgZPrhohyf7uipvFeAG+6qVwaaEI/0cleM+gMcu1ulGgb9YaWEVQxNu8VO+5YT8XgnCB8wKB2UChPi/8MYbQD7+/vTWzF2XQWSPukyOe4k8P+A7ekxvZWvpsrJi2q/4NS08cY1NA7MvD4yPHETuRtwPlOo6kTTyYMJuyEvGwfmX9Nr/k7OnBgrjFkP1CniGPdayPxduazRK5Qi3Ht6L/IoPTs6wiCEX2V6n9NQWWtYhQC6jx7wph0dE+KywxTk2rQ9W59kR5ec8oYER8XhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teYjUxnfLXRvMoHaB7k3rl6IWtZWWierVtlYdyFJjZ0=;
 b=TowX03018vR7oSKrUxQtIMSupDgT4qeDDlMvmvKj+/3PXEe18F4IUdV+X3gEP6sFHHVB5WInCQ2qUl4bpx+vpPBiQMpNwNwNh5voFqJ+6whZcv9i1wC3cbnREm7M8N0grpaLztJ0HGHWiVf6CeJyYLl1BkAt9f3ZJpNOnQsVisM=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (20.179.36.87) by
 AM0PR08MB3844.eurprd08.prod.outlook.com (20.178.22.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 10:19:30 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3%7]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 10:19:30 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [PATCH v2] x86/hyperv: make vapic support x2apic mode
Thread-Topic: [PATCH v2] x86/hyperv: make vapic support x2apic mode
Thread-Index: AQHVeQrgrl6z6kaUqkyr6D3zFBAn2A==
Date:   Wed, 2 Oct 2019 10:19:30 +0000
Message-ID: <20191002101923.4981-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:7:29::48) To AM0PR08MB5537.eurprd08.prod.outlook.com
 (2603:10a6:208:148::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dca16743-704c-4b16-b003-08d747220324
x-ms-traffictypediagnostic: AM0PR08MB3844:
x-microsoft-antispam-prvs: <AM0PR08MB3844BD7556A066C2EA3CF868C99C0@AM0PR08MB3844.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(366004)(346002)(396003)(376002)(199004)(189003)(486006)(86362001)(81156014)(8676002)(81166006)(4326008)(25786009)(99286004)(8936002)(1076003)(71190400001)(6486002)(66476007)(66556008)(64756008)(66446008)(2201001)(71200400001)(6436002)(2616005)(476003)(2501003)(102836004)(110136005)(5660300002)(186003)(478600001)(52116002)(7736002)(6116002)(3846002)(316002)(2906002)(305945005)(1511001)(14454004)(14444005)(7416002)(256004)(6512007)(50226002)(66946007)(26005)(386003)(6506007)(66066001)(36756003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3844;H:AM0PR08MB5537.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuFvy4Ej0x1Ys6P9L6/eS0o46QOQdZY7lx5u0QexIdHOyqS2Ei2DOErW1Q9fVVYwNTeQZBRQWyvA0CvjLwFKMARqb8sPB38iE6321TS+Khvrx7EYHMJfEc5ecTUkeeoJXIjV5y9hJ5JwispQePT9tYY+bl0P/xkRdb3ZW78bHMfeNTCDQZYLAk1+Ux6TZdV5s2M+ENDGzbKVbJc09qnrUUFIt9qznoqQyeW2RTRpExZtfUy+JA844VHG8BJZVlo9WfNLyDccV/OTYgfW8Ym455RpTDqyI1u4bjeykFgtYpZQMQgHvn0cKnJVTwzLg3Bevz+lDpwzDM2fmo51myMILI/7mesI2fsLB1IBmXnW6fwPJsKto9MFqoE405HlvFvPpOJ2rS7X5VD5oT3rik438VGFmiQKdFrUX8JNhzPSwC0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca16743-704c-4b16-b003-08d747220324
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 10:19:30.6209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mElhHLYs8j38eJaROShcUpGtNcwYsYFKSwDh9qwlor+xI7IgSMO58xKwBWdaypFWy9hUm7GKpp8wxwl4DzILtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3844
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

I didn't manage to make my instance of Hyper-V expose x2apic to the
guest; nor does Hyper-V spec document the expected behavior.  However,
a Windows guest running in QEMU/KVM with hv_apic and x2apic and a big
number of vcpus (so that it turns on x2apic mode) does use enlightened
apic MSRs passing unshifted 32bit destination id and falls back to the
regular x2apic MSRs for less frequently used apic fields.

So implement the same behavior, by replacing enlightened apic access
functions (only those where it makes a difference) with their
x2apic-aware versions when x2apic is in use.

Fixes: 29217a474683 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
Fixes: 6b48cb5f8347 ("X86/Hyper-V: Enlighten APIC access")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
- add ifdefs to handle !CONFIG_X86_X2APIC

 arch/x86/hyperv/hv_apic.c | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5c056b8aebef..eb1434ae9e46 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -84,6 +84,44 @@ static void hv_apic_write(u32 reg, u32 val)
 	}
 }
=20
+#ifdef CONFIG_X86_X2APIC
+static void hv_x2apic_icr_write(u32 low, u32 id)
+{
+	wrmsr(HV_X64_MSR_ICR, low, id);
+}
+
+static u32 hv_x2apic_read(u32 reg)
+{
+	u32 reg_val, hi;
+
+	switch (reg) {
+	case APIC_EOI:
+		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
+		return reg_val;
+	case APIC_TASKPRI:
+		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
+		return reg_val;
+
+	default:
+		return native_apic_msr_read(reg);
+	}
+}
+
+static void hv_x2apic_write(u32 reg, u32 val)
+{
+	switch (reg) {
+	case APIC_EOI:
+		wrmsr(HV_X64_MSR_EOI, val, 0);
+		break;
+	case APIC_TASKPRI:
+		wrmsr(HV_X64_MSR_TPR, val, 0);
+		break;
+	default:
+		native_apic_msr_write(reg, val);
+	}
+}
+#endif /* CONFIG_X86_X2APIC */
+
 static void hv_apic_eoi_write(u32 reg, u32 val)
 {
 	struct hv_vp_assist_page *hvp =3D hv_vp_assist_page[smp_processor_id()];
@@ -262,9 +300,19 @@ void __init hv_apic_init(void)
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
 		pr_info("Hyper-V: Using MSR based APIC access\n");
 		apic_set_eoi_write(hv_apic_eoi_write);
-		apic->read      =3D hv_apic_read;
-		apic->write     =3D hv_apic_write;
-		apic->icr_write =3D hv_apic_icr_write;
+#ifdef CONFIG_X86_X2APIC
+		if (x2apic_enabled()) {
+			apic->read      =3D hv_x2apic_read;
+			apic->write     =3D hv_x2apic_write;
+			apic->icr_write =3D hv_x2apic_icr_write;
+		} else {
+#endif
+			apic->read      =3D hv_apic_read;
+			apic->write     =3D hv_apic_write;
+			apic->icr_write =3D hv_apic_icr_write;
+#ifdef CONFIG_X86_X2APIC
+		}
+#endif
 		apic->icr_read  =3D hv_apic_icr_read;
 	}
 }
--=20
2.21.0

