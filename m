Return-Path: <linux-hyperv+bounces-973-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EB7EDF8B
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8C1C20492
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F42D7AE;
	Thu, 16 Nov 2023 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QHxUvUqS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EEA85;
	Thu, 16 Nov 2023 03:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVnV5xTJfHW2USzTeyc9HTMy382OX35/Q78GgwQ35ABZg9ib86Gbke6afWRMrfbNjdNfgtEtFPKLwdvKYE0uQ/xN4ZoBEwvu57VpgychdceUvDwzClHeycrwRGMmj63u4+ya26yGE3vVPj2qgpLJzAUbkhTRYe/Wg9SC/DyXvYWA86aIZ8Vlf0iPx73dtQ4zPMwfmwjEuP3iWbTTuKlBnY9Sqy4qc4j10cm7puOzl4leHg3DhYN/K9NU+sJqDuVPm+fyCcjTm0dd7r1pyytCZtk4AHpCeoqje9b0N5cHzZYIN4h8BpvQYonLDQJFbGgAxIkf54E/gWkpvN7g8FB39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7o7nQJLsbrxtgh1QNpQbEXM72QU8jpDTM8GdtkiHdw=;
 b=bVFHNXLqDKAJz91WbNIDiXmA0iO3wjCJArZYYdx97KqUiK10739wls6Y93thobcH2V8Jvw+rVMUVd2D4igP57ugK8HtNXP0zvhMaU92FTc4NPPSxrPpoNFJQWLuvYrdCL1WvIjGR9JXQtgHJVrOdjc6VYL4x9K7iMUxtdk2SrS/zFg6nC4nnsBHxs/WXs2TdWdHUb0795qk5aJ00aPYmF2M1p7JILxrJJeEsPSxUCFNkRy8MuzEJHY+rBeziHEdds2Nyoyfkdp/npybEPdVYmkX0c8tUYhtZzvjFPd6hnwzIuxZtUKsbdBn2dnkfViNeCk3eqIrKWvy+AObW1aL2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7o7nQJLsbrxtgh1QNpQbEXM72QU8jpDTM8GdtkiHdw=;
 b=QHxUvUqSfBcLdanCK8WxQM5Pk1smAh4HzoeAvZBSusqA/FDT4GjsAnzaX8Xzqr8f1QBf3j46ou3w9uMcVHgppRBXEe+6j7ZZGLrLgwP45b/51Ssa0QwfFEqVY6EF3CaMvIMWJ5SQ6fVS8ho2UZ9aa6LXB1lrsZTBUREEtPdTHt0=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by TYSP153MB1016.APCP153.PROD.OUTLOOK.COM (2603:1096:400:46c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.9; Thu, 16 Nov
 2023 11:21:10 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7025.009; Thu, 16 Nov 2023
 11:21:10 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "leon@kernel.org"
	<leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Index: AQHaF8qGIm6eugOJi0KcyMy20QXRcrB7/d0AgADQPQA=
Date: Thu, 16 Nov 2023 11:21:08 +0000
Message-ID:
 <PUZP153MB0788BF5F18973922F03C2CA4CCB0A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
 <PH7PR21MB311687F4F37C55D6B332D7F0CAB1A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To:
 <PH7PR21MB311687F4F37C55D6B332D7F0CAB1A@PH7PR21MB3116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a89832be-4a0a-4c6b-aea1-8812e4a22e64;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-15T22:38:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|TYSP153MB1016:EE_
x-ms-office365-filtering-correlation-id: 59425e8e-4201-4567-9075-08dbe69621c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g4YZbTNvk9+GsE17OWBkI30xN4Xt9vSA33rtZQwEXJ85xOPLWAhS6irs8tiI4WcRDth4z+CgbeHysX41kd27ZZIamzMUks1Jh4EGYFnndIfSwIVryWrkWVpgePpq1QTZ/cHpiaT3//p8f8iA1SC1SDuj+uH75mYlL4ZehG99PqAPQEbyOr5k+0YA7o/MnmaD2nLVCmwwEOaxv+/hA3SE/YSxqGDhlebCK7X7cb+YEyuHIvgCPrBoveyEsTShgGpZZnodkNkq5ZxxnTpVd9ML+WLiwFi7/udVi+IUECEKVpsubHZ9Wm6BDiaqeHlX9TI57b5a/7acFwuq3LNB+DV63k1Qn+G/cPT0oL7ChbvVRcL21q9FPflvGC7UeZd42NvdI0yuzZmKMZHD4CENY6T3VxRwSftZwXThxDCPF+TzYtaOXOIkdStzq/GXp2QcCGiQiPiYZXC9EqhTyCdZQFEUyknyCIM+HbdGYTOuBXNWAFshzmIWPO4UVj1klSA6pGTyFR0+eFRO+dhFbZLUXD4K4BG+ygELzow7/1FVxf073fwF5xqviLtoYLfBqVtx98KpFjGL/T6YkU0m5t420rUTioLGkNki3DZReTRptRvn4Yi7VGRV1gzLKCWwElDuOpxHYFe+kB91RE71a0J+dIUeYaEbn1g3tmkrI9tYZ1D26Mg2+7rFcgDM0ocQOJzO8oSw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(82950400001)(921008)(122000001)(38070700009)(86362001)(33656002)(7416002)(5660300002)(53546011)(9686003)(6506007)(7696005)(55016003)(107886003)(2906002)(10290500003)(478600001)(71200400001)(52536014)(8936002)(4326008)(8676002)(76116006)(66946007)(110136005)(316002)(66476007)(66446008)(64756008)(66556008)(38100700002)(83380400001)(26005)(41300700001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TWTpAznkSTSqrK7RhWe322rkSbTbysEUkCclSZrptARaqVceSx21AtfBzH36?=
 =?us-ascii?Q?SqSuwNuuMXgrfyPdyafc48AFWFC0Ht7O873xMY/AUobt+IyF6K6WIsBpA8DV?=
 =?us-ascii?Q?L/hsjXxapiGIzneMjdCnKYX5tDFcc9AZJIU4QhgQjXrkc8dLiZk288gQ6wIy?=
 =?us-ascii?Q?0DHVuxTx/2Yl1/gy+kn2oUxT0ki1Xn7rUTnEYEJsa+uk4y9YZV6CozuFztUP?=
 =?us-ascii?Q?wea+Fb/DNfIwrPyuDiUXPgUfsl5R675WDIzeQXgAcAFscMCu+V4H8EfPSka7?=
 =?us-ascii?Q?PrZqaDuL/GCWczkZpPVBc5Eq6Bq+2NSvGmd/m1oyA401PAB0QbEPXG6EjM/0?=
 =?us-ascii?Q?YL3zeg8c2U7s2qGyEgf8DDYv/LAciZq1hDe82G04OrbGPneQv/cGcIUpd2VY?=
 =?us-ascii?Q?+eencuRduWy3XSPMhpPv7EcIly6wt05GNErEMVUDcKG1yD9ZhaWfFM9Y3txJ?=
 =?us-ascii?Q?bEw5oGtiIU/tqDrRFZlEcnl8skp4VK9zpKv8ORg/RiZ2YYDXCdKQEaP6j2aw?=
 =?us-ascii?Q?ScAIOZBjuLodu4LR30fS+C4BO3CEqGfmPkXageIaaKdc5d8gxhvwC5UOneol?=
 =?us-ascii?Q?91ZXKrVSBI6pe77cJIxDlPcG4x+i7u5e9Ei7FlvGfNaxO8hQj9CR5qMRisUA?=
 =?us-ascii?Q?tgkHiniVriK/Z82kReog6KKWfRQNCA1ZOCvjbHwqvqkvTmpKU9o7L0pwE6Am?=
 =?us-ascii?Q?xZw6aBmLwkeQvU8wgQGXZnTmIwpJ03bNLMPKRZrsej4L1IwesL/MRE6qbSAG?=
 =?us-ascii?Q?cCrzvQDD+yEtZ3Oahy9yeyjy+L2Mfe70ZR6Lm2/izSmKJJ3hEpIpuimfsA3e?=
 =?us-ascii?Q?cRnl/We0V5is3ASjPdfBRPd3rKlOU+TeZ9c1yPw58r90kUmL3eRAlhF+C5gY?=
 =?us-ascii?Q?vcim6q3Pw+9SIUVg/HFZkpjLl2hO0qY4Xx/Xl8ikaD1qN4cL1Idi2DY/CuW9?=
 =?us-ascii?Q?3/POjvcLU1lQ5bwEnKDje5RXFA8gf3BzfbEjHvBMhsQ9bE7Gl3IfIMLkqfw+?=
 =?us-ascii?Q?YIsLW4t9XRnTVmNvBZfH7eUZy/WTD8qyfdQ/PO5An3DDW0mPpLXKx6eTOQ7H?=
 =?us-ascii?Q?I10C0N4NvQgDZO9xglnm87CI2MKccHrCF67kYL8BVtp85+hR1C9jIYYsSUKE?=
 =?us-ascii?Q?RMvey6wxz2Avjxrsj+kkQyNxI4hikzlwNJWdsuDjNgehGpoKPLyPZRoW1V7A?=
 =?us-ascii?Q?KnW4HK3K8Pwo4C5RlrP3ZzrjpzfLO+QNpM3AO5YgXMzjI3owMxa5shTpkWb/?=
 =?us-ascii?Q?CkuYd3l47P7DiWkR85E8zZUxRvYPq1dl80m2LYrneQXcA9F6Ug+7l/2ec1cu?=
 =?us-ascii?Q?kxNMXXsSsOHNh3PTBQJpibXle7VDjm5dWljFGKU2aJGxE0PD1T86yz3gtF/J?=
 =?us-ascii?Q?uJj4WCVdLLZWRbLdN7tzwXGhzqP8XNZB7GOh3tFpwCXwJloTWdGlC1h6TYVl?=
 =?us-ascii?Q?7ng749Lx2g7QOtgn1eE5H5UG8LAGHf0toJsTx2HRa3vCGcbU0cpw8VmeyQEu?=
 =?us-ascii?Q?OQJV6cTx6MLWOs3p4An0Ps9xu2yYM8nwOIyj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 59425e8e-4201-4567-9075-08dbe69621c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 11:21:08.8791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dX8Q2/iWBWPADFTjSktvAB5zYwjaMbd4LivtJuGI/dSqTiQwLPuxn2hkrauEGUhn/azvC2C3JL7BtZC6u4O9uGUwx3dyO1seT4cK0Yli8RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSP153MB1016



>-----Original Message-----
>From: Haiyang Zhang <haiyangz@microsoft.com>
>Sent: Thursday, November 16, 2023 4:25 AM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasa=
n
><kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
>davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; Long Li <longli@microsoft.com>;
>sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de; linu=
x-
>hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
>linux-rdma@vger.kernel.org
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
><paulros@microsoft.com>
>Subject: RE: [PATCH net-next] net: mana: Assigning IRQ affinity on HT core=
s
>
>
>
>> -----Original Message-----
>> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>> Sent: Wednesday, November 15, 2023 8:49 AM
>> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
>> sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de;
>> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
>> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
>> <paulros@microsoft.com>; Souradeep Chakrabarti
>> <schakrabarti@linux.microsoft.com>
>> Subject: [PATCH net-next] net: mana: Assigning IRQ affinity on HT
>> cores
>>
>> Existing MANA design assigns IRQ affinity to every sibling CPUs, which
>> causes IRQ coalescing and may reduce the network performance with RSS.
>>
>> Improve the performance by adhering the configuration for RSS, which
>> prioritise IRQ affinity on HT cores.
>>
>> Signed-off-by: Souradeep Chakrabarti
>> <schakrabarti@linux.microsoft.com>
>> ---
>>  .../net/ethernet/microsoft/mana/gdma_main.c   | 126 ++++++++++++++++-
>> -
>>  1 file changed, 117 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> index 6367de0c2c2e..839be819d46e 100644
>> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
>> @@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct
>> gdma_resource *r)
>>  	r->size =3D 0;
>>  }
>>
>> +static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t
>> **filter_mask_list)
>> +{
>> +	unsigned int core_count =3D 0, cpu;
>> +	cpumask_var_t *filter_mask_list_tmp;
>> +
>> +	BUG_ON(!filter_mask || !filter_mask_list);
>> +	filter_mask_list_tmp =3D *filter_mask_list;
>> +	cpumask_copy(*filter_mask, cpu_online_mask);
>> +	/* for each core create a cpumask lookup table,
>> +	 * which stores all the corresponding siblings
>> +	 */
>> +	for_each_cpu(cpu, *filter_mask) {
>> +
>> 	BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count],
>> GFP_KERNEL));
>> +		cpumask_or(filter_mask_list_tmp[core_count],
>> filter_mask_list_tmp[core_count],
>> +			   topology_sibling_cpumask(cpu));
>> +		cpumask_andnot(*filter_mask, *filter_mask,
>> topology_sibling_cpumask(cpu));
>> +		core_count++;
>> +	}
>> +}
>> +
>> +static int irq_setup(int *irqs, int nvec) {
>> +	cpumask_var_t filter_mask;
>> +	cpumask_var_t *filter_mask_list;
>> +	unsigned int cpu_first, cpu, irq_start, cores =3D 0;
>> +	int i, core_count =3D 0, numa_node, cpu_count =3D 0, err =3D 0;
>> +
>> +	BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));
>> +	cpus_read_lock();
>> +	cpumask_copy(filter_mask, cpu_online_mask);
>> +	/* count the number of cores
>> +	 */
>> +	for_each_cpu(cpu, filter_mask) {
>> +		cpumask_andnot(filter_mask, filter_mask,
>> topology_sibling_cpumask(cpu));
>> +		cores++;
>> +	}
>> +	filter_mask_list =3D kcalloc(cores, sizeof(cpumask_var_t), GFP_KERNEL)=
;
>> +	if (!filter_mask_list) {
>> +		err =3D -ENOMEM;
>> +		goto free_irq;
>> +	}
>> +	/* if number of cpus are equal to max_queues per port, then
>> +	 * one extra interrupt for the hardware channel communication.
>> +	 */
>> +	if (nvec - 1 =3D=3D num_online_cpus()) {
>> +		irq_start =3D 1;
>> +		cpu_first =3D cpumask_first(cpu_online_mask);
>> +		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
>> +	} else {
>> +		irq_start =3D 0;
>> +	}
>> +	/* reset the core_count and num_node to 0.
>> +	 */
>> +	core_count =3D 0;
>> +	numa_node =3D 0;
>
>Please start with gc->numa_node here. I know it's 0 for now. But the host =
will
>provide real numa node# close to the device in the future.
Thank you. Will take care of it in next version.
>
>Also, as we discussed, consider using the NUMA distance to select the next=
 numa
