Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E56CA57
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jul 2019 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfGRHwm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jul 2019 03:52:42 -0400
Received: from mail-eopbgr1310107.outbound.protection.outlook.com ([40.107.131.107]:7136
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbfGRHwl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jul 2019 03:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/pSRy1Q5Wek+qXjt/pptK4xCV+FvefGBZWj5FiN2B/55xUVPq7cMN7dZRx75vjprhMY0bQZt67NVZbWG+v2VZ1K6iDke6LeSo1JV+udDSAjV/CTrKCfEwgQjxgNAThD0xtxhLQwsUCO+mKZL39V5eTkg0zxzxu77b/jFitRY1ovbpjLxDGrC6RmGaAobSbs2yNFPvJOhnO3oYqxDaxCieAU6j0qWuL6MYLxDZMvOKwZN8YYaz0pq5HmRYe6Clcz+uR7cmHHW/G5rCGU71xDuU4rxQw9ba0LN06IG1ICBLaSyTKP0YQSbRD9GlZQ5tEPDSL/wrYfLGdQOTa1zhbBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9u2bPHZZ8Drt0fwe4dzymFmKFFyWNXSD3dTc76KATQ=;
 b=MSzfu4+geoMhPMIYAjvGmfGuF21wjJLlWDVD9jG6cpd7EsLNPE8crx42Jua+KXpxhzD+lFpe4kNk6tD/gMWNlBr5sQGNVdu1Ac3b5ft3KWCTjTRBI0O4bGShe1dwTp9dhbXkB+WOLdz7UxFQit7S2pK8cUn1xB3DRhQNEOaddT800zjpCgWC08l2OgH2Rzyziy8v9mhzHHSYnzXyrNIY8dbQTeboUyt8tjKd+DPx7Zp2ChA80mcU79q/8ELxodZoDNVRnX21MIAUEdoMdE+mv7qEOIStznJNf2k3vgMIujqvheQkwH9A+hRlj7214YXJBqDny7SlFwBxspIjJ92HxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9u2bPHZZ8Drt0fwe4dzymFmKFFyWNXSD3dTc76KATQ=;
 b=lcEo7WLI/51SxmxAKK08MLUfhqmnKZmcH4bKZuE8EuEDlXdsNR7ImqfpqbRnzigy9sE0B7O7YNmFQvaNODKOQ64UWXE42A61pCO13AAaZG8Tlwq+6CJp6IdN/V/YJVhyPXob386Nxw58ibGfPikVvSJ4IlYN0kkaMmiS+mFxFKA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0108.APCP153.PROD.OUTLOOK.COM (10.170.188.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.0; Thu, 18 Jul 2019 07:52:27 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::383c:3887:faf8:650a%5]) with mapi id 15.20.2115.005; Thu, 18 Jul 2019
 07:52:27 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Topic: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Index: AdUyCb6p1/Ch6raqSV2uCwYf/NBGWgK6h7yAAAMgE9AADYqTAAAAYumQ
Date:   Thu, 18 Jul 2019 07:52:26 +0000
Message-ID: <PU1P153MB0169BE20761D77E7FD9A3D57BFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de>
 <PU1P153MB01693AB444C4A432FBA2507BBFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907180846290.1778@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907180846290.1778@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-18T07:52:23.0061089Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d583d362-b0b8-4258-8034-5d57032d1631;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:4518:88f8:ed53:3c89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4ed08b1-c22d-470d-a787-08d70b54e0b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0108;
