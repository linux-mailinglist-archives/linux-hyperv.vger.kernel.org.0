Return-Path: <linux-hyperv+bounces-7688-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8CC6B20D
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 19:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 816B928CDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3B31ED80;
	Tue, 18 Nov 2025 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mGn/cwry"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011013.outbound.protection.outlook.com [52.103.1.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8D3612F0;
	Tue, 18 Nov 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489457; cv=fail; b=OrdLbwfCBSdK9qyssn4692XZbsv1ZPKRq1HiqDxCYR8CAUPCVaH/VtKUqsfs79k811Z7xSxbVfIUjlOB5dpQOaQHyNFzylvp4GIRNiVv2Z8PCCvnyK2f4L9Y/K2or/GyVHqr6CNRajy13uDrHckNUK8nEXOdpb8jcydq1XwfZAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489457; c=relaxed/simple;
	bh=WYTPXRyQLni1i/ap3+2lwga7sQcluqE28bAdSQLflqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvudAj2saLasXXN5oC/HsvozpMW8xLIj7eB6mt01kMt3YMz5eHggHZAQ7rr7gknRp3FA4YudR/P7NyohVBps6t/JCAS6elQXlgTZ1+lCl2Y69eavKZEKl6q7bDbDPSGco47EJNQJXNrJu5QgrSUG6hzUL6jMbZ3HOD2BkIJ8cXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mGn/cwry; arc=fail smtp.client-ip=52.103.1.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvQHOizwmkHM6ZR4qGDfsZbtZ2NRMjiaefxqJ9GKwnlk3GOQzlO4MBUZYqg5yV40s7z6G9bxY/UK4Gcb5X4wsD83olXzbw5b+VG+Hfiop0dtzqGWPinmwHvYlX+jT4Ec6ab0Hqfe5+u2gM1ZZUHf4H01w2z5v7EZhqi0RuhOADBoPZodzY3QO/kZre7ekC3YEijjmqlXDGTnZoTbnxbZSB+aAx3KgyeHtTmAqMHYE5NM/3L0lOWaQnFKf6r0p4LLPQZwWCRTEScow6kl0jb4IlGXgpKA1UKYU5bcD4CE2txLN9Z6XtC3YqU32WsM3f2E5FRgNdrBaIr6GOimtkcXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjJTfdGaLSwrflGQYCEu8q2/slxnUDozwrjvPFtRwQQ=;
 b=y0qMJG71b2pDRsyJm+FEojZQurPTW2jAkuYDR+oxEDjl8IeH4rX7FbMlI+JFQEEAxTXLyj3iXuHPWRBoo1BBpq92sevtFSlRiK98As/+U/UYOSU8KDTf/LNif4G0gW73s6ajkta0VLcRASpbXZHrKMFF/k9c7U38gufHPV1s2ioVuGDb7mLc4dRvfM2SRSPlgHnEBxoA04jVUbX9egT0lTR49VlVzFRapxO60zoe464YlSPvMAqnDnpMzDAyCCabomjDUNLvaNOldjku7qVJ/o6GGzTeYWfXD9pmFc6bUVhHtixsBLrF0CVm4nsZ0hUXpPoKnaGGleg8Zbt+s4yLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjJTfdGaLSwrflGQYCEu8q2/slxnUDozwrjvPFtRwQQ=;
 b=mGn/cwryXH8Gp8GjgcLrKtzEOWr+Y2uO0H2FqFzB7/SdVRdULwafrmdDwCSG7xiRkIZHdU7+nvQakq8TpZzaTCvDe9+0BI/qlG85UC24xf7p+h1GIhw++v3qZj2eQoomLZfkDrYaNx4Y5dLHEKykveCuKkL8IV4cr7+TSjDScb04ankMPgkU5sybvuJM9N17urvfehKM7jc/PgQg5Wyj3yXqPF/u0iSfmG+g85ucDwkB8U+w1ue9pAzLTt5LeubZcGf5FdKWTs4JRjzfn7rrC7OqWGNghQc0x+0TjrP964GR6l8olP4Iu9EcAcLwq8SK/VSxbhipNNxF7lNWLYKFcw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM3PR02MB10231.namprd02.prod.outlook.com (2603:10b6:0:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 18:10:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 18:10:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "anbelski@linux.microsoft.com" <anbelski@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v5 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Thread-Topic: [PATCH v5 1/3] hyperv: Add definitions for MSHV sleep state
 configuration
Thread-Index: AQHcWAal74VHuQyPCUSZhF6MaxKP57T4ueZQ
Date: Tue, 18 Nov 2025 18:10:51 +0000
Message-ID:
 <SN6PR02MB41574A771FC709C6BE97A3E8D4D6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251117210855.108126-1-prapal@linux.microsoft.com>
 <20251117210855.108126-2-prapal@linux.microsoft.com>
In-Reply-To: <20251117210855.108126-2-prapal@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM3PR02MB10231:EE_
x-ms-office365-filtering-correlation-id: f8cba72d-ab95-494a-cab7-08de26cdcf1d
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnrSvM2KHQcvRP9S8BO/OGIt1oJuiqibONYDWnsBl7MSJYJKuN+/gYCFxyCCRSRH6oTqam6kXyazWw4saLEUoeYsLZfNfQJVYnzoEtUv6TqXU3HbsUdPIWUKzEIx8AmKIvwafF+MZQCck3LtbR15JmprAJZxGkiTIHbWDqiOzp3B9tJd5c3DdUxCuWxrqHlQudlS87EHRNLf6/tHwSay9x3LnA92CXCjKfHxq8ToQXhNbAE6DLq+J5Ot2vOMc2LCTM4g5cf0ByirnrPLwPTQnweJtJ6rK0o2GBJdu1O0rO8GNbt3EuHM94ssTtIMigju/YAlTgjC/httxvlR25XqnnnAbAkz4owpNWVdRAhHRqB0w6s166B4xigEb3MJTMgIukb7NEZJjZfsQwl8qiOYdNsyDUTsUb/CKcs9SlYLsWlf03yAmn4Dmb4Sd1TYM9x6k4YRXp9kjlM0exK0owojAF3J2Exe2SKQo3FFtclHLJCUM18tqf6t4aUrcEKijOby9xbJwH1aMTwK5Gi1B5pH8UjwQkmo7FPTMDsKOaYEP3otAGU8fF+dbVFcJPTmXqv4qah1bXyioJe52egaPTL00R9hqr2nb+wZLyUOSUwGPLnZctzm3uMg/IpVYz84K7fRKzNEJs678SYZlkRlnNOzon93ZwaJ7EZs9GFxmNyjShs70tNDS+V5gjx3oT5X68fLVe22fW+KafGZbPOYlJNi+sxv/+3iMqMkpJX7SG811V6Kx/da67NJJiYxeic7d7oZAIg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|51005399006|461199028|8060799015|8062599012|13091999003|41001999006|19110799012|15080799012|440099028|3412199025|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KciIauZPrXG9z8xcFZZ7DYkN/gpmsFLhCmgCVTZnrS39GjzWMxTuZbw0YdX+?=
 =?us-ascii?Q?8mn9EBEkY/hyyd2qWeYssLMq2N7tPBSf7zgHJx1eAQ2aGJHrYTz9o9XszgSZ?=
 =?us-ascii?Q?OrHqvTmqRlrrPcZIJnXtrxkJjllLYU8js1HJQaRR24DtSWabSd2j+3VIMxow?=
 =?us-ascii?Q?x4eL3Bz6yPb44ImJY8kuOZeZHPvHZZ8cJb4FNz4urEQ72Y1jfL2863WIlMs+?=
 =?us-ascii?Q?jQE5GbxQdzyt5YTy5RBLu95SeY4dbL0KgQctt1goYhbsCIBaYwEZgoyfkU16?=
 =?us-ascii?Q?tbt3LrUWrO0wx/6OvF6Vm6dSCvqvcDJYK+1BPR2DUmESDmc7CRapO5boDGvV?=
 =?us-ascii?Q?0TFdZZ/Hk5V2gPRKebCE23tyEVdkRO8d5ipq8Fhz1tjRXpLGeofGHJCcO4sO?=
 =?us-ascii?Q?+QBAVEOgdjGwxemfbxzAHGGUVordX3FltVgCLFXfBkRrHg4jO1v8SJF2t/2o?=
 =?us-ascii?Q?8YzIPK/XtWdbshhrv9Je2RhYSI6FN4zX4Pyzuyzp50R1YrAjjME8El2+YwcD?=
 =?us-ascii?Q?pfWgyH8I5Lz3os1lsOjngSB0GttVJT+uqysZFTi08fxUKy2zkyd41Iy5hQQO?=
 =?us-ascii?Q?KW0r+oBL1B5nSooUnVbMJBKOUeWgREbmcw7XZetZOhqdRh2d/WFhUmS6uhVP?=
 =?us-ascii?Q?zOcirqsD++Wb5QluVMaAgUTPhfdEXPOhV06KhmegM8FbO8ifSOzslUJnA06p?=
 =?us-ascii?Q?e/WAt9ZrwtGX1rmku0UCex7f+fGZXv2dtWASro5Z7LjP0uBI5tPz8SkVtGKW?=
 =?us-ascii?Q?7ikBSQrGlETeoFqfeLVtUjmMaQL+FsbONIv8n3oopp0ftCG6FJsDkQziyzVq?=
 =?us-ascii?Q?mHy49evgSSX3vlNQ3RoiclK1XmK1Fz6v9qqoD4FmN0e451x0QbE1BkqoaFl2?=
 =?us-ascii?Q?GuPpQClsEV3YmAlxeOWh7ykU9YuNR0hzAsB/apbMnnam4AYoqsOj4W4Vc35+?=
 =?us-ascii?Q?PjO9IHrhMa9PP/bnsG+liQIyB5KjqchyxLrP/C65iyy2tBDExDZiR8USdQlQ?=
 =?us-ascii?Q?TVjhjfVPvwsVOLSn4VIlnIwfNYKLABU5tRQ2T5ZH4jXsW9jSD2+uQUkSyCA9?=
 =?us-ascii?Q?Ctq3xHkz5hTRovWV63gewkvw/T3YvKQAiIpqCaaTrVKsIdKvC/PGDHSkzcbZ?=
 =?us-ascii?Q?jT5cIme8NLrZaIILO2v3i38rXhZ5CcxwWfAx9LiItFbBbbKGNGK1g5BMroAl?=
 =?us-ascii?Q?umpU4VMolLv/EMxL7+aA93aQl7UKvoGOjIZm22IUwf5GoBtqE8To1SkJ6OY?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IAVB+wceNKuy7QW35e8yVutsh+PkKerKo4teQ1a7n/6YkkfHBm7D0naJyB29?=
 =?us-ascii?Q?5MLvMZ8WtRm3TjUb+T5/jZsZmhfW18U8JEpkC5x+M/oeV7BKLTrpNISocdxC?=
 =?us-ascii?Q?zZDC9Xi4blMsCqLSMUsg2P1cBR6T8JUhhjnHIsbt2sPnwu64i/Y6ZNhnnvG5?=
 =?us-ascii?Q?Z7iOQrVxc4gKU3k/T5BMV8P1TbjyQqcPcfc6jiMhOTUpNAdU68VUMVSO+iOm?=
 =?us-ascii?Q?rpDJRe7hlM1RE56a3JnJNwdO2UhR8P09ZAH5S8gTV2l6y0wFqsW5XZ9ymYLc?=
 =?us-ascii?Q?FU68/wo2HmNFcjMj2bXcC68TdmSYaZdEZKKM5+HoYnriZ50cuCXU3M/TTyfe?=
 =?us-ascii?Q?JVVxAc6QqxcDEWF4QmiVmNoVGoGNVb2PklyG9BCPqTuCpUwWXcCm2BS/JYBK?=
 =?us-ascii?Q?1YJzS5eClEbNi6sFbhT4lnjom87Fq/Mr6UYQSKL0J3u84LdEDbOa8J+qwCwq?=
 =?us-ascii?Q?YDyxMmpkpyupf69Dy4uiHkvryzi8zYuB86oIqclDd2N2dAByZz9vpyxQK8XT?=
 =?us-ascii?Q?pkALpolX4VJIDXcFevYoyF1IOx8DxrCjNY+NUsu64EFOAapvJiUQpEa2qORN?=
 =?us-ascii?Q?HB4alVYZLL9Ay+hpDv5dQ7FHJ2xqb5JHy5tKFoyFx6aZe7XyDyXi86k6ARS8?=
 =?us-ascii?Q?lBYimP6e3UWSfycW5QuTqqGjxHOuOlIl4mggIJOVsVVc3vqnmeUKzvdBXl30?=
 =?us-ascii?Q?fJ+iraKyOJh9yeynfkIkJEtxtxFWNXeq7ngHgfgs7ou62XdimOIhlVyypxPG?=
 =?us-ascii?Q?kzU6/qiEA8CZWqXya3OEZJFnFTsv5h6EbELUiRiCYeZgmk5QtgolRgYIIEK4?=
 =?us-ascii?Q?MYlLmntH72qTPZAF+cQFJpJ5cusljGV644CwYDq2z7gTaTI9uD42naBRgHA4?=
 =?us-ascii?Q?OeXEzJnu6cwzCgA9F81nb1WGe+KyMg1LrHvNan3R4QT55WAN3O/lex2alC4w?=
 =?us-ascii?Q?DyztAoEz5YLhzDnVUz7LWrDxHnoPzlyC8FtG95a0gPCfiPATZnhKh9z7PBZb?=
 =?us-ascii?Q?W9bxP1+nhHtusjEQcZ5BX430hlL3+LdMIjnjfEmkuox+GlIpuk2ztssuRH6q?=
 =?us-ascii?Q?T4gehRUe0aIg2eJczXGJcLxxtcRN4qMh8zUE2MGpc0nQ/qtd/IxPIe9XPAKG?=
 =?us-ascii?Q?TsyZgG1gwkGByVJPG0qvBNg4J9QrkbbhAv3v/ZUHKZ+5BXZAuHzidUAle2Kl?=
 =?us-ascii?Q?kLoeD3+MpE19n1YTV9QFfw+NuIhApGHdso2VRsgMxnHGYOOq+81YJpOS+XI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cba72d-ab95-494a-cab7-08de26cdcf1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 18:10:51.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10231

From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Monday, Novembe=
r 17, 2025 1:08 PM
>=20
> Add the definitions required to configure sleep states in mshv hypervsior=
.
>=20
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 +++-
>  include/hyperv/hvhdk_mini.h | 40 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1d5ce11be8b6..04b18d0e37af 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -465,19 +465,21 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
>  #define HVCALL_MAP_STATS_PAGE				0x006c
>  #define HVCALL_UNMAP_STATS_PAGE				0x006d
> +#define HVCALL_SET_SYSTEM_PROPERTY			0x006f
>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>  #define HVCALL_RETARGET_INTERRUPT			0x007e
>  #define HVCALL_NOTIFY_PARTITION_EVENT                   0x0087
> +#define HVCALL_ENTER_SLEEP_STATE			0x0084
>  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
>  #define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
>  #define HVCALL_CREATE_PORT				0x0095
>  #define HVCALL_CONNECT_PORT				0x0096
>  #define HVCALL_START_VP					0x0099
> -#define HVCALL_GET_VP_INDEX_FROM_APIC_ID			0x009a
> +#define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>  #define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index f2d7b50de7a4..41a29bf8ec14 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -140,6 +140,7 @@ enum hv_snp_status {
>=20
>  enum hv_system_property {
>  	/* Add more values when needed */
> +	HV_SYSTEM_PROPERTY_SLEEP_STATE =3D 3,
>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE =3D 15,
>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY =3D 21,
>  	HV_SYSTEM_PROPERTY_CRASHDUMPAREA =3D 47,
> @@ -155,6 +156,19 @@ union hv_pfn_range {            /* HV_SPA_PAGE_RANGE=
 */
>  	} __packed;
>  };
>=20
> +enum hv_sleep_state {
> +	HV_SLEEP_STATE_S1 =3D 1,
> +	HV_SLEEP_STATE_S2 =3D 2,
> +	HV_SLEEP_STATE_S3 =3D 3,
> +	HV_SLEEP_STATE_S4 =3D 4,
> +	HV_SLEEP_STATE_S5 =3D 5,
> +	/*
> +	 * After hypervisor has received this, any follow up sleep
> +	 * state registration requests will be rejected.
> +	 */
> +	HV_SLEEP_STATE_LOCK =3D 6
> +};
> +
>  enum hv_dynamic_processor_feature_property {
>  	/* Add more values when needed */
>  	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS =3D
> 13,
> @@ -184,6 +198,32 @@ struct hv_output_get_system_property {
>  	};
>  } __packed;
>=20
> +struct hv_sleep_state_info {
> +	u32 sleep_state; /* enum hv_sleep_state */
> +	u8 pm1a_slp_typ;
> +	u8 pm1b_slp_typ;
> +} __packed;
> +
> +struct hv_input_set_system_property {
> +	u32 property_id; /* enum hv_system_property */
> +	u32 reserved;
> +	union {
> +		/* More fields to be filled in when needed */
> +		struct hv_sleep_state_info set_sleep_state_info;
> +
> +		/*
> +		 * Add a reserved field to ensure the union is 8-byte aligned as
> +		 * existing members may not be. This is a temporary measure
> +		 * until all remaining members are added.
> +		 */
> +		 u64 reserved0[8];

I had expected a single u64 to pad out to 64-bit alignment. This is 512 byt=
es.

> +	};
> +} __packed;
> +
> +struct hv_input_enter_sleep_state {     /* HV_INPUT_ENTER_SLEEP_STATE */
> +	u32 sleep_state;        /* enum hv_sleep_state */
> +} __packed;
> +
>  struct hv_input_map_stats_page {
>  	u32 type; /* enum hv_stats_object_type */
>  	u32 padding;
> --
> 2.51.0
>=20


