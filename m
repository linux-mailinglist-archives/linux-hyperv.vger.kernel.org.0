Return-Path: <linux-hyperv+bounces-3588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39CBA030DE
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 20:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E743A21A0
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jan 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC577F10;
	Mon,  6 Jan 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eehfHuPt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBD360;
	Mon,  6 Jan 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192959; cv=fail; b=mSS3UfD10dMx6MZI+4MxatSk3cCaVjTI7fmsyHLcJFy3KOCAf/kZnjZcgHqYYcXfv1AIIhEBWpYehTMnRoRncZpVHOxV51Fp7PtwrzovFfZxDhPjZND3jaZrN0Hr7gJMlLDStK6v88g+vMXklryZUsbcAsRbJHkeQAF+You3rGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192959; c=relaxed/simple;
	bh=0qoJ6q8Rmwf5dvRizK6Z+cela9DldH7GOjHHZZ7mc5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMRCMIFpTKQ07DxTTs77Eo7ZVIe24wKIX00yJsGY3WJPk2e0w7xtLvMpCfy5y1zaF7fTifkQMyq0I6ojcY2Mj9qvg5l5ebCHjQfoKbl7OWf92EPXP0dmDTVKIDaLo3DjGWQlcCSwLdoSV7DugrPjXjX4KzGehunOsGAa6b6IzS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eehfHuPt; arc=fail smtp.client-ip=52.103.2.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI3FHTOY2TiwoDYve77Su/Ib0xkX4GgfluenLf5riD2e9zPyta4zOlVgfJiq7u814K5xKqVpgov14msmuyQ4u8ZbuDmPeuKcn0yq7CN+dytzF4sjV+pawvsgZ0A9kBkAQ78e+3/viE563xESsqCADay+v5W8DQsF6OzjlmvbAPhKIgarMmbx6qAbkd4kwMhOmt8/9TtrvSSNQlpkc6qFK0beVlM0GTZ/7IP4sZYscwd9tCuLinyQ932YHHr3SIyQYqcDwOmkrw+PTDPQzyNGmirFvYOFYrm9X4yX6oeorTCBUFguRU+oxeR3lMCa5k2NxKmVSoVu3Z/Bj04UoDsAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeZZnOtrfvZ0CK4xx0Q43MSZvadzZpHzFTfOhFgsDdg=;
 b=YjyvKI4xThVj+7Ut/+3H08mNWEeT96QqgPaAvxjEyFqQoR7TvfpOddTg5UdoGeR+AdspeeYiO/294j1nxHK8Hb26xC4FDJvr3zjIdy4130dqrzCp9gTFuMhEkkK24WAJenmZb0vAg9EPnuuwkuYDzpSjQ9v8tHH6nUcO9TP60jBaxMsEkdGnRY+rfwTJau9LrQUywcWGZ98yH4IuK2YpLSqTar+IvoaVdSIU8I05sAJSItL35+arohfI3wIj9IGYM3U8BwNsxg/uDUHM9QaPF6rqXTSvy7zItyYASSHiA0PL66Ym43G0ot+8r7RC9KzLdhdl2DiIhOYVDIEkxkHI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeZZnOtrfvZ0CK4xx0Q43MSZvadzZpHzFTfOhFgsDdg=;
 b=eehfHuPtWiEQFRk9L9Yojl0KfDJ2894EUxrQmUKwlK6bMkdzkxrrv5MkCd94qosZZUQFsw9hwX+btYxhQvmXZZQSQvfM9o3XgWAuFbCqoeKUNOKLfwtuy42Y11leVkP1j9vQI3jnn5GkXk4gLvX9XUDWu5KTgSOy60MDibMYs1AZcc7a7YFUObPmMaNyVun0CzA7vHpq4xaqEggSfXhgqR87UwWUdyvsUHEM5GaMdhpJxhfSMN1rI+OLn4/4W+GYhwyg4K6nn8rDOSfYjqf42OlC3IpH5xEuVdtM/55h5bbhrILzXpxLZdk9u6IgkHYK6BzIBTt1sXmoy82MO05ZHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CYXPR02MB10268.namprd02.prod.outlook.com (2603:10b6:930:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 19:49:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 19:49:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
	<apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>, "sunilmut@microsoft.com"
	<sunilmut@microsoft.com>, "vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: RE: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Topic: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the
 VTL mode
Thread-Index:
 AQHbWuYCjpxLpvSze0qhquwoWcqvGbMFcy0AgAAtWgCABGkAAIAABGPwgAAcCACAAAOEsA==
Date: Mon, 6 Jan 2025 19:49:15 +0000
Message-ID:
 <SN6PR02MB4157ECDBBC89D0E838402528D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-4-romank@linux.microsoft.com>
 <20250103192002.GA22059@skinsburskii.>
 <SN6PR02MB41573C71F0BD479FA24A30E2D4152@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250106172312.GA18291@skinsburskii.>
 <SN6PR02MB41576D6210E0270610F55DB3D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250106191914.GA18346@skinsburskii.>
In-Reply-To: <20250106191914.GA18346@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CYXPR02MB10268:EE_
x-ms-office365-filtering-correlation-id: 9a448a1a-b025-465e-92ba-08dd2e8b3335
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|8062599003|15080799006|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?y5RxAYiHc9blGuLUOB2OBh9ePQ2CP6DWzJt/9ypoK95EuIDdoClCDvI7NZVp?=
 =?us-ascii?Q?cSyVab2FCO4Oq94gI3X1iKehJUemfJiZKsoyUxLe6cJFiW3l5HdCusxNMi9s?=
 =?us-ascii?Q?3o7FJYE7wE0bGvLojmoxIlMcY6WyGne76f2Zu1O6v72lCITvU7qy++hE3k03?=
 =?us-ascii?Q?aa4rSj/LBNu5MdSTgX/XOYExpziXm+Z+bVwOmYIFZqEhkgX/duIJGDBYPvpk?=
 =?us-ascii?Q?wd0uPHnj3vXKlXvt8t3B0E/SasOUNWJjhlPtfPNcAoRUUe+m7+B2JwAzam1F?=
 =?us-ascii?Q?O9D7o3XM4VcRZaCjrcj3srxK0y0qnGhvxtRqyQGBbVUiJtIuZXfDENabxazs?=
 =?us-ascii?Q?AMux9N61dAXoUTPe61qogcvg+eky2/Pot8r6L11tGxmFlQFK8JlWyuyogmV2?=
 =?us-ascii?Q?zG8bRlqd/vl2MTNK5illdHDyXeMw+RI30SiZ8XwtpSPwOOW0O0zmlFrh3GpY?=
 =?us-ascii?Q?/d+UHPtfVjILMrPYbRMFPcF60dvqp85K1yngaSy5onSwVj38DHPNUNkAHuwl?=
 =?us-ascii?Q?hQHlBbzckK0vdeaFqJi5GmSAqH227cQWQVp2hARIggATMJ88UnrfbJUzg97e?=
 =?us-ascii?Q?Pe8hfdQa9y905woLNza6YGrWu5JK2+1UFJY0FVBhB7ECIkTwsxJ5xmoz5SUG?=
 =?us-ascii?Q?IqVGdSN3LoAKNG+2yN/bb/8afOb8XngtCWLh6lKBkjMF3z6Cshb10NkKIEEi?=
 =?us-ascii?Q?1sb6OXrldfFcB1kzLl+0YEbvIIou1O2eOHqgZ3J4Spgtry5+DyDQe6rFbaTQ?=
 =?us-ascii?Q?/SNHxYwbNCeRrf7/0x0Ps3B9HWUiMn/jXTIEZo780hKptdUZTJTuou6EGQeD?=
 =?us-ascii?Q?Hnl62r06628V8vabfzih4qZiSSvrR86o76Z/cvO1NhdaOrg9j3WncKuYZ7P+?=
 =?us-ascii?Q?JSDRD8ZPhLVfJYL0fLtLg5g0DLycXhjw4DeeVvwU49J9AOvJZvI5sYoafmof?=
 =?us-ascii?Q?AsSpSCZdie89Ph2g4r7kUZzXHK15BrhkRhMsM/11/IzJe80np7aqg0iRSimN?=
 =?us-ascii?Q?HCaqtjQmWXXfN88GWN5HOrUfwlfw8+aMst+0W4Xfx/lyO6k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MBJX3w1btFy73qyjq28qBXSsaFIJiFYsRbWxJuAwYPfLm0GSFF13/Vs3TUP+?=
 =?us-ascii?Q?nxUl9BJMAKhmPEMMZgwlEziZfWJ6NTcgeXixlqz3VhMA36XYaTOHy7FWj5fT?=
 =?us-ascii?Q?Y9kdfRBq4iI7+zIkBCZ0DrC5CNe1xQhMJNLXPNY/ioJILGHC7NUoIz0iZte/?=
 =?us-ascii?Q?kgViobL04e6WfByUArR4WGppyTUmcB2LQrFcc4bKxGQ9Nxj2WNPco903wk2D?=
 =?us-ascii?Q?FsWp83+JkUXfQAVsDyYTgo+AyBjfzA7IR6NQm2xcGFRKRpgcPbBM/Vdn4kcd?=
 =?us-ascii?Q?fVcX3NgljfjRWSw9G7z3LZzQHb2S6Igk2OQCUttpbB5yb8AaqTmbJGzrgIxY?=
 =?us-ascii?Q?2vOGnNxDVECd5u+DE+pJ5KH0t3L4sVMnGvKKpM20gV/BP4Hp4NupD2ULhUXW?=
 =?us-ascii?Q?O2Xv9+yKf/vXWJOUe2J0dHGWrh26t1tbPu37VOQ6u6xaAfTvdi49aBMhwUCT?=
 =?us-ascii?Q?jyhAwH67LFi92b9qgqdwxHPJMcn/U9TkxsRTQmhVPK57OA1y2GGU9oBQOias?=
 =?us-ascii?Q?lqO0rKp30AdVyHGkXxXaMDDPl945Q3lGBAL6KNq+KvO1auZ7e3PDuP2ToaHN?=
 =?us-ascii?Q?FYFvSdX0wD4Xya0UJa/R6Tw7O3QufndZfiz28T/vuVJfnxkHqYqOeRlPrHSf?=
 =?us-ascii?Q?mH1Wp6nPTpnUFvOm1sE8vQSnqnhfdJvwbDjwjpaSnCAjd9Imwh8u+ZjJsand?=
 =?us-ascii?Q?Xy1GbahhrH5dOpFC5Ft5MPgsIrva76Ok35/2N39Cqq+nPLy3jfGrwhZMwvbz?=
 =?us-ascii?Q?DHPdn9cRZkf/TFd+9GOuIick8AE7RcgK34XMPxdEkGtiIoAPS7SozXuwLqJz?=
 =?us-ascii?Q?wrjKztzPvqHG/hXuj3luNc/FASx4kFFC90Le75t1issdybVrpoLUW42Hy/Mk?=
 =?us-ascii?Q?MV4O8ReHk0Odw51+zVuHBZR89Li9TkIlO3qzmCGkdRLAZEgpebIglVJyZ4l3?=
 =?us-ascii?Q?e1BZqJaO/rVNqgZ+kmWej29kZBKtAX9LoP/DCr/ZuB9qLlru556U6/iYf3wG?=
 =?us-ascii?Q?M8J4Tm3k8ppx/SX6+5ICFo7WfPp4f2FA8jaAwGznuPfqMJ0E5PQQW1JIB3Ez?=
 =?us-ascii?Q?ML8H2ciWesnlzQPZONx75h220Z8csncu+wMhowndFVXU7fuRAQU5/TvNLmXR?=
 =?us-ascii?Q?GfJeVnmW1LZWhCx3nbKcQ1oBcTh8Pkqy1rFFhT6808JUbn+ZmrwErz99A5u9?=
 =?us-ascii?Q?6HOZDTYC/VZjnmIpdx56A9TVPtjZAh2GaCBeZJAdg9H03riybyeDr+KczRA?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a448a1a-b025-465e-92ba-08dd2e8b3335
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 19:49:15.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10268

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, January 6, 2025 11:19 AM
>=20
> On Mon, Jan 06, 2025 at 06:18:51PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Mo=
nday, January 6, 2025 9:23 AM
> > >
> > > On Fri, Jan 03, 2025 at 10:08:05PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Friday, January
> > > 3, 2025 11:20 AM
> > > > >
> > > > > On Mon, Dec 30, 2024 at 10:09:39AM -0800, Roman Kisel wrote:
> > > > > > Due to the hypercall page not being allocated in the VTL mode,
> > > > > > the code resorts to using a part of the input page.
> > > > > >
> > > > > > Allocate the hypercall output page in the VTL mode thus enablin=
g
> > > > > > it to use it for output and share code with dom0.
> > > > > >
> > > > > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > > > > ---
> > > > > >  drivers/hv/hv_common.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > > > > > index c6ed3ba4bf61..c983cfd4d6c0 100644
> > > > > > --- a/drivers/hv/hv_common.c
> > > > > > +++ b/drivers/hv/hv_common.c
> > > > > > @@ -340,7 +340,7 @@ int __init hv_common_init(void)
> > > > > >  	BUG_ON(!hyperv_pcpu_input_arg);
> > > > > >
> > > > > >  	/* Allocate the per-CPU state for output arg for root */
> > > > > > -	if (hv_root_partition) {
> > > > > > +	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) =
{
> > > > >
> > > > > This check doesn't look nice.
> > > > > First of all, IS_ENABLED(CONFIG_HYPERV_VTL_MODE) doesn't mean tha=
t this
> > > > > particular kernel is being booted in VTL other that VTL0.
> > > >
> > > > Actually, it does mean that. Kernels built with CONFIG_HYPERV_VTL_M=
ODE=3Dy
> > > > will not run as a normal guest in VTL 0. See the third paragraph of=
 the
> > > > "help" section for HYPERV_VTL_MODE in drivers/hv/Kconfig.
> > > >
> > >
> > > Thanks for pointing to this piece.
> > >
> > > This limitation looks aritificial to me and as VTL support in Linux i=
s
> > > currently being extended beyond Underhill support, keeping this
> > > restriction makes some further development in scope of LVBS support
> > > complicated and error prone due to potential ABI mismatches between
> > > Linux kernels in different VTLs.
> > >
> > > IOW, making the same kernel properly bootable (or - worse - explicitl=
y
> > > un-bootable) in different VTLs is a more robust way in the long run.
> >
> > The reason for the limitation is the sequencing of early Hyper-V-relate=
d
> > initialization steps. Knowing at runtime whether you are running at
> > VTL0 or some other VTL requires making a hypercall in get_vtl().
> > Unfortunately, the machinery for making a hypercall (setting the guest
> > OS ID, and allocating the x86 hypercall page) is established relatively=
 late
> > during initialization, in hyperv_init(). But running in other than VTL0
> > requires the initializations that are done in hv_vtl_init_platform(), w=
hich
> > must be done much earlier. There's no clear way out of this conundrum
> > purely on the Linux guest side.
> >
> > To solve the conundrum on x86, one possibility to consider is having
> > Hyper-V make HV_REGISTER_VSM_VP_STATUS available as a synthetic
> > MSR, which can be read without making a hypercall. This register could =
be
> > read in ms_hyperv_init_platform() to know if running at VTL0 or not.
> > Using synthetic MSRs is how other aspects of early Hyper-V-related
> > initialization is done in Linux on x86.
> >
> > I think there's some discussion on the x86 sequencing issues on LKML
> > from when the VTL code was first added. I was part of that discussion, =
but
> > don't remember all the details. There might additional issues raised in
> > that discussion.
> >
> > The sequencing issues would also need to be sorted out on the arm64
> > side, as they are different from x86. We don't have an early Hyper-V
> > specific hook like ms_hyperv_init_platform() on the arm64 side, so
> > that might be problem. But on the flip side, we also don't have the
> > x86-specific messiness that hv_vtl_init_platform() handles. Also,
> > there are no synthetic MSRs on arm64, so register accesses always
> > use hypercalls, but there's no hypercall page needed. On balance, I
> > think getting VTL stuff initialized on arm64 will be easier, but I'm no=
t sure.
> >
> > Michael
>=20
> Thank you for summarizing this up. This aligns with my understanding.
>=20
> Since VTL1 firmware is a payload for VTL0 kernel, one of my proposals to
> the original message was to explicitly notify the kernel it's running in
> VTL1 via command line argument and/or DT.
>=20

OK, yes.  Rather than non-VTL0 behavior being a kernel build-time decision,
make it a kernel boot-line based decision. A runtime decision based on
detecting the VTL is hard as described above.

I don't immediately see an initialization sequence problem in using a kerne=
l
boot line parameter to specify running in non-VTL0. I'm unsure if DT would
be available at the time ms_hyperv_init_platform() runs and decides to call
hv_vtl_init_platform(). Have you looked to see?

Michael

