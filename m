Return-Path: <linux-hyperv+bounces-971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C019D7EDB2E
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 06:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37FB1C208CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 05:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B976DC8E4;
	Thu, 16 Nov 2023 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HjqwZXH0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E819D;
	Wed, 15 Nov 2023 21:25:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIb+YZND+s5d4y9o2xzUqSHcrew3W+7I4+XG36bb3yH/FiPnTaTmgfBvUyNMMsGdOexqR59M/cHISnubUjXQtmK/rrbg6BqEGYAA8TiAV1Qe0vS/ZkItYq6FvGPF7jKonJX8XKUuSQ6u6HY0EuWDfo5h5F0+FnFR+y07SPx1ijhNw2yyIns1fFeWAQUYJclm1J2KNbxFJaq2xHpKMzTKlTDreop65iQCI8u3G7/F5DYYRbLYWZz4PAqvMDY7lqRTQpHcZ+4hpELIJVBmmfYR9LRq4F08/pR8LCJOku49NZcPFrlI2JY0hy0JrS2U+erEpx24vv8mPeU7R4EkLkj37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U03RPhrkGWJgSs2a7u+3VQVDQjQXUtEfUFq5z3bFOOg=;
 b=Isw3LsR7+U3C2MdgxmZgQpoM6OCTHmfg/dweTi6awfEqkH4EJCtlF3tjhwTe+9FpRgMlCgfMQ6ot1bxmRwFVEostveKyb6TpN97voKX5J5c2y2Cl+CCLN8+Co95kEfeJaNJmgCGb/7xw/00UKe2Ur5LQm+kyU7ZBFz3oppOUCfqYh1oEEsmxBDlpgSvk6MBUUd8V0zreTYdyWW4YOT6ndVVITu4JJWxvjlnb5CkiHO+ZwOzTHMyjkt+cwwSrXDd/DnUSFPDYaJFel/Jm35FdlfJrk4fQOSPpBblSUleuFB/RsovZG3Ia3i1ImZx60kl3h5huNaiU6UwgrKxK1KovyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U03RPhrkGWJgSs2a7u+3VQVDQjQXUtEfUFq5z3bFOOg=;
 b=HjqwZXH08L82x2fq+XB+3Pyd1OH6Xw4OurI7VsxGi/v8kWXlGvVNOe5rdxDH22+48SDZ5kK8oZ6V2+Qbp1Wl4//NZUcrHbib2JbLS0yT6eeyK7at1sWyXXXYUe9Du502ai7JgyBoTH1yu2qC685RBjHO8hV5p8wW6+eeEm7dl8SL2NHdWfumQKWsPmP26daf+hVpfqJq6PKebqNyzbfAZgH9cMMewiNZ/3jzPaXRt/QTJw0MDWyWiIUkOzxFzlNTnHhkO+Gg6JnuqSxD3sJVUydXLLqM6+vjkdiOUn5lsxyBCOmUah2qL5uuhucDUuWhF41K+bFdhCqGymbnVedOrQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CO6PR02MB7618.namprd02.prod.outlook.com (2603:10b6:303:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 05:25:53 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::3c13:971c:32ba:9d09]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::3c13:971c:32ba:9d09%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 05:25:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
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
Thread-Index: AQHaF8qFIut0V3aUl0iWHXi4P2psf7B8Vglw
Date: Thu, 16 Nov 2023 05:25:50 +0000
Message-ID:
 <BN7PR02MB41487FDBD42B364683A5ACA6D4B0A@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [CdFifNEegMCowVX45CJnE7xfXdHUc/Lt]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CO6PR02MB7618:EE_
