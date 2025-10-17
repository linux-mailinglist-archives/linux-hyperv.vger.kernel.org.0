Return-Path: <linux-hyperv+bounces-7231-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A9BE604E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 03:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E102C19C7347
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA1211706;
	Fri, 17 Oct 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qH6CuFvu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010025.outbound.protection.outlook.com [52.103.23.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58C38DD8;
	Fri, 17 Oct 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663587; cv=fail; b=PBLMhTdNQW0X5mOQ63tsWARmsXgCOYJC9Pm7bbhVZzQyq6CkaIOS6q3lOXXXZs5aIQ3wUWz63HUr/IFrK2xY70Lz2CP+dOtd+hqPBAXlZ5mVB3MIaKxtwGEY91EVlu+mJtBh/s04hqyWPXx/lOvGPGsPHwFyglhAOkxXjPKr0RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663587; c=relaxed/simple;
	bh=pKxLz7fSa6EFenDLFACgs6J9UO/UUaPZoWnph6SNfnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r34ZCVVm6KwK3zFxpvE09UE23jt00cyTpKnI/CRj6u/1fdt03ozsg/9IIYmGoAlAAleuUXccYMELyBvLqoatQPvDuRc6C0EL+QwSLZFWmE7Lmt4BRwqly0J7VHiK/o63cMevsVHqAZbcBXMFp7QSUSOsOKGp8lBorOq2RmyflkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qH6CuFvu; arc=fail smtp.client-ip=52.103.23.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N94Mkfn9sPihsF+Z29fq28AZwDDMPLbBaAM2U9ROEIeESOo5QSXKEvJXbH6q2iZ13T4qXpVEm9SeYF2Bim4LdlDO5h8W1L/DYN7bTn+vN8jeJZKKapS1uPjytNlXb+28Hw9km8AWW2LAK4tB2j+c+AUKle/tX3sbkUWGEQ0sGGcO3ZR0P4qrcxZbt1DM0YqY6ENF57ey7v+5yk6zTalq6XJRU8AoG2fr/+pN/+9lUKACBCoWb6ExOBWvJ6wHF4ry8WLZRsJpZ57hOFpAlebjPW0Fxm5OWIkJ6BZlcnKN5ts+ZNERzCmoODDb1F1fz3s5CAB/bNz2I7vEEynOukjv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VbbGFD5f5z6JTYgOfQ0zhNsvZK2PvrwjsHIRWX+wHE=;
 b=qAggR/kKH0QyQydQPTgtpETD2fNWHq6jbWuiaex2AtVQMU+Dt36L6Vv1S/A/1ASMD66hWgGAv2E7gD/6TpmxgdTDxZ1B84XDKu8UYI6RRtJpWyP0xBrrqhUdRD2JLjsKf/dSngTIyDje/rdUzRKmBc7W0ZLBNmTr+av+lrkOBecBgg8avGROhMKeDF3QUX5APNSK1Rdxza32YshGU27YfEvH6/8Is7WWtuxLYbL0wL/yiWWLrYez1X3ICqzTxx3c2eVD39zwxsUCsQZJhVg1O9/xZxbY4bJTWLfLd7d/GGNeUKcJkdc7AkHoq0B7Z/Ib7ajXz9SyTtIo1S451vRrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VbbGFD5f5z6JTYgOfQ0zhNsvZK2PvrwjsHIRWX+wHE=;
 b=qH6CuFvum96aBWzFoH8LshkE60Cs2j8yxHKDvbHULipuTXk+PW7YhYBBwzOEAJhYcFe2vE9YCUo2+lw2xgbxD47EHNPmx0kLM1LRqTCXMdqpjucME10l+sKYb3SEMxkDDG8lT6PKcALjpk6s6ujYA7XoYVTqb9I3FO6bug+ckBdjQwzXm0emqon13yNQAAt7oKFEv+onsAeiNdOlpwRzYemmFyq9UDUqSctC9AXYlvoCRtUadtZ6xF/7/ofGpLug8KHRXaRvU2BWVe0FDJgz7FnYLVinnm4FXhmVG+5AYotH2h4fCLJHyXVoJsD0VDEMiSaT10raezpocI/J0jKZMA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA3PR02MB10568.namprd02.prod.outlook.com (2603:10b6:208:53b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 01:12:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 01:12:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Topic: [PATCH] mshv: Fix deposit memory in MSHV_ROOT_HVCALL
Thread-Index: AQHcPtae4hOlmQ8RLke3rh0l8QIZ4rTFhImg
Date: Fri, 17 Oct 2025 01:12:57 +0000
Message-ID:
 <SN6PR02MB4157E6D02773A9D7A4B9E85BD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1760644436-19937-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA3PR02MB10568:EE_
x-ms-office365-filtering-correlation-id: 31436a8e-e833-4074-ec5a-08de0d1a4f25
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|8062599012|8060799015|13091999003|41001999006|11091999009|31061999003|12121999013|15080799012|440099028|3412199025|40105399003|51005399003|102099032|12091999003|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yDpK4jBjw+p1+Zlg2b6YV11vjkAgTek0Ohbw694hHOGgkgZFb8fo1Y8tWRyV?=
 =?us-ascii?Q?B8M/mohayQVfiM65oCkLuMcCnelQyfbv1E2xouyNUOEscoWTkiVu26UbbrS3?=
 =?us-ascii?Q?mX5o+M0C/882BkeRD/cDbRfBI3B3UGL3kcsCVzxvO7JVXWGLYSixldINUESA?=
 =?us-ascii?Q?eCFRV3cwTJFe3MIXAJwU9V52WViJ3S9UtaE8iTVh/cRKM4C9ahQhrp4xPbYG?=
 =?us-ascii?Q?jl74XOUPlYWzeNqYYw8grusKQemAbuaBaofV73PkfZteJs9GIWlXByTHE88G?=
 =?us-ascii?Q?CyKGriiNnTzeJ5QUtow9xuMDh8UyZ5o9efSHNYjRp+8x81CJmPM6Gy+gFbcx?=
 =?us-ascii?Q?M7vlxDdw96I/ULIZJVnVd3/QAKtijh7J5LJXzpXvZngMbNBBbwHVNibo5F2C?=
 =?us-ascii?Q?5gWszIyTnpQL+jkH/xXcnTfJdq4evUgGQhf6QjuD9CgIOsGy4JoLsPQ27k0B?=
 =?us-ascii?Q?WQKxhRydDOZR0kzR4C8DKxhVvFfqnRiH9UOYJco7vC5EtmsFWXUV5Ps8exYR?=
 =?us-ascii?Q?rN8f7pSnn3oDQmMnuHX4tP+yDsSdGhOYJv5PtGn1W+50+3q9AIcRIZA9Eb/k?=
 =?us-ascii?Q?GSeZ7583oVZG/aO4puXS+pM/hNyl/Akk53dr5k+1/07hAZqqMDWsSXyHPtWu?=
 =?us-ascii?Q?FA3wreWjZj8Bc9UAkvvpEsoHRdhqBifdisW31eIJVA9ISrAU1zES8GZU8ooi?=
 =?us-ascii?Q?ZnqFagbMSOJVmOXh7sNX3KD3wUJsABo6LM7C3xUDLRgUkOykD5BsObdNyu9x?=
 =?us-ascii?Q?vmdRgtoowxsZ4n6coUrSDB3XyQC+41bg5YQsRmurGv1ONZL3LP9r3hOjMZBz?=
 =?us-ascii?Q?TGY03tDcNvscn9bAJS5tCHBuPXqsEw+Ctx1Th2LqNJZTl8tHCNfSByEAoAac?=
 =?us-ascii?Q?i/tyNUiPdlVvBZ3abCVBN3MxK75uA4ZHJyh5JhJnBqemiFAcKAuWCljXlPtR?=
 =?us-ascii?Q?frbmGHACXx6CgC282NHLTJlVeSY4tT1LEKCsqx8q9EqgDDi7L/m0GkyyGrUH?=
 =?us-ascii?Q?TBazp4idjlmg6CTsRqt7NswXeD0liXh+5t1/pLSHqkW+VF5suC6TbYxLzKGV?=
 =?us-ascii?Q?bYsz0AGnLkaOL1BXDossG7IlN5ELJZT/+9UN0+dKLhaukZokchEVF3kmO5mO?=
 =?us-ascii?Q?4Lbhy8AmR4j28SE23ElvgWfBovl+j5zAGaSqY1oTCpa5y9oqIot/NW5b+LiA?=
 =?us-ascii?Q?GXot1MZUhbaH45hd8j/nUtTqOrRtQezkasV1NXAyklEDU3Krp103q/8nL+dM?=
 =?us-ascii?Q?jAsam8Vtzn1CvCzuKsxrvwh3MaQcdmX5lmeq98hCILaRgoRKd1UAUa4aPwFV?=
 =?us-ascii?Q?PrY/4IvFzSuSCn5Kyg04pm0Pl/b4OV4hNxgyMi6gg3AxlA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Pr85wrnB1IJvVTeFIOmP1c9m9d8BDO5S5DBv19W5tQEjVZuyo35iXD8FrCV?=
 =?us-ascii?Q?1eAJRMeLZZPNTKO7q0Kjp2mb8bvYU3TlGRk/+Gfrm7i6uex8aAb/hjqPOboa?=
 =?us-ascii?Q?HBbktCLSnJH0JRDb7pF/+2Hx9lz8u71GMfIcRQtprJG8HTWSpREgPkiOIsE8?=
 =?us-ascii?Q?3DQ6NUkJBgEZ043jHm6T17Zme4zqo4Vdp1dSdDD8l00MT2M13zZqv/e4+ysu?=
 =?us-ascii?Q?OPzFMR/b/Ei9VYqWVAHBhCWGUQ0tVQuxKby79DrS/PzJsw2wZjas7P761Bav?=
 =?us-ascii?Q?xGrxRMSrqtxdAYbxo4gCnqmPx0MxE+y/O/7X5ZWlDZvdYgJScT2n4r7ID9AF?=
 =?us-ascii?Q?Y5yKhv0vUgmhyUeF7xRDYD+jlw8/HM4vrNfZ8znu43Ar6wbwhRNjP3r/FWo4?=
 =?us-ascii?Q?Cngvp5JambeTUqW0zwIZ2VpV8H+CVo8MSkNtNJKxr7I8J76qlrZxQFLv27tV?=
 =?us-ascii?Q?jagfUrrjbSMt5+T49BWm8GTNPqgK5YZfwT9yTCEbk6yUaKtEdkqSjVq39srp?=
 =?us-ascii?Q?T/LMu+UpPG7xonBhEiQIFm8LuxQAGm48iE+IPP7l60XTcIpfUhJnddHrNbnP?=
 =?us-ascii?Q?Kq6Cxt0pgAcxpBsdc0p+CeWfgvPx7jFk7vSZRlOguVRm5JFTzPTmIIpCD9R6?=
 =?us-ascii?Q?kkppwVg7jPdLlXENSFVjZaEyE5QpJdwTCx5opjtisyCQB6969tnm73ZfeSPY?=
 =?us-ascii?Q?6jL1HENTmtv4Y0v2EluxhzzTNlbVDrzs3iOqd2kf8P965L7kEUGcnVPnXAWw?=
 =?us-ascii?Q?e7YyDGJ8Vtw8HoQCgEHBZJrXXDIWdsMkv0CjtGK+GtnKVoZN9AjGu1z5McLS?=
 =?us-ascii?Q?94CNznGW2VgNGxE4s0HFMKHzz/1NaCdK4w7wsb4OTqKcl/ytpQtn7u0urVzp?=
 =?us-ascii?Q?lcmz8TXXoAdYpHqJqp3U+rqzW577OB4urj+w17Fr/+rb+x9HeRnyh0MuV6Q4?=
 =?us-ascii?Q?/ofidHGHyPrtilWVSz4wNlGvlMEUwk4dlfYxFafi91qMFuGtqKukvhQM1REC?=
 =?us-ascii?Q?/546Qidu1M4LTZGdOYgmsgUHeCgL2BkHeFBEoHYfbLOgkmx1W5cMNknU9nbZ?=
 =?us-ascii?Q?Y0d8Mvbufij7lyK4tKJgM/plzdD/GyDc5+YSRQFCLSYws7Icq1IRHhLkiPsB?=
 =?us-ascii?Q?CysAnvx9dclS2bN+tQ5bIZuGDk2KY+udtVTkxHsD2q1sUwj/R5ev//FHaP+m?=
 =?us-ascii?Q?tQqSFIWgE5k9Osw0rq054YHzghIWVQLVJGcckPFKIyM+lCbh27P0m2B3xjI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31436a8e-e833-4074-ec5a-08de0d1a4f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 01:12:58.0843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10568

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Oct=
ober 16, 2025 12:54 PM
>=20
> When the MSHV_ROOT_HVCALL ioctl is executing a hypercall, and gets
> HV_STATUS_INSUFFICIENT_MEMORY, it deposits memory and then returns
> -EAGAIN to userspace.
>=20
> However, it's much easier and efficient if the driver simply deposits
> memory on demand and immediately retries the hypercall as is done with
> all the other hypercall helper functions.
>=20
> But unlike those, in MSHV_ROOT_HVCALL the input is opaque to the
> kernel. This is problematic for rep hypercalls, because the next part
> of the input list can't be copied on each loop after depositing pages
> (this was the original reason for returning -EAGAIN in this case).
>=20
> Introduce hv_do_rep_hypercall_ex(), which adds a 'rep_start'
> parameter. This solves the issue, allowing the deposit loop in
> MSHV_ROOT_HVCALL to restart a rep hypercall after depositing pages
> partway through.

From reading the above, I'm pretty sure this code change is an
optimization that lets user space avoid having to deal with the
-EAGAIN result by resubmitting the ioctl with a different
starting point for a rep hypercall. As such, I'd suggest the patch
title should be "Improve deposit memory ...." (or something similar).
The word "Fix" makes it sound like a bug fix.

Or is user space code currently faulty in its handling of -EAGAIN, and
this really is an indirect bug fix to make things work? If so, do you
want a Fixes: tag so the change is backported?

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c    | 52 ++++++++++++++++++++--------------
>  include/asm-generic/mshyperv.h | 14 +++++++--
>  2 files changed, 42 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 9ae67c6e9f60..731ec8cbbd63 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -159,6 +159,7 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_par=
tition *partition,
>  	unsigned int pages_order;
>  	void *input_pg =3D NULL;
>  	void *output_pg =3D NULL;
> +	u16 reps_completed;
>=20
>  	if (copy_from_user(&args, user_args, sizeof(args)))
>  		return -EFAULT;
> @@ -210,28 +211,35 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_p=
artition *partition,
>  	 */
>  	*(u64 *)input_pg =3D partition->pt_id;
>=20
> -	if (args.reps)
> -		status =3D hv_do_rep_hypercall(args.code, args.reps, 0,
> -					     input_pg, output_pg);
> -	else
> -		status =3D hv_do_hypercall(args.code, input_pg, output_pg);
> -
> -	if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING) {
> -		if (is_async) {
> -			mshv_async_hvcall_handler(partition, &status);
> -		} else { /* Paranoia check. This shouldn't happen! */
> -			ret =3D -EBADFD;
> -			goto free_pages_out;
> +	reps_completed =3D 0;
> +	do {
> +		if (args.reps) {
> +			status =3D hv_do_rep_hypercall_ex(args.code, args.reps,
> +							0, reps_completed,
> +							input_pg, output_pg);
> +			reps_completed =3D hv_repcomp(status);
> +		} else {
> +			status =3D hv_do_hypercall(args.code, input_pg, output_pg);
>  		}
> -	}
>=20
> -	if (hv_result(status) =3D=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> -		ret =3D hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
> -		if (!ret)
> -			ret =3D -EAGAIN;
> -	} else if (!hv_result_success(status)) {
> -		ret =3D hv_result_to_errno(status);
> -	}
> +		if (hv_result(status) =3D=3D HV_STATUS_CALL_PENDING) {
> +			if (is_async) {
> +				mshv_async_hvcall_handler(partition, &status);
> +			} else { /* Paranoia check. This shouldn't happen! */
> +				ret =3D -EBADFD;
> +				goto free_pages_out;
> +			}
> +		}
> +
> +		if (hv_result_success(status))
> +			break;
> +
> +		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY)
> +			ret =3D hv_result_to_errno(status);
> +		else
> +			ret =3D hv_call_deposit_pages(NUMA_NO_NODE,
> +						    partition->pt_id, 1);
> +	} while (!ret);
>=20
>  	/*
>  	 * Always return the status and output data regardless of result.

This comment about always returning the output data is now incorrect.

> @@ -240,11 +248,11 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_p=
artition *partition,
>  	 * succeeded.
>  	 */
>  	args.status =3D hv_result(status);
> -	args.reps =3D args.reps ? hv_repcomp(status) : 0;
> +	args.reps =3D reps_completed;
>  	if (copy_to_user(user_args, &args, sizeof(args)))
>  		ret =3D -EFAULT;
>=20
> -	if (output_pg &&
> +	if (!ret && output_pg &&
>  	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
>  		ret =3D -EFAULT;
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index ebf458dbcf84..31a209f0e18f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -128,8 +128,9 @@ static inline unsigned int hv_repcomp(u64 status)
>   * Rep hypercalls. Callers of this functions are supposed to ensure that
>   * rep_count and varhead_size comply with Hyper-V hypercall definition.

Nit: This comment could be updated to include the new "rep_start"
parameter.

>   */
> -static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhe=
ad_size,
> -				      void *input, void *output)
> +static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
> +					 u16 varhead_size, u16 rep_start,
> +					 void *input, void *output)
>  {
>  	u64 control =3D code;
>  	u64 status;
> @@ -137,6 +138,7 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 r=
ep_count, u16 varhead_size,
>=20
>  	control |=3D (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
>  	control |=3D (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
> +	control |=3D (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
>=20
>  	do {
>  		status =3D hv_do_hypercall(control, input, output);
> @@ -154,6 +156,14 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 =
rep_count, u16 varhead_size,
>  	return status;
>  }
>=20
> +/* For the typical case where rep_start is 0 */
> +static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhe=
ad_size,
> +				      void *input, void *output)
> +{
> +	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
> +				      input, output);
> +}
> +
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
>  static inline u64 hv_generate_guest_id(u64 kernel_version)
>  {

Overall, this looks good to me. I don't see any issues with the code.

Michael

