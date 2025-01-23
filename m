Return-Path: <linux-hyperv+bounces-3752-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98400A19D51
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 04:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699E33A60EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968E126C0D;
	Thu, 23 Jan 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fq4b9EIp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010003.outbound.protection.outlook.com [52.103.10.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66758615A;
	Thu, 23 Jan 2025 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737603277; cv=fail; b=l9Ns4MCmPWjNYn4sZPKgqHXWF7vEjdAiIRX0SgCfmWgw0BSBDpfUig/Wox4eynrtWk1kx0CcZJtR4chtgeKgbJV9pQiL2WOjA+8+6i4svdMqrT4EenA/5Luonat2Y7o0aTspKrGFnIXswPclnPFRR21jWSsstscxnPh0ftMcgVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737603277; c=relaxed/simple;
	bh=u8NuM53Ab77YZH1qrrjpuhuJdTsC+95Hzx19ShlhVw8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OI8YsReZhO5XMdikh6aOfh/T7cDLJtZXF47aq+/Bo973voms9jvaDrVaCxyd7ZBNRmfqR6Xv0J0zPNFiDhMsCDBzKXfHk7LrVVlGWl2iJQaIRmO8D32j2mee3RqSiZiZJ6+/pbVZFI2VqLZQVAkac7ft3iHKos/kpOeBm7eo34s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fq4b9EIp; arc=fail smtp.client-ip=52.103.10.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ+v0/Ul52SaveH/LGnBe3lFpHPkKp4wA0Tg3oIkZPnfHHUDZ59PFqDuIVUQ0XMv7w51cjYu1vs0O7WfzDbLRLfNUr91i9oajoVI5/IxLk1AWdEWXWsR27q71Bqfy7X8zUR8BnYQYXDDRRaagZQn4jC232CZtjEG5frASyMwYpZSj8xZGeILmkLrTjfWdVQd8CPJzMxzwvwFqX77G7M5OumgDbCb9AFa9Fd9/QqnbfMxJubllDgjaf2XxaF6aQH8/fUwoAVB2tu132TFft+khiac4GPMCw77vzptWgxoZwSD56T4JVZ6MS6tTecVuq1BK96HbPdR0Y/AKpF+fa6Xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8sPalqs/T6pA/LbjJj25oWNkDbjDZgQSKsV2cgsja4=;
 b=M8Or0DM8Ukc0wKKwaTNetQTwj7+F+g5ahaN2Mct/0AWiarVwNKgk2tUm9HU3m1WKJT/1McFlh2PzWRBcldp9L0D7v4SGWDJ1pc7QmlhaGR3YgJAGmSH6q8ZPuwZL8CIB6EK2HTGxvUKidRTQO/rjUlC539LxKGr4AXXKX1wuBG9/ohecbmpChQi7BZp+4DDa+eqPM827NIc0siHm58BYjxgAQc5wVWs8y1IoFqQpf2HyqxTsOn+b2I3SG/hvXfbz2ZakTELaei4omxMDixVMv/OxTtokdzqzxeYjbvo3ZkHowhjSL5xfslq7aN3/Is34B39ra0QmdrYh1mFfYI2U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8sPalqs/T6pA/LbjJj25oWNkDbjDZgQSKsV2cgsja4=;
 b=fq4b9EIpBL6kzFJ5LsHs8OM2cgS9HZLFJk9Upu7jIqM5CSV+wRJO29hMGRybCGYv3G3/zwNK8tMk1fY0pymkkLeKuuDzUFMHhz9zKs3qmwhXTBjBB2ACqEa1kzX7vNnQ+5VzjiQPi8a8aMDzyFRFmCTd+3rcs3WRpsr5MPgkMHx3tpwxvYaEYDn5DrV3fjkhZuBSN+3qWyE1bnnYkhNXwLc/8FkKChnqMsBTvyz/4sRtzxUx7wEGDkwg2kYSdUQcYubyDmBSCs8IAA5vwWRaTK1Ir8v4cpMzGfZUKFSomzcvJKDpBVVH3HknTGHO6pbDvx8cTuvJysW5DVdNm5nTIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB10066.namprd02.prod.outlook.com (2603:10b6:806:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 03:34:33 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 03:34:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Topic: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Index: AQHbaHLRzkYQZ+EqJE6PNc5JdE6XVLMdMCTwgAMi2oCAAE46EIADFiIAgAAGnyA=
Date: Thu, 23 Jan 2025 03:34:31 +0000
Message-ID:
 <SN6PR02MB4157E766FFA1FC3AE35D5B79D4E02@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
 <MW4PR21MB1857121CA82F0CE544F245BFCEE72@MW4PR21MB1857.namprd21.prod.outlook.com>
 <SN6PR02MB415751506B4B116CFD081939D4E62@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA6PR21MB4231FB8BE368335A4EDE365DCEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB4231FB8BE368335A4EDE365DCEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=563ecf69-e157-4f2e-b3a3-9ba714c38af2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-20T22:51:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB10066:EE_
x-ms-office365-filtering-correlation-id: cb05cd59-fb6f-4dbf-b130-08dd3b5ed966
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|8062599003|461199028|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qQlszyScXnkbB+SPRFLNp/3DorI5XaSaZSN95JgfPUV56TR0cA5Jd6vOAk8w?=
 =?us-ascii?Q?7+UVmlB0sCXb3/aE5mmKBVU+sNCFonPhQS2dYtmCxu6eW/d/fRJklp1UKHl6?=
 =?us-ascii?Q?BdOg98dv/2qyIBIwUrT7bkVXCbAQdj8dDXcE5bT+HL0/0nI345SjIQvGhq2s?=
 =?us-ascii?Q?UQIw0K6BPGTcJx/yimwYJEFqyIaA0Hl6uoYtXzrroI8TmgDFKAdboculPotw?=
 =?us-ascii?Q?G8BZnelVhlqLAtfsHzU+bcFxUqMp2IIgJGFdGPPJ3VCem01H1sTBul6N0nFI?=
 =?us-ascii?Q?uuTJRy7skg+d4RTbgPHWK/cyHTGewoMm0ACDvcC5Hmcp06bzzM6BpKyDx7r0?=
 =?us-ascii?Q?gWn4XMa6VGAhdsXys5O/+V52vRZxSC3MYazrEr4YYxDQ/Q0bUhEUFUwxkC8A?=
 =?us-ascii?Q?+lsIkQLAcG8qjxGoXaoXQY7iHqnfYJDunyvVnVJ9qlw7qzYqiRFYpuznBKtb?=
 =?us-ascii?Q?9dSfI9keTvNbIH0zwRnysU6NLqPQ1AHo68lsYOQBU5qSDmFghAXzWjsLx7Zk?=
 =?us-ascii?Q?5trkDGXLpLYeOxZ+w1RqJ4hA8KRqK8pVpdhu2FEkoLGDKSursOqvcEtRfLi6?=
 =?us-ascii?Q?TWHigynW0tLhlIpcyg0zMwSLb4ABfbMvtnj8uStULhN9lLwgFytL95X7Wb0U?=
 =?us-ascii?Q?yFwz3TJ2U8YIROLAZqdp85QJX2l/BVRAD+BvGBetVtnCq1CIBy41mOd1Sbsx?=
 =?us-ascii?Q?4iqsri04FQE1S/SKiEtfN2/tPUq35HX+tpkAA6xmVsBvgG6erpC4t+B/o4cP?=
 =?us-ascii?Q?r98Q5mZg4G8b8KpKGRq120tlURQvwuZqbkGkxUJGIBRvcUK++CvZlB1dhHyP?=
 =?us-ascii?Q?XhcDNQkCSodbxKRBWlK8veXhM3Lbd01c/J/TeNT93U98qljgXHSXtVmX7Zc5?=
 =?us-ascii?Q?i/jkWeZ3nRw4TpW5DxzqyAF2BQeTRsG82LQT5dwdAn838XKUP5DwbuUfKR/O?=
 =?us-ascii?Q?Ov29LLewEvXWUFDXcow0RAkN1WZs1HT30rFmxZUzuvnGFydKTSO6bJ64klSM?=
 =?us-ascii?Q?VQrM+NbWbr8hMW3mcpTlQU0SxiofEtN6I7arlB7LTJXYm0Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SnPUH0JE6WnMuVgg1Pm84TquZhnNcmP/Y/J8wjNRsNbaV3kZ0Upb6VwY2q7S?=
 =?us-ascii?Q?hsyYpWxLPvoK0rzPAtpxU6sF1GiVOZlXeRxjenB0nJOQLvk03c/7iXGvjjGm?=
 =?us-ascii?Q?e2rUnHFa+IuqlTYuiSzZEWzs8p9IASi0mSnH8g2RoZgOAzfezM4qbLz859TO?=
 =?us-ascii?Q?1vh0WMt3ayFoUzX7Q0iNqBJ3XrGzeJWPS6CxnrtppgLefrm5KVSIS1UBNHA2?=
 =?us-ascii?Q?cn/zFG4ZF95d9UtLPkxCUHW4Bril5V7N8TUetwXhQdrriHp3G/ak26eUQk00?=
 =?us-ascii?Q?yiN6qgNT2tNzUD02dHfwPtBU+UyzZfBelyEhehYrp59kBdX/Gf0S6VaxIy3c?=
 =?us-ascii?Q?KrXgT3i1g63S4L2/kKXbJb5jMsEPJyIpcEskTVqVW0TohZbajeKnD8V530iK?=
 =?us-ascii?Q?+FL8iV8eCzy78IJ2khS/NBgZcUyPjmtJpjrVHjlxiJNcUtYDYpwNZban0CtO?=
 =?us-ascii?Q?rzO9Zj7VazDvzCn9Umi4t3JCxHHa/QY5sGlEUl/Fnx3h4bqkzyDtVcoxxV7N?=
 =?us-ascii?Q?8kMIlk6hJKnyV2WzJ6fwWUL1QKszziB4XfefB4shNmtL+8lu1DHtVGDtMmMs?=
 =?us-ascii?Q?VyMNHk38AMm4HI1g4hT+rvsf9vXazCnBjcM+d3SieJeRQvhq6/WSi2SD9hGC?=
 =?us-ascii?Q?SKgI9TD95K5A/sLYCEQJeWfZKUjq17mYZbKECbAmqkTdfkG1lJbxWJS4Rmih?=
 =?us-ascii?Q?VFHqb+tEPEK3ADE7XB6Y705Mm5t27FiNvOndw2ppaPSR/lGQZMzguD8oPjRF?=
 =?us-ascii?Q?wZ0M3I1zyBBavLG4u65qR3A0EWjtL/SKIzPhWU/JIzhi9KOnmnCDpOvrSLXo?=
 =?us-ascii?Q?4rvoZiJv18pDodPzBNK6SnY91hTqLDzzTZC5P1NMLKlC8oTGfS0UsQ4K0vVp?=
 =?us-ascii?Q?/pdnBxKhLU6UC633zbsBTsuzn14Nsh6fRcKbjVHa9bNPavyRajY4foKxr+0X?=
 =?us-ascii?Q?0iZ0K0TOTTmZs8ccE5eUARonErK/XCNs3FL/w1WSV1oy5HqQFJ40ErVh22qr?=
 =?us-ascii?Q?+Pc34D+SlRap10t64CtQaKo31uEt/z8bSC1nVUlUEq/LajavaCe7hOJIA12/?=
 =?us-ascii?Q?C3DXO2thHcqO1ek4K+/TRrYlhkxrU0Zo6MGHZNMST6rFMXY7e6xIa+9CcRRd?=
 =?us-ascii?Q?txtQgEciWQqyWtKsrOT4XoP/VtFCjK8ZJV6P2KfFQOCU74kOdgoNpeTWg5t5?=
 =?us-ascii?Q?NlIhNMCvZT09WuC3Z3vBduNMDAA+RWT7D5DuWbk1jFNC46AFaDmWIN7JOKg?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb05cd59-fb6f-4dbf-b130-08dd3b5ed966
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 03:34:31.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10066

From: Long Li <longli@microsoft.com>
>=20
> > > SCSI mid layer may send commands to lower driver without initializing=
 private
> > data.
> > > For example, scsi_send_eh_cmnd() may send TEST_UNIT_READY and
> > > REQUEST_SENSE to lower layer driver without initializing private data=
.
> >
> > Right. Thanks for pointing out this path that I wasn't aware of. My sug=
gestion
> > would be to add a little more detail in the commit message, including i=
dentifying
> > this path where the private data isn't zero'ed. Some future developer w=
ill wonder
> > what's going on and appreciate having the specific reason provided.
>=20
> I sent v2 adding more details to the comment.
>=20

Thanks.  Looks good to me.

Michael


