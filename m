Return-Path: <linux-hyperv+bounces-967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100477ED7AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B52B20A82
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F543ABE;
	Wed, 15 Nov 2023 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NCyWi7nT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BB98;
	Wed, 15 Nov 2023 14:54:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxrNiYDCP4XPiEnovb0bDa+CloYdGfGnZaYfB11PIvGD67LPrn36E5Vgu2B+f0o0/nYhcVi+ZHPsEeE3n0nPne3ebRU1rCd8hwuVkk7ZvzXQ1eG/Jkwap11wSp0zttaVwkSv/jWOwtm2mu9OliCX4+xXFZWVWX1LgOWuqLbExsmvr8CIe+ltM6HueT0T9a56Ddvq8NtOjA5mV546BKAXK2QfLKxTAHpAl+7AldtrJwO6qNzDT2nAoXBje0bdw0BRagQp2zqW9BXXLELoJ+CetqAaIK7XJsQKy3cn7yofvhxcTpioXg740qe42g4EhHM/bBygO9hQW3N5o77KyLcpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsLW6IMN27WJtdkww9NANDuyRTZ+9oRmdSdB+A3hXg8=;
 b=NN8vR1XIjOBn0V1BDKsxc+EP8ZXxPHEA7GzKb5ZXTBsWd/nUz1TXI44M3sRCTs2f2WUIpItcV44CkZIdrsJVoIEpfQ1hTVOu4KeF4Gq3wT6aH+UtY4EABVH1ctsw03kLiQyTUkLcgeRIZAJBkX+Zo5l+hSqhRi3MkpU6CfqgY3TmOOEEc37+Qv60bycCG0nrSaKZM3QDgNJurwFKqLi1LfrHyxRHPYC7/hD1UJRSOSZMzXkM6sJEqgCBvsK3lW09VxM5GKdjsLh5RsYcmeK404kcdGgTClcTYL8IV0t6ZH8ozD5JFqs7jZfRn/i6+3QcoWzMPe91bZgOtN+rC6sFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsLW6IMN27WJtdkww9NANDuyRTZ+9oRmdSdB+A3hXg8=;
 b=NCyWi7nTxju10+SQUDXfL/IQdh/Qa6YE/Xb2UEMKJApp3b+sfS/MVdIjWQXpw5mPaTRW6fxZSUxDzt3R65SZILBeFo6OeWBoc2R/WMyB6yA5VcouymJ638PsiZMO7BDy17P2vfsgjjrWydCQcUjpEQYjccgD26vjCkPfV8jME9Q=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by PH0PR21MB1992.namprd21.prod.outlook.com (2603:10b6:510:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.6; Wed, 15 Nov
 2023 22:54:45 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::69ce:6d51:2dff:5d21]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::69ce:6d51:2dff:5d21%3]) with mapi id 15.20.7025.007; Wed, 15 Nov 2023
 22:54:45 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
	<longli@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>, Paul Rosswurm
	<paulros@microsoft.com>
Subject: RE: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Topic: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Thread-Index: AQHaF8qAMga1sUoXhUG/ODoPyLEMMrB7+UnQ
Date: Wed, 15 Nov 2023 22:54:44 +0000
Message-ID:
 <PH7PR21MB311687F4F37C55D6B332D7F0CAB1A@PH7PR21MB3116.namprd21.prod.outlook.com>
References:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To:
 <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a89832be-4a0a-4c6b-aea1-8812e4a22e64;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-15T22:38:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|PH0PR21MB1992:EE_
