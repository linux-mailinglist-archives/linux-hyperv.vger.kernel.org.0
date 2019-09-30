Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90C4C26A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2019 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfI3Uie (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Sep 2019 16:38:34 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com ([40.107.3.103]:38787
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfI3Uie (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Sep 2019 16:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V100/ncP1ZCn1VlFtDtXI1juYVDyd3wONJrV6ltT7OsRjbY8y/HpqhxaZg7skuiNhXjHQ7lOtGGHGr9Deh4irWDS8lGdzGz5PUrPkBWzJ8vswXM08YfBlQ2PWxjV7nRLR2X+wyJkvCJ8+lB5xUrcTQoe89uYhqEJ/lg9UFPas2fxuU0TD0llmXDHUgNn5J03eS3jZcASaPutZFZaVEIdDT0tNeDF6cVRsiNNOtfniCSIIPIQYYm2wNyM5Cv6T5vql5CcER9uWDcf7rB9BxDjkYoRj/p6LW9QoA53D8SEl0hpgMZ/o1XU+J3mZW/d1+ZJRnFBn8FCyqQToYoyb1wTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUL/gxQRJkx6o5iqAU4uhq64IBw13J1KOJkiYkGiQoM=;
 b=KbjW3vaaafp2Y7Eo2MjM4swiQwoy7jGRhgNrtzUTnrLgcfTlcX/w6azcqMMtd73gaRZvmdvzF8nooKZlxwJl2FEw6+7kZHznYpvC/16EK5kNvLi8GZL04Gcj1GjZbmHKQTCiJrb0lfCq8cIIb/QxRAVkK97gaBYJetwQ4Y1/oaD7RONrhWTLHowGmRNnT5BNE9zLacrHEwnx1OR+h/U0q2u/Bx19OSfcqbczhIqVuoFl7FY2wvQs8QF4DlPuypAUOYTnKTmlQWIOhM3CfLKaOAvS2QreJhCUYa4phYVWnCdV/jMyLBE7HkBKUw9jUbIf5qNKc/ytSkiHeWIzUo1rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUL/gxQRJkx6o5iqAU4uhq64IBw13J1KOJkiYkGiQoM=;
 b=XIAoqFeu721f0vIJEiLx8ZeemATyTq/GoH5OcFEXjSM01YK0Xl1EN0KPB+1Fz2NZmob3ml9mjHWAyHjsoBFYET0TDjw1ZtZdgOqLhfAWnCBqKRFIZCpjb72zFuVKYqs5zXOqEB7sEXFSWckt/xE/6TuEizJUS6gy3SiNHif4olQ=
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com (20.179.36.87) by
 AM0PR08MB3954.eurprd08.prod.outlook.com (20.178.202.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 17:33:41 +0000
Received: from AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3]) by AM0PR08MB5537.eurprd08.prod.outlook.com
 ([fe80::a8ea:5223:db78:dd3%7]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 17:33:41 +0000
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
Subject: [PATCH] x86/hyperv: make vapic support x2apic mode
Thread-Topic: [PATCH] x86/hyperv: make vapic support x2apic mode
Thread-Index: AQHVd7Uz7GLeEx2RZ0ukSyO6D+H5XQ==
Date:   Mon, 30 Sep 2019 17:33:40 +0000
Message-ID: <20190930173332.13655-1-rkagan@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0241.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::17) To AM0PR08MB5537.eurprd08.prod.outlook.com
 (2603:10a6:208:148::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd9e317-1093-430f-ed6b-08d745cc558f
x-ms-traffictypediagnostic: AM0PR08MB3954:
x-microsoft-antispam-prvs: <AM0PR08MB3954D52D4D5179D11AACDEF4C9820@AM0PR08MB3954.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39840400004)(396003)(376002)(199004)(189003)(6512007)(1076003)(2201001)(4326008)(86362001)(99286004)(478600001)(2501003)(2906002)(52116002)(50226002)(14454004)(8936002)(81156014)(81166006)(3846002)(8676002)(6116002)(6436002)(102836004)(6486002)(66066001)(66446008)(66476007)(386003)(26005)(186003)(316002)(1511001)(6506007)(476003)(25786009)(486006)(2616005)(305945005)(66556008)(64756008)(71190400001)(71200400001)(7736002)(36756003)(66946007)(7416002)(110136005)(5660300002)(256004)(14444005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB3954;H:AM0PR08MB5537.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46tZ8n/dj5uKvHz9iulYq+EaHaWald0SRU9t85AZCICfsEdV8xkNbnExJAr5J2kn37zqHxMOpSwlzrAo/2tzhajndVsDXQcvNYy1x4q9DnbIZKbxbvucyLhBz9DcOqdrZDFhX2vAsdSK6/X+v4XuLD9CBdJKjUlF93v79DFpct3HoXdQa8J8YXJ1piecSy2O9tMNxhAIxezTSzvCKsEVxreupvp1hYE5+CWVl4OBrxL8VFUnj6jn3J7KVED8JDuu8edSkNa+5/FurxGD4UnDQDWPvkc64CBsYXQD0nvTCGcJREXIaG8FxgkJYFIxmdIbqMo7fyVbS29QTPg/uBtNjc9Y66F7umY7s3wBs+OYDLQosc7bf1rzPv2oV2lgHEB9ARaSzR+7LO1edxn3P1nB75gC9Ml/VHo+yb1tmT0aJ/o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd9e317-1093-430f-ed6b-08d745cc558f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 17:33:41.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3mkV5k6K15VZFpYM5pNmyJM1JXRLdlFnM3VsI7GFtcysXR4IrHPdtI102reKDvnUfCFebR3wptS8x7q3lmF8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3954
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
 arch/x86/hyperv/hv_apic.c | 48 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 5c056b8aebef..9564fec00375 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -53,6 +53,11 @@ static void hv_apic_icr_write(u32 low, u32 id)
 	wrmsrl(HV_X64_MSR_ICR, reg_val);
 }
=20
+static void hv_x2apic_icr_write(u32 low, u32 id)
+{
+	wrmsr(HV_X64_MSR_ICR, low, id);
+}
+
 static u32 hv_apic_read(u32 reg)
 {
 	u32 reg_val, hi;
@@ -70,6 +75,23 @@ static u32 hv_apic_read(u32 reg)
 	}
 }
=20
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
 static void hv_apic_write(u32 reg, u32 val)
 {
 	switch (reg) {
@@ -84,6 +106,20 @@ static void hv_apic_write(u32 reg, u32 val)
 	}
 }
=20
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
+
 static void hv_apic_eoi_write(u32 reg, u32 val)
 {
 	struct hv_vp_assist_page *hvp =3D hv_vp_assist_page[smp_processor_id()];
@@ -262,9 +298,15 @@ void __init hv_apic_init(void)
 	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
 		pr_info("Hyper-V: Using MSR based APIC access\n");
 		apic_set_eoi_write(hv_apic_eoi_write);
-		apic->read      =3D hv_apic_read;
-		apic->write     =3D hv_apic_write;
-		apic->icr_write =3D hv_apic_icr_write;
+		if (x2apic_enabled()) {
+			apic->read      =3D hv_x2apic_read;
+			apic->write     =3D hv_x2apic_write;
+			apic->icr_write =3D hv_x2apic_icr_write;
+		} else {
+			apic->read      =3D hv_apic_read;
+			apic->write     =3D hv_apic_write;
+			apic->icr_write =3D hv_apic_icr_write;
+		}
 		apic->icr_read  =3D hv_apic_icr_read;
 	}
 }
--=20
2.21.0

