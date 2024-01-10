Return-Path: <linux-hyperv+bounces-1402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD482915C
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 01:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7F7288CD6
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A2A392;
	Wed, 10 Jan 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FfU+YEzL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2097.outbound.protection.outlook.com [40.92.18.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9431362;
	Wed, 10 Jan 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAReZOSp4WKrTDXPytXco/HgNuq1ZnPYfaDwmADtKHuohl7KIhOwf6VRe48s/sOj4Idr9ZoawhsfdIEFCEsZqtYI/ZmycgNuylTgPt1h5+HRHTQ5AH0q07X4iE+MUwaDztFSfDMtS8799PKrGjDDpt/N+w9faFJbEJZVxHpyInlDA5MropN/45wORcDzeR1nrdbhgqw+ifBC75UZwAvHWcSMxKoMOOXMbquxDwiKU/L5LQf3jepl4Oi0jAvQiq4Cz/tJONmY+luDr0R/x85EePo5EUDuF6LrLyYk3w5/OC1AYnxaRVBwy0v9WkIA4AXxz9HhOYd5lSJv3AudtpDC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA0+M8w4tOqwhum5aXQMMLl5zuzmw00OsEzd61e3Q80=;
 b=ErHnkYuMtMtiFPf4xJs763IyNPfkP2Vj4FdIkzfyojKJv8n7Fstz+1sswMfpb6ajpWZlhCaFe0CQiiAiCo5TB+ykXRWBS0b3FdvAA4vF8MPXEnt5IUkPdSTpI0DwQPzge6dne1XY43u8K0Z72egMnCzE8c+fuoETNSvyOWNR8Xc5P3FEMhtK3p/vrBtp+uq99xsRb6ABmZQRL5aw6q9/8JXTrSrELGvWi4IGplJ1QVQp6lkS1/hXbNOhDG8irB6kgCotw5+yRHZ45+GNI3kVpMyyrxkajvZXbiTqitFqXYp6QtGr4nikocEEtDPJ1aMusZuyyxWpTa720WoOX7VH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA0+M8w4tOqwhum5aXQMMLl5zuzmw00OsEzd61e3Q80=;
 b=FfU+YEzLhAXVLO+Z9euzyH5k1ecy/hMs7Vggr+lmaG8R+gAQgHsBMAGrLZL/uPmzRZ1IQI0ro7+MZCqiVg9pPnr7EiRFSqgaV13owMH0QDU1PdHNSjeNVRmbe1E9IXIUJuUHSed6EwNFspxhmCk4tCgXYsK+qimmyhKqRq+q0RP5aLx1Asi6UTaXWyF7wNVWlUu0ezr4/bWo22zRGMA2H+coilGVbz4nEw0VNQnPBZsQigRrL2vn5MdjGtYdM8enz5ybfxoj0/1jNuaOMYpfADWckRcfzVtxpwCUa86SuWoWBEKNhZ1pQZmDXNXdDjc7wk6q4A29K4F26py9lr+89g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8260.namprd02.prod.outlook.com (2603:10b6:610:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 00:27:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 00:27:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yury Norov <yury.norov@gmail.com>
CC: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "leon@kernel.org"
	<leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "schakrabarti@microsoft.com"
	<schakrabarti@microsoft.com>, "paulros@microsoft.com" <paulros@microsoft.com>
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaQuoWNi7Bv1N390Ch4p7DlTYrcLDR1sMggABKpoCAAAdtgA==
Date: Wed, 10 Jan 2024 00:27:54 +0000
Message-ID:
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
In-Reply-To: <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [sMyKuHekd5BcrLdrZhEIJg+lFLZ/TRU0]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8260:EE_
x-ms-office365-filtering-correlation-id: 50469f9e-41c2-4879-1adb-08dc1172fcb8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V8kl7IQn6GZLj2BhI6K8xZgRrvvQU7sfAVelueZ6UUncLo+DMlSqyUcQMxsw1F2n7+7zKTy+leGoy3aLzVjz8ZC2z2kRupdxM0xLD6Kdru51mwhduTSGK5C939uMRRr111179EAo1YLAgEcOd36wYhwx1CanKeI3RqTIql0oTBjRfpD6sQzC4EpaMKsV7OiN1Qjk95D9ULTHMIjnohHtnrsdBhYxjStFgX/noQR/AEAukmDIaaSibF3e/zEoSq41sHiH+F+7Gr8HCJDY+l+7ArXbi5Vrk/Yz0YjOU5NNGe+2Tu47JQ6NVFSsgE/J/ZZ3PhF9F23mNKRXnacKUAaNBuNj7e524EYILV7wdNiaPf5nbzae0k2Rmnp7u0on+CNTHMS0gq/7+EatPyKdDgcQXrYM5YQIbaVqn3AJHmbalykKP9INyymxzsP8EopqBmMib2he3WA2FROGxgenLfO1CU6J7VzCqZxGl9Oet+HxeVKEv8DyJEwlJoGJFNvElFo28ppYQ4R70e0KgTzbfddpOkkQKB8C+zi6Tq7O2pARWGxJldxjkM02mkVn+Lxjlhtf
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NiH/SaoMCTBAEsMnuyFoK9UVXP6ro6xtkdgWWchnpyPCzkmpEJ4NHOaiTI5S?=
 =?us-ascii?Q?9qw942BQ7K5rzXLp3W8PIO5iEfIOx3uFxQQJN7VmyL8Qq5p4fs1j1gN0gMtU?=
 =?us-ascii?Q?4LexbaTYe4MKLNnMdjsGqqJSld+xrLmeAtyTcWFzoAt40qOBNXQ3HECNHRYD?=
 =?us-ascii?Q?4JzP85NuxLFj7lQ/iKJxE5WMZ7zK5JbZeddNRxjxCjlUHrUs5I2r4k4vnCvL?=
 =?us-ascii?Q?5jnBdg6iC2mKbZJhRAp/Om2idnkhh59fAuWSlhAwF5ql6EVh88bv0fB9y3l1?=
 =?us-ascii?Q?mbe1s41lyrdIj0MtXeixLLzTTYAVuaXVDs3YqEZnAIx1UjxScrMVY3QCBjri?=
 =?us-ascii?Q?5YazoNd4hVbCqNzW5/uN2PlOl1kPxGB7CIhA0Cf5Wvzf2B/Fj3t8iLsmcBzy?=
 =?us-ascii?Q?L1WhI7iD8e+84PqPmLI0iT9zakuP+DLU+qCDAEQq3IcZriOqGsM4V+/poGML?=
 =?us-ascii?Q?c8qy59ATaqsk6eXplj18ArxF61A3y5N2VrCaa4jAGEUoM+oKKO9ikybFnCZC?=
 =?us-ascii?Q?iJC6HiJr2iKDedy9qyRJ0k57ovW5JyZPWqIPqhTzCTwEdvaSmK9uN1RyCFjg?=
 =?us-ascii?Q?iXr8Q/JFQkRECuROMgKGzX3puXaMhwdTk7FU6aAXSXAeUseVo0IwrMqmovgU?=
 =?us-ascii?Q?GY55SV1O+mlY02BenVhYQyCELAZJZTf/V8htwaq6xXdKeuNIoHCZY94BP5T/?=
 =?us-ascii?Q?A/U3jtSOCi8t8aL3H6MNPv+lmfnhAUWmgVtg4LRtHMP7kDSg0UwzBrNbdhDV?=
 =?us-ascii?Q?m+apBsKZ+Wp+1jgjrq12SGkqMiuFi2qipzxsVRXah78IYP/1BarrgoM+Eltf?=
 =?us-ascii?Q?1jhrJIpCgPYaRospEfYevOZ4X7K876zD0/3UTWO/O51xk5qJupcXQsVyoZDS?=
 =?us-ascii?Q?dvOiT6Ls3V72IDykGy1/MRAwNzDQ60ON7ikzd8YI34K5lDVmnKjOVN52eYkX?=
 =?us-ascii?Q?JPK3WW41oBDZGDVLc7rfFWGWYn/RjU7zgVkEJxBW9I4rlY2yiEGNDMUQpqrH?=
 =?us-ascii?Q?PTQCYDdYXl/azi0d/RXZVdIP7HE3rl1NGQKPQGjSewwHz87uUp6a3dm8fHd9?=
 =?us-ascii?Q?3xIkJc2Pj1T2DHgx9QAvUbsJ5ioIXobG0//nAnqN9drDUj2tANnftplWff6W?=
 =?us-ascii?Q?0OSPR86dUfhRNLeawvrKuuHyOwOtCZ/0KiSVwxZ6oOwUPAWlxNw9VvZ9/HL7?=
 =?us-ascii?Q?Ht9cEIXaMQN267mIAO5OAgLI0h5tRtxFKkF4ZQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50469f9e-41c2-4879-1adb-08dc1172fcb8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 00:27:54.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8260

From: Yury Norov <yury.norov@gmail.com> Sent: Tuesday, January 9, 2024 3:29=
 PM
>=20
> Hi Michael,
>=20
> So, I'm just a guy who helped to formulate the heuristics in an
> itemized form, and implement them using the existing kernel API.
> I have no access to MANA machines and I ran no performance tests
> myself.

Agreed. :-)   Given the heritage of the patch, I should have clarified
that my question was directed to Souradeep.  Regardless, your work
on the cpumask manipulation made everything better and clearer.

>=20
> On Tue, Jan 09, 2024 at 07:22:38PM +0000, Michael Kelley wrote:
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> Tuesday, January 9, 2024 2:51 AM
> > >
> > > From: Yury Norov <yury.norov@gmail.com>
> > >
> > > Souradeep investigated that the driver performs faster if IRQs are
> > > spread on CPUs with the following heuristics:
> > >
> > > 1. No more than one IRQ per CPU, if possible;
> > > 2. NUMA locality is the second priority;
> > > 3. Sibling dislocality is the last priority.
> > >
> > > Let's consider this topology:
> > >
> > > Node            0               1
> > > Core        0       1       2       3
> > > CPU       0   1   2   3   4   5   6   7
> > >
> > > The most performant IRQ distribution based on the above topology
> > > and heuristics may look like this:
> > >
> > > IRQ     Nodes   Cores   CPUs
> > > 0       1       0       0-1
> > > 1       1       1       2-3
> > > 2       1       0       0-1
> > > 3       1       1       2-3
> > > 4       2       2       4-5
> > > 5       2       3       6-7
> > > 6       2       2       4-5
> > > 7       2       3       6-7
> >
> > I didn't pay attention to the detailed discussion of this issue
> > over the past 2 to 3 weeks during the holidays in the U.S., but
> > the above doesn't align with the original problem as I understood
> > it.  I thought the original problem was to avoid putting IRQs on
> > both hyper-threads in the same core, and that the perf
> > improvements are based on that configuration.  At least that's
> > what the commit message for Patch 4/4 in this series says.
>=20
> Yes, and the original distribution suggested by Souradeep looks very
> similar:
>=20
>   IRQ     Nodes   Cores   CPUs
>   0       1       0       0
>   1       1       1       2
>   2       1       0       1
>   3       1       1       3
>   4       2       2       4
>   5       2       3       6
>   6       2       2       5
>   7       2       3       7
>=20
> I just added a bit more flexibility, so that kernel may pick any
> sibling for the IRQ. As I understand, both approaches have similar
> performance. Probably my fine-tune added another half-percent...
>=20
> Souradeep, can you please share the exact numbers on this?
>=20
> > The above chart results in 8 IRQs being assigned to the 8 CPUs,
> > probably with 1 IRQ per CPU.   At least on x86, if the affinity
> > mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
> > should balance the IRQ assignments between the CPUs in the mask.
> > So the original problem is still present because both hyper-threads
> > in a core are likely to have an IRQ assigned.
>=20
> That's what I think, if the topology makes us to put IRQs in the
> same sibling group, the best thing we can to is to rely on existing
> balancing mechanisms in a hope that they will do their job well.
>=20
> > Of course, this example has 8 IRQs and 8 CPUs, so assigning an
> > IRQ to every hyper-thread may be the only choice.  If that's the
> > case, maybe this just isn't a good example to illustrate the
> > original problem and solution.
>=20
> Yeah... This example illustrates the order of IRQ distribution.
> I really doubt that if we distribute IRQs like in the above example,
> there would be any difference in performance. But I think it's quite
> a good illustration. I could write the title for the table like this:
>=20
>         The order of IRQ distribution for the best performance
>         based on [...] may look like this.
>=20
> > But even with a better example
> > where the # of IRQs is <=3D half the # of CPUs in a NUMA node,
> > I don't think the code below accomplishes the original intent.
> >
> > Maybe I've missed something along the way in getting to this
> > version of the patch.  Please feel free to set me straight. :-)
>=20
> Hmm. So if the number of IRQs is the half # of CPUs in the nodes,
> which is 2 in the example above, the distribution will look like
> this:
>=20
>   IRQ     Nodes   Cores   CPUs
>   0       1       0       0-1
>   1       1       1       2-3
>=20
> And each IRQ belongs to a different sibling group. This follows
> the rules above.
>=20
> I think of it like we assign an IRQ to a group of 2 CPUs, so from
> the heuristic #1 perspective, each CPU is assigned with 1/2 of the
> IRQ.
>=20
> If I add one more IRQ, then according to the heuristics, NUMA locality
> trumps sibling dislocality, so we'd assign IRO to the same node on any
> core. My algorithm assigns it to the core #0:
>=20
>   2       1       0       0-1
>=20
> This doubles # of IRQs for the CPUs 0 and 1: from 1/2 to 1.
>=20
> The next IRQ should be assigned to the same node again, and we've got
> the only choice:
>=20
>=20
>   3       1       1       2-3
>=20
> Starting from IRQ #5, the node #1 is full - each CPU is assigned with
> exactly one IRQ, and the heuristic #1 makes us to switch to the other
> node; and then do the same thing:
>=20
>   4       2       2       4-5
>   5       2       3       6-7
>   6       2       2       4-5
>   7       2       3       6-7
>=20
> So I think the algorithm is correct... Really hope the above makes
> sense. :) If so, I can add it to the commit message for patch #3.