x-ms-office365-filtering-correlation-id: d4360577-c602-4af9-f83d-08dbe6647edc
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OSS7Oci0wcyDTMKcw1RuX7wrVM+CFImfku2p4/hqqWIVYlG2Pr5YKoDNcUFlfvbuCPtUz48jmGJE30np2rpYmgCf6cdliHdjFeOEZrCik+x0QB0xtUobmw+g1Bcocw9H7wy6lWLUIzusUXGajmsv3hGkJ38DwcGheCE0ZFc0MRbTAaCmQl44cD8nt0dVf0wxrWDyytpoZKh/Ix3xjYktvLitsQ3jHVSAApi5Yzzhq2NCYhKj0Tm5FsB8UZ+FkVVbRmvVRt3jY+XVEAKEK9e1vkCL3ZDYUx1dGA5jIpKRjRjL5IEIN3aD/Cznxi0jVctWL4Ynm8kHl/mp59R61sLPhCEjdiMLNwOnvwuVlqzMcZlttMKh/oPZp2nGDAOGd+7FOw2R4D5p0GIm2FqBkEJPFYz3eqG89TFazbmXLH4oj69XMChxlH/LU9SvKmo1bXLzzMhoaVpVGWbdYOGNWztSlHqeQfIvs/oIEVTublPUU2rwxUWDpi2Jqczt5V3k9aI0xTvQjeQa7oPtE+tIoGaXP3HQYL/5aXnkk95VsQOEi9pt12YscnTPN9Oz+Lop+cgd
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?08Oom/gbR8EzVzNLne79C+FQhElsHqyN5FpTj4BB8No3NN9IBvVKdBgJqFvA?=
 =?us-ascii?Q?Pn/jq/pRlRTmsv6JtNs3GdDuunAb7k5Nt8sXYjxjEY0+gc1cLFr28HO4Sr30?=
 =?us-ascii?Q?Iq8tW5ipuV+hMTqHAih3E9A1B5DYRgMwisLnVH0RamSorFHt+3g2d6tkj0EN?=
 =?us-ascii?Q?v0zPZDdYJMqX5ykyZxsvfmS2IYEhigO6fIunv/GZhczRwxzrePF8JRTB2h5l?=
 =?us-ascii?Q?bP4hXUG3ycR7Y29Ev+ef4a+9mwIGGb94frNkqluUJq2+f7M6NJklZLdvJTsv?=
 =?us-ascii?Q?R0GtpVJKBNTXJ8/6uSPn+zb4dvp/SeS+xlZ8q1y+HxI8EFpHwGUsZMjcjSiv?=
 =?us-ascii?Q?EWQi7fyOMykxeFAmDVekfiG9smlRxH+QNVltGIk0ZU06RWUyPdnfOYfb+dfr?=
 =?us-ascii?Q?KhXDx/+wutf484qU13Jk5IHkH+gzernF8Lrxk7kS/kfR8zEen+XYNMgbkmYA?=
 =?us-ascii?Q?L2YTY305ogCUaD8VCC6dtHZd60QC1BKIDV4gazvilzjgK4ALtKtHJT6XaQ4z?=
 =?us-ascii?Q?q0sm6U9k7eoKG/+MFZ1hiwLhjhG76SOd3HxfbccSdqapbuJxivHrRexGUGPW?=
 =?us-ascii?Q?c6GapV/bySC+0KZuiMWsv61yAjsU6Z8gsjDOdzGTlBpwpbP73EVBmlrDxYF2?=
 =?us-ascii?Q?0XEF+7kML2+Q/XsAGbS1cL3IJwwH8pstQOmLB56nxP+3fOk9ZWLNDhVcODak?=
 =?us-ascii?Q?IghUCjsq3P4c1mtbxvi3LKdAaqZ9ELCOGmU0sOl2ePzPcoiE+/y0eAsBmpkU?=
 =?us-ascii?Q?ibFBHXdHriUDbRGgpJRMh4nN8yIY5sEbGR4RQXgdU/QrpWC80cr/5rmHtur1?=
 =?us-ascii?Q?qlSUNzH4DI86kJh1+/vmdQA9oG4enE+nrvWWq2oRjhjT73uKPOV/5/A3rdoF?=
 =?us-ascii?Q?L5TmNhlJxYa5yuX5Kbx+HEXIuXC1a3Ho6/nqj//jX2b3+EorP4Q6pO1eA9UL?=
 =?us-ascii?Q?gQhhpD8JRrHheHckeSjZfS1+S8q3tIMfsXlcGRs9ys2OFKmN/WEuY6mmmgqW?=
 =?us-ascii?Q?6eqkAFMMObSWytjv2nKjULvTnj6I++uWygIOKyGze8pi8eecrVWX8ZJlCEIp?=
 =?us-ascii?Q?5oGXNAmzOvgzavPLp4UtaPrFiNW9Amzm6UFJv/B/5Ez+9xARNlu3e0Pd5k/U?=
 =?us-ascii?Q?IcyJ32rudI8UUXKsI93JiKGaTiLOVwoubD5BRFRSx6/rT2yreKG2pXlE3Nv0?=
 =?us-ascii?Q?Us8kzVpLh/qhYOG5QJyMA/GdDDd4zygK4HY66g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4360577-c602-4af9-f83d-08dbe6647edc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 05:25:50.2300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7618

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Wednes=
day, November 15, 2023 5:49 AM
>=20
> Existing MANA design assigns IRQ affinity to every sibling CPUs, which ca=
uses

Let's make this more specific by saying "...  assigns IRQs to every CPU,
Including sibling hyper-threads in a core, which causes ...."

> IRQ coalescing and may reduce the network performance with RSS.

What is "IRQ coalescing"?

>=20
> Improve the performance by adhering the configuration for RSS, which
> prioritise IRQ affinity on HT cores.

