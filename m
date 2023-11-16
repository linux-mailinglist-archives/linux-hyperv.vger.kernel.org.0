Return-Path: <linux-hyperv+bounces-972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F477EDB78
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 07:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57591F22786
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BB1870;
	Thu, 16 Nov 2023 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I+2KiN6I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2031.outbound.protection.outlook.com [40.92.22.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F0E127;
	Wed, 15 Nov 2023 22:17:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPsyG7wp/iL6Vonbsh39MOZJFRSVt1oI7AvaeHBjPC3of3wRCy6Xry65MpEMc3+sdQVm0ZzAB6OEndMTIlXAsy5/8aASgTuJcqtRje22ImNJs1nXz8M6Q+CWG7UxU8PPG3X5j/cX8gEnOtgU9L8mjK8uCfbu2q42WV471qUnukVTsVKeR2Hdf4SzBjuinrYpIeRCLdyUg2vCH9NYISmDirULQGO6nT+wAonicSiVI0WrINC6Q0ePAkp0vlnLfEtH62aOp9ZdCj99ZyUbjHvLWPEzT/900AiMbHe2SugvL6TVYZI6HEkC1MSWH4CmMk2hzbxODwPPlvh7+se+wh5Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tONxgB5RY8Os7BAnI2cUOVSAr2dxcfIJPjNK+gfxHPg=;
 b=STMU69rfaN7cEtvnKwXpYykAahxkXvrow0TZQlT6M6uNQCOPq0FBBF4NSlxNDs/F//iVeG8A8mRgG/KXSXwTRfg+O+gyksQ9mZiUsA3n5JywopOmqsafVOAmdrC5qAo//SW0wQNxnt6mzTvUaQsDPhvxLo5btlsqVb7irmnil/kPl3wlv44IoXp8Rs9ehDmm2WtE+dlr8DSCdLS0xbDIRXqahVy65sEPRSWTpjzQRm8QOwdDM2agLVV3ZZgL9LD/pehlvUamSvo0Q/KmgElJsHKgTnBELu9tYJmztqBaKk/bVwHUU2Rj3WtFLQMl8uHPcBUYZf+mugkowRYFqm5xLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tONxgB5RY8Os7BAnI2cUOVSAr2dxcfIJPjNK+gfxHPg=;
 b=I+2KiN6IMdaLd0qJk7w7tMhmiaVLIn9mnFSMUE34msj1a+JWlkAKEquFSaemAgMFyY3ixeM9sx8RkxQjRqY5hRug1XqgDwfKHj3G8M0zVNUvqd7DCLj+4KxjttmHDuylwB1stD7OmtvmMbH8UD+ELBJ2AqgC69ejNsxNxnLaxDmEHmQDiTnMlaorZInbo7fUkx7xzrhwDVlvKfmo1U+L+dJP8VzfjjaBjTFp6kZ4KH2rvbAIrakiuwi7luzVhG9awBo+hA2AtSFvUyVIKax+MT9wrnFtotiQ/IOnNuPioLbSN4C2Po87uut7mqDrCpTSxjbngKwTCrYqlzxFtXKWvw==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by IA0PR02MB9439.namprd02.prod.outlook.com (2603:10b6:208:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 06:17:28 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::3c13:971c:32ba:9d09]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::3c13:971c:32ba:9d09%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 06:17:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "schakrabarti@microsoft.com" <schakrabarti@microsoft.com>,
	"paulros@microsoft.com" <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Index: AQHaF8qFIut0V3aUl0iWHXi4P2psf7B8VglwgAAbgdA=
Date: Thu, 16 Nov 2023 06:17:27 +0000
Message-ID:
 <BN7PR02MB4148581D5DCF51BE46CC1B12D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
 <BN7PR02MB41487FDBD42B364683A5ACA6D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41487FDBD42B364683A5ACA6D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [V7I+hZW95NqVUaPDinLQdUVybpbd1yKi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|IA0PR02MB9439:EE_
x-ms-office365-filtering-correlation-id: 07d9325e-6c88-4721-b1d7-08dbe66bb510
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jqipgI5KBjESiutbutlwX/hkBzPGi6pSIzXQUvoqRrKTfa91HNmMrMr4RQD0kIAA6mqUDLa4eesWdr1dn7BzApN+XXs6z+vn76GKUBoXhtq8CBpQmW5nKMo1qbIu0WCD6V1G5+RymmwiEQMTulFuqoWPy7/pRDWRTtsT5Ns58asd7E86/aLr6Bo7PSKd5aRMeUNbo0TSjzvRCKlOzhHW+h5PJdW/QCVwnwbxkNke2kMU9mdWg/WnZceHqCx3joqCI1JdaZ2EDQ/f4MnEIzG+QehoL20hvJ7jTZLkB4UGG+WMEpx797soiQvuJToZiNGu18wJnUzk4R4heftQ5Y8bbH8eNaBWDuJBSjvNtUsFA2YtHot4VIBDbaHlMg8lvA0Ve71cktLclAlP2qlM9jS/Tv0U8QiXSIOjtSqafX1HIuqA5kfjOJi515anc5cHA2Tn8U5HC5Fj8hOO0X4zoG1/xyRjvHwlcDHBcp1vnTc+QM/gyuzR63cKt0MJRkRh2OclQ9khMWvVrBmdN3ezpiW3/Z789g82LUSe2EqRpkrIfB/Q3XsUfiUIYmPUvC475V7H6f3d0RSOwUXmEqEaNcAkBUWKiIf37UCAK9B/y8BxIAVQwnJ/B6+i0IdpY2coosHW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D33zLV5F+Bm/elx0TXYHH3dhRiQvzA31RoMK0cqWqhjHHkERy9rkjyDvPTdp?=
 =?us-ascii?Q?Y6zPjgVhQT5mVykQS2T/oIw1ZIVpqT+gef1dPX/onXb7hwzwlMPTC/cpNRxo?=
 =?us-ascii?Q?SwO7CJdzHBiaLDhLk/gFraY4akZ/CepVm/KeZ+mMIofCpH2y+o1LDhiV4L7E?=
 =?us-ascii?Q?TsKAaau3PzNhQkbAeqwHo4aM9VEQOdnnLc6nSAccWcvcMRabmnfv3ZSpiF64?=
 =?us-ascii?Q?TPq27Q/tUeM+aAPHn50iwQTQHDKaRsDGjjNyYIJ8LaZN1d+xGpD3C7WBhH6/?=
 =?us-ascii?Q?LSTAZWPlvfzuMxaI+i3zEbnn3nOcLdD29hvUG5QDBgCM/rXS1AkNb/lRnjhN?=
 =?us-ascii?Q?6LxNwR2ScAs1nK5/VsQQA0cbtQ3jJbV16qpmo6IJ7vfQPfZOb6dn16yB7MkU?=
 =?us-ascii?Q?PUhKmSUbNSpXhwDtLW9G7yCWaOwAKtb0t/2lLTF2VC8wg1DrkdTiV/q3VE9e?=
 =?us-ascii?Q?EajU2zcKVFnTtQmsId9FxQkGd5uYir512ZMRE2yRa4uwuHdXks2eidb7HJ/2?=
 =?us-ascii?Q?JD2ej5IcKinBn/9K+RM3SkVZkxyBzeij1e7kkVUc6j+McTkZVHvpsIUlBXHN?=
 =?us-ascii?Q?soWx4Im2CFt6Qrffm4y2CczuSrgb5+Dg12i6SKvnMNXkISgJpfDyxEFSltMU?=
 =?us-ascii?Q?nDI0eSCpkSP4qNXw4y67f4ksiJXqPMmdMhG3GLVhkWtlx+9I1srMtBt0rZYQ?=
 =?us-ascii?Q?fiIgxSscz4J+xfOa+xbD+JJiytxsBZip/nEGqusmlWd+pILfTdMAitKDd13A?=
 =?us-ascii?Q?T2R4avSbrTCC5RWExss6Al3FMvv+z2nMXR0yyiS+lAp7KwGiC1KzHZKlczay?=
 =?us-ascii?Q?hqVwds3dJLmjm/4+gtdfOBVn2risdHjXUvv81UNSBL3rJXc7qhzDDRsgd8/P?=
 =?us-ascii?Q?BWYhLSBLbLd4P1sFY4klx7UhA16IzpCQwvd7MazcUi7van0nxdw7WW1o5Xve?=
 =?us-ascii?Q?ksJHGmlOI3TZHfhgeEfBCQzUhz/3SizCV83RQALhxnEFxRwg9OdkbHIvT+U1?=
 =?us-ascii?Q?KzCU1isRt/nJ9CaHHoHTqVyFKbfdUN9kINuWZE5OceTnvFOwT24XxOjI8MXD?=
 =?us-ascii?Q?ZOoyuZajlpYBU8kcEERsfZxTZkYYPXOeJgmBSjYHrFwtqmpIZ4MDQcpoIiFD?=
 =?us-ascii?Q?ZADEplGrLRR6F+op29JKRLioNn56yrMeBqXQ8NXb+1X1QGUEFYIrh5QFcIPb?=
 =?us-ascii?Q?W3qqYWmYFZAEdXWCZWJ/e2JktepcC7VBnjsddw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d9325e-6c88-4721-b1d7-08dbe66bb510
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 06:17:27.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9439

From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, November 15, 2=
023 9:26 PM
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 6367de0c2c2e..839be819d46e 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct
> > gdma_resource *r)
> >  	r->size =3D 0;
> >  }
> >
> > +static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t
> > **filter_mask_list)
> > +{
> > +	unsigned int core_count =3D 0, cpu;
> > +	cpumask_var_t *filter_mask_list_tmp;
> > +
> > +	BUG_ON(!filter_mask || !filter_mask_list);
>=20
> This check seems superfluous. The function is invoked from only
> one call site in the code below, and that site call site can easily
> ensure that it doesn't pass a NULL value for either parameter.
>=20
> > +	filter_mask_list_tmp =3D *filter_mask_list;
> > +	cpumask_copy(*filter_mask, cpu_online_mask);
> > +	/* for each core create a cpumask lookup table,
> > +	 * which stores all the corresponding siblings
> > +	 */
> > +	for_each_cpu(cpu, *filter_mask) {
> > +
> 	BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count], GFP_KERNEL)=
);
>=20
> Don't panic if a memory allocation fails.  Must back out, clean up,
> and return an error.
>=20
> > +		cpumask_or(filter_mask_list_tmp[core_count], filter_mask_list_tmp[co=
re_count],
> > +			   topology_sibling_cpumask(cpu));
>=20
> alloc_cpumask_var() does not zero out the returned cpumask.  So the
> cpumask_or() is operating on uninitialized garbage.  Use
> zalloc_cpumask_var() to get a cpumask initialized to zero.
>=20
> But why is the cpumask_or() being done at all?  Couldn't this
> just be a cpumask_copy()?  In that case, alloc_cpumask_var() is OK.
>=20
> > +		cpumask_andnot(*filter_mask, *filter_mask, topology_sibling_cpumask(=
cpu));
> > +		core_count++;
> > +	}
> > +}
> > +
> > +static int irq_setup(int *irqs, int nvec)
> > +{
> > +	cpumask_var_t filter_mask;
> > +	cpumask_var_t *filter_mask_list;
> > +	unsigned int cpu_first, cpu, irq_start, cores =3D 0;
> > +	int i, core_count =3D 0, numa_node, cpu_count =3D 0, err =3D 0;
> > +
> > +	BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));
>=20
> Again, don't panic if a memory allocation fails.  Must back out and
> return an error.
>=20
> > +	cpus_read_lock();
> > +	cpumask_copy(filter_mask, cpu_online_mask);
>=20
> For readability, I'd suggest adding a blank line before any
> of the multi-line comments below.
>=20
> > +	/* count the number of cores
> > +	 */
> > +	for_each_cpu(cpu, filter_mask) {
> > +		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cp=
u));
> > +		cores++;
> > +	}
> > +	filter_mask_list =3D kcalloc(cores, sizeof(cpumask_var_t), GFP_KERNEL=
);
> > +	if (!filter_mask_list) {
> > +		err =3D -ENOMEM;
> > +		goto free_irq;

One additional macro-level comment.  Creating and freeing the
filter_mask_list is a real pain.  But it is needed to identify which
CPUs in a core are available to have an IRQ assigned to them.  So
let me suggest a modified approach to meeting that need.

1) Count the number of cores just as before.

