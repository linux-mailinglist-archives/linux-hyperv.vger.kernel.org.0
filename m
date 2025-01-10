Return-Path: <linux-hyperv+bounces-3659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC6A09806
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB858188B460
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFC21325E;
	Fri, 10 Jan 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AbXjRPN1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19012051.outbound.protection.outlook.com [52.103.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02E21324F;
	Fri, 10 Jan 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528373; cv=fail; b=NqGquFCUnlh7mRiWPUVY8iy/UdICAdxDHfjUpKMGR/6b0LsdXrJKNodTEB7Zfuh3p8Uk1mXE1ZdhaL1Ez6sQvjpAHvYOMZxGU+3fUyP1r1ShIgpQIkur20coI3svypCaK1pDVKXY4dhB6JW2k5jHFCa4Ek1myZZINRc9MHH92Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528373; c=relaxed/simple;
	bh=Z7g5Cq96xzfwTXyZJxEM3UB9IdugaSrQOSQT7Gl8XRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1XImPyIyjwuJyjrm2xaRJflIT/KtM0rmKO0ps5fWKpytzbJosNBHdkO1ya5bzY4yfOZZG15W3Kc6BJMDBje+BaX+u+1hhxNM33DGE6qxKzZpGxNvCg6cSgLVY+UM5m+Uh7zHfVg7CQwXJ/BA7/WMmZiZeRnb9tgTbpUHYildvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AbXjRPN1; arc=fail smtp.client-ip=52.103.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqbwLhDiphfqMzHiaNeyanDR28qoFymztC1YZzobJH7Iq8qWrlUulHqKR+H+MMH/h12Outk7cccHBkLmSj6vG+ErDNwduSYXKQ2luC4PBiZuZsC7YBoJu+EdGSaREoZqrnvf3xNOJxTIH2Fsq3SavZYU/AQ5gKrUwa6pQCcjxrLNKSwnASG0gt5kwcTQAi+XQRgchWPQFBc2IDZqgrN8i1xht0p50hUuInjSSi8alxZM0LJbNWaeVT7T3Ewy/FKIiEf5AxN6pYHR/K5VYQX8Qw4BtaRDx4T3NGdNnooVygyPDbIeRjV1wM7TDrMaoGDWMVwZyOUgSxla669JBOVQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Dshi0inPXEEss51UnWvTdfW0bRfPAL33gdjoYv1svE=;
 b=vCA7MCQkx8nWo5+BhePOVqYCsQ1BVDXKn9RoW2C+6MKoMh/cP9lsimMXVMyF7N7jrcCgCzGywNUsC6w7Q1GNJQ9NlT1FuZtWmnIeAo3T0K7Se9EY7IRi+Kd7IzCVrDLhr6QX5Or8BK5sB520oSmf7VqrdMo2vSuC9U2FtK1FKY8Ny6fLUHE+mR/E0a1/gU62y6aZxbn39oupw4qOEdf052aXJHqiumWBogNONuwtTmIjenUnJgCys1RGTojZOBlG7lyCAT8tJyPLeMcC/ujB/VmaQckSsu0U+olX4V+YxANEIIRvHANxt/3YycPMI1EJpJYSeDv/ullBFac+c/+vLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Dshi0inPXEEss51UnWvTdfW0bRfPAL33gdjoYv1svE=;
 b=AbXjRPN13xiruCTs7CWd4zcGsJW+bst4vvO2QVTNdZCb5K9esBllwnBRXUBc7bNEaO8FMeqvM+r2DZDEOfToVCXqul0j76ZQbRmpXr0AtU3QvXDcg/Oa+DczJ/g5Nd+UF/J8w62beFhsTRVOFkL6t9fl7l6wvXVTi2aeIfN4jip6gDUqqx/ohhcf5j+rb2j+4EPsrMB+1siFiRKy0+zFqc3Moy+w4BYTM5rf7N89DcAxJNzffapCXU5UlOIsPSN0VfSh6YGOWPDMnugOae/gJq3HMZVDrThqa+/VsjJQIuGaWYbcdyLBuhDWYpXGrh7ZYTvnAOTRBZMGqHGhb4qAkw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8671.namprd02.prod.outlook.com (2603:10b6:806:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:59:28 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 16:59:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Breno Leitao <leitao@debian.org>
CC: "saeedm@nvidia.com" <saeedm@nvidia.com>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>, Hao Luo
	<haoluo@google.com>, Josh Don <joshdon@google.com>, Barret Rhoden
	<brho@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Thread-Topic: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Thread-Index:
 AQHbQY95SClr+cbj4UuvTBfw6jI/QLLioPuAgA3rQoCAEu8ngIAKajkQgACWBoCAAYUSgIAAfW6A
Date: Fri, 10 Jan 2025 16:59:28 +0000
Message-ID:
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
In-Reply-To: <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8671:EE_
x-ms-office365-filtering-correlation-id: c70a3a1d-e921-4763-702b-08dd31982511
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|15080799006|461199028|19110799003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?z9RgJShiiYnfPaQ2V3V+MadEpR4gQHgLrNoLYXfhrbLniMeCvfQocwQsBGYB?=
 =?us-ascii?Q?Rrlf3sgUqyPHuxXKovxulDbebCrliZsEJ6+ByY4/QGKyzPmXy507HfdOU3om?=
 =?us-ascii?Q?8fSgrz3/MCxn/q7iyOQywX6DLESIKpuUiDh3LPMG5D6wrRhQoH9giCDCxmF/?=
 =?us-ascii?Q?mECcYMXCd9FBHXyl/IULu3gxTgi7CjcQdBl8opy6W5I39V1TogykZN6kT99Y?=
 =?us-ascii?Q?Z6HAzy6yVs2F3mZEPkxJEXqq1Yz1b5s+XJvoL8rW2hQPPHNvVfo+N6CKfqyY?=
 =?us-ascii?Q?RmnBIrOMHRypXfsAp3SlKNCzK661R9SfU4mjTb5FiZW2rDHUU1BTrC/ARTXL?=
 =?us-ascii?Q?l2t5bR0mQBIROE4MwyvzY7165ZTHIF/WK3BUSQ2fP+mVlRY/7Y0lQnpmtfbz?=
 =?us-ascii?Q?tLaPbS8F5h4IwUrWiVxA25vrNyvaSnnYe54NkmBnAYU1ssJsyJxEzawGZbzE?=
 =?us-ascii?Q?QC/nFjvnqOiXvm9dy0b1ooHIje0YR35CkQlBJjMfvjdh5KLBUq+I9RQD96uL?=
 =?us-ascii?Q?1ZP/5vpersufgqA5dC1oNxY3CM8bl2gJEXULueN+9vBf9l3qEgYRm8b+cuIj?=
 =?us-ascii?Q?ZgvF7ZPCyuKlfD2/AJ/p0635QTYz7UiKCj2kPrHTsATMWK2qPBAtlcLCqugz?=
 =?us-ascii?Q?Ej+pJQvRVjlfL/q1YU8AJZS/2SRUOqint328G1gp9IAHKVKLOnvlb9+6sdYM?=
 =?us-ascii?Q?x1W/OSV7Z/TAaBnd6Ez5OyTUZy+sPPd2s7VlYtbp5x9KU+2MId7pXNzxAac9?=
 =?us-ascii?Q?uLRGdZR783KreQRkjKi7Yxt0DE+YyaDHDIEGRTCYvJykj1FoJ/lc6+RKfH4+?=
 =?us-ascii?Q?aKJ84KYtiHP+t1294GrAgsLFUXyLGRukOwpGnDv4h7kRfn6FlStSvUAZ0Jzn?=
 =?us-ascii?Q?GYY+CY21PD8kZ9VedmKREyatIuB1NjdrLwizgaoQ9g/WyJMOaoMDq7ygFtf6?=
 =?us-ascii?Q?D2LnLbLLa6asnrM2WzHSW+gcbLhen2ZEuhn2H4RcK6F0eSjdmj6kiYS1kSEJ?=
 =?us-ascii?Q?3TKlYeOon4cN10+TLSRvH7ZRjobPqVvrJrBsR8HLV6QFoNc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K1weOI4+8eURkhJXrjZESM2EoZfugfbaQWN6VYWlWD6AjxncNxslHvEE8/qP?=
 =?us-ascii?Q?+gcIYMuLi1PHIE4DhM8JysF1NRh4WkRBQCHoR7oWx4U7hpOVQyY9FBtlT0l9?=
 =?us-ascii?Q?Rm5uH5t1xUCA0nkIB40M7DijljmtUjivdOc7sYeaCzW9MyxKnWTHpVGQ7gEV?=
 =?us-ascii?Q?w7qTm2akGgDNr4W0vBwo76JRTbIdzNcxJSQfhM7BrULxWJ6bDdVzFQ6Xq06+?=
 =?us-ascii?Q?zCIxsR0DF/LCZsnHzc8VcI6uBTNgd9okvrsZj4pnXVQb6utyHxuHMygf4ZNK?=
 =?us-ascii?Q?Xuy02cFUl1H5MMXcDtrRQ0Bzcn4lxg+cpVfMN/n/5g70IkydRdargMQLjd9l?=
 =?us-ascii?Q?2pkTxMabnPDVEFM4Uc6e9TXyV+Ub4dLNXoYPwvBlVpfxUklBtVrBW7k026Mx?=
 =?us-ascii?Q?sRIctIGVAVOmACNl165eQvYPg3+z4t7kGWmpk3NW4FXHTpX1uhyIc/F65L1B?=
 =?us-ascii?Q?ULft1iVXrTWTYktNYTb/eGYWa+RLas2PoQaM/Fg/5P1zn/9hGn/Df1wMLs8k?=
 =?us-ascii?Q?k2hlS62NDg/EUPFLLzpMrjrIuY2Tozft1qEXwHcf9h7GpHQ98O25ft8QTTV4?=
 =?us-ascii?Q?EZrSs6A8BH97I0P0j67Hu+pp1FekW2/XR390Sgv7KARAA5wzjgsU5QYHEe81?=
 =?us-ascii?Q?etvfbTkaxd4Bon4WITRtxVZoohCUawofSH5xa6Qz9YN9nyNcwnDcU0KnM6nZ?=
 =?us-ascii?Q?fHU8YXxXutPWcDzDcbj+YKFLdOCpltFCl2KktgGr21CtaYFh0TVmzj6O9IpD?=
 =?us-ascii?Q?nHQZXlJ9vMi4eV58RzozxdHDnwTwzOa1LR39HGrDorxZFjJqQjDIcAK372OZ?=
 =?us-ascii?Q?ZEdqNX+hAVTwgfqf0FL4Pz0Ssj93Gto0135L8uPG8AiNK0+m1Q590i+1vRV6?=
 =?us-ascii?Q?jcGgJxB2vAqn2ZA4gecpgfj8R8Jsq7ZlC30pVr6OhMLCPFkbQfzJwncElJ8I?=
 =?us-ascii?Q?+eWpFll+liVGaV7RiVHnZ0us1DP4oNvL4kZ6yq148PXVLqY0f7JMc/3mgIUK?=
 =?us-ascii?Q?N6Aj/BGEoJlggWstD6+52VCQ7Yaxz+55D9eJvZnNCp2eJuzVojtzWj07zEvS?=
 =?us-ascii?Q?bSYRy2cmkCGlEmb/ML2r+rm1L+90WWVx69pBp0VeZMYB/Cbb3DWXUuOO3E92?=
 =?us-ascii?Q?3JOcjZQq9Rg6tIXAB/3fjp5kZS44/Lnj2v3GjBXE02X+Hmr/K5kLTIxXNMAR?=
 =?us-ascii?Q?Nx85R5IlkmGUxuH+kHGcmsih905OHeJBID+1kOf1fRBkuYbK96em+OBR9/E?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c70a3a1d-e921-4763-702b-08dd31982511
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 16:59:28.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8671

From: Herbert Xu <herbert@gondor.apana.org.au> Sent: Friday, January 10, 20=
25 1:28 AM
>=20
> On Thu, Jan 09, 2025 at 02:15:17AM -0800, Breno Leitao wrote:
> >
> > I would suggest we revert this patch until we investigate further. I'll
> > prepare and send a revert patch shortly.
>=20
> Sorry, I think it was my addition that broke things.  The condition
> for checking whether an entry is inserted is incorrect, thus resulting
> in an underflow of the number of entries after entry removal.
>=20
> Please test this patch:
>=20
> ---8<---
> The function rhashtable_insert_one only returns NULL iff the
> insertion was successful, so that alone should be tested before
> increment nelems.  Testing the variable data is redundant, and
> buggy because we will have overwritten the original value of data
> by this point.
>=20
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedu=
le_work
> outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..e196b6f0e35a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -621,7 +621,7 @@ static void *rhashtable_try_insert(struct rhashtable =
*ht, const
> void *key,
>=20
>  			rht_unlock(tbl, bkt, flags);
>=20
> -			if (PTR_ERR(data) =3D=3D -ENOENT && !new_tbl) {
> +			if (!new_tbl) {
>  				atomic_inc(&ht->nelems);
>  				if (rht_grow_above_75(ht, tbl))
>  					schedule_work(&ht->run_work);
> --

This patch fixes the problem I saw with VMs in the Azure cloud.  Thanks!

Michael Kelley

