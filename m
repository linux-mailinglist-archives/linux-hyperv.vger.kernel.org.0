Return-Path: <linux-hyperv+bounces-1399-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A8F828D48
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 20:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3F11F2731F
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jan 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C913D0C6;
	Tue,  9 Jan 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t4CAeHCo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2023.outbound.protection.outlook.com [40.92.19.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99523D0C3;
	Tue,  9 Jan 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emrfKrEfi93ptKSQjwgDh4P7Niz08kzCBinSVBpi/QB65hc/Eh0Yn2YN68sfYs7PG9bZJMDLI4y27sEkA1Du4xIj3A5dGFBdnbtJnrcymbUF/iZ/BAZzQGKibw22FW+u0o34Y3LbWn9tjgLQME3iikowPsqG+OiVm4UKYcNf6S/PBdYwMmxkjJ1sqSy2wIwit8mS8V/zqdmn7O6cSOPf0kATHmqPnbkDeSp3jFv6Yj9SW46Xjv6eVJp6efR04KcjFwncPtwX7J3BzEgLojWqgqxVGs4aj25ov7J9u0gfa6EPUP6UlKWfXI6wKLFs+nyK/qin9hEGmjgDDolHHA5iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DnUWaf8aBr9DCCZU2qNfaCqur6vXMFXuZ6vg80Uglk=;
 b=U9QMubYFvx3kzaQWM0TyRLIcUADJbbssucgou6qpZaqjaLIPpEaFp102zlDU9iTCa83dPd8iUK9t9hTzAz398viu0HkJTryrZlbPhtUaXJttzSE0k7cZwf2hUVIv3ol+sg3HYfdkbe8tSezGEoTQMNhtNb6yl2x0nlbXgrOSiehGUBVBsZ8gxv4KBRqNfS7yjLL4KuLR92dsI7FCIVqkRU2CfN1/RGeGUTLdYsqBHZTBl2Bx31h4tmJMYfiG6XU2CfvKHK31lUuCG25hnS2GAekOl+yIRxqywEDRUgNuhg89Ji0qDDUdF+QBMYAs9c70Xtht7eM+1KIRaA8+hv1WRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DnUWaf8aBr9DCCZU2qNfaCqur6vXMFXuZ6vg80Uglk=;
 b=t4CAeHCoAyKpJGfwFT/mjuilYrT+SttN4nrw9Fp43w6NC8cuPAeL5OMPGGCXHhwVQq6+jN45JzZHVaPAskoPbqgI9ER+PjVOAMoFDNjpdVxiBbJ02DEzbO1rZY73ntr5MS5XB+6hiF6FyHyufRG44zNAgWgXsnEGRxxcU2dTJe/xpRViBdlm426DNAPhesftK5t7+1yu898BjFIXwOn9BvUhMxSJOR8640l/lLeh5zsTbP13Z9/+beARedok3X4pVv1Rd9j0Swe3+qzhwZjM6aeJ5TU1torYdsmk5zdJhbHj0StpH5iJkr6P4JovuRWBmGSKCcR10GywTOBXkIaLJw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9391.namprd02.prod.outlook.com (2603:10b6:a03:4c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 19:22:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 19:22:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
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
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index: AQHaQuoWNi7Bv1N390Ch4p7DlTYrcLDR1sMg
Date: Tue, 9 Jan 2024 19:22:38 +0000
Message-ID:
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [az8VlYiVcp0dizlN0Us9ZOOpYPC77r+2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9391:EE_
x-ms-office365-filtering-correlation-id: 017b3198-5264-4632-3a14-08dc11485796
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y7tziniuchePv0HBDCJNeUQ+a+HmJOK/fvIAvV3+aPYcExGeiws1sobaW0H3jMnTD8+Le8wAiTKG64hJKuBC2n7H4363gX3fPYfuLCqhYNO9qxR1I4j2VUdoYMAwX1miZD85WlvoVsTxKDpW0MDx5sc8ngEUJUlTzX3FSfbL1HuIb3Zdblii8jJcXFPAFjEjUTIpcXiGCLSAAAJB9RpDEy1XXlC9hh5GUJEfOXnHic96dc+0g7f2UswAvug9rLFLV7dTGdu+dVkF6bRlY4u8s6hIgMrDreLAYIFOOh/ABPRr6Jvet9KOoh571Y1RhZv+0GZINht8dfdQj95DQshaklVRi9dJe3Du9oigIzdTr3KG9AIhN0KlJEl7mgnisnHpukSz588F2zU4JhJYr570dhBfJbSA/eFcAK9tcN1YzRKMD5Z7ObhNtvrdNPTnq1OH4jwiLBNCDSdeyKLTjWB24UB6cVzcZJGT2XR/j3ow6LybADP+USGs0Jnan3u+A1DxIxKqXuCBB3e0n+oYUqo2d/0w5+KXUGdItuJRBRl049zDp+uV9tfnreZXpMbjmvIjawiYtLoOHpv3gVdMI1FP1Qx/BTfl18tfCctJfO42WfE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lo6bdNbnE3ahHHCSwc4weDuiylMdgtQZ1lXt6nIXi37YHsFUFfatCTjSeQf0?=
 =?us-ascii?Q?oKLrAdwhhf8gkXsz6PocRsk2+RkOyKsWf2soCLJ5sJ8dpLgzHFmzsiU/P54X?=
 =?us-ascii?Q?pyd7eOF1iJonKdoSZn6XE7ZU1Gcmk60f4VS8Bc40aAAAa1t+jovh92PlI0IO?=
 =?us-ascii?Q?T1gWxxl6e+VjlwAcodDUy0VEJqRribEvY/ctGxlpknKtoEk+QZ5c4RRW/OwX?=
 =?us-ascii?Q?oLMdD0tX2e+qhlapiNPER4OFEh5TdZWLOSocdr5iTKf96N2DUEFDZ0oIPlr3?=
 =?us-ascii?Q?b+7qAnTfAxpsAq395aBVTsRFpILnxn82Za76lA4UiDwVwApoAeek5wF6W353?=
 =?us-ascii?Q?ZjpfKrWYVm9AjT+u4EL5566+qUMtQbZqw1F1Ln2p6BZRp3vdujUbItMrKNjt?=
 =?us-ascii?Q?B4Z2Tbd9uzgFOT/elIKY3DU0uvpxmcLRZmDuiJ/j5ykISDxwe7fomrB2eUfJ?=
 =?us-ascii?Q?EDaHxu26nVGYhqiIVf5J1XOvZVk5DgXJGgaOpIyrLCQPM9v8FCBYCAXT0M64?=
 =?us-ascii?Q?EwP83zWkQC6PYV9F4pNwcXRAC4sjmlinFc/nb3g0MbciRmxm04CGfZ+DQPG1?=
 =?us-ascii?Q?aFASA4wqTy4PuBT9owHDo7dcP6VcBlgoXigLib0gXNfQoOCOr1q3sPvWtLbj?=
 =?us-ascii?Q?vVw+q4hOozwKgkRcLh9NnrqquXVlcdFyr1IZrPiMeiTa0LYT6rsqSk9grziJ?=
 =?us-ascii?Q?Np2We4z3ZOL5z9rh6SlS4LDPXNn0APBBIEsv7TCkP20Hg+yeKpBnCGQTfnXV?=
 =?us-ascii?Q?PxAnjypc2orKiTU8uZQ7hN35cahhnyRP8jNd7O7LqrO6TkNWtzQtnEw3Rp0q?=
 =?us-ascii?Q?6koahfBUgTg58JapmN205o3Suq3AvDEl5yz08klWbf1Fc71/QHOsBNj/pMBJ?=
 =?us-ascii?Q?529oNXMq0kIsoVZlZRLrSrcP2wmMA7iOkPD5IHFp/8nS6l5pexEoj2z9uKoK?=
 =?us-ascii?Q?SFDJfzQBL4ZcRk5CCI/xWzCHMcp/BCR5WZW2k4NRi8ZWjG67D/YeTUdGX9lZ?=
 =?us-ascii?Q?Nu1/1M6tK2jh3u6LVSypWDq9lAdQK1s0h369Mf6f+Hq7jWNLysRhwMJdXesP?=
 =?us-ascii?Q?Qg1RC7kJCXjADeEZIZayaSk2yVCfrGCPnJPrauS0Z5NtgyCL3huNQ8dZf9JT?=
 =?us-ascii?Q?1I7eKOYss/fnj4CES52zXSDC13sLfA1CSe4ou0aLnRuWRo0RAO9P0bEh65Z6?=
 =?us-ascii?Q?oQFjQOL+F6QmqT+9cWJafaEHhiYKtZE1DsUFbg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b3198-5264-4632-3a14-08dc11485796
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 19:22:38.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9391

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Tuesda=
y, January 9, 2024 2:51 AM
>=20
> From: Yury Norov <yury.norov@gmail.com>
>=20
> Souradeep investigated that the driver performs faster if IRQs are
> spread on CPUs with the following heuristics:
>=20
> 1. No more than one IRQ per CPU, if possible;
> 2. NUMA locality is the second priority;
> 3. Sibling dislocality is the last priority.
>=20
> Let's consider this topology:
>=20
> Node            0               1
> Core        0       1       2       3
> CPU       0   1   2   3   4   5   6   7
>=20
> The most performant IRQ distribution based on the above topology
> and heuristics may look like this:
>=20
> IRQ     Nodes   Cores   CPUs
> 0       1       0       0-1
> 1       1       1       2-3
> 2       1       0       0-1
> 3       1       1       2-3
> 4       2       2       4-5
> 5       2       3       6-7
> 6       2       2       4-5
> 7       2       3       6-7

I didn't pay attention to the detailed discussion of this issue
over the past 2 to 3 weeks during the holidays in the U.S., but
the above doesn't align with the original problem as I understood
it.  I thought the original problem was to avoid putting IRQs on
both hyper-threads in the same core, and that the perf
improvements are based on that configuration.  At least that's
what the commit message for Patch 4/4 in this series says.

The above chart results in 8 IRQs being assigned to the 8 CPUs,
probably with 1 IRQ per CPU.   At least on x86, if the affinity
mask for an IRQ contains multiple CPUs, matrix_find_best_cpu()
should balance the IRQ assignments between the CPUs in the mask.
So the original problem is still present because both hyper-threads
in a core are likely to have an IRQ assigned.

Of course, this example has 8 IRQs and 8 CPUs, so assigning an
IRQ to every hyper-thread may be the only choice.  If that's the
case, maybe this just isn't a good example to illustrate the
original problem and solution.  But even with a better example
where the # of IRQs is <=3D half the # of CPUs in a NUMA node,
I don't think the code below accomplishes the original intent.

Maybe I've missed something along the way in getting to this
version of the patch.  Please feel free to set me straight. :-)

Michael

>=20
> The irq_setup() routine introduced in this patch leverages the
> for_each_numa_hop_mask() iterator and assigns IRQs to sibling groups
> as described above.
>=20
> According to [1], for NUMA-aware but sibling-ignorant IRQ distribution
> based on cpumask_local_spread() performance test results look like this:
>=20
> /ntttcp -r -m 16
> NTTTCP for Linux 1.4.0
> ---------------------------------------------------------
> 08:05:20 INFO: 17 threads created
> 08:05:28 INFO: Network activity progressing...
> 08:06:28 INFO: Test run completed.
> 08:06:28 INFO: Test cycle finished.
> 08:06:28 INFO: #####  Totals:  #####
> 08:06:28 INFO: test duration    :60.00 seconds
> 08:06:28 INFO: total bytes      :630292053310
> 08:06:28 INFO:   throughput     :84.04Gbps
> 08:06:28 INFO:   retrans segs   :4
> 08:06:28 INFO: cpu cores        :192
> 08:06:28 INFO:   cpu speed      :3799.725MHz
> 08:06:28 INFO:   user           :0.05%
> 08:06:28 INFO:   system         :1.60%
> 08:06:28 INFO:   idle           :96.41%
> 08:06:28 INFO:   iowait         :0.00%
> 08:06:28 INFO:   softirq        :1.94%
> 08:06:28 INFO:   cycles/byte    :2.50
> 08:06:28 INFO: cpu busy (all)   :534.41%
>=20
> For NUMA- and sibling-aware IRQ distribution, the same test works
> 15% faster:
>=20
> /ntttcp -r -m 16
> NTTTCP for Linux 1.4.0
> ---------------------------------------------------------
> 08:08:51 INFO: 17 threads created
> 08:08:56 INFO: Network activity progressing...
> 08:09:56 INFO: Test run completed.
> 08:09:56 INFO: Test cycle finished.
> 08:09:56 INFO: #####  Totals:  #####
> 08:09:56 INFO: test duration    :60.00 seconds
> 08:09:56 INFO: total bytes      :741966608384
> 08:09:56 INFO:   throughput     :98.93Gbps
> 08:09:56 INFO:   retrans segs   :6
> 08:09:56 INFO: cpu cores        :192
> 08:09:56 INFO:   cpu speed      :3799.791MHz
> 08:09:56 INFO:   user           :0.06%
> 08:09:56 INFO:   system         :1.81%
> 08:09:56 INFO:   idle           :96.18%
> 08:09:56 INFO:   iowait         :0.00%
> 08:09:56 INFO:   softirq        :1.95%
> 08:09:56 INFO:   cycles/byte    :2.25
> 08:09:56 INFO: cpu busy (all)   :569.22%
>=20
> [1]
> https://lore.kernel.org/all/20231211063726.GA4977@linuxonhyperv3.guj3
> yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Co-developed-by: Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 29
> +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 6367de0c2c2e..6a967d6be01e 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1243,6 +1243,35 @@ void mana_gd_free_res_map(struct gdma_resource *r)
>  	r->size =3D 0;
>  }
>=20
> +static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len=
, int node)
> +{
> +	const struct cpumask *next, *prev =3D cpu_none_mask;
> +	cpumask_var_t cpus __free(free_cpumask_var);
> +	int cpu, weight;
> +
> +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +	for_each_numa_hop_mask(next, node) {
> +		weight =3D cpumask_weight_andnot(next, prev);
> +		while (weight > 0) {
> +			cpumask_andnot(cpus, next, prev);
> +			for_each_cpu(cpu, cpus) {
> +				if (len-- =3D=3D 0)
> +					goto done;
> +				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> +				--weight;
> +			}
> +		}
> +		prev =3D next;
> +	}
> +done:
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
>  	unsigned int max_queues_per_port =3D num_online_cpus();
> --
> 2.34.1
>=20


