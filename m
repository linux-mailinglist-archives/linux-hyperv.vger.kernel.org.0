Return-Path: <linux-hyperv+bounces-5231-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7088AA41A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 06:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD14666E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 04:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659411D54E3;
	Wed, 30 Apr 2025 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e8d/CUya"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011031.outbound.protection.outlook.com [52.103.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6C1AA1FF;
	Wed, 30 Apr 2025 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985910; cv=fail; b=SwHNc3tALBddW4BPGqYQ4SO2cn7ZfN2IvXizaGKT8+SIOug84uNm5J5BwwwXTSB22RA/viRWBjnA4sGoFbZC6DUShHqYjwlB1cXir7CEU3Qm4cf4oWVfQY3aj3FuW8V1Jk4Hl4R0Dh2P9jJAUTNO5e++DtkR2aJ4AmI89ygnBM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985910; c=relaxed/simple;
	bh=jAAGZyvJzASSIv6zmFF1gxE3Jtjb6u7+VpqofxWwF34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/JFZK44u4MTtkaY5yAZhqW53JS+5gJOr010vxKX0oEwm9wHBMyB3E336yNHLoszyohEyjbgNHMZW3EB3VM70/CiJNMmIaym00XH3XXfdInJrXGlop4026c1Mq7EO1EgT1JDoVi+nCUKy4KyHrYx0c3mW31A69nhpJ+CHsMEO5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e8d/CUya; arc=fail smtp.client-ip=52.103.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouLpjL4UGgw8T2iDtW/QjN9eWYTbRPRdO1ZoL4GYvObWEL8WTEKNrliuyc6uU5qWPCjRYHaPF3CQuc/0vv29hEzD7XW7B/Q/gd3hN1ko2OZzb8YO2SJHjlnFLPk//RoAKAjpQrPJfJm8Tefi1jquTFX10kGPkLptljejMWdQKQzJdrdErYtNXCWobWkA9kcFVexcqa/BvWrQaClBSgTrH7HlGWTBh2ke/BQrkjhrDu3GkDB+lQIvjUIRZNQExjxax/zgWfaABV8GZZAO1iqbPwj519lkxB4NFbd5m2GLul+d1LPEoNcK+hcDZ+oIUnvsML7fb5OAUis+BPKEVdCq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxEQEDqI8SzQBGIVaA2iYPodeA6f2VqK+IDbz/SLWgc=;
 b=ak0rf4i8HWs8WSWV6g1FHiw63AYSEUI9fm//Dh7XWdsbwrN4l+JlUNsd2+p1u+7u7wESCqZwIjosiNj4hg2r07tDcZIkyITMzj6sdzrwqJzgzf7dgkXiwwJ7tTKOLwDePllgznJTw9SSFVwZLEJ4vUJPea+8Rcztpn9zRRODQ7L4MeYV07WSaPpE7AtCEF3Isk5VaMb/9KpHvLoFFGKLUYJAsnx+fLIBlicVl0U4bE9kPCQmPpk1pqG82tiAPR8pPOHptyEL8rBQotDQ3tFwIPz4zfXk1dFoLKA9GbyVSbfovUI4MNDWIk427NhszAz8vcLvk/MIS/Y/nfDvz0rsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxEQEDqI8SzQBGIVaA2iYPodeA6f2VqK+IDbz/SLWgc=;
 b=e8d/CUyamTwxaUCnnBEcIs+4mg/Uu8YbbmA8U2uACg0/z2h9hbOQMcc5/UEXkt+cXa+tfacjHtJFYwGa1dW0Vz59X6oB70EEW3KXlVie5vUf64HA01GBe1ikwHdr0yESEaPvTamLjFvIx5G01ccqKraaHxTEexecdk110fDXLxmh93G77ZmLAYpXPxFj8PAPQKUSrikDgokKNPVA9JcU9r5ztYjs2s8aCUqaGu2F1OD+XOINRJrgqE7cbm70mXdj3egHV000UvYOGB5rqQarFH57d5IAJmilZAUi//O0kwhL1VZgVmzILEy3mqysU7glwjrHGBo6PwCs7W9JivbXDw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8892.namprd02.prod.outlook.com (2603:10b6:208:3b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 04:05:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Wed, 30 Apr 2025
 04:05:03 +0000
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
Subject: RE: [PATCH hyperv-next] arch/x86: Provide the CPU number in the
 wakeup AP callback
