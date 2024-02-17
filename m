Return-Path: <linux-hyperv+bounces-1552-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572A85912F
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 17:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BF61F20FD9
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Feb 2024 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556C7D416;
	Sat, 17 Feb 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tZXoKHJQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2011.outbound.protection.outlook.com [40.92.23.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E47D3E6;
	Sat, 17 Feb 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188371; cv=fail; b=WZaLde9iHpk8BjK16zvyFJLHGWo/QGamxiVhKMoYK44+RiPB3PvaOEhosbYJt+TwEqCetCZsmab4MaYZMrb29q3eE7FoM5LPsRAa0DVN4cKlFqEiVaVWqhwlmFB8G6l2yAmT3/p8sxc6Ww01UfZQ4IA9rZXMZYLc8nePcZUuwVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188371; c=relaxed/simple;
	bh=ptp8vNKdIVizCpOWm+i+cJwmm/YyyxDY1O3fwzongsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsy0UEabFleos9btkamGQmUNU2YFI1GAtS7qqexPp4F9qpTSO8As88kIBU3WivKuSN804OnH3e4Ytf79g4jjJSCDjTAl+MiM6noj97N4CSh0eGvaQAGKVGcrhSnwESmjt5FlJuq+oLjHku3YUxRquWr0O6BFxQe2LZudUDL8Qek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tZXoKHJQ; arc=fail smtp.client-ip=40.92.23.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJYNxZ72zpAIbwvS6yh8EzC5k+V1TREJIY6C17o5upvQBdcrVliwZuZcYElZ4F3rebRT1YVBoQc4ES7fW7jAyF0yuZ3PGEkSi6G2G/nHRFmZz9yu2hLhNe48uZpXpbOhvxk6IHmBYbam13q7m7ZRt30RKI4JxhXf1KNMgvL/gQ0GHqveq5rm1PbTmeXxPTWP00pseGS8lZa373htMsoQOT31SPFa1Tz5IRZtrJAhAasMwmSCuDKurfjQ2wBy+Muc/w4nlT/nJ1JJkkTpaeuQBa/xWbOZRGVx0Cp3GfHsB9+fUk8NEUZxz4g1yewrbWPbP8nnAAhVTZpbjCXa9jo1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOUTl/+J7/PMJMGWP0tF6t2C9LS+fKNg/GTMwWosni8=;
 b=Jis0p7p0r4ESzM61D1+GJi5ckokv09Oub/I+HNqDmKx5+GPbWPlijya6veSPdpwCWdtdjRO3cHn4uFDK32yVgS9vaep0vNCkBz/QGj8+HOZrktGTsfyhyFN9MTlhBrGFfN6/OnYONomYwNeLTT8lV58B2FTei4MOGhyJOXsfjJTbKuGHab5LyyW0UjquHqKb3F0+R7R/GM3WU1El08Z0PjKjRSCQR2ibkBOHF4RD7PDoSPAxCNBczuLL008smESnvRUrAMJU4tL2+c4CCQdxwLtZ5rdyalYYt/Jo2fKpk2jHunlDf3EGz7LKXA8S6THmrGYXUuscmwcUOzUE1cf1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOUTl/+J7/PMJMGWP0tF6t2C9LS+fKNg/GTMwWosni8=;
 b=tZXoKHJQf8qchlGjO8Lmef69O3MGjSRa6mMSXBoGTiSZGfJI6hh2MtfxQ0vcszH5hENu7V3z8MNi8c9cGixgqIsFXAvScl0IshRinEEVO2cTopdRMICEB5J7dhMPnlj2Ew96qTRrJWMD+fVm+GnMWecxcMqT3AbM+w7n1LZgiBloHuk4GNnss3SZ+sOCpjLQd3gxL+77KYZyuqvnTjJASw+YRoGrdhBKxyS+bbExw0ipHXlDitkALWCOrPqW+ufbWAxZqCtYp9kBcZoWrRzlOjr5T2ekvhSxebjlN0gh5OPkCPYyQ/XPCRgHNFHr2vHIgg0usMzrCyxRwbMochtPSA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7462.namprd02.prod.outlook.com (2603:10b6:510:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 16:46:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 16:46:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "ssengar@microsoft.com" <ssengar@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-V
Thread-Topic: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for
 Hyper-V
Thread-Index: AQHaYOHvK5zyzBkwkUeCyKTO1/OqarEOuT2w
Date: Sat, 17 Feb 2024 16:46:04 +0000
Message-ID:
 <SN6PR02MB415758508A7BE89E0CFBD976D4532@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [KDUx5TbizkBbdcvkC3zWOEcmORcnEoQv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7462:EE_
x-ms-office365-filtering-correlation-id: 75d2280d-3ca5-41f7-2d7c-08dc2fd7ee4f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7m5oKRm8PDRJcDi4L30I9MpJpTr7mJPTGh/tc7uK6ieYc46ipV0LXnC4Q+HlYBDic/3cR5OzHx0uRLEesBcQe8f75GUhRl8YsZ6f0mLy1DwmYNv7a09BDB07EgwPAr6L7mCDKC+5bAo54KjvwIlRCxbQ0T78JN9jLLzXVWG0ykpEvDpZBTl52jeW1KmZ7oBXKhlCaV8hTYlA4CHgN7MEF4S2KWoJfyfm1mwRIxEbMOz4pCE74jMXOWFbC2v9jAo2KDXNg67wKGWuAMgVuUfO5X4O5m5qfXdCvnEu3XkLrpXg91Xz4G8VGpXSqDPA1NZsfZFR9JzMRvqmgu1Se5fB/2V4kD5EWWbRdOClgyH1BHKdSbiN39A8B/PsF9EOPJR0DJYaNL2z9uHMoTRfKygD5Ym1tHzb99qrDX+u/izUl0PP5H/qBlt8kFaK18aXpJjwF9ZCAc22n/kDTldu7yh048VbImZozWFqVpo5rRRdhQwuAJ+Tv6QEKJpzWi6N+ks5TEMsSBXdkqcA+DXvYa3hozuKkHY5F0Ilv7KWP2DT+3QEvgx2GjVEZEoRwxv2xsehGQ1E6v8FW6N0DneUW2fSALqO4GdYME4n0PyfOATlgNBOZKmSz6ddt+CiyuHHe93EiGFQRQ1okl0DKW/S+nGttA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iPCe2RQ6u9kKXuojNCjk+o7UzaqN5EYd0uDwGFhS2ziwXoYgK6kEcu3GVxQI?=
 =?us-ascii?Q?KthP/pnQYMlkx/4ZbR+PZej7bfmKKieeXwws1BkRsG5g8pKhbwtMzz4JYJTm?=
 =?us-ascii?Q?DLJi/DmDLmogIpVl3yJn51jLpfauh3Q++c5siRkUwvGDv9hN7wEYq1LPH8Zt?=
 =?us-ascii?Q?HJiCveiEDAQlNjO2dWYxpYaCQBRcuEw+GP3s7KHDIVssvml1DOphCXPcfuvw?=
 =?us-ascii?Q?mTIf5XpKpSUNWxXnnb9mlqdq64+486A0sWdg+lFDA2c2/A0f72CjJQrfSo10?=
 =?us-ascii?Q?0M0oREezrGbeyuoYJQiWc6JmB/LaBG8/7kRBcAxeF07I1K0OREkIA6SwTzH3?=
 =?us-ascii?Q?a9wOr42shRvJKTezcPeNkyWQQbdyECf0U/OgCE678vHOEz4VyW9yiCjl4kBX?=
 =?us-ascii?Q?RH6F5wdrTjSVOVuvZPLBg0zvDxhfrs9QVPrYVbdRpWSVoUiG80YQxpaUzw43?=
 =?us-ascii?Q?Tmc320bzrYWBgVArh2DF6hM6ZKoMYkxwGQZL4RPltqPycfAQJUuIzdrAifjz?=
 =?us-ascii?Q?R6oqN8HRf1GlhRyyoLU3vWM8344DoZqMlIY8mZ725R2CWz2W46OHOmEMhbna?=
 =?us-ascii?Q?uMsTwJZMtObhgd7xLKCDrnYdh8GD8iSPytXxuVCE0IFLyYv9pQLWT87yRNmX?=
 =?us-ascii?Q?G55dH11bmP8fjz4Qq7CesQrJLNzf8MVKQ6dPwO1xurh0+1gWswb1ig6sI+tF?=
 =?us-ascii?Q?+5H6QN4Fo1HNBtdKecbBKXBjBJ1q4q5cGUU5dmCRQikRnsjldI2+QsQ+7exX?=
 =?us-ascii?Q?WKUPFjBKoqibyOvkrlHkyq1TKyM+Kw+1t/FHT1sU+4Rdxz+W/Oqpz/lcl6ih?=
 =?us-ascii?Q?+Mq2wFGEASTf0JFP+deQxXDAhy3R/khEY7EeYmOvwgDDx1a7cwRqDJpctJMu?=
 =?us-ascii?Q?rI9hV4pbjZIuRsNHSIrsie2VywSSqpsfbjNZ4rAftsZmzDHhaqTWnGnJufkp?=
 =?us-ascii?Q?LaHCQRaO8yQc8mNj0lFILEJ7Ibt2mLQLq8FR9w4F+TPx0Qv2LHD2qb1CVyqz?=
 =?us-ascii?Q?x3yh4//iYCQvBIUllS3ziaF+RNEnxFTM/GLQqOkJCtMN6MhBZUeQVY5ers+6?=
 =?us-ascii?Q?T8HDOMVihLgnnIQs1+uHQrj1hHvWFRxzlBZ6iFxvUDRTA88r4YZTsdyJOLBp?=
 =?us-ascii?Q?2KqBbIPOwjIj3YNPTBI5N6wTFKsrPhA0IrxH7CgaTfI9P7websNjgl8wwlhK?=
 =?us-ascii?Q?scjoGW3qkK6esKCujofuyy6+CsPGqsQ8gx1fyA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2280d-3ca5-41f7-2d7c-08dc2fd7ee4f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 16:46:04.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7462

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, February 1=
6, 2024 6:10 AM
> To: kys@microsoft.com; haiyangz@microsoft.com; wei.liu@kernel.org;
> decui@microsoft.com; linux-hyperv@vger.kernel.org; linux-kernel@vger.kern=
el.org
> Cc: ssengar@microsoft.com
> Subject: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-=
V
>=20
> CPUMASK_OFFSTACK must be set to have NR_CPUS_RANGE_END value greater than
> 512, which eventually allows NR_CPUS > 512.
>=20
> CPUMASK_OFFSTACK can also be enabled by setting MAXSMP=3Dy, but that will
> set NR_CPUS=3D8192. This is not accurate for Hyper-V, because maximum num=
ber
> of vCPU supported by Hyper-V today is 2048. Thus, enabling MAXSMP increas=
e
> the vmlinux size unnecessary.

Note that these statements apply only to x86.  arm64 doesn't have MAXSMP
or NR_CPUS_RANGE_END.

>=20
> This option allows NR_CPUS=3D2048 which saves around 1MB of vmlinux size
> for Hyper-V.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0024210..bc3f496 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -9,6 +9,7 @@ config HYPERV
>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> +	select CPUMASK_OFFSTACK
>  	help
>  	  Select this option to run Linux as a Hyper-V client operating
>  	  system.
> --
> 1.8.3.1
>=20

I'm not sure that enabling CPUMASK_OFFSTACK for Hyper-V
guests is the right thing to do, as there's additional runtime
cost when CPUMASK_OFFSTACK is enabled.  I agree that for
the most general case, you want NR_CPUS to be 2048, which
requires CPUMASK_OFFSTACK.  But it would be legitimate to
build a kernel with NR_CPUS set to something like 64 or 256
for a more limited Hyper-V guest use case, and to not want to
incur the cost of CPUMASK_OFFSTACK.

You could consider doing something like this:

	select CPUMASK_OFFSTACK if NR_CPUS > 512

But kernel builders always have the option of explicitly
enabling CPUMASK_OFFSTACK.  That's what I see in the distro
vendor arm64 images in Azure, since there's currently nothing
that automatically selects CPUMASK_OFFSTACK for arm64.
So I'm wondering if selecting CPUMASK_OFFSTACK under
HYPERV should be added at all.  The two aren't really related.

There are recent LKML threads on enabling CPUMASK_OFFSTACK
for arm64 -- see links below for some useful discussion of the
topic in general.

Michael

[1] https://lore.kernel.org/lkml/794a1211-630b-3ee5-55a3-c06f10df1490@linux=
.com/
[2] https://lore.kernel.org/lkml/7ab6660e-e69f-a64b-0de3-b8dde14f79fa@linux=
.com/
[3] https://lore.kernel.org/lkml/e0d41efb-a74e-6bb5-f325-63d42358c802@gentw=
o.org/

