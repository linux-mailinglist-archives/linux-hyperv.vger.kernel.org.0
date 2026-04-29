Return-Path: <linux-hyperv+bounces-10478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKOdDmhI8mm1pQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10478-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:05:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20C4988E6
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 184D43031371
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3A3C3C06;
	Wed, 29 Apr 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mxtj2rrL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012067.outbound.protection.outlook.com [52.103.14.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28C931F990;
	Wed, 29 Apr 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485666; cv=fail; b=b+E+7wPk6Fk8dx2SHOsdzbUhfmOCNzy+C2vYIpD9GefPYU7OX+atxvlWbIz+WEd3NQNqI6ov064RBaXwbUmtQmadDk7Zb1H1CyjFsckWo73DKo1Z6WYWRC/p0lcKO3vhDgbTOEeKpWdSnGupnLTSP1Sf1W8VCug3wAKf863kEy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485666; c=relaxed/simple;
	bh=qNtCQNxuqmSvRloiLcelST1t67hLHZ4qJ5evgpB9w2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hj4MatL8w8D8NUWkXGNb55KB7wUSXtper8RdfQ/wyIlgrdnX2+NTqgyAWQ8vOw6gg50GxkC9/TzABjKxlRLqe3LSb4ndx+9LUnqX5EIzBHih/+JfWaRXhbFr0S8WWGFwv9wI3g/qwrlOg710kNJ2xOgh7fo38DOHhW4YRoqoV7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mxtj2rrL; arc=fail smtp.client-ip=52.103.14.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkLn5tRivBsKtL8MDtL5hxFa8wMdrg5rDcQNute1uCAEY7IbrFZ9AxMLvoXnNm8CwUje6qD95vq2aL3Lp5B+OI5b6BIJoC1csl5dxfzUNj6ras4veG2Sj06lM6UjmfP7On59LF5M4f+I2b38W3juGcbdtCxTM/Yg4/eJzFi2rL3AwBr+JKTr9LbpfS1MCkk1JpC6I5Guro9xcMPFkFpSABNAwMuC9PYY4LtKTrC8ryDMPVCpu6l9b/SC2rgE22rFhK+YvR29EbDUjS+s0DMOplo0/IkBXQZjTJNiCzMVqGCqXL7Ai+17Tij8Ou7aTu+UvgGhZlExVNK7oa2fbJNFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YYA/J3vsuEzG3QbOyWrv1h0Ct394fGH/fo3JjqpAks=;
 b=D8bzvtXi2fzSFukc3hRh8esZVuDQhzFu/LkdBYLeNj2IdTheLbPLQAnbp7isZOS1BxM8ZqKtpd3yF2F7sBRC2/6wZXFFfy6dVAwPDHxV/wIi73jMWcAAwMiHd54Dvfw61ryDksUsv/YOId/3AJxRhAflh1hS/z8yqyYBHS7we8K44oIJf97KgDgBtkGwotOe9eZl1tI1rTzeS3vmC0BmwSqx3EsJVpu79u9AxtxFNxXRmyiOlBUNSpn9vjN/sE5IvS9j/kMoj7BFV8eEkmRtJS4qvmML03zvWDnlA9vcGMr8N1jrYFDlcDPz7HaxieK2rcUkc1phhEoRpkghBc4gZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YYA/J3vsuEzG3QbOyWrv1h0Ct394fGH/fo3JjqpAks=;
 b=mxtj2rrLymqLv/xqqaOcq4NOxKEvtF4Syl8VrYJMXaD6UjCH17nYHH1OsjaidghSmLeHaEszB/WeBPOMpTF040QbpGwnhxL3ivUaBuWGJamJcJXvLPit+7DntG3aFp324pmrKYefNYthMhNLkZAFYot1wNtczy4KEuT1thJ0nhRzgmm5s1uwG2FR8yRBS5ksyBnrUAHicBTDBDodPZjY2F3KeuXmfHDhKSO2r/kTarq2qJ8uMzZBpnrJUVYpKbLW+avFg3fvGW/SXqYEnGkQbrERyCQP6CPX3LMoS4EyBj9jx8LBHn0oKoHFb2d1U5Ui/UoSqGFS16PkafZrPxlZ3A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9008.namprd02.prod.outlook.com (2603:10b6:8:b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.28; Wed, 29 Apr
 2026 18:01:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 18:01:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
Thread-Topic: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHczc/fn1PdG2gkFEeUWQdp0QjV5bXs9OVggAhpmHCAAQocQA==
Date: Wed, 29 Apr 2026 18:01:00 +0000
Message-ID:
 <SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
 <SN6PR02MB41576A849B6C4967622B4BA8D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69214DC322549834104D26E0BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB69214DC322549834104D26E0BF342@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9008:EE_
x-ms-office365-filtering-correlation-id: 14f4adca-6c80-4ee9-c6de-08dea619460a
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|41001999006|12121999013|8062599012|15080799012|19110799012|8060799015|37011999003|19101099003|31061999003|51005399006|55001999006|13091999003|440099028|3412199025|12091999003|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OCNaqXmgmLQynanrMyaG4lYvRwiLydRWiess4r0Dy0TZ/vrImKeAIN8jnQ8T?=
 =?us-ascii?Q?aOYplmbZe3jc4QJwWyhn5A9sdUGWspjhdLN0gBz34JDKYuMSE3uDz3Luxywf?=
 =?us-ascii?Q?XfSvBrd8BADvzKB9G5PrzRyddL76xCSvObeUBLD3lgz/ipDQWWcZDBHXuGLN?=
 =?us-ascii?Q?T4SUSZ0hv7VkJgErGa60TAlaXL/+ZI/3H3Z4NIk0yYqiCgghlr2ZzLKHN5hf?=
 =?us-ascii?Q?tuHxqHYtZ+lwN1HCPrMXmpYcAM1Yez4VFNbSF5P4e9yCAVdL07+h/uBWSL3u?=
 =?us-ascii?Q?2UlBl85RuRV16hcYP9/GVik6et9vc9yM6dHWCpi9pTYMT5MbHYVyEIO7phfl?=
 =?us-ascii?Q?wJNgtpf4O3RbOo97GXJPNNIO7rE43rBxDvy8nrdwoJxnieOIXxpQgZWVUrmc?=
 =?us-ascii?Q?xG/Q6hu9v/Q2fW1j2vLPBKRXOEs/NN5vvL7oyEKtHVaUXyrSsoLBATFiPli+?=
 =?us-ascii?Q?WBkYFp9017tRxy+xxED72/ZCpxBx7VNBkLzYjlG7V3dHZQq1yT9jMEdOkXuR?=
 =?us-ascii?Q?5E9CjRBF1xjAjOgyplhXvbu3/zOUGqBBfUOhLtGh6DCOustlg7eTUenl+vhx?=
 =?us-ascii?Q?hBkfGg9cYGnvxTxiCuYyECpB5Q1ub5rl3/Kmzpd/HDK7wgvExCnbgYt79gq+?=
 =?us-ascii?Q?zCuft2rb3nVVL4EBBBSqbofWKvuShydTHaDxzrCmxan75c2Dcyw/ooNMC0hv?=
 =?us-ascii?Q?Vsy21VSVtKWGEoGRJc3uRZV8CiKyoL4D9XcH+YxD2o4AUqMirgtE6bnCFi19?=
 =?us-ascii?Q?nPFSNIFx49gI6UVITtl6eBLAAlMp0C+n4umb3Ghf7+F2jRRWAWc23ACmk/Yp?=
 =?us-ascii?Q?6e8Jv4PnramgJi9XDI/AgSEu/B2XHUZb5gMRX00ttDp9jljtv3mdngVR9mZV?=
 =?us-ascii?Q?e/ZbVVKZSIC1DIxZ5EpVeIAtHh7aMi8rGBwTG+AxYD4YpnJHWJvvcZFgDit/?=
 =?us-ascii?Q?iPbrhZ/4n2bkoi6VFwt7EtbbKO/ww9pqzIIfmKAbbmrUnEpsPJBy+DpaCQCR?=
 =?us-ascii?Q?0BfqrPXirLucWoHbn5PMmxLn+BMCVOkL+kZiCqb7LGSLeI/pTpaIuag0BwgX?=
 =?us-ascii?Q?5aSSWQKkbbOHKtP1qKMvlH+ce2PLt0fPlPgdYpssIrN9wEphY4axhFs97Cj9?=
 =?us-ascii?Q?DxMttlTO5CUvCGVhMRtihdbnDBV/2lWJN8jvo+5De51PDDQL5qFqlkE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L5kF+yQTK0PM/gsdSDVcTieat6nJvLhcTjkyVFh44m7jpeDF8pSRCGxK1FZg?=
 =?us-ascii?Q?thOohL6Gfl2dlaprTwtXlz4wvv0j6sz7ViAEw3NPNI9daOeXoHiOzxlaMAAC?=
 =?us-ascii?Q?+/+LPzPsFyLgHJZfWO3wVsK3BTmUChG4MB+Q/QZfLuXz1pkHiBQP4SnC5ly5?=
 =?us-ascii?Q?4q/i7sJ1QoBkJ/P3Y2M1eSGRnpCGHJwBEYpuQDDgZZOLYNa59qHNRIQMC/SK?=
 =?us-ascii?Q?mBGgsl9TM3z5NJksVfUyIRK8XW+H/Vhf1XRd0cjh0a6a4zsg3iA3M1jQo2mL?=
 =?us-ascii?Q?2IXyxzNCGrr6y9Eqi+svMMvgGK9MtbuMwT65NGjmeFfo+adkJf8f6AiuoZ6u?=
 =?us-ascii?Q?o/IQ2LucmJkPtT4gje2TMf31qBhkqHesnNuG13JeRIMWoSxYUVItxCcmt0kC?=
 =?us-ascii?Q?yuVIreeVu13Nt2bAmbw/GA0ncAOTmf9leCmdF7MFVat1FgOGnUILyttCIzPD?=
 =?us-ascii?Q?Dm6SJYxJZQYy8FTspHV1oDGTD2fEJuKSJcAsS434cCqIsr6ELvuTV7sgCUQw?=
 =?us-ascii?Q?f0+Q+htvBDap0u2iabTgEAlD4BE7sOqbKeccse6aF7z2R5KkxgZJFjhMZ7Pm?=
 =?us-ascii?Q?lKFpY/MAesDsIVqcESsMKD4xNq/JvtilpYXKeVKsbdJAVDdQrAcwGnF1Srio?=
 =?us-ascii?Q?cSPSeYpONBFQT8Wg8MplpBT5MNIxIcUJC7cIXtrR3z28L3ykIxZAlafcVfcN?=
 =?us-ascii?Q?bWjOGLvnXj4sqUgSM+i7MsI/gcR8Ip5efKX1Ru9nCjmWJHoz2gBOFqwXafno?=
 =?us-ascii?Q?XThXWi2xAnY2eOx05l0yFMavkg5E0T+5pi7NeTT45iE2ocWmDMklkKUat49I?=
 =?us-ascii?Q?AyUdfeJPtMEiSFggFNudbBU7UZ37ky90De5fvJlzJLWtlr8DWaoLuPu2Qq/I?=
 =?us-ascii?Q?8hVWK1WPlv59BoF3GLtOh+ErcNnFhz8RE6bYZjp6+XMwRBQIXXOaGHgNddPe?=
 =?us-ascii?Q?3raQoqR0cXAo627Q/QnOKwVcBfPCBMDT/IqYTiPREdecxvTt5IBx1Noyyxtf?=
 =?us-ascii?Q?64YQRs3UvgjgRsQTAq+TDjRamcdCVGgdMqX1wRQ8O+ZMLNOZXPC9EsxF8Uva?=
 =?us-ascii?Q?QoY5vVpLZKXd/w8GOq9zQe2nyZB2qIlPOVEAsXhdFRynpHbbCMWk4wKF5SAm?=
 =?us-ascii?Q?A0UlkfZaNq2U1Bb7sq0rv25v+f//B3SjXFgbbYZpevf/B6GFyu76pKaPQVH3?=
 =?us-ascii?Q?fjz5+RoRRWvzSnN0RRzrBKeqsDSqHeKa3P9JkJIb3eUfswHgV6omf6ezKLvq?=
 =?us-ascii?Q?28cSOGk362f3e6WWzc9jhMMnO1syE2QKeJEbLWXnEVyTJR7gY1Dx4/rpoftN?=
 =?us-ascii?Q?iXliBpTKeAWAnpoBJXZn+GhF1Ug52YJurd7/j6+zIYdXd5WdTojb0dNNG/x/?=
 =?us-ascii?Q?EsHBKqg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f4adca-6c80-4ee9-c6de-08dea619460a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 18:01:01.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9008
X-Rspamd-Queue-Id: 3D20C4988E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10478-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,vger.kernel.org,canonical.com,templeofstupid.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Dexuan Cui <DECUI@microsoft.com> Sent: Tuesday, April 28, 2026 8:13 P=
M
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, April 23, 2=
026 10:40 AM

[snip]

> > > +	/* Hyper-V CoCo guests do not have a framebuffer device. */
> > > +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > > +		return;
> >
> > This test is testing feature "A" (mem encryption) in order to determine
> > the presence of feature "B" (no framebuffer), because current
> > configurations happen to always have "A" and "B" at the same time. But
> > the linkage between the features is tenuous, and if configurations shou=
ld
> > change in the future, testing this way could be bogus. It works now, bu=
t I'm
> > leery of depending on the linkage between "A" and "B".
> >
> > You could set up a "can_have_framebuffer" flag in ms_hyperv_init_platfo=
rm()
> > if running in a CVM, and test that flag here. But I'd suggest just drop=
ping
> > this optimization. CVMs are always Gen2 (and that's not going to change=
),
> > so they have plenty of low mmio space.
>=20
> This is not true on a lab host, e.g. I have a TDX VM on a lab host create=
d
> by these 2 commands (without the 2nd command, Hyper-V won't allow
> the TDX VM to start):
>=20
>     New-VM -Generation 2 -GuestStateIsolationType Tdx -Name $vmName
>     Disable-VMConsoleSupport -VMName $vmName
>=20
> The low_mmio_base is still 4GB-128MB. In this case, it's not a good idea
> to try to reserve the 128MB:
>=20
> 1) the available low MMIO size is smaller than 128MB due to the vTPM
> MMIO range.
>=20
> 2) even if we can reserve the 109.25 low mmio range
> [0xf8000000-0xfed3ffff], we may not want to do that, just in case
> some assigned PCI device has 32-bit BARs.
>=20
> So, IMO we need to keep the check:
>  +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  +		return;
>=20
> BTW, I think this may be a slightly better check here:
> +        if (hv_is_isolation_supported())
> +                return;

