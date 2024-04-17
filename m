Return-Path: <linux-hyperv+bounces-1983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD828A87F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65EB71F21349
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A8143877;
	Wed, 17 Apr 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LpRMZR8/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2069.outbound.protection.outlook.com [40.92.40.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D038DEC;
	Wed, 17 Apr 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368634; cv=fail; b=h01eKNknPwLXz0yc0lVBPlhDH79owH+GPGH26GloTMJV3st7LneAETnB2mPcJkL0VtP0mJo1rWtBgezOsYeROEC2fB5nEvQ9dlII4E9GLSsuEDoYYSS3iDBEZeikY8yo6Xkcok6HVeoIIcnfNzPB48nsD1ZQ+L7JcQcfGzjjFyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368634; c=relaxed/simple;
	bh=CXh5jlFXtMRsKjBfX5XG78HbZteOWOtMgHMrzV4Xs/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dd4AWTheQtNSur6ZrgYAvME2oQYB9/VcVbbxc3aqhcS5JMemsRVUkZF2mTt7uEf53AWHYP6G1WyNKS2zWPqAvdirVX615pATi5a/Ak2OoSCGS9jXFz00Oj/n6VuZg7FK+Aj1PiEyQ2JGQC4MGuoQX79PNUBcH+ep8rh13d+skR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LpRMZR8/; arc=fail smtp.client-ip=40.92.40.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAmJbIaeZ2TYRu2HCmr+mCjvH/bpLQb02NdnDBQGqHv2hZGlCbNWXmjj6Axh8zlpsoVyYoYTJfR+tPxPR3oqsvZynvqdycGaRl1bPNa/1PDNhF/DhzF++NbVkVEXYr+GuyCo8ovLn+bduUf7lfzZvnkUV8d4s7LB8yvvQEFQvVsz9h1sgWA50RqsyibGwI/4osfLA5h5koeMhmiBGyTjJGJxU6vdDSI79zPHiKfKG4F+EJDAcWcredcgREd+fSn6bHKU+C54CQAR7BrMfrcTUQynjlVJlTBWpt6A9dpbJ8Y2PU3VjeDdzDAZxWYtPobkgvdjxjemfsNHOCxzrVcc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+4ZJ/Raujh3Ya6fv1WHoORjsMKHYaanXs0J2KRtWtM=;
 b=WaaOGVwdVDFHU1WurTuufgHSsUYlOJLB+JEYy6BqiUNVKdR11kXD4bJypIi6apYw+1AbW+c/X1nkioHcglKmEFau+3k/nnyqSjCin8q4OzRWuCboKEnb70j9XoX0563j0pVBPOVEuDDQScK2If1aEFd7P+dbjCNSpcmKEgvIpS+9qFdlWUHzyZLXVb68sgbLqqm489aBWMxDYluZnf3BJL1NoK44lRvG6RqWUnqGNdqfMpAZUCvAMFwBNHBIb5Vv+lltr2pLGjgQW0oDfyERpZHSmUmMl3cg6uEqJfnYnNR1oKGJCtg9XrCgjU2lHay1RYMevmVOwP/YgxE1bOjoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+4ZJ/Raujh3Ya6fv1WHoORjsMKHYaanXs0J2KRtWtM=;
 b=LpRMZR8/CLkLWTS1naTp//3qvf2SGfptaN7CqNDuyeYzjmKr6amIKHd8/8sdiWtIXUvnivx62MGz42Hcu1aH55dmVdzV/uw08/z6SZXmaSmxyUsrYUh1unJYh7/0mtwaiUBn1KGsyDcqmwrrxHUdJiVmB+YhaFA4R53Wl/LNOcaUaTxawcozpkdORmWVzyaNc1jIkQHDqoo6wI4FhnjdgfLg56jcoCKfIbEaxswIfh97ij2GGyH0Ri8nv9a+N/23PQBHzAbN4SVsD48MM1OmLjTydZEKXSfcv7+B3MGE8tEwDIWSlf0JBHvPFr16d0yYHDq3NuqC48I0SuFnunBofQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ2PR02MB9894.namprd02.prod.outlook.com (2603:10b6:a03:537::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 15:43:49 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:43:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jean Delvare <jdelvare@suse.de>, Michael Schierl <schierlm@gmx.de>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: dmi: Stop decoding on broken entry
Thread-Topic: [PATCH] firmware: dmi: Stop decoding on broken entry
Thread-Index: AQHakNyeQHU2XdbvxkyqvOE9tFpqPLFsmKbA
Date: Wed, 17 Apr 2024 15:43:49 +0000
Message-ID:
 <SN6PR02MB415755044A025D66B4BC8955D40F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
In-Reply-To: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [elEnpwY/FuEeyEiyGNASYtEkyZLiR6VA]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ2PR02MB9894:EE_
x-ms-office365-filtering-correlation-id: 31262e71-8338-4f63-beba-08dc5ef52cfd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hCCW1j9X3QKY5atkmSND7w6YEfcZys9EV8EfMvgoDoLL70I49ypKIizh7P6j7d44UWnskKDgdemxCKz/rkMwIrT3Ox8DeW6Y/vkY1QgKYkY2FoOibVPYDt9CI1GJI4HDCVcC+QkdVbEGWnj6CrLXj7BgjYxy+ScsHFCfbdiLSO5A00jjRUsdiRh5bhTIxAH2ynBsjhrLvkwT+9oyDW14rnhP+b9MbeVbXsjDrK3czXVVV8QZffTB4IsNg/l3egpslg9kpmcOcl53Th/CKJnOocuB1Yw1X2ZIh4NHcX4hOnac0f00TwmVRtuJe1J+0JSUFUtqxy+sN0r6W0+Pri/Pclih7Oa5zkp3xmcxPihKxnzTSA13Mkg1q72b0gWKo9cz1mj8gKYWf1hGaZDaUg/AejDlZhdRXEq5mOXdW7OVR8vI3UrTsr09YzbaXnMEayufoFzIxmWUJiR9ZovxRBH/QNcy7rGVaIkADMVSuKRWEKsCjeEKnAvfJUjb1YmCFGi0Z6hs73tUTk3kRoNtlLqMEgcMme1SJM89L6XQHlF2cp9l99NnwjbmzxmPNnO31DlsC9WoocxbHG57dyNdi+cBFVSot8bAnazDUYby+QLxzRCMRHeoH2WjKYy6D9AJalwpqdPOofXVxSErqprqByJsJ/Oj8yHLT+VcCZJBRuvaOVY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kHXGmgO3TNYTX9iw8ZF125FF2sKrp3sHRf/LO7pzAEIaryqvlT1GogSuFINJ?=
 =?us-ascii?Q?49k7em7KK66FL/UM7/03H7v0UqAgQy+79oo2g81S7sa1JUkkukF7p4DmrtWn?=
 =?us-ascii?Q?qXdxmyyS2Tcv+B+N12yCIldWTOkIvateqwGxmmIQf9x6y3XxFL5L/U8OJaVc?=
 =?us-ascii?Q?bIzanrUmBF6XlLHAbnvMIL0bY3E4EPgAvu/JCFVPiVUs7X7A2eVzV1p1dEiE?=
 =?us-ascii?Q?ulE6Cq83yKdOyRiN8b01FWHPvrPQ0hVwjFxsWVO7Y2HmTBiLCwCAX4Vyv3aX?=
 =?us-ascii?Q?Qc+VGeum/dpkbl/3hWpqcJiTLDjedWPmVwkL+798ezCdy6naCNOkR8RyjXT9?=
 =?us-ascii?Q?cLESdJU2mw6X/w2rCb8DIZrCiBVK3Ap9aPRn4qiQ5w8/0CuuYxjwrYRymCsu?=
 =?us-ascii?Q?0bwJmVW/cmTXhP6B/2tVJKmf1r/yP7+9IuaTkz7zJX74xgpYulFuCOVEiCgQ?=
 =?us-ascii?Q?qIznLq1hnyD3qKJbQndNAvaTWsd2NEYJK/H3Ok7syutvZZBSKL9WS4OS6tSC?=
 =?us-ascii?Q?mfq6VlGx/8p1FdvKSFvXc9qkDycw4Qtv/HXKEoCvtkVVsTsoovkOQeYZodG/?=
 =?us-ascii?Q?6MPbPfF5qPhz2GwYuO4DychiRGIJC0gaxaBQcfIBj+XpiXIlXxm+ecjK0+FQ?=
 =?us-ascii?Q?kCHGVLNCtQsyPY+H3h33kguADwEKK8F1pI81zTZ4YwMyS1QsRi6PtbP+hgFM?=
 =?us-ascii?Q?xcelMY1k1u1xwzAqiVaGHtmtKPKW7r6nUSFK3aBq4O4lnjVwlenuxnhPW1we?=
 =?us-ascii?Q?53ZG2/AbHl73UWHV6iYX9W4Z8rykZWH8EsOUaBusxAJEOwawGfS/KUig65xx?=
 =?us-ascii?Q?bzaZywJTm+fMXVqNGt66nPeUqv7d3U/Vy66uyFmaOq2aMyH4YpONLZ5mQ+wX?=
 =?us-ascii?Q?IvNZ34rWQQYZTkJnsbHSUAU60QlLC0nkb6KocOmyHIYjkH8ycyOXbIYrrrfa?=
 =?us-ascii?Q?2Ro6aPUKE8COwr81swhW00JpLuKMUl3h0D4q94fNxiwMPX/1Dm/qDuQpI4Nr?=
 =?us-ascii?Q?35oxtUdlpVw00ubkwjHnSBqXrWWGwBWEtN/q1j7AZPGRQfrz25VNwIYudQdP?=
 =?us-ascii?Q?I4O5AR0gzuQB8obJPbu9iacLyrbYfqercGEIfowsL698o+cT1JoIi4wGrIUm?=
 =?us-ascii?Q?Fg6R3ubPRcYQI9OBwEvekzKFvubbFbGSlW6Oj0j2BO6KEwfyzVg+YZZ2z8lT?=
 =?us-ascii?Q?+QwLftQQiXfsP1TqW/I9y1t5TvEEYYw2oUB6Iw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31262e71-8338-4f63-beba-08dc5ef52cfd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 15:43:49.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9894

From: Jean Delvare <jdelvare@suse.de> Sent: Wednesday, April 17, 2024 8:34 =
AM
>=20
> If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
> how DMI table parsing works, it is impossible to safely recover from
> such an error, so we have to stop decoding the table.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox-=
debian-v2/T/
> ---
> Michael, can you please test this patch and confirm that it prevents
> the early oops?
>=20
> The root cause of the DMI table corruption still needs to be
> investigated.
>=20
>  drivers/firmware/dmi_scan.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> --- linux-6.8.orig/drivers/firmware/dmi_scan.c
> +++ linux-6.8/drivers/firmware/dmi_scan.c
> @@ -102,6 +102,17 @@ static void dmi_decode_table(u8 *buf,
>  		const struct dmi_header *dm =3D (const struct dmi_header *)data;
>=20
>  		/*
> +		 * If a short entry is found (less than 4 bytes), not only it
> +		 * is invalid, but we cannot reliably locate the next entry.
> +		 */
> +		if (dm->length < sizeof(struct dmi_header)) {
> +			pr_warn(FW_BUG
> +				"Corrupted DMI table (only %d entries processed)\n",
> +				i);

It would be useful to also output the three header fields: type, handle, an=
d length,
and perhaps also the offset of the header in the DMI blob (i.e., "data - bu=
f").
When looking at the error reported by user space dmidecode, the first thing
I did was add those fields to the error message.

Michael=20

> +			break;
> +		}
> +
> +		/*
>  		 *  We want to know the total length (formatted area and
>  		 *  strings) before decoding to make sure we won't run off the
>  		 *  table in dmi_decode or dmi_string
>=20
> --
> Jean Delvare
> SUSE L3 Support

