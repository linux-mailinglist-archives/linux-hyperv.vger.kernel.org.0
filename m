Return-Path: <linux-hyperv+bounces-2257-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44048D3C69
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39431C20809
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A81836DA;
	Wed, 29 May 2024 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AovK9IGB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2105.outbound.protection.outlook.com [40.92.44.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C851836FA;
	Wed, 29 May 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000161; cv=fail; b=IgfQDgqUEJV5G8F43imbroWfWrrdOiF9Y3jncxUHSS0aqkE/ToH37XiOZQ0DR6Ip9IEp/jdNlnq1LxkypveNmro8JZwS4doe+0c9bmdZE2aqyQN6nTaKw5lxV5DhL50m3FJhr0Q0jXL4kvlXBBTA6M4a7ssyyaA7MOGnYfwbqp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000161; c=relaxed/simple;
	bh=yFAGUgu7E+HmIBAhjf1jD+2MjD7BK5ajHyHo1q6TqbE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJMWhsF+DYUyV/f+bvWM+x4QmWnkY3Vb+6No2R/+QscTFrY9D1seOTNXq124XHF7mYOgFZOgi+KV7zFqU0grXeCp9rmi54x0XiXw45vmSwnvZK824SmstnPXPHlcjmRZ+wik3+EgF6vglkHJy88SZyFegES3U8ao56gVm1U6KUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AovK9IGB; arc=fail smtp.client-ip=40.92.44.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd3CoOR60ZrTcWJp/++Yo66OfopNGJ2cGxSW6t/NgQ2XdMhJhmTi/+3f7jkGK4LjD0QPPxROVY2jhQa/cNW5mUqQHQqyNTugiSWNMQ4OwvfVEChaiUOlKenBj4/W9Q8iTNFMwZIN2NTt51xM/ewzL50a6Ci21Rp5o6ngJLHVot+/S288N6FJ/h5wuG2zoduDlvG/s2Ce14C4Q22y+mtX53E7d3VRDNSqL3GLgZ0uCje4ok8cD4/NETkppzboRFuHnC8i1+xhG3N8mp5tZcohHyMeAXgv5gDS6eXDxIcqv6nr71n+/L2umyu/SROl7bfvvGjptgq9wnUKTk9F4IDhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6neLBZV6KYmHgmG767vB0nCQfhMAQSKYLDFcOdKEPt8=;
 b=JEafn+qX721iJ6Cb3zaApzZIfOFl7bMfkFOwjvl6MMe3sXjkeDqKcauggwjNd/sXnyxmPKJi9n5nuVtceM40WgCyKxawCOcho53g6AfnryBAXOrkHdtpzsVRPfdJeB3DsGP1HHjsCMFds6HsNvzftK9ZvgSgZ5TxOS3lpRdM1z7TItDJdrUZ3Vr1fyAuWyPOO7k+6mzS7/vpuulrNAgAybZYjFffmfzTUG341A+WYSMBj7vvLg8t4Ksh9j4Gyu9gkIok0C2uhjf3KFy7vH0phbcALnVEmMrsoxHsAJN2j2nZuwr+1Gu3iHNgt1jXPdmE9EHo2agPs3EeSxR+PCppyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6neLBZV6KYmHgmG767vB0nCQfhMAQSKYLDFcOdKEPt8=;
 b=AovK9IGB3kguANvxFCS25BpuHGo2AsTlao/P7fmWwFr3Pc6wJ0ed7mA2O6kAO0g7zC3Ub5qMto6B4/TxtE0/xnPet/iMxsEQixgzDFIJGYrbNIqz/m5fTtQugIMCTSyMQs6T5HTvZpVD02WQ8l1rOJk/1EVkjwXIXph6ZworyelfB+uBSz1iRcdci3hEg2Xv3y88XSuu21Sdwpjr4I4ad5WRYHRxMEo7raKfv7Mt2HiAUg1XPj4nNy7Osbi/s2AFz8zJ3MlSQ0dTvKcHl2QxUDmTZF9tf5G2zP6pb8bC6j8krEF8TJh31+E1lObWzCcTDIKiZm1r7IFgykT/vbrzDA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9582.namprd02.prod.outlook.com (2603:10b6:208:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:29:18 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:29:18 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>,
	"adityanagesh@microsoft.com" <adityanagesh@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Thread-Topic: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Thread-Index: AQHaseJ69t/2vyNxWkWkqbj5I7HRCLGuZKrA
Date: Wed, 29 May 2024 16:29:17 +0000
Message-ID:
 <SN6PR02MB41572A8E15A990EB162C60FCD4F22@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1716998695-32135-1-git-send-email-adityanagesh@linux.microsoft.com>
In-Reply-To:
 <1716998695-32135-1-git-send-email-adityanagesh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [1kgsHnhazKmnHjAJbQfRzb5e3Qkv2LuI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9582:EE_
x-ms-office365-filtering-correlation-id: 8f555280-1bb0-4661-a3e6-08dc7ffc7ca1
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 DgL1dPNYLkxn9tmYG0aKTesY4kO7nJwfC7xSrnlLqS1yxlLKRrDD4k2ouxNznZCBhrvetzD3qB07MeqikgIvFSPz0bIJv9R0gky4o72wI+lW0ngAOPRp6HIukJsIZR7NGc+0e8r1FBVQkq//hjnSaVW6IbNQ/HXzADMivTKr+VjzNOCdWYuTcuMWQqMvclk9VDKEfjkpMJ0LjSkRep1BPTGC8q9lSzcFAqrmkm8+hAed0w/oAXh7XKmjgzHoFq00eM5rmimGD3hBChQArzOUngzd2l+ChqtQHlLo/jwREhAlCNbR83qMPXR77ow+EPmutxzAUxB9CGbzHvTSBQ5jRhFLD0bQHOzD04nlX1JhpYxfktQiWYEDjcJlJM/fbJrd8kQFIvDXlW/j4wUENdSpsgda8A20V4ULfpYYgYHIcy/3AbnTFwYtEICbpppFv1QosvOPiT7fzuqlQpVzOG1FtrE38Vsw6/g6W6C7vd0F/Ygc+EvqmeevNy6XYHcOemQAcxFXvZGxk7o7tgTblfDNUC4MN/B12Sn/C86ALcI0pl6cSi77L3Sm+TWRxTzjVppu
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ocTWdRznMtBUGq1YHSb8t1kBVLFLb4DTAwtapTobvgSMw8xpxiLqZxNMZGp?=
 =?us-ascii?Q?UEeuLOiIljiIljT5HR/6qgq7sE1XrofBiaMrBmY4LzJWbBEl6mxvnADq975T?=
 =?us-ascii?Q?FaZnuzLv4ESSGdUwlOTAPccH2wfEHm+38kZ82V6n9ioGSMfe8vmjtcZZK/Xr?=
 =?us-ascii?Q?+fkDG5s/WpixLfxHpjslXC5bEM0UO+Ah8mdiM6YXeqU+dmYtNfQfCiMEb3Wd?=
 =?us-ascii?Q?MTrzSEwTstMvAnGX8Yt5cQ7EeO7G0kbZ4MMfnOteQe3Fbek5ueatWpZ3XLLy?=
 =?us-ascii?Q?VSLguCIq4hKLXxq1Cuxq6YokRW3VZmrLELBO49Jr8cq1uz2bKs9O4T/Sn9Xs?=
 =?us-ascii?Q?JZbVYfDa+V2FKtRyhX+mq2k+rVoW1FYQWjnwfsGVKajB+A3LBPsPGlu1HtSW?=
 =?us-ascii?Q?EM7Zi1OEQvWr/C89HcgS0H7usR2VEp2Azhhqifv8qZXBC8ViAO5JiWUY4orG?=
 =?us-ascii?Q?AgmRv/l/0kes6wy9PYYzSnypcKYsatA4L8ffADqHCheN2E+lKZDUczqx1evr?=
 =?us-ascii?Q?jInK53dFmhXHhdhHXgsmD19p+8XlwFDV+PZyYa84GyHy2vYxjOHOaChg/l79?=
 =?us-ascii?Q?rwGtDIrvOtTxqQ0lH/33B5+lKviIPbujGKQ8ki3+/728FEJQEFCrDQ2VxXOd?=
 =?us-ascii?Q?63US9e95V2jSzFU/gcB3grgJJa7tYXj25CfB87TURFnUTY9EFGnuNYgmYAq9?=
 =?us-ascii?Q?g2fKDvyLGtuHqaUOr1R5aSWFZnnywkhbgT7rkia0zFTn0co5mi0024IWv3wh?=
 =?us-ascii?Q?fZ5eCVD1jtvo0tuXMG+9FVy0k558wTBebBeqkgVm5WBop2DcBqVfraN3GPtG?=
 =?us-ascii?Q?u3N83cwlCVhQI5Rcl5WzWaad2NAbwplWh6kP06U+XBCx5n5fUI0wUOkqlKHz?=
 =?us-ascii?Q?LkkP2rvQqkv0kmtAv63ImUU2cUZIZqfc5a0lvNhuGgJvZyVPbZMuS9UX7ZHr?=
 =?us-ascii?Q?oAcNXtX9N4FRQ6iKEt/6bN3wcCYNkXGeJhk/pSuWzKLQpuO2HOQhr2KpDaRA?=
 =?us-ascii?Q?iofgutvTw2CdRwhqbRqHmGiirzZnlLoUfUx1oDTLchkUBKHUDL8hBV/J1Bca?=
 =?us-ascii?Q?U8BgHcRcT+D3eWgr6Ez/ISRPM0JUOU2DjzjtIe9VsMPb99MzUCrcnUDvBYuW?=
 =?us-ascii?Q?IfM5kPQf4BT3gfXAOS/R+f97HcuisiWpVn0hEEQn5di0R1j5Lh6xfgh84VeY?=
 =?us-ascii?Q?ZUVTTQpKLFgjC4x12y5UfMdycvAfQPh71vOrfwQE7RszRCvr5ZQUrVy++1g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f555280-1bb0-4661-a3e6-08dc7ffc7ca1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 16:29:17.8976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9582

From: Aditya Nagesh <adityanagesh@linux.microsoft.com> Sent: Wednesday, May=
 29, 2024 9:05 AM
>=20
> Fix issues reported by checkpatch.pl script in hv.c and
> balloon.c
>  - Remove unnecessary parentheses
>  - Remove extra newlines
>  - Remove extra spaces
>  - Add spaces between comparison operators
>  - Remove comparison with NULL in if statements
>=20
> No functional changes intended
>=20
> Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V5]
> Rebase to hyperv-fixes
>=20
> [V4]
> Fix Alignment issue and revert a line since 100 characters are allowed in=
 a line
>=20
> [V3]
> Fix alignment issues in multiline function parameters.
>=20
> [V2]
> Change Subject from "Drivers: hv: Fix Issues reported by checkpatch.pl sc=
ript"
>  to "Drivers: hv: Cosmetic changes for hv.c and balloon.c"
>  drivers/hv/hv.c         |  37 +++++++-------
>  drivers/hv/hv_balloon.c | 105 ++++++++++++++--------------------------
>  2 files changed, 53 insertions(+), 89 deletions(-)
>=20

[snip]

> @@ -999,21 +984,14 @@ static void hot_add_req(struct work_struct *dummy)
>  	rg_start =3D dm->ha_wrk.ha_region_range.finfo.start_page;
>  	rg_sz =3D dm->ha_wrk.ha_region_range.finfo.page_cnt;
>=20
> -	if ((rg_start =3D=3D 0) && (!dm->host_specified_ha_region)) {
> +	if (rg_start =3D=3D 0 && !dm->host_specified_ha_region) {
>  		/*
> -		 * The host has not specified the hot-add region.
>  		 * Based on the hot-add page range being specified,
> -		 * compute a hot-add region that can cover the pages
> -		 * that need to be hot-added while ensuring the alignment
> -		 * and size requirements of Linux as it relates to hot-add.
> -		 */
> -		rg_start =3D ALIGN_DOWN(pg_start, ha_pages_in_chunk);
> -		rg_sz =3D ALIGN(pfn_cnt, ha_pages_in_chunk);

Hmmm.  The above is not a cosmetic change.  Looks like this
delta was erroneously introduced in the v5 version.  It wasn't
there in v4.

Everything else LGTM.

Michael

