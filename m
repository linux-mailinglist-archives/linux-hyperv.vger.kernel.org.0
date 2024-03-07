Return-Path: <linux-hyperv+bounces-1673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ED68753AA
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A7C1F24984
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795F212F399;
	Thu,  7 Mar 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hb7aOiSW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284941C65;
	Thu,  7 Mar 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826560; cv=fail; b=tTj7ENgPhUuIOdygHkm1X1CQjb2ejRo7gZCIuHM0jWdftKT7Sy+UoMhpxvEgeSPccDQp8gqaoInLbUvKODGHEhOaEqjSflJqlbo+TIJ4wa7jhOKBiZrv4N7yp0W+POFuH6D59p2m8u+8OOl4F37X6YY81Zi80PhcWEdIlXzIA6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826560; c=relaxed/simple;
	bh=P7P7aJndn7bMBEPjEeBbHl7wgiBdnvYg2oHRH8FUAjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrdrzyFR2OYpW14bPFeMy6sI5yCTU61YtUZbvQAGe7RJzkXkwj9WsxP7Qp2vLDHI9c7jxLEjefWDsH4htajlb7S+46AAqVHxh+KnwJINlFIrccOXF/0Zw+naQH8MFolbSeXC2ffjTQZCmmy6J7dHqGYn07xUmw0uOiad4C3lJM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Hb7aOiSW; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrwkSkA8r8oagn9QHjzeUuIYQanWCP74I6u0rOXRrfhN7D7JL44UO1NXoCdqZjKLECPnX4V4lpWVTp77m6HU64RWPWOWlcBHnqEk7qV35TCxroD+A7S5FrsttS6lHw3fGxKQeqUSvPOjZvqLXlSVr7rr0VKP0a4azdYoHa0kILqG8F+/oOfgaRH7+2pofrgpe63yUgp59sh445z80hMdgvScmIRfMDUiWJOvNK0Lg7jNMS84BXub2YNeUAgldkq96UWicZOPD2r2BDyIzwAFHRVpFgEcK+fezqNqAT/2D9LUqF9QOOgLYvSFzy46QiG9OlJfBOq8Jn/zYv8WWwPBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2Knrg4ySQcnYuGt/1FutYkCANFRdy7v8W1XvCNNA/g=;
 b=hhNW1/mldpAQMDiE2nI0cgNduQ2CAVSeDLO0RDEuMf3hO0Y2bTtq0VlJztHzZHtPHEcGMxt4xwhYynyPODC/F0V4birXw4E6cRQp8wYbBlY0zkGu2JiY4vYKdOmp6yjVCdJnkQ8fsRwXyFNtSHDzDlo1OkbKdvOJN5X3c5xUJVcBADhKgSJ7VXgFkoP+JrzzbifmcOjh1i5tkwn1lfXIEQYVqwxlCwuYg57rbgskmyWefrm0XHhAIfnKrdb/emTIVczg02inI6/d2N41iZTw5w3dY2riZJONGokWv4qN9BuNw59Y6kIPHyfsFjtvtylaMTiRsv1PouYAeXqssCsXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2Knrg4ySQcnYuGt/1FutYkCANFRdy7v8W1XvCNNA/g=;
 b=Hb7aOiSWlX/cui2jzyhb8lsyXtueTZRjGAvd6e8TFubSb0FQFrmek6UITUrl07n8fGO0MIqlcYpRqiEgzISbNU8ze+eZqYaGEI0GIMJXSAB/AAFmOWtL1B1nqPGLba2ibApPzxDXxRjQqYVfjKmhV8/7izgXbFRT2O6f5NkXcQg=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 DM4PR21MB3539.namprd21.prod.outlook.com (2603:10b6:8:a1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.8; Thu, 7 Mar 2024 15:49:15 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e352:f8b9:4805:c9da]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::e352:f8b9:4805:c9da%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 15:49:15 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
	<sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Topic: [PATCH] net :mana : Add per-cpu stats for MANA device
Thread-Index: AQHacJ8N8LLwvYYKc0y/h+tCzJvDjrEsZziAgAADR7A=
Date: Thu, 7 Mar 2024 15:49:15 +0000
Message-ID:
 <DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
References:
 <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240307072923.6cc8a2ba@kernel.org>