I don't understand this sentence.  What is "adhering the configuration
for RSS"?  And what does it mean to prioritise IRQ affinity on HT cores?
I think you mean to first assign IRQs to only one hyper-thread in a core,
and to use the additional hyper-threads in a core only when there are
more IRQs than cores.

>=20
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 126 ++++++++++++++++-
> -
>  1 file changed, 117 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 6367de0c2c2e..839be819d46e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct
> gdma_resource *r)
>  	r->size =3D 0;
>  }
>=20
> +static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t
> **filter_mask_list)
> +{
> +	unsigned int core_count =3D 0, cpu;
> +	cpumask_var_t *filter_mask_list_tmp;
> +
> +	BUG_ON(!filter_mask || !filter_mask_list);

This check seems superfluous. The function is invoked from only
one call site in the code below, and that site call site can easily
ensure that it doesn't pass a NULL value for either parameter.

> +	filter_mask_list_tmp =3D *filter_mask_list;
> +	cpumask_copy(*filter_mask, cpu_online_mask);
> +	/* for each core create a cpumask lookup table,
> +	 * which stores all the corresponding siblings
> +	 */
> +	for_each_cpu(cpu, *filter_mask) {
> +		BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count], GFP_KERNE=
L));

Don't panic if a memory allocation fails.  Must back out, clean up,
and return an error.

> +		cpumask_or(filter_mask_list_tmp[core_count], filter_mask_list_tmp[core=
_count],
> +			   topology_sibling_cpumask(cpu));

alloc_cpumask_var() does not zero out the returned cpumask.  So the
cpumask_or() is operating on uninitialized garbage.  Use
zalloc_cpumask_var() to get a cpumask initialized to zero.

But why is the cpumask_or() being done at all?  Couldn't this
just be a cpumask_copy()?  In that case, alloc_cpumask_var() is OK.

> +		cpumask_andnot(*filter_mask, *filter_mask, topology_sibling_cpumask(cp=
u));
> +		core_count++;
> +	}
> +}
> +
> +static int irq_setup(int *irqs, int nvec)
> +{
> +	cpumask_var_t filter_mask;
> +	cpumask_var_t *filter_mask_list;
> +	unsigned int cpu_first, cpu, irq_start, cores =3D 0;
> +	int i, core_count =3D 0, numa_node, cpu_count =3D 0, err =3D 0;
> +
> +	BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));

Again, don't panic if a memory allocation fails.  Must back out and
return an error.

> +	cpus_read_lock();
> +	cpumask_copy(filter_mask, cpu_online_mask);

For readability, I'd suggest adding a blank line before any
of the multi-line comments below.

> +	/* count the number of cores
> +	 */
> +	for_each_cpu(cpu, filter_mask) {
> +		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu)=
);
> +		cores++;
> +	}
> +	filter_mask_list =3D kcalloc(cores, sizeof(cpumask_var_t), GFP_KERNEL);
> +	if (!filter_mask_list) {
> +		err =3D -ENOMEM;
> +		goto free_irq;
> +	}
> +	/* if number of cpus are equal to max_queues per port, then
> +	 * one extra interrupt for the hardware channel communication.
> +	 */

Note that higher level code may set nvec based on the # of
online CPUs, but until the cpus_read_lock is held, the # of online
CPUs can change. So nvec might have been determined when the
# of CPUs was 8, but 2 CPUs could go offline before the cpus_read_lock
is obtained.  So nvec could be bigger than just 1 more than
num_online_cpus().  I'm not sure how to handle the check below to
special case the hardware communication channel.  But realize
that the main "for" loop below could end up assigning multiple
IRQs to the same CPU if nvec > num_online_cpus().

> +	if (nvec - 1 =3D=3D num_online_cpus()) {
> +		irq_start =3D 1;
> +		cpu_first =3D cpumask_first(cpu_online_mask);
> +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
> +	} else {
> +		irq_start =3D 0;
> +	}
> +	/* reset the core_count and num_node to 0.
> +	 */
> +	core_count =3D 0;
> +	numa_node =3D 0;
> +	cpu_mask_set(&filter_mask, &filter_mask_list);

FWIW, passing filter_mask as the first argument above was
confusing to me until I realized that the value of filter_mask
doesn't matter -- it's just to use the memory allocated for
filter_mask.  Maybe a comment would help.  And ditto for
the invocation of cpu_mask_set() further down.

