Return-Path: <linux-hyperv+bounces-10000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BGbFALt0mlBcQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10000-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:15:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FC73A0231
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 01:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1DF3006383
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Apr 2026 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340E3803DB;
	Sun,  5 Apr 2026 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CtW8SRh7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012016.outbound.protection.outlook.com [52.103.11.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BA19C556;
	Sun,  5 Apr 2026 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430911; cv=fail; b=YgaUZrGsoYWxVvvXrsEJBqvhx1YeX1p618zuX82BwLXqnBCjmHN1VQzmLLS9SO+qcRm8cENp6Ydj/BAsqw19Y8VDj2ENyufy0F3E8lMV67xf5UTkyMB4JIdOUc/OOZ7cwufd4I22gY3lqxHG/G3jYs1D7t2/xuPmB1e4mXbDvag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430911; c=relaxed/simple;
	bh=V5ZPWcIfabG5P9/GKCQxv6P63aT2TH0cfV8cykd7qQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2uD0LgFFgEozN8aEYl0Xw6L23uEUKzzHah1NBRvFWnFHoap1ejFQP2ck0KUBuv5aRd4u8n7N4Gpe7Hpr3IOBG6Cqmz8svHr/KN0sl6NYk7zkxDjx+Uuo552YDpNOeDmVkZKphybXI13DW4FNu3XCD4xW71mvyfbQ+jBa2iOhqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CtW8SRh7; arc=fail smtp.client-ip=52.103.11.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3HokQUaUOwanDkViONDNEsz1RZRmmYo7Abu8fjR5j9J5+DhtbHwX0ippdIyzTPer8VFbH62sns2E6Ft3s0cLaWUs8pMrkU0xRNeEaaFVU4CzPa6TFLGLwzYjo5iJr9/9d9u+BxRokCBm42lHqTz7tzAu/E1qLn/83sx0LKdVHatQZqP5h30ZXaWdicqjMV/1uOGL1cLp3m0FPTr4SXxYpL/P+ZX4CbyFlOKlcyXdE99BID3NyvjlxGRmuq7NYrbnAANoNtwNSThbm8EQxsKjTUAo2jDc3F+9GLC7hRM7cHoLplt3YZYYaXkcr3rTCurueE4nLp2A63ACCZ2dNd4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgNDf+I1Z2WIBhCFJJ7k0T6uMHaFxkknv+oW+LyPJTk=;
 b=DoA9n85c+o4zkEmFUqOx0X+UEzuQdVcjoM2AmH1hXkvsia82wMD6lt2kIj3NpuX338VrnMuwu5jKoPshAgdibWtKWVGFtOMDEk2ANiqar1u84cQGyKkbE5BkrE9zSPohTBlA7OdSVM0MFfWiZXCKDO7BY5lO3o3B/1coddSHxrreVeccJeBIJVTf1tACmw8C+0z+rw4/dy6ooLQMhrG6wQk71RfMIIomDbvYeMHeT6tRQfvD5DsS/v7OuHopngU1TRl1yQfXIkW6izmHOdbGx4bh5n0ceR59UU2wp5QykqIBGDD8I/UQnQRhgSQuQYzlTy/6/NkhCTUVzEjDCTUQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgNDf+I1Z2WIBhCFJJ7k0T6uMHaFxkknv+oW+LyPJTk=;
 b=CtW8SRh7yyv0xxWlOx/vkaSHlRuQsD9Eo2ivprdurWHewEhvY1Qq+0EKxINwiEFzPtNsRM81KlkCmIj5MCNzjIX/NrSM09GnNWtVXSSlCItMp+kdoo4SuYYjyu2vxkvHA4RzR6WbUatvy/3y5Y59t7xz98uOaQrBaxt4QMgSyn/C3YigeRy1bXpv4IJ1ZozIZU5Jb9zWyYNwJ+hzVDHR9vFP+awxP+6uCHRBIejmVQHy78d63jXr6QXGGJTX1cSNRObSr9NnUyPAgPKa58TuVbG80RTe+6FqJNp8IUPctC8O80Kbi25+e7F529VMtCAGH4BZcfHf+dRXTI/2zWoOQQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7201.namprd02.prod.outlook.com (2603:10b6:303:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 5 Apr
 2026 23:15:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Sun, 5 Apr 2026
 23:15:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jakeo@microsoft.com" <jakeo@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, "matthew.ruffell@canonical.com"
	<matthew.ruffell@canonical.com>, "kjlx@templeofstupid.com"
	<kjlx@templeofstupid.com>
CC: Krister Johansen <johansen@templeofstupid.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH v2] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHcwvqZ7/kLR2JkdUmudlv9HY41bLXRHh0Q
Date: Sun, 5 Apr 2026 23:15:06 +0000
Message-ID:
 <SN6PR02MB415794E53D2B621F6A8BA382D45CA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260402234313.2490779-1-decui@microsoft.com>
In-Reply-To: <20260402234313.2490779-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7201:EE_
x-ms-office365-filtering-correlation-id: 9b00ec4c-079a-4d86-cff7-08de93692cd7
x-ms-exchange-slblob-mailprops:
 a+H6FLLcF3qkJ+BXrfQxbsvYfyGqqDaQfLt1XsgWV+VYRxlGxuY7P/VEnTL7SIjdWLLr6k70vhOP3MVz+9bro4eXwvKualWq/tHqVEfXPT145XnAB9k7OXtZokOG2m7FbavjB1PbW41jSBjo31XFzowrbQcLaJbQj9MYZRG+fcL/a9+4z3vjYuJHmZ+6CuI62zQf8wjNuGdRkQ38bRniEdJJsIORSF45v2hOO1fTM9fjFZzVhbX3jtnfsxGlRQfKLi9uH6OH0rcGjmJWu0LVZEJMKEZF32JlfK+zmx0moi2lsvdM35HN/znXlNQYeFFORI0/r5/9Wm+v3pnbdAUf8RH5Ms0ssFFfiJUpJSkGtlNUpQcYDwGz1+ipeldP27pchpAQulMV/P7wK3PuJuCMGsmDCsC8q1EFD1MxK0PhWARRGqHGurVRadhoSCd4lUHPdg4s8D41moJceZ0semOv+hsE9bQm2CcojwV/VnrRFdezg+wue718r0rYetsRDqIRZ/Uqw6sDowmHk4Ja/jgsfvj0rdM/BiVJzWuXO3URe63ji6q1Q7k1KlmjV5PaCQfotnFJ0cpCUtMQsEFdhLAO8h6LCTPGlqku7VezFiZmOv+7yvVzsZUMsd9+9Zxo/nx6P9lCVc9QggF2Yg9M79TMv6VRNw1HteP8nrc+WloRXxYt1y0oE0XiplPVuPDrOY1ah98uO4NrfdKiI4EpKR/ZpomFn4T4tWcqNNJiLeU6UBbSiuKx8/fbqVVIP/0atQf+U/R8Wj/X12GBx/R8UiKcJN9mZbbu7aih867tusDLpjAPECYS2WGLIZ0PJuHO+lhi
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|31061999003|8060799015|51005399006|461199028|41001999006|37011999003|8062599012|12121999013|15080799012|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|102099032|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BlVzv1QWiCUwk3Z4HpiHhwX2N6GQBzCQ8vehP8szvgq27zjonK+4HACDYOXT?=
 =?us-ascii?Q?0yiVPemM44mXCbbE7SJTeeL0vBe+kjNUrKIX3qtvHCtWb2D7zZJD41e70UX1?=
 =?us-ascii?Q?w67NNIx23fom8Nd19mC0RcaveZYq54ZbE108UIVJIKc7DWzoirCapDAjEK4Y?=
 =?us-ascii?Q?NXUoiygGNufkA5jzZZJR+4Z+zx+E/dELXIeDqi04Z1Wo9HRJL6NQo1H1cFPd?=
 =?us-ascii?Q?JIbI/7I5iBKc6NyDzfqIEZqb/oNAOB1eHL9+C5OQgZ/KroZdGXGZrORJ/1n4?=
 =?us-ascii?Q?/YULnEBQqqfewtZAoX08ipcIalENE8AMdxTlAfnY6iWYHeEtZer0Wu5UYEIu?=
 =?us-ascii?Q?PYVFEZsjqyvzahFSXoLSMvF8WkdJGKX7AvkQvNoh6vzrYJZxbPRKvMzbcDF9?=
 =?us-ascii?Q?UXakBzzUmTCkrr8Z+SHPqfq0A77C7n84JuH+8PXgHmGp8chYzbCyZkPehPqQ?=
 =?us-ascii?Q?ayeSIyDbYzVwP8g1CoWgAhMkPPZSGvsG35x4V74aKb/JiY8aD91PyVSk2ume?=
 =?us-ascii?Q?ZM/nznpiFwb5osYTYlEZlteaG15U2UDRdZzukVkZyC1BZRH0EuLDTZCohi8C?=
 =?us-ascii?Q?fyBeSYQS7Ld11pkWsuuTeW7vAM6K9IeQUWyT8jHtb7/8zXI5+mMbuL2PzyMb?=
 =?us-ascii?Q?R+42G2L5Jis9WJRdk47Y1ABGErNfHDW8jWdWPDyAD3zdhkLEUgW5Guy3hisj?=
 =?us-ascii?Q?qivBS35rMb0zKLQamHPBHXFjJWeT8J+0q1yXUVhUbcHXkxLHHmM+1vzeMhok?=
 =?us-ascii?Q?v0mVWoQIZyze2rbA77em+6KlynLI9LVuDLseg5VnMpjL4gWZiPfWHF+LcAUl?=
 =?us-ascii?Q?0jCPq5rmKaL2SGcJ4lCwfMRS+gtKfPCJ6M8lXRhaTTs+Slfs58YOyQmFLQzn?=
 =?us-ascii?Q?X2a1QHMSDtmfKJy6eB1TrIBZMfrkl5J0QFagUtE6ZOnUV/qwdSBV37Nir1cX?=
 =?us-ascii?Q?RIGhqVpW4J80t7Oeo//bUChwTX6N9EakJvq5v9Ui5OvANe26CwCdcMnPnSwY?=
 =?us-ascii?Q?+i5GBPuG3JgrQIUxSa+l99FuhuDTWncY5oXcG3cNz8USH5rwjtL0xRo1VqmK?=
 =?us-ascii?Q?zA1+LLoi8Ry548f32wfVNJnGZEcsl1p1YbcRZvyTYKrGbL7YhrJbSbUTB6+w?=
 =?us-ascii?Q?uVeiq964PpdW0enX55Q051jgeIQBBV701iLLLtppLQz7aqPcXH74Oxey2Szu?=
 =?us-ascii?Q?/WLSFPkKvDoHMsWV657+VdFM+q8ftDVk1rP7v7B/pEfIg1avw6MCvVS0NGU?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N4OzXtG9glev0TJT1/xEG0uCxLsEUblYb+eNFhQIp9xs6z0V3BZXMO3aJQ+1?=
 =?us-ascii?Q?7k7756wnD+CSqpLoMr9hywjsSkdqUCVDx4/SdJKhDFQffko34+bD+ne/8uH6?=
 =?us-ascii?Q?UTvOrLHxDX3ndDzdVYcre07VXXIliZgkjv3P6kWswc5/sLjo7UVhHdkNiijC?=
 =?us-ascii?Q?r7gPQt094bWvKHOZazsJ9oQ3nLPUguTQRGtg80gYooBxpVmUGDzWuzIHUMVm?=
 =?us-ascii?Q?ljNKKFF0Fx4H6wxi+Vf6ISR3Zj2QqWwHpfEEAZau4KHcPWIPfqcA9VAKDGgM?=
 =?us-ascii?Q?By3i4GW0XO41+oVIJG/eMchG8M3FHgJMSbd6DyC4d6Jwtj7KpnqnCDFvwOOf?=
 =?us-ascii?Q?z7JpbZUzdQ/Hsg5LgxRTed/4S2CJXrvbspjlb0AqI23YlR3LaNoKX0+PD+Bn?=
 =?us-ascii?Q?k40ZR8HnuAj10G5vsRPJ4134T1l5XrArmB0YBGu8J72DLeVO/7Jae/jeZf+x?=
 =?us-ascii?Q?A3CTweYUGYMpn9UaqvtkDNFju87Fl5b6cA+5YMD8W4q5dHb45KYRflh15CB7?=
 =?us-ascii?Q?8TQKXuPMPn3ZkzJ/dFALwVc6jlMMdRIbgwoqTsRyMDBno2HANP3qrbhu3I5I?=
 =?us-ascii?Q?qSzm5hDdaZ/bcSq72KnAm3fPZJWQzbyliWGYNyb023j9+iQlHLyLZANo3kEa?=
 =?us-ascii?Q?BQC1e9+v4r5pSWf1X2nrJu3K7QNDbk8kaNhfGPiE9d0lGDLx61jQO+E1s1xr?=
 =?us-ascii?Q?uv2b+cabD3yIJkUwfUAXt+yDFljFAeTCqFQzh4sLpn+9gCbTlnGPmhIPh7gK?=
 =?us-ascii?Q?H7kMZ2JnJvRiBhltJ6hUA54KsgRRbhZ5RQIg47CH+CXxMeLJD5YfXiZyez2o?=
 =?us-ascii?Q?r2rRNqaSV65b4ghAoZOTMOZZhxS8et+nauSmZPThe9gtH4+t2oRtS6xsRaZF?=
 =?us-ascii?Q?MDevO+2pJegq+ovL4ert1Y6e9hsAFyeisCTLuL84OsjJKDUfJMus9WHaTjQf?=
 =?us-ascii?Q?RfuC0YQXEMpqWwT+LD5B4W7ORnL9tygsenX7T5Trsl1thh6wiesVSiMnwyQz?=
 =?us-ascii?Q?ZjMjo3jN43tzhJgcfPDLPsLqK6rzHsMF8SuFhfC8iev1KKb8/cBzAnNUBFwh?=
 =?us-ascii?Q?SjvfAJKxPGVHW6P6FJCPH4Kx/w90zkvEq32evox/I1Z1zrezQ7dAU2vGkCw0?=
 =?us-ascii?Q?inrlFj1GxUzmrfZ6Tgr7RyEtzn1IfydFL6TDWfCE4rLkkKDc8EPRqBAQopLQ?=
 =?us-ascii?Q?s6x+IuSHTLHoeO2RechXBdN7flqSFIjMvdf8ddVnUE5oMvPfNbUh02aRetY3?=
 =?us-ascii?Q?/7CkeaXr6ev2+GFNlDFZEwGvc03FbuWrxDOqsPcVsLa1OCguT5jr9KoG+SB2?=
 =?us-ascii?Q?eVI4kWIqPA05evWYo+gUTIuukzezc8EArgcAIke4lC2mFNNZi8qHCcbD+Kae?=
 =?us-ascii?Q?p0cK7CE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b00ec4c-079a-4d86-cff7-08de93692cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2026 23:15:06.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7201
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10000-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,google.com,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com];
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
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,templeofstupid.com:email]
X-Rspamd-Queue-Id: 93FC73A0231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, April 2, 2026 4:43 P=
M
>=20
> There has been a longstanding MMIO conflict between the pci_hyperv
> driver's config_window (see hv_allocate_config_window()) and the
> hyperv_drm (or hyperv_fb) driver (see hyperv_setup_vram()): typically
> both get MMIO from the low MMIO range below 4GB; this is not an issue
> in the normal kernel since the VMBus driver reserves the framebuffer
> MMIO range in vmbus_reserve_fb(), so the drm driver's hyperv_setup_vram()
> can always get the reserved framebuffer MMIO; however, a Gen2 VM's
> kdump kernel can fail to reserve the framebuffer MMIO in
> vmbus_reserve_fb() because the screen_info.lfb_base is zero in the
> kdump kernel due to several possible reasons (see the Link below for
> more details):
>=20
> 1) on ARM64, the two syscalls (KEXEC_LOAD, KEXEC_FILE_LOAD) don't
> initialize the screen_info.lfb_base for the kdump kernel;
>=20
> 2) on x86-64, the KEXEC_FILE_LOAD syscall initializes kdump kernel's
> screen_info.lfb_base, but the KEXEC_LOAD syscall doesn't really do that
> when the hyperv_drm driver loads, because the user-space kexec-tools
> (i.e. the program 'kexec') doesn't recognize the hyperv_drm driver
> (let's ignore the behavior of kexec-tools of very old versions).
>=20
> When vmbus_reserve_fb() fails to reserve the framebuffer MMIO in the
> kdump kernel, if pci_hyperv in the kdump kernel loads before hyperv_drm
> loads, pci_hyperv's vmbus_allocate_mmio() gets the framebuffer MMIO
> and tries to use it, but since the host thinks that the MMIO range is
> still in use by hyperv_drm, the host refuses to accept the MMIO range
> as the config window, and pci_hyperv's hv_pci_enter_d0() errors out,
> e.g. an error can be "PCI Pass-through VSP failed D0 Entry with status
> c0370048".
>=20
> Typically, this pci_hyperv error in the kdump kernel was not fatal in
> the past because the kdump kernel typically doesn't rely on pci_hyperv,
> i.e. the root file system is on a VMBus SCSI device.
>=20
> Now, a VM on Azure can boot from NVMe, i.e. the root file system can be
> on a NVMe device, which depends on pci_hyperv. When the error occurs,
> the kdump kernel fails to boot up since no root file system is detected.
>=20
> Fix the MMIO conflict by allocating MMIO above 4GB for the config_window,
> so it won't conflict with hyperv_drm's MMIO, which should be below the
> 4GB boundary. The size of config_window is small: it's only 8KB per PCI
> device, so there should be sufficient MMIO space available above 4GB.
>=20
> Note: we still need to figure out how to address the possible MMIO
> conflict between hyperv_drm and pci_hyperv in the case of 32-bit PCI
> MMIO BARs, but that's of low priority because all PCI devices available
> to a Linux VM on Azure or on a modern host should use 64-bit BARs and
> should not use 32-bit BARs -- I checked Mellanox VFs, MANA VFs, NVMe
> devices, and GPUs in Linux VMs on Azure, and found no 32-bit BARs.

Just to clarify, since this patch is predicated on all BARs being 64-bit,
hv_pci_alloc_bridge_windows() never encounters a non-zero
hbus->low_mmio_space, and hence also never allocates from low
MMIO space. So hv_pci_alloc_bridge_windows() does not need to be
patched. Is that correct?

Taking a broader view, fundamentally the current MMIO location of
the frame buffer may be unknown to the Linux guest. At the same time,
Linux must ensure that PCI devices don't get assigned to the MMIO space
where the frame buffer is located. While the current MMIO location of
the frame buffer may be unknown, we can assume it was placed in low
MMIO space by the host -- either Windows Hyper-V or Linux/VMM
in the root partition, and perhaps as mediated by a paravisor. Probably
need to confirm with the Linux-in-the-root partition team (and maybe
the OpenHCL team) that this assumption is true. Presumably the
hyperv_drm driver doesn't need to move the frame buffer, but if it
does, it must stay in the low MMIO space.

This patch depends on this assumption, and effectively reserves
the entire low MMIO space for the frame buffer. The low MMIO space
size defaults to 128 MiB on a local Hyper-V, and is set to 3 GiB in most
Azure VMs (or to 1 GiB in an Azure CVM), so that all gets reserved.

A slightly different approach to the whole problem is to change
vmbus_reserve_fb(). If it is unable to get a non-zero "start" value, then
it should use the same assumption as above, and reserve a frame buffer
area starting at the lowest address in low MMIO space. The reserved size
could be the max possible frame buffer size, which I think is 64 MiB (?).
This still leaves low MMIO space for subsequent PCI devices, and allows
32-bit BARs to continue to work. This approach requires one further
assumption, which is that the host, plus any movement by hyperv_drm,
has kept the frame buffer at the low end of the low MMIO space. From
what I've seen, that assumption is reality -- the frame buffer always
starts at the beginning of low MMIO space.

This approach could be taken one step further, where vmbus_reserve_fb()
*always* reserves 64 MiB starting at the low end of low MMIO space,
regardless of the value of "start". The messy code for getting "start"
could be dropped entirely, and the dependency on CONFIG_SYSFB goes
away. Or maybe still get the value of "start" and "size", and if non-zero
just do a sanity check that they are within the fixed 64 MiB reserved area.

Thoughts? To me tweaking vmbus_reserve_fb() is a more
straightforward and explicit way to do the reserving, vs. modifying
the requested range in the Hyper-V PCI driver. And FWIW, it avoids
introducing the 32-bit BAR limitation.

Michael

>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V VMs")
> Link: https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@=
SA1PR21MB6921.namprd21.prod.outlook.com/
> Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
> Tested-by: Krister Johansen <johansen@templeofstupid.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>=20
> Changes since v1:
>     Updated the commit message and the comment to better explain
>     why screen_info.lfb_base can be 0 in the kdump kernel.
>=20
>     No code change since v1.
>=20
>=20
>  drivers/pci/controller/pci-hyperv.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 2c7a406b4ba8..1a79334ea9f4 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3403,9 +3403,26 @@ static int hv_allocate_config_window(struct
> hv_pcibus_device *hbus)
>=20
>  	/*
>  	 * Set up a region of MMIO space to use for accessing configuration
> -	 * space.
> +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> +	 * driver (which normally gets MMIO from the low MMIO range) in the
> +	 * kdump kernel of a Gen2 VM, which may fail to reserve the framebuffer
> +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> +	 * zero in the kdump kernel:
> +	 *
> +	 * on ARM64, the two syscalls (KEXEC_LOAD, KEXEC_FILE_LOAD) don't
> +	 * initialize the screen_info.lfb_base for the kdump kernel;
> +	 *
> +	 * on x86-64, the KEXEC_FILE_LOAD syscall initializes kdump kernel's
> +	 * screen_info.lfb_base (see bzImage64_load() -> setup_boot_parameters(=
))
> +	 * but the KEXEC_LOAD syscall doesn't really do that when the hyperv_dr=
m
> +	 * driver loads, because the user-space program 'kexec' doesn't
> +	 * recognize hyperv_drm: see the function setup_linux_vesafb() in the
> +	 * kexec-tools.git repo. Note: old versions of kexec-tools, e.g.
> +	 * v2.0.18, initialize screen_info.lfb_base if the hyperv_fb driver
> +	 * loads, but hyperv_fb is deprecated and has been removed from the
> +	 * mainline kernel.
>  	 */
> -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
>  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
>  	if (ret)
>  		return ret;
> --
> 2.43.0
>=20


