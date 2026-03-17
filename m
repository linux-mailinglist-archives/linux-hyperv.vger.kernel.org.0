Return-Path: <linux-hyperv+bounces-9502-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJawL42euWk1LQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9502-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:33:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DA52B0F8D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5205E30080AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05BA37F8A5;
	Tue, 17 Mar 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CoLJ5plH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020096.outbound.protection.outlook.com [52.101.61.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E02E8E16;
	Tue, 17 Mar 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771370; cv=fail; b=Y/xJdt5kie5ZDuf07HXktybOuhmPOD2KE3tEtqDvQezxrR758ngeQHBn5yOvRSiefb2+y99o9TxRespBt0V0m1K+zfT0thYEbaFLj3sY/yLgCV+sIyuAT8arerDcMWEoiPkoz3+PpHSjsY7+7IYD3LHQSEWD1Sv83hOBipseSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771370; c=relaxed/simple;
	bh=2nV/DpgefhjYwPCPcGt2uAYbt7+Wavb2+kb0sL5S8DE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJRGycXnShX2Phhqsar1xOAn0tbgLIt0nP4WzWQlxrWFEuOdgpMnnLjCR/Za8DgyCZmiYLOItAQn2Pt1ZkdlMvUJINLU09Q87SdXrgmxLFjXJoqRylmKUMAY11a4kHRO22Ev2CbLP6BZvmqmvxzC+Cfjr2RWCfcoPiFP3UJzh8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CoLJ5plH; arc=fail smtp.client-ip=52.101.61.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVQidPo65ZrG50xZI8yfNxA2IGP0Hskd8sRvS7ogYcckIVhhA+T7ZW2hPbjzRJmsHEi3DBec/+sr/PM1ovsnGKMedaJN36AY9y708OCRg3iee4LhymL2NNbvXW6JqIatf5UOKEziGHWL/X/P1hgGqWiHRNBb96bZRgbtMYB6c0E79MKmeB1okKNGjpRzWPb6pCRJULdG0/MeSxSpXye6h7VEmDGeZtvTYEj1zK5foUmX/q7GjPdAtg+PMjWgFu8C2CkFNT6ynkQev+v6fUkFWVpRfQMg1LNejBiDC5gpiEeDOk72AwE4E5Tdl8zALzseZ645rEtBa4Wsg2ajH58j7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PQgif4J94FJXsrJKm0++5Q2Rz+I0Oebh+9xACwXAqA=;
 b=WA6I4PzGXcoXF4cgMlRtb44aTTAW3GRpjW/h1nNEEjc8jq1aA4BPOYHxrQnWNSvYmS/l4bnkbi03ulkATxGNId7exI7fUYm9YE3QcYKjuK5azeH5oOUGlS0Xk0czw3VC6ulWRtbQS5arsrq2zzh6gB4h9298pansLPElmD9heGDG7NcTEqcigklv9f4ndI8+YmVT+D8mpIJYoI3SijRrzqqRlwXijs6X9siEZBNBcg3L7Lu7Vr4IxjQ9Qf2UbHFktQ7cZEakI/fDLLFShq94QNneoAWTErNUkJ4fjAbyiTxbgbbv5g2pDm4TDycUoS+GWJTAiASFheHY+Pb0Xuc0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PQgif4J94FJXsrJKm0++5Q2Rz+I0Oebh+9xACwXAqA=;
 b=CoLJ5plHpwWPCsjGvcjZ/7sBHHvOlvx7fQptDN8JB/mVdQBwtMgmcVcrfuYXNCi8S55yVdUkJfYEbbPMczj1Dejn9lzf+jsCshOXPJWOcJU03FIkwtJdVN36EB2PaleA5Vmkv9fLdif8lMtPMpNRKiZCWSjQLLCH+y/h0Kh/qFQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV9PR21MB4829.namprd21.prod.outlook.com (2603:10b6:408:2e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.8; Tue, 17 Mar
 2026 18:16:06 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 18:16:00 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bernard
 Metzler <bernard.metzler@linux.dev>, Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>, Kai Shen
	<kaishen@linux.alibaba.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, Leon Romanovsky
	<leon@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>, Chengchang
 Tang <tangchengchang@huawei.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH 15/16] RDMA: Remove redundant = {} for udata
 req structs
Thread-Topic: [EXTERNAL] [PATCH 15/16] RDMA: Remove redundant = {} for udata
 req structs
Thread-Index: AQHcsbakylQ2xYwboUqXbD97xdJZybWzELfA
Date: Tue, 17 Mar 2026 18:16:00 +0000
Message-ID:
 <SA1PR21MB66837BDE539C2DC3387434C7CE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <15-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <15-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b358171b-bc9c-43ba-b2fc-a3001504b6c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T18:15:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV9PR21MB4829:EE_
x-ms-office365-filtering-correlation-id: e18b8bf3-798a-46f6-e49e-08de84513e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 z+JlhyDFufvALTaNfEzjFEnmgOksLuzdNEHaAmbrxTTGc7BShVRsq/cgk0vMrDgSr7vruwwXahI86Ls40cMO5qJwnlLxolZjl+SB3hSydXsaWbI0vJHlHM0I3dnKF4qrRi/WwDPBtF7nt3YTgoPV6QcawI0Ye85VdcLSeJTLM2oAT+b0r7HZt0Sx3lv5NYYDIFSipgavlFdtouLvGxj1QwwTVjSxckA7waEBxVrZq3vY67MSHWCJWyCWgBeFACbfKtLnjNAEw4+QwiTFu2o+d1FOtHxEh/+C+xCl50nNf8p0dbRGOwTH1aBzK8PX15VLAMG5rw1prtj0FO/czRTjlpexLBMyYitxEF+3CP8gTnpli252a92qA1j25zVmrZxIif7hhyEGHdUouoKE22gAXLo0cvr3FuFLZev2SSnFBvjeiWDk/TuGDKyB/UQsVgO2c3sahpStUpOfz+pUs6k6Nciu2sz3fbUBEhMcK6G/6VAUolz6W+w71scKQNdeAKbXswXGuRR/FgMb9jMi5mlxqCWDtl3+N3P9jhGh9O+vAN99QrPGRcOEdQonryLjfVmItZFWh1+1kEpi1rkdPlWfWahb1Wzfd3n//u2Ke6n83/GUOuzpn6dIds7ZEOwxNX7fbk5sPNDBXdyDK1c73X3IOsgZn4JwnXy+NIi59mohFMdCZeW0dRoKQ6Qyvw5KqmQauGUnEwfKOipbn9nkSPC7aks8mgQ5a8A0/bbyX9ACnkdUJmIjTRfcsWnYWpEeOcvDbr5xB0OEuvS+1Bc4jRCiquyfcyGcapRTwG6yV5J5Lv7V2E0TWIkjsxcGS8B4ncqA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GDcW7mBk0PcDBp16+VZBWOh6RKtjkYe8xn5MBkrgWbOiE31sGDDuCvjaPdhS?=
 =?us-ascii?Q?IKpeg5TkdEzmL1b+OT669cqhLqA2wGdBxouvGuLDoyisUy9lTbFWb6/kQOnr?=
 =?us-ascii?Q?fvcPsYgZg0E/3F7FGqwKMOFs4QGb9825S/2fK1tLWlqowQ3yQNYgkzQ9G7Kr?=
 =?us-ascii?Q?ZggliN6/n8762/X/+nuOUSXx9hyP6XiBc9E303WQ6R1Z0t5EUEwDZCwzGQTI?=
 =?us-ascii?Q?HVHXHBKQWtzsZRRSSkNVONtonUNupCql5/nI71x1eYevPUXr0QBSTJklw6wL?=
 =?us-ascii?Q?aLMdrMYjBQM0qNi9ZgyBKxkAZHAp2SizE8Ha+TEsq/MQvJnUKmET3xqmBFkV?=
 =?us-ascii?Q?V2Zjqk8YobrUaVjGVOHiCo8QK534nCjRMcZkWz44tJOVl9P+vDjQRE5Tj1Dl?=
 =?us-ascii?Q?2TQE3Q3YaFkX9TdTeNCWDvaj9520NoxC1y3vLWUz+XyRHYuaBldGt5vQmUSy?=
 =?us-ascii?Q?X5gTlKU7C1E/n9C7LrnW573umBA/bxKCoxLqAl5VoTVPbaWg/qiCJQvrogU/?=
 =?us-ascii?Q?E6fu4t7DrU/kGttnKp+39VflTmV10uAEGSDjjprZzd/PgfCE/HcHUc1FFSqp?=
 =?us-ascii?Q?2qw17cEOOdmjc6lfu75RFtE8t89554y3lawrQvMJWMOwWzv0093nV0gYfr/v?=
 =?us-ascii?Q?Ac/8vzShKn6QlnFCjNTWdOUItRYxwh/esBLLEIfPkaLNLpjC0R3BlmDOdvLX?=
 =?us-ascii?Q?BcVZgwrSogMuSOk9AY/gxYkUjOEqC31I8FGtS57J+VSEBvEl6aKnRMSdQMyz?=
 =?us-ascii?Q?pNHYj9Ynz+bhBzZ35alvFBIndw2v8E8colB3V5LsYTmotFwD+lx1XFUB7hDG?=
 =?us-ascii?Q?5ibzQtt2jLAY8r/Jlj7W0gEv4ILnELgQsXKKxn2lmz88Yzll9o60TzL73yAw?=
 =?us-ascii?Q?RaHOAAnde7wtv5KsZcUtLYfnAel0RCRxctXiX7Fv2ZvQWJqKUhgfakjXJNPr?=
 =?us-ascii?Q?wsl/CzjLTd6kAvp70E5IbML6m1G2yYcsGYmUsBtkMmqhhengXoRtI7lFRSg4?=
 =?us-ascii?Q?0owBYqCPQuwl+JIPPWx5yLKFDfru36PjjPFqp7sFjx2y4qFkiNij+4Jr6LPF?=
 =?us-ascii?Q?kQsPxEEFb6+lPwV5qPUjLYcDL+Vpcqcuf38oKYL/yxG5LloupUOiutBBBsCU?=
 =?us-ascii?Q?prJYi9azJZ7XB1xlMkDwssoJtOMeJe1ReFJlqsNPZCW0cXiPMdSHnOJPeQc5?=
 =?us-ascii?Q?oIOjicRA/kzkhaPkC+EeFPcYpLdB9NI4WJWJd/PkD5MsuoPtXvz76Q5AEfsL?=
 =?us-ascii?Q?hCw3umCKVweoH02qdyLbUNJM+nI0Ct0InKu/FGe17vgRuw/4NM01Oem6Hf7X?=
 =?us-ascii?Q?5PtSgK06wdFhF33wM2Ih4Ds/6AU7XYFIvrbhiYvjZPfDxxtTkdMiaS6oMCdh?=
 =?us-ascii?Q?Hki99RcMucQZWbyQKQoqpdFxxlPE3Slf/cx8TcsiH+bO5o12nFNXXLWr3jJd?=
 =?us-ascii?Q?n8vUEZYr9A0kc0rZLWqmcexhW3n+GRSPUQVJvvDv+jSWgucCDv9LZxERAc75?=
 =?us-ascii?Q?tBgaAzC9Wr5JEv09t4FTw+N9MmRmtH3jNCys55L2l22FUhF1AfDwgqrKYlvF?=
 =?us-ascii?Q?HUivBS8Ddvxx/4rtxc1N11qD7AOstllG6GY8STt15uEdK7Y+TQlWHRe14OQF?=
 =?us-ascii?Q?+M5aflSGiQAh1dtrvgIZTOz/3tRunFT2E1L0BBGDPqi+QLRjbGiXWQwdEl5Z?=
 =?us-ascii?Q?Wz8lDk+mNOMI76V5NVpeMcrB9m9lRBcSLc1hNK2IZO0G+UV/?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18b8bf3-798a-46f6-e49e-08de84513e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:16:00.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+Uj119RP+A6bfdkQ3GOThKjoITS+PSMAbzakEQR8k2bM6Z5WG6SES3Rqgbc2GnOtacMP0RrBXSsZcdhUDg1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR21MB4829
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9502-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C4DA52B0F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Now that all of the udata request structs are loaded with the helpers the=
 callers
> should not pre-zero them. The helpers all guarantee that the entire struc=
t is filled
> with something.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/infiniband/hw/efa/efa_verbs.c       | 4 ++--
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 2 +-
>  drivers/infiniband/hw/mana/cq.c             | 2 +-
>  drivers/infiniband/hw/mana/qp.c             | 2 +-
>  drivers/infiniband/hw/mana/wq.c             | 2 +-
>  drivers/infiniband/hw/mlx4/qp.c             | 4 ++--
>  drivers/infiniband/hw/mlx5/cq.c             | 2 +-
>  drivers/infiniband/hw/mlx5/main.c           | 2 +-
>  drivers/infiniband/hw/mlx5/mr.c             | 2 +-
>  drivers/infiniband/hw/mlx5/qp.c             | 4 ++--
>  drivers/infiniband/hw/mlx5/srq.c            | 2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 +++-
>  drivers/infiniband/hw/qedr/verbs.c          | 8 ++++----
>  14 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c
> b/drivers/infiniband/hw/efa/efa_verbs.c
> index b491bcd886ccb0..f1020921f0e742 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -682,7 +682,7 @@ int efa_create_qp(struct ib_qp *ibqp, struct
> ib_qp_init_attr *init_attr,
>  	struct efa_com_create_qp_result create_qp_resp;
>  	struct efa_dev *dev =3D to_edev(ibqp->device);
>  	struct efa_ibv_create_qp_resp resp =3D {};
> -	struct efa_ibv_create_qp cmd =3D {};
> +	struct efa_ibv_create_qp cmd;
>  	struct efa_qp *qp =3D to_eqp(ibqp);
>  	struct efa_ucontext *ucontext;
>  	u16 supported_efa_flags =3D 0;
> @@ -1121,7 +1121,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const st=
ruct
> ib_cq_init_attr *attr,
>  	struct efa_com_create_cq_result result;
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct efa_dev *dev =3D to_edev(ibdev);
> -	struct efa_ibv_create_cq cmd =3D {};
> +	struct efa_ibv_create_cq cmd;
>  	struct efa_cq *cq =3D to_ecq(ibcq);
>  	int entries =3D attr->cqe;
>  	bool set_src_addr;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c
> b/drivers/infiniband/hw/hns/hns_roce_main.c
> index ec6fb3f1177941..0dbe99aab6ad21 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -425,7 +425,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext
> *uctx,
>  	struct hns_roce_ucontext *context =3D to_hr_ucontext(uctx);
>  	struct hns_roce_dev *hr_dev =3D to_hr_dev(uctx->device);
>  	struct hns_roce_ib_alloc_ucontext_resp resp =3D {};
> -	struct hns_roce_ib_alloc_ucontext ucmd =3D {};
> +	struct hns_roce_ib_alloc_ucontext ucmd;
>  	int ret =3D -EAGAIN;
>=20
>  	if (!hr_dev->active)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c
> b/drivers/infiniband/hw/hns/hns_roce_srq.c
> index b37a76587aa868..601f8cdfce96a3 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_srq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
> @@ -406,7 +406,7 @@ static int alloc_srq_db(struct hns_roce_dev *hr_dev,
> struct hns_roce_srq *srq,
>  			struct ib_udata *udata,
>  			struct hns_roce_ib_create_srq_resp *resp)  {
> -	struct hns_roce_ib_create_srq ucmd =3D {};
> +	struct hns_roce_ib_create_srq ucmd;
>  	struct hns_roce_ucontext *uctx;
>  	int ret;
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 3f932ef6e5fff6..f4cbe21763bf11 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -13,7 +13,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	struct mana_ib_create_cq_resp resp =3D {};
>  	struct mana_ib_ucontext *mana_ucontext;
>  	struct ib_device *ibdev =3D ibcq->device;
> -	struct mana_ib_create_cq ucmd =3D {};
> +	struct mana_ib_create_cq ucmd;
>  	struct mana_ib_dev *mdev;
>  	bool is_rnic_cq;
>  	u32 doorbell;
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index 69c8d4f7a1f46b..ddc30d37d715f6 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -97,7 +97,7 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, st=
ruct
> ib_pd *pd,
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
>  	struct ib_rwq_ind_table *ind_tbl =3D attr->rwq_ind_tbl;
>  	struct mana_ib_create_qp_rss_resp resp =3D {};
> -	struct mana_ib_create_qp_rss ucmd =3D {};
> +	struct mana_ib_create_qp_rss ucmd;
>  	mana_handle_t *mana_ind_table;
>  	struct mana_port_context *mpc;
>  	unsigned int ind_tbl_size;
> diff --git a/drivers/infiniband/hw/mana/wq.c
> b/drivers/infiniband/hw/mana/wq.c index aceeea7f17b339..5c2134a0b1a196
> 100644
> --- a/drivers/infiniband/hw/mana/wq.c
> +++ b/drivers/infiniband/hw/mana/wq.c
> @@ -11,7 +11,7 @@ struct ib_wq *mana_ib_create_wq(struct ib_pd *pd,  {
>  	struct mana_ib_dev *mdev =3D
>  		container_of(pd->device, struct mana_ib_dev, ib_dev);
> -	struct mana_ib_create_wq ucmd =3D {};
> +	struct mana_ib_create_wq ucmd;
>  	struct mana_ib_wq *wq;
>  	int err;
>=20
> diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4=
/qp.c
> index cfb54ffcaac22c..790be09d985a1a 100644
> --- a/drivers/infiniband/hw/mlx4/qp.c
> +++ b/drivers/infiniband/hw/mlx4/qp.c
> @@ -709,7 +709,7 @@ static int _mlx4_ib_create_qp_rss(struct ib_pd *pd,
> struct mlx4_ib_qp *qp,
>  				  struct ib_qp_init_attr *init_attr,
>  				  struct ib_udata *udata)
>  {
> -	struct mlx4_ib_create_qp_rss ucmd =3D {};
> +	struct mlx4_ib_create_qp_rss ucmd;
>  	int err;
>=20
>  	if (!udata) {
> @@ -4230,7 +4230,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct
> ib_wq_attr *wq_attr,
>  		      u32 wq_attr_mask, struct ib_udata *udata)  {
>  	struct mlx4_ib_qp *qp =3D to_mqp((struct ib_qp *)ibwq);
> -	struct mlx4_ib_modify_wq ucmd =3D {};
> +	struct mlx4_ib_modify_wq ucmd;
>  	enum ib_wq_state cur_state, new_state;
>  	int err;
>=20
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5=
/cq.c
> index f5e75e51c6763f..1f94863e755cc7 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -720,7 +720,7 @@ static int create_cq_user(struct mlx5_ib_dev *dev, st=
ruct
> ib_udata *udata,
>  			  int *cqe_size, int *index, int *inlen,
>  			  struct uverbs_attr_bundle *attrs)
>  {
> -	struct mlx5_ib_create_cq ucmd =3D {};
> +	struct mlx5_ib_create_cq ucmd;
>  	unsigned long page_size;
>  	unsigned int page_offset_quantized;
>  	__be64 *pas;
> diff --git a/drivers/infiniband/hw/mlx5/main.c
> b/drivers/infiniband/hw/mlx5/main.c
> index ff2c02c85625ce..fe3de414bfcad5 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2178,7 +2178,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontex=
t
> *uctx,  {
>  	struct ib_device *ibdev =3D uctx->device;
>  	struct mlx5_ib_dev *dev =3D to_mdev(ibdev);
> -	struct mlx5_ib_alloc_ucontext_req_v2 req =3D {};
> +	struct mlx5_ib_alloc_ucontext_req_v2 req;
>  	struct mlx5_ib_alloc_ucontext_resp resp =3D {};
>  	struct mlx5_ib_ucontext *context =3D to_mucontext(uctx);
>  	struct mlx5_bfreg_info *bfregi;
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 49dcc39836c047..37f3d19bd374ee 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1768,7 +1768,7 @@ int mlx5_ib_alloc_mw(struct ib_mw *ibmw, struct
> ib_udata *udata)
>  	u32 *in =3D NULL;
>  	void *mkc;
>  	int err;
> -	struct mlx5_ib_alloc_mw req =3D {};
> +	struct mlx5_ib_alloc_mw req;
>  	struct {
>  		__u32	comp_mask;
>  		__u32	response_length;
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5=
/qp.c
> index 3b602ed0a2dafc..8f50e7342a7694 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -4692,7 +4692,7 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,
>  	struct mlx5_ib_dev *dev =3D to_mdev(ibqp->device);
>  	struct mlx5_ib_modify_qp_resp resp =3D {};
>  	struct mlx5_ib_qp *qp =3D to_mqp(ibqp);
> -	struct mlx5_ib_modify_qp ucmd =3D {};
> +	struct mlx5_ib_modify_qp ucmd;
>  	enum ib_qp_type qp_type;
>  	enum ib_qp_state cur_state, new_state;
>  	int err =3D -EINVAL;
> @@ -5379,7 +5379,7 @@ static int prepare_user_rq(struct ib_pd *pd,
>  			   struct mlx5_ib_rwq *rwq)
>  {
>  	struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
> -	struct mlx5_ib_create_wq ucmd =3D {};
> +	struct mlx5_ib_create_wq ucmd;
>  	int err;
>=20
>  	err =3D ib_copy_validate_udata_in_cm(udata, ucmd, diff --git
> a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
> index 6d89c0242cab61..852f6f502d14d0 100644
> --- a/drivers/infiniband/hw/mlx5/srq.c
> +++ b/drivers/infiniband/hw/mlx5/srq.c
> @@ -45,7 +45,7 @@ static int create_srq_user(struct ib_pd *pd, struct
> mlx5_ib_srq *srq,
>  			   struct ib_udata *udata, int buf_size)  {
>  	struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
> -	struct mlx5_ib_create_srq ucmd =3D {};
> +	struct mlx5_ib_create_srq ucmd;
>  	struct mlx5_ib_ucontext *ucontext =3D rdma_udata_to_drv_context(
>  		udata, struct mlx5_ib_ucontext, ibucontext);
>  	int err;
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 8b285fcc638701..eed149f7a942b8 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1311,12 +1311,14 @@ int ocrdma_create_qp(struct ib_qp *ibqp, struct
> ib_qp_init_attr *attrs,
>  	if (status)
>  		goto gen_err;
>=20
> -	memset(&ureq, 0, sizeof(ureq));
>  	if (udata) {
>  		status =3D ib_copy_validate_udata_in(udata, ureq, rsvd1);
>  		if (status)
>  			return status;
> +	} else {
> +		memset(&ureq, 0, sizeof(ureq));
>  	}
> +
>  	ocrdma_set_qp_init_params(qp, pd, attrs);
>  	if (udata =3D=3D NULL)
>  		qp->cap_flags |=3D (OCRDMA_QP_MW_BIND |
> OCRDMA_QP_LKEY0 | diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index 42d20b35ff3fe0..679aa6f3a63bc5 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -264,7 +264,7 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, str=
uct
> ib_udata *udata)
>  	int rc;
>  	struct qedr_ucontext *ctx =3D get_qedr_ucontext(uctx);
>  	struct qedr_alloc_ucontext_resp uresp =3D {};
> -	struct qedr_alloc_ucontext_req ureq =3D {};
> +	struct qedr_alloc_ucontext_req ureq;
>  	struct qedr_dev *dev =3D get_qedr_dev(ibdev);
>  	struct qed_rdma_add_user_out_params oparams;
>  	struct qedr_user_mmap_entry *entry;
> @@ -913,7 +913,7 @@ int qedr_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	};
>  	struct qedr_dev *dev =3D get_qedr_dev(ibdev);
>  	struct qed_rdma_create_cq_in_params params;
> -	struct qedr_create_cq_ureq ureq =3D {};
> +	struct qedr_create_cq_ureq ureq;
>  	int vector =3D attr->comp_vector;
>  	int entries =3D attr->cqe;
>  	struct qedr_cq *cq =3D get_qedr_cq(ibcq); @@ -1541,7 +1541,7 @@ int
> qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
>  	struct qedr_dev *dev =3D get_qedr_dev(ibsrq->device);
>  	struct qed_rdma_create_srq_out_params out_params;
>  	struct qedr_pd *pd =3D get_qedr_pd(ibsrq->pd);
> -	struct qedr_create_srq_ureq ureq =3D {};
> +	struct qedr_create_srq_ureq ureq;
>  	u64 pbl_base_addr, phy_prod_pair_addr;
>  	struct qedr_srq_hwq_info *hw_srq;
>  	u32 page_cnt, page_size;
> @@ -1837,7 +1837,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev=
,
>  	struct qed_rdma_create_qp_in_params in_params;
>  	struct qed_rdma_create_qp_out_params out_params;
>  	struct qedr_create_qp_uresp uresp =3D {};
> -	struct qedr_create_qp_ureq ureq =3D {};
> +	struct qedr_create_qp_ureq ureq;
>  	int alloc_and_init =3D rdma_protocol_roce(&dev->ibdev, 1);
>  	struct qedr_ucontext *ctx =3D NULL;
>  	struct qedr_pd *pd =3D NULL;
> --
> 2.43.0


