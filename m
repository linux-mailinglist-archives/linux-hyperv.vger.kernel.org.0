Return-Path: <linux-hyperv+bounces-3689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E570A12D1A
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 22:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AE6165337
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jan 2025 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879C1D619E;
	Wed, 15 Jan 2025 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L7DM0umc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010019.outbound.protection.outlook.com [52.103.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDC1547C5;
	Wed, 15 Jan 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974955; cv=fail; b=StJJAOlXjwOEoVnVNcmG/Prps8Cc3IHRxnqjBF+9fcQi9Uq57bO1k7wKT5jvuiOphP+3cuURXxyXsoN9HNFXxmyF7m99Kgi+pAiiGTF+qKX0oj76G3Gl2SKqLvEXpKHJmkGDF44wZknIpyi9ySsh89gjocyOv0Tu18HJO9sMFPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974955; c=relaxed/simple;
	bh=yxd0PfgFDt7NEXD+IL+LsO5tA9/tSy5kaIJuqrTLZDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqwfJuZQ0R51zIti2IuXsKu+cKxwgdSjgw6U9rNtN4E6LCIYeNLpbsl5Vsj3YwaiuVDFI4HJ/BtQBCfzBokUjR+rnrlqDHoIEqNj4IapimFDVdavuQ9X4vmMsqQVRdjhH+pT3plJlbpxbD1gZj1opqe9suivVWzEsecaJPxYVsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L7DM0umc; arc=fail smtp.client-ip=52.103.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJA0gorPaQkx9ucbkJOmm72ZdqHKsLvivcmIb53y/YWH/9odMhlO0r14nX2B6cHeNRPS7ubXHSLzfVDw7veBfo400ZA5joD67EgTVuFLmbKauV2+G9Cw60K0ZYv+Cp+tlcjK1BC6i/soQ5ZGR8g2pM1imS3nD1K9XsWvKZ/mI4HbV+cJ5M6XcDwxTi1Oq1JMyFzj6NAvMhCE772kgR0uFUFIQaa7B+IV3f5vj9jmjH3LF9T91m6n6Wq2AMHvavY7LkcgxbW9uMqmwTl269HCRri2EN2vjTFSStl+KYcEooYIdo6g9ssFeFfQ8LaH6P01LzDGxphXjdyCDqC6ns0ymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlgIYStoMnX7DBa+Y9QQeYjVABK3LWd0EA6u0ogeM/Y=;
 b=xKd0LKvKRNgTTk/yiWfbS8j5oNiYe8u2FugUBR+88y/ZOfwoODv/vr2s68O7UyhZlSz/ia41aLXtNOMW+x8rBoRJu8gIqwtHkijClciewn+Yc/JUOX9zGRQ+GZegPdu78Q1OdbXHY4L180FjZgqkgkYSNJiY4G+1qwt3ftcJyNCp+OdbmIfyC8TNJYmvogacUlfxj3wlphXx1iMX0agGc529h7tdviZYcmJY7MMh39nZ/66WQgRAWDzTT7z4Dwy50SqbReHduI9ri4ymcsgrSRNT+fnGJYaOHuCVEbYRYyiraPMCb40zbBBVz5F1sKJF6tW0R3hhq3yb5mFFRweR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlgIYStoMnX7DBa+Y9QQeYjVABK3LWd0EA6u0ogeM/Y=;
 b=L7DM0umcoEDmUvmea3OsGP3eqsfeLrpdj7ZSjn3Dox9d/W4Co5MwiZQCSie5CjP6lMSZmnAgW3FFXiyr76+nqBnNRcdj4LXnyfhczmjWgY5iSFfiMQgLm0p/QuABPycF2X4rIWvU0KcmNODAKm2oY/+2EvNwXI0yxJm9gBG9RybAg/txg5yaLFiK8RDqTNGYkv6k1Ld+mqzzZKsh0p+j3G6i7y+tLckeZ/tX/8UsO7BTUJ13sDAeSMyJ9rLtq/njWsl0qpw2R00iI86Xl37nks9WPczfTefyx0bx9RB37InVcu8ZNt3wWruW7HtIG1Qnejt3NWw6baw9aGnWbIM3lA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8377.namprd02.prod.outlook.com (2603:10b6:303:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 21:02:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 21:02:29 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
	<decui@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Thread-Topic: [PATCH v2 2/2] drivers/hv: add CPU offlining support
Thread-Index: AQHbY6sXkGWI1+MW60mlhk/nGWrisLMVSbiggALTIQCAADQ4AA==
Date: Wed, 15 Jan 2025 21:02:28 +0000
Message-ID:
 <SN6PR02MB4157AA9933FC62ECBF98F247D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250110215951.175514-1-hamzamahfooz@linux.microsoft.com>
 <20250110215951.175514-2-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157906A4E40E416D61AFEEBD4182@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4fu5p70KggmQstL@hm-sls2>
In-Reply-To: <Z4fu5p70KggmQstL@hm-sls2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8377:EE_
x-ms-office365-filtering-correlation-id: 5b243817-794f-4a05-e51b-08dd35a7ebe6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|461199028|19110799003|8060799006|1602099012|102099032|10035399004|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UolLW2nWUdCbW3yu3LUfw6Tha01+yTjagWU6UwI1iCqlKOuo1lkRmvWEVQQf?=
 =?us-ascii?Q?nAEKyqlFTGi5YobI4lwAfXGJLvBoi0ZUIsKDpkLqv9zXpPjX0fC3p+cH6O4C?=
 =?us-ascii?Q?7S6OfyZ8inD4zJ2+L7eiUWn2FEdqn1jNnYoXhFKLlIElqc3spJx+f+QSwmj9?=
 =?us-ascii?Q?wEEB53p7J9xyAwftnoo1NMnUdwl9f0APff95dNyqGq/ZyrCTiPYO73cWNsWR?=
 =?us-ascii?Q?Pu3N9qhgncF7GM9b5mGoAqP9K44rWwqBCAWSK+XJrQRcm6RHjlhBuL6cbDtL?=
 =?us-ascii?Q?cVUK37GFQk6eyn0g0oeP7k3aSwKtKCONiF4Ox7hNGpRK4Oka8pTw3aG5xmt4?=
 =?us-ascii?Q?1muS2tPV/7+G+Mw+w7vLY9zBDWkf+B/4LN4RHWl3xo92ka4mPW5ds1VK26HB?=
 =?us-ascii?Q?62AHaWo/Sz9D9tmRsrlHID6aZSJXLY9tsYjbGJpXDmSC3G2pOyhnrpFB5Vvw?=
 =?us-ascii?Q?maC1IdqoN+A9MPbEJwUK4AtGdcGJsE18n5Ppf51B9kUovfcHRcUhDjzM1CYR?=
 =?us-ascii?Q?nyMaa9R+ESBDpTJ+ilm1kV89CYlEaXrZnywv0Mied8I7ulD1WluXaQbzd9WL?=
 =?us-ascii?Q?jonHFnLMtkkBwj5/rN1k9QP2xJgHzaSjWHx3VXNGXLdALOzvUsyH2U8X12p6?=
 =?us-ascii?Q?jFcDBITzlms9Sqq4ytVQYbQsZX+b4Gno+HSzphD8xkVFYCu4u4+apmwqsdly?=
 =?us-ascii?Q?dO8iaKu8lw1Dbz4ueEb8WId79usfp3u6yD13qLo3T1KcoGtonHh2BHIl4ZXR?=
 =?us-ascii?Q?O//2xmi2CZAjSGruuADygCo3Wz/VJG39f33y+2GYy5e8NFv29WoiQZVkVO06?=
 =?us-ascii?Q?Z6l2JqZBYkVRpVmiYLdFMgae0i1H8OeAsc7deEbQ0N7PgCOBlBmYdMvv8r75?=
 =?us-ascii?Q?EU/s31gE/lvMD3pPQeGcNlJrIWaP//JWP3PL4IkdMNgeia8UxFrVVWHIkAEA?=
 =?us-ascii?Q?eBpW+cMRHw2NrqzUkA+qJPa7ztCYg3PjXiuvu75Dhp3v61rt5RRbmhpdVpKy?=
 =?us-ascii?Q?mX28cPAnqHyNTssoi+qRiLt4nQHhUPe4jvyP1jvUjNYBTvHrvB1w+BGfp7t7?=
 =?us-ascii?Q?/rOfEo3vhBJTzlYVBgofoY4FcI3HjEECpxPszq2bEBcVSIc0fub50aAgjuYD?=
 =?us-ascii?Q?hjXKxloa2LxvvJPX3q1GkmaM/AzPxAe1DJ0PrzQl2pFW2k7b12B8le8M4Js1?=
 =?us-ascii?Q?xpjKEmrmiMrJ3RMuI/SUgpaLzbekHvnM/X/Vv2US5kn873NGdmEiVeOUrMQ?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8DCK95zqZnehc7uVGE7oUTgzUtkzwNB6vDGBhPGegDh16fB12/a+3ONaDKWM?=
 =?us-ascii?Q?8OwXOSlS0fYv2WKE/eTQMBAcWyaKNvWrmzXbBLPMjNI0YvR7Y7O5N+ox6AXR?=
 =?us-ascii?Q?kxIMuLeLIEhYeAXV4DVPus//RF6zot+3bGboVJn5eQVN5/7LpIUTLwx2kZvE?=
 =?us-ascii?Q?0Zwl52w5wQBSu+ggSHbOKLD+g6RTbeT/alKwJMJwSsh5pMsLl0BBJCjtXmxO?=
 =?us-ascii?Q?rf9tgXM36Va/0vetZuMIFkklGedP/FqLuYJGl9dvmNmG2zAqp2E2wDxuO54m?=
 =?us-ascii?Q?QBqvA7u9j57vYgbu7rgghmqLsuoQ1pTYSrXki7ew7B59S/Uc+kkFQhDEXhJG?=
 =?us-ascii?Q?S4lk56maAslKHwHpUgFxwQWWSYZs75hyrl49Gp3HcWLMMZxjG7/Z9GO4wZYh?=
 =?us-ascii?Q?/zKXFt1yE77eJD4Kft933p6S4lE7+rXcDhHcEGHsTEqHjC4W3z/8LL98pF0j?=
 =?us-ascii?Q?1KG31pub8djTOP+JZjldqnPswJlwxnCx0CTKXvbSnusKYt3ISxBm2FvjIqjQ?=
 =?us-ascii?Q?q3pGK0Kfo+PsWq3svPzWS9+2C5XEEX9njM7i+9K328U7AYAhRtB3MzU4LIfQ?=
 =?us-ascii?Q?qZ+yQXG5y+JtOwz57e344twtus4oZtYQmU/hCgvZZB3S6XKb4C7fH3NSCRuR?=
 =?us-ascii?Q?LS1A6AVjb7xEPWvXnFhuy/yghcDjQMti952ZnkbbegCkwo6EDRoWIRJ1dPIO?=
 =?us-ascii?Q?HI4dAUc7PZVO8rCh0HW+GUEPFhbLGa2jWEEsLN/O2Y9JIwqRV6qfWSPumbCP?=
 =?us-ascii?Q?oEG5j/whDOu3RcDWcoK+OmLhqiGwYTb4+k5oH50qfqEsJ6iU+zgFqYvKhQvI?=
 =?us-ascii?Q?ZetHz94Ehzg1qa+FaMN8TQXpwl7PHEmw2/ysYwzNqLgy3SIg7MxASNlIu8Tg?=
 =?us-ascii?Q?chqvbCjJZJTLPsi+pO1Xgae1QIrak8msG0m7m8D6b3QgP5Kun/RqGG6tspUp?=
 =?us-ascii?Q?kUB8nTRL6kirpcRU/6KlaC4MoUKlp5RISTyTTeAdJZimPl6O1YuV8TxluZEo?=
 =?us-ascii?Q?BM23Y+TSGr86NP8aoyeNUiOLrzyLg9B9b4umpzPk3I3Cu74N8xO9e7jwFwqW?=
 =?us-ascii?Q?f4O1orD8i4bZ3mkzaG4jHy5KmCinnMK/WZfo9fNJjy9HdH6rYeqIABsJ6Jes?=
 =?us-ascii?Q?09eHIWrH4yJP+PtXbm6G1LEkg7rP3FZpOQc60XRqUwp2we+P+GWTmO+gGn1S?=
 =?us-ascii?Q?JdSlVXsiaFGIDGQw1Hadd1FetyZeqOwZLGULZ4lV/9RqS88zVn3I3pwDLps?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b243817-794f-4a05-e51b-08dd35a7ebe6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 21:02:28.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8377

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Wednesday, Jan=
uary 15, 2025 9:23 AM
>=20
> On Tue, Jan 14, 2025 at 02:43:33AM +0000, Michael Kelley wrote:
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Ja=
nuary
> 10, 2025 2:00 PM
> > >
> > > Currently, it is effectively impossible to offline CPUs. Since, most
> > > CPUs will have vmbus channels attached to them. So, as made mention o=
f
> > > in commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize
> > > init_vp_index() vs. CPU hotplug"), rebind channels associated with CP=
Us
> > > that a user is trying to offline to a new "randomly" selected CPU.
> >
> > Let me provide some additional context and thoughts about the new
> > functionality proposed in this patch set.
> >
> > 1. I would somewhat challenge the commit message statement that
> > "it is effectively impossible to offline CPUs". VMBus device interrupts
> > can be assigned to a different CPU via a /sys interface and the code
> > in target_cpu_store().  So a CPU *can* be taken offline by first reassi=
gning
> > any VMBus device interrupts, and then the offlining operation will succ=
eed.
> > That reassigning requires manual sysadmin actions or some scripting,
> > which isn't super easy or automatic, but it's not "effectively impossib=
le".
>=20
> Fair enough.
>=20
> >
> > 2. As background, when a CPU goes offline, the Linux kernel already has
> > functionality to reassign unmanaged IRQs that are assigned to the CPU
> > going offline.  (Managed IRQs are just shut down.)  See fixup_irqs().
> > Unfortunately, VMBus device interrupts are not modelled as Linux IRQs,
> > so the existing mechanism is not applied to VMBus devices.
> >
> > 3. In light of #2 and for other reasons, I submitted a patch set in Jun=
e 2024
> > that models VMBus device interrupts as Linux IRQs. See [1]. This patch =
set
> > got feedback from Thomas Gleixner about how to demultiplex the IRQs, bu=
t
> > no one from Microsoft gave feedback on the overall idea. I think it wou=
ld
> > be worthwhile to pursue these patches, but I would like to get some
> > macro-level thoughts from the Microsoft folks. There are implications f=
or
> > things such as irqbalance.
> >
> > 4. As the cover letter in my patch set notes, there's still a problem w=
ith
> > the automatic Linux IRQ reassignment mechanism for the new VMBus IRQs.
> > The cover letter doesn't give full details, but the problem is ultimate=
ly due
> > to needing to get an ack from Hyper-V that the change in VMBus device
> > interrupt assignment has been completed. I have investigated alternativ=
es
> > for making it work, but they are all somewhat convoluted. Nevertheless,
> > if we want to move forward with the patch set, further work on these
> > alternatives would be warranted.
> >
> > 5. In May 2020, Andrea Parri worked on a patch set that does what this
> > patch set does -- automatically reassign VMBus device interrupts when
> > a CPU tries to go offline. That patch set took a broader focus on makin=
g a
> > smart decision about the CPU to which to assign the interrupt in severa=
l
> > different circumstances, one of which was offlining a CPU. It was
> > somewhat complex and posted as an RFC [2]. I think Andrea ended up
> > having to work on some other things, and the patch set was not pursued
> > after the initial posting. It might be worthwhile to review it for comp=
arison
> > purposes, or maybe it's worth reviving.
> >
> > All of that is to say that I think there are two paths forward:
> >
> > A. The quicker fix is to take the approach of this patch set and contin=
ue
> > handling VMBus device interrupts outside of the Linux IRQ mechanism.
> > Do the automatic reassignment when taking a CPU offline, as coded
> > in this patch. Andrea Parri's old patch set might have something to add
> > to this approach, if just for comparison purposes.
> >
> > B. Take a broader look at the problem by going back to my patch set
> > that models VMBus device interrupts as Linux IRQs. Work to get
> > the existing Linux IRQ reassignment mechanism to work for the new
> > VMBus IRQs. This approach will probably take longer than (A).
> >
> > I lean toward (B) because it converges with standard Linux IRQs, but I
> > don't know what's driving doing (A). If there's need to do (A) sooner,
> > see my comments in the code below. I'm less inclined to add the
> > complexity of Andrea Parri's old patch set because I think it takes
> > us even further down the path of doing custom VMBus-related
> > work when we would do better to converge toward existing Linux
> > IRQ mechanisms.
>=20
> I would prefer (B) as well, though as you said it will take longer.
> So, I think my series is a reasonable stopgap until we get there.

Yes, and I don't fundamentally object to your series on that basis.
Somewhat separately, I'd still like to see if there is consensus to converg=
e
on Linux IRQs as a longer-term change that's worth the trouble.

I was reviewing my notes from 6 months ago on making the existing
fixup_irqs() mechanism work for the putative VMBus device IRQs, and
it will be challenging because of needing to get an ack from Hyper-V.
There's still a possibility that it just won't work in any reasonable way,
in which case your patch set is all we'll have. But I'll remain optimistic
and think that there's a way. :-)

> >
> > [1] https://lore.kernel.org/linux-hyperv/20240604050940.859909-1-mhklin=
ux@outlook.com/
> > [2] https://lore.kernel.org/linux-hyperv/20200526223218.184057-1-parri.=
andrea@gmail.com/
> >
> > >
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Wei Liu <wei.liu@kernel.org>
> > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > ---
> > > v2: remove cpus_read_{un,}lock() from hv_pick_new_cpu() and add
> > >     lockdep_assert_cpus_held().
> > > ---
> > >  drivers/hv/hv.c | 56 ++++++++++++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 41 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > > index 36d9ba097ff5..9fef71403c86 100644
> > > --- a/drivers/hv/hv.c
> > > +++ b/drivers/hv/hv.c
> > > @@ -433,13 +433,39 @@ static bool hv_synic_event_pending(void)
> > >  	return pending;
> > >  }
> > >
> > > +static int hv_pick_new_cpu(struct vmbus_channel *channel,
> > > +			   unsigned int current_cpu)
> > > +{
> > > +	int ret =3D 0;
> > > +	int cpu;
> > > +
> > > +	lockdep_assert_cpus_held();
> > > +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> > > +
> > > +	/*
> > > +	 * We can't assume that the relevant interrupts will be sent before
> > > +	 * the cpu is offlined on older versions of hyperv.
> > > +	 */
> > > +	if (vmbus_proto_version < VERSION_WIN10_V5_3)
> > > +		return -EBUSY;
> >
> > I'm not sure why this test is here.  The function vmbus_set_channel_cpu=
()
> > tests the vmbus_proto_version against V4_1 and returns an appropriate
> > error. Do we *need* to filter against V5_3 instead of V4_1?
>=20
> Yes, please see: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/tree/drivers/hv/vmbus_drv.c#n1685

I knew about that distinction between v4.1+ vs. v5.3+. I was
thinking that explicitly changing the assigned CPU via /sys and
target_cpu_store() should not be any different from changing the
assigned CPU implicitly by taking a CPU offline. But upon further
reflection, that thinking is flawed. Changing the assigned CPU
implicitly by taking a CPU offline is by definition immediately
going to fall into the problem documented in the comment,
whereas changing it explicitly via /sys will not. At least in the
latter case, taking the CPU offline is a separate operation.

But the distinction does produce a functional incongruence.
If running with VMBus version between 4.1 and 5.2 inclusive,
you can change the assigned CPU explicitly via /sys, but not
implicitly by just taking the CPU offline, which is a little weird.
But perhaps that incongruence isn't worth worrying about.
Most users will be on newer versions of Hyper-V and running
with VMBus 5.3 or later.

>=20
> >
> > > +
> > > +	cpu =3D cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_m=
ask);
> > > +
> > > +	if (cpu >=3D nr_cpu_ids || cpu =3D=3D current_cpu)
> > > +		cpu =3D VMBUS_CONNECT_CPU;
> >
> > Picking a random CPU like this seems to have some problems:
> >
> > 1. The selected CPU might be an isolated CPU, in which case the
> > call to vmbus_channel_set_cpu() will return an error, and the
> > attempt to take the CPU offline will eventually fail. But if you try
> > again to take the CPU offline, a different random CPU may be
> > chosen that isn't an isolated CPU, and taking the CPU offline
> > will succeed. Such inconsistent behavior should be avoided.
> >
> > 2. I wonder if we should try to choose a CPU in the same NUMA node
> > as "current_cpu".  The Linux IRQ mechanism has the concept of CPU
> > affinity for an IRQ, which can express the NUMA affinity. The normal
> > Linux reassignment mechanism obeys the IRQ's affinity if possible,
> > and so would do the right thing for NUMA. So we need to consider
> > whether to do that here as well.
>=20
> That sounds good to me.
>=20
> >
> > 3. The handling of the current_cpu feels a bit hacky. There's
> > also no wrap-around in the mask search. Together, I think that
> > creates a small bias toward choosing the VMBUS_CONNECT_CPU,
> > which is arguably already somewhat overloaded because all the
> > low-speed devices use it. I haven't tried to look for alternative
> > approaches to suggest.
>=20
> Ya, I noticed that as well but I didn't want to overcomplicate the
> selection heuristic. Though I guess having it wrap-around isn't too
> involved.

This is the "trap" of having a separate mechanism for VMBus
device interrupts. The complexity can grow in order to handle
isolated CPUs, NUMA topologies, etc. But at least at the
moment that complexity isn't too bad and can be handled.

Michael

>=20
> Hamza
>=20
> >
> > Michael
> >
> > > +
> > > +	ret =3D vmbus_channel_set_cpu(channel, cpu);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /*
> > >   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> > >   */
> > >  int hv_synic_cleanup(unsigned int cpu)
> > >  {
> > >  	struct vmbus_channel *channel, *sc;
> > > -	bool channel_found =3D false;
> > > +	int ret =3D 0;
> > >
> > >  	if (vmbus_connection.conn_state !=3D CONNECTED)
> > >  		goto always_cleanup;
> > > @@ -456,31 +482,31 @@ int hv_synic_cleanup(unsigned int cpu)
> > >
> > >  	/*
> > >  	 * Search for channels which are bound to the CPU we're about to
> > > -	 * cleanup.  In case we find one and vmbus is still connected, we
> > > -	 * fail; this will effectively prevent CPU offlining.
> > > -	 *
> > > -	 * TODO: Re-bind the channels to different CPUs.
> > > +	 * cleanup.
> > >  	 */
> > >  	mutex_lock(&vmbus_connection.channel_mutex);
> > >  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry)=
 {
> > >  		if (channel->target_cpu =3D=3D cpu) {
> > > -			channel_found =3D true;
> > > -			break;
> > > +			ret =3D hv_pick_new_cpu(channel, cpu);
> > > +
> > > +			if (ret) {
> > > +				mutex_unlock(&vmbus_connection.channel_mutex);
> > > +				return ret;
> > > +			}
> > >  		}
> > >  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
> > >  			if (sc->target_cpu =3D=3D cpu) {
> > > -				channel_found =3D true;
> > > -				break;
> > > +				ret =3D hv_pick_new_cpu(channel, cpu);
> > > +
> > > +				if (ret) {
> > > +
> 	mutex_unlock(&vmbus_connection.channel_mutex);
> > > +					return ret;
> > > +				}
> > >  			}
> > >  		}
> > > -		if (channel_found)
> > > -			break;
> > >  	}
> > >  	mutex_unlock(&vmbus_connection.channel_mutex);
> > >
> > > -	if (channel_found)
> > > -		return -EBUSY;
> > > -
> > >  	/*
> > >  	 * channel_found =3D=3D false means that any channels that were pre=
viously
> > >  	 * assigned to the CPU have been reassigned elsewhere with a call o=
f
> > > @@ -497,5 +523,5 @@ int hv_synic_cleanup(unsigned int cpu)
> > >
> > >  	hv_synic_disable_regs(cpu);
> > >
> > > -	return 0;
> > > +	return ret;
> > >  }
> > > --
> > > 2.47.1
> > >

