Return-Path: <linux-hyperv+bounces-11886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nELDkfzT2oQrAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11886-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:15:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB112734D5F
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 21:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=pySLDLL8;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11886-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11886-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68FC130927DC
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430EC3AFD16;
	Thu,  9 Jul 2026 19:08:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011029.outbound.protection.outlook.com [52.103.13.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52643ABD8E;
	Thu,  9 Jul 2026 19:08:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624114; cv=fail; b=E+XighdLvLjep3SeRM7n4ssePaNipvsKfaUIilpOulj5tcS4p3g3VMsbppybA7Rsozr+lnK1vA+QS8JTLMNwRUQv0wXxC+3mFGS2XDF/eQ81X2bYcNkgSwYBBvku6OiVw2Z8RgAlhW9g/wpu4jYpdaFmK7pWDdzoNW3tbPVopCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624114; c=relaxed/simple;
	bh=2xGB3N/+E/cR+jQ8mYoI5pZYWQ2BtDOzxRZ0rd2PqPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0K373Zn3Hej3nDojaN4hHeL/MGkUwXvfeCRAXb1hjsg7I7T2MuQweeEzIfROYQzjna6gGLyc55lrxAJCOnadIuvwgk1uTwha2s3VtT5OHngW0Oa1DqrBY1+DlZiBGTT4QPeL2shm5ogp6wdiEFuS2I0ninpPvWY6gi9YJfMZX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pySLDLL8; arc=fail smtp.client-ip=52.103.13.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFKDSZ8bTH/XwgWZp9L1rplftcEzUlYS/ZjC9EcoR2RJa4/FHvy5RV3iVmc/y4EMedCsKGrth/Gd5HNWtH+4+AtrXLC/KHcEWQYT42h6s7pLcXQw0UnF7cK/BwrqhpDDWA943kHcG8pKUXSXeGTOhDVY/Au4ropwXImbzJHf753mQqO4K7IPoNZELl4tV65MqaHji+IpDSEpiqmpbNejJ+36sqphQCKhLMGnpweGfUk51togEhxR0yPWAAADFdaL8Af7RmqwrjIHRnc39dE+ULd7Fhhs4sWsDRcvUay/4ZzajpzwBKTqpQrKl8VtWOZczj7OTp3l4JDm5IGdq7kC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCIjUMbI+2ztJAvXyrPIaLwhp3OYjfJhfz+gcxaQPAc=;
 b=WjAmS/6Nzs2PV8J1sRfSljxbTUbHeA9/EI2LijacBd+5kZTUw9wpEKC8Jc1NPeWJ5slmKDfb9LEbkR/lejcfr3h3a6j6gVoY7uzpWkZAYdqD4j571rsL51LefjDli9k5kqx/egNxIChm2EJoF4ld6uExr0yj5JY+BIfSWiNcsN1RYfYcarhPEERkjoVH0gFB3tWte2ziAo5sIzv8y004LEOmb//pd5V8NFgpd75e2LCcbyaDPUJwAhmniwCrpCLnkyu8GwE1hCmBPSiwufEvM2ndk/8VJv8TK9IDHu/pqUlnf6UuSzDnzFVO+d1lpFqKRmQTDMWlAjpEg6UL3InApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCIjUMbI+2ztJAvXyrPIaLwhp3OYjfJhfz+gcxaQPAc=;
 b=pySLDLL8wIUENCkygUm8h/u389SKL+9jEuVG2SmomRHhxe/9CzhX63QAAQ8uJ6YsN17Z+yuX5d6NjHr32hj263Ro+c/b72nR9UbyS0PtT3WTwWyIYJTGo2YF27dcq2X+dcLjmMpLW396Cz+KGKKm3lCpszr1iaZutm7zjnhD8IkTYjAYt/WwBlO2osOQBmozk620uAjWyxYchzDz7H73zs4cKImaWj2oBVNGWHS0pVTDR+ZVvPc4EssuUdhcAhO2n1p8FGC2/bQByBwVFPzW4lvRqPnAUpMBLfDtjCH7yHDx7KBHNug9WrijOngjU2WLwR4rIVP9Byszd9xcU2nSdg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6905.namprd02.prod.outlook.com (2603:10b6:5:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 19:08:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 19:08:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHdCjyk3FoDd2PvoEaR3JQ0We2DX7ZlmCnQ
Date: Thu, 9 Jul 2026 19:08:26 +0000
Message-ID:
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6905:EE_
x-ms-office365-filtering-correlation-id: b4f48830-2f10-4dc4-197c-08dedded7469
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|13091999003|19110799012|8062599012|8060799015|51005399006|12121999013|31061999003|19101099003|25010399006|37011999003|15080799012|40105399003|12091999003|56899033|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oFKclpUIJ3/Az/oZNBU5GUe84bWHmpz42hY6YtfCDTNkQgSwNKS4lsQbspUT?=
 =?us-ascii?Q?l4LF0rGvkTWKzyVKRZ2EB7CVL6BBSLrbP6AY167uOx6i/S9uG8VCbsTN56PZ?=
 =?us-ascii?Q?Vi/odkd9pfl8Sb/SVXpCvDU4zbF7kbjqq7b4v1j+jVfxYrhX6VjGmwW4i9k8?=
 =?us-ascii?Q?qO+5PTw9m1f2dikbslXOiE+SM2rCp4/3L8gOYbGFSa3mihmLDzgPkNZhmn0G?=
 =?us-ascii?Q?c1bIF00UWlaHfUsy8t9Qdzvrcx1uwZohsyAf+E2iig+jM5IhEXJoi0JkE1JI?=
 =?us-ascii?Q?ihPvOKG6bZrWTcFa4Jm5hOVSaQ02VgCjr2NgHRXwPRWH2pDNysUKMXl6lWjo?=
 =?us-ascii?Q?sO1sAflcgM8PZ4C/DkkLzoO2ObdySbqtAdYBIcn7uZPuhIQR8Nvm6RpNQDOe?=
 =?us-ascii?Q?r+2AFAk8pItsfSQDXeQiZS3wNb3GSmv0ORO7t5/4XDRPNzb//dunF5PVnn0N?=
 =?us-ascii?Q?+FOilg/7oUZsBex0ZSr/ZBIR5SzUT0s1nGhXEivO3Nz4tw/1t4NTY0Idkn9E?=
 =?us-ascii?Q?gWKXzhrl3UvmP6/7hfnYefOriOo31tm+QVWeyO4B14VpgM1lxSQmoQiiLE5Z?=
 =?us-ascii?Q?be6RO7YgLJz1zGF/lK4V23y8rMseKPp4g09SuSWdNCEpQQWrSfb56KfkaDk3?=
 =?us-ascii?Q?0avPh0K8KY5beKJOzYlPUfQEfQoChVccRtDML77qDYVfy5hGBq4H+MtbKu1K?=
 =?us-ascii?Q?S2svSO/mzdU/CnWSeuo75GU0WpMpjxt0XzCteWUBan0NF2w2oufmyU1XMENF?=
 =?us-ascii?Q?/30pWbYqStHE/Zw6tcAvvhzeclGnw6p2HFNp+HBmFqdtiu5iIy9KYTMZlze0?=
 =?us-ascii?Q?rFE1mY/MaK8Jb2qF7OYwOIQ+u6jr/tc2XiCHwHuqcbiOkjMvazDR2ohj47ag?=
 =?us-ascii?Q?edEUDwAu1W/dfSL3tt60hD27QxQ8vH0hyozzAscJS5qn0biBbBhQ+OAxu4ww?=
 =?us-ascii?Q?cnhoYwEoVo+0nu0z7EsCYSjwd6e7RNplFkCkV/G7uX+E3c4LAiBA76qk8bUE?=
 =?us-ascii?Q?I8aMmbJIaxX7/6WIXwTcoEVz7hfBxbLfRkUFmW8obNFKpk419+rIWKAPkoWa?=
 =?us-ascii?Q?Av0M3PpZeKGCpJvvRWdauEZWLLvSmIUmByTVlF0Igh6nei5Jri/stnJj1BnU?=
 =?us-ascii?Q?NyEReEAKVc6+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q+AIzEH4dJ3aii9D2L9YTmh7HxP97mnJ7yOlu/I8dEmmu6okYxUVC9jVLzOv?=
 =?us-ascii?Q?G1EmBHoGwo+W1rCb5gxifkn7lqIg1FqFLywwX+8e9sXPCANyRh5c80vV0+bu?=
 =?us-ascii?Q?8b6xdc3lcPJ1URw1c23PD3NC4JqsJe/Fi1TK5un0JYOUpxhko1V6ms4GwWsn?=
 =?us-ascii?Q?69h6dhUWXKxc+CdNzxCbSxZJfz8JRW39MW3zPgsI6Q75PMQUgOyYTUavzSNc?=
 =?us-ascii?Q?R/S0h7A6JeJJpxdFmmi4YPzdr86VfnoTG802kqTk5YLn28oIelMA79ks0R6z?=
 =?us-ascii?Q?TaLT2aWf7qXZRxX54CxsAdYy1K/n0aye9W9tIXMERsfDjiODo3jUUhfXoDDG?=
 =?us-ascii?Q?vNkyQMtZ8GCOoPNpLlIynIHiFkOolAjFdMzEAL2nfgzspf+GeF47hK/8vSPt?=
 =?us-ascii?Q?6cI8/cdzSKYhBqjfj4B9GTOdrtoUPafGhfDILMQ6tFr8U9wf4hWm51Y4C3dz?=
 =?us-ascii?Q?hsyATvD+WuIhu02ou+91F8y9iEG6Vn8wCbGgrHyGPdjrQ4eRlX8XQzQX4hlU?=
 =?us-ascii?Q?OwKFLoFV32aL8MYcTiTYXDAG+5Q4yrdhLTrX8ShUWW7B2eY3MVlVOijj6khc?=
 =?us-ascii?Q?vF1KgJbdk3Zc+vcSKK1W+YYjKmoXHT5uGaZE+MmmIsAogKIov3aLYGzJZPtt?=
 =?us-ascii?Q?4Jht7XFrR4eninBnEuSjLBCHDh65aZPwt3a81cY2lRCVmMXWxEueS9dnVFtS?=
 =?us-ascii?Q?TciRTRIf6SRLOMBKHSEPwpoW+bCX64TXY8+GFlcc9hfaEC1/jy0EXmXYieKB?=
 =?us-ascii?Q?C4XQsSEFJur3J6fBPXHhwpvYDlYJ8QFX4EWds/h91F20cG59gtsYtbM4xFET?=
 =?us-ascii?Q?RNfwp8B6uSxrmMomhm7iFEs58LbYfPlXCQj6yV7Xp53bONmo43XaQJiKSTK+?=
 =?us-ascii?Q?MKWkbFQHlm2D4a12nofNA0IGz35v5+JL6jh3NyZaKza11AHYOaVZBZdjXYZr?=
 =?us-ascii?Q?BmVpo00iL3DAgXxOlZ9AUphNagqh/YV+ANE+zUsxTL10Nhf3QEgMVPwx5YCE?=
 =?us-ascii?Q?G7PTJSmHELE5IphIuCwRA/wUIR0nkKILCnMcd06d6RUHUcDDS7SmuMo9Yiws?=
 =?us-ascii?Q?25XBpMuDJFI/RZpYxV1gOQ3rfduBhsPi6uiqJ8S0SBNWdohq56f+UdWsomTS?=
 =?us-ascii?Q?eKeC24TqGoFpbXV0do0l9ZEoE/97UHBkjgni0A05qE2ar7SK2lGBc/LPaxZq?=
 =?us-ascii?Q?YEsqAuI/A/j0BEjCY0l/i8rURoimiAepueeyucVtyp8849swXL9dqCUTJ4RA?=
 =?us-ascii?Q?okV8iuoxp7MiEKuKrLHo6Y66cXoeBlZHJzxB65AavH7vcXqa+DqjJ7RxY9VI?=
 =?us-ascii?Q?Jqwbt8CJNpcgxmDPaGE58devfXQTpl7RwPAvaROpVKtoSWUYcCCyhnxTqr4e?=
 =?us-ascii?Q?zNz8KAU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f48830-2f10-4dc4-197c-08dedded7469
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 19:08:26.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6905
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11886-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,outlook.com:from_mime,outlook.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB112734D5F

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 =
9:05 AM
>=20
> Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> This driver implements stage-1 IO translation within the guest OS.
> It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> for:
>  - Capability discovery
>  - Domain allocation, configuration, and deallocation
>  - Device attachment and detachment
>  - IOTLB invalidation
>=20
> The driver constructs x86-compatible stage-1 IO page tables in the
> guest memory using consolidated IO page table helpers. This allows
> the guest to manage stage-1 translations independently of vendor-
> specific drivers (like Intel VT-d or AMD IOMMU).
>=20
> Hyper-V consumes this stage-1 IO page table when a device domain is
> created and configured, and nests it with the host's stage-2 IO page
> tables, therefore eliminating the VM exits for guest IOMMU mapping
> operations. For unmapping operations, VM exits to perform the IOTLB
> flush are still unavoidable.
>=20
> To identify a device in its hypercall interface, the driver looks up the
> logical device ID prefix registered for the device's PCI domain (see the
> logical device ID registry in hv_common.c) and combines it with the PCI
> function number of the endpoint device.
>=20
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       |   4 +
>  arch/x86/include/asm/mshyperv.h |   4 +
>  drivers/iommu/Kconfig           |   1 +
>  drivers/iommu/hyperv/Kconfig    |  16 +
>  drivers/iommu/hyperv/Makefile   |   1 +
>  drivers/iommu/hyperv/iommu.c    | 620 ++++++++++++++++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h    |  51 +++
>  7 files changed, 697 insertions(+)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 55a8b6de2865..094f9f7ddb72 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -578,6 +578,10 @@ void __init hyperv_init(void)
>  	old_setup_percpu_clockev =3D x86_init.timers.setup_percpu_clockev;
>  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev=
;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +	x86_init.iommu.iommu_init =3D hv_iommu_init;
> +#endif
> +

This approach to .iommu_init is a bit different from the Intel VT-d and
AMD IOMMU initialization. Those cases detect the existence of the
IOMMU first via a "detect" function that is called in pci_iommu_alloc().
If the detect function finds an IOMMU, it sets .iommu_init. Any
reason not to use the same approach for the Hyper-V pvIOMMU?
One problem with exactly the same approach is that Hyper-V
hypercalls aren't set up at the time pci_iommu_alloc() runs.
So you'd have to call the "detect" function here in hyperv_init(),
and have the detect function set .iommu_init if pvIOMMU
support is present.

While the code currently in this patch works, it generates boot
time errors if the kernel is built with CONFIG_HYPERV_PVIOMMU
but run in a guest on a host without pvIOMMU support:

[    0.101673] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed, statu=
s 2
[    0.101675] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed: -22

We really don't want errors if it's just the case that there's no
pvIOMMU support. A less alarming message (at INFO level instead
of ERROR level) about running without an IOMMU might be OK, but
perhaps is unnecessary since you have an INFO message if the
pvIOMMU is found and successfully initialized.

>  	hv_apic_init();
>=20
>  	x86_init.pci.arch_init =3D hv_pci_init;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee..20d947c2c758 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -313,6 +313,10 @@ static inline void mshv_vtl_return_hypercall(void) {=
}
>  static inline void __mshv_vtl_return_call(struct mshv_vtl_cpu_context *v=
tl0) {}
>  #endif
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int __init hv_iommu_init(void);
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>=20
>  #endif
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6e07bd69467a..0d128f377929 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -195,6 +195,7 @@ config MSM_IOMMU
>  source "drivers/iommu/amd/Kconfig"
>  source "drivers/iommu/arm/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
> +source "drivers/iommu/hyperv/Kconfig"
>  source "drivers/iommu/iommufd/Kconfig"
>  source "drivers/iommu/riscv/Kconfig"
>=20
> diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
> new file mode 100644
> index 000000000000..8b6abbaaf9b8
> --- /dev/null
> +++ b/drivers/iommu/hyperv/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# HyperV paravirtualized IOMMU support
> +config HYPERV_PVIOMMU
> +	bool "Microsoft Hypervisor para-virtualized IOMMU support"
> +	depends on X86_64 && HYPERV
> +	select IOMMU_API
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_X86_64
> +	select IOMMU_IOVA
> +	default HYPERV
> +	help
> +	  Para-virtualized IOMMU driver for Linux guests running on
> +	  Microsoft Hyper-V. Provides DMA remapping and IOTLB
> +	  flush support to enable DMA isolation for devices

I think this is specifically "PCI devices", right?  VMBus devices
that do DMA (storvsc and netvsc) don't use the pvIOMMU.
The "assigned to the guest" phrase pretty much implies "PCI",
but it would be clearer to be explicit.

> +	  assigned to the guest.
> diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefil=
e
> index 6ef0ef97f3dd..fefb409d976b 100644
> --- a/drivers/iommu/hyperv/Makefile
> +++ b/drivers/iommu/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IRQ_REMAP) +=3D hv-irq-remap-x86.o
> +obj-$(CONFIG_HYPERV_PVIOMMU) +=3D iommu.o
> diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.c
> new file mode 100644
> index 000000000000..254136946404
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.c
> @@ -0,0 +1,620 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2019, 2024-2026 Microsoft, Inc.
> + */
> +
> +#define pr_fmt(fmt) "Hyper-V pvIOMMU: " fmt
> +#define dev_fmt(fmt) pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/generic_pt/iommu.h>
> +#include <linux/pci-ats.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +struct hv_iommu_dev *hv_iommu_device;
> +
> +/*
> + * Identity and blocking domains are static singletons: identity is a 1:=
1
> + * passthrough with no page table, blocking rejects all DMA. Neither hol=
ds
> + * per-IOMMU state, so one instance suffices even with multiple vIOMMUs.
> + */
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops;
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops;
> +static struct iommu_ops hv_iommu_ops;
> +
> +static struct hv_iommu_domain hv_identity_domain =3D {
> +	.domain =3D {
> +		.type	=3D IOMMU_DOMAIN_IDENTITY,
> +		.ops	=3D &hv_iommu_identity_domain_ops,
> +		.owner	=3D &hv_iommu_ops,
> +	},
> +};
> +static struct hv_iommu_domain hv_blocking_domain =3D {
> +	.domain =3D {
> +		.type	=3D IOMMU_DOMAIN_BLOCKED,
> +		.ops	=3D &hv_iommu_blocking_domain_ops,
> +		.owner	=3D &hv_iommu_ops,
> +	},
> +};
> +
> +static inline bool hv_iommu_present(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_PRESENT;
> +}
> +
> +static inline bool hv_iommu_s1_domain_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_S1;
> +}
> +
> +static inline bool hv_iommu_5lvl_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_S1_5LVL;
> +}
> +
> +static inline bool hv_iommu_ats_supported(u64 cap)
> +{
> +	return cap & HV_IOMMU_CAP_ATS;
> +}
> +
> +static int hv_create_device_domain(struct hv_iommu_domain *hv_domain, u3=
2 domain_stage)
> +{
> +	int ret;
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_create_device_domain *input;
> +
> +	ret =3D ida_alloc_range(&hv_iommu_device->domain_ids,
> +			hv_iommu_device->first_domain, hv_iommu_device->last_domain,
> +			GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	hv_domain->device_domain.partition_id =3D HV_PARTITION_ID_SELF;
> +	hv_domain->device_domain.domain_id.type =3D domain_stage;
> +	hv_domain->device_domain.domain_id.id =3D ret;
> +	hv_domain->hv_iommu =3D hv_iommu_device;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->create_device_domain_flags.forward_progress_required =3D 1;
> +	input->create_device_domain_flags.inherit_owning_vtl =3D 0;
> +	status =3D hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("HVCALL_CREATE_DEVICE_DOMAIN failed, status %lld\n", status);
> +		ida_free(&hv_iommu_device->domain_ids, hv_domain->device_domain.domain=
_id.id);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_delete_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_DELETE_DEVICE_DOMAIN failed, status %lld\n", status);
> +
> +	ida_free(&hv_domain->hv_iommu->domain_ids, hv_domain->device_domain.dom=
ain_id.id);
> +}
> +
> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_flush_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	status =3D hv_do_hypercall(HVCALL_FLUSH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_FLUSH_DEVICE_DOMAIN failed, status %lld\n", status);
> +}
> +
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	struct pci_dev *pdev;
> +	struct hv_input_attach_device_domain *input;
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +	int ret;
> +
> +	if (vdev->hv_domain =3D=3D hv_domain)
> +		return 0;
> +
> +	pdev =3D to_pci_dev(dev);
> +	dev_dbg(dev, "attaching to domain %d\n",
> +		hv_domain->device_domain.domain_id.id);
> +
> +	ret =3D hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefi=
x);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no IOMMU registration for vPCI bus\n");
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->device_id.as_uint64 =3D (u64)prefix | PCI_FUNC(pdev->devfn);
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_ATTACH_DEVICE_DOMAIN failed, status %lld\n", status);
> +	else
> +		vdev->hv_domain =3D hv_domain;
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> +					struct device *dev,
> +					struct iommu_domain *old)
> +{
> +	int ret =3D hv_iommu_attach_dev(domain, dev, old);
> +
> +	/*
> +	 * Attaching to the blocking domain only asks the hypervisor to
> +	 * disable translation and IOPF for the device, so it cannot fail
> +	 * unless there is a driver or hypervisor bug. Return the hypercall
> +	 * status rather than 0 so that a failure on the DMA ownership claim
> +	 * path (VFIO/iommufd) fails the claim instead of leaving the device
> +	 * unblocked. WARN since such a failure indicates a bug.
> +	 */
> +	WARN_ON(ret);
> +	return ret;
> +}
> +
> +static int hv_iommu_get_logical_device_property(struct device *dev,
> +					u32 code,
> +					struct hv_output_get_logical_device_property *property)
> +{
> +	u64 status;
> +	u32 prefix;
> +	unsigned long flags;
> +	int ret;
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct hv_input_get_logical_device_property *input;
> +	struct hv_output_get_logical_device_property *output;
> +
> +	ret =3D hv_iommu_lookup_logical_dev_id(pci_domain_nr(pdev->bus), &prefi=
x);
> +	if (ret)
> +		return ret;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_output_get_logical_device_property *)(input + 1);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->logical_device_id =3D (u64)prefix | PCI_FUNC(pdev->devfn);
> +	input->code =3D code;
> +	status =3D hv_do_hypercall(HVCALL_GET_LOGICAL_DEVICE_PROPERTY, input, o=
utput);
> +	*property =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_LOGICAL_DEVICE_PROPERTY failed, status %lld\n", sta=
tus);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property =3D =
{0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev =3D kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev =3D dev;
> +	vdev->hv_iommu =3D hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));
> +
> +	return &vdev->hv_iommu->iommu;
> +}
> +
> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev =3D dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);
> +
> +	kfree(vdev);
> +}
> +
> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	WARN_ON_ONCE(1);
> +	return generic_device_group(dev);
> +}
> +
> +static int hv_configure_device_domain(struct hv_iommu_domain *hv_domain,=
 u32 domain_type)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct pt_iommu_x86_64_hw_info pt_info;
