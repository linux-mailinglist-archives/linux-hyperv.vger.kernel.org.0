Return-Path: <linux-hyperv+bounces-3466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85E9ED98B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 23:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9D164BA7
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2024 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FC1F03E4;
	Wed, 11 Dec 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FqQsA0wk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013077.outbound.protection.outlook.com [52.103.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE951EC4CD;
	Wed, 11 Dec 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955757; cv=fail; b=ku5rzkij7XxZXQ5KP5WXcAVPlN57Fih+IpsHxd/5UPaF4/USaX5+eTRgPgaBDw6IYoiryzSxQ3/kwcwtWCC+OOGI1BlX5DeW9xBKBsOzP12K0uUszkpez/3wDItIhT8+CsrBI01MgsvTqdTdKIJ9ceuNO2SuF45+/lHjyvti+gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955757; c=relaxed/simple;
	bh=wzOYwJnVIoIfsICxToeSB8e0JCq9U3ksrfjqELfxAeM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIpwOMacBv/EXsP6jMRsfzV7+UHNuC6E6O92lRkrVnz0NnvK1q7nCQGkEPbfX/QqiI0CULfPMI32s9U2U+8MBuaUNcPTMm0IQFY3CV7fJzK1G5r9hpGWcSshJc6QoTgZYKtL43iEc3KfYFXmIWoAiqNdqThqOt/1nd62ZPhAHPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FqQsA0wk; arc=fail smtp.client-ip=52.103.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNcuPey5UeEDzt1kWHEo96fnE2OHXWIYV5SqLcau6DwBQ6dgj3c8kT/Imz499D1PqR9fq/gU1jM7FyJ8Xx/e6lWgpMh8A63D208kw1wKGaFdNkF/9e4EPwdmR68rbf+qSo0uvghb8s4cziMuX75r4Zj+6VvoxxtlY9VC2WN8Zp68XdTI/7wc2TEsM32DHG8eLMaoP0EchcLjGu47CFM/Y9GioAzxf7VE3AriO105ppBVvhsdZCgBoquvQmQm+/2P589VWRRxmrxfQNFA6SEvxlZulmRwL3jOaL5YRtLMCGK4KC4/SkXl3jfSBFtY7mDJh1woaJgdQtwVXFRSUcVJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCmhvF80osUdkuXIV8+qeImtngwc1TQ7uFdKIRBCyh0=;
 b=J47TN2pfqgZECarzk9vv8os+ohaMIMnWxPzD8ruNgms8mCZxQVu6m/WQZoDuNVvVp/1pVHIzqxr4/MjIcjLwwSFFwn8tkx56ts0qa7an39RW+7MaPVFe6Jb/aX8c2xFuiB6dEoORFm8SbfP4VVEukMZ9+iBN6cxGG1n43aNXxtHhCoM3EdbHkhNjW1dv17mEgXMz+HRHbi2vCJcv6JTaAJ8IJ5GEISh6TwjDUz6Sn07kG+neaeRPOYmkMwP/QCY69CM8VdWEq8VlXD01g0GJb9J2Fgkj8OVwDe3g6r7FxlXHpGzs5XNDw5l6M6oCxs9jZrk6E82TZJsWTd6ITljxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCmhvF80osUdkuXIV8+qeImtngwc1TQ7uFdKIRBCyh0=;
 b=FqQsA0wkla+WgWLOqkFWyLejfOXek4p6mpIlQM7Bdc7HMfPd6YUrfNDl5KvbH/3ztGzE7i83b/sqMx1bjjvmpnreiO94mk79OySPEaFoNBwxWMfPUU0ACoKTQUNFF92qmOwzqGauDkBJRsvVKPT4pCMSr9qqqhh/jh6wkhQZWoxXulu4mdSJMzknwU4VXTWfdUjImw4qokt4R9O368maJxOriquPz6D9Eq2i2JnlUcrnwPci32+fcuF9/xOT9+dt/dWadUaTSowh8BfUWGa7crqQxb41wJIdAVSrHA1xfVvB8RzL3Ta5cJH/TYuiwSkDBui2E46V2NCwyJ+fmjly6A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9996.namprd02.prod.outlook.com (2603:10b6:806:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 22:22:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 22:22:31 +0000
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
Thread-Index:
 AQHbNS9UbXwh5KJBoU2oxHpKRgf4mrK0CjPAgAtX/gCABEfyYIAE/TWAgAB/NKCAGFw8gIAASGrw
Date: Wed, 11 Dec 2024 22:22:31 +0000
Message-ID:
 <SN6PR02MB4157923900BEB94E9A6A50D4D43E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB41575A98314B82C498A3D312D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241120005106.GA18115@skinsburskii.>
 <SN6PR02MB4157121B6CD9F5CAAFB39637D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241125222457.GA28630@skinsburskii.>
 <SN6PR02MB4157344DE32DF479543CC2CED42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241211180035.GA20385@skinsburskii.>
In-Reply-To: <20241211180035.GA20385@skinsburskii.>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9996:EE_
x-ms-office365-filtering-correlation-id: 4c0d73ab-880e-49ea-147c-08dd1a324ddd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|15080799006|8062599003|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4yzw3ecml2PsIBpIZolvkHGtB8vZuZzXuq8BmOEgFktNEGohb9C0VhhYwWl2?=
 =?us-ascii?Q?rZqOn7lhpIHTwBGtImtByODMHfhLBJZ+cmMvHG1tzlKHaCl0etvUEpve1dqE?=
 =?us-ascii?Q?vVO7E8Lp+UZXB+NXgvLxhPzH8IPf6kq2ZCaZ26BU8yVq6G1JkjgSzsh0buoZ?=
 =?us-ascii?Q?/TEj0ivxqlXwJQvsLNf5UJU0KyJGNrQDVBvDjkFUTLRQbXQvJtwvaj5F+jef?=
 =?us-ascii?Q?xL2JBmXb34yGbc1X6r/asiC+fTNDOh7VkdIalZL1X8ZItFdp0fPwEFilRBiL?=
 =?us-ascii?Q?Ru9QlT3rQzD4c1GrVa57mnOpvGtbrpB+Tb45KWqhx7kXLEPE9GqD9JbbLhtE?=
 =?us-ascii?Q?1pHLUQkzkG4wT65i/2sauvF5D6GqC4p9emePf5xOqW3UxWEag3xfjDbKu/J6?=
 =?us-ascii?Q?bkGkwQvYtlx/+jr7deOqycz074yACQEOL/yfMvQpNtMXWBVT6NxD8mZlDp4U?=
 =?us-ascii?Q?9/V0SWbeKbzaZZwLVHJJWWn3ukgFGi8U+GoRQZQ2Rk9kKJA1pwswwVGQehvV?=
 =?us-ascii?Q?ayoYRHOKg3n7AAWakO4IxGmgOpzZbZdG+zc121KMEM7WR6HcwVcJDil9gE9Q?=
 =?us-ascii?Q?qen6DHcJ6U2Y6wMIN66OT9knjElCXFVSwf7UH/7XsFdim9nNBsrT2q6g4LLw?=
 =?us-ascii?Q?51OP1JCSMRFkWEkVT9miYGC7Oqgd4z0ai/th9ziKx5y8tlbDxH6JSHRztk41?=
 =?us-ascii?Q?PyAARAyK0j8ZcFZSq+BDRNJlLRrCqLpIMc3hCBWsfXe+3iSJdsa6VT/Z4p7S?=
 =?us-ascii?Q?VAuJmfnlQd+s9UFKK+9cPU52ZsRq/hl+RG+v4t1/ya6TGRpYN/EuWvs/41oI?=
 =?us-ascii?Q?tnBDiTR09uRn5RIigDpQkbG1KhzGLsoOmSVQOcoEP0/bt/xLHoXqPK853xvd?=
 =?us-ascii?Q?Rx1fzND7SBI10bPlRURGLBx07Qe/W/QmMEQHOsOI77NszQ0ebcB45WggzWbK?=
 =?us-ascii?Q?ykOvKwu1MO8v3uJDFnBrcoiwUBPTVSilPwm6ttqYztJC3MvPi25vidv7lbbS?=
 =?us-ascii?Q?4D/QUbzdR5eB96w++VMoYTofTw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HR6/PymdvVRfKwdBv5g7/urb+CxNn4PyXWQASvtS2b+VnA0bedLCBlOacIgS?=
 =?us-ascii?Q?VfZZBEXW4QcAmop0Pj9/F9ZEyvJkoAL8IqWVumkkJPMYt7p7+D6TY6S1PP6E?=
 =?us-ascii?Q?5MgmqdSWuVLb+tiMQ9JYWmuC8IjvCYyQ2OYDhMwnuFEOh5mgqZOTVncVTRPX?=
 =?us-ascii?Q?+Re1HnOkuTXHMOJw2m1vlTWGn5pLqQdPKRu8lEn8u40uqaiYMhO2P6ABWLje?=
 =?us-ascii?Q?yeUO4smTVOLLzLGtBLxvj1fa2GsSewLCMNkPR0l65+voHUPoqIifrMzcT3T9?=
 =?us-ascii?Q?3KqsOjwgoBFrd8DHciEfc/g3X6f+Cs9zhI8dx3N2yqPtUwfd/vqORWIsw+oU?=
 =?us-ascii?Q?NYXH5TCw409//AZa3z6VBn72YMjoYOknB7mTvVbBDLT7hNOFVjIeWKMClCup?=
 =?us-ascii?Q?xvj0HxFGTSh6h0Oz6Q/vQJGI8uj7ZgIWNlfgK5MDiHbijBlx/dG4Tyy8Aeua?=
 =?us-ascii?Q?akeEJpQMayTzl8KNoN+0z1aclbQTvxFoohCk/9OtiWO7yLzo2s9+Gfvu/ZcL?=
 =?us-ascii?Q?GNfjpgynC6thgc5sRYP7noewkMS7xDXMW0nFpeqOo+jl9iM2vkdW+IlkOiyD?=
 =?us-ascii?Q?XFiqdVuF8dxqsL/D0POuav2PPW5nwzQb4xx2QJYL0ZsBXeXqZ0SR1Ew1EI9i?=
 =?us-ascii?Q?cpcIl1d5I/piYO/e7raGi3LXuxH5LiLdKDsVaWGWwrk9+i985ruWsd69ciPa?=
 =?us-ascii?Q?CE1DeW0URVOcyK7z6qMG1AwzcO8ww5Jro0wj2LtBfGRgK3gn/63nRyVGkyy7?=
 =?us-ascii?Q?A7VHa006q/3A+wyRGUFkdE5bsSoLEtaCZG1GvEe7L0ze00lGkPr51HL++7Xm?=
 =?us-ascii?Q?se/kmY9qK9yzhfwk6UkjoEjedPXRjKAl2fAKbHmflZD6vV6mEkP+tnfYGgLr?=
 =?us-ascii?Q?gMfzJgD5kaRFhkpIzZ27/+BFB+u3YXe522Ocvx/AnCadss41VAz5CDrgD/aK?=
 =?us-ascii?Q?zqOhaQvIhmciK1FgNAZu6BcFs/xz4x4+RwjfvRGkHKiWNItbgUdLkTm4IpVo?=
 =?us-ascii?Q?no/y1d9gxLkS2meHcHHdheUVyiU5QC1rkzGqIS9IGw1vxFNRm1PUb6H470pb?=
 =?us-ascii?Q?3Rz9toVpmJ8YFO3zOT7wCHq1I+Y31x15jVdSKPmsPqwlvrXpK/Do58gISHMQ?=
 =?us-ascii?Q?IHtNcGBo6skkmaHPVs0vGZB2O/deYKUmZGfIfgihN/vET4Zh4DONzIYyW9xB?=
 =?us-ascii?Q?6VW0QT3/kc5nprva2uLbAGmfFuxvzD2QPjrNRlOn4VARmwOUlFt2FOvhN3w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0d73ab-880e-49ea-147c-08dd1a324ddd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 22:22:31.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9996

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednes=
day, December 11, 2024 10:01 AM
>=20
> On Tue, Nov 26, 2024 at 06:11:10AM +0000, Michael Kelley wrote:
> > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Mo=
nday, November 25, 2024 2:25 PM
> > >
> > > On Fri, Nov 22, 2024 at 06:33:12PM +0000, Michael Kelley wrote:
> > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent=
: Tuesday, November 19, 2024 4:51 PM
> > > > >
> > > > > On Tue, Nov 12, 2024 at 07:48:06PM +0000, Michael Kelley wrote:
> > > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> =
Sent: Tuesday,
> > > > > November 12, 2024 10:18 AM
> > > > > > >
> > > > > > > Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC=
_RELIABLE is
> > > > > > > independent from invariant TSC and should have never been gat=
ed by the
> > > > > > > HV_ACCESS_TSC_INVARIANT privilege.
> > > > > >
> > > > > > I think originally X86_FEATURE_TSC_RELIABLE was gated by the Hy=
per-V
> > > > > > TSC Invariant feature because otherwise VM live migration may c=
ause
> > > > > > the TSC value reported by the RDTSC/RDTSCP instruction in the g=
uest
> > > > > > to abruptly change frequency and value. In such cases, the TSC =
isn't
> > > > > > useable by the kernel or user space.
> > > > > >
> > > > > > Enabling the Hyper-V TSC Invariant feature fixes that by using =
the
> > > > > > hardware scaling available in more recent processors to automat=
ically
> > > > > > fixup the TSC value returned by RDTSC/RDTSCP in the guest.
> > > > > >
> > > > > > Is there a practical problem that is fixed by always enabling
> > > > > > X86_FEATURE_TSC_RELIABLE?
> > > > > >
> > > > >
> > > > > The particular problem is that HV_ACCESS_TSC_INVARIANT is not set=
 for the
> > > > > nested root, which in turn leads to keeping tsc clocksource watch=
dog
> > > > > thread and TSC sycn check timer around.
> > > >
> > > > I have trouble keeping all the different TSC "features" conceptuall=
y
> > > > separate. :-( The TSC frequency not changing (and the value not
> > > > abruptly jumping?) should already be represented by
> > > > X86_FEATURE_TSC_CONSTANT.  In the kernel, X86_FEATURE_TSC_RELIABLE
> > > > effectively only controls whether the TSC clocksource watchdog is
> > > > enabled, and in spite of the live migration foibles, I don't see a =
need
> > > > for that watchdog in a Hyper-V VM. So maybe it's OK to always set
> > > > X86_FEATURE_TSC_RELIABLE in a Hyper-V VM, as you have
> > > > proposed.
> > > >
> > > > The "tsc_reliable" flag is also exposed to user space as part of th=
e
> > > > /proc/cpuinfo "flags" output, so theoretically some user space
> > > > program could change behavior based on that flag. But that seems
> > > > a bit far-fetched. I know there are user space programs that check
> > > > the CPUID INVARIANT_TSC flag to know whether they can use
> > > > the raw RDTSC instruction output to do start/stop timing. The
> > > > Hyper-V TSC Invariant feature makes that work correctly, even
> > > > across live migrations.
> > > >
> > >
> > > It sounds to me that if X86_FEATURE_TSC_CONSTANT is available
> > > on Hyper-V, then we can set X86_FEATURE_TSC_RELIABLE.
> > > Is it what you are saying?
> > >
> >
> > No. Sorry I wasn't clear. X86_FEATURE_TSC_CONSTANT will
> > be set only when the Hyper-V TSC Invariant feature is enabled, so
> > tying X86_FEATURE_TSC_RELIABLE to that is what happens now.
> >
> > What I'm suggesting is to take your patch "as is". In other words,
> > always enable X86_FEATURE_TSC_RELIABLE. From what I can tell,
> > TSC_RELIABLE is only used to disable the TSC watchdog. Since I
> > can't see a use for the TSC watchdog in a VM, always setting
> > TSC_RELIABLE probably makes sense. TSC_RELIABLE doesn't
> > say anything about whether the TSC frequency might change, such
> > as across a VM live migration. TSC_CONSTANT is what tells you that
> > the frequency won't change.
> >
> > My caveat is that I don't know the history of TSC_RELIABLE. I
> > don't see any documentation on the details of what it is supposed
> > to convey, especially in a VM. Maybe someone on the "To:" list
> > who knows for sure can confirm what I'm thinking.
> >
> > Michael
>=20
> We had a long ionternal discussion with hypervisor folks and it looks
> like we will propose a more robust solution to go forward.
> The hypervisor will provide an additional CPUID bit, which guarantees
> TSC reliability (including across live migration).

Interesting. Is there a text description of what this new CPUID
bit means? I would be curious, and in particular how it is
different from the various existing CPUID bits describing TSC
behavior.

Michael