In-Reply-To: <20240307072923.6cc8a2ba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shradhagupta@microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60ca9008-496c-4f0f-954c-124078107146;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-07T15:41:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|DM4PR21MB3539:EE_
x-ms-office365-filtering-correlation-id: 910a61b8-2a1d-4b3c-65d8-08dc3ebe2477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rZXGHgnGXVA07MpPpYoksNhNjSLM4zd2IvlZV6PH33GlahbHxVNjP6HNUH+oXkUvJCkfECBml4f1jvQav58oOpEd05NxGLWHg1gSpZFILktLOyICqCYl3ZqdVGfS9c3FwSr5IFgHVRkX8Q9bVXvxvn0w2+f4OtuNcTNDloSGNoeTq8EmU0GCkBC2PkAh5J/KVZRuquo6eFappHZty9Ro0TLCExT2EYEvkGJh4LWWzlDo8RQOBrVrMgj/KawqqCbPfyvBnW+z343d2ZH0KwE1F7RkavbYyZZ7zmgJ36wPZIS7yNsNv22mjZ5IIaol5nlRrZnKXlT+AwSzVPr8hR2Qct23Rdi3K+sqUMRjE2dFksgSjLG5yMNP2RxFa/NeGtSYxX2OsMovfYck0I6WOxawfH4ch9oskVoMGuZf0K2kstatVtFvXtw5tuutV4ri7GdnXDQRzGfy+130dBFtT9xcIXVv5Oz0o/bo/J6uB+bzKmFNnJy07SxV1BDJOejStHlT42mdg4Q7TiqWvM9JBdhZPNR1d+o/El+p/o8Jg+1rVd55LOzEO5XJ6ueWe3GZagGsW9MzaCFleGF/HP5RSQiA590NRIgVEsSp9TogG+kCm+Bx1Ny1IIms9LPDw2San9LHTDBNhXPqg74d9++6BEBEVaVodjiu4rW0FJj+/oeNjALAXPgAewbpw1hE8Z9P+/512P4eZrCkceezdnAI35EIKzglh8nCAN0LdfKmzJx2isw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YHxooy0H/AMpMuYcCHtaejpEz7Ec4c2NGfjrhFyGOF7/Qjg9vvCRw0cexFS+?=
 =?us-ascii?Q?YM7KhR6HLN3NH8k8O6TQaDgoM3s2IEStkpO11l2oQWi+BOMAwtAKuKNtGiRZ?=
 =?us-ascii?Q?0NLq7ky1z7s8q+KciEBm7RMTL0GUzgPVXQ5/TPUKu9ap6lhrtAwGHVT3EP/U?=
 =?us-ascii?Q?hbbbjownjGZPfI35n9p806seC2i/hTjV98Ten5yVgUTmSmhnlqL+34Qbn5XP?=
 =?us-ascii?Q?5mgst92ffknRRIgt1ya8s030AFD6kVIUPaDkEn/KZv38Db8fgJj6W6YluCP2?=
 =?us-ascii?Q?J9+Kwm9DZ/E2ZGkjpFLrv4Z6rfFOtx9OXQEd5HbzjWY6HHkMCAU24ZxwrS62?=
 =?us-ascii?Q?cEWrsNYpLIhj4yJ58sEREMrxCRFkzb2kSyhRVNslb0zbVtQBGr4L6hHQvVS4?=
 =?us-ascii?Q?sNCOgQUDRJQhQ8LlwYhGfpuS7Im6ZddPALy1iRSYP8iOUciq2uYEw0KZfmDu?=
 =?us-ascii?Q?ZOS9UNiZomgy8hB7kJ2SfV/IZl9SpcUR2j22c4T1cqah/gH1KpUeW37c2zSZ?=
 =?us-ascii?Q?o8+DEerCypGdRtn2aMOPLDSSGy+3VuJZfDgMEUkZyz1dfHdyMese0LcZpQ6/?=
 =?us-ascii?Q?EGDIBBY78juJdzQewPuveJgryrtKvwMmm7VlNJEYvTU/w9onVKssjFhV83E1?=
 =?us-ascii?Q?g7bC9+NWhmGZY0Et5EPyaMJRu6RRRDTvO6G3+/h7qNHeynqFGkuf2+OiYDv4?=
 =?us-ascii?Q?HH0TLkwPHCj4WekFglEJaJqytUB5YtVU8R/x2siUN0YF7SgPUUI7AAk1/2sP?=
 =?us-ascii?Q?f5sErPgF2ZVwTXYEHCIAK+8FGG4vBswly64+g4gwi9e5g7x7oaREL0bKDpIA?=
 =?us-ascii?Q?XiQBkA3ZGIOrccc/Wb9QVCI2dVhHJAgwKvKuoPwmp0k4MG1XUgfTJaaIKXaR?=
 =?us-ascii?Q?MmRkR19PSOKv/y5oC7sWShss1y2jM8JDl+1Sj0ManP4y97K3vy/lQU2gcY3+?=
 =?us-ascii?Q?9Ss6Ylqs4cLDRg/N7/KsS27hpe/TJY2nijwbTgqYEcU16Dadepwh3NvLBgYo?=
 =?us-ascii?Q?01Z2hxJjlbi62vIT6tPcaq2sHYB1RT3kcI/8Dq95Qvrc3zfBzH3hTNFj23lM?=
 =?us-ascii?Q?aSY8nwfM02czF5MbjJzoFQv7VMhsUoOwmhE/QLwIZB4kjxdNioUP+lzI4coY?=
 =?us-ascii?Q?sodqiniBfZ/Tsm8AVdjSVemlS4wStSMLeb1ErfU+n64X94qNIE3t+JLJR3BO?=
 =?us-ascii?Q?AnUJmAIhDWt0V3Q71MgevfbpqggsS01pcxqH7KMCv+lpyArVY3TcsPrwjQH4?=
 =?us-ascii?Q?a2WE8BWeAdIB7eUzr1q91+/Mc9mzl0Ul/+3vpP1KB5WEz4eRRydaQxdVZov7?=
 =?us-ascii?Q?iLnV3wIl7ZBFpyRJNNoJoriqGt0+HSJZRH9Y+AvWrgeFybayLPnXmbuKS+c3?=
 =?us-ascii?Q?rB5wAtYLukEt8a2RO3BfOYPTEBRWTWM+7aGLybcIuVpqoPNHvtBnripZMw9c?=
 =?us-ascii?Q?DhmZFOa7t/YqVnd326zjniNAQoCphqdKOAJ5ru3B/PrgDuzmFHgIr9f2aJjJ?=
 =?us-ascii?Q?99+5WlrhTJL4ffvjhgF+UQMJdxJbmit986ew1qPcRMXp4SHd3rxr+C1uOAjl?=
 =?us-ascii?Q?xU2wqJu/fgJ5WkwCzAH6rB5JDFk+J2p6lCCq5YVT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 910a61b8-2a1d-4b3c-65d8-08dc3ebe2477
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 15:49:15.5752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2lIs3h8wXliHV8pqd81iCH4yni/JNLvywT4G9VQy2uuxfX1/r1Sedr35RU3DvWi0m25cN9g9sgGbI7K/+PUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3539



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, March 7, 2024 10:29 AM
> To: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Ajay Sharma
> <sharmaajay@microsoft.com>; Leon Romanovsky <leon@kernel.org>; Thomas
> Gleixner <tglx@linutronix.de>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <decui@microsoft.com>; Long Li <longli@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>; Shradha Gupta <shradhagupta@microsoft.com>
> Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
>=20
> On Thu,  7 Mar 2024 06:52:12 -0800 Shradha Gupta wrote:
> > Extend 'ethtool -S' output for mana devices to include per-CPU packet
> > stats
>=20
> But why? You already have per queue stats.
Yes. But the q to cpu binding is dynamic, we also want the per-CPU stat=20
to analyze the CPU usage by counting the packets and bytes on each CPU.

>=20
> > Built-on: Ubuntu22
> > Tested-on: Ubuntu22
>=20
> I understand when people mention testing driver changes on particular
> SKUs of supported devices, that adds meaningful info. I don't understand
> what "built" and "tested" on a distro is supposed to tell us.
> Honest question, what is the value of this?
@Shradha Gupta Please add the tested SKU and test case here. Or, you don't
have to include test info with the patch.

Thanks,
- Haiyang