>node (in a separate patch).
>
>> +	cpu_mask_set(&filter_mask, &filter_mask_list);
>> +	/* for each interrupt find the cpu of a particular
>> +	 * sibling set and if it belongs to the specific numa
>> +	 * then assign irq to it and clear the cpu bit from
>> +	 * the corresponding sibling list from filter_mask_list.
>> +	 * Increase the cpu_count for that node.
>> +	 * Once all cpus for a numa node is assigned, then
>> +	 * move to different numa node and continue the same.
>> +	 */
>> +	for (i =3D irq_start; i < nvec; ) {
>> +		cpu_first =3D cpumask_first(filter_mask_list[core_count]);
>> +		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=3D
>> numa_node) {
>> +			irq_set_affinity_and_hint(irqs[i],
>> cpumask_of(cpu_first));
>> +			cpumask_clear_cpu(cpu_first,
>> filter_mask_list[core_count]);
>> +			cpu_count =3D cpu_count + 1;
>> +			i =3D i + 1;
>> +			/* checking if all the cpus are used from the
>> +			 * particular node.
>> +			 */
>> +			if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
>> +				numa_node =3D numa_node + 1;
>> +				if (numa_node =3D=3D num_online_nodes()) {
>> +					cpu_mask_set(&filter_mask,
>> &filter_mask_list);
>> +					numa_node =3D 0;
>Ditto.
>
>Other things look good to me.
>
>Thanks,
>- Haiyang


