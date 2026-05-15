Return-Path: <linux-hyperv+bounces-10920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAzZFYhaB2orzwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10920-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:40:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2437555668
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F56B3004930
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 17:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DF403123;
	Fri, 15 May 2026 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QAT7LA/a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012016.outbound.protection.outlook.com [52.103.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662D403148;
	Fri, 15 May 2026 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866604; cv=fail; b=e0/M1ZegA2oMUKiB+3ruCaKwQbjyCctQNnq03wyGx5d0FuCOH4waE4jd3U0lQPTPPWM2AEwuONFdMfILomNlhv5bIMcNdatZszOf0i0sJCZ+gc0Khfp2QhdmOC4PdFE6tRCvQpr3u2Jz7m2fn2bYMR9oqMlovVEHu3MwxsAskNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866604; c=relaxed/simple;
	bh=8xw5j1nGnSYBspV+cl23k0UF/5P2KfErWWAn8gY6Sj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQJZ/ZPH6COEyNwqoNGjtAwsqJOcvJ+2lm8vGGWUh94RA6s/tSTuH3cqjeS/WVZTrJfzLLfXi8Q6FMvNdYbSekVhdxsUY/KZ3jv15SLJ/TWWGUfRhbiQccQOkBx8f9nnaYFf+HhO8vrHx+ecdQ8Um+mzEelVvhoAkKRA5ul1Ii4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QAT7LA/a; arc=fail smtp.client-ip=52.103.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyjzmWNubit/iwfwD/IQPc2DYy/Pa+MVJRWvcTgzau5C3yyVgLipvG3t5sHjeDKIFjYwDCl9KGC17lbVRaJ7Udp7NJEr5wYmaLbEVNYaaBzbcxQGfaSlmfU2UXBi67uO6Mr02L2jmaCZZqJaekVcG22k5ks1GthsE6hx0HATPeEVbFuD9F8YUr24LhgX8TuMQwy88BeVRRWAeVK6zojP6VVb7H8W5WIzE6YmrO5YiJWTbtQl++d73337gf9T7TiMWP3/8jlyCpBE/QYFDMcm/AMqWF2aldUxuPXJNGph3bdcM1xaemGoE/TGYsIMG4i41A7ZHbOJD7D26HJdNss4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xw5j1nGnSYBspV+cl23k0UF/5P2KfErWWAn8gY6Sj4=;
 b=y8VjOS1JtolN8jlGz0stoLN9/czDi9jAoper2q5+FceQaU2hm7c2lsDURYcgE3GquY6czT+6sMlN7dURX4P7BkFjUwU96jkmArkzNmpR6mNEpZhzLXm9x4LkgGp6ib2D1+iMQUIZUHDo/SG7z9sflhGwsUMdmlG5wnNG5QDQWCHS3paaeqQ+mxhRvKya/BOdoWAuJnAeojIk29QgOg/X/bykC1ab1IgKDTaN1A8grB2u/6IT7B1GywfQjJNo27LdQ7mCj+SJjI1Op8gApHy19ckDZdQo6PkoBUZ9qAnTGUQhwPa/TaMbT2d7uZfcPSs4/yFMPt+UJ5IzJ9STWQUkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xw5j1nGnSYBspV+cl23k0UF/5P2KfErWWAn8gY6Sj4=;
 b=QAT7LA/aZ5DpT011ha0GYN2RIitGMm9Qe9ODn/s1uzbAyxvjlf+IFqUWgYXGrwnMnidpVGeR5dhNwhMLEKuL3h0J1+m95zZVGeUpKb2ssFSWbEF4k+3Mtkqr7uKRQbbyuuah/IZQ9DZPyPWqfGfoOngYhad5+Fvi1mmzNd+axVe3KyFyxG8jy2vrY7L2QTxUysLBi50f7v88lHMfiHkkKnRC3PfV/5v0jfc+TpF1oz5iBJT6EvHnUy//jw7BceNyIcTK64u2pKwYxJKQLazQLl11ZJjPTUmkMvDhmDc3zCh+B7K+p1kQNkwkHWNmV1rz4vSxj0V4XXdSGRpXzJSJ1w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9258.namprd02.prod.outlook.com (2603:10b6:610:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:36:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 17:36:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, Mukesh R
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Topic: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Thread-Index: AQHc4WKng45scVRbCkamiCGsElTD+rYN1+PQgAFLfoCAAA56sIAAIiAAgAAL/qA=
Date: Fri, 15 May 2026 17:36:40 +0000
Message-ID:
 <SN6PR02MB4157A1B2D9B56062A0917BC5D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
 <SN6PR02MB415734108A86BDFB66AEE4CED4042@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
In-Reply-To: <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9258:EE_
x-ms-office365-filtering-correlation-id: 1cdf9592-3424-43fb-522a-08deb2a8860e
x-microsoft-antispam:
 BCL:0;ARA:14566002|2604032031799003|55001999006|19101099003|31061999003|37011999003|15080799012|13091999003|12121999013|19110799012|8062599012|8060799015|51005399006|40105399003|440099028|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5GINqMlloAypG1hMq0/DfqaR9D8uxajbsiFRvFk1ae7X7BdOYus09Qd1rJt4?=
 =?us-ascii?Q?uxMehTKUGSPRqXghZD3sow2jakaPYXdNpAza1qU8HuwXwlgW5krRGZSzJQqx?=
 =?us-ascii?Q?gccKgeZpsnOo4APae74gC43/eOMvYycAcjtYgQ2EJ6owONc130VtKU4uEm5E?=
 =?us-ascii?Q?SQHOgvpcQNwFswvGngSq6w248yS1SHNGuYcbxKFIOxyvEGpLwrZj1SUuZF3g?=
 =?us-ascii?Q?thsaveAYx9Tn8cVvXC4E/BQY3HDvkcOSN8IZoyhWbD0/+/dc70ErlXqIeCvz?=
 =?us-ascii?Q?dhi0xB4Jes3aXkINSNja6Srh3TPRYHl55Dl61UDuHHvV5Lr8smQL5wbRcuxh?=
 =?us-ascii?Q?Iq9ZTPh1XlRqVW/SeV8b3X+Zr0FB1fKcx9+6Vf9wWyVMDq6F53mjbVgng9lc?=
 =?us-ascii?Q?H6VGC+O55Ld9p+dE2VosCGwGzoL/p/NujeQJX8Fp6CBmRFxdTHEHBFVZHUxX?=
 =?us-ascii?Q?4vadmKYMNxriqWvGIR1xcBDsON+9qrqWO6I/7O5jpJ7t06DiA7FHB8MqRp5h?=
 =?us-ascii?Q?1PKHw1coitkvyE+xgT+OiWKaXPPt5CtR4NwtjalK8mteVGjhD4Tx896d/D/X?=
 =?us-ascii?Q?1He1p3rBFz4j/y5i1BEb669wRvNmDKSnZEbCaSycd7qaO2JYGSrd+FuIoWda?=
 =?us-ascii?Q?4AK1u7LQOIwBrTpeY5zZ7DYYBGZOcIdlSsham2hlyadIBZSbxQcPwVsacdto?=
 =?us-ascii?Q?h2jtwIAle4j6EEZLttzkfzvrA/pFDG7MiXMRzmeKrJ6KjnP8Qx0a15B44XdD?=
 =?us-ascii?Q?YeET2G8jRt8vs0xWgNAnV1k994pMvm4Qc5A0xtUkLHBl/EFxL3FtPtE1yosh?=
 =?us-ascii?Q?ijT4C6NsM9HOsP6NbPtPec4vL27Z3c3rXxpOX8XkAb1yBGFX8N6ZXW82ZCA1?=
 =?us-ascii?Q?aqIrFw/exLt3wfs7QBkWX9LudoDLKI+eco7i6ZQ6E+VYISxIFDC/5RMWwHmp?=
 =?us-ascii?Q?YDugGf5XZ9IWppKPq+O3+7uv+S/dYNv9NvEAG4CoJWX1pGKWUYGD22d0v3wo?=
 =?us-ascii?Q?goiMUTSFv1pFFqSAfMxkmKVAKedm+Im0QXkKe2jUwjPG+KSpVAga9yX7aExG?=
 =?us-ascii?Q?+9Ii09pqnXWfvj9xdZRqc8UUlcT5CuM8hAIrnDQJCnI6ZAP0i3oETS3GT13U?=
 =?us-ascii?Q?OmEuxu1Al2BHroVsIkdbthrDKK943CT8eg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5XQNeuAeeYV8z7cvby7246pF0yRnl5NiDbT5i1KwHo/F07fDy6IbSw8HGgK8?=
 =?us-ascii?Q?80esw2txT/Uk+vzH21OCJks5/X5WZ6VfSt+Vkei2FvF8NOjbW1FNJLFLvjgj?=
 =?us-ascii?Q?rz9MZ97g248YxyHF9TWhMZdvDV+UPOs9AKnQzfU3EPQe5Aa9EUEVwSvxvkUd?=
 =?us-ascii?Q?nypgOL3kGbDsVHDbM8rv2grOYhmAxmaUXQ/Z+kXKyP+TSS2NdouUa4VbxlUO?=
 =?us-ascii?Q?A+vso/aOKmbsNwi2RrDLe2RDkCxrM8s2H2VrTqwOHFBEt+MX8NY90YlsS1v9?=
 =?us-ascii?Q?eXaNYLeVz3XLFysqUoW5ZKTIMT9MgwnXA+FJP10xgK02ykAVCPZy/Ar/t/NH?=
 =?us-ascii?Q?UpPhfsqM8IyxwgM0t0Ifhs9qpn9Ef8vG9v3JRTLJzQbWM6NWVxg3Y9cLpxVa?=
 =?us-ascii?Q?ucFGtu+wj6k5vU1G18+GNwSn/0UuafGXzTX/CuoH8AFOsF1m31S0oBCnok1D?=
 =?us-ascii?Q?Ck8t3eX4OroBQw9HYNnbU6IfncwL2BvzhsXGrDm5++VOHtVmS8klIL0Odvp+?=
 =?us-ascii?Q?UOzv7fmaobdveVVh7upcnj/iiWdvj8WmQUbeqh3EbBnFk7J5jrLiMwEH6K4n?=
 =?us-ascii?Q?yhetuIYGY0MNCPuTHr58sdEmjigHCTBqT2sQF1AzUtjdlfc1PPi6yUwvrYob?=
 =?us-ascii?Q?3fNRFNDaverOXDo6Ui0wqD8B7PKfqE5/kAOj+EIancf0q7CpNYFAFMZ+qAzZ?=
 =?us-ascii?Q?egFznGPD5ffUeI7KZhTWV52EoesNVdejilrcn+Mb0HJWABxKaU/vxRXhj/Zd?=
 =?us-ascii?Q?dpb6AtVlBzoyA3Jf5wjQ0JGlBgE94z/6h/s8Bi7HZuRZk4Rbr9Cxk06amu8l?=
 =?us-ascii?Q?YndXBh2nMwlvj62rwOUz08e0+bpbbwJI7rpfPRAaVUSDXkB8IDA5PtEN1qdA?=
 =?us-ascii?Q?ZvT2ccxcZltuQTdpaCio1+jPsZA1b9MIARotiGv1RmMBdLkAKOC+lk622N69?=
 =?us-ascii?Q?/CN8Fy9dsRkz3fRbBNza1vMPp77LS8dTHG6OjKKaLfQzVSlzIzVOhLrVCjRn?=
 =?us-ascii?Q?uQjxO0f24WHTShRNGBGug3mfKo6B3MmzAbqzOnJBrV/Dh5Q9v5HNbdtb/JHD?=
 =?us-ascii?Q?8jxvquJMXHQ/xefnhuScwNequi+eyBhoeTOK5HI3Da4eFLtmDC1o457uWetS?=
 =?us-ascii?Q?jBKM0NgRV/J4Bkib0lfQQ9We3LVc33zUDzxGhcqq9RMCN2upv74S7aQpwYRa?=
 =?us-ascii?Q?izVuAFVvGrxU9WJGKQC4KGBkEl9BBKgAm2YpNx9HNvQSAZzUMkg/ZhZrKrPk?=
 =?us-ascii?Q?y8P1EPecnM0QvDF1ZT2JjaVkRRPrj+vI/NLEoBOYhaeBwXTsah/1qE226+My?=
 =?us-ascii?Q?snMjtsIs+QrqyuEXKfqOWBDBpLRd7JzXGMVZbsgwzZlXthojFsfPiveXO/hi?=
 =?us-ascii?Q?x1U8I2E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdf9592-3424-43fb-522a-08deb2a8860e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 17:36:40.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9258
X-Rspamd-Queue-Id: B2437555668
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10920-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[26];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Action: no action

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 9:=
54 AM
>=20
> On Fri, May 15, 2026 at 02:51:38PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 202=
6 7:00 AM
> > >
> > > On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
> > > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11,=
 2026 9:24 AM

[....]

> > > >
> > > > Previous versions of this function did hv_iommu_detach_dev(). With =
that call
> > > > removed from here, hv_iommu_detach_dev() is only called when attach=
ing a
> > > > domain to a device that already has a domain attached. Is it the ca=
se that
> > > > Hyper-V doesn't require the detach as a cleanup step?
> > > >
> > >
> > > The IOMMU core attaches the device to release_domain (our blocking do=
main)
> > > before calling release_device(), so I believe the explicit detach in =
the RFC
> > > was redundant. I simply didn't realize that at the time.
> > >
> >
> > Got it. But after the IOMMU core attaches the device to the blocking
> > domain, there's the possibility that the vPCI device is rescinded by
> > Hyper-V and it goes away entirely. Or the device might be subjected
> > to an "unbind/bind" cycle in Linux. Does the detach need to be done
> > on the blocking domain in such cases? In this version of the patches, t=
he
> > Hyper-V "attach" and "detach" hypercalls still end up unbalanced. That
> > seems a bit untidy at best, and I wonder if there are scenarios where
> > Hyper-V will complain about the lack of balance.
> >
>=20
> Thank you, Michael. May I ask what "the vPCI device is rescinded by
> Hyper-V and it goes away entirely" mean?
>=20

See the documentation at Documentation/virt/hyperv/vpci.rst in a
kernel source code tree, and particularly the section entitled "PCI Device
Removal". Such removals can and do happen in running Azure guest
VMs. Start with that info and then I'll do my best to answer follow-up
questions you may have.

The unbind/bind case is separate, but has some of the same effects in
that Linux should be removing all setup of the PCI device. There's actually
two unbind steps -- one to unbind the device-specific driver (e.g., the
Mellanox MLX5 driver or the NMVe driver) driver from the device, and
potentially a second to unbind the VMBus vPCI driver from the device.
These unbind/bind sequences can be done in the Linux guest without
the Hyper-V host rescinding the device.

Michael