x-ms-office365-filtering-correlation-id: 408af7f9-8c1a-41c8-e257-08dbe62ddc32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yFRkGmLL+CjHt5LCvAaRj2sZw67vfEmjV8WokYtIFd2nrZEZHEgDs4soswyElQwZCifTdOEfb9KvH8bim1m7DV4pbUCkI1PLJuzlCZ4+Y0jwnR7XQp9M6SOQpcNO7v6f+OEptDuCk74yvh8IKVUnms/k82ERw0d5c5PS1i3/1oy/0hfTG6hDIjWi5jEL1KFC2h8iDTjXSnyUDgy/HJIIk2TTnLF2fjInsijLTzO2jVNG/+O84gpkxPespb0FH4RtR5PwXIaCben+IlMpwqRjoO71mDgdmqdMMTgaA4X5Bm5jd13K9uXqA0uizCL7fPqscrdRsqFYq0g4Kl4yA/h+RY98sP60iWLO8LKef3KeUV/XwHnf+KTF0tdBzFBs+yTd3LfRjVEJOIDtRpgVoh5Z//PNWJUEYq2PIsKvFpvbTn6H0ssmwY9Qmmf/3aKy7Pu+g5bFcWnk5yM4cKTv3w8k8tIGuSalTrjq1ET0g4IS4m3np1mtVP54z2qXmLFsoqox/mG0tiSNhqOLM/6K8rDtLDLwv8KjL7mUTHtLMS5TgtkkriUACUj9CFSJrtWgWeYfHSM4/Ve0l4Mpmfsr/F0U6IiKBVVpyJqRaZJlDmiJvSPm3xjqSjlZjtSayis54i2qoo0/CZ4kSU/JS/h2edNHfqqBNoZgMYboYMJRr6DPq4i+yy7r10QbU9Lzjz5OnLdS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(55016003)(38100700002)(83380400001)(7416002)(122000001)(5660300002)(33656002)(2906002)(86362001)(921008)(9686003)(82950400001)(53546011)(82960400001)(6506007)(107886003)(26005)(7696005)(64756008)(478600001)(66556008)(71200400001)(8990500004)(41300700001)(54906003)(4326008)(110136005)(76116006)(8936002)(52536014)(66946007)(316002)(66476007)(66446008)(10290500003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZcH5gvyhZenO+1obC3tZGob/hYg00pZIyd9sRx9Cs5ffe7zqe4e/GbkA8d36?=
 =?us-ascii?Q?QwHQNFJKd7GGo8dvbrdQZJBdVA0SCOUPShCBZ7FI/W3FA/8AU/R6fDqUIhRF?=
 =?us-ascii?Q?s9nSCd3T8enWO34/Gg0NdijhNMG0bk6t/0B6X0NwIpJ1vwegI65QTWlWOOch?=
 =?us-ascii?Q?OlwMMm0z/mBOa4W3NrmJ2G2LTisCnCNlBGRe6ek9Kr95Sgljrm+dgHYwnQtG?=
 =?us-ascii?Q?sDRLRPI0XslLITAGdM13VgAewK+I0PcKIm+yfAzzQVanLpJ+zecKiGNGs4aB?=
 =?us-ascii?Q?+vu+4U3NxFGgNSGUcL8B/+B7nZeuHGm97TQYlyv/a6Gvxdne1VscBB6uJf93?=
 =?us-ascii?Q?rWwicyzfUK81GJdNmYQ58U0yJiIccQ8h7RvBOli4KL7pSuPZR9ccmvry/bFo?=
 =?us-ascii?Q?E8NxTNT4Yasv/onxzIYtrkFdhGyyks51LV7JkYsb5bwfKe32taGCZ+RlYLlf?=
 =?us-ascii?Q?a3Cdh5TbWZZi26SJalqS3f7wZQnBPSyWS5OlKNMsqHkTwi/PIBvchbTBQoPc?=
 =?us-ascii?Q?82y7ZkkpOWMz7OS84JCoNykJV0SobDUFn3VDqnno8aSVfmTSZFi4NH5O2FiZ?=
 =?us-ascii?Q?9BS3afSDQoYlO2XjZ+W6KrHtIszeG1R0d3geYTNTU6WIl1Bq7FgGw8GbhH3j?=
 =?us-ascii?Q?kzK7vEF+7/PieY0bJ6/TEeWcXR6sjmzUB8VKTfqglLhFYM/JltmuJndMIsvO?=
 =?us-ascii?Q?bgob2/kzMcoInyUfAt/bUmDhg/N+DUrty+wN2R/mU7UHf8m6fH6EP0WfIsmt?=
 =?us-ascii?Q?W8+D+ng6B5ah+0gxg8/8wN33CaAlOtQqCoKbDsYCw4uMlZBydKDIZNUXMf24?=
 =?us-ascii?Q?Rd8gtmi/GV2ntOpmRCxGZgpv6u+YxajVJVo1oBkBYZ5Av6/VlmJoF+safAdE?=
 =?us-ascii?Q?us0HpMGr2UuKQdfD6jyifx1GM5R7Thrh6yCI66I3o8YNyiRotz0MoAFwbt2w?=
 =?us-ascii?Q?wRehS0e0GMPD/EZYqhG2SnpseKOmfVuj5e0fCqURu1s4GD3E1rsrgGQUD3hE?=
 =?us-ascii?Q?wkzbCVjb1IDnaCJfC5UjOyuw84QvfVLNPZuFqQuBVSX7el1Q5Doj/E33/dPr?=
 =?us-ascii?Q?44e1W7p1Os6C8CVTBFNdIxKjpSkdaPPDjSJvQ/tvo16/65lYoVijTPZCAqH8?=
 =?us-ascii?Q?3eyCMoXdR9Put8Kb3u0mmxNLGgybf+E9kuMau0V7ApGSgnVim5e0SxdMr7Ps?=
 =?us-ascii?Q?w90fqwG65OSf1JwQRMlD6iccKSNoBBSR/nfBpV8Ou20rqErauqWeorDzZX9H?=
 =?us-ascii?Q?JZwjf+FQ3+Tm6VO2gYSVeqNguUGIC86HA+ln7ZTUOwyciRndlu1wSrJvgLCi?=
 =?us-ascii?Q?uHvgFEjcfzwTGmbn1u7xlRYXGpHDtpiNx24wRwoXim2i9AM0vF9HQ0NPx4PA?=
 =?us-ascii?Q?GgpE2hHemh55JF8qRHImuOvu9TB8XDzofoi7gMz4PwsWQqpY1USMxr51uevR?=
 =?us-ascii?Q?Lpu0e8Cz3Tuwd3eseNSznndP92wsoSezZumMDluy1bZhB/M4KM2v/9M4ryQG?=
 =?us-ascii?Q?B2rixkBK0HEvB3bJil4lPgKuGyqE4NTaT+f6BjI0BBNQ99465eRU0hWt8mJl?=
 =?us-ascii?Q?xE03N1HaHNukq+p74K15MZgFAqUZsoN04gaUe5LX?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408af7f9-8c1a-41c8-e257-08dbe62ddc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 22:54:44.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+97569vHhEFLl7RlI8TQ8elQV3fHalqWXZc7ixrNjNJVU85T92oXwrn8/Jz06NOVR0IIkEJpr/XHv4M9bO3RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1992



