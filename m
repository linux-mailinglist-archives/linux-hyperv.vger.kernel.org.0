Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB2ED5F107
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jul 2019 03:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGDBq1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 Jul 2019 21:46:27 -0400
Received: from mail-eopbgr1320114.outbound.protection.outlook.com ([40.107.132.114]:1376
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbfGDBq1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 Jul 2019 21:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIPpBT6i+8PwK5Nh9kufbQIC8SYqQbvaf1v1bh5jfz7g8vjIv0sMxT3MbC5ybfQG74hwITtTyaPpGp2EyQEW0Mzco60lB0uQ+TQorK463qXSRN/XQ0WnWHF0fSMSoIPc9xPKBq+oCDDxEn89m9Uj/dWJLoN9odU/kPzJd4t5UjixGzcINujMAPdto/5SYL2rAOJARtXJJha10s2eio3RiCmFGi9ygh+tVvCgCPJGTQjYMkIYjg6iurbRZL0gGbVUduw3QJMvvs4veovRP1eXGRDUnVJ2IsEyZsFQQevQc1RYR7kXHETaIJyjQ+dyHo9bgWkrETPRHzk/eXoUYmbcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v6GVm6tGYty3JcJjdWZrKUTOKN41704m3N7xx5cBNU=;
 b=OP6RltYtvG74zaJGzHW5WsRh48VD1ll8eWGMewKuYFSbC5o3vPRB5STBt5uhzCyVEJP1wR4xPK4Hlveyk7/8j8zV+YlKmvSfVeowx25PQOTV4s1uV7oJiA3ryj4klUgemFFIBHJEa8DEtNNFhN20yi9j9v8He1NL43JheOo6/gpVZ5W/rEPIDaMYW/jYdQ1zY0kAo5U4oFgx0zRgPtHByFTECWrsm38sAg8/HuOrDeb7llHgt+uAkPr+sqPVH4a3zRqp1bCOEPpFNOV8dYoVqA6rDG8XVxCjbvngOf6401/piXQxqrvMfQPjCfDSol3PpT3y0kMVwTQoKoj2g2w0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7v6GVm6tGYty3JcJjdWZrKUTOKN41704m3N7xx5cBNU=;
 b=jKZJF7RDX4vaoSLqae1Lw2Z41LlSHoVYA5vhAaDvj5SsqVQfBifXOywJJW5/XseeFjNjy3QveNVNOu2Th89Gg51w5MTStFPTcqeei2p8jLv6nctklwQeJyiBs2UCwzQoJ056S01YmzYKmESItX2Fo6mplr8A0Oc2BlAVlVmeMKs=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Thu, 4 Jul 2019 01:45:42 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::61b3:885f:a7e4:ec0b%9]) with mapi id 15.20.2073.004; Thu, 4 Jul 2019
 01:45:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU offlining
Thread-Topic: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Index: AdUyCb6p1/Ch6raqSV2uCwYf/NBGWg==
Date:   Thu, 4 Jul 2019 01:45:42 +0000
Message-ID: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-04T01:45:38.3267647Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85e22f80-189c-4798-b8a7-1089c5ef2a54;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:418d:2241:ae9c:1f48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b1af2a1-bd21-482f-1a23-08d70021532d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0203;
x-ms-traffictypediagnostic: PU1P153MB0203:|PU1P153MB0203:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB020304C9BC265BA619871426BFFA0@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(9686003)(478600001)(46003)(55016002)(6436002)(486006)(10090500001)(476003)(53936002)(99286004)(186003)(1511001)(102836004)(6116002)(6506007)(7696005)(2501003)(256004)(66476007)(66556008)(64756008)(14444005)(66446008)(66946007)(73956011)(71200400001)(71190400001)(2906002)(5660300002)(33656002)(10290500003)(52536014)(4326008)(86362001)(76116006)(110136005)(54906003)(25786009)(74316002)(8676002)(81166006)(22452003)(8936002)(316002)(8990500004)(305945005)(81156014)(7736002)(14454004)(7416002)(68736007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mTod6tqUngzCSKu667o6BZtFT8dZxEYDyOvXXGNmRJrBPHYjNR4RQZHDtarzSXxRcf71072+/oTEGgdIyTKpU48SpSXlllfrDuu6eKE7xq0coMg/sxaLfJ6F0ghlgT75H4Qe1uYSBzDxBgUMwUA93ZB8FYGP8rLKOA7H9+gmj6fv7lCip4KrDVnEk/qqC9yad5hY5HzTE9MORL6eu2fOFkOL6FsWenbMbFSUFuI5nXGGMjYKQLp+smiQuCS97+Y4BkmGfyg8WsLZ56XvWdr3+OtsxihnP+ndGux7mkEo8T31x+qZAs1H7SWiUoXOARSDqfF30Mru2EpKkiDXCWVFdvJAzPLcfKzHoOoGR3+skT1E2ZVPMQst5fj+dhA/o3iTJVdGXNyGrRItd1TAaMROmdAxxu2xWuFdKWYhA0ZsSDM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1af2a1-bd21-482f-1a23-08d70021532d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 01:45:42.1202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a CPU is being offlined, the CPU usually still receives a few
interrupts (e.g. reschedule IPIs), after hv_cpu_die() disables the
HV_X64_MSR_VP_ASSIST_PAGE, so hv_apic_eoi_write() may not write the EOI
MSR, if the apic_assist field's bit0 happens to be 1; as a result, Hyper-V
may not be able to deliver all the interrupts to the CPU, and the CPU may
not be stopped, and the kernel will hang soon.

The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
5.2.1 "GPA Overlay Pages"), so with this fix we're sure the apic_assist
field is still zero, after the VP ASSIST PAGE is disabled.

Fixes: ba696429d290 ("x86/hyper-v: Implement EOI assist")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0e033ef11a9f..db51a301f759 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -60,8 +60,14 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
=20
+	/*
+	 * The ZERO flag is necessary, because in the case of CPU offlining
+	 * the page can still be used by hv_apic_eoi_write() for a while,
+	 * after the VP ASSIST PAGE is disabled in hv_cpu_die().
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

