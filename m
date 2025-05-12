Return-Path: <linux-hyperv+bounces-5471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBECAB3A28
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF016B7CF
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559119E82A;
	Mon, 12 May 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VkEPvr8o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022107.outbound.protection.outlook.com [52.101.126.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDB1E32DB;
	Mon, 12 May 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059179; cv=fail; b=eiKqg98f1BxlPQBmCXeJfc1Pcz+xHDo0BMI0uBpPS/B++x/jCoTW7mOiO1yKCkHVQLPUHBcsYT1Df4lvcWlUKUrJ/GABuGfKE61RrymRvjwGqxlbXqxd6IRC8vmqRuNc74fAGXMaBthSmDOLjm97yMhKNpwjRQH8l3PU+h+fY8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059179; c=relaxed/simple;
	bh=ZePCN6PJGnqvZgYT0YE12C0a0i56Joz5l9sFFw0/AiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVlROvTeQxyMrfvNYabcNnGikjVLnPQQpCg0jpVCw8x9S2Wxakakmv1YIcmp8bSgMhNSXWg475KD4n32lgjDU60hjXnXamDAM5zic9oqch+EOa+snsA/DAsVT1yyos2q16kL74somEOH38TNrKp+nrs8nQhfIMxUgxe4DxeBDEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VkEPvr8o; arc=fail smtp.client-ip=52.101.126.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRmJdWgnVZw2dUHWRJ6+0W7CKHAdzcVjFLnUo5QS6fkLlcPg3841azR5VOuAKYgUOBGU2ZZTFAMkvXDHenLGsT0+FhQ9UaPwdhLKEqUZ3OwjV6xwVTZfzhnBtzXLarD8rg8hwqDC3bNwKtcrDBYNg5l6XazSqqu/bixuQYgnv9wTY5/Kcu7kYqsYXvuDPn5xpGLPXLi1w9TEFKToi1yQSCpdU1kunuBQ3v9Z7MNze8LVND8ecWSKMFhuqsK30qYYE5R7p/go95Vvttbjf1N+6G1VeQvzUT00XR9RYUcnyHPC0piDVwVaWqUr6F+ZDwTCIuvBxAIJhLKOzcGzp/WWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/+nbS+P9DilWgcDfSc1E+6tyWK4/A1xI6ZFUeOaKwA=;
 b=iV8f06eNunkmPuddZvRfv6l6ev0/BWiYR8I7hzYB/yA+zTJTkDU4UpRz2qmRc5M3kOQFjPjvNxOfvVWyxbhAWamncXNPOLwdX5iOqiJePbFe2eu4hKqs0FhLjJHLnuIXiYPgr9y0phPApzJrXgPR8++s5S0HysRdv9E0YZpD5Tv/tUkEcPQWKyaNArBrQr6ZUDUHDMaJd0IHSt4Y6B9dJoIqgyoJk/FscosjiypaLuOaR7aKfpUwZ3fOtw7AExrk/GY0Wt7AzAu52WS9OhBDxkwp+zPO3lI37HpmVfnUoPWrXUv/c4ErQJYRXaicG1ightc0ugqn7sNsHEs+tZ7SIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/+nbS+P9DilWgcDfSc1E+6tyWK4/A1xI6ZFUeOaKwA=;
 b=VkEPvr8oR6VYnWhcyI2uhAaJj7Zpo/8mnP7/fhcJRt/8jan4lHNkTLYW93GL0x39BSd+QCctWpuHvZmSbJz79zTQ+prSdl1kOBjEbJSy0C7N7CVEfrNrESDq5w+NHPVccIYjCIM0uLVnvq733mmjUTdPZ5F+ys71PhxApME+p8Q=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by TYPP153MB1390.APCP153.PROD.OUTLOOK.COM (2603:1096:405:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.12; Mon, 12 May
 2025 14:12:53 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%6]) with mapi id 15.20.8769.001; Mon, 12 May 2025
 14:12:53 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: Roman Kisel <romank@linux.microsoft.com>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH v2 2/2] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbw0balE8ou3EfWkKGet9I/0BCUbPPCBnA
