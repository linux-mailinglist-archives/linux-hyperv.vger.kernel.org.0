Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399113C75BC
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMR2w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 13:28:52 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:58131
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229848AbhGMR2w (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 13:28:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3gdrV+BdfwP781eNeAXkGnr1c+7FhymxbUdSD6dfkDCNw96YefVBgxzMo+IL2dGJiHKdWy/37b370J8YvpBNihlkWUnF4h+DWOIVDwtecaqAadh0t/b8dtQScXvomsMdTkkjnJFYjomGQ0QPHTM1nlqQiCKjtcL1KG8CHLTz6hKe2/J7btdC7q8Icg5sm3ZgnkkBPLEQ1miqOX9jzvr05Fto4yRYVvxs4EdhYwuOUWbqNUmu/U49zLWuUCgIdV6EcuiychLO7MO5KfJy5ZPisQLW1ABfJsFtJT7rubKvbmVjwahZZx1ws2vwF1WsepARH0qJSW10djwMKemshFTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr8Sg5O6tz6732rZlCxlwNFEPNdI2N+ep2Ks1Lz0W4E=;
 b=LWP2GmduLNJ3lDUnktyPrAtOsr+WRykCRr+u/gxn3Od79Yb0Te1zclXT2OCAmNDHcvy0A4PrUyXLKX7b4rSfsH4C2xJ6tvg/zKC8dtFVRNxIlF08Ut2Lv8+64r0bgCp2xt3IcyR+hkJ9zhkhdxf4YSdKhswHJK6NjsOgfERFAZRLhQxJe963DsWkpJRlJ+tbl4tVVxPfty8fjruBwHxjPMsFFd0GMrUTNsOJi1+NvaHgwwWI/c8OWaWkDCDUQykQB5gXwxyV0pOvTKFpo2uVA+nkUyJVn4+TDir/EQlzmTRJyxRB76MNzmAnkE8SyZY3Ihv0LMXu3KVIOXBnSi3JNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr8Sg5O6tz6732rZlCxlwNFEPNdI2N+ep2Ks1Lz0W4E=;
 b=iD+6k739XkEF37SXOuG7XpUEEFW5CwqnEuxBAD+NLCrc73SReEO/UqsdMao5sULJcRvrLwmYcIFeojYwzjEtxLhatOCDjzmOTs2w3QHuaSuNsPb8qkgoTAaOgSDTxjlpXtBJa/Y8X2KdIjOq2Xm1oCjrZqcisfrSGFIc0HOIMiY=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR21MB0855.namprd21.prod.outlook.com (2603:10b6:903:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Tue, 13 Jul
 2021 17:26:00 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f%4]) with mapi id 15.20.4352.008; Tue, 13 Jul 2021
 17:25:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ani Sinha <ani@anisinha.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "anirban.sinha@nokia.com" <anirban.sinha@nokia.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Thread-Topic: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Thread-Index: AQHXd5QA/Pf4lQTVX0uoJvEieLSplatBKDfA