2) Then instead of allocating filter_mask_list, allocate an array
of integers, with one array entry per core.  Call the array core_id_list.
Somewhat like the code in cpu_mask_set(), populate the array with
the CPU number of the first CPU in each core.  The populating
only needs to be done once, so the code can be inline in irq_setup().
It doesn't need to be in a helper function like cpu_mask_set().

3) Allocate a single cpumask_var_t local variable that is initialized to
a copy of cpu_online_mask.  Call it avail_cpus.  This local variable
indicates which CPUs (across all cores) are available to have an
IRQ assigned.

4) At the beginning of the "for" loop over nvec, current code has:

	cpu_first =3D cpumask_first(filter_mask_list[core_count]);

Instead, do:

	cpu_first =3D cpumask_first_and(&avail_cpus,
			topology_sibling_cpumask(core_id_list[core_count]));

The above code effectively creates on-the-fly the cpumask
previously stored in filter_mask_list, and finds the first CPU
as before.

5) When a CPU is assigned an IRQ, clear that CPU in avail_cpus,
not in the filter_mask_list entry.

6) When the NUMA node wraps around and current code calls
cpu_mask_set(), instead reinitialize avail_cpus to cpu_online_mask
like in my #3 above.

In summary, with this approach filter_mask_list isn't needed
at all.  The messiness of allocating and freeing an array of cpumask's
goes away.  I haven't coded it, but I think the result will be
simpler and less error prone.

