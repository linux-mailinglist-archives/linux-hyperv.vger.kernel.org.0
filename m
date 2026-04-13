Return-Path: <linux-hyperv+bounces-10143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FDPFG5b3WnYcwkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10143-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:09:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 017183F367A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 23:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7272430211EF
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B538B7D9;
	Mon, 13 Apr 2026 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MY2kGbGP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9EF35B62F;
	Mon, 13 Apr 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114535; cv=fail; b=A7SWcNjhUOwDtiqkP+X2os7P9YOrggez89YwxVZZUUoI8ZG0e4FRpwdZMDbc4mmOMuYVXkdzf480bfUMdhsEBsGrLnVdAuoQWnX6cxIlWO0hzGpJ6XJAUYXnrezGBAgXC/+Hr+BzvS4Tb3zaSUHmTIpoU1qrQsv6Md3Zw2MQ3w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114535; c=relaxed/simple;
	bh=W9kfdGwYDOzEl+osfBvS9ulQ3kUknC7rUEK9oZKKKk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3ith6058toO8E2LxH57ctxfgHceACKymr3DmsYN7MN3166DNB/mO3XdH7ElXmWbpLjWhKJWkD6MgFsPQXNvdR8n21k0/0bjrKpH1AGeRWJxWvKHpk3TSdYdBuwf7drNTDzmKNBxq3FENBOf5zF66fefzSwzrsY1hr2saG6X3lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MY2kGbGP; arc=fail smtp.client-ip=52.103.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o65TLoFglS15bdY6CFrF5b3A0oeTjCmKMrJpJTK++c2THFT+Ms/YwDezmhe0bScCU4Q2Xf5gu22lFUVZkNCnwgSWXbG/zCPLlmSHWVLxRn0HcbhhWRNOBT65yedURicPtjbwaXZQEznUftwtJz8PpmvWWHeUOq0h7SLjGiWGiJnW8ml2O82j7ywhiQ/4zDQKor6KG6R+1eKywtaXVF9voC99lfum6gIt/XBLjdALIX0fTAOmmqBNs3l5a1KDKKLMiYZutiRvtboY0vEb9Kr3gPsDM9bBm5NUJ/WfauWjiSEZ+cmwWsjdbT0UQDBQb/yPdO6OYMPbDa3jIokql+Zm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV7an+fUtgrToWZuz22XPqz4pLciHZcNdxgvibmv/no=;
 b=Hlk7+mQ0o5G9R38LKIiux1Fv4cdzMkYmb7Kz9l6SpmwS5RfUcolU83zmdZ4iiP5qCwdbIFaAJpVTw84X5yZ4Zc+V9MCp31a8KIJ0COYsAm2WLulDl7mG8/LfKaU6+i4WQEHsdc/LSCoaTX5wkln+P01hIwaqaz3m9gaAr50Agi7sQFUhZemghkIOkQtCqTzwGPzcdLU7/j0x9v8H1pkxyMzeaP4fSIAI/OODM0b4y0b4P9opCSl5tsqqCqWDrZNSA77APF3QbyCNbv/WyJP1RQnNGc0Ae+yIb71g5ntsrGb6pXsn+Q63a7ASoaO/oJQdCM5YHKSEjqjhBrgpJZg/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV7an+fUtgrToWZuz22XPqz4pLciHZcNdxgvibmv/no=;
 b=MY2kGbGPMpA8GzTT/hmZk+BYwFoZUUXr/Zv5Bx3fNKPaw0Z4feX2GfCSHJgMjlWjY3MSIP3h4u0W8fPdVZcRt4Qj3q/24BQbcoMCZ3HYg95z4vF06YH4jp+I8jSWXyVQ6obtXmFcEhYRUdxQZwU88Xp/ncX21O/Jozl8w8ZqLX3gdND6TXikP1MwR5fHH9Ss/Qgu/dfwRrOf/zW99PpE1IVfOkrXZbr9CTjcN/pgNQ4M3T62hI4C8zdimwAjvzUO86VTezp4Zc8WWPU80iINTIsg1GblknhM8Se6Yw9wDCWC+qmf1Z0EUDZc8CvgHIgP3WiL8L6vsQZKJlnenqpcAw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8057.namprd02.prod.outlook.com (2603:10b6:610:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:08:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:08:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] mshv: Support regions with different VMAs
Thread-Topic: [PATCH 3/7] mshv: Support regions with different VMAs
Thread-Index: AQIU4Z+TtrNiAr8jNsFOwdDCIL2bZAGPO1GztWDFreA=
Date: Mon, 13 Apr 2026 21:08:52 +0000
Message-ID:
 <SN6PR02MB4157043516DEB3DC5E987AA6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177490106973.81669.17734971204992890360.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177490106973.81669.17734971204992890360.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8057:EE_
