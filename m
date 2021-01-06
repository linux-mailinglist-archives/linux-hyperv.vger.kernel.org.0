Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763872EC681
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 00:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAFXEt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 18:04:49 -0500
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com ([40.107.92.90]:55008
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbhAFXEs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 18:04:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVkpFJfqyBY40y+3Jd1vJNQK89BC70/nF302mp2KpQC+x+NBFv3joIUSkXtzY2kKj3F3cCm95xeaix0eFCCcVHhWOcBmHyMxXeTSikR8uM+rdjVS+W4FzQsaJkWQyRCFLrM2l6zF5yoLgdCgbvH3GLQhwmEQJcmesvaY9m9u0fXR6cZacY2YBuj5Y7OkPRR78X0beOuB0U8zsF9xVpj0/TDzv/UACWNe18mR+0RUA1URavQoj9HA44lqpSXZVgdDoBeaKD3S0I5LGbKO9AjbrtjALqAx6yo8ZHMuINwrZDu7z4uKTqyXj5CRCcNc8d4CKSLC4kwYB5uWmaAmjQC0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ+FLl57hMop19+55ATkQHwXUFAMkg/3KhEZlQxKBgw=;
 b=bT+AJwQluIXnHvvFi7NLNT7xiyYPLLctdeMlhoWUOjzbezL0kbf+K4i/Bj79TcwhrZBz4qU767k7X4t2sNlPOSX6BxTV1TmIsT5Kj78LCmpaEyN9GC2cE2NURrhOzszwP1wQ4RfOqkFhrw1JQKxPnDr3J+/kXsxW/WFvxLIVl2tURLaeiGh8hsu2qND2icGy8XWNrR2GaoVh1rb7teQW9BuVGmVOmVURyn0fHQdYF4agiJwLRrq8GpniaJ4ALAdkUhJHUzKKlR4kmQgr4xux1PlF63o+jl5eKJSHNGe+JZEwCl17OfO3Hw+xFN7FNRVVCIweMsusD0EK7ebDxyKODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ+FLl57hMop19+55ATkQHwXUFAMkg/3KhEZlQxKBgw=;
 b=eWWt0Ud+zEXyU9rItgQJpuKC+uQsU/INJfqV7weK9xXbrbFnF78kVbA0FlFCD9An+ofWzPUgziyrVnwtPvV1aLg46yRg7pDpaGp+HRWwa43xxwXoIMRAFKEb0AbLDp7DI48lPvQMeNOr/nle+7TEZJNoLPo2FxHwtwFMvD/P72s=
Received: from (2603:10b6:803:51::33) by
 SN6PR2101MB0896.namprd21.prod.outlook.com (2603:10b6:805:9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Wed, 6 Jan
 2021 23:04:01 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 23:04:01 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2] x86/Hyper-V: Support for free page
 reporting
Thread-Topic: [EXTERNAL] Re: [PATCH v2] x86/Hyper-V: Support for free page
 reporting
Thread-Index: AdbjiOckXy2XABo0QQC5vn/n9MZDigApuVgAABBfCaA=
Date:   Wed, 6 Jan 2021 23:04:01 +0000
Message-ID: <SN4PR2101MB088078C9B0C7A6F41E7FC919C0D09@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08800F9A2F6961A05DAEAE4BC0D19@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87v9cagpor.fsf@vitty.brq.redhat.com>
In-Reply-To: <87v9cagpor.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:f11f:f773:1cef:ecfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c992b2e-6d64-4f99-25a6-08d8b2975b31
x-ms-traffictypediagnostic: SN6PR2101MB0896:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB08962C97F887AE586511163DC0D09@SN6PR2101MB0896.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fqY0FXuXDvfR7FiUqjPsKpaSI2cEQH4Lf5Yj2dd/WltdWUjZJqZpHmjK57f3h/nP3AqfDyFVvpgFBjHOMVl97jplq0VLxQqJ/dKQLkRo+rpJh+/g/2L/Fs5Im91k6BeZ4Z3dgjojwkuLPoVNbIe0Q6ydYIvNBZs9F+FtuyRXZuNDTwnHLH1ScIEMZysxVxj3guC4NfV+5UHLHaR28s+s2VnQCOkRqi3i+6itRregv3afIBBz058S705rEx4o3eC8f4F4D4ZZXG7UnGPGVmN2hjcPGEAka7WkfyXib7PDtmIAE+hzqa8afOIyZpNv8DT9xXJjDLdhf0IBi1uK5IMhK6Y6E244DVyi8sblst/cweE9PHiHdNYt81Op7J4lIdSmtbPgeWqfN5tzX3Gad7GQU+CfWdEwt8hZqxY30tOLn/A0DxG4yGGD24oYxieeTV1Jq+TNRTUX+Ykncyfbz5cjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(7696005)(66476007)(6916009)(76116006)(6506007)(64756008)(5660300002)(2906002)(8936002)(66946007)(71200400001)(52536014)(33656002)(10290500003)(66556008)(478600001)(83380400001)(4326008)(8990500004)(86362001)(316002)(55016002)(186003)(66446008)(82950400001)(82960400001)(9686003)(54906003)(8676002)(21314003)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tVMyqXt9hsOEKXMqq1XGI15ugBm5KjfmYPvr40NQAAhV9I1Ela3kXsjZIR5D?=
 =?us-ascii?Q?kV7v5v2EpOWHHLBEMA9UmbZ3paeFZYEj/Q2kRruAGHka+5djeVFTJJzwyW5C?=
 =?us-ascii?Q?beWalWuUZ7gSavT7N1k//Bht6En/vflbMKVCi/HwtSjbOfjG9zTClnJ4IGHe?=
 =?us-ascii?Q?p/b4GlCSrdV1gbQqVNKf/z72Dxcf27ShuHubsRO95FpzBERPRpITqJlFAs3i?=
 =?us-ascii?Q?Gp6jJDR7EkVTvq98aRyXN7zYHKcdPg8W/DlT81dr6eRaO5U9oKOQ1hCgu9Fy?=
 =?us-ascii?Q?Nj/8hN8E0VG/8j8lnM8ANlh5lYiTlBE2YWETRWGovm4laYWEbFTFNRewPVam?=
 =?us-ascii?Q?wDhvMEzJRhgTkFDlLjgZlm8iWDAmJBidjvH1GIIN3zaf/c4yoErHCsc1fkY6?=
 =?us-ascii?Q?vH9G5tiVTCEmocb+xOLc5Fp+23Opxm5OoobxikdhxH8uILoi+2owL28LT6No?=
 =?us-ascii?Q?/eTwGtXngDy69OwPzgQKcqeXWwYE43FD1A77aUHvT+AJO5KI841vEYrJtf1L?=
 =?us-ascii?Q?dtfj9a9Hc6JaSInCffLhtxThMhH8nPIESo1l/8lvB4/lgeJuYS1WjYf7r+Ro?=
 =?us-ascii?Q?z4nJXafgISTIriwXQLpmPDgLlg50jEbq4/d0XAtcGMGfsNncwADP2hpED6sX?=
 =?us-ascii?Q?lv+roNVv8QS1QGdKstt/lp1u3XT0JWmBT+xNQO+k54xtCbtpwoRP/uZ1SptU?=
 =?us-ascii?Q?ujhiygbMZf/rVi7ZO0QD4GWswcnQZGwqiKB2RhflmCjUbszBqipqI+Hp251l?=
 =?us-ascii?Q?MIIKIuKUgw3G3725AKHyJsc4i0N4q5rj9oFvJvlp37xa+hj4p6Voqoc/39Wg?=
 =?us-ascii?Q?nAf5vWqztJ8y4FSlVy0eWW3cdCgzxq793ifdn6fCyv/j679hlxXg8z9W0s93?=
 =?us-ascii?Q?dpk+Kw0GUMfvhCWc0yBOSNXpBHDsstexW7+zs/spBHessXRJzi3nzSoZ1HUo?=
 =?us-ascii?Q?n2g1K9vd2tTHQGCNSaXuqetMFY3SQKCs6KTJ1CrY76x1Jt5rQjL4EFhPkjU3?=
 =?us-ascii?Q?RkBoZ8IGIY841orzW8Ac/U6n4AVj1Hj14kLp2Rbjy5h8SMc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c992b2e-6d64-4f99-25a6-08d8b2975b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 23:04:01.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8Zkv6w4DXH4MVuCbcHsUWzCJE3vjGOGI/QrNv8WTvUFHwsEAnZ8asdza6EFNPazLLFTspmVro0NcSpwlEaEhHIT0+IK6OjqiBdQm7eTIlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0896
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +// Bit mask of the extended capability to query: see HV_EXT_CAPABILITY=
_xxx
>=20
> Please don't use '//' comments in Linux (here and below)
Will fix in v3.

> > +	/*
> > +	 * Repurpose the input page arg to accept output from Hyper-V for
> > +	 * now because this is the only call that needs output from the
> > +	 * hypervisor. It should be fixed properly by introducing an
> > +	 * output arg once we have more places that require output.
> > +	 */
>=20
> I remember there was a patch from Wei (realter to running Linux as root
> partition) doing the job, we can probably merge it early to avoid this
> re-purposing.
I would prefer getting this in right now and we can update this once Wei's
patches gets merged.

> > -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> > -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> > +	pr_info("Hyper-V: features 0x%x, privilege flags high: 0x%x, hints 0x=
%x, misc 0x%x\n",
> > +		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> > +		ms_hyperv.misc_features);
>=20
> Even if we would like to avoid the curn and keep 'ms_hyperv.features',
> we could've reported this as
>=20
> "privilege flags low:%0x%x high:0x%x" to avoid the misleading 'features'.
>=20
Sure, will change it in v3.

> > +	WARN_ON(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
>=20
> WARN_ON_ONCE() maybe?
Sure, coming in v3.

> > +	for (i =3D 0, sg =3D sgl; sg; sg =3D sg_next(sg), i++) {
>=20
> This looks like an open-coded for_each_sg() version.
Thanks, will change in v3.

> > +	BUILD_BUG_ON(pageblock_order < HV_MIN_PAGE_REPORTING_ORDER);
> > +	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
> > +		pr_info("Cold memory discard hint not supported by Hyper-V\n");
> > +		return;
> > +	}
>=20
> Which Hyper-V versions/Azure instance types don't support it? In case
> there's something fairly modern on the list, I'd suggest to drop this
> pr_info (or convert it to pr_debug) to not mislead users into thinking
> there's something wrong. In case they don't see 'Cold memory discard
> hint enabled' they know it is unsupported.
>=20
This is not available in Hypervisor spec 5.0 and was added in 6.0. I don't =
see any problems
with making it 'pr_debug'

> > +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> > +struct hv_memory_hint {
> > +	u64 type:2;
> > +	u64 reserved:62;
> > +	union hv_gpa_page_range ranges[];
> > +};
>=20
> Other similar structures use '__packed' but I remember there was some
> disagreement if this is needed or not when everything is properly padded
> (or doesn't require padding like in this case).
>=20
There are other places where we don't use '__packed' where everything is
properly aligned. But, I will add it as I don't see a problem with it.

- Sunil