Thinking about it further, I agree with you.  If we want NUMA
locality to trump avoiding hyper-threads in the same core, then
I'm good with the algorithm.   If I think of the "weight" variable
in your function as the "number of IRQs to assign to CPUs in
this NUMA hop", then it makes sense to decrement it by 1
each time irq_set_affinity_and_hint() is called.  I was confused
by likely removing multiple cpus from the "cpus" cpumask
juxtaposed with decrementing "weight" by only 1, and by my
preconception that to get the perf benefit we wanted to avoid
hyper-threads in the same core.

>=20
> Nevertheless... Souradeep, in addition to the performance numbers, can
> you share your topology and actual IRQ distribution that gains 15%? I
> think it should be added to the patch #4 commit message.

Yes -- this is the key thing for me.  What is the configuration that
shows the 15% performance gain?  Patch 3/4 and Patch 4/4 in the
series need to be consistent in describing when there's a performance
benefit and when there's no significant difference.   In Patch 4/4,
the mana driver creates IRQs equal to the # of CPUs, up to
MANA_MAX_NUM_QUEUES, which is 64.  So the new algorithm
still assigns IRQs to both hyper-threads in cores in the local NUMA
node (unless the node is bigger than 64 CPUs, which I don't think
happens in Azure today).  For the first hop from the local NUMA
node, IRQs might get assigned to only one hyper-thread in a core
if the total CPU count in the VM is more than 64.

Michael

