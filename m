Return-Path: <linux-hyperv+bounces-5401-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D3AADC5D
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4DC1BC6008
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9461B0402;
	Wed,  7 May 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aqpy7OhD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EB4B1E69;
	Wed,  7 May 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613194; cv=fail; b=dXa4te8zHJ5XPx1yt5zKh9s3EjQe2+EWdmyrojl2Ymv6Zk9eRowiJ/6rao/3VGz16G15teS/Iu3yYdh1RhkhaZfKZcj21NJXxlV2IgGQKtcl2A3SdRQBSbmg4q2mDf29Q2+1BJVOMrmNLi0p52Wu4qcD60AxoBqNUU8JApFnrJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613194; c=relaxed/simple;
	bh=kpmyCp56kfAW/Zei+WlzHVzERKwh4ziLJMniFKi1LHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPZFuCjD2iUTwH3mGvjHjvnwEGDEsHQNv3pVWLeFDT/scXpYcPAV1xavfCB7hu7TH2I8cdcEQOjaobRJjWc6kXCKHXRxNOsZCQDzT/9ZxbP860IqayPJNVUUi118ouYDjyxKcLAa27dS+DAOdmCfzHORORXJZurcQeVZZmPqdXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aqpy7OhD; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6j9tWrDtvyV8LHNMu5n5B24SD3IgczsceH8QU21SyryW5om8vYpgxvpiAfmRkchRXP0iQTRxlh6taDHr1SSNJBn/vtyUQ97kd828kFVAT4c0XUYL7M19jvgd/y2Ju5qY+G8hNwH/zAfzEc3EsgaW6sVoZ0leLdHxEvD+egfmNZsfkzJHXm1CA3azSxP4xjK7aYZKI+ZkIZ7qsGAvSUm466ssDdUBreOHNbCmMnq5FU9fyYfxA34eimZM6joUNw7d4wORoDt46bPop0uDxidUOtf1Pkhdz6suhYADDEQsgmW36SAkiEJcei4fj/nwgOkk6qm1rFvHF+ICKCiWBf/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrQ3WBWU6qhoFuyA+AzmkFIyq5mXwpVJrziqocbrf3w=;
 b=VGfM+gUPyG2h/5Sr9YfDkhCzp7NyUUzT9yB461TY77ya9TjoXDy/S8gR7ZF6xNZMpGnI1OJJTLYFMj6rSkjnqT85ZAYKliHm9+/p3SVAtbrAdIUlwI1L45SiqXjzyRD/gXsliXsTS34tO5vLLOs2v7vgVNrF9OXus4DLI1no5TL42rFlDlph8l0lF5hcGIVqCCyASCOIyw8CRkgaL5H6aK4sddhJa/dAYPcul9cAUgKdJ6WIlTfhcqxGkO9klpiLuKHx4bUPjtMECUqQ5FpaGVZYRt+PdCpPFAqN7Azl0pcRuFwQ7pb/SELGJL5IBmcdLSK9/U+oL2HwwdVMVzRY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrQ3WBWU6qhoFuyA+AzmkFIyq5mXwpVJrziqocbrf3w=;
 b=aqpy7OhD4RDI5YZaO+lf6SJqzXJP/WHJ4cT/ncBVYhFywdPTzzq0PHMnnNlciYKRA0invtf08TFUBPRvk//0Jvx2mr9f3oq9qnSdhaplqvk+VVZXUC8OCuIz4liK7G/U8Y/LvAnU9lRJZVXxjcGQQvB5guv06qG9P/gx5LSu1jE=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by KUYP153MB1117.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.7; Wed, 7 May 2025 10:19:31 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Wed, 7 May 2025
 10:19:31 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPWwq1NkNsYtEq9b/XTYQeJpbPG7DDg
Date: Wed, 7 May 2025 10:19:30 +0000
Message-ID:
 <KUZP153MB1444BE7FD66EA9CA9B4B9A97BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
