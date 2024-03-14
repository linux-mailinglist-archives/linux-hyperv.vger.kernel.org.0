Return-Path: <linux-hyperv+bounces-1759-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0BA87C316
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 19:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4C3B208F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA274E09;
	Thu, 14 Mar 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M/oIYpZ0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFA71750;
	Thu, 14 Mar 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442478; cv=fail; b=aCMdjqk8/6s7VzNACAsBpsUdUhkr8OesHpOldLF13Q/gmXUgjH5JJjb2dGB/7tOJHYkKGlwJwzpQ36nRvS7yKjYN6ylZSDHm8pGOAHoPaLgHX5MaBwhtAE1vRpRgJstqa8wnhH+gsBsghdKWVKJfdA4+Ai6ZQSrj95fH9Zt361U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442478; c=relaxed/simple;
	bh=uxEXH78/18V5kL9JD1lSPtv1bUEi+pcHlaILTxzqyy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERwQWjhtmo5COnUOfEYNeCtcqu3Tl5UBLDDIljwEF5EDK5HXGDiv4UxIUnfVXAse0+hoVQxJE0V75D/hAjA6APeICtXb9+HxC4opAG2li9sUa/gYgFW010Mvgx/8VT+cqZ/evkT1BmCC/Ud6kwZ68iLQNiXSxcb0/5YLoRB2lsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=M/oIYpZ0; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNoQ2J9EdFEI5J0tScVDTHfOxvEybXSz2QC+kgjYGwUSBNVukIcMi+wJdWjfZr/XnOQH5COhpn26BJy5ytXVWdc/dzPNwv3DnSayNDFxA9eNFxduYR/WwNbfPHWoidAof3uX5UT3Yxjb3/biVF15VUxQFkCar3/TfQOKiXPfMpbEDpoo+IsD8/2nSst+LZ0NSDApuJ1mDV4bd0V3/I8m9nEsYKM0wPHMV/W7aEKIemxwyj0tFElOWy1lEzGFP6g3Y17eW5pLriQjaGHgaY2OSBtonWvvGIVZtEr9Otm0BVwM/gcLLtZ5BUuZ7nR88cMKszSu7DSk402otllItviusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys9OWAcOuFDdUJvKoGvc6h3LyTCEy4rk0vQM9SSD7Y4=;
 b=Rdwcd0hCmGQn8L/YPVDGcl9wuDJoPZ3wIRP5Ei7TzeuncpOjkfWbzTWhnY/Fvk8zclE3XFS7/KyNdopnMKsJ47aAKMcwwKoLNHzwrt+U3HLvxG1340HX6LT1f54P4IhD6rsWq6ngfGPkWM5xHWoOo5aDWE2o3wO7tLihwTEA9DfVPpvU6fnjET2TiZtFmtfpMvIJ40pRKrTPGIp3xbD65K5+yLFSrvdblLaQYAwe8qnrnRmLcmTx+4Ij6i0tk8xHNaucuikAMhsEDDYqpI+R0kdWuHnhpVgPl09D2n0ft0oZJfa2b8IkLOtzv8hODHtf9sEdNPtsqvYveDFDJm/tWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys9OWAcOuFDdUJvKoGvc6h3LyTCEy4rk0vQM9SSD7Y4=;
 b=M/oIYpZ0qCRrMNFrTDoV49ozwVvwXnjO47DmJP4w1A8qqb+wzt/oQs4QsaZTPDVFyr2b+vGXo51SZx1xEf9675N9XUV1zRa7RxwlYcIR1DALlRz6IapbZbxFJXohKCm+VHlvcyBiIyjfs12COAdSanwpDWzaOXjpUh7O2+SMK0w=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 LV2PR21MB3372.namprd21.prod.outlook.com (2603:10b6:408:14e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.5; Thu, 14 Mar
 2024 18:54:32 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::2faa:c71c:55d9:6792]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::2faa:c71c:55d9:6792%5]) with mapi id 15.20.7409.007; Thu, 14 Mar 2024
 18:54:32 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
CC: Shradha Gupta <shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, Alireza
 Dabagh <alid@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Index:
 AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsZziAgAADR7CAABaHgIABr8IAgAAJ9wCAA7q6AIAEn/IAgAED5wCAAAUH8A==
Date: Thu, 14 Mar 2024 18:54:31 +0000
Message-ID:
 <DM6PR21MB14819A8CDB1431EBF88216ABCA292@DM6PR21MB1481.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240314112734.5f1c9f7e@kernel.org>