> +	struct hv_input_configure_device_domain *input;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->device_domain =3D hv_domain->device_domain;
> +	input->settings.flags.blocked =3D (domain_type =3D=3D IOMMU_DOMAIN_BLOC=
KED);
> +	/*
> +	 * Clearing translation_enabled bypasses translation (DMA uses the GPA
> +	 * directly), which only suits identity. The hypervisor requires paging
> +	 * and blocked domains to keep it set.
> +	 */
> +	input->settings.flags.translation_enabled =3D (domain_type !=3D IOMMU_D=
OMAIN_IDENTITY);
> +
> +	if (domain_type & __IOMMU_DOMAIN_PAGING) {
> +		pt_iommu_x86_64_hw_info(&hv_domain->pt_iommu_x86_64, &pt_info);
> +		input->settings.page_table_root =3D pt_info.gcr3_pt;
> +		input->settings.flags.first_stage_paging_mode =3D
> +			pt_info.levels =3D=3D 5;
> +	}
> +	status =3D hv_do_hypercall(HVCALL_CONFIGURE_DEVICE_DOMAIN, input, NULL)=
;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_CONFIGURE_DEVICE_DOMAIN failed, status %lld\n", status)=
;
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain =3D &hv_identity_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	/* Default stage-1 blocked domain */
> +	hv_domain =3D &hv_blocking_domain;
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto delete_identity_domain;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_BLOCKED);
> +	if (ret)
> +		goto delete_blocked_domain;
> +
> +	return 0;
> +
> +delete_blocked_domain:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +delete_identity_domain:
> +	hv_delete_device_domain(&hv_identity_domain);
> +	return ret;
> +}
> +
> +/* x86 architectural MSI address range */
> +#define INTERRUPT_RANGE_START	(0xfee00000)
> +#define INTERRUPT_RANGE_END	(0xfeefffff)

