Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82CE5223
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbfJYRQ7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 13:16:59 -0400
Received: from mail-eopbgr780127.outbound.protection.outlook.com ([40.107.78.127]:19692
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389658AbfJYRQ6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 13:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMUKN3dNj3pBd17D/w7YS97ulFfNV0ZOOXk8lYyP5m3eFEmXA93mLlCF3TYrotH8HA0mXQ4s2si2kP0BFyPRfuYD+vU5kv6zHOy+kotQGf298mqEQDNfAXQP1+VKeVHmEbnFBxmALxH4r5qe9ZUPxkV3aTZivU8GcId397qgvauGUBgl45c83ISCwTVdNlu4N318bNxT/LBB8r0/WEbWx8wwHr3RhVDQ9JkVMMKbyf2hT5uB74522xI3KIlNLfpXcnsLh5dte3gvAK0NjTyaovVw6ltCRkAMDdxIrT9Z6Xz4bRPJ78WZjAAqqoDdvfGcTuvhisquvk45LA1t3L17ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht2W9ztvjxJTzagPotWJxUoFxMitH/D2+0pKQLpPYhE=;
 b=AEkQh8nltGVSIgxa446OG5leTTpjUNS22mihgvtRTprHynPxM5R7qYZQzTz5toEfcyy2gWWNPRr+bGUcI4AFmr/cp2x+IUF9J1fxY0p9xSa526WqRRLb2j8RxMz/x3xn0KsT6QxTqUDa/cDGoxQILb4hg25s+RY2k4lbRG/YiTbZKpuHD8TrUFU1KfMWX3kvxgdwDBj7K+pqVe9bXrB2cHGfDGzXnEA4KNxqn+EAijg+Jh+AmeC14xpUtavYDFGfQMt6hNrUfw/KegnxbX0vhZDCF6HDjhq7ZEZ7ATIuAJy1niP3v/WgxjdF8hRHbLHU5LtE0LEYCEPwijvyS/A7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht2W9ztvjxJTzagPotWJxUoFxMitH/D2+0pKQLpPYhE=;
 b=gik4Le0xCkbxu+fxw2HLEi7PalUYzMEZYi2AYN5k2Y5aWw/sYaKAops9xAJpIuby7mvP/Z9ouyBlwXHUib4AIRxRClao3Latxsd7ROJ8vV2JFZ+i95VWeBU1t57TxdfMExOaUQF+9Q6tobZAq7sRQy9CEfb/DgPWRzYPtZIVVoc=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0827.namprd21.prod.outlook.com (10.173.172.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.9; Fri, 25 Oct 2019 17:16:10 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::356d:3ae3:a1c8:327e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::356d:3ae3:a1c8:327e%8]) with mapi id 15.20.2387.016; Fri, 25 Oct 2019
 17:16:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH v2] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVizZYw71SQ8Diqka+aNAAyPdZE6drliLg
Date:   Fri, 25 Oct 2019 17:16:10 +0000
Message-ID: <DM5PR21MB013707183D9E271E60FBD435D7650@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191025131546.18794-1-vkuznets@redhat.com>
In-Reply-To: <20191025131546.18794-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-25T17:16:09.1576233Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19fba2b8-0c92-4483-b227-7a15e3f43df5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c134dd6-a074-4f35-b26f-08d7596f081d
x-ms-traffictypediagnostic: DM5PR21MB0827:|DM5PR21MB0827:|DM5PR21MB0827:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB08273A600E603DCD8726355DD7650@DM5PR21MB0827.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(189003)(199004)(14454004)(52536014)(74316002)(33656002)(8936002)(81166006)(8676002)(81156014)(25786009)(76116006)(486006)(10290500003)(66556008)(99286004)(64756008)(7696005)(66476007)(11346002)(66446008)(76176011)(7736002)(478600001)(66946007)(305945005)(4326008)(476003)(6116002)(3846002)(10090500001)(186003)(86362001)(26005)(446003)(256004)(6506007)(14444005)(5660300002)(102836004)(8990500004)(7416002)(2906002)(6246003)(9686003)(54906003)(55016002)(110136005)(229853002)(316002)(71190400001)(71200400001)(6436002)(2501003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0827;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4dg10QUoul4yoeHzPGAt/Diq0OSPHStU7N11v9Qd7GfAp7oqMgYGLRnUyHhe77OAQHnSoG3OYRN2rxTob3i+Aiklmd9VG1zaHLUEQ0xFjFdqklZEfrACzcQ6zFgGGqsC1Z3qnwavX5Rdyq5YeqCZ/L0qo5rXElIQtKi+WnWwiw8PW9aFGczvWe16COOqrbT/AOsevrWPGiXDWZZYArl+6dq2vAhfFPgMf5SZQdvJcUmqAJyyUMMgAylzjZ3f48s4qcfZamh4GmwJXga8vGSG+CI3Z+sNbnu3Cgpmp+Le+eSLkNfY8V9vjfdmiVUK7cQ1Xs2H5LPkQu87drEapnlqotxZ78hWQFQoCzElkBHiSILh1P9Et9uFP6yPltNHCdsplavSvhTuHQsL5aU34shxH8LOsX5YE6lmm+39cu0stii3CuLc6xiBadYhyjgVelr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c134dd6-a074-4f35-b26f-08d7596f081d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 17:16:10.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUXtET+jNiMTVJYQlLqfXghtN6lmD1f7un2nG9zzyRo7fvFPOksMlyJEPiggrvxJRAjU/A0P/fLJeq55jl5PcolohvAHlVZpbK2rgmzVFSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0827
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20
> When sending an IPI to a single CPU there is no need to deal with cpumask=
s.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
>=20
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CP=
U
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1:
>  - Style changes [Roman, Joe]
> ---
>  arch/x86/hyperv/hv_apic.c           | 13 ++++++++++---
>  arch/x86/include/asm/trace/hyperv.h | 15 +++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index e01078e93dd3..fd17c6341737 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -194,10 +194,17 @@ static bool __send_ipi_mask(const struct cpumask *m=
ask, int
> vector)
>=20
>  static bool __send_ipi_one(int cpu, int vector)
>  {
> -	struct cpumask mask =3D CPU_MASK_NONE;
> +	trace_hyperv_send_ipi_one(cpu, vector);
>=20
> -	cpumask_set_cpu(cpu, &mask);
> -	return __send_ipi_mask(&mask, vector);
> +	if (!hv_hypercall_pg || (vector < HV_IPI_LOW_VECTOR) ||
> +	    (vector > HV_IPI_HIGH_VECTOR))
> +		return false;
> +
> +	if (cpu >=3D 64)
> +		return __send_ipi_mask_ex(cpumask_of(cpu), vector);

The above test should be checking the VP number, not the CPU
number, since the VP number is used to form the bitmap argument
to the hypercall.  In all current implementations of Hyper-V, the CPU numbe=
r
and VP number are the same as far as I am aware, but that's not guaranteed =
in=20
the future.

Michael

> +
> +	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
> +			       BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
>  }
>=20
