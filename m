Return-Path: <linux-hyperv+bounces-1006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199697F3681
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8556AB20DFB
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2655C26;
	Tue, 21 Nov 2023 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oIBf+5pt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2046.outbound.protection.outlook.com [40.92.44.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CC8B9;
	Tue, 21 Nov 2023 10:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNrGi8ADNw0+KgtufEhXIx5d1zomzeIlOEUQV8Kr9IgLiYx4xRbXwaPBfbAHKrteBbARBINuXLFKmiFFx70NCsKyHLUFquZd83tUg44CWcmVMz/m+f553+Ac5aab6YJynYiApevzdXXKIUv8gNDNbeBGSS0CUX86nM4VIAPLNVgEQN1McMkdM2uClQzaWUU3zGYg7Bwt6lQrPWgctNm2YjTeV4plCnY66pagBW2EkcrOF7JKUD3+4ckJ+AOb3WUle+8qo/ELheKjFizW8Pj4vrJQI88kvKvlq7CfDx0wLODTQeF7OmL0W5tdSicdxva9AuDuVQiYUBBwc6wtMjywbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jff/d8V2H5Id5/j2eEkbUHH4GrxdxlPtmPq7rGpx3q0=;
 b=V04B5NavATkHSBtvkz37xieXI+fQ6aGw8FfonYPu0Fvy4drOw2EhNeVTDf0X6dv8i3o2UKr9EYiPn50TIjKM/ImoWTnfoC2Wvrxmb7N7oZqrSTm1ChdDulGXgUx3fp0aR1gL1Inc5QUqHgY1onLnbr0Bb4BSEsIY4mgWHQrvEgbUcMNpnLDckO0gmkTZ9OaFxchLI5Al/oqHy5bGg7ZnWfPGvde9U1suaMsU8HrKDYV5q5h0T1fvcWFslp4u/zd3fXABFuRB7voCmELA7RTPVjY5RJ3HDAOCK0SNNEOWx/gIUd+ZguLwort9YHroDF/BH8utKHvPOcSGXpHhU0/eyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jff/d8V2H5Id5/j2eEkbUHH4GrxdxlPtmPq7rGpx3q0=;
 b=oIBf+5ptQn3rUcBNuqMqds0hLskUZO1wYql+ZH6W8jdYI066omNFFCPduT7hh7UCeoYcM0I2iYW+yK8Ma8OGP+Vlucm28YVxQYyDdEIi+qSXKOb1v5HPFVF8spkWDjqN6GVc2aRQ7rAbEBauKB8+GkRdAMi/P3eMBjDHIaF9lZMYuk6rtsUWytfDMx0pOo2K4ugSY/fMYDuMSlqeILMSh5hCqJyhAfZS0c5+moDRgemto4DjZr+YGT8DoRwcfr/8f2KH1CrViJrIlNuofWGlV7EkVUXIlQyFJABgkLk28r3OnysoiRFOmxClzI0WVq/cBxPGADDuYfpZkEPoQdApIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL0PR02MB6482.namprd02.prod.outlook.com (2603:10b6:208:1ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 18:51:39 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::54e5:928f:135c:6190%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 18:51:39 +0000
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
Subject: RE: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Thread-Index: AQHaHIJLYSaGF4VzakKKvvUoGccXXrCFCyqA
Date: Tue, 21 Nov 2023 18:51:39 +0000
Message-ID:
 <SN6PR02MB41572F7E6D18E91A76EED137D4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Q9sGraZ8zl+nxMUoSP+32Xr5SPw1ZxyD]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL0PR02MB6482:EE_
x-ms-office365-filtering-correlation-id: a508ad3c-5861-4bb9-a3ed-08dbeac2e584
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dVFdg3nmIL5pPBpm6zny56Db3B1G6CCeq8iIUGZ/w0rfPL1n0+0uBS578gQk1I86NtiSVu4GfzhkQbKpU97x9NxuF2G+7PJ42suE8IP49ipsqzwf3c2oOqiu5+hKJJ16jVFp6SMMVidgA/xfmLtIborMPtzh5/nKjjlYc3svKotBloIdbe2A7eWZUD5yFeGwniI5GB24L6Oi14yTwiMRhe7F0FvbXHzMBUCEOYECNbzf0wxIQtx9qTqY2kCw7umPV0mdV6nLu7ivSrlBbS8BPYXauz9wJQ8MmWvIPH6qja/qMQ4nxktAdvQd7GIMpIp8pX4Ugq9cj+prMxgCCDlrENtCpTtRS9VPe2q+SFJg7NvjIB5oTwvNQm0X8YFpVbD23svQQs3ZvrPoPyCWGM9DeLzp/cQrz/1H5JMqZCs9TgJy3JTM/TEmBZ0z9sGtzDH6MmEs2NcmyQLG4gWp75A9jTWMXLRjs70CH1XvtEouytSwyHBh5YqpT706KG+A9uSkyR9kxtAhf3HImXzI7XSJGoSUMgNpnEQvY6xJYA6yzqt5rICceKqV5G0S7HgALS04
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C7Nrcofp8KCPfUVN1t413++yXnt6JGF/ziF3927bls6ZAXELZRU0o7/Jl78u?=
 =?us-ascii?Q?fDvnMi3d9cHe9Pk2iru1n8iEPM0kMOaOlVDXypP2ok3zDEfwJdINqnfrZlXL?=
 =?us-ascii?Q?+CNKIAjmFiDV2dzU5C92roLsXNklmgrji89XKZE2MHu/WrTZtSHQ4ac9QJ6m?=
 =?us-ascii?Q?IrrpPc77hf/d509fbDi/qFWKHx1RlyKPujZKcYUAb7wjLe3klHffCASZZGQt?=
 =?us-ascii?Q?nP1Rfq0E+SXiDqvYkbjcy7Y42sU6LMQdH5xSxtNf5kdV9NZ4cjLWEpBWFr7l?=
 =?us-ascii?Q?m1zGT/Cti4qS9xP4oViGrW72CcmTYCPVHewzp5XEsxoK6cOHF7vDCFP4Vsw5?=
 =?us-ascii?Q?4o1PkkAUn03oQyQtg9opsAhqUf0xxxOj5COj2E4GaQqGztTKd4u7mMTo4vbn?=
 =?us-ascii?Q?9B3iVzm1PFlPT/F1jG6jaPwBVnWXjnfvMgGNp2usZ00JRXKXuc0kOn11DCx5?=
 =?us-ascii?Q?IHS320w8Hzaa7NwAB9FXBO0hqrQEOVggQfcaFoy29HxDt6hgkKx1Ory8v5iX?=
 =?us-ascii?Q?XK2dOACs2hvxYhSFluDhWyPZU723u09585b0AICMhfhvqWYms321r6nselnw?=
 =?us-ascii?Q?JBJBVqyzgn1yvgiKjbTULE15M+s2V22xTSzhfZ1/LDoL+EtX8tz/T6zsQNzy?=
 =?us-ascii?Q?hRCM/mMIB1svtpOSjdhbQ24S3CgH//kiUpH27fETrBHRBaWo2X6ZNANJZuCD?=
 =?us-ascii?Q?SgXX3rfXmW5lK1ky6RdqOa6nr3KYqmCagqfqueDfP8uWF60V/xHyuFV2Pvlw?=
 =?us-ascii?Q?vkWUuZLiAvf1/F+l+JfDrgmtYIoORgDJLHsxQCFY3C4P7seJis5vuoEl8La0?=
 =?us-ascii?Q?E1NPatdtT6V1re+5S8wuCT51dL1pqEj2nZqg+SOHoAAVp0MJfKI+/I8iP/Ke?=
 =?us-ascii?Q?53Edxncm9RhvcgatsOZjH78o5AEXYbakokRVjQqRK+LleyiZUDGLpoKGqNS8?=
 =?us-ascii?Q?heW1QWnzMURGvHG+rZECL1feK1yVtiCALYR02VFlmUMBznUMkTDHbIEVCbHg?=
 =?us-ascii?Q?m6Wu+Fk55W3/sAtfosoEzRSCLGTjGGowxJMTXD2K8hZLQlQP+XyYSG7Oe7bO?=
 =?us-ascii?Q?HaD90lwTP5qbMna4futfYUkLFuoBlpEMR6XCyb38U09GEoGaMq6YKbA7seE0?=
 =?us-ascii?Q?PCdaX9efJltlooRr1lw8kCtJ3y1X+aeCN5VsVCT99OdEnzoRy1bqXbgj6z6T?=
 =?us-ascii?Q?pgXF1LTlOPNSJJKm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a508ad3c-5861-4bb9-a3ed-08dbeac2e584
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 18:51:39.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6482

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Tuesda=
y, November 21, 2023 5:55 AM
>=20
> Existing MANA design assigns IRQ to every CPUs, including sibling hyper-t=
hreads

"assigns IRQs to every CPU"

> in a core. This causes multiple IRQs to work on same CPU and may reduce t=
he network

"This may cause multiple IRQs to be active simultaneously in the same core
  and may reduce the network"

> performance with RSS.
>=20
> Improve the performance by adhering the configuration for RSS, which assi=
gns
> IRQ on HT cores.

This sentence still doesn't make any sense to me.

>=20
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V1 -> V2:
> * Simplified the code by removing filter_mask_list and using avail_cpus.
> * Addressed infinite loop issue when there are numa nodes with no CPUs.
> * Addressed uses of local numa node instead of 0 to start.
> * Removed uses of BUG_ON.
> * Placed cpus_read_lock in parent function to avoid num_online_cpus
>   to get changed before function finishes the affinity assignment.
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 134 ++++++++++++++++-
> -
>  1 file changed, 123 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 6367de0c2c2e..8177502ffbd9 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1243,15 +1243,120 @@ void mana_gd_free_res_map(struct
> gdma_resource *r)
>  	r->size =3D 0;
>  }
>=20
> +static int irq_setup(int *irqs, int nvec, int start_numa_node)
> +{
> +	unsigned int *core_id_list;
> +	cpumask_var_t filter_mask, avail_cpus;
> +	int i, core_count =3D 0, cpu_count =3D 0, err =3D 0, node_count =3D 0;
> +	unsigned int cpu_first, cpu, irq_start, cores =3D 0, numa_node =3D star=
t_numa_node;
> +
> +	if(!alloc_cpumask_var(&filter_mask, GFP_KERNEL)
> +			     || !alloc_cpumask_var(&avail_cpus, GFP_KERNEL)) {

I think it's the case that you don't really need both filter_mask and avail=
_cpus.
filter_mask is used to count the number of cores and set up core_id_list.  =
 But
it isn't used anymore when the code starts working with avail_cpus.  So a s=
ingle
allocated cpumask_var_t variable could serve both purposes.

> +		err =3D -ENOMEM;
> +		goto free_irq;

This error path will check if core_id_list is NULL to decide if the
core_id_list memory needs to be freed.  But core_id_list is uninitialized
at this point.

> +	}
> +	cpumask_copy(filter_mask, cpu_online_mask);
> +	cpumask_copy(avail_cpus, cpu_online_mask);
> +	/* count the number of cores
> +	 */
> +	for_each_cpu(cpu, filter_mask) {
> +		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu)=
);
> +		cores++;
> +	}
> +	core_id_list =3D kcalloc(cores, sizeof(unsigned int), GFP_KERNEL);

Need to check for memory allocation failure.

> +	cpumask_copy(filter_mask, cpu_online_mask);
> +	/* initialize core_id_list array */
> +	for_each_cpu(cpu, filter_mask) {
> +		core_id_list[core_count] =3D cpu;
> +		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu)=
);
> +		core_count++;
> +	}
> +
> +	/* if number of cpus are equal to max_queues per port, then
> +	 * one extra interrupt for the hardware channel communication.
> +	 */

The "then" part of the above comment is missing some wording.  I think
what you are saying is that in this case, irq[0] is in the IRQ for the hard=
ware
communication channel and is treated specially by assigning it to the first
online CPU.  That IRQ then does not participate in the IRQ assignment algor=
ithm
that is implemented by the remaining code in this function.

> +	if (nvec - 1 =3D=3D num_online_cpus()) {
> +		irq_start =3D 1;
> +		cpu_first =3D cpumask_first(cpu_online_mask);
> +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
> +	} else {
> +		irq_start =3D 0;
> +	}
> +
> +	/* reset the core_count and num_node to 0.
> +	 */

This comment seems out-of-date since num_node is gone.

> +	core_count =3D 0;
> +
> +	/* for each interrupt find the cpu of a particular
> +	 * sibling set and if it belongs to the specific numa
> +	 * then assign irq to it and clear the cpu bit from
> +	 * the corresponding avail_cpus.
> +	 * Increase the cpu_count for that node.
> +	 * Once all cpus for a numa node is assigned, then
> +	 * move to different numa node and continue the same.
> +	 */
> +	for (i =3D irq_start; i < nvec; ) {
> +
> +		/* check if the numa node has cpu or not
> +		 * to avoid infinite loop.
> +		 */
> +		if (cpumask_empty(cpumask_of_node(numa_node))) {
> +			numa_node++;

This doesn't work correctly.  Just incrementing numa_node could
produce a value that needs to wrap-around to zero or has wrapped
back to the initial numa node.  Also, the next numa node selected
could *also* have zero CPUs and the code below would still get stuck
in an infinite loop.

This also seems like the wrong place to make this check as this
check is executed every time through the loop, including when
only moving to the next core.  You really want to make this check
in two places:  1) the initial NUMA node that is passed in as
an argument, and 2) whenever the NUMA node is updated
below.

A suggestion:  create a helper function "get_next_numa_node()".
This function would do the following:
1) Wrap-around back to NUMA node 0 if appropriate
2) Then check for having visited all NUMA nodes -- i.e.,
having wrapped back to the initial NUMA node
3) Check for no CPUs in the selected NUMA node.  If that's
the case, increment the numa node, then retry starting at Step #1.

This helper function would be called before starting the main "for"
loop and again when all CPUs in a node are used.

I haven't coded the above suggestion, so you'll have to see if
it really works out.  But I think getting all of the numa node
selection code in one place would help make sure it is right.

> +			if (++node_count =3D=3D num_online_nodes()) {
> +				err =3D -EAGAIN;
> +				goto free_irq;

I don't understand what the above code is doing.  What is the
situation where you could "run out" of NUMA nodes and need to
return an error?  There always must be at least one NUMA node
with CPUs.

> +			}
> +		}
> +		cpu_first =3D cpumask_first_and(avail_cpus,
> +				topology_sibling_cpumask(core_id_list[core_count]));
> +		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=3D numa_node)=
 {
> +			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
> +			cpumask_clear_cpu(cpu_first, avail_cpus);

This looks good.  Getting rid of filter_mask_list worked out well. :-)

> +			cpu_count =3D cpu_count + 1;
> +			i =3D i + 1;

Nit:  Stylistically, "C" usually writes the above as just:

			cpu_count++;
			i++;

> +
> +			/* checking if all the cpus are used from the
> +			 * particular node.
> +			 */
> +			if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
> +				numa_node =3D numa_node + 1;

Same here:  just numa_node++

> +				if (numa_node =3D=3D num_online_nodes())
> +					numa_node =3D 0;
> +
> +				/* wrap around once numa nodes
> +				 * are traversed.
> +				 */
> +				if (numa_node =3D=3D start_numa_node) {
> +					node_count =3D 0;
> +					cpumask_copy(avail_cpus, cpu_online_mask);
> +				}
> +				cpu_count =3D 0;
> +				core_count =3D 0;
> +				continue;
> +			}
> +		}
> +		if (++core_count =3D=3D cores)
> +			core_count =3D 0;
> +	}
> +free_irq:
> +	free_cpumask_var(filter_mask);
> +	free_cpumask_var(avail_cpus);
> +	if (core_id_list)
> +		kfree(core_id_list);
> +	return err;
> +}
> +
>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
> -	unsigned int max_queues_per_port =3D num_online_cpus();
> +	unsigned int max_queues_per_port;
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	unsigned int max_irqs, cpu;
> -	int nvec, irq;
> +	unsigned int max_irqs;
> +	int nvec, *irqs, irq;
>  	int err, i =3D 0, j;
>=20
> +	cpus_read_lock();
> +	max_queues_per_port =3D num_online_cpus();
>  	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
>  		max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
>=20
> @@ -1261,6 +1366,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev=
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
> @@ -1281,27 +1391,27 @@ static int mana_gd_setup_irqs(struct pci_dev *pde=
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
> +	err =3D irq_setup(irqs, nvec, gc->numa_node);
> +	if (err)
> +		goto free_irq;
>  	err =3D mana_gd_alloc_res_map(nvec, &gc->msix_resource);
>  	if (err)
>  		goto free_irq;
>=20
>  	gc->max_num_msix =3D nvec;
>  	gc->num_msix_usable =3D nvec;
> -
> +	cpus_read_unlock();
>  	return 0;
>=20
>  free_irq:
> @@ -1314,8 +1424,10 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev=
)
>  	}
>=20
>  	kfree(gc->irq_contexts);
> +	kfree(irqs);
>  	gc->irq_contexts =3D NULL;
>  free_irq_vector:
> +	cpus_read_unlock();
>  	pci_free_irq_vectors(pdev);
>  	return err;
>  }
> --
> 2.34.1


