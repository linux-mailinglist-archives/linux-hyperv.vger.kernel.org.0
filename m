Return-Path: <linux-hyperv+bounces-10144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L8MEEFd3WmadAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10144-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:16:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9013F379F
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 655563088E00
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093A38B7D9;
	Mon, 13 Apr 2026 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tr1ZNurc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010040.outbound.protection.outlook.com [52.103.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8B40DFA7;
	Mon, 13 Apr 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114552; cv=fail; b=vEOhUwT5SamHbgxbDq0NRVtIMvgLLnByJbkMO/oFx4+Ar26BF3q0lCkqjYaUKSdHucj2zbRZiT9TmX6tfdw4qmZBnqaa96Nse/MdiRSxoLh3LSrLOlivL4ZCB5Gh28Oo4xHXWrpkTndMBJ1L/DVV4ZQ9DYZzmoghtvPqu3DbnZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114552; c=relaxed/simple;
	bh=jNktC+sGAqmGcG0Nnb6/y5wG/aDV81H28/JB+XlsYI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxC70zYlJz0nh9e7WlGoDzlqkMoSc+EJYm6TU7kvGp4zq6KFLkxGlCwQiw7p5H5h//KPLUAhaBKCV60I2uGCCUXCWfQzMI8upGaWzoYRIZNzsF0O0nJJ6E4qc57N5wbJFOz5yVVEY7dPQvmyGQvdKnWEUv5pBX9LN7kUJlqvO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tr1ZNurc; arc=fail smtp.client-ip=52.103.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w16UFza73r7GFM4iq7H8XnjwmYVjYxI25+Gtj8wknbLHT20QWePYKX+3czq1L6AR1H9AtS5qyke1p56Hb6gynGjL+QdfvRlKdk+wXs/L76VknIVhWpQOEzDneldSrYHJ8ep+NxfD8yooU2FzjSpbLXuM/qatF1Yg6fS3w8edAl6oYtcvUeznHdD8gKE4GwDLAFrtFU7bD9K8BvwGAbDMeSZ7sBHAnEX6qoMaLHVcLZJwy2+5tuMpSHPJvXseu6ZlDPTmVJYiBY2Fh+zvDlmYPZYvGleqb4uIY+1fgvSBgIDuzDkRbRnzu3NkvuDh3HxOge17yJQriTbnNRVuW6utCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m4njBXDbibbS5FCxZRT+R14V13i+IxZq30Ey5PehhM=;
 b=xD7QTUVxNs3SOdls+lW2l/pVEtBx5BW2/UG+5r81fooINuFT7NR3GtRmb9yz0M64wSqF5x2DHTpjo0zcA85vDaDAXjShLLVH616utuvFJmNSNNHOKnWNVh+vu0k5HZcKzDzWc8hN8IAVlyxLy93YBgTiOatJncgiPnOowmdC5sE14x4yM2jAiC45heki3shwUu5mnqxJ7nWIGjlxnNNz8ToanWKvc82N4sY9SpnQO3TPlKz+Paa/TwIJxXMC0DsH++JwR9pezx+xYccLXbTLQSQBc9Crev4WsCELp97ENXMyHpjWO4n15fchqc9nq2i61RMhy8Fr1o2Xlcc1Fk0gvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m4njBXDbibbS5FCxZRT+R14V13i+IxZq30Ey5PehhM=;
 b=tr1ZNurchblhLMTP20fuc0cFS3lfGPlbyaCLYaY+rKbcOyVAk/XiWkhvdv6sJRrhOyx7d/Tx4G8iYzNuRBT/wKNCMb0BWc710SrzgrSdBqVkTjevXh/INWptPUbvVJazuCwrpxC0ZMzWh9NWEfRrBeM0WdDg1c/G6/K48/1wiunJpxh4Pj3sIQqey0PcDZ3lM5ZFxsetaqhBpkzYrSHsWum/Hq5y4hS0ujyybvdGzSDIv5epmMfNs/FNYj6BkXVbJai/ulpl2quBuYc+UbexshOev2i/KCuXgbXYsh5PGVG6I0feTJFUaQX3EzGN3UPIJCzjHmqv/2C0dFJLL6TeKw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8057.namprd02.prod.outlook.com (2603:10b6:610:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:09:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:09:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/7] mshv: Map populated pages on movable region creation
Thread-Topic: [PATCH 5/7] mshv: Map populated pages on movable region creation
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZAIKpaGttVztmrA=
Date: Mon, 13 Apr 2026 21:09:08 +0000
Message-ID:
 <SN6PR02MB415725768DFBF9502CE942DDD4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490108104.81669.2129535961068627665.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177490108104.81669.2129535961068627665.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8057:EE_
x-ms-office365-filtering-correlation-id: add63204-de07-498d-9da2-08de99a0e76d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|31061999003|8060799015|8062599012|15080799012|41001999006|51005399006|19110799012|37011999003|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iAxIGtGSYnUi36lquTTC3hxH5V+GuP8fE91YMrLQbJ8n4Ska5UHvvluP/6pq?=
 =?us-ascii?Q?wKULW3jNifmeKNEX2emcpgk/9Ys3/Ita3+Rebvzvj7+BAiuZVKafj/f3hgbk?=
 =?us-ascii?Q?e7bV1nbd2fkYWvzVNVY0bRGPDpdFn+BxkCkd5mFAeLRtk2ZWgCLDa+A3kO4J?=
 =?us-ascii?Q?DtBJp6DlLhgF33nXPQlxGJttyYNEibFUI1mzNFm5alJVRkBfgOI9+0s5Urh8?=
 =?us-ascii?Q?TA674gx6KEvc9dfblOEUMeka5UYUjxBBjD0hkCDZDRfs33AeCoQBLSH86dYE?=
 =?us-ascii?Q?D2V73yk6r7gFA7Y8QnXhLKQqsLkGyY5r6n91h3qauiJlx3mzQbzwvkJz/9KA?=
 =?us-ascii?Q?y/Ut/H8oeJWFyPaGQiRduS+xmrb8/5RCCp8ODmdGLE+nvFbMJOGqpiNCjMM3?=
 =?us-ascii?Q?SxKf8O1ZugxN5i/bwXlJEKJLoNDONtfVNG2dos5mv7wiHZp4Efqu53YZ9GlA?=
 =?us-ascii?Q?p3B4+OIIgeyzuA8cjRFaHzsuYiSRmpk25xEZLiIwIsRs7qJFFp+nFGZY5FjI?=
 =?us-ascii?Q?ObPc7sdv/qePEsQcIVR9FbIyU9xmABQ+gzIWSJMqix9CcbLK0V8Fj/2T+oqT?=
 =?us-ascii?Q?eqKn7KnwyrrXFoOz8qpzQ+6BRsjpvYSvkZ1HP2moZ3yMfR44jBe07HXKnenD?=
 =?us-ascii?Q?hGSYgPzIfXkO7KIBDxaFF7q5ii6xqbvNmVxM1UOZn3h8Ge6KxcUxNOBTi5TO?=
 =?us-ascii?Q?0qR9hvdGHnEu99q5nT9guJRqp1GHQbjrIZxPKOHLU6gznFVe05XY3EwWtH1m?=
 =?us-ascii?Q?V6c6xRvl9oq2roKYzNuXeVxn3KxntXvAYcMSuwuatdyTTYX+ouw/hgTNY4EK?=
 =?us-ascii?Q?GnzFDbaSozlszondn+X8+HMAeFH6Lv9tMsBZYc6yetsymISj3SFUOh4RFvJL?=
 =?us-ascii?Q?s085zZLa/FYzNKzbWTW94hANyyDAbGC0ZLIGnFweS7hs7dQ0Bmp/75mt+S6a?=
 =?us-ascii?Q?OPFfXey/gH8qmGkLCuB6Nb7Vo5nbdEWjJIBCHpkjAFyetPc2bw+VbHxPUmat?=
 =?us-ascii?Q?WST7pYPYd5c9IlfTjUp56eXCSnjeFIgYI/U66/aVCjpRO84=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IOL/6HNqaLqoUGB3MRJk7xMLF64lrYnXVox4k5fSdEfwCUFs+ofRsLgMnDLg?=
 =?us-ascii?Q?yS9Kw5asdtjfwavC18bx+fNJD+5I9I9iDSza1SLZ9SMkjVQ1z8EJVPkItDjz?=
 =?us-ascii?Q?YA3+RDPdwq6n8CkK8rOB6obm137CHUlJa3nogBNeASINY3yS6XSG+vnAuOAQ?=
 =?us-ascii?Q?lH28gWlNSb5UjgdgtmEoIjIBMntG/phleQ/M6liNmW3DCimB03r6EG5KAZ3Y?=
 =?us-ascii?Q?k7Tr7Aj3/q+ioFQlWaYIyDhENj4o/rr956nJAPiVpjILqU4Jzts/YH1TKqBl?=
 =?us-ascii?Q?3fkV323Z2+oapkET1AlK9rLSCUsozjEuwi7uSW8X8RKAtnpVLeR5bY6Vn3G6?=
 =?us-ascii?Q?uMo2lZHpH8da/hidi6q2JG3akJ9MPsD+f1IReh9bH2fd1/F+b0Q/x8eGfhgt?=
 =?us-ascii?Q?S7OuhMTl2gHwXgYu68fTNGSAeDeNDYl2Q4RhFPeHdKOg7AhXQIcqxEVh2OPZ?=
 =?us-ascii?Q?yCFWbHJsVj82SFrk7arFQsfiMYH51ReM4f12UIWtoxo9oNAU4RKD5DiUKgeH?=
 =?us-ascii?Q?LpjKxweoHRaFzjtY09FyAC/lY513kp/aUgTlof963HsjQH4N5FQnSHxbQ9Hq?=
 =?us-ascii?Q?/zQSbuXXooSxfbD/bD3ngdTrA9clbEbEjzIfSjZ/WdwzTXWXWnleBtoCcJ1e?=
 =?us-ascii?Q?qqIGR4HRcyA+BGBpL1Mn79Hl5HAeHlTpXScVPpzuLcCptbEjWcsqfkR1I82d?=
 =?us-ascii?Q?6wFRhhCJo6BnC5+Wi/WDxsGZnVJ8bNOMJNw3P5qjbz5njjQ1N5p+qX0ggDPY?=
 =?us-ascii?Q?GRPrFgLpjgDxY17LDO9L2HFtWqrs5u+HZTvnSUYZfqFgEayLNl3/3JzGD0dL?=
 =?us-ascii?Q?WqABiyLn+iY01gbLp0IWGDaMN7dln++QouVT3/ZXSVHwNRuhNyJp+hVvZx18?=
 =?us-ascii?Q?mpGIg6XzR3q4xJFQr76QzoXbnJo2yI0EbssA/ug573xFKZ3ij60b1jw6aYCf?=
 =?us-ascii?Q?WhyZKOQEmhy8IDLzcVWmy311Ujc6REM/CR38dHJpr9qfPkHZfUxDMqEuOWLG?=
 =?us-ascii?Q?a+ACfZhhlSatNY0/CUpg7s9u2bhq6ymM1DTkgI0cYBk0n1xDgmmVYYjtpM6q?=
 =?us-ascii?Q?BREKrJNQrmYPycHDnOcuucRcOW1mlk45jaubKONnGrWMiY3nN3L1ll9GFRYS?=
 =?us-ascii?Q?eif1F8s1JyPMzUhUS9jrb8nFXeSUcTIabGU/P+6uLeOWFnUxV+HA9JC0Qk5X?=
 =?us-ascii?Q?eXd8szedIgYR3bcvRgsC9EmTGPhmQ+ZjWxtHhTNke5HgOKupHYMZvom3Wzqs?=
 =?us-ascii?Q?iGfZ7r6e9+N5G5v8IUGTVbOxe87F2Ct03M7KSvG0XuxYieKHEadB4fmzTE+E?=
 =?us-ascii?Q?I92lHpPipHf+YMurV3ix+kpP7o4NafTNZ05qjwnzzYP3/wceCrFRSAdTy5tA?=
 =?us-ascii?Q?LNhIMTY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: add63204-de07-498d-9da2-08de99a0e76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 21:09:08.9273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8057
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10144-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 9B9013F379F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, March 30, 2026 1:05 PM
>=20
> Map any populated pages into the hypervisor upfront when creating a
> movable region, rather than waiting for faults. Previously, movable
> regions were created with all pages marked as HV_MAP_GPA_NO_ACCESS
> regardless of whether the userspace mapping contained populated pages.
>=20
> This guarantees that if the caller passes a populated mapping, those
> present pages will be mapped into the hypervisor immediately during
> region creation instead of being faulted in later.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c   |   65 ++++++++++++++++++++++++++++++++-----=
------
>  drivers/hv/mshv_root.h      |    1 +
>  drivers/hv/mshv_root_main.c |   10 +------
>  3 files changed, 50 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 133ec7771812..28d3f488d89f 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -519,7 +519,8 @@ int mshv_region_get(struct mshv_mem_region *region)
>  static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region=
,
>  					  unsigned long start,
>  					  unsigned long end,
> -					  unsigned long *pfns)
> +					  unsigned long *pfns,
> +					  bool do_fault)
>  {
>  	struct hmm_range range =3D {
>  		.notifier =3D &region->mreg_mni,
> @@ -540,9 +541,12 @@ static int mshv_region_hmm_fault_and_lock(struct msh=
v_mem_region *region,
>  		range.hmm_pfns =3D pfns;
>  		range.start =3D start;
>  		range.end =3D min(vma->vm_end, end);
> -		range.default_flags =3D HMM_PFN_REQ_FAULT;
> -		if (vma->vm_flags & VM_WRITE)
> -			range.default_flags |=3D HMM_PFN_REQ_WRITE;
> +		range.default_flags =3D 0;
> +		if (do_fault) {
> +			range.default_flags =3D HMM_PFN_REQ_FAULT;
> +			if (vma->vm_flags & VM_WRITE)
> +				range.default_flags |=3D HMM_PFN_REQ_WRITE;
> +		}
>=20
>  		ret =3D hmm_range_fault(&range);
>  		if (ret)
> @@ -567,26 +571,40 @@ static int mshv_region_hmm_fault_and_lock(struct ms=
hv_mem_region *region,
>  }
>=20
>  /**
> - * mshv_region_range_fault - Handle memory range faults for a given regi=
on.
> - * @region: Pointer to the memory region structure.
> - * @pfn_offset: Offset of the page within the region.
> - * @pfn_count: Number of pages to handle.
> + * mshv_region_collect_and_map - Collect PFNs for a user range and map t=
hem
> + * @region    : memory region being processed
> + * @pfn_offset: PFNs offset within the region
> + * @pfn_count : number of PFNs to process
> + * @do_fault  : if true, fault in missing pages;
> + *              if false, collect only present pages
>   *
> - * This function resolves memory faults for a specified range of pages
> - * within a memory region. It uses HMM (Heterogeneous Memory Management)
> - * to fault in the required pages and updates the region's page array.
> + * Collects PFNs for the specified portion of @region from the
> + * corresponding userspace VMA and maps them into the hypervisor. The

Actually, this should be "userspace VMAs" (i.e., plural)

> + * behavior depends on @do_fault:
>   *
> - * Return: 0 on success, negative error code on failure.
> + * - true: Fault in missing pages from userspace, ensuring all pages in =
the
> + *   range are present. Used for on-demand page population.
> + * - false: Collect PFNs only for pages already present in userspace,
> + *   leaving missing pages as invalid PFN markers.
> + *   Used for initial region setup.
> + *
> + * Collected PFNs are stored in region->mreg_pfns[] with HMM bookkeeping
> + * flags cleared, then the range is mapped into the hypervisor. Present
> + * PFNs get mapped with region access permissions; missing PFNs (zero
> + * entries) get mapped with no-access permissions.

Hmmm. The missing PFNs are just skipped and the mreg_pfns[] array
is not updated. Is the corresponding entry in mreg_pfns[] known to
already be set to MSHV_INVALID_PFN? When mapping a new movable
region, that appears to be so. I'm less sure about the=20
mshv_region_range_fault() case, though mshv_region_invalidate_pfns()
does such initialization of any entries that are invalidated. At that point
in the code, I'd add a comment about that assumption, as it took me a
bit to figure it out.

So does the comment about "zero entries" refer to what is returned
by hmm_range_fault() via mshv_region_hmm_fault_and_lock()?
The mention of "zero entries" here is a bit confusing.

> + *
> + * Return: 0 on success, negative errno on failure.
>   */
> -static int mshv_region_range_fault(struct mshv_mem_region *region,
> -				   u64 pfn_offset, u64 pfn_count)
> +static int mshv_region_collect_and_map(struct mshv_mem_region *region,
> +				       u64 pfn_offset, u64 pfn_count,
> +				       bool do_fault)
>  {
>  	unsigned long start, end;
>  	unsigned long *pfns;
>  	int ret;
>  	u64 i;
>=20
> -	pfns =3D kmalloc_array(pfn_count, sizeof(*pfns), GFP_KERNEL);
> +	pfns =3D vmalloc_array(pfn_count, sizeof(unsigned long));
>  	if (!pfns)
>  		return -ENOMEM;
>=20
> @@ -595,7 +613,7 @@ static int mshv_region_range_fault(struct mshv_mem_re=
gion *region,
>=20
>  	do {
>  		ret =3D mshv_region_hmm_fault_and_lock(region, start, end,
> -						     pfns);
> +						     pfns, do_fault);
>  	} while (ret =3D=3D -EBUSY);
>=20
>  	if (ret)
> @@ -613,10 +631,17 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>=20
>  	mutex_unlock(&region->mreg_mutex);
>  out:
> -	kfree(pfns);
> +	vfree(pfns);
>  	return ret;
>  }
>=20
> +static int mshv_region_range_fault(struct mshv_mem_region *region,
> +				   u64 pfn_offset, u64 pfn_count)
> +{
> +	return mshv_region_collect_and_map(region, pfn_offset, pfn_count,
> +					   true);
> +}
> +
>  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gf=
n)
>  {
>  	u64 pfn_offset, pfn_count;
> @@ -800,3 +825,9 @@ int mshv_map_pinned_region(struct mshv_mem_region
> *region)
>  err_out:
>  	return ret;
>  }
> +
> +int mshv_map_movable_region(struct mshv_mem_region *region)
> +{
> +	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
> +					   false);
> +}
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index d2e65a137bf4..02c1c11f701c 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -374,5 +374,6 @@ bool mshv_region_handle_gfn_fault(struct mshv_mem_reg=
ion
> *region, u64 gfn);
>  void mshv_region_movable_fini(struct mshv_mem_region *region);
>  bool mshv_region_movable_init(struct mshv_mem_region *region);
>  int mshv_map_pinned_region(struct mshv_mem_region *region);
> +int mshv_map_movable_region(struct mshv_mem_region *region);
>=20
>  #endif /* _MSHV_ROOT_H_ */
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index c393b5144e0b..91dab2a3bc92 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1299,15 +1299,7 @@ mshv_map_user_memory(struct mshv_partition
> *partition,
>  		ret =3D mshv_map_pinned_region(region);
>  		break;
>  	case MSHV_REGION_TYPE_MEM_MOVABLE:
> -		/*
> -		 * For movable memory regions, remap with no access to let
> -		 * the hypervisor track dirty pages, enabling pre-copy live
> -		 * migration.
> -		 */
> -		ret =3D hv_call_map_ram_pfns(partition->pt_id,
> -					   region->start_gfn,
> -					   region->nr_pfns,
> -					   HV_MAP_GPA_NO_ACCESS, NULL);
> +		ret =3D mshv_map_movable_region(region);
>  		break;
>  	case MSHV_REGION_TYPE_MMIO:
>  		ret =3D hv_call_map_mmio_pfns(partition->pt_id,
>=20
>=20


