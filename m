Return-Path: <linux-hyperv+bounces-9881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J6KMHxQzWkWbwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9881-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4737E634
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Apr 2026 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 547703014C5A
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Apr 2026 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C747B42C;
	Wed,  1 Apr 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jSJu5zS3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012054.outbound.protection.outlook.com [52.103.10.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B637FF69;
	Wed,  1 Apr 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062745; cv=fail; b=Ew9wRxgO5L/KG0Q3qiHXT++qd6MxJxbTILH17q8Q3ggyQMOKRQxdo5W6x63LzxLKUH48PyLVMhmGv271Vd+B3KRC9W1L2uDHHGp34o6cGYXsVj0ze8/NIWsD39iXMlXTFyZnqiWOEbZp5LnB/pmyJYB8N7eU/lCWkre9mY0XpOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062745; c=relaxed/simple;
	bh=2YJHUzXXYLA8624OXYbWuVj1l3CmzE+GpDs7Adis7Bg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XMHmDnITZ2hWfmghjVu6XyuuIlO8pRiUA9q0T5E/uDUTJY69CnRuZF+Ut5+iwE+RJsCfmZaOcJRr8IaDOU2NVwHprwvLFij8wwbSs+TpToKe3eaqsgFVb39E0+toAeDsaMzmJlFy+gxrwE1NtmNGR4MNwvBqIkHANQmcem/jweY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jSJu5zS3; arc=fail smtp.client-ip=52.103.10.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrsDk9M4aVwSuokD84sBEWGlGpLHF0ZdIVu6qqtEf7zOvZhKuQpTR/2vKREnDUEcU8l9v6xOawtktQrOcNP3Q76vczV1jBgdiltapxyU6eiHeKV6997kwI/q967KoElp5Y2I+RuEagAHZc6bJmvSKWjeZjcqOiPpytVIX8w0fJkQkr0bzNwIt/JZ3XVxI3I/Q5g6x6vcZuKRlf+k8R9B3huoe5FsXGOnSx/zHGOsg4xvvLMokOgU6OOYzgKm4eQ12PMxecS5HyJhfQo7CCmXfIF7yN3RG9tZjUZLP4BEhF+v85eXgFF/ElzeXkyOVwHvoa8/nKith27tgFexMdZyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqDyf6/B+RNBVpwD5czl7YEh0k/l+hlaW9W8PTQ7L5I=;
 b=cStVEOguF0YW4ydjyc2WJFY6uO20/G1mPsXqopzfiv9Pbx7PynahHNSVr8XbECI3KitI7tQYTD7POHbtiYKv6xjIPQwqDqfU7k6O5fYFtPcGNcJNANDT7C3YLXK+xHJSfGJheBs8vQ2kM/sRh1OYWMSGZHbl9LN67mq1Bg/14Z9xcWduSNtsOQ2YjJIuM4sLUWR1ksUiF6KIBgfAf+s8K4BAHsRNziARrvHcAEI38/vlfBi2r5T8MP1/ns8Ddg+pp0Uo7XnRajezfBLYYSPD6Fol6Hc+Dc0Kk69w33XqnN43qD4bcd9NJztv8tNFTjo3E9b7yZ1gtER4A7nA7jszOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqDyf6/B+RNBVpwD5czl7YEh0k/l+hlaW9W8PTQ7L5I=;
 b=jSJu5zS3BwOlF6GGUjSHHKOp1pJ38bFv0UIOsSv6Vi9ocS+HEu0pTvCUS2tSJy6hW+P00rMpaN8/0OMMfa0N4D2I4oL/vXSxn6jZ4rPMwXuJapwiKWkWuq5L2nsudN3lT/59/bYgh/ZWNimEXQi5NKwLii+ET+Xxi2yne7e0TWbXE2Yujv5QNku7K3/UgNVhEM1J9xrcQ82agXme1jjlWivtu6MNic6tXdhoGZ2ioVNvuertAM5037dhaAbZyCXlfkloovsLmmVt7pveO2aBL0TP4sE/eiwyrEImUrecYGED+wBTwQoV7VG4/D8zbT8QUV8WDvn8XtQhHLuD+rJO1A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8808.namprd02.prod.outlook.com (2603:10b6:806:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 16:58:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 16:58:58 +0000
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
Subject: RE: [PATCH 11/11] Drivers: hv: Kconfig: Add ARM64 support for
 MSHV_VTL
Thread-Topic: [PATCH 11/11] Drivers: hv: Kconfig: Add ARM64 support for
 MSHV_VTL
Thread-Index: AQHctT5rpEx13RIuik6uv1M9Du7GkLXKhytQ
Date: Wed, 1 Apr 2026 16:58:58 +0000
Message-ID:
 <SN6PR02MB4157FEE5578344625418BFDBD450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <20260316121241.910764-12-namjain@linux.microsoft.com>
In-Reply-To: <20260316121241.910764-12-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8808:EE_
x-ms-office365-filtering-correlation-id: ee9e615e-6478-4614-4aff-08de900ff747
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6SxtkYQ7MCYTjarDLPeMcafFltdza+eHt1c863bjUH+2rfj4XooWLKhUUM+U4pFoDbDpXx2jOkqYA58tm04xIt7J867XDO2ukvi/+DixLXvm7CGx7O+oEqJVU8KH61HCPkKU7N/Hnl0HvvNT3edUrpyRorNWja4/k5Nr1m7jnXO9Egnf37LkBGEqRyyaRAiimHgTNZMLKZgQpmmnkkM3NhBYuuhVwoBye3LDgepWARSmv77Bfw/ZpFwQde8vW1ZWFu5dMLGkbm1U0r4zwzhNgculUXeEMKe8yf8ixm7vVpgJLSLljihJnHiBizOvNKnNO5TGOGnaeLGoo7z1MrKwMgwkb9kJC2HJ19ik2hA/nt4/oKY6myo4/hNp44oLWJRui4PsT9SYODx9JQmHLk91P0X4OX/TsdIHoyUTZlklITNkeBNI28iOAekKIEVgABafdruB4m2WDbESBvpdmBwebZipGgwj0nFmb2f1WP57QZU8zg6m+WMgsTpfST1XayWWbyDhAVD1CotGhiZrG/mHJ3nEWwo0K+OJk7DF9JX0C1O3wDLWncHSXHQG8KB9c6VgxIbKlu30voPYIiLVFMYHaueBAFfvX7sp2mzJpX0aBpseHDYbVvbHAf8JidxY/+x3qgfor4icbNs6TKi7flKayVev2dxSaKUy6ldxqUn61qfiBPIkjUgmDegogd2C9e4NRm51IFWXInwWwKVQj6bhBQSFxD8VNrNq7JFuxNSDqhdNM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|31061999003|37011999003|19110799012|8062599012|8060799015|15080799012|461199028|51005399006|40105399003|102099032|440099028|3412199025|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kIrwIvA7Fmkk7k4xGHjDIg9I6BGNeRQtLRqPaHa/LV2eL2WP/BMhNtQr0sL5?=
 =?us-ascii?Q?vb6Sj2KsIdTSR3BMF+3lIogq7eumIeuuv7h5A7id15NELpSxpDoUmAlr04EX?=
 =?us-ascii?Q?c8u0XAyv1ufc6FbP2AuNfLxzAYubap+7EPEWP3oO8wdGmCTWdbanvx913XCR?=
 =?us-ascii?Q?WZPgkuRdVWlZfYHC51IinVZnM2u5mptAyMDRC/JxKSnt3T9+IYFkzI5v7e5H?=
 =?us-ascii?Q?Xa6LQhxSGUMX9OSlWt0RUGB7ZpyJ3xjw/8QV4y1MJ/7iOtU++5tS3r2J3+Vs?=
 =?us-ascii?Q?Cbndx+VD80lL4/drb5a1Ri5MdxtvYfTjo9dQ+pb1vlc9MgbSrSwQuhswLmEr?=
 =?us-ascii?Q?JoP++2fvgPuUGHKUn3l994vTHO+vFfBAWRNMGNVwUbZMbGXHe0vqi+dKqsjd?=
 =?us-ascii?Q?PCa2IHYEyJLK8B5tTXTMxrpUA5P8sIxcDwQf9+xr3pPdF2Pv5jXVkmwj3wtW?=
 =?us-ascii?Q?5eQ8Cu/oWqeabrpX2xdG33oQAHvipes6tlV+FqiqLpJb7i/5PIWEPj8tZi7j?=
 =?us-ascii?Q?NBFJzwB165rzBRKcta8qL7Sq+BKPzMf2zVl2hrvF99rjQ9BoKFYgk5jnS7Gm?=
 =?us-ascii?Q?wLCZTGe8bd+ZyeHEw/5T0goqFcnQnmfshfJJvuOoPbJNbDS3i7sCK6C3C0o0?=
 =?us-ascii?Q?37nk7HWIQ9OtNSHaaVgvinSWgUyUHqJgrLiG1BUcrOdn5+YSdwWZhC27xwOR?=
 =?us-ascii?Q?a+hptGWkZ+VTfjoEEnDuTnlzV9I2ubvF6r07llsybha5ywqEB8EpWQcrD0J2?=
 =?us-ascii?Q?ZY3NxEfiaty94efTXzVuTdFEZXMB8bqUANTX39eo65k8KOEPRzKCdtFX92YQ?=
 =?us-ascii?Q?j7GR4CLj0fzeEPm3t81SDl/DfvWpAKFFvwYb60KlKIHMq1m2BXelYe6SWU+c?=
 =?us-ascii?Q?7RbRRPWyFY+CBp/2gOb/OHnQsIFjA0o4+SuHb4jQfpc2YY5AFZa8FF7MPzzt?=
 =?us-ascii?Q?NEFGu4jZwej5jWtSLm/q3vuY4SMffj+EQCKvHAOtXNquBFa+qJqm3AyV9jxZ?=
 =?us-ascii?Q?vj0Q/8PRuYqJSpVDxC9xpNO5kUEiu1whSOcojyBPyLcttGE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xI2v7ALM+pikRTo2DYx5wsCbmtRtOoJohcCbYGaNDgYqSdhe4p4wgR2JlKsX?=
 =?us-ascii?Q?hCFV7jN/NGzwGlo7j6dT/XNsKIe2NfEuBAwpA4ayp1bJ/d1OuEzO24aghpn/?=
 =?us-ascii?Q?PGIZmenjRXMUaF7RCPscKjq21N8yBhaQT2p/vMJWNeGSgWdcFG+tQ9nXqvBV?=
 =?us-ascii?Q?KyToul6A1JzI3bUuqp3q5eYslfK0TL+JKnZxIftGlkHGF6g7X3JERFm+ygQN?=
 =?us-ascii?Q?pJxx8lq2Bpr3pup+qggraytBbn0rv7wzTG2+EKHJyhMPurCACOvvrWDRbB7w?=
 =?us-ascii?Q?SO7I35a0vIItyK83HUaxyBzHeMb9qb7JQ0mSq7aA5owmKMDUZbfxX5ldOfZm?=
 =?us-ascii?Q?yi/OR5uqEw6gX2HfNLUhoaSkYRWLNRKC7GOHB184B8Wc4HB9TfKICbGrtk3q?=
 =?us-ascii?Q?KXTC3+17IyFDIWQ+zgjDHsLq81PiKbuAqyLd66RE0PcxYWsmOK2sx1+ooGov?=
 =?us-ascii?Q?l3z+NSv6VGkzkDs+T1kxFO/sTfbhk7vZHohzW7lJlAEJfoY+II5GoE5FXQ2x?=
 =?us-ascii?Q?LeBnBk7UGAXO9M/afUajQmDUfIJ/kQlGesXOC1kU4hgha6gpzlrqDd6+XGyi?=
 =?us-ascii?Q?r5UjcC11n1pFqZj87VsY8amjuc1tqM04CE+mrYppEaMbMbmi/tAqn+nKiEcJ?=
 =?us-ascii?Q?m0f3bf6QW81EAiUVQwHrpLQQQpqHEf/ANWIbkeP1mT8GoHCdpL+/h1+6PtYu?=
 =?us-ascii?Q?tzOkLyuG55VhTXF+XQsBBNnlQ0kOx7zW+8jY3w1ubzheXkzpG5t1b9qpVxMN?=
 =?us-ascii?Q?Am5wZ7QBeq8+36YMLvG6NyJgwGEbKJcmHB1SWBSACJEh79U6CwhqXf7TQ+5P?=
 =?us-ascii?Q?L6IzRs4foTfPGI3Dyxg7gFfh79ykhJZ2dKYtHj8IUKFzzol5irzVfS2/WHqW?=
 =?us-ascii?Q?M19Cn1hqAgdCyAh3w+n2ycUBj1pmLTKzL70RgomODnlxsu5tqzlkcPMcCJh4?=
 =?us-ascii?Q?RKOyxIeJElilfitFc4zMomUW0lA7swBQHDQaw8oRScS2rHXTq9oc9mGDtDmz?=
 =?us-ascii?Q?g3VuU1VGCaf814SyFIo/pzGIkE+0YKGh9GSf5S75nKAsNSaK1RG9MiWkFryt?=
 =?us-ascii?Q?9SpTVH7BdoxWQkwr3KXAfzx0dGCXI3LVFexlrqYn44haSGPvf/B2xpaD2izC?=
 =?us-ascii?Q?S8xcUTd+AVznL5o8zginKikZqLDyt8RLBSg/RDdoDwFEf7V5FjIxESn85WjW?=
 =?us-ascii?Q?NDXzb7xh5FYhBw9VigTmGfLo2tEFUVdLEvPKigYe6ONMlaLiHLkni6Ts53ZF?=
 =?us-ascii?Q?ScT8YoZkC0/C8R/bUZY5fn8RsPhwYIum8bnaJO54f7DKz1LJ+Aht2IQ2O5AM?=
 =?us-ascii?Q?i+UhSuNs8zXq82KTIpc0jyNrJjubPl/+45psvSwzjzqthPYACH/qfB/s7cRR?=
 =?us-ascii?Q?cjES4CA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9e615e-6478-4614-4aff-08de900ff747
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 16:58:58.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8808
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9881-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FE4737E634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026=
 5:13 AM
>=20

Nit: In keeping with past practice, the "Subject" prefix for this patch cou=
ld
just be "Drivers: hv:"

> Enable ARM64 support in MSHV_VTL Kconfig now that all the necessary
> support is present.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..393cef272590 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -87,7 +87,7 @@ config MSHV_ROOT
>=20
>  config MSHV_VTL
>  	tristate "Microsoft Hyper-V VTL driver"
> -	depends on X86_64 && HYPERV_VTL_MODE
> +	depends on (X86_64 || ARM64) && HYPERV_VTL_MODE
>  	depends on HYPERV_VMBUS
>  	# Mapping VTL0 memory to a userspace process in VTL2 is supported in Op=
enHCL.
>  	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VM=
s,
> --
> 2.43.0
>=20

The nit notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