Thread-Topic: [PATCH hyperv-next] arch/x86: Provide the CPU number in the
 wakeup AP callback
Thread-Index: AQHbuJFlLO1f1d8ZxkSbk/55UHkW7LO7kqVA
Date: Wed, 30 Apr 2025 04:05:03 +0000
Message-ID:
 <SN6PR02MB4157D83C50EC47D816DB9574D4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250428225948.810147-1-romank@linux.microsoft.com>
In-Reply-To: <20250428225948.810147-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8892:EE_
x-ms-office365-filtering-correlation-id: 675825ae-6325-4bfe-da9c-08dd879c2f71
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|8062599003|15080799006|461199028|56899033|3412199025|440099028|102099032|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0nMDYyJdVorx9dmMjSd5Q4gd//67z2UozEkMrKV4Hg79OPgjJeKAQCm/nM22?=
 =?us-ascii?Q?Dh6BaE7g7LVy1b0Po0ZshJmEOG1PdSJtF6/calg3jaO6I0DPzONZ0u55NgtA?=
 =?us-ascii?Q?rPCTxlwq1Dz6EHAk8RC/E+14LAYCM9L5PcIqgQXdaffzuu5A50Xv6VIW0wJi?=
 =?us-ascii?Q?twJkTjesWxC6lMs/5/28GUpLDWvskUJ/4I+FUHtCkDvWzd+4x+rMTpp+2mtq?=
 =?us-ascii?Q?j43PdFlKtIlSOCJZcc0Vg6SefO+ym158+xCrMDaPd/kCWis68YkZtjyzGnzb?=
 =?us-ascii?Q?UAKRWhGK00lYZx/JdY3QKWEuFqiOFsl15xmgtG/yycHvrNMuBBX/QZBSlf4v?=
 =?us-ascii?Q?KbbPcAce/0vCDMsW6f5dIyGYDcCjN7YhOfKNG5dNbTM9vzTYXadMI4SR+IDc?=
 =?us-ascii?Q?HyxsfIE0m6pUVqzJiM4TFmS/vj/cW/sOsTTGbXHX3SAdl6pPa8ryICo2JHHR?=
 =?us-ascii?Q?J1dHsajQyiZEcjSLgZ09m67lO7v8U/RUvoCK3ue60zEOP3KxzihJZZVy000z?=
 =?us-ascii?Q?w21R5HeytbCC5CwTFeRT+0KlvyNorFDNSPi5aLqlpaaE/WqPIgOEnqk71z/o?=
 =?us-ascii?Q?34a9ERYkG5bmR0KGk8K3jwkwUaeS/czocUkSYX2OS4U2ibxGAkOtKsriFHzU?=
 =?us-ascii?Q?ihhqZDI/JUQqSZjYQAbKf70aaYJdy/uA073aBSFjNyE6JnBShvIEeqiWk4j1?=
 =?us-ascii?Q?c807i/DWyylXP1hq920kgBwdSVKi4GRJamWSJ547HWJdstwjkuXfXcUNDwkM?=
 =?us-ascii?Q?EISbtS2H/81J8N8bTZzS1bGx+ebqZ1o8zWJW53tO0ZddNjwnn8xeWUIUeLzD?=
 =?us-ascii?Q?jLjnv7MX7qMM0rZJsEL52WIAZTOL633WTdi/U5+nF4oj+Axkpd4XTb99WtpD?=
 =?us-ascii?Q?fwacYEEQnw37wbN1/A+/8v7riPToUN6+eBUfufRB6SJOblf3suGjKXpoLOBV?=
 =?us-ascii?Q?DNJCkGOWgZuqG9xZQmxq30LrJMLX7/zAtSrAxqYNzjrnZHW04SOOKGD+UkWj?=
 =?us-ascii?Q?xc9ok0pfgYaDl4wwdLUx+l98Ux9JWnvSEGwG6XnlChJJ7PRMHhgyNlzYcjFb?=
 =?us-ascii?Q?zFQUSOQZSSFKD0+BnEMipRO+Yt7e7ITUWjorhHQUwkjS9CwjBHPJd0fTLrVn?=
 =?us-ascii?Q?5i2JrIZHKXajnToAz/cxBY7XLN51jDRDIw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SdTK10YhnSNP/eID/cTdxxJmwmmTj581r7n0YpUgRU+tXCz71c9ngeVt5840?=
 =?us-ascii?Q?N4uK9Jsky36KMAI4l4VLHXifYXv8BGWsBufrEsPUODcmBO3a1Fqf6NUeRadP?=
 =?us-ascii?Q?Z1jXum73saGhlmkkGJrBHWDeK2PwAaTVou1SF7o49mGEV/J0/FB1ALq+p0Jj?=
 =?us-ascii?Q?q7mVhV2/3WEVjkEegQ9dsf1KmexwiIufpIEwaupdrvkn4n4mrmtf/3Y3XlIx?=
 =?us-ascii?Q?mDLSl4DexiZXMk4iR5U0s/Tm42PbjBeNXfgw4QC/WPUtKUuLwlFqRfWk1PT3?=
 =?us-ascii?Q?r/H1x/O4XfXdmtV5vYTSW3SGp87wTEDXi4LxTsADlWqwHYI27KQdJYXTMASi?=
 =?us-ascii?Q?rN+juhMcpPJHUW/bL2ZzBltLwlve25g40UKrMf3ViJVgSAOGkPxEuUI1951o?=
 =?us-ascii?Q?BDR7l9CYyrClBlF+R01fjFrcPLFNjSgJCI/az5HDdjApkaksqJrRC7ySXML+?=
 =?us-ascii?Q?ElPEd5S9TxFClHefwoeUFrebilurWZ3iFwp1wTPU/bMlIuQX8ii9HJjEv6j1?=
 =?us-ascii?Q?AoixYC9ERXECWrPlzzf+OePjbCX8IPpNwaq6LAmQv1zM5agXN2RqDk1TA8zV?=
 =?us-ascii?Q?cFbqbdj2SDJUEg3T/t3ERWzdz9IuVlYFWucMn3wVszBIUVb9nOLhg+UFpCJ4?=
 =?us-ascii?Q?dZHUl7XCrHcbf97onO5slxYuXm3tsTDSmxbeHPNINyvklLmBYmPS2IPnANLd?=
 =?us-ascii?Q?EOqV6ZJeC4qywpP730n2ObAm41Bm2Kk2+1/OH3O05rSxR2nxEgPFamGDMfFN?=
 =?us-ascii?Q?UX+I7t1hrKqvolb685/h2sKSlk5VAm3oqShNl5BBQLCC88DDxAmeL1vLSDtk?=
 =?us-ascii?Q?9jUReKxKR8dl2No5EBsO0twRSKuSFHk3g/mjL5TpWKa3wtEdUxKHlyAnCPOe?=
 =?us-ascii?Q?/jJc6wWeVemcm5Nx1ufLOvbRGCfQCzIh2kFAp/Vs4u9GzhJPV8bv2giRBhJm?=
 =?us-ascii?Q?DZAuRjneowxNHXFI92cw9fDUoRo66uIuMqljBXKTXlEzmJVzxwCl3OsXgKvm?=
 =?us-ascii?Q?JdzO5WYlKLJm0A0O/f6WD9F4DUg6Hoy/1Qe5mIUuHdUrTy1cdzVDptqN60LE?=
 =?us-ascii?Q?9/H/RAZJRv5Oy6w1YXw/r/BFIP9f6poQfcYQyjINVue/DP8idZr/OZACyNF+?=
 =?us-ascii?Q?Sfruti/+wFAwfX2EosP65GCAYa70gMcVadfGuRH+3PBL3+4i6Y6f8WenGboc?=
 =?us-ascii?Q?Ue49N1SywnStjZKGF+3IyMiILXyh+kXwFwj368N5vHkuhFXtixKcQsWoiAA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 675825ae-6325-4bfe-da9c-08dd879c2f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 04:05:03.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8892

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 28, 2025=
 4:00 PM
>=20
> When starting APs, confidential guests and paravisor guests
> need to know the CPU number, and the pattern of using the linear
> search has emerged in several places. With N processors that leads
> to the O(N^2) time complexity.
>=20
> Provide the CPU number in the AP wake up callback so that one can
> get the CPU number in constant time.

This patch aligns with my original suggestion and brings the expected
benefit in runtime and in code simplification. But to me, introducing
struct wakeup_secondary_cpu_data seems a bit unnecessary. The
secondary wakeup functions currently have two arguments, and
increasing that to three arguments is not problematic. I usually see
structures introduced when the argument count gets into the 6 or
more range, and there are multiple call layers that need those same
arguments (such as the TLB flushing code, for example). In those
cases, adding a structure makes sense.

But in this case, quite a few lines of code get added to define local
variables and to pull values out of the structure and into those local
variables, all of which would be avoided if the three arguments just
remained as individual arguments. Adding a structure perhaps makes
it easier to add a 4th argument should the need arise, but that seems
unlikely and could be dealt with when and if it actually happened.

So I'd say drop the structure, and just pass "cpu" directly as a
3rd argument.

Michael

>=20
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/coco/sev/core.c           | 18 ++++++++----------
>  arch/x86/hyperv/hv_vtl.c           | 17 +++++++----------
>  arch/x86/hyperv/ivm.c              |  8 +++++++-
>  arch/x86/include/asm/apic.h        | 14 ++++++++++----
>  arch/x86/include/asm/mshyperv.h    |  5 +++--
>  arch/x86/kernel/acpi/madt_wakeup.c |  8 +++++++-
>  arch/x86/kernel/apic/apic_noop.c   |  2 +-
>  arch/x86/kernel/apic/x2apic_uv_x.c |  7 ++++++-
>  arch/x86/kernel/smpboot.c          | 19 +++++++++++++++----
>  9 files changed, 64 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 82492efc5d94..063f176854fd 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1179,17 +1179,24 @@ static void snp_cleanup_vmsa(struct sev_es_save_a=
rea *vmsa, int apic_id)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
> +static int wakeup_cpu_via_vmgexit(struct wakeup_secondary_cpu_data *wake=
up)
>  {
>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>  	struct ghcb_state state;
> +	unsigned long start_ip;
>  	struct svsm_ca *caa;
>  	unsigned long flags;
>  	struct ghcb *ghcb;
>  	u8 sipi_vector;
>  	int cpu, ret;
> +	u32 apic_id;
>  	u64 cr4;
>=20
> +
> +	cpu =3D wakeup->cpu;
> +	apic_id =3D wakeup->apicid;
> +	start_ip =3D wakeup->start_ip;
> +
>  	/*
>  	 * The hypervisor SNP feature support check has happened earlier, just =
check
>  	 * the AP_CREATION one here.
> @@ -1208,15 +1215,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, uns=
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
> index 582fe820e29c..7ed3c639d612 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -237,17 +237,14 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  	return ret;
>  }
>=20
> -static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
> +static int hv_vtl_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data =
*wakeup)
>  {
> -	int vp_id, cpu;
> +	unsigned long start_ip;
> +	u32 apicid;
> +	int vp_id;
>=20
> -	/* Find the logical CPU for the APIC ID */
> -	for_each_present_cpu(cpu) {
> -		if (arch_match_cpu_phys_id(cpu, apicid))
> -			break;
> -	}
> -	if (cpu >=3D nr_cpu_ids)
> -		return -EINVAL;
> +	apicid =3D wakeup->apicid;
> +	start_ip =3D wakeup->start_ip;
>=20
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
>  	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> @@ -261,7 +258,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, un=
signed long start_eip)
>  		return -EINVAL;
>  	}
>=20
> -	return hv_vtl_bringup_vcpu(vp_id, cpu, start_eip);
> +	return hv_vtl_bringup_vcpu(vp_id, wakeup->cpu, start_ip);
>  }
>=20
>  int __init hv_vtl_early_init(void)
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..6037cabc1ae0 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <asm/apic.h>
>  #include <asm/svm.h>
>  #include <asm/sev.h>
>  #include <asm/io.h>
> @@ -288,7 +289,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area =
*vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup)
>  {
>  	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> @@ -296,11 +297,16 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	struct desc_ptr gdtr;
>  	u64 ret, retry =3D 5;
>  	struct hv_enable_vp_vtl *start_vp_input;
> +	unsigned long start_ip;
>  	unsigned long flags;
> +	u32 cpu;
>=20
>  	if (!vmsa)
>  		return -ENOMEM;
>=20
> +	cpu =3D wakeup->cpu;
> +	start_ip =3D wakeup->apicid;
> +
>  	native_store_gdt(&gdtr);
>=20
>  	vmsa->gdtr.base =3D gdtr.address;
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index f21ff1932699..7e660125f749 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -262,6 +262,12 @@ extern void __init check_x2apic(void);
>=20
>  struct irq_data;
>=20
> +struct wakeup_secondary_cpu_data {
> +	int cpu;
> +	u32 apicid;
> +	unsigned long start_ip;
> +};
> +
>  /*
>   * Copyright 2004 James Cleverdon, IBM.
>   *
> @@ -313,9 +319,9 @@ struct apic {
>  	u32	(*get_apic_id)(u32 id);
>=20
>  	/* wakeup_secondary_cpu */
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
>  	/* wakeup secondary CPU using 64-bit wakeup point */
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
>=20
>  	char	*name;
>  };
> @@ -333,8 +339,8 @@ struct apic_override {
>  	void	(*send_IPI_self)(int vector);
>  	u64	(*icr_read)(void);
>  	void	(*icr_write)(u32 low, u32 high);
> -	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
> -	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
> +	int	(*wakeup_secondary_cpu)(struct wakeup_secondary_cpu_data *data);
> +	int	(*wakeup_secondary_cpu_64)(struct wakeup_secondary_cpu_data *data);
>  };
>=20
>  /*
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 07aadf0e839f..62c64778ad01 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -6,6 +6,7 @@
>  #include <linux/nmi.h>
>  #include <linux/msi.h>
>  #include <linux/io.h>
> +#include <asm/apic.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <hyperv/hvhdk.h>
> @@ -268,11 +269,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
> hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeup);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { retu=
rn 0; }
> +static inline int hv_snp_boot_ap(struct wakeup_secondary_cpu_data *wakeu=
p) {
> return 0; }
>  #endif
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c
> b/arch/x86/kernel/acpi/madt_wakeup.c
> index d5ef6215583b..5de1bd4e49ed 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -169,8 +169,14 @@ static int __init acpi_mp_setup_reset(u64 reset_vect=
or)
>  	return 0;
>  }
>=20
> -static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
> +static int acpi_wakeup_cpu(struct wakeup_secondary_cpu_data *wakeup)
>  {
> +	unsigned long start_ip;
> +	u32 apicid;
> +
> +	start_ip =3D wakeup->start_ip;
> +	apicid =3D wakeup->apicid;
> +
>  	if (!acpi_mp_wake_mailbox_paddr) {
>  		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting =
with kexec?\n");
>  		return -EOPNOTSUPP;
> diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic=
_noop.c
> index b5bb7a2e8340..dd4ba29042f9 100644
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -27,7 +27,7 @@ static void noop_send_IPI_allbutself(int vector) { }
>  static void noop_send_IPI_all(int vector) { }
>  static void noop_send_IPI_self(int vector) { }
>  static void noop_apic_icr_write(u32 low, u32 id) { }
> -static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip=
) { return -1; }
> +static int noop_wakeup_secondary_cpu(struct wakeup_secondary_cpu_data *d=
ata) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2=
apic_uv_x.c
> index 7fef504ca508..b76f865c31ef 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -667,11 +667,16 @@ static __init void build_uv_gr_table(void)
>  	}
>  }
>=20
> -static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
> +static int uv_wakeup_secondary(struct wakeup_secondary_cpu_data *wakeup)
>  {
> +	unsigned long start_rip;
>  	unsigned long val;
> +	u32 phys_apicid;
>  	int pnode;
>=20
> +	phys_apicid =3D wakeup->apicid;
> +	start_rip =3D wakeup->start_ip;
> +
>  	pnode =3D uv_apicid_to_pnode(phys_apicid);
>=20
>  	val =3D (1UL << UVH_IPI_INT_SEND_SHFT) |
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index c10850ae6f09..341620f1e1fe 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -715,8 +715,14 @@ static void send_init_sequence(u32 phys_apicid)
>  /*
>   * Wake up AP by INIT, INIT, STARTUP sequence.
>   */
> -static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long =
start_eip)
> +static int wakeup_secondary_cpu_via_init(struct wakeup_secondary_cpu_dat=
a *wakeup)
>  {
> +	unsigned long start_eip;
> +	u32 phys_apicid;
> +
> +	start_eip =3D wakeup->start_ip;
> +	phys_apicid =3D wakeup->apicid;
> +
>  	unsigned long send_status =3D 0, accept_status =3D 0;
>  	int num_starts, j, maxlvt;
>=20
> @@ -865,6 +871,7 @@ int common_cpu_up(unsigned int cpu, struct task_struc=
t *idle)
>  static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>  {
>  	unsigned long start_ip =3D real_mode_header->trampoline_start;
> +	struct wakeup_secondary_cpu_data wakeup;
>  	int ret;
>=20
>  #ifdef CONFIG_X86_64
> @@ -906,6 +913,10 @@ static int do_boot_cpu(u32 apicid, int cpu, struct t=
ask_struct *idle)
>  		}
>  	}
>=20
> +	wakeup.cpu =3D cpu;
> +	wakeup.apicid =3D apicid;
> +	wakeup.start_ip =3D start_ip;
> +
>  	smp_mb();
>=20
>  	/*
> @@ -916,11 +927,11 @@ static int do_boot_cpu(u32 apicid, int cpu, struct =
task_struct *idle)
>  	 * - Use an INIT boot APIC message
>  	 */
>  	if (apic->wakeup_secondary_cpu_64)
> -		ret =3D apic->wakeup_secondary_cpu_64(apicid, start_ip);
> +		ret =3D apic->wakeup_secondary_cpu_64(&wakeup);
>  	else if (apic->wakeup_secondary_cpu)
> -		ret =3D apic->wakeup_secondary_cpu(apicid, start_ip);
> +		ret =3D apic->wakeup_secondary_cpu(&wakeup);
>  	else
> -		ret =3D wakeup_secondary_cpu_via_init(apicid, start_ip);
> +		ret =3D wakeup_secondary_cpu_via_init(&wakeup);
>=20
>  	/* If the wakeup mechanism failed, cleanup the warm reset vector */
>  	if (ret)
>=20
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> --
> 2.43.0
>=20