Date:   Tue, 13 Jul 2021 17:25:59 +0000
Message-ID: <CY4PR21MB15866351E83212975EA02C34D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <20210713030522.1714803-1-ani@anisinha.ca>
In-Reply-To: <20210713030522.1714803-1-ani@anisinha.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52a1f4c7-16bc-4a6d-9f94-fade4edee136;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-13T17:22:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0db2570-f865-4504-dc84-08d946234843
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB08551F80B0BEEE78E7FC69ABD7149@CY4PR21MB0855.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5QjAmyrx3e5tvl83T/NS8IX2CIrLbG0JfWrmLfBb1QVy1sLJfzd6vRiiyaNCeQeFuZLxfwZKCOKoM6pqpQRTd7tzzhToEd0laNPK/8F0zttcFccew/Hx0OxNXScU8r9OJcWObt8X5RKLU4Nbg6jchn3p2D8hR+VJUUADvqK80+a2JPWvrjewozV/Hx8y5SvGVirX5NeErYa+zPUonanw6DmEHRLdM7E9Q0QRMaLlBtdcZ2290xjxUKL9pDgvuTF+8XlBge3AiufNAOoMduGj55h5YS7Y5BeXkmD1vKVU5sNOh2ERPE4bVMx1cXxvJy4Mz3qFAsOb/mtazcP/2zPHOEYQOOTc+Lm0tsmJs2VtpgCpJ7Jn8lWufgHDIt0QSY4CDAmC2A57ra4ni9D6jkwqwNCBm8SXaTzgrJy883SkkzneO/KXqLqD08Stptfxv11RkdqheZ0TlT2MGkWeNE2p1Hh/TBhCjrbKB3rrb7KUMaC1Bxyv3/FbkX6TAv8DGrdGaVx6SnR18BVfLmhzmD0c8QtrytaBNpcjVDIcWnxMcB/f4seWp7xmMIs50A4SOoEstqfI+5FDqzw7c1jCin9jotOtJTr1VnclX4sWc5r6MSDXtDsyl7YPI58vOMVz4A+3u2DTsfpQTz5WkfT6G8mRI4J81BhsKscQ8p4YferUF+KacaJDbBO8relRsHXssUfhj5HlzOE6VI38PJOknXRgWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(66446008)(8990500004)(4326008)(6506007)(8676002)(26005)(54906003)(478600001)(316002)(38100700002)(2906002)(76116006)(33656002)(186003)(10290500003)(71200400001)(9686003)(110136005)(86362001)(83380400001)(5660300002)(82960400001)(52536014)(66946007)(55016002)(8936002)(66556008)(64756008)(66476007)(7696005)(122000001)(82950400001)(26123001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m9m5QE+rna6d2sDnIgNKHslfS3ApKa6PRwX897YQ/Y6N2aHp1QV6lNpBOqc9?=
 =?us-ascii?Q?J4tWylTNGMqJoRltbRRFzMhVitA+VkJf29Yj97wJyh4oOkbGt36tXjddzWl7?=
 =?us-ascii?Q?0uc24Pn794Av+vScfTi52uYCo9StnNRZsfihN64WnQn0Iv64uKi5O69PN+3O?=
 =?us-ascii?Q?miCtffaGuGoGH+3LEr46DoB5wZdNp9QWLL+xIeHaCPSU31zsEMMqqz+X7zsx?=
 =?us-ascii?Q?8vaxfiXr6YQwLpuVDsc2Sn4MNx4/yoDEMCKlBzOUFKrF5vfNvIyff8n59VlA?=
 =?us-ascii?Q?RWtNBRpAYnGVBnVxdwkkUNqnEAoPT9/n3cVVX6gK7XKNIGrFka6y4ENcsR9s?=
 =?us-ascii?Q?8sa9hy8KG1FMZGrtFv9/G1j5pFSHPi4aqJ6Qedoerr/wYquddYrpIA0+5bd2?=
 =?us-ascii?Q?m1+7waM9QSYXe6Vn3iSF4twJPv3cM8eoGUgUgqhvb1ND0f7YZYYJ8pADRoih?=
 =?us-ascii?Q?Ke20ZDD0XJFnhfOzLBkSMFpccDUy8Ohz8ahe+joOnfhRtet9sdJLHn1cC9us?=
 =?us-ascii?Q?7MDxwaHMCt0CnIzt6zxvsQig9byaoMDYc94Exa3RPZXsi8TUvbKhrs6q/J3k?=
 =?us-ascii?Q?LqhT71lcNi1nJwW//xoxsOzZRYhed9TVhJ4n9U/n0SrcVgJtyX1/Zrn/e6p/?=
 =?us-ascii?Q?XpeBGwOmOAgmeZ1rxh4T7Fs3rHGMeYIRmMYR169IE480KkgxdIO1Xcfcz7d5?=
 =?us-ascii?Q?3Gco52sIf7cAfuTA5n9HmNPnDQiZrEhiEPQNnXdMEf/BM3uUACt1QcL9UpFA?=
 =?us-ascii?Q?iLeq1n+R9pYs8rYNsCJYNSTO64iTq5eVi/eOiF6JEBZPOX209ZS5t3l/IaWc?=
 =?us-ascii?Q?sqWT+Xx4PdNEbrLZChD7Y6+fZo/sNpPZB4t4EiBu3JBAu+5qVrSX4+wfCx+1?=
 =?us-ascii?Q?Sv51WjucI7faE7crxsOQln1D4v55dQZ0BFULQF9hou4X3NeHrc75BdOigVKc?=
 =?us-ascii?Q?OxN3X0VFRS5RtfsGoX2RSYJ/lIRUIXTOIJYsh1SjCqjJ+V/u+PVnzm03+bRb?=
 =?us-ascii?Q?2A3xI9magWuuHNmPqWAujS5e+dKGdamj7bovA0vWz7Sg5aVeTJZzEdok2y6s?=
 =?us-ascii?Q?ldXf5di9rwJN58HP70YsW/CF2bb/+MsU0uPKym/3P7VA00hQgYAej8+nYpGT?=
 =?us-ascii?Q?u6xLMzAiF0hrmOHZXchFl8AkfHODu0QkokUPjb6cTQ5YxvjKp3IxlRoVYQnz?=
 =?us-ascii?Q?RFwX6HRDj2p/xNmkNmBruvDWJXayUsf4FomqeW54b/erMCAvKKpZkpcW2KfT?=
 =?us-ascii?Q?qXdAy0s/jwxBJK+1APlmB2V15R61kgsst1usPzh3SnWvPTLuNjT1wyE6mrgg?=
 =?us-ascii?Q?Cf4tk4W+8HkGKd0C5pW0Y9aE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0db2570-f865-4504-dc84-08d946234843
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 17:25:59.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iirr88TQNylRofSxWbjb62FGtSB7llSOHUIxxdHHVYwzK/4LtJXSks8NDRqqKYJuihjqwMXxgHuwqB5dEU6DOv30Eo0cTWuOrKdmBqX1XPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Ani Sinha <ani@anisinha.ca> Sent: Monday, July 12, 2021 8:05 PM
>=20
> Marking TSC as unstable has a side effect of marking sched_clock as
> unstable when TSC is still being used as the sched_clock. This is not
> desirable. Hyper-V ultimately uses a paravirtualized clock source that
> provides a stable scheduler clock even on systems without TscInvariant
> CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> scheduler clock has been changed to the paravirtualized clocksource. This
> will prevent any unwanted manipulation of the sched_clock. Only TSC will
> be correctly marked as unstable.
>=20
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 22f13343b5da..715458b7729a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -370,8 +370,6 @@ static void __init ms_hyperv_init_platform(void)
>  	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
>  		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x1);
>  		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> -	} else {
> -		mark_tsc_unstable("running on Hyper-V");
>  	}
>=20
>  	/*
> @@ -432,6 +430,12 @@ static void __init ms_hyperv_init_platform(void)
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
>  #endif
> +	/* TSC should be marked as unstable only after Hyper-V
> +	 * clocksource has been initialized. This ensures that the
> +	 * stability of the sched_clock is not altered.
> +	 */

For multi-line comments like the above, the first comment line
should just be "/*".  So:

	/*=20
	 * TSC should be marked as unstable only after Hyper-V
	 * clocksource has been initialized. This ensures that the
	 * stability of the sched_clock is not altered.
	 */


> +	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
> +		mark_tsc_unstable("running on Hyper-V");
>  }
>=20
>  static bool __init ms_hyperv_x2apic_available(void)
> --
> 2.25.1

Modulo the comment format,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>=20