Agreed. Using hv_is_isolation_supported() seems better than
cc_platform_has() for this purpose.

>=20
> A CVM on Hyper-V won't start without the command line
>     Disable-VMConsoleSupport -VMName $vmName

Unfortunately, on my laptop Hyper-V, a VM with VBS Isolation appears
to *not* require Disable-VMConsoleSupport. I can start the VM, and the
VM is offered the VMBus synthvid, mouse, and keyboard devices.

But what's weird in this case is that vmbus_reserved_fb() sees lfb_base
and lfb_start as 0. Furthermore, as a test, I changed the "allowed_in_isola=
ted"
flag to true for the synthvid device, and the Hyper-V DRM driver loads and
initializes. In doing so, the vmconnect.exe window is resized larger, as is
done in a normal VM. /proc/iomem shows that the DRM driver claimed
the expected MMIO range at the start of low MMIO space. I can run a user
space program that mmaps /dev/fb0 and writes pixels to the mmap'ed
memory, and that succeeds as it would in a normal VM, but the
vmconnect.exe window doesn't show anything. It appears that the Hyper-V
host has allocated memory for the frame buffer, but is ignoring anything
that is written to it.

Running Disable-VMConsoleSupport works as expected -- the synthvid,
mouse, and keyboard devices are no longer offered to the VM.