> -----Original Message-----
> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Sent: Wednesday, November 15, 2023 8:49 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>;
> sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
> ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de;
> linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rdma@vger.kernel.org
> Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
> <paulros@microsoft.com>; Souradeep Chakrabarti
> <schakrabarti@linux.microsoft.com>
> Subject: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
>=20
> Existing MANA design assigns IRQ affinity to every sibling CPUs, which ca=
uses
> IRQ coalescing and may reduce the network performance with RSS.
>=20
> Improve the performance by adhering the configuration for RSS, which
> prioritise
> IRQ affinity on HT cores.
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
> +	filter_mask_list_tmp =3D *filter_mask_list;
> +	cpumask_copy(*filter_mask, cpu_online_mask);
> +	/* for each core create a cpumask lookup table,
> +	 * which stores all the corresponding siblings
> +	 */
> +	for_each_cpu(cpu, *filter_mask) {
> +
> 	BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count],
> GFP_KERNEL));
> +		cpumask_or(filter_mask_list_tmp[core_count],
> filter_mask_list_tmp[core_count],
> +			   topology_sibling_cpumask(cpu));
> +		cpumask_andnot(*filter_mask, *filter_mask,
> topology_sibling_cpumask(cpu));
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
> +	cpus_read_lock();
> +	cpumask_copy(filter_mask, cpu_online_mask);
> +	/* count the number of cores
> +	 */
> +	for_each_cpu(cpu, filter_mask) {
> +		cpumask_andnot(filter_mask, filter_mask,
> topology_sibling_cpumask(cpu));
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

Please start with gc->numa_node here. I know it's 0 for now. But the host=20
will provide real numa node# close to the device in the future.

Also, as we discussed, consider using the NUMA distance to select the next
numa node (in a separate patch).

> +	cpu_mask_set(&filter_mask, &filter_mask_list);
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
> +		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) =3D=3D
> numa_node) {
> +			irq_set_affinity_and_hint(irqs[i],
> cpumask_of(cpu_first));
> +			cpumask_clear_cpu(cpu_first,
> filter_mask_list[core_count]);
> +			cpu_count =3D cpu_count + 1;
> +			i =3D i + 1;
> +			/* checking if all the cpus are used from the
> +			 * particular node.
> +			 */
> +			if (cpu_count =3D=3D nr_cpus_node(numa_node)) {
> +				numa_node =3D numa_node + 1;
> +				if (numa_node =3D=3D num_online_nodes()) {
> +					cpu_mask_set(&filter_mask,
> &filter_mask_list);
> +					numa_node =3D 0;
Ditto.

Other things look good to me.

Thanks,
- Haiyang