Michael

> > +	}
> > +	/* if number of cpus are equal to max_queues per port, then
> > +	 * one extra interrupt for the hardware channel communication.
> > +	 */
>=20
> Note that higher level code may set nvec based on the # of
> online CPUs, but until the cpus_read_lock is held, the # of online
> CPUs can change. So nvec might have been determined when the
> # of CPUs was 8, but 2 CPUs could go offline before the cpus_read_lock
> is obtained.  So nvec could be bigger than just 1 more than
> num_online_cpus().  I'm not sure how to handle the check below to
> special case the hardware communication channel.  But realize
> that the main "for" loop below could end up assigning multiple
> IRQs to the same CPU if nvec > num_online_cpus().
>=20
> > +	if (nvec - 1 =3D=3D num_online_cpus()) {
> > +		irq_start =3D 1;
> > +		cpu_first =3D cpumask_first(cpu_online_mask);
> > +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
> > +	} else {
> > +		irq_start =3D 0;
> > +	}
> > +	/* reset the core_count and num_node to 0.
> > +	 */
> > +	core_count =3D 0;
> > +	numa_node =3D 0;
> > +	cpu_mask_set(&filter_mask, &filter_mask_list);
>=20
> FWIW, passing filter_mask as the first argument above was
> confusing to me until I realized that the value of filter_mask
> doesn't matter -- it's just to use the memory allocated for
> filter_mask.  Maybe a comment would help.  And ditto for
> the invocation of cpu_mask_set() further down.
>=20
> > +	/* for each interrupt find the cpu of a particular
> > +	 * sibling set and if it belongs to the specific numa
> > +	 * then assign irq to it and clear the cpu bit from
> > +	 * the corresponding sibling list from filter_mask_list.
> > +	 * Increase the cpu_count for that node.
> > +	 * Once all cpus for a numa node is assigned, then
> > +	 * move to different numa node and continue the same.
> > +	 */
> > +	for (i =3D irq_start; i < nvec; ) {
> > +		cpu_first =3D cpumask_first(filter_mask_list[core_count]);
> > +		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=3D numa_nod=
e) {
>=20
> Note that it's possible to have a NUMA node with zero online CPUs.
> It could be a NUMA node that was originally a memory-only NUMA
> node and never had any CPUs, or the NUMA node could have had
> CPUs, but they were all later taken offline.  Such a NUMA node is
> still considered to be online because it has memory, but it has
> no online CPUs.
>=20
> If this code ever sets "numa_node" to such a NUMA node,
> the "for" loop will become an infinite loop because the "if"
> statement above will never find a CPU that is assigned to
> "numa_node".
>=20
> > +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
> > +			cpumask_clear_cpu(cpu_first, filter_mask_list[core_count]);
> > +			cpu_count =3D cpu_count + 1;
> > +			i =3D i + 1;
> > +			/* checking if all the cpus are used from the
> > +			 * particular node.
> > +			 */
> > +			if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
> > +				numa_node =3D numa_node + 1;
> > +				if (numa_node =3D=3D num_online_nodes()) {
> > +					cpu_mask_set(&filter_mask, &filter_mask_list);
>=20
> The second and subsequent calls to cpu_mask_set() will
> leak any memory previously allocated by alloc_cpumask_var()
> in cpu_mask_set().
>=20
> I agree with Haiyang's comment about starting with a NUMA
> node other than NUMA node zero.  But if you do so, note that
> testing for wrap-around at num_online_nodes() won't be
> equivalent to testing for getting back to the starting NUMA node.
> You really want to run cpu_mask_set() again only when you get
> back to the starting NUMA node.
>=20
> > +					numa_node =3D 0;
> > +				}
> > +				cpu_count =3D 0;
> > +				core_count =3D 0;
> > +				continue;
> > +			}
> > +		}
> > +		if ((core_count + 1) % cores =3D=3D 0)
> > +			core_count =3D 0;
> > +		else
> > +			core_count++;
>=20
> The if/else could be more compactly written as:
>=20
> 		if (++core_count =3D=3D cores)
> 			core_count =3D 0;
>=20
> > +	}
> > +free_irq:
> > +	cpus_read_unlock();
> > +	if (filter_mask)
>=20
> This check for non-NULL filter_mask is incorrect and might
> not even compile if CONFIG_CPUMASK_OFFSTACK=3Dn.  For testing
> purposes, you should make sure to build and run with each
> option:  with CONFIG_CPUMASK_OFFSTACK=3Dy and
> also CONFIG_CPUMASK_OFFSTACK=3Dn.
>=20
> It's safe to just call free_cpumask_var() without the check.
>=20
> > +		free_cpumask_var(filter_mask);
> > +	if (filter_mask_list) {
> > +		for (core_count =3D 0; core_count < cores; core_count++)
> > +			free_cpumask_var(filter_mask_list[core_count]);
> > +		kfree(filter_mask_list);
> > +	}
> > +	return err;
> > +}