In-Reply-To: <20240314112734.5f1c9f7e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bb4edda4-4af1-4b15-849c-2e3e398058d1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-14T18:45:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|LV2PR21MB3372:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A4t634CTNYeHqrNhRoy3kolYbO+BEPvFcQ8pIRAdwkMAfghg28fuHb8x4XnMlApsEp6vn9gDPG7O0c4mREiSioLlNcys/MTBLD4jpwVMPjHZEP79/zHA1s3j1L33q65sU5U8/tHM/ZHzkww8PH5CUt9rm2uAL5AzCifUYniIdlK2hMUIFOaHJslOO51kNcJ5ByljrPe4rPbjixoVdGl334FO7UxdHLy8TntMmtKkd+YyuWS0zQaded5jZnwr4SSp2A3R4KBUrGL1+VqkKcn7eRqY2/K/9kNcX8yBB46Wxc1REepNfwto41dEDIMf9EkoYtWAbpgyxgDqsv/K0vfZcCB/zvQ0yDEMVgv048jBx/mkrErQSI+Z+uJ9qrgxpe9NHI8XSsVXOsw7kb8MKBnBYCjKyB5l0qWeTyj8Zfh10/WJzYv9iAx9mhoLNcDVfYIbKUshyuNuiBX8Ieeh8n22yYS+DRzqJA/fX6iUD1++vqFbKZ2NbtXpEVe5fLmB6hkgVmY3oUNfpYSumNussvS93hhjQ3fCiAN13cW+nJJsjCxIjHQnsHVLAYnIqEyznU2I+d7OIh2v9zcvslWk56T6ta1CpRbbBSysjah5comcw2SFfyC//SSuak3ZxzGHRGeVh9eBhf01jeendtxursmI8JYyBYgwtzvBALkmSV6CgQQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GCwL7k7Ohjx7EnicFYpWDSUDNQj/oTvssEenpBpbFIhfO+5RYAC6DknWs4w8?=
 =?us-ascii?Q?D0mB8cKCUvxGqbIayDxKjFq272ME9Hgz3MwtOLcx3QLbEg4FJvG8iYBedTue?=
 =?us-ascii?Q?VYPwYmbMISfTkv409aBBSOlX6PeclPAmfu8Ir0BqAlKnNa9Ugj5zsvIKjTcW?=
 =?us-ascii?Q?M5/bXW8ASTafhPDLUNLa0zjYawcu9xdE0vJ7U+dGz2HgJW9ljhirhnAckdD4?=
 =?us-ascii?Q?grVzCkOc+JPAb1cRY6W7JFnQtEyEgGbB0DDf+SE5yUh4Xa00APgiUU3oQ3vG?=
 =?us-ascii?Q?hbqlMUTLylR00KUiArFBdmf4MLuFb8VfF1x/mGmTmxWwmkiJEJhf+3Oruq7T?=
 =?us-ascii?Q?pBUNsWvi6x421Q24DJzDtYErdVJ6DkjJkU3MLNpN888Iwe3NSCEpjLp9NbKA?=
 =?us-ascii?Q?iN1nLlH45dwbxG2b/XmKL4aKVoqZRYIfXypaToBh3IvDE1BnYwu6+icOp40y?=
 =?us-ascii?Q?G7vrgYzZ2beb9TulBUuvxYEmoafelfKG46Eu1Rnxal6SYN6zuymzZ5HYklHs?=
 =?us-ascii?Q?ckCN5X82k5R2H64+kxLrMdyu1u834vdr+m7qeYeYLsmQnjkW8u5IyBzG4Mqf?=
 =?us-ascii?Q?t/dlci1VxIjHqmKETYPGTAHOfXDSQ51HP+gmG5YeT8FeodklZ5AbY+/RBtu5?=
 =?us-ascii?Q?LICXbNdo8C4ElXUpPq9fictTRAuujqw7i+kDNPBlNNjzuK+Q19fiDcZHg7Fg?=
 =?us-ascii?Q?+uYLtxytbmBoQqMRjr3Q3IS2xMbjN4Hd/gFJkjrRyw2W2bMadCksWUbmYEFX?=
 =?us-ascii?Q?TIpKYxT65OMBZOR38X7uPcigOBBPQ1Ls3RXx2GmauirZJ/praJPBMeTzGfLS?=
 =?us-ascii?Q?0RrNcjF9fuGaKSZwUlWyazNnI0jVCjpRSG9oVFWIHMP4Ar6bH01q6dnDoq8P?=
 =?us-ascii?Q?L/k3FeX0EedHlCfby7VCpNefpelWUoHQvkgQviDOvdFr+r/+XB7TveUxd6Xn?=
 =?us-ascii?Q?frdC21TUD/LrZEOVDLyAn3WMDeU3crvJz5Q0gqIL5OQxRGE+itboQ0nRxG2l?=
 =?us-ascii?Q?QeU+y6mC7WH03tiKXGYbatBXaWd45W7yZEatqC1luIwssJKR4AvgpAIkHuyK?=
 =?us-ascii?Q?oo87usiEYJ7F/YAJyUFEMnoBUpq1T6noWJpbfOZ2Yd4uNMb2dinj5gqk401U?=
 =?us-ascii?Q?jeVXQD4vQ08pBZcndkvyHON0MZ8Mh4r4Q9wga9V8TDR1JLAYEha+qNi4eBYZ?=
 =?us-ascii?Q?zs4zmmduAUDro/MowuqZ/MTOpta3JqmUhcCvBczh8bgOFChxVDS8+0SMt+sP?=
 =?us-ascii?Q?YWib6VLMF+3EWwKmN+cp5X88bnvJZ0myeLCgIzpyt403Q3VqCZJGEs9ZSylI?=
 =?us-ascii?Q?CxYOYfB6hNj+7qmRvWL6ghO7FtwciS1b2jTNVrpTczZ6blA12+ZRZHN3in6p?=
 =?us-ascii?Q?95Ss3IvrNGHv4cND3Evk+wtAFD1zsXQVMVyEWaX91rNxD0sLSYxWjeAR4RRp?=
 =?us-ascii?Q?fGKcRQk/ZRf4/hBz/ZXRsy5oGNfDYREcMIrNXQSHW8ZrHHwQoF7u+qT8HHSa?=
 =?us-ascii?Q?pdtwQbBY2xut+pQJwAAx5OfiQgTwWE0iXpLKTEdFdsCmO1Bl5Q51Z4f5WHaN?=
 =?us-ascii?Q?3W7PegiB9eJiJPPpo/TsA9D3S6MMSmONAnYBNkmu?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed0af63-2708-4175-9dc0-08dc44582f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 18:54:31.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gnjieGETaXlCuVK8A1d3ghydRZE2JBtwM7yfyFAestRXw6VcPodL+xGBnFCSimw15RTu8qbQC+fOOE5pHHi9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3372



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, March 14, 2024 2:28 PM
> To: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Shradha Gupta
> <shradhagupta@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-rdma@vger.kernel.org;
> netdev@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Paolo Abeni
> <pabeni@redhat.com>; Ajay Sharma <sharmaajay@microsoft.com>; Leon
> Romanovsky <leon@kernel.org>; Thomas Gleixner <tglx@linutronix.de>;
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>; KY Srinivasan
> <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
>=20
> On Wed, 13 Mar 2024 19:57:20 -0700 Shradha Gupta wrote:
> > Default interrupts affinity for each queue:
> >
> >  25:          1        103          0    2989138  Hyper-V PCIe MSI
> 4138200989697-edge      mana_q0@pci:7870:00:00.0
> >  26:          0          1    4005360          0  Hyper-V PCIe MSI
> 4138200989698-edge      mana_q1@pci:7870:00:00.0
> >  27:          0          0          1    2997584  Hyper-V PCIe MSI
> 4138200989699-edge      mana_q2@pci:7870:00:00.0
> >  28:    3565461          0          0          1  Hyper-V PCIe MSI
> 4138200989700-edge      mana_q3
> > @pci:7870:00:00.0
> >
> > As seen the CPU-queue mapping is not 1:1, Queue 0 and Queue 2 are both
> mapped
> > to cpu3. From this knowledge we can figure out the total RX stats
> processed by
> > each CPU by adding the values of mana_q0 and mana_q2 stats for cpu3.
> But if
> > this data changes dynamically using irqbalance or smp_affinity file
> edits, the
> > above assumption fails.
> >
> > Interrupt affinity for mana_q2 changes and the affinity table looks as
> follows
> >  25:          1        103          0    3038084  Hyper-V PCIe MSI
> 4138200989697-edge      mana_q0@pci:7870:00:00.0
> >  26:          0          1    4012447          0  Hyper-V PCIe MSI
> 4138200989698-edge      mana_q1@pci:7870:00:00.0
> >  27:     157181         10          1    3007990  Hyper-V PCIe MSI
> 4138200989699-edge      mana_q2@pci:7870:00:00.0
> >  28:    3593858          0          0          1  Hyper-V PCIe MSI
> 4138200989700-edge      mana_q3@pci:7870:00:00.0
> >
> > And during this time we might end up calculating the per-CPU stats
> incorrectly,
> > messing up the understanding of CPU usage by MANA driver that is
> consumed by
> > monitoring services.
>=20
> Like Stephen said, forget about irqbalance for networking.
>=20
> Assume that the IRQs are affinitized and XPS set, correctly.
>=20
> Now, presumably you can use your pcpu stats to "trade queues",
> e.g. 4 CPUs / 4 queues, if CPU 0 insists on using queue 1
> instead of queue 0, you can swap the 0 <> 1 assignment.
> That's just an example of an "algorithm", maybe you have other
> use cases. But if the problem is "user runs broken irqbalance"
> the solution is not in the kernel...

We understand irqbalance may be a "bad idea", and recommended some=20
customers to disable it when having problems with it... But it's=20
still enabled by default, and we cannot let all distro vendors=20
and custom image makers to disable the irqbalance. So, our host-
networking team is eager to have per-CPU stats for analyzing CPU=20
usage related to irqbalance or other issues.

Thanks,
- Haiyang


