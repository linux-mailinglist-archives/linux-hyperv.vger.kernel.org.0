Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BA6D950
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jul 2019 05:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfGSDWr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jul 2019 23:22:47 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:1152
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfGSDWr (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jul 2019 23:22:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BexL4rknCQPPiVi2AM+U9TP4QLJ9IfBlRDJG+szsk+jLRLOuW+Ltwr17+r83d94dZG6S3ifx9vawfMos7iYge4JXaiDsg1SDljOy8lpVrL9g3HIhGh5Biy7gkVmaIrX7WmLRUK3mg+8KlY1uqnGykvgiRjNQMbk0atFVg8Y1T556ClGr+mgl2GqRfNpDH5mu2D142soHoeCcpaUszZhCwN8jFHTQNUclLJMhicsBJJ8+HxQg8kLrqOVj3Gl1iyfXFsattmSwCJSRM62tCalCTzPP5gDgf4ylG/l3PGyTP8CsrB2GkiCS57EBu6OVYf9jJ+UwjJS7ntnjL9p/kTfRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7OOzUXIkXNQVKBgq+RH4TVBKG1F7aVKkPsCj4wkJRk=;
 b=DFfjh42igKyXlwqKYINxbbMZXzsWrSjYLYhNS3v4ocLRhUBF2j8PURBMopz1wh9bHREvk3Sa6Wsd1hCXYDZegdBkC554obTNu6yOsItQMJGQWvEDqWeMlJr/pqRZb35gPUpM/Iv5wZll0OicbqDXua1G2CMCUjMUQJKbzZouo+uEgnQ70SONdrgAdPPKp8rhOBsiG6QWFQtJbAeAotFin+9gl1lMibai+5AjcWgdQe2WiqcKzhfzuxYguL7U5m+4pdmTmBOC5Maly1r/I9IVzFsQNcPuIXiM7gSBRJjRZYWbJF1u9GgHjVudGW6+wx4qjq3K3Ra4KIp2rTtcFljK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7OOzUXIkXNQVKBgq+RH4TVBKG1F7aVKkPsCj4wkJRk=;
 b=j4Yq7cnsqlQ1zi2kNzDcCM2KtfeWmvj7Fa2bKK/nSFqYtKI9bqhaHxCtUq7p4yD1kwDsz6btPgaQvNQOIpdW+KMy1p1KeJGdo5OKlk0Hi0jz7w4h6Lxc2r3CYUEzGQ+PZ1x40dR1tkQhvDV64gfXM/CTtoTBk+Mk8znhFYj4ND0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.0; Fri, 19 Jul 2019 03:22:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a%5]) with mapi id 15.20.2115.005; Fri, 19 Jul 2019
 03:22:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>
Subject: [PATCH v2] x86/hyper-v: Zero out the VP ASSIST PAGE to fix CPU
 offlining
Thread-Topic: [PATCH v2] x86/hyper-v: Zero out the VP ASSIST PAGE to fix CPU
 offlining
Thread-Index: AdU94G2xIVn7CyIeS/6O8LXGJUvDAA==
Date:   Fri, 19 Jul 2019 03:22:35 +0000
Message-ID: <PU1P153MB0169B716A637FABF07433C04BFCB0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-19T03:22:32.0829896Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5dd41e98-2884-4d2f-a875-9f8196cfcfd0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:515a:5ef4:7d96:37ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca99e34d-d1a1-4f62-0bd1-08d70bf85897
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:|PU1P153MB0140:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 2
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0140949E76B7A4464D0092C4BFCB0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(54534003)(189003)(66446008)(64756008)(66556008)(55016002)(110136005)(54906003)(99286004)(66476007)(66946007)(76116006)(2501003)(14444005)(53936002)(305945005)(102836004)(33656002)(7736002)(86362001)(74316002)(71190400001)(71200400001)(4326008)(966005)(9686003)(10090500001)(478600001)(46003)(6306002)(6116002)(7416002)(7696005)(5660300002)(8676002)(14454004)(2906002)(316002)(8936002)(68736007)(81156014)(81166006)(8990500004)(52536014)(10290500003)(476003)(486006)(256004)(25786009)(1511001)(186003)(6436002)(6506007)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NmJdbnc8pJkJKQx+DtJV2bT+1Omc1g1NyB7Mokw44r+rkz7O5uTQoInNCZRg4ozFf+RmoIEBLrIZQ9gDquvG0xPM+ZVF1an/Cuut97VlEBudWSMmjD7WB+FpCI9th593MshAsUsb2KeI/sDxWJugJUD4Z2b4lR+67l+Rn5pAaDOF72129eThsEoUMR5TYlx809hDWBlRz3gtgjwCxDufp1+YIx3/c+/b1Cjohso/QRr6/I6Tpm5c0HDj7i51AiNTnWPiFKRp85G5T6Tx5USAaw/jpPAVIXpS3PG7xt49v0OHrPqiZelPbmLi5zWm7lbGrQiI6SLjR9YDvHb7oC4OKNMnGYTQoI6vg3rCOk+GFyIaiZeLsC+N6u1MydnNuUnsjClbZYpxzvQaxx3Be5MdxtwDgFy9JwWwsKHdreZMLjk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99e34d-d1a1-4f62-0bd1-08d70bf85897
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 03:22:35.7586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
5.2.1 "GPA Overlay Pages" for the details) and here is an excerpt:

