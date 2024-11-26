Return-Path: <linux-hyperv+bounces-3363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115269D91A9
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2024 07:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C482828352F
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2024 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F654782;
	Tue, 26 Nov 2024 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DMbacLy/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012070.outbound.protection.outlook.com [52.103.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB45B67A;
	Tue, 26 Nov 2024 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732601475; cv=fail; b=oKGxKE5IngKCN/UaRMm9YFb3h7IzwjvCkCByFM8dsyNDb203Qau7VNtT0mmZDXUWflnGDL+FsbV+iIEaEcbSwnF62WG2LxPHuDjnZWegNh+V90jSn7wLimwc9pGo4dH3+o5eOmoordzSqrEjQ1ouU8rwLZsrYdAf/9MHg+MlymA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732601475; c=relaxed/simple;
	bh=cDvVgBZ6PHdX4bM5CYkjLtEZruROYX3mQ+rQ7wJDn2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dz19H7G+9OIHgTrx5/EwaU932UNWqN3nAZgz2lkEJ+HmYukfVnIX1tcpd991v7uR7fs/tQKWLKOp8io30HBAPS62l733ZNwdyiugmbOoiGm5M+RQ2grFSK7hciYbBxAdYGTMgv6qC+bJ2BCumq8d6YF0HldLtvSczWhMhhoDftw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DMbacLy/; arc=fail smtp.client-ip=52.103.14.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toUflsZz6IK4S2JAHEsMe1A7rs5M20UcgQ0g1mxoBg51wHt4uLJdVMsTUjmdK5s4p65IIu5FKLCNq8+vNFCRIN4N3mCLEBKYYsZN5slKA1nGhiiKTNXopdsd5xPIbZS4xA4BjR2agUeVf6/9CSrz9I/QR2kXO5nSdUiBQ/p4JtANob4Vk8rDdXFUn2s/B5DaCj7ASenx/ZxqNhxeBG4pSY72du+qDPAvQ5KFutyAtDX4kK9qyqEMICTmBuWhFDm8YJAu2qIrJJD+lN8otYHlUrPIyYV/+jaGlVsgQlms31VCIH4EvduYLSIZiguF7tcAOP18rkjAS9HwFO/rXdbXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvEi4prI50cVh5w+x4vmek596cwOorGDkrc9ogDbpkM=;
 b=nSLEvcoWgYT5E53Wqn5ianM4+O/84SdlYzv8qCZE6ssMDOWINN3DWyAnwSHTdYLzlOWs6qCckAl8SFlIb/EAr3Hy/pqSvHMaE7xptPZgeH/lUhcq2EG4LYFljds2Ug2IPLpUWrFy6jytIcTbCs14KXElCRxr+bLxBZJNJ/YDGoQBhDpxCgSbRsvcakgzAOBlwj6K16VwWI0ds0ejf2HxGCm8suA3GM5TXy4ZiodbxsCdkAtRt1ifPTaBVn2kxd8VUSGu1ZqfIZGss4Le8ft4FrVBx1jnsXvOb0Eq6DJEddL84JUdSKW8Pwgqm7VFPOVIWUAWd+WXNhggFAg02faa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvEi4prI50cVh5w+x4vmek596cwOorGDkrc9ogDbpkM=;
 b=DMbacLy/l09kahl3+plTXd/DlNAY/MVnBC0RZsFo0wy/eTuyOH8R04B6+LQEcZMW7weDMxYfQlln6G0nlmvjVWtEssevl7AVc9KPua9ioTPJUUDoICPQ6jaY3Ibk+S9DnkgqFI1y6ITworC3qP5xJQKsc6FzcNj7wi83HlML/PeUt9ohsFMWIGsiIR0DLgKcoH3mNXTaXb97INtjw7+1x8O3xUnbquEl/EGD7nLWHeROD3BNYomrUhw6TrG45qY6nR27Nkpd53dUxIRQ8Pgydg3/80IoBeHhRafiADtlncWZc1cPZRslaD6LmcavRqsVdEnLMEtQc2P2F/rEj1AUXg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8447.namprd02.prod.outlook.com (2603:10b6:806:1f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 06:11:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 06:11:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Topic: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
Thread-Index: AQHbNS9UbXwh5KJBoU2oxHpKRgf4mrK0CjPAgAtX/gCABEfyYIAE/TWAgAB/NKA=
Date: Tue, 26 Nov 2024 06:11:10 +0000
Message-ID:
 <SN6PR02MB4157344DE32DF479543CC2CED42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241120005106.GA18115@skinsburskii.>
 <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241125222457.GA28630@skinsburskii.>
In-Reply-To: <20241125222457.GA28630@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8447:EE_
x-ms-office365-filtering-correlation-id: ba9215af-d044-467c-a93b-08dd0de11fda
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|8062599003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?e6lEXR0mbR2yBac2aEUaK9fgQfHyRqlabiE+opf7Bwr/9UtUuX94eacR6gBQ?=
 =?us-ascii?Q?e7DI+rQDoVQsG27j7f6o74j9xyv5S4LUZjGs6CpIAn1Ggu4XQw3cVa+nM323?=
 =?us-ascii?Q?BJ/StO7LTiGjEi+Hn9HIK072WgHyvhHc4tfJX9Ckg3DRCfBDguEXa9fu5wjy?=
 =?us-ascii?Q?8GBzKbl3AtTdLW+699dwrG00SPNphsGaehll3qV6Op9dOe9WquS8tnlQb2lg?=
 =?us-ascii?Q?0rm9kH+zyhsaeDNE5GQ7Xro+lA6RMkQWj6+lAziJ9MyFxJXLAL963KE0SRMh?=
 =?us-ascii?Q?DmV/8IfMcPX4n2Qm1TU9rq730ypnOOmBLXQaXjX6F0NrmSDAIBkkieY0ROKJ?=
 =?us-ascii?Q?Tjg23JTLEEFoGkXZ1HTmEph6l+452mzQYmnBildV0jqhbPowm9hVdkNQ7c6M?=
 =?us-ascii?Q?7X1Hvv+F65RY/wMGNB4ReIsdR30c8gS1+lHRqPpZkHFZKiGEdHYcVKtpH/b0?=
 =?us-ascii?Q?WDN08Tkum5xC7aa+CUgDfxPtt9YFIAGaWQ7wPZs2ukL4DIOTUhY3Vaw0RmeC?=
 =?us-ascii?Q?4La5Qc5IsicjX7zkDgS4U4aN/Dk58P64OAvjyIcagJNmFUqjFFaE9EAOVjeK?=
 =?us-ascii?Q?bK4wepGh63F5ia7OfNPUpcT3GhvfBUVRTUwEV2wKa7w2Ni5YfsJmnCRGggS4?=
 =?us-ascii?Q?fhDOneG7vrFOGTsVsWlbRlisv4GpM9bKZC3fFjDM6ugstoR40q2fbyCHxLji?=
 =?us-ascii?Q?POGRHKZliwCJXegiS/r81vPbngcuYChqfp7lRaxO7SDAhM179jBBv5dMm9T8?=
 =?us-ascii?Q?Amy+hzO73P1A2edTS0rAdMDl9pMqoLTkJsYQvz74DzJUwd5Lwg49wefc9NCp?=
 =?us-ascii?Q?rEyuHZvzIPjHu2k7XqoBzfcSdZef9Fcd4nRibXs/HAJgu/5FzWmnggW1HqQH?=
 =?us-ascii?Q?Uc4HleI/vG0IE267bOQr8Fw9jZEnJnyobdzLGmspM28fCu8ILEo33kP3S+el?=
 =?us-ascii?Q?/cEaETpEyK0eNV/cGK17Imu9NMibsjqFcH6/BamEXQ+Z3kr/XSznj4adKGxU?=
 =?us-ascii?Q?V/7P4hyIT2OFc1lecDuw8lZMSw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BWbf6P1OOHMqzyI2ibxVaKGT/o55bthjHoLql1Rk9r9wevod+lKOTGlDeRKD?=
 =?us-ascii?Q?aCQ+Po+zmMQBaA5CP4/24uovEj8JhhOrJ043dNEuESIpGfKsdtlYDGsjPkW/?=
 =?us-ascii?Q?p0unugFgVJDvJOpZCKC22hssXTjQB3uCYBoCOcQZ6y+Fm1wpb3M2UYzqdG7S?=
 =?us-ascii?Q?LExgJ6+DkvJ4MhznysAaroo3Mh2R2QOzfmTo2NqaErpRE8KGkG/KUKPUAdip?=
 =?us-ascii?Q?V78yjyaZbh56IszytlDx+4uYMKiwI3D+ZaCoUVHUOlyFAEyLSMZydIx2iWmk?=
 =?us-ascii?Q?Mdq0MUFru+JRQGdAmlM+EOP8vQ7tWmVhurPpRrNS54RYUnijt+BqsEi9o91J?=
 =?us-ascii?Q?DmMlXeNDDiLoYXk8Zqt9SfiBa2sl4rG4GOVqnqUFnZEoVUuvbjFqa5XS0fif?=
 =?us-ascii?Q?df8AHJanuIVlng0cycL2k3COVnXyFOh6qBrDQsl3M6kOmTKzHRIaKyuWPCjf?=
 =?us-ascii?Q?Rb/i0KDF0yQap6rTwKSCrDE/RIjQQ7Y+9vUwTbsTtXhdJZM/4ToPR+zisIsL?=
 =?us-ascii?Q?Rd1SMxhkToOJ7DK5omtkkgRaFqdDgI5DJI1+Krpcn04ArroAaDbjIJLEOcM8?=
 =?us-ascii?Q?/7Qq/fgjFATsL10XELJlKqEl9ytOD6Wd6Sqw8C4VRgycQi+CYz9DI3pBKDHh?=
 =?us-ascii?Q?1jWEJZb6aN6CCjdhFQinQludWEqokxAD5yeko2dy45ySRX6jRUVaUKGToJaS?=
 =?us-ascii?Q?2a5YOHRI3kzWq50nExP+0bLT4ypHij8nW23FGkOeo8v1zDi4ObiPGjeC8GRL?=
 =?us-ascii?Q?4j6CDgG+5u82TLAHf20uYQLLkVQPd7s3LpPN1b0t7SONfcnDI8jkmDxhzBLw?=
 =?us-ascii?Q?BVJ0DavIZ0A04npPIvYnJoxAetRM9/luKLP30NNyTXeKF8+6L/S3R27AgOXL?=
 =?us-ascii?Q?ZsaipJuyLPrEDx8u4MAnuI8xGczcof/AAZHqWiC71DY8UY50/ZqCyz6ysNF+?=
 =?us-ascii?Q?FcOmlKRBAZQp1eV0NNymJQw/Y2/SYbSi0nNVpCOUn3c47Y82c3Oxy9zsKIXj?=
 =?us-ascii?Q?O4knK+mx49Mjrh8H+3RhsZdJi1vjZIzy1Xfux1+UHGjH3+X3sDpULhI/cwBF?=
 =?us-ascii?Q?dDv/e/DfsQBjqvTo2EJS9+IJCnQBUR4jDXY6a2ijrI6qQeKOWlc/0SHqsApO?=
 =?us-ascii?Q?ZMw0cwlaYC4jMSnx1H1iCJXtIgtZnKA/AJVgKKmBwfE0VXOioD5BW+3daynW?=
 =?us-ascii?Q?JJiuA+3E8HmmRQ2ODNrmpP4LuiiJyNLlD0n6qv0GtvGvFsad2ZdlqylfaU8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9215af-d044-467c-a93b-08dd0de11fda
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 06:11:10.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8447

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, November 25, 2024 2:25 PM
>=20
> On Fri, Nov 22, 2024 at 06:33:12PM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tu=
esday,
> November 19, 2024 4:51 PM
> > >
> > > On Tue, Nov 12, 2024 at 07:48:06PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Tuesday,
> > > November 12, 2024 10:18 AM
> > > > >
> > > > > Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_REL=
IABLE
> is
> > > > > independent from invariant TSC and should have never been gated b=
y the
> > > > > HV_ACCESS_TSC_INVARIANT privilege.
> > > >
> > > > I think originally X86_FEATURE_TSC_RELIABLE was gated by the Hyper-=
V
> > > > TSC Invariant feature because otherwise VM live migration may cause
> > > > the TSC value reported by the RDTSC/RDTSCP instruction in the guest
> > > > to abruptly change frequency and value. In such cases, the TSC isn'=
t
> > > > useable by the kernel or user space.
> > > >
> > > > Enabling the Hyper-V TSC Invariant feature fixes that by using the
> > > > hardware scaling available in more recent processors to automatical=
ly
> > > > fixup the TSC value returned by RDTSC/RDTSCP in the guest.
> > > >
> > > > Is there a practical problem that is fixed by always enabling
> > > > X86_FEATURE_TSC_RELIABLE?
> > > >
> > >
> > > The particular problem is that HV_ACCESS_TSC_INVARIANT is not set for=
 the
> > > nested root, which in turn leads to keeping tsc clocksource watchdog
> > > thread and TSC sycn check timer around.
> >
> > I have trouble keeping all the different TSC "features" conceptually
> > separate. :-( The TSC frequency not changing (and the value not
> > abruptly jumping?) should already be represented by
> > X86_FEATURE_TSC_CONSTANT.  In the kernel, X86_FEATURE_TSC_RELIABLE
> > effectively only controls whether the TSC clocksource watchdog is
> > enabled, and in spite of the live migration foibles, I don't see a need
> > for that watchdog in a Hyper-V VM. So maybe it's OK to always set
> > X86_FEATURE_TSC_RELIABLE in a Hyper-V VM, as you have
> > proposed.
> >
> > The "tsc_reliable" flag is also exposed to user space as part of the
> > /proc/cpuinfo "flags" output, so theoretically some user space
> > program could change behavior based on that flag. But that seems
> > a bit far-fetched. I know there are user space programs that check
> > the CPUID INVARIANT_TSC flag to know whether they can use
> > the raw RDTSC instruction output to do start/stop timing. The
> > Hyper-V TSC Invariant feature makes that work correctly, even
> > across live migrations.
> >
>=20
> It sounds to me that if X86_FEATURE_TSC_CONSTANT is available
> on Hyper-V, then we can set X86_FEATURE_TSC_RELIABLE.
> Is it what you are saying?
>=20

No. Sorry I wasn't clear. X86_FEATURE_TSC_CONSTANT will
be set only when the Hyper-V TSC Invariant feature is enabled, so
tying X86_FEATURE_TSC_RELIABLE to that is what happens now.

What I'm suggesting is to take your patch "as is". In other words,
always enable X86_FEATURE_TSC_RELIABLE. From what I can tell,
TSC_RELIABLE is only used to disable the TSC watchdog. Since I
can't see a use for the TSC watchdog in a VM, always setting
TSC_RELIABLE probably makes sense. TSC_RELIABLE doesn't
say anything about whether the TSC frequency might change, such
as across a VM live migration. TSC_CONSTANT is what tells you that
the frequency won't change.

My caveat is that I don't know the history of TSC_RELIABLE. I
don't see any documentation on the details of what it is supposed
to convey, especially in a VM. Maybe someone on the "To:" list
who knows for sure can confirm what I'm thinking.

Michael