x-ms-office365-filtering-correlation-id: 8ef08692-c99c-49dd-be6f-08de99a0dd9d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|13091999003|31061999003|8060799015|8062599012|15080799012|41001999006|51005399006|19110799012|37011999003|440099028|3412199025|12091999003|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7whTAEExEomfJeh7NlfDtMt/BWQX4YXfJZC9oXBP55S9z1tsWg0IVMp5DZc0?=
 =?us-ascii?Q?+QaiSgs6I7E4+lXp4YjJ8QapWNUes1Ry0TEq34tnvvRv/RG1W5kHPJrmphYk?=
 =?us-ascii?Q?y3PuVcOa5Ud1QlgX2IjtCKfdoXc0jySkU+mDU0q40zRhNBHFzdD6nyvwJOyq?=
 =?us-ascii?Q?CiY33AD3U/00cslBkDPFGJh5UeVRYhUCMxR1645iEiFuYwM8zAjvmnFUNaQB?=
 =?us-ascii?Q?hNehUbXLSh//YqfI0sFsi7zmJO8pylCysN++8Vh8Tmc8yo5JRbuB+kdQL55A?=
 =?us-ascii?Q?REyiyDnbc12eEdjTkBU73g1fBs29gk5V7/nbjWAtY0ucNqI+aCOkiTNOCh6G?=
 =?us-ascii?Q?2r7HhBbHQKabKnHdVg3hSKJSJdiJ6JKuhb7kYemeAhp65ebjf4JTK2Ac2oDv?=
 =?us-ascii?Q?SXgeGktSXGb5pztgxBRirOlURG11PFBu2t+qp+k3hR+fbfsBugD9j+KXCuhJ?=
 =?us-ascii?Q?DCK5a8Ib8UrJCmCROY5HcTsVwtZqjV+nYcCPRhl6b8HW06DOpSeBUWWv9eMW?=
 =?us-ascii?Q?5hFsOsK+FX2eqsl425pXpHyFczSnzrhosQWm3+QvSjKvgJJcjSjZ915YP44Z?=
 =?us-ascii?Q?PQWcAElyf17ui88XkDrm3LUViE7xQ+8R03GaM/BLp42U+LCpnDjb/rFH4CUQ?=
 =?us-ascii?Q?gpLlhHEYqmSzKtHncfEwMZgAQuDcwXSHTYgLp0L4YBuRDCfUtdUnjDiNxx75?=
 =?us-ascii?Q?9n/zrm4hpcH4c32LYDF4/d1CmFshUihddrqcCnUfB2MmFHQlqT2zdJ50744h?=
 =?us-ascii?Q?6abk36+cQRe212NHnpYf2ZHV3Nv26mpOkCH84Q73ln8XJWrKBfnK14mn6JO9?=
 =?us-ascii?Q?9IyrSU9iwwC2jISWE/J3md1u0jvL4ldNSil4mkIpFTeRfp5Fj+FeYvv/0u0Q?=
 =?us-ascii?Q?aAe085Oo8sptkFq6EteDMzvzk+GvsPFt5XL1fPkHh5zu9ERh+IkjrCBXezFP?=
 =?us-ascii?Q?AxYI8wf2GxKp+PC+/1/jeB/jNV28W1szaRKSC2hyeCP3N13OngbIIAHFAXDf?=
 =?us-ascii?Q?E5sszh+KeTB54G8rvggqSJ2hwLKjGovX/4Bz3ST3ajGVrWn9iT/mhXybf8lL?=
 =?us-ascii?Q?fvW0EqAv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RVsQDUZAzkaOnVPeENicoehVxbYzt0Gc/Yrj67hli6i+H1iR03rLX4PwxPio?=
 =?us-ascii?Q?paUHVvCgrkmIUwEDo0pkKYqOLfb3JjPeuJObkBlUlwOjAy3B7ugIV/VkC83n?=
 =?us-ascii?Q?/5WWtmzMh925mYsH9AlvR6JjsgH8m181R0vMjFICP9o6YdPv2F0baQaV7Eh1?=
 =?us-ascii?Q?ktNfPTfsIHrfJWuva1vGwLFcl7aNpt9sBZ4DpDvQP7gz76bo62tPrvdQmCdz?=
 =?us-ascii?Q?rUoTykMFqC3IhNlHlbSv78ThQQpmqaVE4dYYbfpyXgxhq5l5VLE9ZlRJfaoC?=
 =?us-ascii?Q?9Ot6QTq1wgUbnqVbipK1h3Kh06Ob2wJJmbm13X9Buzf5oCJaMaEu129h42xW?=
 =?us-ascii?Q?gfcczO7UHPkDixBHPPjtXCTpjeUTxKXmsjdCONRbhI25jSy2d79cXZ5ydkpw?=
 =?us-ascii?Q?lQrQpcgy//h0Aex3KKxqkcJE2wQp9kL5IklrNf2l0fNm1bI/awBaTfTlBhuq?=
 =?us-ascii?Q?WEcphK2+UalCTvWCnLNxpRwlRFZ3OR10ZOt1/iuqQsscY6ndLik7NINQ7jal?=
 =?us-ascii?Q?8TKrBEPjfUw4ayFRbHXfFPKAhfSehOOIfs0/ZTj6gfU6irHXV7YZwxXSnStf?=
 =?us-ascii?Q?J2tQ91/JTQozv8LdZWHfCV4BvngMcGMNebmDtWAhGW1SCJ7ii/RjGV4pkPH5?=
 =?us-ascii?Q?73ISJQ2E7Qs+abVxYLhi9JebOwTCtPHRjIlR08L+YXavONSIwIrDAuaag9Pt?=
 =?us-ascii?Q?ROFa8KSn/oWuKXJOVPe4Nn7m+Squ9HpNKqfh92Hfsp00yQXT7tig0zdaNzJJ?=
 =?us-ascii?Q?1Emr3E4CmPrI1y82Vk4Rxd27mVIQGcxX/XtTQcmUp5twtTgO+T3la67w6Fcf?=
 =?us-ascii?Q?jD/BqjIg3K0kJLxzI0GwfrbEpUFijeBbuY6GUW+Q71uzkDOmCmQRre8us+ux?=
 =?us-ascii?Q?LlS4cgjkidbO0jarAwvCFc5q/3vkEoIQsHXIn+bP67dK6o999aqUxt4PGs1b?=
 =?us-ascii?Q?t6yTcZ0bdxethlUBr2AN4W4KReflDIRvTqLel9A8O7D5rFd+0pE+gxN1HoOO?=
 =?us-ascii?Q?3xJCagin3+I/O4EPAQZnztrA54VpTmQ7oRh/w8hY9CcqW4SK+f2UjvsGCWgM?=
 =?us-ascii?Q?YkTpzwGmgSwksdUVtTh39SJaI8jJuCnx1Ct0MiRn/CSK1rO4LyQeDUAiAxeH?=
 =?us-ascii?Q?Bs9xCfBv2ZvQQr7E+wHuUwF8LfoTQjR9BzU3PKBkuUgN2N0tkq5qRJ1/tzaC?=
 =?us-ascii?Q?VOVGTBtu0OQK4YgJyHZZvRxqgJpTir2VLSyFLcq3y8iPZpEdddiiVcnBIXH4?=
 =?us-ascii?Q?j8VjdlhrSISvV1QWP3YFQ+1adMEv2QemZ6ZoRicATXrcumvGupjmurwzE6Yn?=
 =?us-ascii?Q?clyBKYgT0IsSTF2cnvaCxEc+h0DZ6aZ9uHdAjsxHmGnx5uHq0kNEdqCFRWAW?=
 =?us-ascii?Q?KEas9P0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef08692-c99c-49dd-be6f-08de99a0dd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 21:08:52.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8057
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10143-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 017183F367A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday=
, March 30, 2026 1:04 PM
>=20
> Allow HMM fault handling across memory regions that span multiple VMAs
> with different protection flags. The previous implementation assumed a
> single VMA per region, which would fail when guest memory crosses VMA
> boundaries.
>=20
> Iterate through VMAs within the range and handle each separately with
> appropriate protection flags, enabling more flexible memory region
> configurations for partitions.
>=20
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_regions.c |   72 +++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 52 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index ed9c55841140..1bb1bfe177e2 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -492,37 +492,72 @@ int mshv_region_get(struct mshv_mem_region *region)
>  }
>=20
>  /**
> - * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memor=
y region
> + * mshv_region_hmm_fault_and_lock - Handle HMM faults across VMAs and lo=
ck
> + *                                  the memory region
>   * @region: Pointer to the memory region structure
> - * @range: Pointer to the HMM range structure
> + * @start : Starting virtual address of the range to fault
> + * @end   : Ending virtual address of the range to fault (exclusive)
> + * @pfns  : Output array for page frame numbers with HMM flags
>   *
>   * This function performs the following steps:
>   * 1. Reads the notifier sequence for the HMM range.
>   * 2. Acquires a read lock on the memory map.
> - * 3. Handles HMM faults for the specified range.
> - * 4. Releases the read lock on the memory map.
> - * 5. If successful, locks the memory region mutex.
> - * 6. Verifies if the notifier sequence has changed during the operation=
.
> - *    If it has, releases the mutex and returns -EBUSY to match with
> - *    hmm_range_fault() return code for repeating.
> + * 3. Iterates through VMAs in the specified range, handling each
> + *    separately with appropriate protection flags (HMM_PFN_REQ_WRITE se=
t
> + *    based on VMA flags).
> + * 4. Handles HMM faults for each VMA segment.
> + * 5. Releases the read lock on the memory map.
> + * 6. If successful, locks the memory region mutex.
> + * 7. Verifies if the notifier sequence has changed during the operation=
.
> + *    If it has, releases the mutex and returns -EBUSY to signal retry.
> + *
> + * The function expects the range [start, end] is backed by valid VMAs.

Use "[start, end)" to describe the range since end is exclusive.

> + * Returns -EFAULT if any address in the range is not covered by a VMA.
>   *
>   * Return: 0 on success, a negative error code otherwise.
>   */
>  static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region=
,
> -					  struct hmm_range *range)
> +					  unsigned long start,
> +					  unsigned long end,
> +					  unsigned long *pfns)
>  {
> +	struct hmm_range range =3D {
> +		.notifier =3D &region->mreg_mni,
> +	};
>  	int ret;
>=20
> -	range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
> +	range.notifier_seq =3D mmu_interval_read_begin(range.notifier);
>  	mmap_read_lock(region->mreg_mni.mm);
> -	ret =3D hmm_range_fault(range);
> +	while (start < end) {
> +		struct vm_area_struct *vma;
> +
> +		vma =3D vma_lookup(current->mm, start);

The mmap_read_lock() was obtained on region->mreg_mni.mm, but the
lookup is done against current->mm. Maybe these are the same, but
it looks wrong.  (Pointed out by a Co-Pilot AI review.)

> +		if (!vma) {
> +			ret =3D -EFAULT;
> +			break;
> +		}
> +
> +		range.hmm_pfns =3D pfns;
> +		range.start =3D start;
> +		range.end =3D min(vma->vm_end, end);
> +		range.default_flags =3D HMM_PFN_REQ_FAULT;
> +		if (vma->vm_flags & VM_WRITE)
> +			range.default_flags |=3D HMM_PFN_REQ_WRITE;
> +
> +		ret =3D hmm_range_fault(&range);
> +		if (ret)
> +			break;
> +
> +		start =3D range.end + 1;

Since range.end is exclusive, the +1 should not be done.

> +		pfns +=3D DIV_ROUND_UP(range.end - range.start, PAGE_SIZE);

Just to confirm, range.end and range.start should always be page aligned,
right? So the ROUND_UP should never kick in.

> +	}
>  	mmap_read_unlock(region->mreg_mni.mm);
>  	if (ret)
>  		return ret;
>=20
>  	mutex_lock(&region->mreg_mutex);
>=20
> -	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
> +	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
>  		mutex_unlock(&region->mreg_mutex);
>  		cond_resched();
>  		return -EBUSY;
> @@ -546,10 +581,7 @@ static int mshv_region_hmm_fault_and_lock(struct msh=
v_mem_region *region,
>  static int mshv_region_range_fault(struct mshv_mem_region *region,
>  				   u64 pfn_offset, u64 pfn_count)
>  {
> -	struct hmm_range range =3D {
> -		.notifier =3D &region->mreg_mni,
> -		.default_flags =3D HMM_PFN_REQ_FAULT | HMM_PFN_REQ_WRITE,
> -	};
> +	unsigned long start, end;
>  	unsigned long *pfns;
>  	int ret;
>  	u64 i;
> @@ -558,12 +590,12 @@ static int mshv_region_range_fault(struct mshv_mem_=
region *region,
>  	if (!pfns)
>  		return -ENOMEM;
>=20
> -	range.hmm_pfns =3D pfns;
> -	range.start =3D region->start_uaddr + pfn_offset * HV_HYP_PAGE_SIZE;
> -	range.end =3D range.start + pfn_count * HV_HYP_PAGE_SIZE;
> +	start =3D region->start_uaddr + pfn_offset * PAGE_SIZE;
> +	end =3D start + pfn_count * PAGE_SIZE;
>=20
>  	do {
> -		ret =3D mshv_region_hmm_fault_and_lock(region, &range);
> +		ret =3D mshv_region_hmm_fault_and_lock(region, start, end,
> +						     pfns);
>  	} while (ret =3D=3D -EBUSY);
>=20
>  	if (ret)
>=20
>=20


