Return-Path: <linux-hyperv+bounces-10085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AgPNvNd1mmNEggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10085-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 15:53:55 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3F3BD3AA
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64876300623F
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E6A335063;
	Wed,  8 Apr 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nQ+1bEFu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010028.outbound.protection.outlook.com [52.103.23.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB292F3C3E;
	Wed,  8 Apr 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775656429; cv=fail; b=e0lRvrPNoLikKov0iD2RyxEfGYvVZ0YllV/z8lpsCIZNPe+esrIfkxbUexDTDZTWmL6ii47PpeIxArfRMYxZeewO199oVXqbdFLQkO/DoclxV7c4oIpuJBS7UTpwUXsWTUFSY3GC+8gUa6mgaG8fHORNVjuBX23Q2dKN6I9osCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775656429; c=relaxed/simple;
	bh=f3YLYT00L2U4QFdwj5HXBr1ejSWLU97qp5QYHOhpaNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBAUmYdzVd0MuoxmCPttUDUVpN6uY/DFV/P4MWndFWRdohLzmiNEjD9ikZePDVlBCdrIGFEMtKBYUOSPjjw7RtTFnKGfHSb7nPjT6NzxCeNL3h010Ed1kCu/BJAebI27qkgcqhfYiZ/QXOIXCSc6nw65i6IBnv+4wXoWhpk/J3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nQ+1bEFu; arc=fail smtp.client-ip=52.103.23.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKDeakRwf59ZaOSjGJWl6bqoM7nR114W9pJeWcaJWOp7sZIq09VjBLOQr+plnov6YAy+R9GK/fkYuImrHiiChAtGwZT0pSyw6eom4Ayi2/XdMHCVrJN0ml9mN2iLZM5EQhNBS9YHFfclYmA07hLdKTv/cwN6SSkdzzR2uR/uFCYNpxsSHNYKtUpQF4yWrCGEahOLlNa4XqrzDBJQGx1QL6EGD0wZ5NOyoF0uX4YXxtYQNlHBTKYws/Elnaaqy50+cmmVm2+bQ4GEZIs0G9Z8R71T4TdIq+0E8+a0pxQmhgXsXwtJZr8gw3E5jHXDMbggcJvH3VqPzG/6bT65Fhc6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jS9NxDPLzo1HF1AlOkqG+B4tntvNUspw0lif17KMklw=;
 b=FmbsNpOMmOuHYEar48WMZsGoMg/VL9c8fYJ/OM+IZh3qHF5EcFPwDLPtF7rlmqbZykRne1Ln+/hFdIwnEII1v3tunYs1EJ0Y8T7sBkxJBvjJhz+T2UmJ5iDYaVc1tdz6VgJShvoNPRridTeN5pxwMQ+wJ5AhEn4mJrtpqesgBD/RQWQz778P0BVVd1F9Bep/NKn8KlyPsucTByQs/2RXjSgkCJ8hHFYlKFqVnHrCDtFIEZ4PBieINDw21mB9Io4eQIUa2onqUPCfHecLg2zYc7NrdF3pg3wnrXvvOFdTnFFLJR5T54vG90+8jmOnjZ1JnGEemFYT69AFwEZi9qeuyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS9NxDPLzo1HF1AlOkqG+B4tntvNUspw0lif17KMklw=;
 b=nQ+1bEFuuBD6/ZB9BSyPGTH/eucSgRxKJFfvIioVeLN/QO7ZbZLzSig/NMVYNmBcd9Kge3s3fRCbbYE9smKgur1C0Eskvs4FSl24SybbAh1f9cFh82psnoz9YfZMeM6pwD1rDN9pT3XtsC3iRqjv//m8cm0QAuMImqyH5yaMwRpUcWQuRELJLtElxLdwAdbrUg0FMXI/XrRkI83XvQTfJSjO/coz9OlkOiRXPL/SqGHAebr9T4AJYmrex8Wjbr3QoTbxbhK5yNoee8QtKychrergTXjwlvpQbJQjx+Y55rSEMbOEzHcKcDmJM4UG31ld1WHgdZXE/WNZWvKNd+9OYg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7116.namprd02.prod.outlook.com (2603:10b6:806:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:53:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 13:53:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0QgAOgeDCAAHmtkA==
Date: Wed, 8 Apr 2026 13:53:45 +0000
Message-ID:
 <SN6PR02MB4157D5C8EE35A221B130FC5AD45BA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69215C164B06109C6682984EBF5BA@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7116:EE_
x-ms-office365-filtering-correlation-id: 8d6c0f42-979c-46ee-0f21-08de9576405f
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/Rjw2gaeRTXclTRoF+mU1AznpKhNOhtU3atItY2NzZZKFsYfDci2HkA60ifmnjDK3lTCCTzUBZJktBRsArxX3fDZWsCl4/TQonsdBgDy1IFrFYMmY4z/DDeoCCoD6JmwlXlJFa0judXUYC9zhseEW89kYk6JtF+ftIIrHMgJed3upWBqumPUxXxJB/b6Pu+O+TSYkGsYVrdThVrIW8UntpeIkBfgLrBkTqWRLgHx8p/8DYBV9m3FO0e3IfpVrBvX5m+loGyddnVxMgJ241JGDhpPId8ZRShGixywVB9/k+HtXaDSyZLB0TgrMURKXXiBt4pzlF9y/mYQKLHZg2SJmLvMWt4usbGOzBmaE6M6gPXpT//RWUv3Xj88JsqGUax/C92jXHYRUdVmnlc0BlVHTWFYjiVGK9yex73iikcEVKQqEWsvMSr+0TWbgBLrqeRm3pHnhHRvDuLK9CzzT/7qwF9r6BtzNsgltTOvcVISS9QtmW+CCYGn7ZNXld7o4YwuGIwHpW61WWhb1xkHCnJoJJh2EcADulkCsqoADmJgLhBlHyaClIhvoVSJ8X/5EjtqgMnylDMn/0KXk0om4z8fUmxBu0JiXI71igT5NmkM5gtboK7dSRj/XxfwGeMOof8neAf2lwOPzPn+nijmcaq8u5Pit0RaS9xfbflZCOcxc+WyBkRD7WNW5xwm4KZpYgDdJdMnZwG49pmhEf+6KK5JegXtf6rsFcyTwKSomxjqVv0Q=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|51005399006|461199028|8062599012|15080799012|37011999003|31061999003|41001999006|8060799015|12121999013|19110799012|440099028|3412199025|26121999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k875wMt18wSytWE43rBGMYL2iXIDwHbl83c4CynbUNKhQJ04KNo3PWVHoahn?=
 =?us-ascii?Q?26NIfeg0xZ2+slXag8dsmEkeepW6hvBxnMMsLLW3V5v1tE22exZP1iB49QpU?=
 =?us-ascii?Q?l0RM5mR5yo67tU5VfFI0USWfpu7CdhVrCwra/+ZlwTamWcFByb5WH6PUcLBj?=
 =?us-ascii?Q?WImKB4aJvzSxthX78ktPfCd04uVPMTqmoQJOMSMLupwjlgkJeOEktLBHDHPv?=
 =?us-ascii?Q?7C9fDAWE2itvh67d1rJVFRLzI5NFqTn2DJUsWlDIMtF2fj9+8n5X4ahI31+x?=
 =?us-ascii?Q?NNpx+eke/ejCn53Oih4KuNKzeqtwbChwV1qC/cD9V20bv8Y5O1bt2gB9TZvp?=
 =?us-ascii?Q?X11ASkz9EMZTYCS1EBMlvDHeWNUG9VtJjZEvDW5cyNNI/pt6cc1jAd+vHQfl?=
 =?us-ascii?Q?qAiApoS9Yucr7IYQF1N6duFYVRg7GufsWtNm//R/CsxjDO8IgEwCYRtTzQqR?=
 =?us-ascii?Q?IgA7TDeoff5N8l9IGj8RTqX/AGZrdHyy+9X+OLaPnhFd1hj5PXF2a+v/82Xk?=
 =?us-ascii?Q?JB3bKO2DgCLZbYCmJQBB24VtXw+4beOEgAnyHHpa4uHjUlFEMXf3bpmotPTD?=
 =?us-ascii?Q?RFbsenIlJvPCGH5kFN3+9vEZ+HGJxEg5EVzJGtqTXMot8/nwdKU5b8Uo2Ug3?=
 =?us-ascii?Q?JolOnjXqYGaJk8yvJTqHh1e7livkTMY6Ozv5Jv8Fq5i4kB7EVWVbH28VKtbC?=
 =?us-ascii?Q?xGgTmBITAOokHc/W62aRbsm0/PxPBW6QIBqeNfVN/G6qlz9rYVKvGMX1M8HB?=
 =?us-ascii?Q?lpjzjEGW/5+pXA1FL6SPB6Z3RdTE9YYS5YvxSDEIaH+RFpxpl+5c6p+h8RuD?=
 =?us-ascii?Q?Qk874jO1eUf7K9n0ZKdij1F0+Ftdwm4wU6dOxIEShUSr1s4OErD/wi+tzn58?=
 =?us-ascii?Q?rBSW0XDWPNlAoq5gqQMN+LSJZ9XRMfAcUYKWCOHh9Hl7Xy2oSQchfnH3jfxt?=
 =?us-ascii?Q?MYo6p+RXkJkLuHX99p7eNoCcvOMr9dCE59jFr1ZcC3L++S6MFhfFuRlGkUDE?=
 =?us-ascii?Q?mIWkFnmqF0GFN5KM0v2ENRQbCU0iZZRexQ0y4Q61ElzSpRYJfveg1F7/PNWy?=
 =?us-ascii?Q?SQsVvzx+TQTAoedS9k041rwZ3PkVgQ9Jzrk8mZivS3SbD0qDTyk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?upufumk6JGVS0b9BcomuTFnsSN+OoGvupVwSUhTb+/XSjeMHyusvGXm6Cwda?=
 =?us-ascii?Q?TWgO6EEvgWzXJUsuQqXKQGW67hrNUwpzxaCdgHKOwcgoPqmDpJMXNz/mYCOH?=
 =?us-ascii?Q?QwM3EQpj56U5LXGd8yxBa9HOZZJ0ZNa2RsduvGonapWpcnUWLMOlJ8xoQFeQ?=
 =?us-ascii?Q?FG+bYtu+KpfEJIayYo8F1FRSaWJHcf+Nfh82m97NonoBgMxmxCw/xXCiRein?=
 =?us-ascii?Q?kKOKUtCHlYNy4ZJLUWf61PUcvIVeWBWfL5KPlBXEbnyNmpQar8Yek9D67WWR?=
 =?us-ascii?Q?3W+OtPWLpgYjhrHIEtRqLvDk0qZKXFrotuB+hfRxeXulDdoCoXC7MOE/ZkmE?=
 =?us-ascii?Q?25m2v9WwCDlXt7VODVWrsUPCHK8McgpGs6A6v8SsN1ExW6DY2ijUW6ZbM5Rh?=
 =?us-ascii?Q?YGfyGJ9v8NTKelwo8oIBXAKqzTsLlQ3NT6r4d1c/2d7Eqk7wtAZIHKjTUhCz?=
 =?us-ascii?Q?4cvRPfTCrvAzViLutZ6/e1x3ZVx86UumKr8eYQ2zEFakXj6YjQ0kZ/jGJqbk?=
 =?us-ascii?Q?fHcsc+o5QutQMggVGpXDgX8HGX8OfNilndbZzT68xaSw7a1Y92ll77IfD/7i?=
 =?us-ascii?Q?CZPv611L/kovDc8fxuPPvpas2muw50+Elsr5/o2zp6ZHRjCNute6dksy9jXa?=
 =?us-ascii?Q?j4raJv8AaveKhQZaVW6G5WgtrK3e5td9IXy19cb+FKwqhpKULvu7ZGj3ndxr?=
 =?us-ascii?Q?VYj+QaTx/dr1HVEvHuuMZA6iliBu5d+HYvL7KKdqz0AnYRYsK5F1wbEOIIqP?=
 =?us-ascii?Q?P+pC4/SD8qRx1f3GsIeNW9rMpjdjjTFZf36YvpmBsgyHF+zMHmIbdlq79BrR?=
 =?us-ascii?Q?0hoIWNdo0P+8UQ7+dSZK69+AHavRwpQ+gRSwkGIMVYjo8eqsWdESH0Y4vt5b?=
 =?us-ascii?Q?ra9hTzU7/K1QbHXJcxUNQaBU956nQIpzfXVyoFS+G+jW6u8Ny5jf1Lr6oJJm?=
 =?us-ascii?Q?F6FBSA+RLy5km5agh4GJw5Mnwla9v3R5jPCVIqwFVLtGn6ADhRO7hrNx8MGz?=
 =?us-ascii?Q?GA7f9Aur+s4uNJrsNbi9pZTxIgKshVUn2o2+cBhTM+o2RslkoGLlB+Q805Qr?=
 =?us-ascii?Q?LfMuGaJzUT1wwN8dYxX3unRXUXzzb6r3MdW/MC5X8hJJ5y5/jDPmF3DJohOx?=
 =?us-ascii?Q?fVS86XPTsjdhLzElcNQ2ekik5Ztg84ggBe3ICzZN6sz0LV6hbW9HZ/zfc9xR?=
 =?us-ascii?Q?OAxKlw6koTJmrkGesZwZWKNyaT3l7POrvXgP6iYHesASYcvwAiap23ScCYzW?=
 =?us-ascii?Q?NYKplxSLyWXmhMBwQSSahEQbczPHfCQKBMEZ5/opzkTB/d0iblZ9syoyZdI4?=
 =?us-ascii?Q?m8rAlhcPODhlHVh1cj9ZGrk/Oxiud9x3P724H+VbbUIvT8hau4mW4Q5Nikah?=
 =?us-ascii?Q?M6vVEhI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6c0f42-979c-46ee-0f21-08de9576405f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 13:53:45.1374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7116
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10085-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,google.com,vger.kernel.org,canonical.com,templeofstupid.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: D3E3F3BD3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <DECUI@microsoft.com> Sent: Wednesday, April 8, 2026 2:24 =
AM
>=20
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Sunday, April 5, 2026 4:15 PM
> > > ...
> > > Note: we still need to figure out how to address the possible MMIO
> > > conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> > > MMIO BARs, but that's of low priority because all PCI devices availab=
le
> > > to a Linux VM on Azure or on a modern host should use 64-bit BARs and
> > > should not use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe
> > > devices, and GPUs in Linux VMs on Azure, and found no 32-bit BARs.
> >
> > Just to clarify, since this patch is predicated on all BARs being 64-bi=
t,
> > hv_pci_alloc_bridge_windows() never encounters a non-zero
> > hbus->low_mmio_space, and hence also never allocates from low
> > MMIO space. So hv_pci_alloc_bridge_windows() does not need to be
> > patched. Is that correct?
>=20
> Correct. For 32-bit BARs (if any), IMO we can't really do anything for
> them in hv_pci_allocate_bridge_windows(), since they must reside
> below 4GB.
>=20
> Note: while the patch doesn't fix the MMIO conflict if there are any
> 32-bit BARs, the patch doesn't make things worse for 32-bit BARs (if any)=
.

OK, right. Your patch doesn't prevent 32-bit BARs from working. It
just doesn't fix any potential frame buffer conflicts with 32-bit BARs.
I misinterpreted the situation.

>=20
> > Taking a broader view, fundamentally the current MMIO location of
> > the frame buffer may be unknown to the Linux guest. At the same time,
> > Linux must ensure that PCI devices don't get assigned to the MMIO space
> > where the frame buffer is located. While the current MMIO location of
> > the frame buffer may be unknown, we can assume it was placed in low
> > MMIO space by the host -- either Windows Hyper-V or Linux/VMM
> > in the root partition, and perhaps as mediated by a paravisor. Probably
> > need to confirm with the Linux-in-the-root partition team (and maybe
> > the OpenHCL team) that this assumption is true.
>=20
> IMO this is a good idea! It looks like the framebuffer base always starts
> at the beginning of the low MMIO space. We can reserve some
> MMIO for the framebuffer at the beginning of the low MMIO space.
>=20
> > Presumably the
> > hyperv_drm driver doesn't need to move the frame buffer, but if it
> > does, it must stay in the low MMIO space.
>=20
> It looks like this assumption is true.
>=20
> > This patch depends on this assumption, and effectively reserves
> > the entire low MMIO space for the frame buffer.
>=20
> To make it precise, the patch reserves the entire low MMIO space for
> the frame buffer and the 32-bit BARs (if any), and there is no MMIO
> conflict in the first kernel (assuming hyperv_drm doesn't relocate the
> MMIO range), and there can be an MMIO conflict in the
> kdump/kexec kernel if there is any 32-bit BAR.
>=20
> > The low MMIO space
> > size defaults to 128 MiB on a local Hyper-V,
> Yes, by default, the low MMIO base =3D0xf800_0000, size=3D128MB,
> but the range [0xfed4_0000, 0xffff_ffff], whose size is 18.75MB,
> is reserved for vTPM: see vmbus_walk_resources(). So by default
> the available low MMIO size for hyperv_drm is 128 - 18.75 =3D
> 109.25 MB.
>=20
> The size of the framebuffer should be aligned to 2MB, so if the
> framebuffer size is bigger than 108MB, it looks like there is no
> enough MMIO space in the low MMIO range, e.g. with the below
> command:
> Set-VMVideo -VMName vm_name -HorizontalResolution 7680
> -VerticalResolution 4320 -ResolutionType Maximum
> , the resulting max framebuffer size is
> 7680 * 4320 * 32/8 /1024.0/1024 =3D 126.5625, which would be
> rounded up to 128MB.
>=20
> However, according to my testing, with the above command,
> the low MMIO base =3D 0xf000_0000, size=3D256MB, so it's probably
> ok to reserve 128 MB for the frame buffer.
>=20
> In case the low MMIO size is <=3D64MB, we would want to reserve
> less MMIO for the frame buffer.
>=20
> > and is set to 3 GiB in most
> > Azure VMs (or to 1 GiB in an Azure CVM), so that all gets reserved.
> >
> > A slightly different approach to the whole problem is to change
> > vmbus_reserve_fb(). If it is unable to get a non-zero "start" value, th=
en
> > it should use the same assumption as above, and reserve a frame buffer
> > area starting at the lowest address in low MMIO space. The reserved siz=
e
> > could be the max possible frame buffer size, which I think is 64 MiB (?=
).
>=20
> It can be 128MB with the highest resolution 7680*4320 (I hope the
> highest resolution won't become bigger in the future).

Indeed!

>=20
> > This still leaves low MMIO space for subsequent PCI devices, and allows
> > 32-bit BARs to continue to work. This approach requires one further
> > assumption, which is that the host, plus any movement by hyperv_drm,
> > has kept the frame buffer at the low end of the low MMIO space. From
> > what I've seen, that assumption is reality -- the frame buffer always
> > starts at the beginning of low MMIO space.
> >
> > This approach could be taken one step further, where vmbus_reserve_fb()
> > *always* reserves 64 MiB starting at the low end of low MMIO space,
> > regardless of the value of "start". The messy code for getting "start"
> > could be dropped entirely, and the dependency on CONFIG_SYSFB goes
> > away. Or maybe still get the value of "start" and "size", and if non-ze=
ro
> > just do a sanity check that they are within the fixed 64 MiB reserved a=
rea.
> >
> > Thoughts? To me tweaking vmbus_reserve_fb() is a more
> > straightforward and explicit way to do the reserving, vs. modifying
> > the requested range in the Hyper-V PCI driver.
>=20
> Agreed. Let me try to make a new patch for review.
>=20
> > And FWIW, it avoids  introducing the 32-bit BAR limitation.
>=20
> This patch addresses the MMIO conflict for 64-bit BARs and not for
> 32-bit BARs (if any). The patch does not introduce the 32-bit BAR limitat=
ion.

Right.  I misinterpreted the problem you mentioned about 32-bit BARs.

Michael