"
The hypervisor defines several special pages that "overlay" the guest's
Guest Physical Addresses (GPA) space. Overlays are addressed GPA but are
not included in the normal GPA map maintained internally by the hypervisor.
Conceptually, they exist in a separate map that overlays the GPA map.

If a page within the GPA space is overlaid, any SPA page mapped to the
GPA page is effectively "obscured" and generally unreachable by the
virtual processor through processor memory accesses.

If an overlay page is disabled, the underlying GPA page is "uncovered",
and an existing mapping becomes accessible to the guest.
"

SPA =3D System Physical Address =3D the final real physical address.

When a CPU (e.g. CPU1) is being onlined, in hv_cpu_init(), we allocate the
VP ASSIST PAGE and enable the EOI optimization for this CPU by writing the
MSR HV_X64_MSR_VP_ASSIST_PAGE. From now on, hvp->apic_assist belongs to the
special SPA page, and this CPU *always* uses hvp->apic_assist (which is
shared with the hypervisor) to decide if it needs to write the EOI MSR.

When a CPU (e.g. CPU1) is being offlined, on this CPU, we do:
1. in hv_cpu_die(), we disable the EOI optimizaton for this CPU, and from
   now on hvp->apic_assist belongs to the original "normal" SPA page;
2. we finish the remaining work of stopping this CPU;
3. this CPU is completely stopped.

Between 1 and 3, this CPU can still receive interrupts (e.g. reschedule
IPIs from CPU0, and Local APIC timer interrupts), and this CPU *must* write
the EOI MSR for every interrupt received, otherwise the hypervisor may not
deliver further interrupts, which may be needed to completely stop the CPU.

So, after we disable the EOI optimization in hv_cpu_die(), we need to make
sure hvp->apic_assist's bit0 is zero. The easiest way is we just zero out
the page when it's allocated in hv_cpu_init().

Note 1: after the "normal" SPA page is allocted and zeroed out, neither the
hypervisor nor the guest writes into the page, so the page remains with
zeros.

Note 2: see Section 10.3.5 "EOI Assist" for the details of the EOI
optimization. When the optimization is enabled, the guest can still write
the EOI MSR register irrespective of the "No EOI required" value, though
by doing so we can't benefit from the optimization.

Fixes: ba696429d290 ("x86/hyper-v: Implement EOI assist")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

v2: there is no code change. I just improved the comment and the changelog
according to the discussion with tglx:
    https://lkml.org/lkml/2019/7/17/781
    https://lkml.org/lkml/2019/7/18/91

 arch/x86/hyperv/hv_init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef11a9f..d26832cb38bb 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -60,8 +60,16 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
=20
+	/*
+	 * The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
+	 * 5.2.1 "GPA Overlay Pages"). Here it must be zeroed out to make sure
+	 * we always write the EOI MSR in hv_apic_eoi_write() *after* the
+	 * EOI optimization is disabled in hv_cpu_die(), otherwise a CPU may
+	 * not be stopped in the case of CPU offlining and the VM will hang.
+	 */
 	if (!*hvp)
-		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
+				 PAGE_KERNEL);
=20
 	if (*hvp) {
 		u64 val;
--=20
2.19.1

