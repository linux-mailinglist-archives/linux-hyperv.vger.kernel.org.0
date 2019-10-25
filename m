Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB4E5122
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502667AbfJYQYF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 12:24:05 -0400
Received: from mail-eopbgr700119.outbound.protection.outlook.com ([40.107.70.119]:42721
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2632791AbfJYQYE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 12:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO4Fd5PMRtepWRDzTxrR/MF7daVQE5epcldSYgFackhA/3QGErHXijx3IGZl99YSsxmwZQdHwUFuyL6a3OOaTgOiLU4d+WCRAhLcHHbEHWALfsKjUe3Jnhjh9T7axNddFI+UdqoMlOVatQwj5P5dsbrLDz4nl2vw/1sqkwkNJuyUIC3vuBtYg06vdKcIMGRdcYVD2kZeLfJWoDnbUtsgGsPLjlBRR6lFFN2hlGiuf7D60TbBvcf3BFGq/i0aJUjdeFatVjrmZmVzK9G7v03q1d9zFfP+AWHycMcVQ5vOOknC+kxPjqa9P1MBzlv9y7viGecOoQg1ZkJgHBr+MDM3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jZoFGj4XVaCQzxNcxeCXN7Ev6skf4zc84qW2O50XTw=;
 b=W1q5nZXMdep85vb4r4Io1s5I3cwPr2j3GVoiDMfi661a/A0PU6kCaNZT8TK0+TZA/SVltLNu/hXY0nftxNHGFtkt6bd1C3ethb0h6XeYneJnc3Ygcz7CE3hE1/EOc+wbHQjXVKj12coGqw9fwNX43N1St9fUX4r/XK2z5eIGzkHpPh9aTLX/Alp2Sq0WzhZCxdDtCNfF0Lh+B4ATZU7qx+ld+EcFAbrW8LVlIp/q6EeNW17DKFeDbigWejpwy+OUMmT430F1HIDT0fVVtlIapKPvPLMczQybuGzqU1ygEBZ2DZ64k2g/RkZl6wDsCvmM7lp+RBFSah1ATivJf90PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jZoFGj4XVaCQzxNcxeCXN7Ev6skf4zc84qW2O50XTw=;
 b=YKGDq9Znwkhfl47+iYliIe1uQFy06/tAQdBOAIT6plF2eIIv9Kw8MyKccLyg4hyvXLy1rQvF8oamqDNTVin9Nq4br24AnosaiMS6lZPoW1N1J0lB6z/oPxkurhrr8cjm0jbtqr6VOvO7rwHY8TNKH4FWRmu0Ruc0X06NJlO8Sj0=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0745.namprd21.prod.outlook.com (10.173.172.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.10; Fri, 25 Oct 2019 16:23:22 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::356d:3ae3:a1c8:327e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::356d:3ae3:a1c8:327e%8]) with mapi id 15.20.2387.016; Fri, 25 Oct 2019
 16:23:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVioF/EssSW0uoH022cwWWWj4pcqdp/COAgAExGoCAAFte0A==
Date:   Fri, 25 Oct 2019 16:23:22 +0000
Message-ID: <DM5PR21MB01378544207EB796E178B2CAD7650@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191024152152.25577-1-vkuznets@redhat.com>
 <20191024163204.GA4673@rkaganb.sw.ru> <87r231xfyg.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r231xfyg.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-25T16:23:20.8262793Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89e4f643-46d7-44f3-835e-dc0f6dcfcf3d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b323819-b0ad-4a6c-1f92-08d75967a7dd
