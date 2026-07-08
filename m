Return-Path: <linux-hyperv+bounces-11859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TzkTFoS7TWpX9gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11859-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 04:52:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD472140A
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 04:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=Dp3nS1Z3;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11859-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11859-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94D30300E2A9
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F623B6377;
	Wed,  8 Jul 2026 02:52:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012046.outbound.protection.outlook.com [52.103.23.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDA2E3FE;
	Wed,  8 Jul 2026 02:52:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479168; cv=fail; b=sH8nscXRdxiOc+ROrmN4Sk53zs7tOgb9NZ+rT+UMz2ChA3i8KPT6QjOlJObQdrh/TcXjl4Fr5EqQ7jjOqMPg2H3CWQkbnVxWlyrDheMVI7Vb1DY0UZHhFuMh4AUxmg92nGB7YayjuQnUl3ULzeAHMLcG+D2HFS8NdxWEDSRCeis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479168; c=relaxed/simple;
	bh=M9Ias/ZrwgRrqkzPIbFhNSReyX4JhFrrSl4OeZFxDG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gq9u0eQ/ptYteMr3c+ZYEAfw/YyAjxtf0QVFHTYZujCYJBs0a1V5N3YRXelmYomI12RwDjU5dUOw4Jq4fpFWdSm54jex/l4vBPq5w2thkZtjABrFWKAn6+vQOImEcGYwcNrbcmtj1dFeDs8iS60CMeHyzOt3DQdHx7FcGOnNYRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dp3nS1Z3; arc=fail smtp.client-ip=52.103.23.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrgSjeFZKDChCO5YgtPNTMD/3cWbvz1knUhNbi1QKHxjYso1v6/QVAO6IEGjuCihd1GPKAhXYn29MlGOsMw6ZT8rhdia3xLoeVckAON+IaqMzAoRKs7W4vt/9QBF+PtffwjS0E0HQH6iSIRO+kP3m1PI71UADAr/aXaYBjdt1jgCUzqLcjo7HtLPOA4z8eUqayw7dxmq9a1BsCTd2VzzTzhdfMddfkVkfqLenLh9qh+gUmwf/mmfFSgip/BOs4fUOuEE1UbgyHDAC8IEvjWe67mqnKJN1vBmWHMQp4SYVSODPj2rT02hXac4mCL0aQxRDg4nAbOLnZ3FVYMyW95bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/PsNTXO+6QvcB+an6JCZt0PsnyY0OmBMrjRHEKntOo=;
 b=GtdlFbLOLR+qLt4zNbWm6TD42/7gH6GDsf4uLzReXvLvIIt7Sl+T9d8Z077dUTPF+kS9t5a0tWetS+o63e7w15oEbhyR7sxCIYoC4mP19N6Z8TfxNv/D8nTEVsvAVJrNNadPoKB1/a24Kzh5PV0rvtYyfLUl0UPmEDif4uitnConRexyaay4MnneREOs3e0nL8OjfeJ3XT+O+lqztVD/drSwI6K61ShOx0akcZHzYQe36YEId+jbOnskjwkPSSy1nH9IUYPwvjzwJafinhpYuw/HCMbzUKYI5MnSEZvHhb4Z65Zy7THcf9x2jvMrG0srH2ozws29TWJsKkDnkDJdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/PsNTXO+6QvcB+an6JCZt0PsnyY0OmBMrjRHEKntOo=;
 b=Dp3nS1Z38aXDDGyHw59kPFICFs5dbx6+ZgiLUVcAMYitOJZznKodsYZD9b4bV+RJ8Ira9gugN/hD2YAb2L0JhE/i/HCyW50A+WaRl03ZsRn9mA33+UP2R0W1fBsF4eLAJIm/zwjQ3FhnDl1cd39TYuotHz09lha52hpJdZq0HvXAIE4ajlCOWt+f9RnVy8xJvaqsN8kP0yHbPZADKkFrujxwMRydcXBa6oce52vCyI485cai3XrAP8CN3AJcW/YM9c9GgZVN5M24xS9mWn7PPFQ7gCptIyjhe8VUDUzpZdYG9jkyw0zPJTpX+/RMivN+6wFUGmi3bBcqBoUSblintg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10154.namprd02.prod.outlook.com (2603:10b6:610:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 02:52:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 02:52:43 +0000
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
Subject: RE: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Topic: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Index: AQHdCjyhy62fRqTOH0yC7zsP+xZ0eLZi9TRg
Date: Wed, 8 Jul 2026 02:52:43 +0000
Message-ID:
 <SN6PR02MB415798534DFCC14E5202D021D4FF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
In-Reply-To: <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10154:EE_
x-ms-office365-filtering-correlation-id: 940dd482-4910-49eb-6573-08dedc9bfba8
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|19101099003|41001999006|31061999003|51005399006|8062599012|8060799015|15080799012|25010399006|37011999003|40105399003|56899033|12091999003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q/LyB9FjV/9mKc4QNtPJae9OkvRZazONhvtRXO/yz9y2pD+5iY0/5A1MmfyG?=
 =?us-ascii?Q?lSRST5lDfF6xaxbqRkiQzVV2phqg1S7YIyNBAp1sbqPJJZWWxSbQfZxgyjek?=
 =?us-ascii?Q?yXPr+bJBwsPI2z7U4BjI9zSLtzXkfZQtDRD/MdsOgOIlD74luI8DfEovzji/?=
 =?us-ascii?Q?YoVQ8WTj9MkPKXX5Mk7ePjUDUO4T13h5scIkcFyl9X+XlHVaeZnXr5IzY3lz?=
 =?us-ascii?Q?s8rGn2z4yVAjAkG9HSgxsCjLmiVn4KjtCd5eK9k58X6AOZG65tKrKdQ7C3+Y?=
 =?us-ascii?Q?wpxAj+nFmGG6eq1KYX0WO9/suORhjj6iJnkRonfPTARRRDBteFDaHNlBvIRB?=
 =?us-ascii?Q?gkPJckdwllYXUnhqRfnbloZCSnjNGTwQFUek4XMP2yTY0a9JFgU1t03cJE7m?=
 =?us-ascii?Q?LBAt6DBaLutC262n5icqf6wKe8Q7P0++k0GDkXHMgOd2A4uc8L4ninwflpDp?=
 =?us-ascii?Q?l4646hoA+K8S67ztr5odHIP39shkWLFKQ7+EmPbm6XnfsavvEPYQXkYATFgS?=
 =?us-ascii?Q?sZC59Ryqv8aCjlJ469PUx7zGOsaJaVtr8f+h4xJ9suznSSp44XKCHYJvOz9X?=
 =?us-ascii?Q?gNcCdOGQnla/0EJ9iNe2eQ0v2d2eksgQm+pemhiKTZTVaIW1V3LrzZ1PkDsO?=
 =?us-ascii?Q?yC8hJQE0U4E3tMg+wqM0L+c3pvwf7/8ZKm2DI4P52ba1Fewd78t9wPLUX3+t?=
 =?us-ascii?Q?JN1OhEaEXjPP3O0LGjVrWk5zgZqw61sqALToV+ev5YGg6D6yarjqI658n8Tz?=
 =?us-ascii?Q?sMikFD+mwh7xJ/0luQNRFBlpVISgwsA40WLq1rZFej71HhzPniQn57tOUsko?=
 =?us-ascii?Q?1OxpPM35IpRoX+97Y4q3aFhyIAzGbKGPwNdAAl/vuhTduM+mfnKSe9cSiRdS?=
 =?us-ascii?Q?2rhBtRosKETGU+aY8olJSiEy4gyciMbXUhAjmeNAzQtZqm3JoeBi0LBYzdDs?=
 =?us-ascii?Q?sGAGO2SYil4l5vr5wU89+J+Tv2INGLKtrlf7v6DVAM2HOri/PsV1+69LX/0B?=
 =?us-ascii?Q?/2Zgs67FwTF36K7346dDkOiEs96SvGLpZxL10vyrqzQsvzFjQaga7bCHYTGn?=
 =?us-ascii?Q?77/v/p0GLvE68w96J0qjsXIir3tCk47/Oi/t8Uqfvla3VvQRcDQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2K3FMb6+9qaYcdqdbh9KZQ7qhOcG/FYOLzLLZKP18xIkQLyIMiSMpHU2vYcq?=
 =?us-ascii?Q?YpImfqkB3U9XLggeVZQRTQILBCmWBw83bp3rjNqMJS4w5ZUXOrSWjQ4msU9p?=
 =?us-ascii?Q?on0n6CEVkeSY2gCnhu6D52wcskWDsuE2JF58zFQ3U0DL7TIgG0wj+B+4QaOw?=
 =?us-ascii?Q?DJRAfIdkbY+QElxZYD+zx/PEnUnyPVo449OZVTyM+CaCEnb3EUfd+WObuc9t?=
 =?us-ascii?Q?LOpsnKlz4HJEckjE/XXdhBoabzDinndGgWGp9KOxPVaI5DRcDTAZkhtyFbMW?=
 =?us-ascii?Q?hD6pwbCGOjoSqW3h9CBR8fj60BlH1Hr45rNjdtJFLJmXUi/0K/ou0jYERnN1?=
 =?us-ascii?Q?u5SEaP4hpsGO7r6ursvkFJ5wdm54zg4PxpcKsO1q/6/DIbkgWq+7g3mpHGZV?=
 =?us-ascii?Q?PCrlrd0aymUwC34ut+Ca+7nYD0Sq1EVkXRka26m2hkuCv4YF5ckDQt8TRTnj?=
 =?us-ascii?Q?LXoXW+NI9LNT9i5LAGHNLc5aKc+vWzW2C4bhqP3jbSyiAlKNrAmsU/i7+t2n?=
 =?us-ascii?Q?Fi1/V9juTwRXbvS4ladyC/1uBQ8vasb43ltFm4xppZSom8TJK3kOs0wLEs70?=
 =?us-ascii?Q?ARDPKa3xV7JwPX+2SiUXR+ea3z9ge6prA8c5Cg6e6QX/Zwc42Nv6YontuvS6?=
 =?us-ascii?Q?LBu4ZZpn1I8KHOrgj67DhB9YNI4mWToc+O8FPozDQRq0jjTyOq+K5S6DTRnk?=
 =?us-ascii?Q?QkRUcCrKi9D6ZWtnxPJGU3laAxUdRRcmIVZ7mx1LeOWlhlP9HEN75lMAxFts?=
 =?us-ascii?Q?rkzoCJeGgKO3EPKLjNBLmHYR0wb1zNoQDereceJVCQ1Ht2VTptpJ7SA4AVUT?=
 =?us-ascii?Q?eMjo3Yzh2/19EDvsaWPggVBkLmODydup7oWp9XVw6POjsv0i9/OzDzAfgkNv?=
 =?us-ascii?Q?ZwyVPdkhNuWIL/jjjvBBa4Ezvs6zUPTeWz0czzIXpwfj+CVRFwNV0TMNjssv?=
 =?us-ascii?Q?WQEjGpcvO2r8B/x4pRpRlxJ39khQLFuApwcZw5mPVt6Ycq6FMvF4OSoWfKxp?=
 =?us-ascii?Q?E2HoWTKqzFSR/uQNJbAX9iKBsIDBwOfWY5N90J4ZQv42ABpbHDMnZnRsfWwP?=
 =?us-ascii?Q?Mif31w8HgEUq5OFW9+N8JxQ6EgARc6UHfn5RYWIqxkKGa5ATHLLuDTfi9eCz?=
 =?us-ascii?Q?LeJytlfE/nbDIQz4WmaqmiqlacXq+1el3wxx+pZDKfKjiiWTHz4iZa+Mc7In?=
 =?us-ascii?Q?PPXGYhNFOs6Th8oClviicqUi2PM+BI5BahyeJdrBzbh8aeuhYBC+S0o8qy6E?=
 =?us-ascii?Q?0BokG1a5Z2Iqbx0DEcPooTMBLtQyaYld3WxYRMyGn2uVIaMd97lDfZinLROX?=
 =?us-ascii?Q?eLrrBHvQH2LxiSWf8e5CQZkMn3OcDGaBTqONwDJfcuPp6bj6uuEb4ZGkwYBy?=
 =?us-ascii?Q?I91ama8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 940dd482-4910-49eb-6573-08dedc9bfba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 02:52:43.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10154
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11859-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:from_mime,outlook.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23CD472140A

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 =
9:05 AM
>=20
> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID in
> its hypercall interface. This ID consists of a per-bus prefix, derived
> from the VMBus device instance GUID, combined with the PCI function
> number of the endpoint device.
>=20
> Add a small registry in hv_common.c that maps a PCI domain number to its
> logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> prefix when a bus is probed and unregisters it when the bus is removed.
> Consumers such as the para-virtualized IOMMU driver look up the prefix
> by PCI domain number and combine it with the function number to form the
> complete logical device ID for hypercalls.
>=20
> The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> that pci-hyperv's interrupt retargeting path and the registry use exactly
> the same byte layout. It is derived on demand from the constant hv_device
> instance GUID rather than cached in struct hv_pcibus_device, which is
> private to the pci-hyperv module; this keeps the interface narrow and
> avoids depending on pci-hyperv internals.
>=20
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c              | 95 +++++++++++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c | 21 +++++--
>  include/asm-generic/mshyperv.h      | 13 ++++
>  include/linux/hyperv.h              |  8 +++
>  4 files changed, 132 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac616789..53493f8d14dc 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -26,6 +26,8 @@
>  #include <linux/kmsg_dump.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
>  #include <hyperv/hvhdk.h>
> @@ -863,3 +865,96 @@ const char *hv_result_to_string(u64 status)
>  	return "Unknown";
>  }
>  EXPORT_SYMBOL_GPL(hv_result_to_string);
> +
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +/*
> + * Logical device ID registry shared between the vPCI bus driver
> + * (pci-hyperv) and the para-virtualized IOMMU driver. The vPCI driver
> + * registers the per-bus logical device ID prefix at bus probe time, and
> + * the pvIOMMU driver looks it up to build the full logical device ID us=
ed
> + * in IOMMU hypercalls.
> + */
> +struct hv_pci_busdata {
> +	int		 pci_domain_nr;
> +	u32		 logical_dev_id_prefix;
> +	struct list_head list;
> +};
> +
> +static LIST_HEAD(hv_pci_bus_list);
> +static DEFINE_SPINLOCK(hv_pci_bus_lock);
> +
> +int hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pref=
ix)
> +{
> +	struct hv_pci_busdata *bus, *new;
> +	int ret =3D 0;
> +
> +	new =3D kzalloc_obj(*new, GFP_KERNEL);
> +	if (!new)
> +		return -ENOMEM;
> +
> +	spin_lock(&hv_pci_bus_lock);
> +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> +		if (bus->pci_domain_nr !=3D pci_domain_nr)
> +			continue;
> +
> +		if (bus->logical_dev_id_prefix !=3D logical_dev_id_prefix) {
> +			pr_err("stale registration for PCI domain %d (old prefix 0x%08x, new =
0x%08x)\n",
> +			       pci_domain_nr, bus->logical_dev_id_prefix,
> +			       logical_dev_id_prefix);
> +			ret =3D -EEXIST;
> +		}
> +
> +		goto out_free;
> +	}
> +
> +	new->pci_domain_nr =3D pci_domain_nr;
> +	new->logical_dev_id_prefix =3D logical_dev_id_prefix;
> +	list_add(&new->list, &hv_pci_bus_list);
> +	spin_unlock(&hv_pci_bus_lock);
> +	return 0;
> +
> +out_free:
> +	spin_unlock(&hv_pci_bus_lock);
> +	kfree(new);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_register_pci_bus, "pci-hyperv");
> +
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr)
> +{
> +	struct hv_pci_busdata *bus, *tmp;
> +
> +	spin_lock(&hv_pci_bus_lock);
> +	list_for_each_entry_safe(bus, tmp, &hv_pci_bus_list, list) {
> +		if (bus->pci_domain_nr =3D=3D pci_domain_nr) {
> +			list_del(&bus->list);
> +			kfree(bus);
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_pci_bus_lock);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(hv_iommu_unregister_pci_bus, "pci-hyperv");
> +
> +/*
> + * Look up the logical device ID prefix registered for @pci_domain_nr.
> + * Returns 0 on success with *prefix filled in; -ENODEV if no entry is
> + * registered for that PCI domain.
> + */
> +int hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix)
> +{
> +	struct hv_pci_busdata *bus;
> +	int ret =3D -ENODEV;
> +
> +	spin_lock(&hv_pci_bus_lock);
> +	list_for_each_entry(bus, &hv_pci_bus_list, list) {
> +		if (bus->pci_domain_nr =3D=3D pci_domain_nr) {
> +			*prefix =3D bus->logical_dev_id_prefix;
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +	spin_unlock(&hv_pci_bus_lock);
> +	return ret;
> +}

I started thinking about the mechanism here because it's somewhat
annoying that it takes 77 lines of code (sans comments) to manage
this simple little mapping. I also started thinking about how many entries
are likely to be in the mapping. A guest VM probably has fewer than 10
entries unless it has multiple NICs and maybe some GPUs. But this code
is also intended to be used by the Linux-as-root code, and I'm thinking
that the number of PCI devices managed by the root could easily be a
hundred or more if the root is managing a couple dozen VMs on a large
physical server. Searching a linked list with 100 or more entries could be
a bit slow.

If only the guest scenario were needed, you could declare a static
array with 64 entries (64 is an arbitrary upper bound), and just search
through the array instead of having to allocate memory, deal with
allocation failures, and deal with linked lists. But a fixed size array
would need to be much bigger for the root scenario, and you would
still be doing a linear search.

A better alternative to consider is rhashtable, which is an existing
Linux kernel facility. Based on what an AI bot generated for me, the
code for setting up and using rhashtable is straightforward, and
would probably result in far fewer than 77 lines of code. Lookups
would also be faster than a linear search, at least for the root case
with more than just a few entries. I'd suggest looking at rhashtable
to see whether you like how the resulting code comes out for this
use case, and whether it really is simpler than a roll-your-own linked
list.

Michael

> +#endif /* CONFIG_HYPERV_PVIOMMU */
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad..58ca2c95bd10 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -641,10 +641,7 @@ static void hv_irq_retarget_interrupt(struct irq_dat=
a *data)
>  	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
>  	params->int_entry.msi_entry.address.as_uint32 =3D int_desc->address & 0=
xffffffff;
>  	params->int_entry.msi_entry.data.as_uint32 =3D int_desc->data;
> -	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> -			   (hbus->hdev->dev_instance.b[4] << 16) |
> -			   (hbus->hdev->dev_instance.b[7] << 8) |
> -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> +	params->device_id =3D hv_build_logical_dev_id_prefix(hbus->hdev) |
>  			   PCI_FUNC(pdev->devfn);
>  	params->int_target.vector =3D hv_msi_get_int_vector(data);
>=20
> @@ -3715,6 +3712,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	struct hv_pcibus_device *hbus;
>  	int ret, dom;
>  	u16 dom_req;
> +	u32 prefix;
>  	char *name;
>=20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
> @@ -3857,13 +3855,22 @@ static int hv_pci_probe(struct hv_device *hdev,
>=20
>  	hbus->state =3D hv_pcibus_probed;
>=20
> -	ret =3D create_root_hv_pci_bus(hbus);
> +	/* Notify pvIOMMU before any device on the bus is scanned. */
> +	prefix =3D hv_build_logical_dev_id_prefix(hdev);
> +
> +	ret =3D hv_iommu_register_pci_bus(dom, prefix);
>  	if (ret)
>  		goto free_windows;
>=20
> +	ret =3D create_root_hv_pci_bus(hbus);
> +	if (ret)
> +		goto unregister_pviommu;
> +
>  	mutex_unlock(&hbus->state_lock);
>  	return 0;
>=20
> +unregister_pviommu:
> +	hv_iommu_unregister_pci_bus(dom);
>  free_windows:
>  	hv_pci_free_bridge_windows(hbus);
>  exit_d0:
> @@ -3977,6 +3984,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>=20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		int dom =3D hbus->bridge->domain_nr;
> +
>  		tasklet_disable(&hdev->channel->callback_event);
>  		hbus->state =3D hv_pcibus_removing;
>  		tasklet_enable(&hdev->channel->callback_event);
> @@ -3994,6 +4003,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		hv_iommu_unregister_pci_bus(dom);
>  	}
>=20
>  	hv_pci_bus_exit(hdev, false);
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bf601d67cecb..f65344f2bb81 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -73,6 +73,19 @@ extern enum hv_partition_type hv_curr_partition_type;
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
> +#ifdef CONFIG_HYPERV_PVIOMMU
> +int  hv_iommu_register_pci_bus(int pci_domain_nr, u32 logical_dev_id_pre=
fix);
> +void hv_iommu_unregister_pci_bus(int pci_domain_nr);
> +int  hv_iommu_lookup_logical_dev_id(int pci_domain_nr, u32 *prefix);
> +#else
> +static inline int hv_iommu_register_pci_bus(int pci_domain_nr,
> +					    u32 logical_dev_id_prefix)
> +{
> +	return 0;
> +}
> +static inline void hv_iommu_unregister_pci_bus(int pci_domain_nr) { }
> +#endif
> +
>  u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9de2c8d6037a..10ee2c462d7c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1287,6 +1287,14 @@ struct hv_device {
>  #define device_to_hv_device(d)	container_of_const(d, struct hv_device, d=
evice)
>  #define drv_to_hv_drv(d)	container_of_const(d, struct hv_driver, driver)
>=20
> +static inline u32 hv_build_logical_dev_id_prefix(struct hv_device *hdev)
> +{
> +	return ((u32)hdev->dev_instance.b[5] << 24) |
> +	       ((u32)hdev->dev_instance.b[4] << 16) |
> +	       ((u32)hdev->dev_instance.b[7] << 8) |
> +	       (hdev->dev_instance.b[6] & 0xf8u);
> +}
> +
>  static inline void hv_set_drvdata(struct hv_device *dev, void *data)
>  {
>  	dev_set_drvdata(&dev->device, data);
> --
> 2.52.0
>=20


