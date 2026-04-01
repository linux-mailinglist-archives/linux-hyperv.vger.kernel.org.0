Return-Path: <linux-hyperv+bounces-9877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGAmCRFSzWmnbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9877-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:12:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A137E76C
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED29306329B
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2285B40FD8F;
	Wed,  1 Apr 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W5YBFg6K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012084.outbound.protection.outlook.com [52.103.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7337FF59;
	Wed,  1 Apr 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062665; cv=fail; b=JRxuiD+7pOtUIeqy/bSEmjJbhbeBPe1eyw4U3iIxgzL0WlTK0DO4Db1F2ui/2m/R+vcgJJBTqYAGTc1zU3k/iyuHT4gA3igCC2klVnGopyb7AWjhRLz/gjNHpA2NZxzIwjUju/TlyQRX9Tt7emnQ1m9G3+FNOEW7/CF63koRGP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062665; c=relaxed/simple;
	bh=nrLyEIbP2+UDKMy+46OEYymahsE4BICoBclsq/bQIzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIeOHjxsf/qUHD5JEDj/fYWmV19NvEeJUUEta3SBWr22zX1HydzBKnijlhLCdRac7TCwf0JSWsVXPSGVFkXqi/Kn7CsV1uhwnPabcsyZWIrnTYKqvgpPSP6tJ5hBIg8AU1+wBAMbjvOQ36TPs9SAc3JeQ2+MEhlfZXJUtXH8gDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W5YBFg6K; arc=fail smtp.client-ip=52.103.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xl0IeVzTyFa5jaqifVkP0bBOGRKc84V4D1CLO0ctLrrsvWibRsNLui/rVP3ej6puZVxGYSnAD0sSDC6xHLSOcsJzcfaHNQyfh5rRbGiZ7EmG/m0X1lYF1A8EtfGTsQRfiAcGItRl+aQdcyRgfgPjhh0FUPfHzRfLEWobCAujCKCDRpIj1TJnKqz4i8PpQ4ncczJbCwHNMq8DSgD6EcB9tEdOnzTUec3xncjcYFFDLOVAxGzT7LOR1YhEHpKb1N97FNKgCzz6OLWDoWLnyGhrACFmfakIu5KBkk88xZMqEKEfTFUQnFYCm7eWJsQwjGPhy4nmLYI0GhatoUNUU+LHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DS8wp2tiY0lITh/UYciVdvb1C1zAoH/ENMI/+b2pt4=;
 b=H+7jvVmM/Mvz7BTdQctdFLyugCRDMaJw48AgHNOjKFye2xopDtydO/vdeKGB9dBa/90uD7tJYxZQNOa2mb0o9klN/qfhfjiq1DD09E8mA+cXAi0txz9w/n3p0YyJsTm0DoS5tijCliNNOIiWY5gy6O9h/NEDzqyyd5nsziXZaJP6Qq2LE4BKE6ZW7r5wz+lyeoGvpIBd6zxN8S62zQq/gbgoGEAjJrsUoDYmPRkr0gvj5GxKzeLrRmw3d0elpryvEaQJahs1C0L/txvSb4F5nwNRt/NNC8DZ9wKYIABq3hbXKGssflWrWO6uRdG4u/KzMm/wbPoug2f2R90eQk3ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DS8wp2tiY0lITh/UYciVdvb1C1zAoH/ENMI/+b2pt4=;
 b=W5YBFg6Kt94VOLRjLoCVGmwqRqwtCIfm9KsLqC5pacjtvsTq1OHR7NxJ9TYcVsDuq1UaaFmRbF7OpxnojICiJdNI/PypTnUzMdf/GI2QfGqkCEeX7QUUmrJWZVH455dtyg9NFpatMAzG2kOvzsDW+AXev7q/AGHjn4xdf2lkyw55loZQ+gonQ9Od/dOHw7wIHFuvH7a38Zw5LkXDMC/j1xMDlFm9NFNqByuqkZsDBEt8IDhziK3wnhXM35ETD4rz4IkgTsmfOtQxXvJ91T77YkHQtZZSzk9ueTPHKYkGOqLCVtZIkTIsVf7yT6vvkvIioF5E37SowxuHMzR55tsAIQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6701.namprd02.prod.outlook.com (2603:10b6:208:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:57:40 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:57:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, mrigendrachaubey
	<mrigendra.chaubey@gmail.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 07/11] arch: arm64: Add support for mshv_vtl_return_call
Thread-Topic: [PATCH 07/11] arch: arm64: Add support for mshv_vtl_return_call
Thread-Index: AQHctT5XIwojczjqDEmTHcbxCnpDo7XKhs6Q
Date: Wed, 1 Apr 2026 16:57:40 +0000
Message-ID:
 <SN6PR02MB4157D3C4F6F376C8D6C3D234D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-8-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-8-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6701:EE_
x-ms-office365-filtering-correlation-id: 15245e45-c0a8-4e1c-2903-08de900fc906
x-ms-exchange-slblob-mailprops:
 CLk2x5OX5VYv3c8Emt0jD2wdZaenNeU3rqTmvT5xlTAzxo5nEB2XZNynqLNulh2dNP3QYwnlKB9s/C/NYl1OCTYrIDkc0s6BEgedqki4Lz0DQdAyE66JD6XAbdKUQG4JFh0IKqUcwnWuztOrMBgt8DV2nnnJfyxd6bRgzxrz7BEYwR2+B2slpk8voRznJHXM6L4Zvej5Xb2Nxp330r/1dpwBDUu0Xi8AJ43N5Lm8QFzcMCuqfuUpzdbTx7t4xWKgF1RqNmRM54SzwdHYvu5CrhDTRV08eqQjZPZuZc6sID+I8bwHIFIOsyjacPQW4bwjqSkt+SJKu1gzB9bO6A8UahLf28+I6O/WbkzgaTP51E6Hlvhh49gNuAajhmr6NXPwEQY1CksS6lOa6evT5Hxlbfdyh/gzUmZ6i5nBvUHhxJVo9YtgrwY+Vw3uItiCudbej3Si8ZK0TPskO9D1wVduuet8wXSThH9Q362p/vam5VkPWgKthdP4DfuI6iuxCWj4L++5NPECoV1s0k+Er2Jkbiqpy2fuS+mdIPjqhEY+aeHlT42TZ/TQMXugkVhC9kZGIwyf7SESsOcDIHPYA34nG9AWsxuNqy7QW6IzsUHATjCHimE8PSylsKUZxBGVwSY6/I8qZROCv1aHgt/hHYeSEYAEwrxxl0LweYJSxbodw0+qB6dzlsUSlsK6XmCNowgv48I4yT7mnrP03d+3NNjyLA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|19110799012|12121999013|37011999003|31061999003|461199028|41001999006|51005399006|15080799012|13091999003|440099028|3412199025|12091999003|26121999003|102099032|13041999003|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b38canoKps7dcF+osW1mkuvWgVZl2b987kVpwazPY8hv4YppLiVvXqEjwXQE?=
 =?us-ascii?Q?n0JZIlExemAVAlJLcOp5ps214s19M5KeZXLzLA67nJTYH4mfhoS6hhNy+Z3T?=
 =?us-ascii?Q?MVME354lUOpgFJbczmgmlLuEhThwK9sJuwFinpvZMOfN6UyPCNT7VNO5R1X8?=
 =?us-ascii?Q?V9zxE1B3HKADbATPBIQvZf2JJgpv32BjyOaSnMr0zHSOV+pt7Ov7OSXOIRHM?=
 =?us-ascii?Q?eKChEfRRRnHah2fjzFTEAOz6v6YEB2ZN2qQlMpvx9vVfRCx/RN66TIOXPc4a?=
 =?us-ascii?Q?wud9AejAXqlxaJ5RvcVPl0r9cGOKKDcqyjw1CRixWjVxyFbIPqnb8rN73QGT?=
 =?us-ascii?Q?HLtodIuKrSjtL4u+qGFADPfZpFLyEpgaIYeBV4oYDSlJdsk2GWWmvxirQhOF?=
 =?us-ascii?Q?0wf7+HNIDaz2mG6BaRyEi66heX3049JDNp5Q9gUCcrnmQRPCy2V+xKsdONjr?=
 =?us-ascii?Q?KddCjm8xkLz4I1K1WJnvxqYEjwigTpI4737q/k5sXaiv3f5JtdOGL8YByoJm?=
 =?us-ascii?Q?bnqZ2jAkca2iettqylqHUv5v3zL+YMbj6UM7YWwGGjiSBVl0P1qKcYPsPOFK?=
 =?us-ascii?Q?dDLh/hVoftEA/5c4VkebERfsKSxwhoDvMX1qooxRf9f5lT1b/Lel17i9zbWf?=
 =?us-ascii?Q?Ef5lFFryUmvSfVTj9Ds2UCYR3XaEW/GUBUEKmYD3JzaydYNG4YrFPvprlf5C?=
 =?us-ascii?Q?j/4UAXn2iElqxNDgDYmzd3NgzU1R2LfbuEQ5VvkSbpCAnxSvAcKEpZSfeyIt?=
 =?us-ascii?Q?a94aXgtbJxJSGASmOAiL1bzs2IDPaeDmVbnrMdzU6FhH5KKfIo2tF7jfZjqj?=
 =?us-ascii?Q?FTn59QN9a3ETS59VGTARfwEGwAbqyi4qbrFOLCNouYnOKOHru0jchuQaK6A/?=
 =?us-ascii?Q?ru5QV0u/mleL3dgqrmSBEDTmJmgtx9TOCiNmMzDgmBk66EB5qBqinBdvbMFU?=
 =?us-ascii?Q?ZzRWWF4vIP1LhwfikgABQM558VULa79ZoogfR0T5v3Ao08xQ13VBWzrG7k5/?=
 =?us-ascii?Q?qu2IZ6hE1JVYdASI27fsiyZHyxWVNu5t7Aw+t+7oJN5iiHhaZNV1ZQ1FiB8+?=
 =?us-ascii?Q?PEx3ua7H1j61YMDwD98xXFW6hwf0IrCtWtaUDGx4T8pBHgNbplxKxARGKYG/?=
 =?us-ascii?Q?PGIXHRH6WM2Fh0zp9AKGm84dkfU4ceJqHA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RME6wV7jqoArzd+rGXz7g1dg3O3iXzwk5zBaLOLCN246n3ytiqTAKRet0g9R?=
 =?us-ascii?Q?R9HDPBHIQrJUi/Z8qetWrGRoTvJkPco2qqTogCrJj3dPn0KzxcrIUrmrBLlE?=
 =?us-ascii?Q?IctNZ+P1qPinag6h7SD3VQ0IwrE4kDx12XnC9s7ssHlpE+CaqvyGFudI3IHs?=
 =?us-ascii?Q?GvKzAqOQSj7smbXScZyL4GFQuUuIgJXjs6rAbJQXmN3fk2iQz24/VvYIITOm?=
 =?us-ascii?Q?DEANJ+7w1IT37FNqxfjs7vBz4dOah1i5macvlD9iY8AszVFm/cR8eQ2j1ELs?=
 =?us-ascii?Q?Q9f8XhBgw25xa7c8SkCkSdZAf7B4lEC3XSBvgJDsatI7uNnsMLw6yIqEwqjM?=
 =?us-ascii?Q?TP53jo1bdv9C1UgUH4u21uQj7uGGnpMmBivvUuNOKJIPOY02QV34wMj+elC3?=
 =?us-ascii?Q?K1QxO2WLYHfU8K/75JZroIp4baXLu2ypdM52e+RbJoBOQcD6Ht+ag43yuIpk?=
 =?us-ascii?Q?sb3cy2RnUrmOn5Udtur6HOCS4h3W0O5N97R7YCwSRxuKIJUKSaj0/xq4/ejn?=
 =?us-ascii?Q?ZgGiqH+pg34HogRoiM0cOuextRmTsqXnWN3jzJl0pLhC3I5acPFenflMAj/D?=
 =?us-ascii?Q?Hsd+Q3uGwP7zzw5g1q9amnBAbBViX4J68BVqfakVHM8UIXRZKpaH+tIFXbjk?=
 =?us-ascii?Q?lPhyZCEWmTCz5iCjFIKE5107rieG0mWZLjbuBnmA7vcv5aQpcOOPSCb92btT?=
 =?us-ascii?Q?HM4OvOGD7bHBGnysqbaA2uwlIZzoSzb8ojXSyM+V8uc0f8hn1zNDBtQ2kkQ8?=
 =?us-ascii?Q?0MvX9gHsQoqQV/iR209J0ntMgpwtqr4ux50NOMYQNR/IIYI2qMbCW/Jotr/f?=
 =?us-ascii?Q?uNhHGiPAno1Y5yduTTIg2fHah1iYzFyevefCRmqUQzUU/IKZl/1wvFaXs5GL?=
 =?us-ascii?Q?0Qioxe+RH8XddPRScOglJC0XrA96j0lqOoa5JjK+cTnV6xTCufGIoLYr9lZi?=
 =?us-ascii?Q?jV9tI1IM4d+FlPmRXb2kvcVqhlsrRzJQ5sInZfaR7LgrNTJ+DJl8LWGH+35c?=
 =?us-ascii?Q?dLwMGh19EXW8/QPdL+Pm9JfZ5OnYMaTxsP0HwXnLcdzFy2q3f+ijtruaHBJE?=
 =?us-ascii?Q?aIh8GMtsE3GtYiSv55xHqNfJKZFHurlO6uHXW1aLCACFFaWwPH2lYsOpi6q3?=
 =?us-ascii?Q?JZoEwIwBsqujTnusQxbFtJudGPmw3JZel8j2dWfn75KQZ0AbSU/dEd1UR+Yo?=
 =?us-ascii?Q?Z/t3Q5GwlCeycIqAlz83JhBwv5XWyMPwGi7fTpFSJtlxlc0gkyUgCKtxACz0?=
 =?us-ascii?Q?ZoelzPB1jhkzw/PffaFfq/3coXXpfcf2qa9M3IyQvGaehhi5Xv7nIT+tuAwG?=
 =?us-ascii?Q?QKEopGpEDSalLh6CytaBQLSPVqi11TPrbvriV3UTN9xrWdyNHj0FimFm3pcB?=
 =?us-ascii?Q?7eoN0e4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15245e45-c0a8-4e1c-2903-08de900fc906
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:57:40.4597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6701
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9877-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 803A137E76C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20

Nit: For historical consistency, use "arm64: hyperv:" as the prefix in the =
patch Subject.

> Add support for arm64 specific variant of mshv_vtl_return_call function
> to be able to add support for arm64 in MSHV_VTL driver. This would
> help enable the transition between Virtual Trust Levels (VTL) in
> MSHV_VTL when the kernel acts as a paravisor.

This commit message has a fair number of "filler" words. Suggest simplifyin=
g to:

Add the arm64 variant of mshv_vtl_return_call() to support the MSHV_VTL
driver on arm64.  This function enables the transition between Virtual Trus=
t
Levels (VTLs) in MSHV_VTL when the kernel acts as a paravisor.

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |   1 +
>  arch/arm64/hyperv/hv_vtl.c        | 144 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h |  13 +++
>  3 files changed, 158 insertions(+)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
>=20
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 87c31c001da9..9701a837a6e1 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y		:=3D hv_core.o mshyperv.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+=3D hv_vtl.o
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..66318672c242
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Microsoft, Inc.
> + *
> + * Authors:
> + *     Roman Kisel <romank@linux.microsoft.com>
> + *     Naman Jain <namjain@linux.microsoft.com>
> + */
> +
> +#include <asm/boot.h>
> +#include <asm/mshyperv.h>
> +#include <asm/cpu_ops.h>
> +
> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0)
> +{
> +	u64 base_ptr =3D (u64)vtl0->x;
> +
> +	/*
> +	 * VTL switch for ARM64 platform - managing VTL0's CPU context.
> +	 * We explicitly use the stack to save the base pointer, and use x16
> +	 * as our working register for accessing the context structure.
> +	 *
> +	 * Register Handling:
> +	 * - X0-X17: Saved/restored (general-purpose, shared for VTL communicat=
ion)
> +	 * - X18: NOT touched - hypervisor-managed per-VTL (platform register)
> +	 * - X19-X30: Saved/restored (part of VTL0's execution context)
> +	 * - Q0-Q31: Saved/restored (128-bit NEON/floating-point registers, sha=
red)
> +	 * - SP: Not in structure, hypervisor-managed per-VTL
> +	 *
> +	 * Note: X29 (FP) and X30 (LR) are in the structure and must be saved/r=
estored
> +	 * as part of VTL0's complete execution state.

Could drop "Note:".  That's what comments are. :-)


> +	 */
> +	asm __volatile__ (
> +		/* Save base pointer to stack explicitly, then load into x16 */
> +		"str %0, [sp, #-16]!\n\t"     /* Push base pointer onto stack */
> +		"mov x16, %0\n\t"             /* Load base pointer into x16 */
> +		/* Volatile registers (Windows ARM64 ABI: x0-x15) */
> +		"ldp x0, x1, [x16]\n\t"
> +		"ldp x2, x3, [x16, #(2*8)]\n\t"

On the x86 side, there's machinery to generate a series of constants that a=
re
the offsets of the individual fields in struct mshv_vtl_cpu_context. The x8=
6
asm code then uses these constants. Here on the arm64 side, you've calculat=
ed
the offsets directly in the asm code. Any reason for the difference? I can =
see
it's fairly easy to eyeball the offsets here and compare against the regist=
ers
that are being loaded, where it's not so easy the way registers are named
on x86. So maybe the additional machinery that's helpful on the x86 side
is less necessary here. Just wondering ....

> +		"ldp x4, x5, [x16, #(4*8)]\n\t"
> +		"ldp x6, x7, [x16, #(6*8)]\n\t"
> +		"ldp x8, x9, [x16, #(8*8)]\n\t"
> +		"ldp x10, x11, [x16, #(10*8)]\n\t"
> +		"ldp x12, x13, [x16, #(12*8)]\n\t"
> +		"ldp x14, x15, [x16, #(14*8)]\n\t"
> +		/* x16 will be loaded last, after saving base pointer */
> +		"ldr x17, [x16, #(17*8)]\n\t"
> +		/* x18 is hypervisor-managed per-VTL - DO NOT LOAD */
> +
> +		/* General-purpose registers: x19-x30 */
> +		"ldp x19, x20, [x16, #(19*8)]\n\t"
> +		"ldp x21, x22, [x16, #(21*8)]\n\t"
> +		"ldp x23, x24, [x16, #(23*8)]\n\t"
> +		"ldp x25, x26, [x16, #(25*8)]\n\t"
> +		"ldp x27, x28, [x16, #(27*8)]\n\t"
> +
> +		/* Frame pointer and link register */
> +		"ldp x29, x30, [x16, #(29*8)]\n\t"
> +
> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
> +		"ldp q0, q1, [x16, #(32*8)]\n\t"
> +		"ldp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
> +		"ldp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
> +		"ldp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
> +		"ldp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
> +		"ldp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
> +		"ldp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
> +		"ldp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
> +		"ldp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
> +		"ldp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
> +		"ldp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
> +		"ldp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
> +		"ldp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
> +		"ldp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
> +		"ldp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
> +		"ldp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
> +
> +		/* Now load x16 itself */
> +		"ldr x16, [x16, #(16*8)]\n\t"
> +
> +		/* Return to the lower VTL */
> +		"hvc #3\n\t"
> +
> +		/* Save context after return - reload base pointer from stack */
> +		"stp x16, x17, [sp, #-16]!\n\t" /* Save x16, x17 temporarily */
> +		"ldr x16, [sp, #16]\n\t"        /* Reload base pointer (skip saved x16=
,x17) */
> +
> +		/* Volatile registers */
> +		"stp x0, x1, [x16]\n\t"
> +		"stp x2, x3, [x16, #(2*8)]\n\t"
> +		"stp x4, x5, [x16, #(4*8)]\n\t"
> +		"stp x6, x7, [x16, #(6*8)]\n\t"
> +		"stp x8, x9, [x16, #(8*8)]\n\t"
> +		"stp x10, x11, [x16, #(10*8)]\n\t"
> +		"stp x12, x13, [x16, #(12*8)]\n\t"
> +		"stp x14, x15, [x16, #(14*8)]\n\t"
> +		"ldp x0, x1, [sp], #16\n\t"      /* Recover saved x16, x17 */
> +		"stp x0, x1, [x16, #(16*8)]\n\t"
> +		/* x18 is hypervisor-managed - DO NOT SAVE */
> +
> +		/* General-purpose registers: x19-x30 */
> +		"stp x19, x20, [x16, #(19*8)]\n\t"
> +		"stp x21, x22, [x16, #(21*8)]\n\t"
> +		"stp x23, x24, [x16, #(23*8)]\n\t"
> +		"stp x25, x26, [x16, #(25*8)]\n\t"
> +		"stp x27, x28, [x16, #(27*8)]\n\t"
> +		"stp x29, x30, [x16, #(29*8)]\n\t"  /* Frame pointer and link register=
 */
> +
> +		/* Shared NEON/FP registers: Q0-Q31 (128-bit) */
> +		"stp q0, q1, [x16, #(32*8)]\n\t"
> +		"stp q2, q3, [x16, #(32*8 + 2*16)]\n\t"
> +		"stp q4, q5, [x16, #(32*8 + 4*16)]\n\t"
> +		"stp q6, q7, [x16, #(32*8 + 6*16)]\n\t"
> +		"stp q8, q9, [x16, #(32*8 + 8*16)]\n\t"
> +		"stp q10, q11, [x16, #(32*8 + 10*16)]\n\t"
> +		"stp q12, q13, [x16, #(32*8 + 12*16)]\n\t"
> +		"stp q14, q15, [x16, #(32*8 + 14*16)]\n\t"
> +		"stp q16, q17, [x16, #(32*8 + 16*16)]\n\t"
> +		"stp q18, q19, [x16, #(32*8 + 18*16)]\n\t"
> +		"stp q20, q21, [x16, #(32*8 + 20*16)]\n\t"
> +		"stp q22, q23, [x16, #(32*8 + 22*16)]\n\t"
> +		"stp q24, q25, [x16, #(32*8 + 24*16)]\n\t"
> +		"stp q26, q27, [x16, #(32*8 + 26*16)]\n\t"
> +		"stp q28, q29, [x16, #(32*8 + 28*16)]\n\t"
> +		"stp q30, q31, [x16, #(32*8 + 30*16)]\n\t"
> +
> +		/* Clean up stack - pop base pointer */
> +		"add sp, sp, #16\n\t"
> +
> +		: /* No outputs */
> +		: /* Input */ "r"(base_ptr)
> +		: /* Clobber list - x16 used as base, x18 is hypervisor-managed (not t=
ouched) */
> +		"memory", "cc",
> +		"x0", "x1", "x2", "x3", "x4", "x5",
> +		"x6", "x7", "x8", "x9", "x10", "x11", "x12", "x13",
> +		"x14", "x15", "x16", "x17", "x19", "x20", "x21",
> +		"x22", "x23", "x24", "x25", "x26", "x27", "x28",
> +		"x29", "x30",
> +		"v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
> +		"v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
> +		"v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +		"v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
> +}
> +EXPORT_SYMBOL(mshv_vtl_return_call);
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index 804068e0941b..de7f3a41a8ea 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -60,6 +60,17 @@ static inline u64 hv_get_non_nested_msr(unsigned int r=
eg)
>  				ARM_SMCCC_SMC_64,		\
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
> +
> +struct mshv_vtl_cpu_context {
> +/*
> + * NOTE: x18 is managed by the hypervisor. It won't be reloaded from thi=
s array.
> + * It is included here for convenience in the common case.

I'm not getting your point in this last sentence. What is the "common case"=
?

You could also drop the "NOTE: " prefix.

> + */
> +	__u64 x[31];
> +	__u64 rsvd;
> +	__uint128_t q[32];
> +};

struct mshv_vtl_run reserves 1024 bytes for cpu_context. It would be nice t=
o
have a compile-time check that the size of struct mshv_vtl_cpu_context fits=
 in
that 1024 bytes. That check might be better added where struct mshv_vtl_run
is defined so that it works for both x86 and arm64.

> +
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  /*
>   * Get/Set the register. If the function returns `1`, that must be done =
via
> @@ -69,6 +80,8 @@ static inline int hv_vtl_get_set_reg(struct hv_register=
_assoc *regs, bool set, u
>  {
>  	return 1;
>  }
> +
> +void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);

This declaration now duplicated in mshyperv.h under arch/arm64 and under
arch/x86.  Instead, it should be added to asm-generic/mshyperv.h, and
removed from the arch/x86 mshyperv.h, so that there's only a single
instance of the declaration.

>  #endif
>=20
>  #include <asm-generic/mshyperv.h>
> --
> 2.43.0
>=20