Date: Mon, 12 May 2025 14:12:52 +0000
Message-ID:
 <KUZP153MB1444CF7C66D521208B0CAC76BE97A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250512140432.2387503-1-namjain@linux.microsoft.com>
 <20250512140432.2387503-3-namjain@linux.microsoft.com>
In-Reply-To: <20250512140432.2387503-3-namjain@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0364dea1-121f-4b21-af3a-518a23f77dc7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-12T14:08:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|TYPP153MB1390:EE_
x-ms-office365-filtering-correlation-id: e553b035-d4c4-4979-0c38-08dd915f15ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x5bGZmumjlb8jZAhLAnniW9h0g1Dy0rHUMW+QfvJXTUN5msNrFHjaKsdQ5zo?=
 =?us-ascii?Q?540wU86+ItFcus5zWhXdirp+FoFCjRCQviSdlHS3TrNrNixzwWHT0SX2auiu?=
 =?us-ascii?Q?vo61IcCeuPTjnqst9K0mzM+t8Ef5UWqRZDzNvsqQS39zV8eK7CMUqLS+VM7/?=
 =?us-ascii?Q?AHPvvx2KkXLOyQG2zF4N5j1VE/WOqyg62yxHWww+gSb5GR3frSozx0EhaXa7?=
 =?us-ascii?Q?LHUol0e20dX8mEwloKO9jqYP25hEIR7mKkqzSVm7y+x6cNPd3ACMOVHPj1K6?=
 =?us-ascii?Q?ZcCobCo82hy7yVPGKqVJxfj4+WphEPsmwpF+g3KdtHSgw3eyZbWhDHaoZFLO?=
 =?us-ascii?Q?oUS3kcLTT89ZXeedBV7QZqUDeIzvqIbpu0pK8x90gTWdp2JWljQFOrQd/O0y?=
 =?us-ascii?Q?ktp7v1MZnsHQ9nIB9PR60nZAXbflL1UYV/8CF6TBRSGBIIBMw0g3HrbnVGg9?=
 =?us-ascii?Q?ycI/OdevyNyE8sgYV0V1WkHlqhdzUJT7hE2gLITXHHtSFdCPQAj79OObNCfF?=
 =?us-ascii?Q?2/y1A5WhCzdoSPtteLLRxXoZ0at035EA5H0XdF6SWOPu4cX8fIE8y67qveF0?=
 =?us-ascii?Q?mGHAzk3OsFYg//SmD08CV21MjUKsABUjE+UYOFxQzVNGmNq6tx6py1KVz+hM?=
 =?us-ascii?Q?yuTVhCP5tSSy/CrAHiOId3RWQhC0Nbh1p8KyaCJiVE2TKw2L0yC0QPKHKChH?=
 =?us-ascii?Q?sVqoB9ijXH1kf9bR3Y6Tj4Xvje5KP5tmQ95Kf5yjpkfuRvfCZu353KZ5MoCW?=
 =?us-ascii?Q?JQl6PtfEAF+3TbA8p7oy6hexpV4TdWyDvTNucw2nsZr8f+QrOTbXwR5xftAY?=
 =?us-ascii?Q?ggb/BAW4Y55xInP4WcbMEqbjsy8J7Tet2RCDOBQ1sMDdn1ylSSN8zFaBtGav?=
 =?us-ascii?Q?HGsKlWEA7lumKSjmOzjsdtPEHzqVxL7/8LyefY5dx01ZLtCgo5QyQaXwk0HH?=
 =?us-ascii?Q?gys/mICDcuVYJzgDojb1uVAWVLJGHqyWxpHpj/EPgkDT0WoH7OlNAM16TG3b?=
 =?us-ascii?Q?yrIaBvLVtDUwJR0H7tT8gkxqOuhc3Ut7j05sCk7Gve57sG8NZo7C5hVKnB2m?=
 =?us-ascii?Q?FQ9VkTkOMq/XYmyQs49aaW7ZWNUQmVVBJCK84VQxjDVXF+pmKI31lGo9O5+K?=
 =?us-ascii?Q?wWt6nFJjmWWnox2PwiHrYE2QIKOaRnDIREai/dIJ9SFCEhxfECJvns9PlN2T?=
 =?us-ascii?Q?aDTMFvVt5e6E0t8iZ2hlWUJgD5H9YfdBZoDJn0HaoAVyS3ljdQj1YCDgl5Zr?=
 =?us-ascii?Q?6DHPBgYOBzZ0y6s+0dPEOWAd4U8e0XoDvTZPlfz4LXGwlm0SOzmtw2vF7mXn?=
 =?us-ascii?Q?v0fiY7zkdNeTN3a06yupbtBpxNnYAtcbZTpTwl9pRCbeF8uvKn2TiQ7YCRMB?=
 =?us-ascii?Q?Lx2oVb1Hb8L9Ons5a6X2FWt01rs7k2s8NvhtKhzW09p0PBVPI7zwO93DkeAQ?=
 =?us-ascii?Q?0a9Jg0N26Am+WF/Vq7Y+2uMTPZA+j80l8RAmv+Qt4xG3+ZzreYr27A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5+VLfLBTBJZugDlA+XCIT4g4/yvzD1Szqz9EGBT4M8XT3EYt2s9ZhRgypGi5?=
 =?us-ascii?Q?OIYbJNJ1MtFgMkVX4TPWVrO5qVDnjMqSIeAvDBIFzKnZTBWl6rRp9B0jp5GR?=
 =?us-ascii?Q?6Kdm2Oi5jtZzM/pVeaNgcihPPxNfUZQhO2Gz1uOFOMCaw+MTcVjksroNQhI4?=
 =?us-ascii?Q?qqpBRNOgIJ6zF+D4QL6w2fhiHb7cRvQkjnNZuI5bPj/uqMTD9cAvz64Ovn/c?=
 =?us-ascii?Q?K4ykbq6rSndoCUinaXqNPLONC/KmO4puOe9f5WjjFqwK/KXYLqJbFDQDrbjV?=
 =?us-ascii?Q?cSc9rLrd7nFVVVan3l4rQP4WF6i9CHa7D9vNHyvYJeqPgt/54DFA76wzH80/?=
 =?us-ascii?Q?K7i0zWXFPggft5ipMgMvhseIZuRG76b2HL8cHxLeRexHtWwylRb2Vc8E5/8z?=
 =?us-ascii?Q?OdAhoev94ygy8DhAGXSAI7eXHOw4MWQi4r30O4vDUTk54RWQiVxeN3aXsoCo?=
 =?us-ascii?Q?JyhWohxYubjSJWA6Te0cFUJQ4NxL0naB65+9gwjrhRZCtTklLU3u+F98qw/H?=
 =?us-ascii?Q?poJg2cG7mk9j88UGTO4Y6i+RgPyICd4pZrNLr3LgrD7coa7eksv9VZBzmlkH?=
 =?us-ascii?Q?V/o7EX86VDpMd4fa5JLuApTENU7SHqW+CLYWNfmprstuu7tlqQo68JuRubiI?=
 =?us-ascii?Q?s8iLN3yasFF7Y9Vx7RvO5S1WEvHO3wje9VP9jsZj4VODNAJO153GiviRzOG4?=
 =?us-ascii?Q?A6Vzhm2e++sHDhPSOiSY1KyximUfEKm6IKB+lBAZBnTy9kuRK5ba0SWzmMhW?=
 =?us-ascii?Q?x1d40a8IqXA3lYjeAEem1E9cc/HidewzBYwqpNLg4bPGNwNgJZ1JsXgD8kkm?=
 =?us-ascii?Q?shR6X+Crhig89Qvrg36I9Cnwax6veG046Baf3V5g7W6gnnU+5KJBsUN+R1WZ?=
 =?us-ascii?Q?nMOk+1zd5x192g86meVglkAE7ADk5vEm+TThTq/v1Sl4e0R1rzHUnHlrOgUQ?=
 =?us-ascii?Q?3EwXcoIKAbp6RPpkm8dsLH7cgLzJAqW2aUWinqiM/2mqW5lVXutegAFWW1Ja?=
 =?us-ascii?Q?cH0E3AHHoXJBQaxAlamCc/jqJNwVPUQtb5fPaaZZY4WKhZn0xml5P6ixXOw1?=
 =?us-ascii?Q?RMUhtL/w5abyI4hGcbLmU5AyHRMn2w6KQtgEOsq1pIA1uSo4wnygmxFE5hIB?=
 =?us-ascii?Q?88HkQ4A5sQi1aQ/pxyf3n/Rjfu/KRpUQIpZC0NrR5HNvyywrHE/Iit5+4Lrx?=
 =?us-ascii?Q?L7pon+v4eDnxXUHiMEkHpGW9ENGD4u0fhRDNV2zhINIxwOr5L+Q6jLSxIx9I?=
 =?us-ascii?Q?bK8z3vKwD6qBpM1z9YA+ycgxNBFl9EmhZfs4fN0avnHWe8W73GWajqHeolZK?=
 =?us-ascii?Q?YW+xdZH4H1ETqPLtC38LgFn6z9sC8Da5zX3NZ7jeH95jkmBGeOlQ7wyaDNC8?=
 =?us-ascii?Q?LcfzHvLylAW6C8giCu6yAoCtxbhe9H+DPddANh/NTrH2wiCLWa2qwaTXpCp7?=
 =?us-ascii?Q?9WV6a/MY+SyoW0aqBtQAoGDHJA5yMc70wfCiKKeJOiHT5wSn/uQugDFsS03M?=
 =?us-ascii?Q?/aAtgnfU239fN/teGlnxCXglrZM0W50XbrKFMFaAFGthk51eOfvfuHtbAx7x?=
 =?us-ascii?Q?OtorlpXVbjo5qgBwRHdKnkpLTAQhYZ4kE2dQOWlK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e553b035-d4c4-4979-0c38-08dd915f15ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 14:12:52.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: So3XSHu8JnpddLJLzo1izLiuQrbmv9oInHfGvDoUD6OjQ6Ckv/BqCLT8MxBNyqv08SZh3CYQ3uWMrjsqipyGJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPP153MB1390


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
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig          |   21 +
>  drivers/hv/Makefile         |    7 +-
>  drivers/hv/mshv_vtl.h       |   52 +
>  drivers/hv/mshv_vtl_main.c  | 1783
> +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h |   81 ++
>  include/hyperv/hvhdk.h      |    1 +
>  include/uapi/linux/mshv.h   |   82 ++
>  7 files changed, 2026 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vtl.h
>  create mode 100644 drivers/hv/mshv_vtl_main.c
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index eefa0b559b73..05f990306d40 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -72,4 +72,25 @@ config MSHV_ROOT
>=20
>  	  If unsure, say N.
>=20
> +config MSHV_VTL
> +	tristate "Microsoft Hyper-V VTL driver"
> +	depends on HYPERV && X86_64
> +	depends on TRANSPARENT_HUGEPAGE
> +	depends on OF

I am aware that OpenHCL works only with DeviceTree and hence we have to
enable CONFIG_OF, but I am not aware of any dependency in this driver, why
we need to enable CONFIG_OF by this driver.

We can always enable CONFIG_OF separately in OpenHCL kernel configs. Please=
 check.

- Saurabh


