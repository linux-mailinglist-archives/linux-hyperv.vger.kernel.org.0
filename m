Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C88037CACC
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 May 2021 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhELQcR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 12:32:17 -0400
Received: from mail-sn1anam02on2125.outbound.protection.outlook.com ([40.107.96.125]:48640
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238427AbhELQE6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 12:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjrrMf5ooe45CESnd7a6SpyCPrzbMv3D3X9hwJ1rLNAnVVg2PNk6k0HxCCQ+dZeANppYZXUwS9zsbIZ2QkCgn0WwdOr+TzUD5o2J9dA4ideN4vV4yWAIHYkL1dUvhfnhHizB1HVd9j0C9Zs+VihGPDhwVMopPLUDEqcDuiay/09PXu0PTqPFaBXz2T/3Phbpgmdj8/dpFYHK43si9YU+9w2Ex980eSSoZZuZWLGl0mpnX719SYue2ldA+GwzvrzpSabyp0h/zMViS4B8MGkCzBeR/UUJUbTm+GhwRDfIh/fTYfQnQmdQPhjeDXl7NVbFF5/ItZyFNlr3WvaidXVzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5KLpwK3ifDBoBVo3F9zLFRQOhRwVaNZNOFbEq7ydYU=;
 b=KIz4x8OA9UZLjhHtZeu4loW4vr8A2/rYP+ZM/kJzUMoLH0GzPxyhTMvMpuEnFrtvSy4wz2YKitQm7oom2f4GGI6Ww3mCpbMGO4CS8L+gfkdsTnLxUD4ntOmJosyVSjzUVDLFQYkMdkIgV6gPgL2vBDxwdGscLhY7gq599sRkQLMb3j7VmDHfNPTqv4uXxcjJI2EATNQ3f2a6zDI7HJmOy5z7bBpzn9Dafwcx5N1nuPwtH1+6nvp4VbqSo2wXEemW3ojpUcH+6iGRe1BaGlFTo4lGZXIoML63lU2GZ8tAziF2jGAgAMz872dY1tlZb1QZoiDH2x+FfHDYn7vA1AI0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5KLpwK3ifDBoBVo3F9zLFRQOhRwVaNZNOFbEq7ydYU=;
 b=SpBhEe4piBlqVZrbvJjV4haeHzY2o5f1mYj5yTfkeq64Y1pM1pAQj8uKSWrvnxbUumw1y4pnv89YHJzL+8BllrCDLP5czQUVdf2FB2xUpya6HQngCFLE+hsEu+aAg4YX5ExZJf2FwYNcN5MzdO2gWDzANJ0O4qCkWc+k95X5EOs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0704.namprd21.prod.outlook.com (2603:10b6:300:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.7; Wed, 12 May
 2021 16:03:39 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4129.023; Wed, 12 May 2021
 16:03:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Thread-Topic: [PATCH] clocksource/drivers/hyper-v: Re-enable
 VDSO_CLOCKMODE_HVCLOCK on X86
Thread-Index: AQHXRwtVNnDiDjklFkSFuIrM36V3V6rgAGXg
Date:   Wed, 12 May 2021 16:03:39 +0000
Message-ID: <MWHPR21MB15935352EB587E263D2C808CD7529@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210512084630.1662011-1-vkuznets@redhat.com>
In-Reply-To: <20210512084630.1662011-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9fb28631-f914-4533-a943-f102c3b28a2a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-12T15:55:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7663199-ed41-44f8-2f5b-08d9155f81f7
x-ms-traffictypediagnostic: MWHPR21MB0704:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0704DE09930058D781F29E45D7529@MWHPR21MB0704.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiDgnv4QKO6vr9jZ0xLQ5H16bq2/GyGERWi9+e8osKsmcoufB2kuRQ0AmjzC5Cf3qg1J+nZnzz2vnQJGA2A8YcHdk/QKt6P51PKB90PlJhvfDuJVCIqODnPqr4G3Dg01hk49Uyw1EIKqSnWa1T/oYGUnfdyat7G85XqX6XFvedawn+rvwFP25cOWYv31XzcsKNZHC+wf1W+wNZyg6HtnfiTa7KGEKG6fWkYx90pecPGxOb6Ltcf8h2ndm4CYCyAySXthE1ELrQdm9BwTBruPRCZwJ1vvdi4wVVers8Xt1bHys3jMcAu28DqyaE410fw5V7Hxi1hchJn+ECAQ7AaGt9Y3WHkdDo5yGQ5Qv6lqtLCsqkRWq4XMKVfPhGBJolxi3QPe2bdEZTHWGUeyYS0dkRQLRDQeojDDjQaMk23aCG+Erbpe2SqNxSg0dvtdGtOJl0oSz+QFXJdQsOFZGVLfOWCQ5iiRwtiSUJJp/u3HrqIzv9lT9YRcdwIlA6LIKUXupwp0c+UT7ASpFYStAehuEFb5TFabw2VTdWRhu1+n+KkDpq5mH1Wysrp/ER92REF0pkWVhUsEZYymeSYsdm/3ZreG08lUFnJwPjtgX/+6PFUmEWm0bcdDr+HxRPVO4plSXuDwIkHncNszfH1SxtHpMwbKhLHR5F4hexFY2UN4MG9CpOCX72mL0UURfAIndgNp1VZK9q0taHKr2qt51nE0Vx3vtNF+Re0Al2LzY3RmicI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(316002)(66476007)(64756008)(8936002)(186003)(66946007)(66446008)(5660300002)(7696005)(55016002)(6506007)(52536014)(8676002)(2906002)(83380400001)(26005)(33656002)(9686003)(86362001)(4326008)(82960400001)(38100700002)(82950400001)(71200400001)(122000001)(54906003)(76116006)(10290500003)(8990500004)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rmzB4PmcOTuVb/gMuhgNt9DI99eA6joaVsT6UCer5h59X4TJ1oTRGxmLCvcM?=
 =?us-ascii?Q?Tm6fy7GVVeXUjXcUYPXKd9VkeXjfRuuqq+Cf/jVKU8967zvHd9zBdLXdpNlV?=
 =?us-ascii?Q?g9Bkxxs+t7AX9Le6r1zhqmxFLqiDD9kBGOuPsX/x3p7a250U54JIliXYAMTx?=
 =?us-ascii?Q?pptFuyMGkzDK84+wNZgZKZUPp7j73lTmbdzQF9SLdROA099hUis0rRoaeyyx?=
 =?us-ascii?Q?qyxeJ5qyuRxnAObni45udem5X9n1DBldSOhVAGFQ+EkrH3Jw3tFXAUYggKI9?=
 =?us-ascii?Q?KMVI6sxn+PA++XfT0WX3lHhhCHQRvVzDm2jI9qpMDBfgQyXNaK0YWYQUCfCy?=
 =?us-ascii?Q?7BLWGEjMUHDDSaziBnhJmVZfI2LOiPK0ilSdsJ1cFmh7/npmDEnw0uinLLow?=
 =?us-ascii?Q?yyglhxBufhbUgLhS9KSp63Did30HInHukout5LybgkiNmC0P9k/3lUbU76o2?=
 =?us-ascii?Q?FwENKRBSl4bIFCGYleqeyRyDT/H0M9pnMBC/nWoAjgJaMV6zljXMsIic/Lmx?=
 =?us-ascii?Q?V1UK36pI7InXh7AvpS9MysI8QRBu6peVPQvJD8xrgHtfER6rP+5MlJpY4Ril?=
 =?us-ascii?Q?Zia1pHmHh9VTWZXgWl6A/CUM2rSiExASH6LpcNQ9AlQ/JbYqnljKb3jWVIIA?=
 =?us-ascii?Q?grHmkGABsnCLWQCewd+ofjJPCIwbE7qvr14+pSEmR5r2DHIHERLPESC0KSf/?=
 =?us-ascii?Q?jphpntulgeKI2TIZBwNC5nBxsV+7lNx5qZFZFBKdP9DCO/2HfRGpRjGDT3iH?=
 =?us-ascii?Q?XhpAiijbL00Jr6qVvozgsKiEKr8ekcKrJpos/3GwJ2uQaOGuqcRDdIEWCFoy?=
 =?us-ascii?Q?wr0FRyg2HEwzPoHMcx1Mea6f7aXBtWLNV4N3U1/EfxLVs6aQjhRwC4JzlQZP?=
 =?us-ascii?Q?fYjisacnlAG8HnAHSIq1IlH0lRX2Z59BXKYspZKHXgES+klUROSH5lWFXZr3?=
 =?us-ascii?Q?Pb03+x4PIUbYUPyMhJiK8pKUGZK2EhyFpKLK3eGf?=
x-ms-exchange-antispam-messagedata-1: RDNObe8Pb1JymyH/0UYxBpSMH6b05FBf+8bkCXED3Qy3o39UcYXqWyp3m/xahByHC7pueBth9dJUxwt2ggB2JVanqWGMbxunikmEbM3+YOkIi16cN1wgHLibfc+Du9KhMjC4P0zUxqatyMh6qAXgXlPLkGPlb8risXx+COH11IjbeCoxFien9KBe0wEru/6iSOGfXyd4lNpciHlYrqzi0Pdzch3PS3/25hq3qf2cWerv+9yUYK0QeEiNk8egj8kijzfBDYm/BLeSdLuVqvh1DsUSz3AOZjojLbsIQ+pAX1hqzh2o/OZaiZ0Jm/epxUry5K+Ogsgx3AiIFSTwg1W50gog
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7663199-ed41-44f8-2f5b-08d9155f81f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 16:03:39.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twKcWrf9zYFigh0h5AaDCqyGfP9sBV4mNLy0K8uB5vra9LPgo4wjIlB3PbgGQ/Wu500Kc4BUiRWubuIRQ5ifG61j8DgtZPjqzcuU8rInPPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0704
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, May 12, 2021 =
1:47 AM
>=20
> Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=3D213029)
> the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
> differences inline") broke vDSO on x86. The problem appears to be that
> VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
> '#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
> a define). Replace it with CONFIG_X86 as it is the only arch which
> has this mode currently.
>=20
> Reported-by: Mohammed Gamal <mgamal@redhat.com>
> Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO difference=
s inline")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 977fd05ac35f..e17421f5e47d 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *a=
rg)
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
>  }
>=20
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef CONFIG_X86
>  static int hv_cs_enable(struct clocksource *cs)
>  {
>  	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
> @@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc =3D {
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
>  	.suspend=3D suspend_hv_clock_tsc,
>  	.resume	=3D resume_hv_clock_tsc,
> -#ifdef VDSO_CLOCKMODE_HVCLOCK
> +#ifdef CONFIG_X86
>  	.enable =3D hv_cs_enable,
>  	.vdso_clock_mode =3D VDSO_CLOCKMODE_HVCLOCK,
>  #else
> --
> 2.31.1

Well, bummer.  I thought I was being so clever.  I hate having to base the
behavior directly on the architecture instead of the actual VDSO feature,
but I don't see a way to detect whether VDSO_CLOCKMODE_HVCLOCK is
defined or not.  The other alternative would be to add another #define
such as VDSO_CLOCKMODE_HVCLOCK_PRESENT in
arch/x86/include/asm/vdso/clocksource.h, and use it in the #ifdefs
here.  But that's a bit messy too, and I'm not sure it's worth the
trouble.  So,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Mohammed -- Thanks for finding this!