x-ms-traffictypediagnostic: PU1P153MB0108:|PU1P153MB0108:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0108E4F9DF21C2FCDC38612FBFC80@PU1P153MB0108.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(66946007)(186003)(6506007)(102836004)(76176011)(6306002)(9686003)(76116006)(966005)(478600001)(305945005)(7736002)(55016002)(8936002)(229853002)(53936002)(7696005)(10090500001)(4326008)(52536014)(486006)(8990500004)(99286004)(66556008)(64756008)(66446008)(66476007)(476003)(11346002)(46003)(446003)(256004)(14444005)(86362001)(54906003)(33656002)(71190400001)(14454004)(2906002)(6116002)(25786009)(6916009)(8676002)(81156014)(81166006)(74316002)(10290500003)(6436002)(22452003)(316002)(7416002)(6246003)(5660300002)(71200400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0108;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /4/Z/A+teFtzp7/0Nz/UwNuRcWqGnsAOtd5jQyMPgysLn5XaFch5PyXHZXQn1jIE0Tiefzed5Y42yjzWTLMRvFqtdu7jI4DVdo7ijLnyFgyxdlRfhXtO9HBNQcnMDWRk6maxtDPYSGPQNTiBAY2wkGgbA6TDIzF4AsyP5k5yxhaKB0LBqR2MQgmwfMlj8TPMwciNUg+u5UxeEdQn/DOxRcL51fAhUfOq1da34v3LMRNNgMC9TD+TZoO5WYPP0X/a95+qSjXp/nfNn9me313TFRnPeVLUf7zw6hflOmieXMPj9CquDG7KXdqpY3UACpdR1Eype9JGfpjHla889t0lmap8wPLy0Pgmc0nMf7tX+J9E1acpp3VGBWBUs56G8pTNY6JwGQ3Fp5OhZTvmh1Wj6wnRVBW2NTWVlGQHzT7ONdI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ed08b1-c22d-470d-a787-08d70b54e0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 07:52:26.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0108
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, July 18, 2019 12:01 AM
> ...
> Those are two different things. The GPF_ZERO allocation makes sense on it=
s
> own but it _cannot_ prevent the following scenario:

Hi tglx,
The scenario can be prevented.=20

The VP ASSIST PAGE is an "overlay" page (please see Hyper-V TLFS's Section
5.2.1 "GPA Overlay Pages", on page 38 of the spec).=20

The spec can be downloaded from
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/referenc=
e/tlfs
(choose the v5.0c release)

Here is an excerpt of the section:

"
The hypervisor defines several special pages that "overlay" the guest's GPA
space. The hypercall code page is an example of an overlay page. Overlays
are addressed by Guest Physical Addresses (GPA) but are not included in the
normal GPA map maintained internally by the hypervisor. Conceptually,
they exist in a separate map that overlays the GPA map.

If a page within the GPA space is overlaid, any SPA page mapped to the
GPA page is effectively "obscured" and generally unreachable by the
virtual processor through processor memory accesses.
...
If an overlay page is disabled or is moved to a new location in the GPA
space, the underlying GPA page is "uncovered", and an existing
mapping becomes accessible to the guest.=20
"

Here, SPA =3D System Physical Address =3D the final real physical address.

>     cpu_init()
>       if (!hvp)
>       	 hvp =3D vmalloc(...., GFP_ZERO);
>     ...
>=20
>     hvp->apic_assist |=3D 1;

When the VP ASSIST PAGE feature is enabled and the hypervisor sets
the bit in hvp->apic_assist, the bit belongs to the special SPA page.

> #1   cpu_die()
>       if (....)
>            wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);

After the VP ASSIST PAGE is disabled, hvp->apic_assist belongs to
the "normal" SPA page mapped to the GPA.

>    ---> IPI
>    	if (!(hvp->apic_assist & 1))
> 	   wrmsr(APIC_EOI);    <- PATH not taken

So, with the one-line patch or the three-line patch, here we're sure=20
vp->apic_assist.bit0 must be 0.
=20
> #3   cpu is dead
>=20
>     cpu_init()
>        if (!hvp)
>           hvp =3D vmalloc(....m, GFP_ZERO);  <- NOT TAKEN because hvp !=
=3D
> NULL

It does not matter, because with the 1-line patch, the initial content of
the "normal" SPA page is filled with zeros; later, neither the hypervisor n=
or
the guest writes into the page, so the page always remains with zeros.

> So you have to come up with a better fairy tale why GFP_ZERO 'fixes' this=
.
>=20
> Allocating hvp with GFP_ZERO makes sense on it's own so the allocated
> memory has a defined state, but that's a different story.
>=20
> The 3 liner patch above makes way more sense and you can spare the
> local_irq_save/restore by moving the whole condition into the
> irq_save/restore region above.
>=20
> 	tglx

The concept of the "overlay page" seems weird, and frankly speaking,=20
I don't really understand why the Hyper-V guys invented it, but as far
as this patch here is concerned, I think the patch is safe and it can
indeed fix the CPU offlining issue I described.

Thanks,
-- Dexuan
