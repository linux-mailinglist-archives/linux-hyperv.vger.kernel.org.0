Return-Path: <linux-hyperv+bounces-10588-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFgGGKm2+GkczQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10588-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:09:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5A4C0718
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD20030066B0
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C53DA7EC;
	Mon,  4 May 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Usz09XVR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012015.outbound.protection.outlook.com [52.103.23.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82BC3D5254;
	Mon,  4 May 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907366; cv=fail; b=EsW1getisrsgxM5lg768BAfuQGncjpNwH6N2NDhonjq9ACzAnhTJKD3ZY2rfSjPfMISRF46c9XN4AWSNa16S5cIGTPRXtv8xtpAGdpPZ9va6HzIv+gZ4F1tEJ5IxxN7wQTI5AoWmf+YVQZsbAV4hQ6Yb+nSN3CoAAcpwoL1yPlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907366; c=relaxed/simple;
	bh=/dhSmoOjDuDq0pHPSAoyuaMFAkVHF9DXbMcuqRss5Qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qw/kX0nBgjbCBv1rBl2oSBetvmKCQDGhqlk4nqYcq7ixihLuDfz0EHai1vsNREa15awPJk+d40nqj3e65KJuJRbmgVa43Xf38EgVt+C8XQNK5tVwhJ2mRFNUcFb6gZQl3yZ6Wtv6NFk0K7m9KqBkpPJ38993OCajhcZVmXSMD4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Usz09XVR; arc=fail smtp.client-ip=52.103.23.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quUymkXvQaQ3bfEXFP+WzBP1C2icXBJ+apehAyKdbmDNphZVCjsLrSCByr31ts2m38n0iRYvRL+jqgcB3kVnh+y4Nya5dPm9S4d9loC4OolS77X0eURP1dEXqZyRkRW7WFlom2B4rcF/7jAbBeFWbVW9dvicb2O/JR9dwoioSox1vbt42x1vdSTOsC7YE66zQZqszwuEd7xNHt0j/DVSSmuV9cQw6kDS+ErDaBPiVt+BDx5PGMlgCI7vrHcTjNACmhCGioGBvgRokCUE51juPi/xnLFi5zGr0OqgCjjIyhVM5UB+73CRuGfGsMQdnvzAcjpvGkJzcnlXSgPXaarSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C7/ICy8/dzMN025V8ETJWU/YrSvqFMV/bMqlR2XKZQ=;
 b=eaplXyZmS0Emj1+53N4yya9X5c4r7EBbfbcm6ld2uWHSpDOAQQmXki+EvlAi1pfM9V7AICN3OFkeZ08rtDuiu/s7fcQs2VDd3qfjr44cqAugckRVsf20zQCpy3Uh6sp51bdGUxwcGl+HfKmQ3XtRN657VNxOR885TWzaPVN80sCtDTeifdw6fm7SoBQfVNcGR2ZovEW7clAyAopKs0ineiAVkIrHMKY79cloZ5yAwq3rbHQP40mfvdCNnNt9jfmFK/5eZYhMQ6n96MiUxcfwhUPHEvxX569RceQXM+aAYleoQcvPoCgPUOq6AGEPqzD3seiZUtjBtnfN8fmcblmHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C7/ICy8/dzMN025V8ETJWU/YrSvqFMV/bMqlR2XKZQ=;
 b=Usz09XVRgbr7nztuyfSfavQ/v57d644Fs6IsIb7wy2+koJmD5IGEOckw4EBqs2Oi5ZhRYkm5H6/NxyWJYuCWB7NQM0qw+ebNvU1fL7AQ1lRybczu3YdvCJhbaf/dzNeTLZca8ihWUloFHl56ANJDnS9bOVA4wdvz5gRIy7Zfkaa8gjrPw7pw0UAGUoK0KFErb4ZzbJNMXuz1tCLIyzPqMJgg5o1HFzA+d3rpzsDL09F09cEYMg1K8UYYKgFMdrKYAWj67ZLka7zRkRChVPKtIV/3Ct9bgs4oBdIvMLkSFqxKO1NvYRhsVftKrDn3o4MNCVGmKL2H24Yaqp0epki+1Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9818.namprd02.prod.outlook.com (2603:10b6:303:23f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:09:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:09:21 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jork Loeser <jloeser@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>, Michael Kelley <mhklinux@outlook.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Anirudh Rayabharam
	<anrayabh@linux.microsoft.com>, Stanislav Kinsburskii
	<stanislav.kinsburskii@gmail.com>, Mukesh Rathor
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v3 3/6] x86/hyperv: Skip LP/VP creation on kexec
Thread-Topic: [PATCH v3 3/6] x86/hyperv: Skip LP/VP creation on kexec
Thread-Index: AQHcxvg2yrQQCDWzF0avVXi4VB2dFrX+IgYg
Date: Mon, 4 May 2026 15:09:21 +0000
Message-ID:
 <SN6PR02MB41578A8F9A225227FB5E79E6D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
 <20260408013645.286723-4-jloeser@linux.microsoft.com>
In-Reply-To: <20260408013645.286723-4-jloeser@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9818:EE_
x-ms-office365-filtering-correlation-id: 5c10c4f9-d908-46cc-b2d0-08dea9ef1edb
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|41001999006|8060799015|8062599012|19110799012|12121999013|51005399006|13091999003|461199028|55001999006|19101099003|31061999003|440099028|3412199025|12091999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZYbcsIFCwOQgDzgngr5T97tT7quGsTxUQR461bhOuizSfphTq90ey+pZfzQO?=
 =?us-ascii?Q?7KBnMUIbUl1hKOPK0NeHIAHZH0D/4AvCjxh6yGQuYx6EFqLzb/cieMdt1Q8v?=
 =?us-ascii?Q?r/uDYodmpN7fF6VeSyWwko9CjYQqq+luh2YjSMRcxVso3MnIMmgkcijycZDF?=
 =?us-ascii?Q?6p0rWINkh5ounkeEjegnR94gg6Yezz4ZGdpATeIaX4tbWT7ChZLpT7XsB6N4?=
 =?us-ascii?Q?WH09VbiB4ocG0i8f4p2iWheV/TEoWAmB9j4p107+DpuQDwpAivyhzUbS3vGq?=
 =?us-ascii?Q?oDEamVKEdO4zEWBB8aMe7QBnAcR/NmzPNQXLdRZiHDdQIcisjtIlwC+swTw5?=
 =?us-ascii?Q?NhlwWfkB8aPjWa7NJ9gEIr8AJ9aH33fiFBRg7ITWHl5MZH715CSkEYMLwS3X?=
 =?us-ascii?Q?ewF+7TW8BKnsAeqGcjM35j4pKmi1pyrLLy+kCORryYF95VWf1+kiJJu5vzpm?=
 =?us-ascii?Q?Dx2pwz2QA2UeajjsmfsIrJ7W3sWjedpGwBR4tKg/m1lFCTAr0Tydde0jXAoT?=
 =?us-ascii?Q?y41Kq35sjsUBbAavfJIfBDCRKQfjepFwwPAr4BLZMxmkXhYnuKB2rRNkMBjW?=
 =?us-ascii?Q?gmMm2h22JO6L6Dh9+2V9EQxhnIPxzd/JvN/ouiFoS5yPXlUkEs5pj0+eQpsy?=
 =?us-ascii?Q?5rw8eQRE5KDWNWpFear5Tx/Ie8VoCiQX1BM1XTJkmbjSqtB+K1xN+rxZL0WA?=
 =?us-ascii?Q?JCv9XX2/TLsk+5ORkqm6dgspaBaI83yi4nqjAyfz3S76YTHnnJYmpZECSKo9?=
 =?us-ascii?Q?VytQrWjvqC73p8Gi7Zo5na5rsF1VyoOzJVrBKuUTdW0Q9iZWgECQpTjlPXyu?=
 =?us-ascii?Q?4PdcYznWCerMHqfc2afBxHNpx+J7ppslA+yGVsTRIXGEh290vIOlAF+ELDLI?=
 =?us-ascii?Q?hq4LlJsjB+/6z4BGEzewQ/xHaV00nCBoO8DP53CqpTgslg7JJp/M4jxKQhwe?=
 =?us-ascii?Q?kelquFhWHTvXNI/dUK5e/XyABTEAzZpAoc+Duh/jXx0Ej/G6/35AgwyUtmiK?=
 =?us-ascii?Q?JtzzUO8qHSb7h0QrJjwcb6AUE7fPmxRtT20rvgqbNOm3iYFFJ6Azx4Hb6xmc?=
 =?us-ascii?Q?soL6BtZRTM6TjviLXqxYtQdsUHAcjfZdc54xWDNZ9SqA+WDtNev+jFhVhiJC?=
 =?us-ascii?Q?o8BOHIhfL8zQvjlmisu8qs7ntM3N0zV1Iw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yS+jjW8jOzfOrtLCcNk8s0TysnlNl87IEDAqpgYx7Im0RmRcgIQwrBeGMPBa?=
 =?us-ascii?Q?B03DoyzhSsU368I2xUNT6CdT3gbTAxqAjZ1nyD+gN71oPrub8UueV+5kexuO?=
 =?us-ascii?Q?+vzsJ+zJWZHKDNPEEEuFaTZcxdOCVoHknCVrCfKC1XG7+mAJ/6m5/oFLYwQg?=
 =?us-ascii?Q?9HhyNRP1MjgWWoN65MlGaBnZSUX+PqmZl50+JYZ14s98V/TWhTg0FafenkKk?=
 =?us-ascii?Q?8XmsPxAAkx9I3khlGiPXxEqwsCMAZQSaZw280Z09icvJ5sOnKrNacDML5Gpq?=
 =?us-ascii?Q?5qNmkp0xakRZLVrWj6thPUk8ZpSS8icdUEkALZUn5JxwNfsq/d0tWdRGgw8E?=
 =?us-ascii?Q?RomA7JT9ZjBPA2KSlXhntMVZcYXKCKkLJr4derLKDKca+F9qHLSj3nmelgtK?=
 =?us-ascii?Q?iKcn3+/PYTYgke7eGtXHkKMNhPucrp98NfhmjavdiEIcYevtwhuY4z1724Rj?=
 =?us-ascii?Q?SJeWrDHNX5nVS3c9RHE//K8Phn/HwLyBmdXdnr7agbHo3pMerY+0/3xFlNvJ?=
 =?us-ascii?Q?gSRDC3TrB38eyi4q3XRkjXZVuKERATniiPTBCglGDOG89Ycs/jrQDmL/KxNC?=
 =?us-ascii?Q?lBavDbTNvSNAAHULkfZuonBcnDe8iULDr0Le9KaSfR3tkhVeinDyOHDaQvF4?=
 =?us-ascii?Q?jG8Rh+z5F4Jv1X+wzu7tS89MPPTaJrKEVLwZvlnA8VVDla1+vOK7D8iP2ZGA?=
 =?us-ascii?Q?to/+/tTMyaRrfiROcyhPu0spShkrWBEbhotEJBxAGPx8hMXovx6J8FS4mO3C?=
 =?us-ascii?Q?hTmVd+X5MUAlkA6/rq9yW9P+mUrVXkRDtzk0+nyJNFFO77lHqdFEMk2rgO64?=
 =?us-ascii?Q?UWYTf03hkpn7FSKABeb5JznjxjTGWHAhGvVCxE+NqePHLKzuRduH1AwobZPY?=
 =?us-ascii?Q?bWI0hLVuQivQ6WVxm7oxVj2S4lMW7Erdv9mODLRRjOwavSJM7QzylpwKNp83?=
 =?us-ascii?Q?qTNl8w3jXZEJyO0mReOSA5LwIJ1iZMcukeRxQ477bVoYutCGJf78u+BVQ/1P?=
 =?us-ascii?Q?NurUhPwh85vtuaaBeUTRoJMMqRED9Okomi1AeanbsDUjQtJatVNapSuiMW5N?=
 =?us-ascii?Q?57JSoI9PC5p+tBCPL/11HWUlgpz3+nu2WP4U75jyThEaD9LoMe5NO/gtwr4H?=
 =?us-ascii?Q?uOKB71iQIOtoLNeIz9iPWUTELueFrWDmVYuFnTrNjqXLCI+jl5x8kxYItpEp?=
 =?us-ascii?Q?8JusMoebyEHeKW/2HdSsYLEqUK9XnWKiSXyljLsKF5AcGLYccbVLgOINu1HL?=
 =?us-ascii?Q?lMM5sChnYFKKtTiMn8yS+Cys//eC7rqsrGCCoAgt1SQKOfGGfGoEKDfkrCie?=
 =?us-ascii?Q?yUZsKngDeyWBnnaNHccJ/NSMFdRd389RurYbfCz2IaBemRs0u1REq5PVPitq?=
 =?us-ascii?Q?SBahiTc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c10c4f9-d908-46cc-b2d0-08dea9ef1edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 15:09:21.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9818
X-Rspamd-Queue-Id: E8F5A4C0718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-10588-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Tuesday, April 7, 202=
6 6:37 PM
>=20
> After a kexec the logical processors and virtual processors already
> exist in the hypervisor because they were created by the previous
> kernel. Attempting to add them again causes either a BUG_ON or
> corrupted VP state leading to MCEs in the new kernel.
>=20
> Add hv_lp_exists() to probe whether an LP is already present by
> calling HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME. When it succeeds the
> LP exists and we skip the add-LP and create-VP loops entirely.
>=20
> Also add hv_call_notify_all_processors_started() which informs the
> hypervisor that all processors are online. This is required after
> adding LPs (fresh boot) and is a no-op on kexec since we skip that
> path.

Adding hv_call_notify_all_processors_started() seems like it should be
a separate patch. And this paragraph in the commit message leaves me
with questions:  Is it really "required"?  If it is, how does the existing
upstream code ever work? Does the change need to be backported
to stable kernels? If it isn't *really* required, what are the implications
of not doing it?

>=20
> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> Co-developed-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |  7 +++++
>  drivers/hv/hv_proc.c           | 47 ++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h | 10 ++++++++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk_mini.h    | 12 +++++++++
>  5 files changed, 77 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e498b6b2ef19..b5b6a58b67b0 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -431,6 +431,10 @@ static void __init hv_smp_prepare_cpus(unsigned int =
max_cpus)
>  	}
>=20
>  #ifdef CONFIG_X86_64
> +	/* If AP LPs exist, we are in a kexec'd kernel and VPs already exist */
> +	if (num_present_cpus() =3D=3D 1 || hv_lp_exists(1))
> +		return;
> +
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
>  			continue;
> @@ -438,6 +442,9 @@ static void __init hv_smp_prepare_cpus(unsigned int m=
ax_cpus)
>  		BUG_ON(ret);
>  	}
>=20
> +	ret =3D hv_call_notify_all_processors_started();
> +	WARN_ON(ret);
> +
>  	for_each_present_cpu(i) {
>  		if (i =3D=3D 0)
>  			continue;

An observation:  hv_smp_prepare_cpus() is getting to be a bit of a mess.
It handles both the SNP case and the root case, which aren't really related=
.
I could envision having hv_smp_prepare_cpus_for_snp() and
hv_smp_prepare_cpus_for_root() in order to separate the two cases
cleanly.

Then hv_smp_prepare_cpus_for_root() calls four functions in hv_proc.c,
all of which require stubs for the case where MSHV root isn't being built.
Better would be to move the root version of prepare CPUs functionality
into a new function in hv_proc.c, and only have a stub for that single
function. Three of the other four called functions could then become static=
.
The #ifdef CONFIG_X86_64 could also go away since hv_proc.c is only
built for x64.

I'll probably submit a separate patch to implement these suggested
cleanups, unless someone else wants to do it first.

Michael

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 3cb4b2a3035c..57b2c64197cb 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -239,3 +239,50 @@ int hv_call_create_vp(int node, u64 partition_id, u3=
2 vp_index, u32 flags)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(hv_call_create_vp);
> +
> +int hv_call_notify_all_processors_started(void)
> +{
> +	struct hv_input_notify_partition_event *input;
> +	u64 status;
> +	unsigned long irq_flags;
> +	int ret =3D 0;
> +
> +	local_irq_save(irq_flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->event =3D HV_PARTITION_ALL_LOGICAL_PROCESSORS_STARTED;
> +	status =3D hv_do_hypercall(HVCALL_NOTIFY_PARTITION_EVENT,
> +				 input, NULL);
> +	local_irq_restore(irq_flags);
> +
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "\n");
> +		ret =3D hv_result_to_errno(status);
> +	}
> +	return ret;
> +}
> +
> +bool hv_lp_exists(u32 lp_index)
> +{
> +	struct hv_input_get_logical_processor_run_time *input;
> +	struct hv_output_get_logical_processor_run_time *output;
> +	unsigned long flags;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	input->lp_index =3D lp_index;
> +	status =3D hv_do_hypercall(HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME,
> +				 input, output);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status) &&
> +	    hv_result(status) !=3D HV_STATUS_INVALID_LP_INDEX) {
> +		hv_status_err(status, "\n");
> +		BUG();
> +	}
> +
> +	return hv_result_success(status);
> +}
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index d37b68238c97..bf601d67cecb 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -347,6 +347,8 @@ bool hv_result_needs_memory(u64 status);
>  int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_notify_all_processors_started(void);
> +bool hv_lp_exists(u32 lp_index);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
>=20
>  #else /* CONFIG_MSHV_ROOT */
> @@ -366,6 +368,14 @@ static inline int hv_call_add_logical_proc(int node,=
 u32 lp_index, u32 acpi_id)
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int hv_call_notify_all_processors_started(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline bool hv_lp_exists(u32 lp_index)
> +{
> +	return false;
> +}
>  static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_i=
ndex, u32 flags)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index f9600f87186a..6a4e8b9d570f 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -435,6 +435,7 @@ union hv_vp_assist_msr_contents {	 /*
> HV_REGISTER_VP_ASSIST_PAGE */
>  /* HV_CALL_CODE */
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE		0x0002
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST		0x0003
> +#define HVCALL_GET_LOGICAL_PROCESSOR_RUN_TIME		0x0004
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT			0x0008
>  #define HVCALL_SEND_IPI					0x000b
>  #define HVCALL_ENABLE_VP_VTL				0x000f
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 091c03e26046..b4cb2fa26e9b 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -362,6 +362,7 @@ union hv_partition_event_input {
>=20
>  enum hv_partition_event {
>  	HV_PARTITION_EVENT_ROOT_CRASHDUMP =3D 2,
> +	HV_PARTITION_ALL_LOGICAL_PROCESSORS_STARTED =3D 4,
>  };
>=20
>  struct hv_input_notify_partition_event {
> @@ -369,6 +370,17 @@ struct hv_input_notify_partition_event {
>  	union hv_partition_event_input input;
>  } __packed;
>=20
> +struct hv_input_get_logical_processor_run_time {
> +	u32 lp_index;
> +} __packed;
> +
> +struct hv_output_get_logical_processor_run_time {
> +	u64 global_time;
> +	u64 local_run_time;
> +	u64 rsvdz0;
> +	u64 hypervisor_time;
> +} __packed;
> +
>  struct hv_lp_startup_status {
>  	u64 hv_status;
>  	u64 substatus1;
> --
> 2.43.0
>=20