x-ms-traffictypediagnostic: DM5PR21MB0745:|DM5PR21MB0745:|DM5PR21MB0745:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0745B2C9964C76722DC1BBF1D7650@DM5PR21MB0745.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(76176011)(6436002)(11346002)(486006)(256004)(14444005)(316002)(6246003)(7736002)(86362001)(305945005)(478600001)(8990500004)(7416002)(25786009)(74316002)(54906003)(446003)(26005)(66556008)(22452003)(186003)(76116006)(476003)(2906002)(4326008)(10290500003)(66946007)(66476007)(64756008)(66446008)(110136005)(9686003)(55016002)(71190400001)(229853002)(7696005)(102836004)(5660300002)(6506007)(6116002)(99286004)(66066001)(3846002)(52536014)(10090500001)(8936002)(8676002)(81166006)(81156014)(14454004)(71200400001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0745;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoj5SRK/P9WJfT4TK8PrDWxMlZbr/I0G90gkkqcjT5/JplQ6Sui7ML7RzqV/0Mk4Ga+pWvGZpqqjGRlOo3nQXqjHibQlfgl3GlKaabKsZywSykdG8pr6D4ouwx6rnomGqnOaSMXsxvvVGNJbaiSPdWmhaSVzKr9SZKlOpP+Y1GkoLUEGNlHE+IWMuwNy9zBidosBDgEATkqEfyJe0Sdjr4JFNUJKa/4xS4qgXYFi32OibCTkar9BCSaG5rVkjVtgWm3/e5NmbibDcYoC/HE0+Y/r+Yj36kKCW9umK4JT4DB2OlgZWJyXtI0+y1gqJ8y0FxuKZ1pY4EDErn9A2ToqY+rkkMF81Aw9ZrpSQOeKyZUSXGmlPT7AKXr0MkI2uF7+2S7+SEEypJEyZMjEWbtJld5mtYitco+hw4Qd7pmgrAAvkTaMn9pjRnkkhtXEt3bo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b323819-b0ad-4a6c-1f92-08d75967a7dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 16:23:22.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7S+GXW5D4dxelc5llKk0E698vffMKjAV6sp9nL3e9WJMYs8H1IZskvHeTlHLIuXy+Pv5WJxdOm8Yr0/mim6nDOg4y3zBtF+UMvvFNwIQXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0745
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, October 25, 2019=
 3:44 AM
>=20
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > On Thu, Oct 24, 2019 at 05:21:52PM +0200, Vitaly Kuznetsov wrote:
> >> When sending an IPI to a single CPU there is no need to deal with cpum=
asks.
> >> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 C=
PU
> >> cycles) improvement with smp_call_function_single() loop benchmark. Th=
e
> >> optimization, however, is tiny and straitforward. Also, send_ipi_one()=
 is
> >> important for PV spinlock kick.
> >>
> >> I was also wondering if it would make sense to switch to using regular
> >> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650=
 CPU
> >> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu=
,
> >> vector)).
> >
> > Is it with APICv or emulated apic?
>=20
> That's actually a good question. Yesterday I was testing this on WS2019
> host with Xeon e5-2420 v2 (Ivy Bridge EN) which I *think* should already
> support APICv - but I'm not sure and ark.intel.com is not
> helpful. Today, I decided to re-test on something more modern and I got
> WS2016 host with E5-2667 v4 (Broadwell) and the results are:
>=20
> 'Ex' hypercall: 18000 cycles
> orig_apic.send_IPI(): 46000 cycles
>=20
> I'm, however, just assuming that Hyper-V uses APICv when it's available
> and have no idea how to check from within the guest. I'm also not sure
> if WS2019 is so much faster or if there are other differences on these
> hosts which matter.
>=20

On Hyper-V 2016 and 2019 (not sure about 2012 R2), and when the guest is
using xAPIC (not x2APIC), you can tell within the guest whether Intel APICv=
 is
enabled based on the setting of  HV_X64_APIC_ACCESS_RECOMMENDED.   If
this flag is set, then APICv is not present, because Hyper-V only recommend=
s
using the synthetic MSRs when APICv is not present.  Conversely, if the fla=
g is
not set, then APICv is present.

FWIW, when APICv is present in the hardware, you can disable its use in a
particular VM by using Powershell in the host to set  compatibility mode on
the VM:

Set-VMProcessor <vmname> -CompatibilityForMigrationEnabled $true

Then when the VM is booted, HV_X64_APIC_ACCESS_RECOMMENDED
will show as set even if the hardware has APICv.  This is useful for testin=
g
the older code paths on hardware that has APICv.

Michael
