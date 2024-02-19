Return-Path: <linux-hyperv+bounces-1577-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77D85AA67
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 18:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BF72854FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Feb 2024 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8E40BE5;
	Mon, 19 Feb 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ixM4yGtC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2042.outbound.protection.outlook.com [40.92.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A343B19D;
	Mon, 19 Feb 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365210; cv=fail; b=BBTBZ16t+ryKsKggONsDLejNOlrwoqwdB0eWTedg9gTBchVBt4SG4niqOGFNzVRNWX/OPJCdQ4IrBsqUe4mvr3adGdc24hnb59LmSonlhcJ7MsfcL2iAdD+ScGkGWV7CeyIiFMQiFmI4BDC4lpRQlfBdjwc/K8GoEF862PGZ7q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365210; c=relaxed/simple;
	bh=j/qgfFQKXqEnK8CE/1YR9LQ6S0y32jd/V6ZHPAQhPEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gyVyAjcupycm2TAc6tYd8TOodZRrZWa45SFMf2RVimcTfBfI+5+MF2Fm7+zD2kjfOKPKZatcaespOk1mJpHYAtypdOi4RGX4budtJzW+lAv+h9MHKwwWyzE6+rFrVUdnBJs4LmVtmoZk60nNyyy+obgfHGdt9UC6jHDjgVm3W8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ixM4yGtC; arc=fail smtp.client-ip=40.92.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKjIABUx+4qtJ9VSkKRQl/CO9OyB8TUWTu9oO7T/KIgSlULzpoWiGOd6ZIDUp8i7lfbUvz0CsSU2lGotepQf2jS3fLxJKjJsJoAeSvKFpSD5k7/YKLVBPQhytQ+I+znNQz0LfkPN40xMR4dHcwzbqrT3BMbsfbkke8aShHuoGR1k6QGrwLfi/9s5CyeI/0FGfzIz/0rN179qXjLtasrJt9c+fiTDKqwnI1axcJ9iE6wXcyuj1h77zXRMPlMgfm12eXjcH3jrSx/CLxs3FLywGj5hGD9400yvBiwUd6VXMxizFeE7he7RB2k/hjYGS5Wgg9dyEZ6IQK9CuGWt2VyM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ7//Y5aJCEY7dZVimJjpgIpVecczmnvMtZfRbJOYfo=;
 b=CCTNnHHbf5ziIeoTmGnOCMkWdg7gz2ZZ8bbNiqLCB4dRAejNZ8X5Y0YcnO2e+MsApWYhw/zn7VY6dEOu9cXpwgkEQ3fNUrRiuu144iWYCAji3PQh3uQJ3xuu6LSjNKljUUsOgTFXNlKGom0uPp+SPlQMcdDFSMlVmI/+Yl8Eol1nwVNCWof77dvnlsvUPdC1LkZpaXg0i+jyFb7Go880VxFiF9lDOvi4x/JvmhsXvR2L2sEl9Et0xxg4t+XOQcMp2TiWlMxx0Qqz83ZNP3fFKIEXW/7NCQOVq/2/fVAohOg7An2AoH6R/cP0/BOoZPYrJ6ZRtMXntff9n980O2+tLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ7//Y5aJCEY7dZVimJjpgIpVecczmnvMtZfRbJOYfo=;
 b=ixM4yGtCm+733Z536PaP78Yvl3+FdQ9LHLxWobL8E58aIBwZuNGtVT/kPM/ZjDKiVP/CT1Yz1ozEJa8+S4rekszUHPIi7GjoF5/MFcndK4bfv7rwNna8rVyC1bhcb9mHtszJBc0jMsTDKQmEbwMqtUFxPWX+jXuWzIxfs1hJqdTtpZZDPl/k7I5cXpW0BMoqS7QVysO+vyJEqCvcBFH0GUkjP5rh452TnX3VJ/v1OgqkPtUMx84SLtErKjT7dc1hxLNurzbKB6M2cEQfkV1is5ictZiQzARTWbFksb/dlQqpx1iQ2J4Vt2Z8vrlDqZOv3raiSVjJS7oYMMUt+ckiDg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7197.namprd02.prod.outlook.com (2603:10b6:a03:293::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 17:53:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 17:53:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ssengar@microsoft.com"
	<ssengar@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-V
Thread-Topic: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for
 Hyper-V
Thread-Index: AQHaYOHvK5zyzBkwkUeCyKTO1/OqarEOuT2wgAD6DICAAj61sA==
Date: Mon, 19 Feb 2024 17:53:25 +0000
Message-ID:
 <SN6PR02MB41573212FCDBDF58305881ECD4512@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com>
 <SN6PR02MB415758508A7BE89E0CFBD976D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240218071727.GA19702@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240218071727.GA19702@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [D+gHYmNQWzxy1Sdfl5o1+0j26BXSEvJx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7197:EE_
x-ms-office365-filtering-correlation-id: beca78f6-3bf0-4815-4fdc-08dc3173abe6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SS7hLwU+PYPF+IMN5SYo9aNDErCbFe+i8e1H+O2pxYFWA1unlgXWc+KeqYk5faCSs7hn1qf8nQ4e2Lw9lFfKI/bm0cFR85f76DAtcT2QRwXo3DKq/LJIvlTBgWHLfriXFQ73Qu88Bm4bXpaGM6v6WHIe3HukGiOcbZVQ0VpEd8Zz84VIrV9gbOJBNofIhKDrPx7pzY+Hy2UtjL+nwW7JX4Rezw0wgZWGBnM4kMI92I2oIGWklfNsDsZu5fhrHqKChdDg00P/WSwPLm3JLwDT9ILZnFfoLBXtJTd+BobtEN23KmWu4hGFzBaN1Ql/mOvW1XcEX0FKOhZoXEf/znxiF6vMO3tH8uJFgZJoX3wzMOpYpTxAKr6h2FdeIcIH4l4JrafiwoGn5wOxcHcrx5NitR2rzpMsr/mCUlbRBPh+TKmlBCpZtpOw6BDVWIFuWU/q9vAR6NvnBgVIhk7XYTRhFIwT9zK6gM+78kB67/pH2HCD16Ie8NbLQOSZOP65chqKNpVQquyq2qW1rtanBcdv3pki9suhk2I/XR/xZUd3gE7n7d31Q7YvoWd0ikxe8EclgmSepgu0NEsxYGZcmsf5Wpq/s9UQHYqbi6p+IBOsmFI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8ba9BTlYh2H/rm8GLM2izt93X56BWrl3aeJmTZWCznrFH5M8CzbWnlAcg5n/?=
 =?us-ascii?Q?GRl3QNFyrrIroIr+Ldy2BIAvZ1VeHustxoURW07ou9exI+/JO9GFulaUZkzK?=
 =?us-ascii?Q?TdrBh1h/o/jW6NdsxwC03SvRS09ZAC8rLC8iekhVM1WZlHkbWdG5UMGVuEJJ?=
 =?us-ascii?Q?HJSkXlSBIj/KplTZZwB9SGW5ORfBDVZgeY69I56xZtYXe6Xb96CHSEPEC4E1?=
 =?us-ascii?Q?EHprSJU50ZZixOt/kbtW2ySUxdxnkU48qKCJ76Zi/DXqpUYIi7aMPV13JhKK?=
 =?us-ascii?Q?1vk1zfv10IoFoizsuzlgkDdhAgBizLF3UNuTVcjgxmKCDta1TOwPg4rs+ysT?=
 =?us-ascii?Q?lLb5QHdUV1umTSvwIpeqgQYCA3bSc0KCnh91Yml6AL+DFiTSJAAEl70G4lnR?=
 =?us-ascii?Q?QW/TymrHXUJAkoZff9PNn1HnSJINzsxAoOchJXMsPpIKEI0/HTwdKkhkwhRk?=
 =?us-ascii?Q?7PClv2BUx+aldBld8mKXRpcVWBN2VnRLOR225sMQYxaB8apd9GnD6IC3rPsY?=
 =?us-ascii?Q?Cy+H+MHslVZueFryznH0Ci2nvjfqhP4URenjneoiKkxBgbJDV8/xczuD1mn5?=
 =?us-ascii?Q?tidnI/LVFqSAzg4ujcgQY7yZY8ANUK0GazhcBXx50ykFUCIg2N//XVMp5GIw?=
 =?us-ascii?Q?6UIeZ2PS2KJJk/inul7WXENecorp0sZI412nj/+p4fy1sF+RTETKz/aQ5WVB?=
 =?us-ascii?Q?casgq5HmaMCcORe5phf+yQFanLPPz4ASDTB2aBDDCSkl7Bxw/E1DVZBEV9iF?=
 =?us-ascii?Q?w2rYNdP+6PB9naQC3W9UB7Jmuv1Hr9nl8ID1D6Bde0/Wpl69sW4PXtQ2dODH?=
 =?us-ascii?Q?AV8G5pS05ejmUqfe1gybmPbbAj00GeLID0226tyXiKXhF9dKTTFbN0GtT7nz?=
 =?us-ascii?Q?tZ45Zdf++swP39oL1L525PyGppVMjhavs5iGugtWaXKTRJKski+r4pPZb4Jz?=
 =?us-ascii?Q?XF1E9KkXSq6Fj9Y+NOtabbeQF37XA+a6OlHvwWZy9SZvL/DBUF/AKe6b/dfc?=
 =?us-ascii?Q?0aTbH/6QfrAAmam0tlp8i6LYs3aWi7ULdwojdA2MD3hdPadGBWV2x8YgqlwM?=
 =?us-ascii?Q?Ig6yhItqcPprp8xA6K4aWoCQxOP0PsYmzqmWYZKB8Hkp3fcCmsL3YHK0Sfn6?=
 =?us-ascii?Q?DTu0tcpu8MnRW9jSpqy3VYVYGsP/eU/WWrHAhP88jmu3yqO+26p8m80D5uej?=
 =?us-ascii?Q?XK7wcB7ZbvyvfNHgLMpCE+WjA0C2UHslSgMCTA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: beca78f6-3bf0-4815-4fdc-08dc3173abe6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 17:53:25.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7197

From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Saturday, Fe=
bruary 17, 2024 11:17 PM
> > >
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index 0024210..bc3f496 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -9,6 +9,7 @@ config HYPERV
> > >  	select PARAVIRT
> > >  	select X86_HV_CALLBACK_VECTOR if X86
> > >  	select OF_EARLY_FLATTREE if OF
> > > +	select CPUMASK_OFFSTACK
> > >  	help
> > >  	  Select this option to run Linux as a Hyper-V client operating
> > >  	  system.
> > > --
> > > 1.8.3.1
> > >
> >
> > I'm not sure that enabling CPUMASK_OFFSTACK for Hyper-V
> > guests is the right thing to do, as there's additional runtime
> > cost when CPUMASK_OFFSTACK is enabled.  I agree that for
> > the most general case, you want NR_CPUS to be 2048, which
> > requires CPUMASK_OFFSTACK.  But it would be legitimate to
> > build a kernel with NR_CPUS set to something like 64 or 256
> > for a more limited Hyper-V guest use case, and to not want to
> > incur the cost of CPUMASK_OFFSTACK.
> >
> > You could consider doing something like this:
> >
> > 	select CPUMASK_OFFSTACK if NR_CPUS > 512
>=20
> Thanks for your review.
>=20
> This was my first thought as well, but for x86, NR_CPUS itself depends
> on CPUMASK_OFFSTACK and this creates some kind of circular dependency
> and doesn't work effectively.
>=20
> Here are few key points to note:
>=20
> 1. In ARM64 as well for enabling CPUMASK_OFFSTACK we need to enable
>    DEBUG_PER_CPU_MAPS and that will have additional overhead.
>    This dependency is for all the archs. There was an earlier attempt
>    to decouple it: https://lore.kernel.org/lkml/20220412231508.32629-1-li=
bo.chen@oracle.com/=20
>=20
> 2. However, for ARM64, NR_CPUS doesn't have dependency on CPUMASK_OFFSTAC=
K.
>    In ARM64 NR_CPUS is quite independent from any policy, we can choose a=
ny
>    value for NR_CPUS freely, things are simple. This problem specificaly
>    to be solved for x86.
>=20
> 3. If we have to select more then 512 CPUs on x86, CPUMASK_OFFSTACK
>    needto be enabled, so this additional runtime cost is unavoidable
>    for NR_CPUS > 512. There is no way today to enable CPUMASK_OFFSTACK
>    apart from enabling MAXSMP or DEBUG_PER_CPU_MAPS. Both of these
>    options we don't want to use.
>=20
> I agree that we possibly don't want to enable this option for HyperV VMs
> where NR_CPUS < 512. I have two thoughts here:
>=20
> 1. Enable it only for VTL platforms, as current requirement for minimal k=
ernel
>    is only for VTL platforms only.
>=20
> 2. Fix this for all of x86. I couldn't find any reson why CPUMASK_OFFSTAC=
K
>    dependency is there on x86 for having more than 512 CPUs. What is spec=
ial
>    in x86 to have this restriction ? If there is no reason we should rela=
x
>    the restriction of CPUMASK_OFFSTACK for NR_CPUs similar to ARM and oth=
er
>    archs.
>=20

You've done some deeper research than I did. :-(  What a mess.

ARM64 seems to have it right.  On x86, the dependency between NR_CPUS
and CPUMASK_OFFSTACK seems to flow the wrong direction. I would think
you would select NR_CPUS first, and then if the number is large, select
CPUMASK_OFFSTACK.

And the display of CPUMASK_OFFSTACK in config tools should not be
dependent on DEBUG_PER_CPU_MAPS.   It should be easy to independently
select CPUMASK_OFFSTACK (modulo architectures that don't support it).
In the Libo Chen thread, I don't understand the reluctance to make
CPUMASK_OFFSTACK independent of DEBUG_PER_CPU_MAPS.

I don't have any great suggestions for the path forward. :-(  Maybe
revive the Libo Chen thread, with a better justification for removing
the dependency between CPUMASK_OFFSTACK and
DEBUG_PER_CPU_MAPS?  Or at least clarify why the dependency
should be kept?

Michael