>=20
> IMO this is very unlikely to change in the future, because the Hyper-V
> synthetic framebuffer VMBus device is not a trusted device for a CVM,
> so there is no reason for Hyper-V to offer such a device to CVMs; even
> if the host offers it, currently the guest hv_vmbus driver ignores it.
>=20

In the case of VBS Isolation, if such a VM also had a PCI pass-thru device,
the core problem could recur. I.e., not reserving space for the framebuffer
could allow the PCI device to try to use MMIO space that Hyper-V has
set up for the frame buffer, causing the PCI device to fail. And that's a
worse problem than just having the graphics console not function. I
can't actually try the failure case because I don't have an assignable PCI
device on my laptop, but it seems likely based on the evidence that
Hyper-V is setting up a framebuffer device.

So instead of not reserving any MMIO space for the framebuffer on
CVMs, the code you already have limits the reservation to half of the
MMIO space below 4 GB. Won't that work to avoid exhausting the low
MMIO space in a CVM that's running on a local Hyper-V with only 128
MiB of low MMIO space?

> When we assign a physical PCI GPU device to a CVM, I'm not sure if there
> is any framebuffer from the GPU or not. Even if there is, that's a comple=
tely
> different scenario and not reserving some low MMIO for "framebuffer"
> is unrelated: I think hyperv_drm (or the deprecated hyperv_fb) is the onl=
y
> driver that sets the fb_overlap_ok parameter of vmbus_allocate_mmio().
>=20
> > And at the moment, CVMs don't
> > support PCI devices,
>=20
> This is not true: recently I created a "Standard DC16eds v6" TDX CVM
> on Azure, and I did see two NVMe local temporary disks in "nvme list"
>  (here TDISP is not used). In 2023, we added the commit
> 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs"=
)
> and I believe some users are running CVMs with GPUs.

Interesting! I worked on commit 2c6ba4216844, but had not noticed
that Azure now has offerings that makes use of it. I'll take a look at
that TDX VM size.

Thanks,

Michael