> +	/* for each interrupt find the cpu of a particular
> +	 * sibling set and if it belongs to the specific numa
> +	 * then assign irq to it and clear the cpu bit from
> +	 * the corresponding sibling list from filter_mask_list.
> +	 * Increase the cpu_count for that node.
> +	 * Once all cpus for a numa node is assigned, then
> +	 * move to different numa node and continue the same.
> +	 */
> +	for (i =3D irq_start; i < nvec; ) {
> +		cpu_first =3D cpumask_first(filter_mask_list[core_count]);
> +		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=3D numa_node)=
 {

Note that it's possible to have a NUMA node with zero online CPUs.
It could be a NUMA node that was originally a memory-only NUMA
node and never had any CPUs, or the NUMA node could have had
CPUs, but they were all later taken offline.  Such a NUMA node is
still considered to be online because it has memory, but it has
no online CPUs.

If this code ever sets "numa_node" to such a NUMA node,
the "for" loop will become an infinite loop because the "if"
statement above will never find a CPU that is assigned to
"numa_node".

> +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
> +			cpumask_clear_cpu(cpu_first, filter_mask_list[core_count]);
> +			cpu_count =3D cpu_count + 1;
> +			i =3D i + 1;
> +			/* checking if all the cpus are used from the
> +			 * particular node.
> +			 */
> +			if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
> +				numa_node =3D numa_node + 1;
> +				if (numa_node =3D=3D num_online_nodes()) {
> +					cpu_mask_set(&filter_mask, &filter_mask_list);

The second and subsequent calls to cpu_mask_set() will
leak any memory previously allocated by alloc_cpumask_var()
in cpu_mask_set().

I agree with Haiyang's comment about starting with a NUMA
node other than NUMA node zero.  But if you do so, note that
testing for wrap-around at num_online_nodes() won't be
equivalent to testing for getting back to the starting NUMA node.
You really want to run cpu_mask_set() again only when you get
back to the starting NUMA node.

> +					numa_node =3D 0;
> +				}
> +				cpu_count =3D 0;
> +				core_count =3D 0;
> +				continue;
> +			}
> +		}
> +		if ((core_count + 1) % cores =3D=3D 0)
> +			core_count =3D 0;
> +		else
> +			core_count++;

The if/else could be more compactly written as:

		if (++core_count =3D=3D cores)
			core_count =3D 0;

> +	}
> +free_irq:
> +	cpus_read_unlock();
> +	if (filter_mask)

This check for non-NULL filter_mask is incorrect and might
not even compile if CONFIG_CPUMASK_OFFSTACK=3Dn.  For testing
purposes, you should make sure to build and run with each
option:  with CONFIG_CPUMASK_OFFSTACK=3Dy and
also CONFIG_CPUMASK_OFFSTACK=3Dn.

It's safe to just call free_cpumask_var() without the check.

> +		free_cpumask_var(filter_mask);
> +	if (filter_mask_list) {
> +		for (core_count =3D 0; core_count < cores; core_count++)
> +			free_cpumask_var(filter_mask_list[core_count]);
> +		kfree(filter_mask_list);
> +	}
> +	return err;
> +}
> +
>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
>  	unsigned int max_queues_per_port =3D num_online_cpus();
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	unsigned int max_irqs, cpu;
> -	int nvec, irq;
> +	unsigned int max_irqs;
> +	int nvec, *irqs, irq;
>  	int err, i =3D 0, j;
>=20
>  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
> @@ -1261,6 +1363,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev=
)
>  	nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
>  	if (nvec < 0)
>  		return nvec;
> +	irqs =3D kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
> +	if (!irqs) {
> +		err =3D -ENOMEM;
> +		goto free_irq_vector;
> +	}
>=20
>  	gc->irq_contexts =3D kcalloc(nvec, sizeof(struct gdma_irq_context),
>  				   GFP_KERNEL);
> @@ -1281,20 +1388,20 @@ static int mana_gd_setup_irqs(struct pci_dev *pde=
v)
>  			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
>  				 i - 1, pci_name(pdev));
>=20
> -		irq =3D pci_irq_vector(pdev, i);
> -		if (irq < 0) {
> -			err =3D irq;
> +		irqs[i] =3D pci_irq_vector(pdev, i);
> +		if (irqs[i] < 0) {
> +			err =3D irqs[i];
>  			goto free_irq;
>  		}
>=20
> -		err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
> +		err =3D request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
>  		if (err)
>  			goto free_irq;
> -
> -		cpu =3D cpumask_local_spread(i, gc->numa_node);
> -		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
>  	}
>=20
> +	err =3D irq_setup(irqs, nvec);
> +	if (err)
> +		goto free_irq;
>  	err =3D mana_gd_alloc_res_map(nvec, &gc->msix_resource);
>  	if (err)
>  		goto free_irq;
> @@ -1314,6 +1421,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  	}
>=20
>  	kfree(gc->irq_contexts);
> +	kfree(irqs);
>  	gc->irq_contexts =3D NULL;
>  free_irq_vector:
>  	pci_free_irq_vectors(pdev);
> --
> 2.34.1