These same constants are also defined in the Intel and AMD
IOMMU drivers. Bonus points for creating a common definition
in a .h file that can be shared by all the drivers. :-)
=20
> +static void hv_iommu_get_resv_regions(struct device *dev,
> +		struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region =3D iommu_alloc_resv_region(INTERRUPT_RANGE_START,
> +				      INTERRUPT_RANGE_END - INTERRUPT_RANGE_START + 1,
> +				      0, IOMMU_RESV_MSI, GFP_KERNEL);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +}
> +
> +static void hv_iommu_iotlb_sync(struct iommu_domain *domain,
> +				struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	hv_flush_device_domain(to_hv_iommu_domain(domain));
> +
> +	iommu_put_pages_list(&iotlb_gather->freelist);
> +}
> +
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);
> +
> +	kfree(hv_domain);
> +}
> +
> +static const struct iommu_domain_ops hv_iommu_identity_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_blocking_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_blocking_attach_dev,
> +};
> +
> +static const struct iommu_domain_ops hv_iommu_paging_domain_ops =3D {
> +	.attach_dev	=3D hv_iommu_attach_dev,
> +	IOMMU_PT_DOMAIN_OPS(x86_64),
> +	.flush_iotlb_all =3D hv_iommu_flush_iotlb_all,
> +	.iotlb_sync =3D hv_iommu_iotlb_sync,
> +	.free =3D hv_iommu_paging_domain_free,
> +};
> +
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +	struct pt_iommu_x86_64_cfg cfg =3D {};
> +
> +	hv_domain =3D kzalloc_obj(*hv_domain, GFP_KERNEL);
> +	if (!hv_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		goto err_free;
> +
> +	hv_domain->pt_iommu.nid =3D dev_to_node(dev);
> +
> +	cfg.common.hw_max_vasz_lg2 =3D hv_iommu_device->max_iova_width;
> +	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
> +
> +	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KER=
NEL);
> +	if (ret)
> +		goto err_delete_domain;
> +
> +	/* Constrain to page sizes the hypervisor supports */
> +	hv_domain->domain.pgsize_bitmap &=3D hv_iommu_device->pgsize_bitmap;
> +
> +	hv_domain->domain.ops =3D &hv_iommu_paging_domain_ops;
> +
> +	ret =3D hv_configure_device_domain(hv_domain, __IOMMU_DOMAIN_PAGING);
> +	if (ret)
> +		goto err_pt_deinit;
> +
> +	return &hv_domain->domain;
> +
> +err_pt_deinit:
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +err_delete_domain:
> +	hv_delete_device_domain(hv_domain);
> +err_free:
> +	kfree(hv_domain);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct iommu_ops hv_iommu_ops =3D {
> +	.capable		  =3D hv_iommu_capable,
> +	.domain_alloc_paging	  =3D hv_iommu_domain_alloc_paging,
> +	.probe_device		  =3D hv_iommu_probe_device,
> +	.release_device		  =3D hv_iommu_release_device,
> +	.device_group		  =3D hv_iommu_device_group,
> +	.get_resv_regions	  =3D hv_iommu_get_resv_regions,
> +	.owner			  =3D THIS_MODULE,
> +	.identity_domain	  =3D &hv_identity_domain.domain,
> +	.blocked_domain		  =3D &hv_blocking_domain.domain,
> +	.release_domain		  =3D &hv_blocking_domain.domain,
> +};
> +
> +static int hv_iommu_detect(struct hv_output_get_iommu_capabilities *hv_i=
ommu_cap)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D (struct hv_output_get_iommu_capabilities *)(input + 1);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output=
);
> +	*hv_iommu_cap =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed, status %lld\n", status);
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap =3D hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width =3D hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width =3D 48;
> +	}
> +
> +	hv_iommu->geometry =3D (struct iommu_domain_geometry) {
> +		.aperture_start =3D 0,
> +		.aperture_end =3D (((u64)1) << hv_iommu->max_iova_width) - 1,
> +		.force_aperture =3D true,
> +	};
> +
> +	hv_iommu->first_domain =3D HV_DEVICE_DOMAIN_ID_DEFAULT + 1;
> +	hv_iommu->last_domain =3D HV_DEVICE_DOMAIN_ID_NULL - 1;
> +	hv_iommu->pgsize_bitmap =3D hv_iommu_cap->pgsize_bitmap;
> +	hv_iommu_device =3D hv_iommu;
> +}
> +
> +int __init hv_iommu_init(void)
> +{
> +	int ret =3D 0;
> +	struct hv_iommu_dev *hv_iommu =3D NULL;
> +	struct hv_output_get_iommu_capabilities hv_iommu_cap =3D {0};
> +
> +	if (no_iommu || iommu_detected)
> +		return -ENODEV;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	ret =3D hv_iommu_detect(&hv_iommu_cap);
> +	if (ret) {
> +		pr_err("HVCALL_GET_IOMMU_CAPABILITIES failed: %d\n", ret);

hv_iommu_detect() already outputs an error message in the failure case.

> +		return -ENODEV;
> +	}
> +
> +	if (!hv_iommu_present(hv_iommu_cap.iommu_cap) ||
> +	    !hv_iommu_s1_domain_supported(hv_iommu_cap.iommu_cap)) {
> +		pr_err("IOMMU capabilities not sufficient: cap=3D0x%llx\n",
> +		       hv_iommu_cap.iommu_cap);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> +	 * hypervisor to advertise a non-empty subset of exactly those.
> +	 */
> +	if (!hv_iommu_cap.pgsize_bitmap ||
> +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> +		pr_err("unsupported page sizes: pgsize_bitmap=3D0x%llx\n",
> +		       hv_iommu_cap.pgsize_bitmap);
> +		return -ENODEV;
> +	}
> +
> +	iommu_detected =3D 1;
> +	pci_request_acs();
> +
> +	hv_iommu =3D kzalloc_obj(*hv_iommu, GFP_KERNEL);
> +	if (!hv_iommu)
> +		return -ENOMEM;
> +
> +	hv_init_iommu_device(hv_iommu, &hv_iommu_cap);
> +
> +	ret =3D hv_initialize_static_domains();
> +	if (ret) {
> +		pr_err("static domains init failed: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	ret =3D iommu_device_sysfs_add(&hv_iommu->iommu, NULL, NULL, "%s", "hv-=
iommu");
> +	if (ret) {
> +		pr_err("iommu_device_sysfs_add failed: %d\n", ret);
> +		goto err_delete_static_domains;
> +	}
> +
> +	ret =3D iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");
> +	return 0;
> +
> +err_sysfs_remove:
> +	iommu_device_sysfs_remove(&hv_iommu->iommu);
> +err_delete_static_domains:
> +	hv_delete_device_domain(&hv_blocking_domain);
> +	hv_delete_device_domain(&hv_identity_domain);
> +err_free:
> +	kfree(hv_iommu);
> +	return ret;
> +}
> diff --git a/drivers/iommu/hyperv/iommu.h b/drivers/iommu/hyperv/iommu.h
> new file mode 100644
> index 000000000000..3a9f40fa2403
> --- /dev/null
> +++ b/drivers/iommu/hyperv/iommu.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Hyper-V IOMMU driver.
> + *
> + * Copyright (C) 2024-2025, Microsoft, Inc.
> + *
> + */
> +
> +#ifndef _HYPERV_IOMMU_H
> +#define _HYPERV_IOMMU_H
> +
> +struct hv_iommu_dev {
> +	struct iommu_device iommu;
> +	struct ida domain_ids;
> +
> +	/* Device configuration */
> +	u8  max_iova_width;
> +	u8  max_pasid_width;
> +	u64 cap;
> +	u64 pgsize_bitmap;
> +
> +	struct iommu_domain_geometry geometry;
> +	u64 first_domain;
> +	u64 last_domain;
> +};
> +
> +struct hv_iommu_domain {
> +	union {
> +		struct iommu_domain    domain;
> +		struct pt_iommu        pt_iommu;
> +		struct pt_iommu_x86_64 pt_iommu_x86_64;
> +	};
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_input_device_domain device_domain;
> +	u64		pgsize_bitmap;
> +};
> +
> +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu, domain);
> +PT_IOMMU_CHECK_DOMAIN(struct hv_iommu_domain, pt_iommu_x86_64.iommu, dom=
ain);
> +
> +struct hv_iommu_endpoint {
> +	struct device *dev;
> +	struct hv_iommu_dev *hv_iommu;
> +	struct hv_iommu_domain *hv_domain;
> +};
> +
> +#define to_hv_iommu_domain(d) \
> +	container_of(d, struct hv_iommu_domain, domain)
> +
> +#endif /* _HYPERV_IOMMU_H */
> --
> 2.52.0
>=20


