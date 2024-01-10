Return-Path: <linux-hyperv+bounces-1413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F782A3CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 23:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA21C26797
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7204F882;
	Wed, 10 Jan 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CQ3uNjL1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2099.outbound.protection.outlook.com [40.92.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2E4F1E5;
	Wed, 10 Jan 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdZcJ555afit3bQ0gZVOzN9i8ZBotEkSTknX4mxIxVRTNxOVav8WMqbGUIhrxG/tdcLlVaVW1kBZxfrxxcyeS8IwttxwXqoCCR9Z3PT7BjpNpKoUb1EjiOKcL96s0YSJC5i8xU5oFz5DvMSv2wId7Gi7PssoS9U4ASs+FITRP1zL6ZT1+kYOWmhW/1JjYuDhouszBAorliJhcvarQuIOiVH9KVkyH5PTsx9gfwmBxJK69Ie4euIm+S1QoJOOMarbG2fl4XETtmXhH7yiO3bSPik5fbty0frD8Cjbg1Sej66YvwJm9F151/5+QjsQib559QO7ikYQxI8mxVS33nE/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46iwDve333VEzAk7mIsqsvXOMlh9AlR/MUYTnYkOn5s=;
 b=fa03yf/Qr0n15pl7m7dJEkCOU0aIBpg9yCzpqFY1WhO23KUlebqKsZPVMuwiJsPnb6PONrW2cIgqYARfTZPvotIsn6kPcGCEDHYUjw5aDwNDQFbBhyLooNAfLwnxQl5IVnqt4zXsEU6rLjCA8saaqb/pVo6wnxDQ/x79eSLCyl7PAzGJNU12QHl2zwQM+DW+LJgoVMNnclCxAof6/OqNs8MM7Hstjwr30myppFszZKfbrFTn3f2jTORqsjSQt6lyO5YelMj/guPa0XcVNzrAuqh90/ZbLwRfuWMAazS/vGb2QrQlOf/Z9/WI83GcJnCDZPsqDGN0Us4ZnDKnckzJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46iwDve333VEzAk7mIsqsvXOMlh9AlR/MUYTnYkOn5s=;
 b=CQ3uNjL1G/Lpjd0P3F0zFu2DxUoKLLCHMDqHs7082Ycq3kajq7IK7CfKQYo9jfr3FlG0elFW/vWh/mMHK0PzsmFvy0MWunjqEmCrHpgyZaQRnLK1gU9M6pwDTrLK8hl3YliB1ZLH3hkecK9wxwJbFOXMkTnrPl4WUQ24L6LhW0FQL7aW6yTuL/BfzPOjSStiEklTIeW+KU1SVLpwL9Tkv/CEuRryrDqGd0kjVoeaUAb547i3CrIQQwRqDpfjhYJxtIJMaLWnl09CzPtZuKSULiXHmforePJ2UuIANGu6TqMEgAU5burOADxZK+7pgVbZJi7X8Kp35qkTxFiYzneeSQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO1PR02MB8619.namprd02.prod.outlook.com (2603:10b6:303:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 22:17:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 22:17:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Markus Elfring <Markus.Elfring@web.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, "cocci@inria.fr" <cocci@inria.fr>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Topic: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Thread-Index: AQHaQ7PyvvrIb8tUYUye7rRKlkvVrLDTNj6ggAAqigCAADt1QA==
Date: Wed, 10 Jan 2024 22:17:17 +0000
Message-ID:
 <SN6PR02MB415710A52835BC82B1FA1EAFD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d3c13efc-a1a3-4f19-b0b9-f8c02cc674d5@moroto.mountain>
In-Reply-To: <d3c13efc-a1a3-4f19-b0b9-f8c02cc674d5@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [9Bnj9+onyGg/XP3kqltg4msot4eUqsM/]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO1PR02MB8619:EE_
x-ms-office365-filtering-correlation-id: 21cc1c4c-ba3b-425d-8d1f-08dc1229e7d4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xqq9BZIkQOntMnpTxJhV1yvUk34jWlchMNgQSKd8NeKnLJt6Onzo+vh7RzERCfBRD3A2R68TtMPwJVq4R3PiGbPVvph0W9EyV1Krtnmp6Zwj/iKMoo8vTHNpz5SxPt8Ogt9bXTF58WQXfbX7CjvTZWyCXLC/BkR2ykg3kbpWXiMuXFxi8Z9ch3YNyTjqMDqlwt/mZ4WLZ8eJrrY2K5Y6iEH7fqdeAUmtQegzdiPi1V4fWeqzdrrKSAIgHWAc/tCEjx6o9qHgIZ1lnlygNn9z/e0kDyqA2prtUjIdniMz3VcIZrswLLG+AIg1OGtj8oDLQDMWDiSEo8/A5ACOctxZKOvCKEkwy+xNYP5rklNcTsSqsulq6tzmkUgQNPDOlZXF2CuxD4VhOVD5/0pyJX1FGDanEQl2TbZpmT3gFXQ2QUcgM52nELAodLmhk+qcNgGie3M1cBOg8Y7fUGsAm58szdawDs2SYZAsHUI68py5H3kg6xl5Zjr2+CmVJLV6ldfTd8PCjQc1EX3NIXppCZLYpnQM5Y64fZlDjHT9vyht457j9cF8SaZRS+j/CMlQizG7
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?owCur0JVW0jvzPDWaN0tI3QKkG2hSWDSwvgoH3imqVS2ObAbQv/hzrYVk5NC?=
 =?us-ascii?Q?6VbuI2OjTlPY5SRX60aaNybj6hTAP6N5oGG6ldcbZJSmTp+RdJJovXu6o16M?=
 =?us-ascii?Q?EED8WkzTG9kctPoKrULEVCxHAvPS+qQhjy//ZcIrOQe8hRC67ojswDLzrknp?=
 =?us-ascii?Q?XDcT+6xbFTdYNq9FyvITq8Qc9mV/NC6HtC5Qu3LLA79PkFwj6sCi8NvPLugo?=
 =?us-ascii?Q?pVFh+Jqs816rcOo3VG+VWC1fwnztyOId7oqpNVcQZlIe7AIWUhNhGxLzGdpv?=
 =?us-ascii?Q?dDg3VQZs+jcYZwuFTOcMfFIBd/Geni2FHTj2RhzDXIdtUZvmL5nmDf3dQv3x?=
 =?us-ascii?Q?SltdDIXR7nZj6MSbuAhMGNV9IVdSJMJGF/2AZUEnujc8HgQ1fOkhYIMt0L3H?=
 =?us-ascii?Q?gHMBKgJb9fM0P60ZOvo/+Jrlg679eg3GBiN7+WGnD0oX22hvJrLtEJuhDTpr?=
 =?us-ascii?Q?/AHnqt/uV98Ri/oUXoKggeMWFYzNzr+UyRVYfRaOfNyYcxZc5ct7T9+5Bxel?=
 =?us-ascii?Q?plUYfx9Pf+R9cImpVnDT+ahfRtDUB57CCfy7rE5Fv148+GwqRoEKTRX9Fb02?=
 =?us-ascii?Q?ueqmnmCv4Lo5OGJxrRZ2RoL7DNdMxRdCD9wWoszoJIS186proCvW/pH8iqJH?=
 =?us-ascii?Q?R5TiReHfyalJ8FE16bSOxXEMQGKuDKRZxHn059rdJx3KI3A91AhwH2/eNEXn?=
 =?us-ascii?Q?0FGHxBCt6ik9Y6L7tnw/UquXoh3CFDmAjpePQpzwG0CZ7HyFEbAb7aZ3eFym?=
 =?us-ascii?Q?CdzSRpzi2Ae5BEycGG1v/lx2a4hV6+B0mbqQxBVjbB8ev8T33geS+S2Ya5x+?=
 =?us-ascii?Q?v0WGlo9lrtR18qlvvu8bHh0/oAgd/h3Ojoq8qthG9uBYDa4ME4P1GB97S9uW?=
 =?us-ascii?Q?J/P/2kj+Auvbkw1/n8AVl6RGR0g56PUm/L1xON+R4hYpul32xXTGy/ewiUJV?=
 =?us-ascii?Q?k7s6KlJ3HXpVZTXa0oVwLoZFUAWnxReEO5ijFrv7OdgdmTrgBSUT4x6lXzFI?=
 =?us-ascii?Q?ZiATV6OatYuULNIErDboP88qFNz3iP3u+GYr71ztFFH5bzJoa4XpvxXv5sFW?=
 =?us-ascii?Q?rriUtX9GCeJiMKXxXtCgmYHYVXUEALtuFFProXzIwfi6wHIXS5NCZhqkWXIv?=
 =?us-ascii?Q?JzJaEUTGdUEaLYGRt0nZwIMzmSkGaktNVVMxpSW/mBE54wvFoYm+UybBNjFR?=
 =?us-ascii?Q?dzA/YL6X+609KAPdwv6CJT+yBgxnyo4FufD+Pw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cc1c4c-ba3b-425d-8d1f-08dc1229e7d4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 22:17:17.1966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8619

From: Dan Carpenter <dan.carpenter@linaro.org> Sent: Wednesday, January 10,=
 2024 10:38 AM
>=20
> The second half of the if statement is basically duplicated.  It doesn't
> need to be treated as a special case.  We could do something like below.
> I deliberately didn't delete the tabs.  Also I haven't tested it.

Indeed!  I looked at the history, and this function has been
structured with the duplication since sometime in 2010, which
pre-dates my involvement by several years.  I don't know of
any reason why the duplication is needed, and agree it could
be eliminated.

Assuming Markus is OK with my proposal on the handling of
memory allocation failures, a single patch could simplify this
function quite a bit.

Dan -- do you want to create and submit the patch?  I'll test the
code on Hyper-V.  Or I can create, test, and submit the patch with
a "Suggested-by: Dan Carpenter".

Michael

>=20
> regards,
> dan carpenter
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 56f7e06c673e..2ba65f9ad3f1 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -328,9 +328,9 @@ static int create_gpadl_header(enum hv_gpadl_type typ=
e, void *kbuffer,
>  		  sizeof(struct gpa_range);
>  	pfncount =3D pfnsize / sizeof(u64);
>=20
> -	if (pagecount > pfncount) {
> -		/* we need a gpadl body */
> -		/* fill in the header */
> +	if (pagecount < pfncount)
> +		pfncount =3D pagecount;
> +
>  		msgsize =3D sizeof(struct vmbus_channel_msginfo) +
>  			  sizeof(struct vmbus_channel_gpadl_header) +
>  			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
> @@ -410,31 +410,6 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  			pfnsum +=3D pfncurr;
>  			pfnleft -=3D pfncurr;
>  		}
> -	} else {
> -		/* everything fits in a header */
> -		msgsize =3D sizeof(struct vmbus_channel_msginfo) +
> -			  sizeof(struct vmbus_channel_gpadl_header) +
> -			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
> -		msgheader =3D kzalloc(msgsize, GFP_KERNEL);
> -		if (msgheader =3D=3D NULL)
> -			goto nomem;
> -
> -		INIT_LIST_HEAD(&msgheader->submsglist);
> -		msgheader->msgsize =3D msgsize;
> -
> -		gpadl_header =3D (struct vmbus_channel_gpadl_header *)
> -			msgheader->msg;
> -		gpadl_header->rangecount =3D 1;
> -		gpadl_header->range_buflen =3D sizeof(struct gpa_range) +
> -					 pagecount * sizeof(u64);
> -		gpadl_header->range[0].byte_offset =3D 0;
> -		gpadl_header->range[0].byte_count =3D hv_gpadl_size(type, size);
> -		for (i =3D 0; i < pagecount; i++)
> -			gpadl_header->range[0].pfn_array[i] =3D hv_gpadl_hvpfn(
> -				type, kbuffer, size, send_offset, i);
> -
> -		*msginfo =3D msgheader;
> -	}
>=20
>  	return 0;
>  nomem:

