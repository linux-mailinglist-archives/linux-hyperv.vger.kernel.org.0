Return-Path: <linux-hyperv+bounces-5273-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419CFAA5804
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 00:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC0C7B2F1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB222618F;
	Wed, 30 Apr 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ljRqVG6s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013071.outbound.protection.outlook.com [52.103.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65689225A3E;
	Wed, 30 Apr 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746052785; cv=fail; b=HFVwFbmV7smUSuxow808lO8/HVl8nSaMjnChqjAb1Oh4/DJDSj/zyW6pAokuVf+hpSENhn2rBDoRZt3oUCeZR5NN3dngytByLbxwye7ctk+nx9pBvD/xfhqYHQ0GFjrvOUSEAabrleAgwZApaGpg4JmbSl9a9cQ+pWLKuAHjv7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746052785; c=relaxed/simple;
	bh=byY24aHFIVHFI/nuoUX57NOmmO33B2A94GefzIcxsrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LEDt/8rZBNQnLQK47YmzyogkhSBpWuM4rryLr2mcp7JjxD7ul4piMbn6h/gv7L5i58SxyHQ2Lsp2GiRuAeYLp2/+zZZlefMvwRbnhvRcfPZog/mW6RVHw+qbQgEhYsdTqkMR1l6VuIS3MMjE5zebAmZnaMZEoNO/0Dp8SwpS6hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ljRqVG6s; arc=fail smtp.client-ip=52.103.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlFl7Filf6qryv0+mvohDQ/M6qL4yghaC4pOgLXbc6G6eH2K2mbOpEr8pWTPrSaih6MT6LasftLTRD/8BYqL4k+noIIp8TgMOXsjLfIm/pXdlga9W870IqLx3K+33aNsGEOD/tw4KyuqW/YUitN0+6+EeNLM1ubnfIVxxZMMueS6DT248wzZiFfERxpg0aRNWwJrf+3ic2O5CdMAyTSdVP6BYoIDVd6Ul6h9f0AJvfvJkkhuoXPKL1o2pX+ypYLIEa7ganYgoNwXbTsWHfI3AbzZLe11mAbAwGafICniIukfADMFILiRQafSFgKQ81doJcVrOfUFotf7Skxtjz0vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKDuGgLvSzjPuzDuwUNt0EI0NsHO1aPkQwgkNuW4hfs=;
 b=CwZQrPbYf9gPtpEYfXDsFi+d+W+u3MPuwwqhUsY65khjNJIiS2p0K7SHYIGGiBY4MGfbdermBoejuQ05HmEiSe9Z3turKz+1Dkqf/b7zbv/ytJ6AQwBuicmIpTCL2i7U9tj0FWKejj+LZAZ8kvmbkeX/R+pieJytK1UCyqlpK1LQsuUH0BeBlfqvGjy1MMQuxrRSJF30hD1SG8oNaskLY/GmdKFoHn6yortrX/ZDH4+sBGibYImsPWDmdf2GtN5Ey/gbu1e6Tj9bFr3g4jV4a6lU19E4z8kyu0QnFktJumyZyRjXPM9YxEtSgGJa4jQcZb8M3fCpDzs8axDERidDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKDuGgLvSzjPuzDuwUNt0EI0NsHO1aPkQwgkNuW4hfs=;
 b=ljRqVG6sJneCZ7wvhAQxX5OPRp+gzYZ4jYoRvAqojC6wTBsYFOhdtMFMNg4SDstD/Lz9c/Euwm3IVvwq29lFhSlqvcbDm3FbQWCgnCD4NONm80XmE7Em2mFJ4bW1LVMahpbltMaBYVDhBdpL+k4jxk32xLNX72MUwpzufGILL8tSzLjze2k6ljQKcpoJdOadvgbQ+ZbTi/UrvBTtMWqiWu8BvCor6ZwVgLwUkpqeJ8cUj4BW3yruKMu3OAkSe/w2Xf9aDs1BNx/ywYdbX+AI1RHyggid/sKlfbu7pN+bSKNwONLVxGqzdcd/04EfBBvmMHOOZuoAtOXHXM+rvVKsUA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8504.namprd02.prod.outlook.com (2603:10b6:510:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 22:39:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Wed, 30 Apr 2025
 22:39:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "dimitri.sivanich@hpe.com"
	<dimitri.sivanich@hpe.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"imran.f.khan@oracle.com" <imran.f.khan@oracle.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"jgross@suse.com" <jgross@suse.com>, "justin.ernst@hpe.com"
	<justin.ernst@hpe.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"kyle.meyer@hpe.com" <kyle.meyer@hpe.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>, "papaluri@amd.com"
	<papaluri@amd.com>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "russ.anderson@hpe.com" <russ.anderson@hpe.com>,
	"steve.wahl@hpe.com" <steve.wahl@hpe.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "xin@zytor.com" <xin@zytor.com>,
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Thread-Topic: [PATCH hyperv-next v3] arch/x86: Provide the CPU number in the
 wakeup AP callback
Thread-Index: AQHbuhFEBuvITqnc2UO2yvXkMm+4rbO8yr/w
Date: Wed, 30 Apr 2025 22:39:38 +0000
Message-ID:
 <SN6PR02MB415780229941BD1668547945D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250430204720.108962-1-romank@linux.microsoft.com>
In-Reply-To: <20250430204720.108962-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8504:EE_
x-ms-office365-filtering-correlation-id: ac84e45a-8cf8-4437-51de-08dd8837e3ea
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|8062599003|461199028|102099032|1602099012|10035399004|3412199025|4302099013|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IZi+fKVkIA4EB+G8/+Kf+feyiTP0vga3E3+/s+ijAP4Jb38tDBrkwciCp6UV?=
 =?us-ascii?Q?xiP0KQjdTI+t8RsT/gk91fQcwzOZA+OG81zWnO8t7hQuhEwSmlxhIoz5W++U?=
 =?us-ascii?Q?cN3IPgontJ2ZKKWhH10QQ0CFkGe1S/csXtOEkUiBIaJXYfYQ5Q/UaHMwF0tn?=
 =?us-ascii?Q?MzTnuud2TdBcW/jYiQmRfR8/RxwGHU12Fcioo2Hf8xU57yXcSOgme0pRsy8M?=
 =?us-ascii?Q?b9Wf8ibD0j/sJbe2LTY5dlyEv63at6uWb06wuLbYyi1ayr0xyFvmNgG46VVk?=
 =?us-ascii?Q?wdPR/4tbtgfQ/emNRRXnIEMQOgXjFc9zb/MykTQcP4KXoz6TODMtUxPxeQO7?=
 =?us-ascii?Q?7pY5ZmIauA11X5jxQ+FQlJ7W1bpxC+x3chGynt7uwwzY0uw0hVYHXBxrNLwv?=
 =?us-ascii?Q?CPQYSserOOLLzMhujo5XlSZ2JR37PFRiBzoX+oG8tizgChBUbvTNwKaSYfka?=
 =?us-ascii?Q?0nc5nZHwkDJY38vDcBVNyRCf+n4AlnCJIuVYx7u8XRuE5QwSYqKxftMjAlmp?=
 =?us-ascii?Q?RyPadNmFbQDh7ilfr1VbEKGMhQLcJqsq4/4cz8T19FojU/J/xy0WYqRP4POf?=
 =?us-ascii?Q?LFz4pkqwmS4TbCb9G5PQH6brJEWnPPavvuR9NJn/EZ2eeqtncw2sMKtJ5EEw?=
 =?us-ascii?Q?OouPPzULg2e80XZpLcHAZN81glKtfdQHV32CJVR1i9WbDXuqd/Fu8OwenyPU?=
 =?us-ascii?Q?BbZpxD2ThwfkNhEuiGoE8ya9tAVxeUzbQb8aykz1bjGYg9lEcugZvlpk9odq?=
 =?us-ascii?Q?FoiZU8K3Jz0BVVipL7jErUw9gvtfJjBiBhL5I+yiyu4V0U0HnL+qusQLSVI4?=
 =?us-ascii?Q?FLsHznaqJmTEqjDrZDNKVOEodstbPqRDQzZjZhXJcK8z3RV4K/h+tZzXgHAH?=
 =?us-ascii?Q?XoeFelnJei5kHlpL0KfEXB+G5KAGQox7IkClbPNxyVTDyrhPzIlIm6tEyETl?=
 =?us-ascii?Q?k+A4Vx2oRfJDYg9PhdnbF92Psdhd3ohG9DM8qKmZN88MkkyOIQuTew/YCoDJ?=
 =?us-ascii?Q?Xe3oGzRbPbGxep7H0IZDQaw4LgvxY6UXZWgspIB07phulv/dV101nXMOcQq9?=
 =?us-ascii?Q?Pr39COYnK+tLS++VBO0iSeREN4EaLK7J5HFVNEDg0RzwQ7acqUMdR4XbLYYT?=
 =?us-ascii?Q?It7TUyQd48qgNFgPLi5A1epn92mfqwSO4YlWgeHGiUGpjbRfnhwpSNs1pRQx?=
 =?us-ascii?Q?gnTLZwrJJu+BFymStDOxEq707mmXH+9AhuhviLyucvlq6zhZqEUIcvoU0RxP?=
 =?us-ascii?Q?MYTSX7zTpENtojS9o4vDx7vU8WkupZP2K7EOHQYM8ulDvv5DDKI4jtIF0Y1+?=
 =?us-ascii?Q?tJ2e8ZwZVy2f0qwXh4ZhEQd0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q3iqyxhAvF/sSNf5iq9TCXn2cwj9QBw9rUBpstJHDyy90R368UWVwcmXAY14?=
 =?us-ascii?Q?P2quNVi8Kyl6VDt7+X9bKkgLPUqU5fHZeFufzTG6rtkFur+o9wXIm3kjCkoa?=
 =?us-ascii?Q?DpSChWZCm35hgcAzaZpNM1HlxSuO+dmgJjcaa5cbJSAb5GQg3fJ48pSItQZ+?=
 =?us-ascii?Q?raSuyC7/UDNLfsb7qPWrCu2fEQH8VfQKl8mwmLYndfRD0EVcxDpUC6cdfRvD?=
 =?us-ascii?Q?wJVJsoPjNgAXkQtmhUckctQC4iNx2cP/lo458lXY+OEGdLkNtNWHlsueE17y?=
 =?us-ascii?Q?hlQriLVxLcEPVDNdlWIlwkecelEBxciXgT+jSfRTcJUx9iS5bBspZ08LlTBs?=
 =?us-ascii?Q?BIygHjjCiw1PQBrq1YwucGJnnK+AwWWWfO35AW9nXvQfxdLLvf2OGU2+g37Y?=
 =?us-ascii?Q?zmTh74gehbu/K2pJEYD0kt2SPbl4BSOmGhha/mxTnSaSP1HYGrM8x31C4kqu?=
 =?us-ascii?Q?MVVmYttow3hOLHyZn1RN9JkOzpT611xfxPM0e0SEARCeBr4+S6THzpBA9YoT?=
 =?us-ascii?Q?IruPujIe4mtA5Z6CvMtrDKxUzxoemxKvqUtIgmPnJ4Ae18ubzTPGI1FWaXea?=
 =?us-ascii?Q?+o4+aQMXvCyWFXlMpcjCNC3NF3AMYP6FsHq/5NoB4kLKwfnEfgu8nrWWZlox?=
 =?us-ascii?Q?+YwKXOrc7ntz1SV1M8alqvixuo82F9QmgSVFAxNngECIW3ci4dByBHijjbXk?=
 =?us-ascii?Q?/KdL0O1jGlK+fKVu4vrCnnWImJMhJDFjtEQJ7kaf/maToa6X+PCkTN31mbYI?=
 =?us-ascii?Q?YrLbqdaltxQRdxrCNn2fT3ASd4mPL3KEaTx2JCn/rh6kLIZlJOi3PoBh3+O0?=
 =?us-ascii?Q?uHBSYzVBsVLjVWD065xKW0j+r3s0cPAsFZ2QXIyuhsvmO4lUP2mKeAjByZv6?=
 =?us-ascii?Q?CjfFlQ3tRv6gqRjdUchGsZNrWNfCfypdDabuWi0ka6B75mOQBEN1BaSOupfT?=
 =?us-ascii?Q?Nlz3GiUd7jphCC0ZCMUctzANF1iTz+UI/Xy4u21y+EUB+wFv2akdK5RvfEwT?=
 =?us-ascii?Q?hmNsOlhWO/M7pxNSMLIlHQPAKdKZbAtXdwv38lGmPjreFXJCfdZcNMGJCxhV?=
 =?us-ascii?Q?ncZRJHbCYITzywLiogmwJfP9CsUjI+i2xlDWBiJT/aiK6pyYDjb30nyItYDd?=
 =?us-ascii?Q?f1XgLKZRRYKko+P7OtKq0JnnA5f81MiuOBh85QrABZY77TlcwHRuiWNMPJh7?=
 =?us-ascii?Q?q1sVgEZnexHvSQ9rJaTsj3VyxDr2CEqE8gILSQNYBeqefeUyul/7mhxPe88?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac84e45a-8cf8-4437-51de-08dd8837e3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 22:39:38.4664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8504

From: Roman Kisel <romank@linux.microsoft.com> Sent: Wednesday, April 30, 2=
025 1:47 PM
>=20
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
>=20
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.
>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

LGTM.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
> The diff in ivm.c might catch your eye but that code mixes up the
> APIC ID and the CPU number anyway. That is fixed in another patch:
> https://lore.kernel.org/linux-hyperv/20250428182705.132755-1-romank@linux=
.microsoft.com/
> independently of this one (being an optimization).
> I separated the two as this one might be more disputatious due to
> the change in the API (although it is a tiny one and comes with
> the benefits).
>=20
> [V3]
> 	- Fixed the cpu nummber to be unsigned int within the patch and
> 	  in the do_boot_cpu() function.
> 	** Thank you, Thomas! **
>=20
> [V2]
> 	https://lore.kernel.org/linux-hyperv/20250430161413.276759-1-romank@linu=
x.microsoft.com/
> 	- Remove the struct used in v1 in favor of passing the CPU number
> 	  directly to the callback not to increase complexity.
> 	** Thank you, Michael! **
> [V1]
> 	https://lore.kernel.org/linux-hyperv/20250428225948.810147-1-romank@linu=
x.microsoft.com/
> ---
>  arch/x86/coco/sev/core.c           | 13 ++-----------
>  arch/x86/hyperv/hv_vtl.c           | 12 ++----------
>  arch/x86/hyperv/ivm.c              |  2 +-
>  arch/x86/include/asm/apic.h        |  8 ++++----
>  arch/x86/include/asm/mshyperv.h    |  5 +++--
>  arch/x86/kernel/acpi/madt_wakeup.c |  2 +-
>  arch/x86/kernel/apic/apic_noop.c   |  8 +++++++-
>  arch/x86/kernel/apic/x2apic_uv_x.c |  2 +-
>  arch/x86/kernel/smpboot.c          | 10 +++++-----
>  9 files changed, 26 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 82492efc5d94..8b6d310b61b9 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1179,7 +1179,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_are=
a *vmsa, int apic_id)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, u=
nsigned int cpu)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> @@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsi=
gned long start_ip)
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
> -	int cpu, ret;
> +	int ret;
>  	u64 cr4;
>=20
>  	/*
> @@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, uns=
igned long start_ip)
>=20
>  	/* Override start_ip with known protected guest start IP */
>  	start_ip =3D real_mode_header->sev_es_trampoline_start;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apic_id))
> -			break;
> -	}
> -	if (cpu >=3D nr_cpu_ids)
> -		return -EINVAL;
> -
>  	cur_vmsa =3D per_cpu(sev_vmsa, cpu);
>=20
>  	/*
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..4d6e0e198041 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -237,17 +237,9 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	return ret;
>  }
>=20
> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
> +static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip, unsigned int cpu)
>  {
> -	int vp_id, cpu;
> -
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apicid))
> -			break;
> -	}
> -	if (cpu >=3D nr_cpu_ids)
> -		return -EINVAL;
> +	int vp_id;
>=20
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..6025da891a83 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area =
*vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu=
)
>  {
>  	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index f21ff1932699..33f677e2db75 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -313,9 +313,9 @@ struct apic {
>  	u32	(*get_apic_id)(u32 id);
>=20
>  	/* wakeup_secondary_cpu */
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsign=
ed int cpu);
>  	/* wakeup secondary CPU using 64-bit wakeup point */
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, uns=
igned int cpu);
>=20
>  	char	*name;
>  };
> @@ -333,8 +333,8 @@ struct apic_override {
>  	void	(*send_IPI_self)(int vector);
>  	u64	(*icr_read)(void);
>  	void	(*icr_write)(u32 low, u32 high);
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip, unsign=
ed int cpu);
> +	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, uns=
igned int cpu);
>  };
>=20
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 07aadf0e839f..cab952f722e4 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,12 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
> hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu=
);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { retu=
rn 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip,
> +		unsigned int cpu) { return 0; }
>  #endif
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c
> b/arch/x86/kernel/acpi/madt_wakeup.c
> index d5ef6215583b..f48581888d53 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -169,7 +169,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vecto=
r)
>  	return 0;
>  }
>=20
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip, unsigned =
int cpu)
>  {
>  	if (!acpi_mp_wake_mailbox_paddr) {
>  		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs.
> Booting with kexec?\n");
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic=
_noop.c
> index b5bb7a2e8340..58abb941c45b 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,13 @@ static void noop_send_IPI_allbutself(int vector) { }
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip=
) { return -1; }
> +
> +static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip=
,
> +	unsigned int cpu)
> +{
> +	return -1;
> +}
> +
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2=
apic_uv_x.c
> index 7fef504ca508..15209f220e1f 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -667,7 +667,7 @@ static __init void build_uv_gr_table(void)
>  	}
>  }
>=20
> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip,=
 unsigned int cpu)
>  {
>  	unsigned long val;
>  	int pnode;
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index c10850ae6f09..b013296b100f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -715,7 +715,7 @@ static void send_init_sequence(u32 phys_apicid)
>  /*
>   * Wake up AP by INIT, INIT, STARTUP sequence.
>   */
> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long =
start_eip)
> +static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long =
start_eip, unsigned int cpu)
>  {
>  	unsigned long send_status =3D 0, accept_status =3D 0;
>  	int num_starts, j, maxlvt;
> @@ -862,7 +862,7 @@ int common_cpu_up(unsigned int cpu, struct task_struc=
t *idle)
>   * Returns zero if startup was successfully sent, else error code from
>   * ->wakeup_secondary_cpu.
>   */
> -static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
> +static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct =
*idle)
>  {
>  	unsigned long start_ip =3D real_mode_header->trampoline_start;
>  	int ret;
> @@ -916,11 +916,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct =
task_struct *idle)
>  	 * - Use an INIT boot APIC message
>  	 */
>  	if (apic->wakeup_secondary_cpu_64)
> -		ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
> +		ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip, cpu);
>  	else if (apic->wakeup_secondary_cpu)
> -		ret =3D apic->wakeup_secondary_cpu(apicid, start_ip);
> +		ret =3D apic->wakeup_secondary_cpu(apicid, start_ip, cpu);
>  	else
> -		ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip);
> +		ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip, cpu);
>=20
>  	/* If the wakeup mechanism failed, cleanup the warm reset vector */
>  	if (ret)
>=20
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> --
> 2.43.0
>=20


