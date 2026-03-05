Return-Path: <linux-hyperv+bounces-9152-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIUCKf7cqWm4GgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9152-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:43:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C5217B1F
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 20:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B8FA301DD7D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Mar 2026 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C953E3DBA;
	Thu,  5 Mar 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M8GRYcM9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012070.outbound.protection.outlook.com [52.103.14.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27B3CB2CB;
	Thu,  5 Mar 2026 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739836; cv=fail; b=AzVXKa8OiWKLwwKkDx3cfWHWPS0GvSN+Dt8wTh8+Ld1Uv44Dvbe5Fg938SVBBKRNKxmz2FsQ4j68uSNAXbIDHFpZ3ZlCPIar4ejWwK9IHQfp9QG9uOSy3fyUbHkiCu8Xi68n3TI1OkLCmlE8mZDfGPlTB+nAKLG/AL7mMQnEofM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739836; c=relaxed/simple;
	bh=4VRg5lTTD+JZ6JhL93d3o40wCm/DjmldYBcCGpF+uig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MS6jI3OPj4fHoP3mwOvkAEpudTFIv6QZQHl6Q+RWfi51snMod+7ibaRwzxdfCQx0ldjptYCk9ESoTeSoxZnHpFxO7Utkuw0RAVBDKx0Zfxdnvgjqxg0H3Nlbj3ODvBESv+ckt5mt8Xyhidzaf2k4wPMI2TkBVIAMxgR4BbqdYwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M8GRYcM9; arc=fail smtp.client-ip=52.103.14.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLHmSrbEEk5gMSlWbtAcox84pbQ1uklKxz6wSD+zW7I2VMYWB29EjlIsIn8J3SoPX8YMDpTyjdYrew7brjTuqMSAYb4TrXIrStjVvRcALFIUuscpCw7q9X2oP0DRAc24LFLq83cPNoTphNLWHl2JCzpkiMpbddnFiKCv05SBWdbEsep7kIiKRF9GRJ6Uh8xvvTpU9xDXtRAppwxt4X3X3/4XQ+tlIVOQjwYL7AeFLmGsgjr0Ambat2Tk8ZRCjgCFFk5jHGfE7AIROKuC3/5chU6BpsVPlR495vyM6I8mvymHGkJYT2NG/5Mz/iOXFLc8lkmt57Fnz4E1TSh1ZbCH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCgO+Lk6UXEu2eFzi8dWlDqmxHqFlzk1cQK6g5x/6p8=;
 b=OxTL0t3wriN4EcFCAnasnZwp3awlYuOcr4LYvX1KaHtaYhD1K8BJ8zDtn6wXw2JZDuEHzHrzX7Js6Bau1fwkgkNfJLLtlUJV3LGyN+1KqPyw9fNOB+XgGLHubgMU3PoWicgODlj7r3hWvvHIY1wdhxDS/cehIWVqMpBkFDT6nQAOCc1MzmipDEYyKASzzSFYC5Ln2eJ45FMswYukNcUFyk2tJyQ8ClWkrRn6g30U0WbdCsJ1Nf9ToFBmeah2uEFejMVA8Ef9XHidD5AzWpdW3cXZ1LvkdFrRoWpzvOA0yP4FFCIzvXf6BngSeayCbUef4PSDgF6CMXQrJF8eepCjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCgO+Lk6UXEu2eFzi8dWlDqmxHqFlzk1cQK6g5x/6p8=;
 b=M8GRYcM9epIjU07GH+cWTBQBeYAVXLcZBVAyTW11izjWmQHbozXH4KmHUjjbMeDwJZAf53cwSo1c4Etf7Ss/GlAnoYrNUEhQJ8AnObEUG/CusnfbrQXp1BuBPKrd2+aVs6KN6kVQbBVoJsN/Q3quZrtojH7JEPkFSyM2nTDj7OUEnLND1A9i96FEqYfSkShV1bT5Ndf6sDBrquGtL3s3mwoZCjOBCRFwXaJQbsYg0LR8IEobN//RrD9/QiXP7cCFC4O/wE6DAnmpZYb95F7iMDvo9pYuy4F5XfyTK1DfMBLD7DTt206PkLL34E2BaM2M9sgx7vRRy+UFZ27kHacwrA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8726.namprd02.prod.outlook.com (2603:10b6:806:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 19:43:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 19:43:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] mshv: Fix pre-depositing of pages for partition
 initialization
Thread-Topic: [PATCH 2/4] mshv: Fix pre-depositing of pages for partition
 initialization
Thread-Index: AQGf/CXhq+vihj2DXZ0/OE6Cmc0kFALD95CUtgOMT7A=
Date: Thu, 5 Mar 2026 19:43:52 +0000
Message-ID:
 <SN6PR02MB41579AC067C0F5A66C29F6BCD47DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177258381999.229866.4628731518107275272.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177258381999.229866.4628731518107275272.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8726:EE_
x-ms-office365-filtering-correlation-id: f6af8810-1ab0-4dd9-6112-08de7aef87da
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|51005399006|13091999003|12121999013|15080799012|8062599012|19110799012|37011999003|31061999003|8060799015|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4vX6/zHIUya1aCrecromnIe3uDKurNet2Uj//zpX5/vVbZdpCvLv1SCHygKh?=
 =?us-ascii?Q?gp/o2TUeuzBEHgIFQizipWBPxX7G7VGW+ZHkZ+5q6ZnTKHr9Ttuc2EvUlA2u?=
 =?us-ascii?Q?5DzSyYRXpyt+mx7n50/zx87fJnZqdwV0udI0RizwafKksc03oxb9pLKTORi9?=
 =?us-ascii?Q?tu5VFSBhOjrKGv+XhIWNyg07efLLEpFFoF1OIhrVV7XQ1ZqW81cTJg+U8YYb?=
 =?us-ascii?Q?kgRyK4dvQceHes8whvqAGZJj4VeaS9ZrNdlqD/4DYd6urz7F5D8D5cyFUp4U?=
 =?us-ascii?Q?sj0vKGnqD7meR4M4jUJBNjqua1pQRf3yEjDAHkTEbM6U+4YRLm9V6HkD904Q?=
 =?us-ascii?Q?/OuCcKT19I+69jhz0yukHVjNHp3ODMsR9k/9JsLarZAOaXozzBq4hnBRzng5?=
 =?us-ascii?Q?6hmN416y9qrTzly1wKNrIzKXPryubETh17kHFCu3zS6Ul0CtOdqqob+ZYdj3?=
 =?us-ascii?Q?G59gCQA3sSEbwjmStcNYWY2X0RXCjomvzbmESIqEb/JUPFajwUxMjNJUeD/r?=
 =?us-ascii?Q?ZNAOgzgT0oDrWYSw8eTvmH6Q8l/MS2Q45M7xDjSzvfEmbWs3HUMAt/LE9n3Y?=
 =?us-ascii?Q?4DQKzcdfkA+IKFh+i2zZMVQGi/te4kzKdhzf0n1YgqmZBPDKUMvhPy6CJtgP?=
 =?us-ascii?Q?A15Vx9pNRpVWQnM/ZURkYgUMYrAA7Xdi6mpvdsw2W/DUunYzTw/OtTz8t6fC?=
 =?us-ascii?Q?5o4NElIsn980J804e5Ikymns8LfnjukBjNAKidiX7VAX6WkA43+jNorZwSQt?=
 =?us-ascii?Q?Pwm47kvEUqscpOlPgf7GejEW/rKTTH2SVaDxrWffuny9GTsAHysfmjMWD/P8?=
 =?us-ascii?Q?16c7pp7eyWKBZGe9vZ4Rug/QjsruqSTvtxX+GnrC2j0sEZj1zMd23iWNVMYD?=
 =?us-ascii?Q?+KdBruatHbL2UDB23vGfZqThEm/oT8rkAWz4eiJXfZyDVL3wmJomrqXDaxN2?=
 =?us-ascii?Q?u4CTlK+OENH5hdw9SbwMaeVNi6vUp+00UG9b4dNChzFtwZS8GvPIp9CH8Fyi?=
 =?us-ascii?Q?oDFphyfXECuo+GL8Q68wPhfsz0Q0qdoUFXukUNreAS6htqA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MFePS5f/Tx22vklGJAaRJrs4yBA9lNFCJHnIgo+ZBrbNHKE/06CHT5GHeClO?=
 =?us-ascii?Q?UIQXCrGtcs9VCzZ2diOk5fsyRRvBSCklEO1qijW+9F53OuWMYqDPNCdvY3Zv?=
 =?us-ascii?Q?ih8zr2txeFG9ZV2sb8ohQDwPE1UzElQL6WmPMVkvvFPhJQVLgAqweRIqETGe?=
 =?us-ascii?Q?ZvVq0IyaQ12RqzAHfC9zlUV2XH+FaeWpb99buO2Qo1Xr0ACOCxAaJASsGZf2?=
 =?us-ascii?Q?sKc4UIQdia+lrUbBZg3FAXFUgLKmxJi5wdGlig93hfeyu2T2CWP5hC2zR5kh?=
 =?us-ascii?Q?OefdnozEOmgSLFbsURkXOtqDBqubCPv3OFdHrEtaBHPifbgI/YWgSaZOXW56?=
 =?us-ascii?Q?19ZUWepYdh/vyAw/30T3zszFKmtMSW6KYZzPBHqXL6crSAR+rQqLBchnRZje?=
 =?us-ascii?Q?7ZXoBkLVY4V6f0tENiBQaKPK2dGIqmVOGhtw2WnpNaUYZm0KXl1EmVXJCODF?=
 =?us-ascii?Q?N0iemN0zD9M76Q+O40mcwpBm/zGjp0InoD9d8S+hJGyMPHg1yWspamIxQb0a?=
 =?us-ascii?Q?2V4wGVQcEQDLNTby93AGhvFfeyw+1zPhoOctQea5+93EjzZ9T/F3w7MNk5c4?=
 =?us-ascii?Q?nvIxWly2WGGknfd3EP8EJfLounh0a2pTBVaD0WkmF5qVh1iFBniWE1KnfoYT?=
 =?us-ascii?Q?iXynlxqP607YKS24WUAAAYOY5UV5d8WkSjJeNHcFij5/lCWgmntiPbSFd/Cb?=
 =?us-ascii?Q?al6qEN2VTVLKj0o0jZ+KE0RIVzfyp9BV+Ukcu/Xv21qWg9+myMhnTrXtC57Y?=
 =?us-ascii?Q?8PgCTzO7D580LkjS5O8yI0XwxyrPQstbinh9KhHzQ61+AqYGOyP06J6IsPjJ?=
 =?us-ascii?Q?bubMh6U1wHFShitv5X946xte/cwTvJ1HAKSUc77JrQgpqmBCIo2UxgfzpL3G?=
 =?us-ascii?Q?nSfyx699nEvwXv4+fG6o0NyRDQGZ0E0RFNlwQ0symoKO2ZkUfT0RcNHBdAZ2?=
 =?us-ascii?Q?R0QF6cHF4+USOXvsEoU7kwRkkJUriV8eAK1KeExWQMpd916a+QbIvpSYQjgv?=
 =?us-ascii?Q?VTmV4qsrcHCccbHXMI88DlzOgsXTg9YHegVvyqP4tPhYiQ+DvBmXbeoSKaPT?=
 =?us-ascii?Q?obHpeRpcjUsEcFdibm/r42QXww1vfVqbUEi4zZGqO72B1eg0B0tVaFEcf7tk?=
 =?us-ascii?Q?ObEGWKjNqsNQXUg86w2F1whRZ4HYN7FzuL7Ax+HOdsD4AYrglb3WkueFf4SG?=
 =?us-ascii?Q?xpmeIFBa1CkqPerW+hyJnNNAk9BF9J/364wCt1RW76CLJIvgxEe9pn2uUnDr?=
 =?us-ascii?Q?348SEYpmTuYpre6waBPki/hD1z6gdEKXZEFXTMvxaZwd07vH7pqSyleG6Z6T?=
 =?us-ascii?Q?MZKIdeM2iJuQpaWzLL+DYvWMpQWKDzEO/f0ZcRVr9Vk+LjZp0qbhNph6RtGJ?=
 =?us-ascii?Q?kvYXtW0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6af8810-1ab0-4dd9-6112-08de7aef87da
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 19:43:52.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8726
X-Rspamd-Queue-Id: 651C5217B1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9152-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Tuesda=
y, March 3, 2026 4:24 PM
>=20
> Deposit enough pages upfront to avoid partition initialization failures d=
ue
> to low memory. This also speeds up partition initialization.
>=20
> Move page depositing from the hypercall wrapper to the partition
> initialization code. The required number of pages is empirical. This logi=
c
> fits better in the partition initialization code than in the hypercall
> wrapper.
>=20
> A partition with nested capability requires 40x more pages (20 MB) to
> accommodate the nested MSHV hypervisor. This may be improved in the futur=
e.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |    1 +
>  drivers/hv/mshv_root_hv_call.c |    6 ------
>  drivers/hv/mshv_root_main.c    |   23 +++++++++++++++++++++--
>  3 files changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 947dfb76bb19..40cf7bdbd62f 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -106,6 +106,7 @@ struct mshv_partition {
>=20
>  	struct hlist_node pt_hnode;
>  	u64 pt_id;
> +	u64 pt_flags;
>  	refcount_t pt_ref_count;
>  	struct mutex pt_mutex;
>=20
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index bdcb8de7fb47..b8d199f95299 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -15,7 +15,6 @@
>  #include "mshv_root.h"
>=20
>  /* Determined empirically */

I think the above comment applies to HV_INIT_PARTITION_DEPOSIT_PAGES
(not to HV_UMAP_GPA_PAGES) and should be removed.

> -#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
>  #define HV_UMAP_GPA_PAGES		512
>=20
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> @@ -139,11 +138,6 @@ int hv_call_initialize_partition(u64 partition_id)
>=20
>  	input.partition_id =3D partition_id;
>=20
> -	ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -				    HV_INIT_PARTITION_DEPOSIT_PAGES);
> -	if (ret)
> -		return ret;
> -
>  	do {
>  		status =3D hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
>  					       *(u64 *)&input);
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index d753f41d3b57..fbfc50de332c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -35,6 +35,10 @@
>  #include "mshv.h"
>  #include "mshv_root.h"
>=20
> +/* The deposit values below are empirical and may need to be adjusted. *=
/
> +#define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
> +#define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)

Nit: The placement of these #defines *above* the MODULE_* notations seems
a bit odd to me.=20

> +
>  MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/=
mshv");
> @@ -1587,6 +1591,15 @@ mshv_partition_ioctl_set_msi_routing(struct
> mshv_partition *partition,
>  	return ret;
>  }
>=20
> +static u64
> +mshv_partition_deposit_pages(struct mshv_partition *partition)

Nit: This function name makes it seem like it will "deposit pages".  Maybe
mshv_partition_get_deposit_cnt(), or something similar, would be better?

> +{
> +	if (partition->pt_flags &
> +	    HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE)
> +		return MSHV_PARTITION_DEPOSIT_PAGES_NESTED;
> +	return MSHV_PARTITION_DEPOSIT_PAGES;
> +}
> +
>  static long
>  mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>  {
> @@ -1595,6 +1608,11 @@ mshv_partition_ioctl_initialize(struct mshv_partit=
ion *partition)
>  	if (partition->pt_initialized)
>  		return 0;
>=20
> +	ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
> +				    mshv_partition_deposit_pages(partition));
> +	if (ret)
> +		goto withdraw_mem;
> +
>  	ret =3D hv_call_initialize_partition(partition->pt_id);
>  	if (ret)
>  		goto withdraw_mem;
> @@ -1610,8 +1628,8 @@ mshv_partition_ioctl_initialize(struct mshv_partiti=
on *partition)
>  finalize_partition:
>  	hv_call_finalize_partition(partition->pt_id);
>  withdraw_mem:
> -	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
> -
> +	hv_call_withdraw_memory(MSHV_PARTITION_DEPOSIT_PAGES,
> +				NUMA_NO_NODE, partition->pt_id);

What's the strategy here for withdrawing memory after a failure? As I noted=
 in
Patch 1 of the series, there's no way to know how many pages were deposited=
.
Might have been zero, or significantly more than MSHV_PARTITION_DEPOSIT_PAG=
ES.
And in Patches 3 and 4 of the series, there's no attempt to withdraw pages =
if
hv_call_deposit_pages() fails, which seems inconsistent.

>  	return ret;
>  }
>=20
> @@ -2032,6 +2050,7 @@ mshv_ioctl_create_partition(void __user *user_arg, =
struct device *module_dev)
>  		return -ENOMEM;
>=20
>  	partition->pt_module_dev =3D module_dev;
> +	partition->pt_flags =3D creation_flags;
>  	partition->isolation_type =3D isolation_properties.isolation_type;
>=20
>  	refcount_set(&partition->pt_ref_count, 1);
>=20
>=20