In-Reply-To: <20250506084937.624680-1-namjain@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d50ff7d-2b7b-4194-be68-66317ec97014;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-07T09:43:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|KUYP153MB1117:EE_
x-ms-office365-filtering-correlation-id: a610882c-a45c-4eab-9ed4-08dd8d50a79e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UbWQ5glNuw5jn0VqMt14I7wFWX0a77ZRfs/ff+I0pScrje+bYDHBRkla5XH4?=
 =?us-ascii?Q?BBh2iMwh5xYUI0VWf0jvXx7q6IBCnglcFUfq76vRQsD5eouFUrUGTlsWnQAz?=
 =?us-ascii?Q?H560mrvHqwBX0iIaEqhOUDiZ4+FushpJyJZXZzJqbRZmD5gWSlm1GdAmktLO?=
 =?us-ascii?Q?4yqgNzKfwX4wMWrvaBer9gFAZ2Vx9bjJso+FagNxIMA5XXZTIerHam8fFXQR?=
 =?us-ascii?Q?jk1q4+3/HGUAwTIg87xsHyxO2Isclg20F4be7j2YiLnwwSyrw/QbkJFkN1Ct?=
 =?us-ascii?Q?Qp9RFumfLfmsBegaGq6lDRkzKQE440tKMvQYxYGYSOB6aK0D2OgKLXeycj2p?=
 =?us-ascii?Q?Z/eb2HEu/uzuMiy6T/pQ79unlWDzAWKQs/W4xoIHayhxGyS05HSLuYAzrire?=
 =?us-ascii?Q?UHoIA54fcR7/jhlEUmxYuMgMgVF7ShP8L7vBTFPtIbZsIZEbbkT6D42TrOJ0?=
 =?us-ascii?Q?lduZyeaMfvVPzJrYlsejWc7BPMWcdQa2QcTcIMRLAAfnXdsLadcyrF9QdRW8?=
 =?us-ascii?Q?vNXWma/2gtiATys/88tHKfUWMpne+6g2GCdr72z3UYV59T8Z+/BDVhePIRxR?=
 =?us-ascii?Q?fV7T3TpLeaRmH2AssLVNNQL3SE1N7KAHdxJOD64q81XK0/T9P/mWsvygJkY1?=
 =?us-ascii?Q?Qe1bGsud01qVjh7YPXyjPSwVl7fTcO824kzI8xuC4GeA5p8R06cDJDt6Pl7R?=
 =?us-ascii?Q?1a9d8GaBM7JnaY/mvYPpE9uj07eLyIe04P4Mkyda1MnamfOF0YHIasP+m5mu?=
 =?us-ascii?Q?4KxaIciE4EW8Guige0pnXb2Sq+FlH0FSS5Mg48tje68mjP15tVnDbf2aI9hh?=
 =?us-ascii?Q?TUrm0B/PzW0o7lylmqEAb6pXa5bAO3hDLBhcn307Xwzq1Xaz1SDoXwJtvyFv?=
 =?us-ascii?Q?t/il+/H9el9xkocvvBtAqZqAvvQ5fkK5HZwQfst4jbtSnGSQLySXJn1tJk6w?=
 =?us-ascii?Q?1eQrWXw8tCNjFjILs6K4olRYAHA6gZ4WvtsQ672wlME09QSbDZIjk86io/PK?=
 =?us-ascii?Q?Qb2K6FE9bVYcpphy42cB+uaco3clmKIswK4TWTtsBFGz/16kBZk0J/SuVBnO?=
 =?us-ascii?Q?F2GeMO5sla12xJXZuIsU4VO0xaJxt5OqiQEtmrS72iLzTQQ9Duprw4ywLJpu?=
 =?us-ascii?Q?/hCiRcXWDQKdi1qISEG01K+m/4iNh0PxEeDgGyTdDKkmWNtP7uG6bC6cd5HD?=
 =?us-ascii?Q?kXMLwh2Jo4nrpBrW0+VayWEbnonpNFzrBQjBiH9m1AopXlmPcaHKQn/K10sL?=
 =?us-ascii?Q?M+DtEK1Ba3I0Jg3ExwsyAMmbsN9HOO9bFASIYup/dxJHGm1yzSxkzfPmJ+WN?=
 =?us-ascii?Q?kBS6vD5TKFLuOLoKaZY2/yJcBcuUWNrI1cuUx2QxTPiEOksVkfURpU4Bux32?=
 =?us-ascii?Q?tdo/ve2AL0bCfE7cyob/ahO0n8KztGFXLrWthOkhAU5/gJ/lzSK9OHc+0brk?=
 =?us-ascii?Q?uOChnpTj96szCJzZJn5BWd8lI18UYrOdv2LdTes5Kfq4RrnlOoTzkDi0LDRm?=
 =?us-ascii?Q?QwIs0s6KK5FDArY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RS+m8GZ7GRjTY4VSnggEdIEBPA2v9jt55iubFckwZj+acgqqvEqqUJuaa8nB?=
 =?us-ascii?Q?0RK/zbhXyfrZ2mSGsPkdOXO0QuQoEG25JUyWtkoCfnMr1jbFHbT4HkZgmk0U?=
 =?us-ascii?Q?aT0EDQriTEeEKKsZFphS7TW4sKTXkTOASE8Edtr7e5BJDooGAsGPFD6VgYma?=
 =?us-ascii?Q?26sVdGBcwo8dZG5rrdGkivPOppK1WQAqKy2sWMGB7QH9kXshyFHKnBpSXaWr?=
 =?us-ascii?Q?xAUFsH71NF2lqhWz16V57jviMGLDpJz6m9fcEknl8MLf8Qp3yYw8WcJIE8gx?=
 =?us-ascii?Q?sBdt95d0ndRS7VqYFZOl4Ie5Rnig3XeJCqbuNl61bfrQUVgYJNaXWy/L/R/D?=
 =?us-ascii?Q?artsyURrYyUy73tcNg7ioX2j91SAjHpH2PlTUbDa+1LBP300IDu4O0clvL9E?=
 =?us-ascii?Q?ijqRfPXlCLON3OdwguSsglWLUzrY/eRM7Xdn20G8HYuNHxewdysRyN+Z1vRV?=
 =?us-ascii?Q?vpypVucQ6UVXYHPJxOwVH5Y6RhUzCqDRys4+UpinCrfquy9hUKxDbVzb/Rdz?=
 =?us-ascii?Q?hIiMGq3nX8ilD4G3pFV3T9h0LB2NO7NmAEETYXhXJALnpWC3epIy47CSvaxB?=
 =?us-ascii?Q?YFupdN5upt3EXigaCENAzSAOBH/lr5xSrNRfgfmbIptLOy1tj8EKPupLkfxH?=
 =?us-ascii?Q?LFe/L0g6vXcMz3zDDXDmTfePrQsbJX219qaheDl+1ElUcO0KY/OEJZfNKPx+?=
 =?us-ascii?Q?e1tXjam2R47tzdcgorQcoZUIPaxiV2Q8l+60rm1RwL0T7HntlAXWek3782ZD?=
 =?us-ascii?Q?oy6rDYazJi8SGqRwHAXYP31sk2hdDcu4HVfnusbKFD4tMhZ5a2rZRbbzvO0X?=
 =?us-ascii?Q?pBvvZwbKpavknjfmdw7Yfea65uxG4IqW9AKWR2ONIo3ZrTetld49K93O4YFN?=
 =?us-ascii?Q?yJy9HveJxfWkSgf23ytN59SI1OA83ZyeEKD1jKFPmdVXJ+wcN431Toe4c2IE?=
 =?us-ascii?Q?5jZEQd5+CtlLz0RFSWsEXkrMImV4uml2YawQzE+9Wd7OlyPGMq6fLHmTerow?=
 =?us-ascii?Q?QI0xil9BG5YFAUfVqoIcrAAak4PTdDvT7xwh1WVBpBk970Kgmi+l7aKoG/YA?=
 =?us-ascii?Q?HHJy/QVKL8TqpNLn+xKlRnKKZjYaXp8eh3F2zmEgtUn/xrMBanTOcQ0oDb/h?=
 =?us-ascii?Q?Y9aTSe2cDWD5a/tx4jaAnPwwVM8UNtYIe/a6HtU7p6blnhkb0PBd+trsIMzy?=
 =?us-ascii?Q?cuKu5yhOEedvFCvVZunbCEr6jdiz+JjiIT2kfM5z8T5kAd8vvsgZSmB4NGtU?=
 =?us-ascii?Q?wzGawnpmHiW3KjMrKyQwV/b1h5dedlfC3vscULbCzLP/SOtSFGBK3lV5AqnV?=
 =?us-ascii?Q?xQXK7DIb21maIdkKQA91UrXa9zD29IP2caWqlCSVMcfr+nId2jkyfOAH0pz4?=
 =?us-ascii?Q?5T02mChfp0z24pn9XCoVIQjyd/CC2icayZlwwvBhQkUTbq0IkhhrT375huKb?=
 =?us-ascii?Q?oaYD1CxhGBXZVYtf0cdO7/uem8JQb2lKb+aGVgtm8uiI3dPa3ZYXNZj3kGmr?=
 =?us-ascii?Q?6Ctk5Z4kGSxWbWxddmdiWe1eQ4zCuVn17pNBbycfZ81jPljqiJ+4Um1ItMjF?=
 =?us-ascii?Q?wKE3O7w4BlpKws+HNVpTEWccOL4aETFJrpafm821?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a610882c-a45c-4eab-9ed4-08dd8d50a79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 10:19:30.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCeZ6cFX9eY7bgG9W+3CwlEmLv2BiBD4cB2R/TnO/NSevGYjKt9boKGgZXhrczOH7e/STpmV5LTPIr4tZ2EsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYP153MB1117

> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>=20
> OpenVMM :
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fopenv
> mm.dev%2Fguide%2F&data=3D05%7C02%7Cssengar%40microsoft.com%7Ce3b
> 0a61c2c72423aa33408dd8c7af2e9%7C72f988bf86f141af91ab2d7cd011db47%
> 7C1%7C0%7C638821181946438191%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> 0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFp
> bCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DuYUgaqKTazf0BL8ukdeUEor
> d9hN8NidMLwE19NdprlE%3D&reserved=3D0
>=20
> ---
>  drivers/hv/Kconfig          |   20 +
>  drivers/hv/Makefile         |    3 +
>  drivers/hv/hv.c             |    2 +
>  drivers/hv/hyperv_vmbus.h   |    1 +
>  drivers/hv/mshv_vtl.h       |   52 ++
>  drivers/hv/mshv_vtl_main.c  | 1749
> +++++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c      |    3 +-
>  include/hyperv/hvgdk_mini.h |   81 ++
>  include/hyperv/hvhdk.h      |    1 +
>  include/uapi/linux/mshv.h   |   83 ++
>  10 files changed, 1994 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 6c1416167bd2..57dcfcb69b88 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -72,4 +72,24 @@ config MSHV_ROOT
>=20
>  	  If unsure, say N.
>=20
> +config MSHV_VTL
> +	bool "Microsoft Hyper-V VTL driver"
> +	depends on HYPERV && X86_64
> +	depends on TRANSPARENT_HUGEPAGE
> +	depends on OF
> +	# MTRRs are not per-VTL and are controlled by VTL0, so don't look at
> or mutate them.
> +	depends on !MTRR
> +	select CPUMASK_OFFSTACK
> +	select HYPERV_VTL_MODE
> +	default n
> +	help
> +	  Select this option to enable Hyper-V VTL driver support.
> +	  This driver provides interfaces for Virtual Machine Manager (VMM)
> running in VTL2
> +	  userspace to create VTLs and partitions, setup and manage VTL0
> memory and
> +	  allow userspace to make direct hypercalls. This also allows to map
> VTL0's address
> +	  space to a usermode process in VTL2 and supports getting new
> VMBus messages and channel
> +	  events in VTL2.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 976189c725dc..5e785dae08cc 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
>  obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
> +obj-$(CONFIG_MSHV_VTL)          +=3D mshv_vtl.o
>=20
>  CFLAGS_hv_trace.o =3D -I$(src)
>  CFLAGS_hv_balloon.o =3D -I$(src)
> @@ -18,3 +19,5 @@ mshv_root-y :=3D mshv_root_main.o mshv_synic.o
> mshv_eventfd.o mshv_irq.o \
>  # Code that must be built-in
>  obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
>  obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o mshv_common.o
> +
> +mshv_vtl-y :=3D mshv_vtl_main.o mshv_common.o
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 308c8f279df8..11e8096fe840 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -25,6 +25,7 @@
>=20
>  /* The one and only */
>  struct hv_context hv_context;
> +EXPORT_SYMBOL_GPL(hv_context);
>=20
>  /*
>   * hv_init - Main initialization routine.
> @@ -93,6 +94,7 @@ int hv_post_message(union hv_connection_id
> connection_id,
>=20
>  	return hv_result(status);
>  }
> +EXPORT_SYMBOL_GPL(hv_post_message);
>=20
>  int hv_synic_alloc(void)
>  {
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 0b450e53161e..b61f01fc1960 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -32,6 +32,7 @@
>   */
>  #define HV_UTIL_NEGO_TIMEOUT 55
>=20
> +void vmbus_isr(void);
>=20
>  /* Definitions for the monitored notification facility */
>  union hv_monitor_trigger_group {
> diff --git a/drivers/hv/mshv_vtl.h b/drivers/hv/mshv_vtl.h
> new file mode 100644
> index 000000000000..f350e4650d7b
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _MSHV_VTL_H
> +#define _MSHV_VTL_H
> +
> +#include <linux/mshv.h>
> +#include <linux/types.h>
> +#include <asm/fpu/types.h>
> +
> +struct mshv_vtl_cpu_context {
> +	union {
> +		struct {
> +			u64 rax;
> +			u64 rcx;
> +			u64 rdx;
> +			u64 rbx;
> +			u64 cr2;
> +			u64 rbp;
> +			u64 rsi;
> +			u64 rdi;
> +			u64 r8;
> +			u64 r9;
> +			u64 r10;
> +			u64 r11;
> +			u64 r12;
> +			u64 r13;
> +			u64 r14;
> +			u64 r15;
> +		};
> +		u64 gp_regs[16];
> +	};
> +
> +	struct fxregs_state fx_state;
> +};
> +
> +struct mshv_vtl_run {
> +	u32 cancel;
> +	u32 vtl_ret_action_size;
> +	u32 pad[2];
> +	char exit_message[MSHV_MAX_RUN_MSG_SIZE];
> +	union {
> +		struct mshv_vtl_cpu_context cpu_context;
> +
> +		/*
> +		 * Reserving room for the cpu context to grow and be
> +		 * able to maintain compat with user mode.
> +		 */
> +		char reserved[1024];
> +	};
> +	char vtl_ret_actions[MSHV_MAX_RUN_MSG_SIZE];
> +};
> +
> +#endif /* _MSHV_VTL_H */
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> new file mode 100644
> index 000000000000..95db29472fc8
> --- /dev/null
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -0,0 +1,1749 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Roman Kisel <romank@linux.microsoft.com>
> + *   Saurabh Sengar <ssengar@linux.microsoft.com>
> + *   Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/miscdevice.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/pfn_t.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/count_zeros.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +#include <asm/debugreg.h>
> +#include <asm/mshyperv.h>
> +#include <trace/events/ipi.h>
> +#include <uapi/asm/mtrr.h>
> +#include <uapi/linux/mshv.h>
> +#include <hyperv/hvhdk.h>
> +
> +#include "../../kernel/fpu/legacy.h"
> +#include "mshv.h"
> +
> +#include "mshv_vtl.h"
> +#include "hyperv_vmbus.h"
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V VTL Driver");
> +
> +#define MSHV_ENTRY_REASON_LOWER_VTL_CALL     0x1
> +#define MSHV_ENTRY_REASON_INTERRUPT          0x2
> +#define MSHV_ENTRY_REASON_INTERCEPT          0x3
> +
> +#define MAX_GUEST_MEM_SIZE	BIT_ULL(40)
> +#define MSHV_PG_OFF_CPU_MASK	0xFFFF
> +#define MSHV_REAL_OFF_SHIFT	16
> +#define MSHV_RUN_PAGE_OFFSET	0
> +#define MSHV_REG_PAGE_OFFSET	1
> +#define VTL2_VMBUS_SINT_INDEX	7
> +
> +static struct device *mem_dev;
> +
> +static struct tasklet_struct msg_dpc;
> +static wait_queue_head_t fd_wait_queue;
> +static bool has_message;
> +static struct eventfd_ctx *flag_eventfds[HV_EVENT_FLAGS_COUNT];
> +static DEFINE_MUTEX(flag_lock);
> +static bool __read_mostly mshv_has_reg_page;
> +
> +struct mshv_vtl_hvcall_fd {
> +	u64 allow_bitmap[2 * PAGE_SIZE];
> +	bool allow_map_intialized;
> +	/*
> +	 * Used to protect hvcall setup in IOCTLs
> +	 */
> +	struct mutex init_mutex;
> +	struct miscdevice *dev;
> +};
> +
> +struct mshv_vtl_poll_file {
> +	struct file *file;
> +	wait_queue_entry_t wait;
> +	wait_queue_head_t *wqh;
> +	poll_table pt;
> +	int cpu;
> +};
> +
> +struct mshv_vtl {
> +	struct device *module_dev;
> +	u64 id;
> +	refcount_t ref_count;
> +};
> +
> +union mshv_synic_overlay_page_msr {
> +	u64 as_u64;
> +	struct {
> +		u64 enabled: 1;
> +		u64 reserved: 11;
> +		u64 pfn: 52;
> +	};
> +};
> +
> +union hv_register_vsm_capabilities {
> +	u64 as_uint64;
> +	struct {
> +		u64 dr6_shared: 1;
> +		u64 mbec_vtl_mask: 16;
> +		u64 deny_lower_vtl_startup: 1;
> +		u64 supervisor_shadow_stack: 1;
> +		u64 hardware_hvpt_available: 1;
> +		u64 software_hvpt_available: 1;
> +		u64 hardware_hvpt_range_bits: 6;
> +		u64 intercept_page_available: 1;
> +		u64 return_action_available: 1;
> +		u64 reserved: 35;
> +	} __packed;
> +};
> +
> +union hv_register_vsm_page_offsets {
> +	struct {
> +		u64 vtl_call_offset : 12;
> +		u64 vtl_return_offset : 12;
> +		u64 reserved_mbz : 40;
> +	};
> +	u64 as_uint64;
> +} __packed;
> +
> +struct mshv_vtl_per_cpu {
> +	struct mshv_vtl_run *run;
> +	struct page *reg_page;
> +};
> +
> +static struct mutex mshv_vtl_poll_file_lock;
> +static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
> +static union hv_register_vsm_capabilities mshv_vsm_capabilities;
> +
> +static DEFINE_PER_CPU(struct mshv_vtl_poll_file, mshv_vtl_poll_file);
> +static DEFINE_PER_CPU(unsigned long long, num_vtl0_transitions);
> +static DEFINE_PER_CPU(struct mshv_vtl_per_cpu, mshv_vtl_per_cpu);
> +
> +static const struct file_operations mshv_vtl_fops;
> +
> +static long
> +mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
> +{
> +	struct mshv_vtl *vtl;
> +	struct file *file;
> +	int fd;
> +
> +	vtl =3D kzalloc(sizeof(*vtl), GFP_KERNEL);
> +	if (!vtl)
> +		return -ENOMEM;
> +
> +	fd =3D get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +	file =3D anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
> +				  vtl, O_RDWR);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +	refcount_set(&vtl->ref_count, 1);
> +	vtl->module_dev =3D module_dev;
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +}
> +
> +static long
> +mshv_ioctl_check_extension(void __user *user_arg)
> +{
> +	u32 arg;
> +
> +	if (copy_from_user(&arg, user_arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	switch (arg) {
> +	case MSHV_CAP_CORE_API_STABLE:
> +		return 0;
> +	case MSHV_CAP_REGISTER_PAGE:
> +		return mshv_has_reg_page;
> +	case MSHV_CAP_VTL_RETURN_ACTION:
> +		return mshv_vsm_capabilities.return_action_available;
> +	case MSHV_CAP_DR6_SHARED:
> +		return mshv_vsm_capabilities.dr6_shared;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static long
> +mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	struct miscdevice *misc =3D filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_CHECK_EXTENSION:
> +		return mshv_ioctl_check_extension((void __user *)arg);
> +	case MSHV_CREATE_VTL:
> +		return mshv_ioctl_create_vtl((void __user *)arg, misc-
> >this_device);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static const struct file_operations mshv_dev_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.unlocked_ioctl	=3D mshv_dev_ioctl,
> +	.llseek		=3D noop_llseek,
> +};
> +
> +static struct miscdevice mshv_dev =3D {
> +	.minor =3D MISC_DYNAMIC_MINOR,
> +	.name =3D "mshv",
> +	.fops =3D &mshv_dev_fops,
> +	.mode =3D 0600,
> +};
> +
> +static struct mshv_vtl_run *mshv_vtl_this_run(void)
> +{
> +	return *this_cpu_ptr(&mshv_vtl_per_cpu.run);
> +}
> +
> +static struct mshv_vtl_run *mshv_vtl_cpu_run(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.run, cpu);
> +}
> +
> +static struct page *mshv_vtl_cpu_reg_page(int cpu)
> +{
> +	return *per_cpu_ptr(&mshv_vtl_per_cpu.reg_page, cpu);
> +}
> +
> +static void mshv_vtl_configure_reg_page(struct mshv_vtl_per_cpu *per_cpu=
)
> +{
> +	struct hv_register_assoc reg_assoc =3D {};
> +	union mshv_synic_overlay_page_msr overlay =3D {};
> +	struct page *reg_page;
> +	union hv_input_vtl vtl =3D { .as_uint8 =3D 0 };
> +
> +	reg_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO |
> __GFP_RETRY_MAYFAIL);
> +	if (!reg_page) {
> +		WARN(1, "failed to allocate register page\n");
> +		return;
> +	}
> +
> +	overlay.enabled =3D 1;
> +	overlay.pfn =3D page_to_phys(reg_page) >> HV_HYP_PAGE_SHIFT;
> +	reg_assoc.name =3D HV_X64_REGISTER_REG_PAGE;
> +	reg_assoc.value.reg64 =3D overlay.as_u64;
> +
> +	if (hv_call_set_vp_registers(HV_VP_INDEX_SELF,
> HV_PARTITION_ID_SELF,
> +				     1, vtl, &reg_assoc)) {
> +		WARN(1, "failed to setup register page\n");
> +		__free_page(reg_page);
> +		return;
> +	}
> +
> +	per_cpu->reg_page =3D reg_page;
> +	mshv_has_reg_page =3D true;
> +}
> +
> +static void mshv_vtl_synic_enable_regs(unsigned int cpu)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D false;
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
> +	/* Enable intercepts */
> +	if (!mshv_vsm_capabilities.intercept_page_available)
> +		hv_set_msr(HV_MSR_SINT0 +
> HV_SYNIC_INTERCEPTION_SINT_INDEX,
> +			   sint.as_uint64);
> +
> +	/* VTL2 Host VSP SINT is (un)masked when the user mode requests
> that */
> +}
> +
> +static int mshv_vtl_get_vsm_regs(void)
> +{
> +	struct hv_register_assoc registers[2];
> +	union hv_input_vtl input_vtl;
> +	int ret, count =3D 2;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	registers[0].name =3D HV_REGISTER_VSM_CODE_PAGE_OFFSETS;
> +	registers[1].name =3D HV_REGISTER_VSM_CAPABILITIES;
> +
> +	ret =3D hv_call_get_vp_registers(HV_VP_INDEX_SELF,
> HV_PARTITION_ID_SELF,
> +				       count, input_vtl, registers);
> +	if (ret)
> +		return ret;
> +
> +	mshv_vsm_page_offsets.as_uint64 =3D registers[0].value.reg64;
> +	mshv_vsm_capabilities.as_uint64 =3D registers[1].value.reg64;
> +
> +	return ret;
> +}
> +
> +static int mshv_vtl_configure_vsm_partition(struct device *dev)
> +{
> +	union hv_register_vsm_partition_config config;
> +	struct hv_register_assoc reg_assoc;
> +	union hv_input_vtl input_vtl;
> +
> +	config.as_u64 =3D 0;
> +	config.default_vtl_protection_mask =3D
> HV_MAP_GPA_PERMISSIONS_MASK;
> +	config.enable_vtl_protection =3D 1;
> +	config.zero_memory_on_reset =3D 1;
> +	config.intercept_vp_startup =3D 1;
> +	config.intercept_cpuid_unimplemented =3D 1;
> +
> +	if (mshv_vsm_capabilities.intercept_page_available) {
> +		dev_dbg(dev, "using intercept page\n");
> +		config.intercept_page =3D 1;
> +	}
> +
> +	reg_assoc.name =3D HV_REGISTER_VSM_PARTITION_CONFIG;
> +	reg_assoc.value.reg64 =3D config.as_u64;
> +	input_vtl.as_uint8 =3D 0;
> +
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF,
> HV_PARTITION_ID_SELF,
> +				       1, input_vtl, &reg_assoc);
> +}
> +
> +static void mshv_vtl_vmbus_isr(void)
> +{
> +	struct hv_per_cpu_context *per_cpu;
> +	struct hv_message *msg;
> +	u32 message_type;
> +	union hv_synic_event_flags *event_flags;
> +	unsigned long word;
> +	int i, j;
> +	struct eventfd_ctx *eventfd;
> +
> +	per_cpu =3D this_cpu_ptr(hv_context.cpu_context);
> +	if (smp_processor_id() =3D=3D 0) {
> +		msg =3D (struct hv_message *)per_cpu->synic_message_page +
> VTL2_VMBUS_SINT_INDEX;
> +		message_type =3D READ_ONCE(msg->header.message_type);
> +		if (message_type !=3D HVMSG_NONE)
> +			tasklet_schedule(&msg_dpc);
> +	}
> +
> +	event_flags =3D (union hv_synic_event_flags *)per_cpu-
> >synic_event_page +
> +			VTL2_VMBUS_SINT_INDEX;
> +	for (i =3D 0; i < HV_EVENT_FLAGS_LONG_COUNT; i++) {
> +		if (READ_ONCE(event_flags->flags[i])) {
> +			word =3D xchg(&event_flags->flags[i], 0);
> +			for_each_set_bit(j, &word, BITS_PER_LONG) {
> +				rcu_read_lock();
> +				eventfd =3D READ_ONCE(flag_eventfds[i *
> BITS_PER_LONG + j]);
> +				if (eventfd)
> +					eventfd_signal(eventfd);
> +				rcu_read_unlock();
> +			}
> +		}
> +	}
> +
> +	vmbus_isr();
> +}
> +
> +static int mshv_vtl_alloc_context(unsigned int cpu)
> +{
> +	struct mshv_vtl_per_cpu *per_cpu =3D
> this_cpu_ptr(&mshv_vtl_per_cpu);
> +	struct page *run_page;
> +
> +	run_page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!run_page)
> +		return -ENOMEM;
> +
> +	per_cpu->run =3D page_address(run_page);
> +	if (mshv_vsm_capabilities.intercept_page_available)
> +		mshv_vtl_configure_reg_page(per_cpu);
> +
> +	mshv_vtl_synic_enable_regs(cpu);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_cpuhp_online;
> +
> +static int hv_vtl_setup_synic(void)
> +{
> +	int ret;
> +
> +	/* Use our isr to first filter out packets destined for userspace */
> +	hv_setup_vmbus_handler(mshv_vtl_vmbus_isr);
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> "hyperv/vtl:online",
> +				mshv_vtl_alloc_context, NULL);
> +	if (ret < 0) {
> +		hv_remove_vmbus_handler();
> +		return ret;
> +	}
> +
> +	mshv_vtl_cpuhp_online =3D ret;
> +	return 0;
> +}
> +
> +static void hv_vtl_remove_synic(void)
> +{
> +	hv_remove_vmbus_handler();
> +	cpuhp_remove_state(mshv_vtl_cpuhp_online);
> +}
> +
> +static int vtl_get_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	input_vtl.use_target_vtl =3D 1;
> +	return hv_call_get_vp_registers(HV_VP_INDEX_SELF,
> HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int vtl_set_vp_registers(u16 count,
> +				struct hv_register_assoc *registers)
> +{
> +	union hv_input_vtl input_vtl;
> +
> +	input_vtl.as_uint8 =3D 0;
> +	input_vtl.use_target_vtl =3D 1;
> +	return hv_call_set_vp_registers(HV_VP_INDEX_SELF,
> HV_PARTITION_ID_SELF,
> +					count, input_vtl, registers);
> +}
> +
> +static int mshv_vtl_ioctl_add_vtl0_mem(struct mshv_vtl *vtl, void __user
> *arg)
> +{
> +	struct mshv_vtl_ram_disposition vtl0_mem;
> +	struct dev_pagemap *pgmap;
> +	void *addr;
> +
> +	if (copy_from_user(&vtl0_mem, arg, sizeof(vtl0_mem)))
> +		return -EFAULT;
> +
> +	if (vtl0_mem.last_pfn <=3D vtl0_mem.start_pfn) {
> +		dev_err(vtl->module_dev, "range start pfn (%llx) > end pfn
> (%llx)\n",
> +			vtl0_mem.start_pfn, vtl0_mem.last_pfn);
> +		return -EFAULT;
> +	}
> +
> +	pgmap =3D kzalloc(sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
> +		return -ENOMEM;
> +
> +	pgmap->ranges[0].start =3D PFN_PHYS(vtl0_mem.start_pfn);
> +	pgmap->ranges[0].end =3D PFN_PHYS(vtl0_mem.last_pfn) - 1;
> +	pgmap->nr_range =3D 1;
> +	pgmap->type =3D MEMORY_DEVICE_GENERIC;
> +
> +	/*
> +	 * Determine the highest page order that can be used for the range.
> +	 * This works best when the range is aligned; i.e. start and length.
> +	 */
> +	pgmap->vmemmap_shift =3D count_trailing_zeros(vtl0_mem.start_pfn
> | vtl0_mem.last_pfn);
> +	dev_dbg(vtl->module_dev,
> +		"Add VTL0 memory: start: 0x%llx, end_pfn: 0x%llx, page
> order: %lu\n",
> +		vtl0_mem.start_pfn, vtl0_mem.last_pfn, pgmap-
> >vmemmap_shift);
> +
> +	addr =3D devm_memremap_pages(mem_dev, pgmap);
> +	if (IS_ERR(addr)) {
> +		dev_err(vtl->module_dev, "devm_memremap_pages error:
> %ld\n", PTR_ERR(addr));
> +		kfree(pgmap);
> +		return -EFAULT;
> +	}
> +
> +	/* Don't free pgmap, since it has to stick around until the memory
> +	 * is unmapped, which will never happen as there is no scenario
> +	 * where VTL0 can be released/shutdown without bringing down
> VTL2.
> +	 */
> +	return 0;
> +}
> +
> +static void mshv_vtl_cancel(int cpu)
> +{
> +	int here =3D get_cpu();
> +
> +	if (here !=3D cpu) {
> +		if (!xchg_relaxed(&mshv_vtl_cpu_run(cpu)->cancel, 1))
> +			smp_send_reschedule(cpu);
> +	} else {
> +		WRITE_ONCE(mshv_vtl_this_run()->cancel, 1);
> +	}
> +	put_cpu();
> +}
> +
> +static int mshv_vtl_poll_file_wake(wait_queue_entry_t *wait, unsigned in=
t
> mode, int sync, void *key)
> +{
> +	struct mshv_vtl_poll_file *poll_file =3D container_of(wait, struct
> mshv_vtl_poll_file, wait);
> +
> +	mshv_vtl_cancel(poll_file->cpu);
> +	return 0;
> +}
> +
> +static void mshv_vtl_ptable_queue_proc(struct file *file, wait_queue_hea=
d_t
> *wqh, poll_table *pt)
> +{
> +	struct mshv_vtl_poll_file *poll_file =3D container_of(pt, struct
> mshv_vtl_poll_file, pt);
> +
> +	WARN_ON(poll_file->wqh);
> +	poll_file->wqh =3D wqh;
> +	add_wait_queue(wqh, &poll_file->wait);
> +}
> +
> +static int mshv_vtl_ioctl_set_poll_file(struct mshv_vtl_set_poll_file __=
user
> *user_input)
> +{
> +	struct file *file, *old_file;
> +	struct mshv_vtl_poll_file *poll_file;
> +	struct mshv_vtl_set_poll_file input;
> +
> +	if (copy_from_user(&input, user_input, sizeof(input)))
> +		return -EFAULT;
> +
> +	if (!cpu_online(input.cpu))
> +		return -EINVAL;
> +
> +	file =3D NULL;
> +	if (input.fd >=3D 0) {
> +		file =3D fget(input.fd);
> +		if (!file)
> +			return -EBADFD;
> +	}
> +
> +	poll_file =3D per_cpu_ptr(&mshv_vtl_poll_file, input.cpu);
> +
> +	mutex_lock(&mshv_vtl_poll_file_lock);
> +
> +	if (poll_file->wqh)
> +		remove_wait_queue(poll_file->wqh, &poll_file->wait);
> +	poll_file->wqh =3D NULL;
> +
> +	old_file =3D poll_file->file;
> +	poll_file->file =3D file;
> +	poll_file->cpu =3D input.cpu;
> +
> +	if (file) {
> +		init_waitqueue_func_entry(&poll_file->wait,
> mshv_vtl_poll_file_wake);
> +		init_poll_funcptr(&poll_file->pt,
> mshv_vtl_ptable_queue_proc);
> +		vfs_poll(file, &poll_file->pt);
> +	}
> +
> +	mutex_unlock(&mshv_vtl_poll_file_lock);
> +
> +	if (old_file)
> +		fput(old_file);
> +
> +	return 0;
> +}
> +
> +static int mshv_vtl_set_reg(struct hv_register_assoc *regs)
> +{
> +	u64 reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		native_set_debugreg(0, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		native_set_debugreg(1, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		native_set_debugreg(2, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		native_set_debugreg(3, reg64);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		native_set_debugreg(6, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		wrmsrl(MSR_MTRRcap, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		wrmsrl(MSR_MTRRdefType, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		wrmsrl(MTRRphysBase_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		wrmsrl(MTRRphysBase_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		wrmsrl(MTRRphysBase_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		wrmsrl(MTRRphysBase_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		wrmsrl(MTRRphysBase_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		wrmsrl(MTRRphysBase_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		wrmsrl(MTRRphysBase_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		wrmsrl(MTRRphysBase_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		wrmsrl(MTRRphysBase_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		wrmsrl(MTRRphysBase_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		wrmsrl(MTRRphysBase_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		wrmsrl(MTRRphysBase_MSR(0xb), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		wrmsrl(MTRRphysBase_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		wrmsrl(MTRRphysBase_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		wrmsrl(MTRRphysBase_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		wrmsrl(MTRRphysBase_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		wrmsrl(MTRRphysMask_MSR(0), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		wrmsrl(MTRRphysMask_MSR(1), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		wrmsrl(MTRRphysMask_MSR(2), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		wrmsrl(MTRRphysMask_MSR(3), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		wrmsrl(MTRRphysMask_MSR(4), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		wrmsrl(MTRRphysMask_MSR(5), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		wrmsrl(MTRRphysMask_MSR(6), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		wrmsrl(MTRRphysMask_MSR(7), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		wrmsrl(MTRRphysMask_MSR(8), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		wrmsrl(MTRRphysMask_MSR(9), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		wrmsrl(MTRRphysMask_MSR(0xa), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		wrmsrl(MTRRphysMask_MSR(0xc), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		wrmsrl(MTRRphysMask_MSR(0xd), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		wrmsrl(MTRRphysMask_MSR(0xe), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		wrmsrl(MTRRphysMask_MSR(0xf), reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		wrmsrl(MSR_MTRRfix64K_00000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		wrmsrl(MSR_MTRRfix16K_80000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		wrmsrl(MSR_MTRRfix16K_A0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		wrmsrl(MSR_MTRRfix4K_C0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		wrmsrl(MSR_MTRRfix4K_C8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		wrmsrl(MSR_MTRRfix4K_D0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		wrmsrl(MSR_MTRRfix4K_D8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		wrmsrl(MSR_MTRRfix4K_E0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		wrmsrl(MSR_MTRRfix4K_E8000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		wrmsrl(MSR_MTRRfix4K_F0000, reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		wrmsrl(MSR_MTRRfix4K_F8000, reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static int mshv_vtl_get_reg(struct hv_register_assoc *regs)
> +{
> +	u64 *reg64;
> +	enum hv_register_name gpr_name;
> +
> +	gpr_name =3D regs->name;
> +	reg64 =3D (u64 *)&regs->value.reg64;
> +
> +	switch (gpr_name) {
> +	case HV_X64_REGISTER_DR0:
> +		*reg64 =3D native_get_debugreg(0);
> +		break;
> +	case HV_X64_REGISTER_DR1:
> +		*reg64 =3D native_get_debugreg(1);
> +		break;
> +	case HV_X64_REGISTER_DR2:
> +		*reg64 =3D native_get_debugreg(2);
> +		break;
> +	case HV_X64_REGISTER_DR3:
> +		*reg64 =3D native_get_debugreg(3);
> +		break;
> +	case HV_X64_REGISTER_DR6:
> +		if (!mshv_vsm_capabilities.dr6_shared)
> +			goto hypercall;
> +		*reg64 =3D native_get_debugreg(6);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_CAP:
> +		rdmsrl(MSR_MTRRcap, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_DEF_TYPE:
> +		rdmsrl(MSR_MTRRdefType, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0:
> +		rdmsrl(MTRRphysBase_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1:
> +		rdmsrl(MTRRphysBase_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2:
> +		rdmsrl(MTRRphysBase_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3:
> +		rdmsrl(MTRRphysBase_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4:
> +		rdmsrl(MTRRphysBase_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5:
> +		rdmsrl(MTRRphysBase_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6:
> +		rdmsrl(MTRRphysBase_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7:
> +		rdmsrl(MTRRphysBase_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8:
> +		rdmsrl(MTRRphysBase_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9:
> +		rdmsrl(MTRRphysBase_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA:
> +		rdmsrl(MTRRphysBase_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB:
> +		rdmsrl(MTRRphysBase_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC:
> +		rdmsrl(MTRRphysBase_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASED:
> +		rdmsrl(MTRRphysBase_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE:
> +		rdmsrl(MTRRphysBase_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF:
> +		rdmsrl(MTRRphysBase_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0:
> +		rdmsrl(MTRRphysMask_MSR(0), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1:
> +		rdmsrl(MTRRphysMask_MSR(1), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2:
> +		rdmsrl(MTRRphysMask_MSR(2), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3:
> +		rdmsrl(MTRRphysMask_MSR(3), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4:
> +		rdmsrl(MTRRphysMask_MSR(4), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5:
> +		rdmsrl(MTRRphysMask_MSR(5), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6:
> +		rdmsrl(MTRRphysMask_MSR(6), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7:
> +		rdmsrl(MTRRphysMask_MSR(7), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8:
> +		rdmsrl(MTRRphysMask_MSR(8), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9:
> +		rdmsrl(MTRRphysMask_MSR(9), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA:
> +		rdmsrl(MTRRphysMask_MSR(0xa), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB:
> +		rdmsrl(MTRRphysMask_MSR(0xb), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC:
> +		rdmsrl(MTRRphysMask_MSR(0xc), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD:
> +		rdmsrl(MTRRphysMask_MSR(0xd), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE:
> +		rdmsrl(MTRRphysMask_MSR(0xe), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF:
> +		rdmsrl(MTRRphysMask_MSR(0xf), *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX64K00000:
> +		rdmsrl(MSR_MTRRfix64K_00000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16K80000:
> +		rdmsrl(MSR_MTRRfix16K_80000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX16KA0000:
> +		rdmsrl(MSR_MTRRfix16K_A0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC0000:
> +		rdmsrl(MSR_MTRRfix4K_C0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KC8000:
> +		rdmsrl(MSR_MTRRfix4K_C8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD0000:
> +		rdmsrl(MSR_MTRRfix4K_D0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KD8000:
> +		rdmsrl(MSR_MTRRfix4K_D8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE0000:
> +		rdmsrl(MSR_MTRRfix4K_E0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KE8000:
> +		rdmsrl(MSR_MTRRfix4K_E8000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF0000:
> +		rdmsrl(MSR_MTRRfix4K_F0000, *reg64);
> +		break;
> +	case HV_X64_REGISTER_MSR_MTRR_FIX4KF8000:
> +		rdmsrl(MSR_MTRRfix4K_F8000, *reg64);
> +		break;
> +
> +	default:
> +		goto hypercall;
> +	}
> +
> +	return 0;
> +
> +hypercall:
> +	return 1;
> +}
> +
> +static void mshv_vtl_return(struct mshv_vtl_cpu_context *vtl0)
> +{
> +	struct hv_vp_assist_page *hvp;
> +	u64 hypercall_addr;
> +
> +	register u64 r8 asm("r8");
> +	register u64 r9 asm("r9");
> +	register u64 r10 asm("r10");
> +	register u64 r11 asm("r11");
> +	register u64 r12 asm("r12");
> +	register u64 r13 asm("r13");
> +	register u64 r14 asm("r14");
> +	register u64 r15 asm("r15");
> +
> +	hvp =3D hv_vp_assist_page[smp_processor_id()];
> +
> +	/*
> +	 * Process signal event direct set in the run page, if any.
> +	 */
> +	if (mshv_vsm_capabilities.return_action_available) {
> +		u32 offset =3D READ_ONCE(mshv_vtl_this_run()-
> >vtl_ret_action_size);
> +
> +		WRITE_ONCE(mshv_vtl_this_run()->vtl_ret_action_size, 0);
> +
> +		/*
> +		 * Hypervisor will take care of clearing out the actions
> +		 * set in the assist page.
> +		 */
> +		memcpy(hvp->vtl_ret_actions,
> +		       mshv_vtl_this_run()->vtl_ret_actions,
> +		       min_t(u32, offset, sizeof(hvp->vtl_ret_actions)));
> +	}
> +
> +	hvp->vtl_ret_x64rax =3D vtl0->rax;
> +	hvp->vtl_ret_x64rcx =3D vtl0->rcx;
> +
> +	hypercall_addr =3D (u64)((u8 *)hv_hypercall_pg +
> mshv_vsm_page_offsets.vtl_return_offset);
> +
> +	kernel_fpu_begin_mask(0);
> +	fxrstor(&vtl0->fx_state);
> +	native_write_cr2(vtl0->cr2);
> +	r8 =3D vtl0->r8;
> +	r9 =3D vtl0->r9;
> +	r10 =3D vtl0->r10;
> +	r11 =3D vtl0->r11;
> +	r12 =3D vtl0->r12;
> +	r13 =3D vtl0->r13;
> +	r14 =3D vtl0->r14;
> +	r15 =3D vtl0->r15;
> +
> +	asm __volatile__ (	\
> +	/* Save rbp pointer to the lower VTL, keep the stack 16-byte aligned */
> +		"pushq	%%rbp\n"
> +		"pushq	%%rcx\n"
> +	/* Restore the lower VTL's rbp */
> +		"movq	(%%rcx), %%rbp\n"
> +	/* Load return kind into rcx
> (HV_VTL_RETURN_INPUT_NORMAL_RETURN =3D=3D 0) */
> +		"xorl	%%ecx, %%ecx\n"
> +	/* Transition to the lower VTL */
> +		CALL_NOSPEC
> +	/* Save VTL0's rax and rcx temporarily on 16-byte aligned stack */
> +		"pushq	%%rax\n"
> +		"pushq	%%rcx\n"
> +	/* Restore pointer to lower VTL rbp */
> +		"movq	16(%%rsp), %%rax\n"
> +	/* Save the lower VTL's rbp */
> +		"movq	%%rbp, (%%rax)\n"
> +	/* Restore saved registers */
> +		"movq	8(%%rsp), %%rax\n"
> +		"movq	24(%%rsp), %%rbp\n"
> +		"addq	$32, %%rsp\n"
> +
> +		: "=3Da"(vtl0->rax), "=3Dc"(vtl0->rcx),
> +		  "+d"(vtl0->rdx), "+b"(vtl0->rbx), "+S"(vtl0->rsi), "+D"(vtl0-
> >rdi),
> +		  "+r"(r8), "+r"(r9), "+r"(r10), "+r"(r11),
> +		  "+r"(r12), "+r"(r13), "+r"(r14), "+r"(r15)
> +		: THUNK_TARGET(hypercall_addr), "c"(&vtl0->rbp)
> +		: "cc", "memory");
> +
> +	vtl0->r8 =3D r8;
> +	vtl0->r9 =3D r9;
> +	vtl0->r10 =3D r10;
> +	vtl0->r11 =3D r11;
> +	vtl0->r12 =3D r12;
> +	vtl0->r13 =3D r13;
> +	vtl0->r14 =3D r14;
> +	vtl0->r15 =3D r15;
> +	vtl0->cr2 =3D native_read_cr2();
> +
> +	fxsave(&vtl0->fx_state);
> +	kernel_fpu_end();
> +}
> +
> +/*
> + * Returning to a lower VTL treats the base pointer register
> + * as a general purpose one. Without adding this, objtool produces
> + * a warning.
> + */
> +STACK_FRAME_NON_STANDARD(mshv_vtl_return);
> +
> +static bool mshv_vtl_process_intercept(void)
> +{
> +	struct hv_per_cpu_context *mshv_cpu;
> +	void *synic_message_page;
> +	struct hv_message *msg;
> +	u32 message_type;
> +
> +	mshv_cpu =3D this_cpu_ptr(hv_context.cpu_context);
> +	synic_message_page =3D mshv_cpu->synic_message_page;
> +	if (unlikely(!synic_message_page))
> +		return true;
> +
> +	msg =3D (struct hv_message *)synic_message_page +
> HV_SYNIC_INTERCEPTION_SINT_INDEX;
> +	message_type =3D READ_ONCE(msg->header.message_type);
> +	if (message_type =3D=3D HVMSG_NONE)
> +		return true;
> +
> +	memcpy(mshv_vtl_this_run()->exit_message, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +	return false;
> +}
> +
> +static int mshv_vtl_ioctl_return_to_lower_vtl(void)
> +{
> +	preempt_disable();
> +	for (;;) {
> +		const unsigned long VTL0_WORK =3D _TIF_SIGPENDING |
> _TIF_NEED_RESCHED |
> +						_TIF_NOTIFY_RESUME |
> _TIF_NOTIFY_SIGNAL;
> +		unsigned long ti_work;
> +		u32 cancel;
> +		unsigned long irq_flags;
> +		struct hv_vp_assist_page *hvp;
> +		int ret;
> +
> +		local_irq_save(irq_flags);
> +		ti_work =3D READ_ONCE(current_thread_info()->flags);
> +		cancel =3D READ_ONCE(mshv_vtl_this_run()->cancel);
> +		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
> +			local_irq_restore(irq_flags);
> +			preempt_enable();
> +			if (cancel)
> +				ti_work |=3D _TIF_SIGPENDING;
> +			ret =3D mshv_do_pre_guest_mode_work(ti_work);
> +			if (ret)
> +				return ret;
> +			preempt_disable();
> +			continue;
> +		}
> +
> +		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
> +		local_irq_restore(irq_flags);
> +
> +		hvp =3D hv_vp_assist_page[smp_processor_id()];
> +		this_cpu_inc(num_vtl0_transitions);
> +		switch (hvp->vtl_entry_reason) {
> +		case MSHV_ENTRY_REASON_INTERRUPT:
> +			if (!mshv_vsm_capabilities.intercept_page_available
> &&
> +			    likely(!mshv_vtl_process_intercept()))
> +				goto done;
> +			break;
> +
> +		case MSHV_ENTRY_REASON_INTERCEPT:
> +
> 	WARN_ON(!mshv_vsm_capabilities.intercept_page_available);
> +			memcpy(mshv_vtl_this_run()->exit_message, hvp-
> >intercept_message,
> +			       sizeof(hvp->intercept_message));
> +			goto done;
> +
> +		default:
> +			panic("unknown entry reason: %d", hvp-
> >vtl_entry_reason);
> +		}
> +	}
> +
> +done:
> +	preempt_enable();
> +	return 0;
> +}
> +
> +static long
> +mshv_vtl_ioctl_get_set_regs(void __user *user_args, bool set)
> +{
> +	struct mshv_vp_registers args;
> +	struct hv_register_assoc *registers;
> +	long ret;
> +
> +	if (copy_from_user(&args, user_args, sizeof(args)))
> +		return -EFAULT;
> +
> +	if (args.count =3D=3D 0 || args.count > MSHV_VP_MAX_REGISTERS)
> +		return -EINVAL;
> +
> +	registers =3D kmalloc_array(args.count,
> +				  sizeof(*registers),
> +				  GFP_KERNEL);
> +	if (!registers)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(registers, (void __user *)args.regs_ptr,
> +			   sizeof(*registers) * args.count)) {
> +		ret =3D -EFAULT;
> +		goto free_return;
> +	}
> +
> +	if (set) {
> +		ret =3D mshv_vtl_set_reg(registers);
> +		if (!ret)
> +			goto free_return; /* No need of hypercall */
> +		ret =3D vtl_set_vp_registers(args.count, registers);
> +
> +	} else {
> +		ret =3D mshv_vtl_get_reg(registers);
> +		if (!ret)
> +			goto copy_args; /* No need of hypercall */
> +		ret =3D vtl_get_vp_registers(args.count, registers);
> +		if (ret)
> +			goto free_return;
> +
> +copy_args:
> +		if (copy_to_user((void __user *)args.regs_ptr, registers,
> +				 sizeof(*registers) * args.count))
> +			ret =3D -EFAULT;
> +	}
> +
> +free_return:
> +	kfree(registers);
> +	return ret;
> +}
> +
> +static inline long
> +mshv_vtl_ioctl_set_regs(void __user *user_args)
> +{
> +	return mshv_vtl_ioctl_get_set_regs(user_args, true);
> +}
> +
> +static inline long
> +mshv_vtl_ioctl_get_regs(void __user *user_args)
> +{
> +	return mshv_vtl_ioctl_get_set_regs(user_args, false);
> +}
> +
> +static long
> +mshv_vtl_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
> +{
> +	long ret;
> +	struct mshv_vtl *vtl =3D filp->private_data;
> +
> +	switch (ioctl) {
> +	case MSHV_VTL_SET_POLL_FILE:
> +		ret =3D mshv_vtl_ioctl_set_poll_file((struct
> mshv_vtl_set_poll_file *)arg);
> +		break;
> +	case MSHV_GET_VP_REGISTERS:
> +		ret =3D mshv_vtl_ioctl_get_regs((void __user *)arg);
> +		break;
> +	case MSHV_SET_VP_REGISTERS:
> +		ret =3D mshv_vtl_ioctl_set_regs((void __user *)arg);
> +		break;
> +	case MSHV_VTL_RETURN_TO_LOWER_VTL:
> +		ret =3D mshv_vtl_ioctl_return_to_lower_vtl();
> +		break;
> +	case MSHV_VTL_ADD_VTL0_MEMORY:
> +		ret =3D mshv_vtl_ioctl_add_vtl0_mem(vtl, (void __user *)arg);
> +		break;
> +	default:
> +		dev_err(vtl->module_dev, "invalid vtl ioctl: %#x\n", ioctl);
> +		ret =3D -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
> +{
> +	struct page *page;
> +	int cpu =3D vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
> +	int real_off =3D vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
> +
> +	if (!cpu_online(cpu))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (real_off =3D=3D MSHV_RUN_PAGE_OFFSET) {
> +		page =3D virt_to_page(mshv_vtl_cpu_run(cpu));
> +	} else if (real_off =3D=3D MSHV_REG_PAGE_OFFSET) {
> +		if (!mshv_has_reg_page)
> +			return VM_FAULT_SIGBUS;
> +		page =3D mshv_vtl_cpu_reg_page(cpu);
> +	} else {
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	get_page(page);
> +	vmf->page =3D page;
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct mshv_vtl_vm_ops =3D {
> +	.fault =3D mshv_vtl_fault,
> +};
> +
> +static int mshv_vtl_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	vma->vm_ops =3D &mshv_vtl_vm_ops;
> +	return 0;
> +}
> +
> +static int mshv_vtl_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_vtl *vtl =3D filp->private_data;
> +
> +	kfree(vtl);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_vtl_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.unlocked_ioctl =3D mshv_vtl_ioctl,
> +	.release =3D mshv_vtl_release,
> +	.mmap =3D mshv_vtl_mmap,
> +};
> +
> +static void mshv_vtl_synic_mask_vmbus_sint(const u8 *mask)
> +{
> +	union hv_synic_sint sint;
> +
> +	sint.as_uint64 =3D 0;
> +	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.masked =3D (*mask !=3D 0);
> +	sint.auto_eoi =3D hv_recommend_using_aeoi();
> +
> +	hv_set_msr(HV_MSR_SINT0 + VTL2_VMBUS_SINT_INDEX,
> +		   sint.as_uint64);
> +
> +	if (!sint.masked)
> +		pr_debug("%s: Unmasking VTL2 VMBUS SINT on VP %d\n",
> __func__, smp_processor_id());
> +	else
> +		pr_debug("%s: Masking VTL2 VMBUS SINT on VP %d\n",
> __func__, smp_processor_id());
> +}
> +
> +static void mshv_vtl_read_remote(void *buffer)
> +{
> +	struct hv_per_cpu_context *mshv_cpu =3D
> this_cpu_ptr(hv_context.cpu_context);
> +	struct hv_message *msg =3D (struct hv_message *)mshv_cpu-
> >synic_message_page +
> +					VTL2_VMBUS_SINT_INDEX;
> +	u32 message_type =3D READ_ONCE(msg->header.message_type);
> +
> +	WRITE_ONCE(has_message, false);
> +	if (message_type =3D=3D HVMSG_NONE)
> +		return;
> +
> +	memcpy(buffer, msg, sizeof(*msg));
> +	vmbus_signal_eom(msg, message_type);
> +}
> +
> +static bool vtl_synic_mask_vmbus_sint_masked =3D true;
> +
> +static ssize_t mshv_vtl_sint_read(struct file *filp, char __user *arg, s=
ize_t size,
> loff_t *offset)
> +{
> +	struct hv_message msg =3D {};
> +	int ret;
> +
> +	if (size < sizeof(msg))
> +		return -EINVAL;
> +
> +	for (;;) {
> +		smp_call_function_single(VMBUS_CONNECT_CPU,
> mshv_vtl_read_remote, &msg, true);
> +		if (msg.header.message_type !=3D HVMSG_NONE)
> +			break;
> +
> +		if (READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
> +			return 0; /* EOF */
> +
> +		if (filp->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret =3D wait_event_interruptible(fd_wait_queue,
> +					       READ_ONCE(has_message) ||
> +
> 	READ_ONCE(vtl_synic_mask_vmbus_sint_masked));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (copy_to_user(arg, &msg, sizeof(msg)))
> +		return -EFAULT;
> +
> +	return sizeof(msg);
> +}
> +
> +static __poll_t mshv_vtl_sint_poll(struct file *filp, poll_table *wait)
> +{
> +	__poll_t mask =3D 0;
> +
> +	poll_wait(filp, &fd_wait_queue, wait);
> +	if (READ_ONCE(has_message) ||
> READ_ONCE(vtl_synic_mask_vmbus_sint_masked))
> +		mask |=3D EPOLLIN | EPOLLRDNORM;
> +
> +	return mask;
> +}
> +
> +static void mshv_vtl_sint_on_msg_dpc(unsigned long data)
> +{
> +	WRITE_ONCE(has_message, true);
> +	wake_up_interruptible_poll(&fd_wait_queue, EPOLLIN);
> +}
> +
> +static int mshv_vtl_sint_ioctl_post_message(struct mshv_vtl_sint_post_ms=
g
> __user *arg)
> +{
> +	struct mshv_vtl_sint_post_msg message;
> +	u8 payload[HV_MESSAGE_PAYLOAD_BYTE_COUNT];
> +
> +	if (copy_from_user(&message, arg, sizeof(message)))
> +		return -EFAULT;
> +	if (message.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT)
> +		return -EINVAL;
> +	if (copy_from_user(payload, (void __user *)message.payload_ptr,
> +			   message.payload_size))
> +		return -EFAULT;
> +
> +	return hv_post_message((union

This function definition is in separate file which can be build as independ=
ent module, this will cause
problem while linking . Try building with CONFIG_HYPERV=3Dm and check.

- Saurabh

