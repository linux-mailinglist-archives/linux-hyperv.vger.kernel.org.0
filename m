Return-Path: <linux-hyperv+bounces-5906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CACAD9200
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 17:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCFA1BC5613
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74F21882B;
	Fri, 13 Jun 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SnXGxzBt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2039.outbound.protection.outlook.com [40.92.19.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6E22DA17;
	Fri, 13 Jun 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829860; cv=fail; b=OpgOo2t/XtpIswd5YtjkZzFC4iPQmmZY/IPSEtI0uIJKnwYBxb2zXdBiDew0GcEBCmopSe9zHKlXuP+x4YmcTq37jr/FVhTz+KsV4vOA5pXIwn4QsaBZllPDKlAnu0pg0APOFFjc9xF5Y10s26R7ZcSvevBoJmyh0LVnqLH4R4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829860; c=relaxed/simple;
	bh=68A2McSWbuUqUfqX3cIjmwDd101buvXJLx/x4L72FAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lOI29aPjJt4NbikAZxA666hHg4IGinFT072+GjG5T9JYVPem91ZQBPd80L9Pj33cW+OeqohhhZPmszV7AftXPXMyuAEntsesctBVIBAxuQKs1ZZYig/Dsp3ycmWUgpXhF593xu44fXSXmnnYVu77viuMiYUxpXMqpr2sFUdpHKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SnXGxzBt; arc=fail smtp.client-ip=40.92.19.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZNWGaxTTARQGiWWKng8jZDOqbJ7j38X7p8WDTzLnIcGOT0buRKc7lQLXEbhOi3IT2bujJ+akN+aerp8yCnTV+/tSV5Bgdgg6av2DShn3DiTZB/rWUdJ8g7Bix56HUAL7FTr1IwsgVP9jQAxuV0XYmaJIgp5T3ErYcM187TwBvjiAA5mNbmuXq7FoMCf5DP9x9BHkAAoE59y9Va6qpq8OkZiJXtQQRmaeXNOjFI4AdCpvFDSh5BOYjRyMsfBMN5ewzAuiR7s7BVP6nxCNYYc+DmIR8IQ0kSoCnXT/aDMaYJgIiu0b72lhzkqta++73rt6Sej+Bnb9o2Ei3eNbuVhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moWIjvGA2LA+cdPOK8UuDctci8o3CN5PwHUcKGDXmVY=;
 b=mWSsm1NqJquACAUL3zpuh4GbEnrOjtyuv299Orayd/3IV+6WiS+4UmjSmgcPJECZR5AeGG2RqtZQecVijhrBa68XE9JObwf3DlfZlanJrgaCpR9cn0yPjCFQJIJoFDn4HrfILdhuxtBZX2qGb9eHVIpV+rqDaQCj326bbHzHR2gw99+uyAIbfF5LE47Cg5wCbnhJcVVLZwgTsBuV5rvZoR3TzyDWx27fTzPHsC+p9tO3Iw+SnueHMMRvEqYdHkndKwwne0KTtOtminHYvdeX5DbVxYVzDA/QBFzSL17IyqzaO+FRGdMk0JDLoFSfhjYF1U8+ivluMTNxSEddgV5Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moWIjvGA2LA+cdPOK8UuDctci8o3CN5PwHUcKGDXmVY=;
 b=SnXGxzBtyFm0QXVMJcFYtVv4tIxhIP8MeWQQdOCJGAYUbasSWFGQbuhczZm1USZ9YSCyfGs0wONELsD/NRssizJGgrlXLm0ECIXgV03Lnv+A3qoqSyFTJGUwgBMDROEM7e3nEkd7IWmIzkmH/hdZV83AcPQAgz2s2EVhc+cOjKq0rTJIZXJY/xqLUiwqRB8mWTEEWreI2MOTg3UmPOxjHWnH7v7aeDSF8FC9FAqbgG+G+5MaK0L5L3E9suGLI/H9e2bNkQW7vbbUrh36sYxMHa9abbr7QokcqnL6JahAjUlNpaHiCz12SgWb+dNpRKNLXaU7/qyrt0vwmc7XfpOIUQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7243.namprd02.prod.outlook.com (2603:10b6:806:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 15:50:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 15:50:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Arnd Bergmann <arnd@arndb.de>,
	Roman Kisel <romank@linux.microsoft.com>, Arnd Bergmann <arnd@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH] hv: add CONFIG_EFI dependency
Thread-Topic: [PATCH] hv: add CONFIG_EFI dependency
Thread-Index: AQHb2eia04zHIDnue0WZOFD8f2qY5rP8hlQAgAADWgCAAAFzcIAAKcLwgASGDxA=
Date: Fri, 13 Jun 2025 15:50:49 +0000
Message-ID:
 <SN6PR02MB4157D600219C00D33D00C3B4D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250610091810.2638058-1-arnd@kernel.org>
 <20250610153354.2780-1-romank@linux.microsoft.com>
 <df1261e1-25d4-43ae-88c4-4f5d75370aee@app.fastmail.com>
 <SN6PR02MB4157CE643DEB6CE4B0AEFC00D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157D3A61C5DB1357267D712D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157D3A61C5DB1357267D712D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7243:EE_
x-ms-office365-filtering-correlation-id: 74b22a7f-49a2-4871-a6fe-08ddaa921183
x-ms-exchange-slblob-mailprops:
 V85gaVfRD4/0/avatvyefFMaYYkxcpZNHe26a/niBD2u0efyLRZ94/ZIzSRQDI+ZFsfsoaBeScXazW7tGe8LVYFQecMSENsJSggAMDlNj/sM+G49NMfTQTAozGMzaH2PGLAtRBvbaPV02Rvp4EJKAFo+ZGFt7lwItIOGYSCPfPxC2IVp1npQMOI9/uP4sYpJ+dFYJZgu/zhDOJiyJckXelx+INlbpHNmHXz/dUP3jEpPvXlPD+sRuEEL+X6RaOjgkLttsVClZlq9QM/AsbuGCgv6+CTvlxTAiX0ucSi+rCZ0C7dOkDnVtgsTwkD+LjsWjdLXLkfwPDmf7wVH6UzWgoYrsMbZviyqNk01WgOwPU0wpyZ0dLUbYEV1krk9XflP0GaL+DE9NxI0ifKxXmclRHnsLR8BCFp+/WI+hWgow55XGaWlg7PdWOV2Ub/MbyHq1P3wrlpxQ6G0a+ePK5zc95C7SXr1X6AHYmyd4uRTkahNokNy8fjDKfIQ9/RmZWrYUip8JEynWPb8qjWMFVQS2e9m/pEsMiNLzB5IB/OOvV8QzSKMJxCqVWHq9i9p51ut/9iH5mVx5EgWUo/vnJaYrnsMcmmii55at3T8lbJiBgV4d1t9d03gDuLfilNHbl7F3Oc8+Vnpkpzfo87rrYwP9PStPG/IdAs16bpRxItPYGF9VSPJIG7LHt/SqOWfV6Hz5Qs1URr4rUN4/5bV53xa8f1ZNNibEyPlh9y/9yZ994z/gW6JRlUxa+tU9cDzente6gLmh8zZeQY41UTBn4EywdCFiKu3IXlG/ojuvM6Xm8o3lHQgPlbZwEng3B02qU8ZT57XeV/pXbJtvLTO3b4Ofw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|8060799009|8062599006|15080799009|12121999007|461199028|1602099012|40105399003|3412199025|440099028|4302099013|10035399007|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1P1n5UIpwhbY8MIRMpPRplI0uX2rwQH5BpsQ3/0FRS1bDja3+KjyGrqYSP9D?=
 =?us-ascii?Q?uZOBz9rA1Rm/QwyEzU7MMouErZt2nPz1dRgn9tEs6LUxS/bZnbyVXGI7uOua?=
 =?us-ascii?Q?KysKX6dvVPgCaBbB0CvDVoIrwpcWpozz09jHv1z6TMYtGYyK7ZH0NhG/7gvj?=
 =?us-ascii?Q?3II/s/YG6e1KdfGcIi2Z4109wP0ptBXJu+1gGv2ZjMuNE1v5ba0xpQ23lfi1?=
 =?us-ascii?Q?t/71yIjHyJP887VCtYALazxKQccZeeCUDEANlQbJ+HQHtUr6FL1xgpdd8v6k?=
 =?us-ascii?Q?r8x6LDmP/W3x/isWMvgnIwRt99/2xVsM0qgr9JuDBusc77BmqtMsGhtlG91h?=
 =?us-ascii?Q?inLGI/YRTVmG7Phi/2k9q7b/f/HsPncmwxEhknAxAtLPwzR2vwpgdT0L4aGi?=
 =?us-ascii?Q?mq7nltoaxhAgZo4LEsBJGQFbcyl8abfpav3CXx8z23+0dbW9TxgkFWG8O6Qg?=
 =?us-ascii?Q?GPiDLFdidX+EBAWQZKzFXL98hiN3lUwCMW7O/cr9wO6FwH17I9WbiK4uAY2l?=
 =?us-ascii?Q?duI3IKN6eRImzHSYABV+2zUuihR4cmFM3vcRajReOlcb435i2MqY9FIIen60?=
 =?us-ascii?Q?FQIMUIQZYgkSoM2B+w//5MsibNAdI5O0M5Nb9oUUF6Gl0HK8VJ4m65ktSwkO?=
 =?us-ascii?Q?Ek3n87Rel6a0TPVjlEYdR95fpTk/ttoaiox2Tx7l2sIIcCb463sEZLbRhEaJ?=
 =?us-ascii?Q?LLcwCvuCR5g+dLRnGhqF8/BT/PphFn+rNf8Yu9j/1RbPYlXCGJMUE/zUDXfc?=
 =?us-ascii?Q?HRjHz9Ee/imGqiVZIsZnhfSqxTSi5L8XlBalQ/rlM6HTeIaktfuZ0JINu1q3?=
 =?us-ascii?Q?bp7sWNctsI39ImaBFcABCUBpr9xu67aT3HmsJxZdQTec+s9zpoegIQWZUXxW?=
 =?us-ascii?Q?C0qGKbYcCto0LAqhvwm+f2nBofFSkbop3n29SORocPGamVR2vqPlVAJ7573r?=
 =?us-ascii?Q?fUbj7OdJwKhDM3ctkd4YB9Bab7IbbCe6tH0Oi36xCafabeBx2C4xpZ7pGsB9?=
 =?us-ascii?Q?40IKltKNWT68stgaqDP7eJuYb4KtSvXrpPPj/B1DjT1/PVtI3OTcrOdvHosI?=
 =?us-ascii?Q?iUpw9tl/kau5pMv8Wcng8aORtz0k542mg9D2y1uKQ/KcKOZ0EK/JLBRzXAvn?=
 =?us-ascii?Q?8vIMN/5+AsAW40s7U24ccaiR0+i1YefB9ojFyfNyZyZ3Y/516aW4s1cZ6Qf+?=
 =?us-ascii?Q?/2+yJ9qJD30l1Bz2PdVhYx1f7woSsGGcqWs9qslGASYSD2i0Rf3F8l19ZNvK?=
 =?us-ascii?Q?ZQlTPQ5aeY+4U6qKQD9PAPjni91LiwhwUN6IDH0PKN1O1LyXhodKLyWnu5Gc?=
 =?us-ascii?Q?xEw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dSzE9lEnqZnhtmuRxtUaaD66p+unrQgqMIGiNNrvjKbaZSYVUnBNF/1LYsOu?=
 =?us-ascii?Q?Llhvv1KmvqH9dC7gKjXHK/kvXV7gAqYBhnJxyY2IFI4PWWPvgbR0uxyCXhTp?=
 =?us-ascii?Q?1ItLXDsuGJLAxwAyVvspwxiSRdwNbxY0wF0dFHofmIOsNgrOjU88Kz2qlY3w?=
 =?us-ascii?Q?7ZY2cpr+Cu4z1y7gW9x8luyFuwg5EyWnmSCUUQNlZzyBWRA5O61+Ur+Emqag?=
 =?us-ascii?Q?6D6WUsWiOpZ6SgAB/3Ct4JEZxyxxJr622eSvElLnlYvEydwNpHGwXy2giKkE?=
 =?us-ascii?Q?sG+xVpXJg/luiw4XaHmAapyG0991wD/KYDaTHIJeGDWFUsg5M5ewA0DMMODi?=
 =?us-ascii?Q?bfogkYIAXYhdbrMrOeBGhbFIEJDFrCg7QKGEueLe86tBKalmkXO90ah29zmH?=
 =?us-ascii?Q?fPLdQ816NsKks/hlhTAPCRfxOQvtDalPpATDUivSkOCZnEfD4lc4DLcK9Yr+?=
 =?us-ascii?Q?ivIYl6/j8KRtnhgKktmq3tbr1vr6JPWXni3MlUMApgcOa32YiZuWurdJOwZQ?=
 =?us-ascii?Q?IGCv7a//yXDb24PULh1qPs5msfnU1R7Z5HUksDU2oW6BQmlDxNb42M6Ospvk?=
 =?us-ascii?Q?mA0as/RCu6+Ptt33a9BR+L/Hq9w6IYjTYz1KogaiNwoPCfrlfJXAuKe09ztB?=
 =?us-ascii?Q?Egm9ZrpNZRmT/OY8f0647EjsTTJbf4FbkUPhiQUu+QhlF5/f4Xzlem7gARBY?=
 =?us-ascii?Q?12GLS4WLax5k1nuhNlERNJ7VtcBUqFoV2NN6/CyN2g86yfQD3NgQPZWNkXtJ?=
 =?us-ascii?Q?gycszUkOZg2yTksfZ0b/IvBJMf9EnULhEHvgbGceimm3N7bUaXBzFhR08wuE?=
 =?us-ascii?Q?s4q10jRC5eaZIxcf45j9q8018pFrUWvR4GWrq2dZOQxBWsh2kvFhF9zoeJZG?=
 =?us-ascii?Q?rAGPG1YFH+d8bK00Ol0ErX8fHQr9o6FMD3WOfOBymDAJWFYS/TBtBPwwRwrw?=
 =?us-ascii?Q?ih5uWtlqAXQiRmuywSXfdwizWUxbLsIt7SjpGNTUbWsvw5vy4LVJRZF//FZ9?=
 =?us-ascii?Q?hqHZVD78ySzO312wGoLB2Eont4ZtuKQe7iq+Gaw09wqgsvATToJKeg0umAXM?=
 =?us-ascii?Q?P+NAUUs0H2dyv0nQyIQlPSv7fhINqC9IinttnZp8FohPAjB0bqOus8sgWmbJ?=
 =?us-ascii?Q?LW7c5uNeDiazFjb4SH5lvd25YHvOnD3qg6iPKqbzb9TQfJ/IDSeJWZ4YBeaC?=
 =?us-ascii?Q?1jxaBcP4+oUYgklzvOcw66xY0gRGvojN1yXYQ5cME4HYWaP5jyzzR3b20go?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b22a7f-49a2-4871-a6fe-08ddaa921183
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 15:50:49.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7243

From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, June 10, 2025 11=
:46 AM
>=20
> From: Michael Kelley <mhklinux@outlook.com> Sent: Tuesday, June 10, 2025 =
9:17 AM
> >
> > From: Arnd Bergmann <arnd@arndb.de> Sent: Tuesday, June 10, 2025 8:46 A=
M
> > >
> > > On Tue, Jun 10, 2025, at 17:33, Roman Kisel wrote:
> > > >> Selecting SYSFB causes a link failure on arm64 kernels with EFI di=
sabled:
> > > >>
> > > >> ld.lld-21: error: undefined symbol: screen_info
> > > >> >>> referenced by sysfb.c
> > > >> >>>               drivers/firmware/sysfb.o:(sysfb_parent_dev) in a=
rchive vmlinux.a
> > > >> >>> referenced by sysfb.c
> > > >>
> > > >> The problem is that sysfb works on the global 'screen_info' struct=
ure, which
> > > >> is provided by the firmware interface, either the generic EFI code=
 or the
> > > >> x86 BIOS startup.
> > > >>
> > > >> Assuming that HV always boots Linux using UEFI, the dependency als=
o makes
> > > >> logical sense, since otherwise it is impossible to boot a guest.
> >
> > This problem was flagged by the kernel test robot over the weekend [1],=
 and I
> > Had been thinking about the best solution.
> >
> > Just curious -- do you have real builds that have CONFIG_HYPERV=3Dy (or=
 =3Dm)
> > and CONFIG_EFI=3Dn? I had expected that to be a somewhat nonsense confi=
g,
> > but maybe not.
> >
> > Hyper-V supports what it calls "Generation 1" and "Generation 2" guest =
VMs.
> > Generation 1 guests boot from BIOS, while Generation 2 guests boot from=
 UEFI.
> > x86/x64 can be either generation, while ARM64 is Generation 2 only. Fur=
thermore,
> > the VTL2 paravisor is supported only in Generation 2 VMs. But I'm not c=
lear on
> > what dependencies on EFI the VTL2 paravisor might have, if any. Roman -=
- are
> > VTL2 paravisors built with CONFIG_EFI=3Dn?
> >
> > > >>
> > > >
> > > > Hyper-V as of recent can boot off DeviceTree with the direct kernel=
  boot, no UEFI
> > > > is required (examples would be OpenVMM and the OpenHCL paravisor on=
 arm64).
> > >
> > > I was aware of hyperv no longer needing ACPI, but devicetree and UEFI
> > > are orthogonal concepts, and I had expected that even the devicetree
> > > based version would still get booted using a tiny UEFI implementation
> > > even if the kernel doesn't need that. Do you know what type of bootlo=
ader
> > > is actually used in the examples you mentioned? Does the hypervisor
> > > just start the kernel at the native entry point without a bootloader
> > > in this case?
> >
> > Need Roman to clarify this.
> >
> > >
> > > > Being no expert in Kconfig unfortunately... If another solution is =
possible to
> > > > find given the timing constraints (link errors can't wait iiuc) tha=
t would be
> > > > great :)
> > > >
> > > > Could something like "select EFI if SYSFB" work?
> > >
> > > You probably mean the reverse here:
> > >
> > >       select SYSFB if EFI && !HYPERV_VTL_MODE
> >
> > Yes, this is one approach I was thinking about. However, this problem
> > exposed the somewhat broader topic that at least for ARM64 normal
> > VMs, CONFIG_HYPERV really does have a dependency on EFI, and that
> > dependency isn't expressed anywhere. For x86/x64, I want to run some
> > experiments to be sure a Generation 1 VM really will build and boot
> > with CONFIG_EFI=3Dn. Then if we can do so, I'd rather add the correct
> > broader dependency on EFI than embedding the dependency just in
> > the SYSFB selection.
>=20
> I've built and tested x86/x64 Generation 1 VMs with CONFIG_EFI=3Dn,
> and I don't see any problems. No build-time EFI dependencies have
> accidently crept into the Gen1 code paths over the years. Since
> Roman has confirmed that VTL2 images do not use EFI, we could
> express CONFIG_HYPERV's broader dependency on EFI as:
>=20
>      depends on EFI if ARM64 && !HYPERV_VTL_MODE
>=20
> which would allow building an image without EFI for an x86/x64
> Generation 1 VM. The newly added "select SYSFB" entry would do the
> right thing and stay unchanged.
>=20
> An alternate viewpoint is that we've always built Hyper-V x86/x64
> guest images to be portable between Generation 1 or Generation 2
> VMs, and that allowing x86/x64 images with CONFIG_EFI=3Dn for Gen 1
> VMs only isn't necessary. In that case we could just add
>=20
>    depends on EFI if !HYPERV_VTL_MODE
>=20
> I lean slightly toward the first of the two, and not requiring EFI on
> x86/x64 if someone really wanted to build an image that only runs
> on Gen 1 VMs. But the downside is that someone who built such an
> image might be surprised it won't run on a Gen 2 VM. Anyone at
> Microsoft want to weigh in on the choice?
>=20
> Michael

What I suggested doesn't work. The "depends on" statement
doesn't take an "if" clause. :-(

There are other ways to express the HYPERV dependency on EFI that is
conditional. But if the condition includes HYPERV_VTL_MODE (which
it needs to), then there's a dependency loop because
HYPERV_VTL_MODE depends on HYPERV. So that doesn't work
either.

To solve the immediate problem, we'll just have to do

    select SYSFB if EFI && !HYPERV_VTL_MODE

Separately, if we want to express the broader dependency of
HYPERV on EFI (at least for ARM64), then the dependency of
HYPERV_VTL_MODE on HYPERV will need to go away. Three
months back I had suggested not creating that dependency [1],
but the eventual decision was to add it. [2, and follow discussion]
We would need to revisit that discussion.

Arnd -- if you'd prefer that I submit the patch, let me know.
I created the original problem and can clean up the mess. :-)

Michael

[1] https://lore.kernel.org/lkml/SN6PR02MB4157B22BD56677EFBD215D87D4BE2@SN6=
PR02MB4157.namprd02.prod.outlook.com/
[2] https://lore.kernel.org/linux-hyperv/20250307220304.247725-4-romank@lin=
ux.microsoft.com/

