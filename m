Return-Path: <linux-hyperv+bounces-5144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C3DA9CC82
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3577BB26D
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D0274644;
	Fri, 25 Apr 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eI3nG7kX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2104.outbound.protection.outlook.com [40.92.40.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC1F26C398;
	Fri, 25 Apr 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593960; cv=fail; b=T2Z8aqTN3Wfuq6E1ERTCbQfe/Cz7enk3pdQmD/HUn+W2evctYwHQH5BJkwupV0obZk9hrK9jJdtpAYU4ECenhvGeR1o0yu1z/U3mdHk5V/Z5xOx1wwsripBhosc0hEsE2pno0ge+5PreNlTTjHlum9GU/Xs8rvFNAjqaJ8kFBWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593960; c=relaxed/simple;
	bh=pSYu7l4rkY0eMLubXvMtblC6Z7H2QS27yNZy+L50g58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQbBtMaj5E0S7n+HT8EsnmNbkSTr3Gb3elV4HpQMqggwHDGaiPdO46PRRUGt9aZqUtT1M7zwIjWNyNK8yav+j7z++OdmjoKJFbfo4uPN2fZzVz19abji4l7bCj67/5+TSVnZ1gAJtgaIjcy2Nn32UCLxOvBwytP6tgqrQ/DLONc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eI3nG7kX; arc=fail smtp.client-ip=40.92.40.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFUPxebjfwDMdq5lBPOAxLHWK0pQ3D3YwGc/NhwlQsU5NrTFKLZClsRXOUHrXeZASXfW/G8cuhVkw6NqsGqep/Omo0/bVpeO+xsI62GHpqiZpNcRhdY1N/SmIzXy4/eIZVwerKVPnRkWrPPwjwDiqh2c4ZbI1e/pFpFV9zt9nMscE8xVlsFoeUIYYEcXzETADRxJSp9iVjy/Y/+mHaBu4terzg+NLvTRFFjj8XvOO2mI48m4Y5NrDaGpF6xuvlP53zezBN4cnBPM5PEClRcjCGf8kINitHPlYlcz2nQ6oR8yMKCXh0y6btxCmui9WaK664DxsSvXzgVch8crBXC6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aqmJZje0n1JBdlrd/h3l04QGtd+8i4Ca2BatzfC8Uk=;
 b=ZHKQG3dddXm92uQMhnSlNzoEoxwb3GJG1HKvyl0TpWPd3iEWoT47GbUDkMtP7r/dNAxNzn3wioelCttooYeFUcUrJd/aZ+IJGNLBV/RwxEv25b2QtMMx0MeiZlvEkZ9QOkAXHAS2yCT0bvbj3tju+KNgSTCEQxz1jGh1n+LTs47CxXvqEftAUNLd8J59rTOvaoEz+wnilW1/WAKvI7gR6D73ymn8EyIR8OV+Qr698Qk1CnDbVR3wXZ6fgxQ2ODAY6D9X9yl4HmUlx/oCLcl2V8crhMx8OWXEl570BWrLKCqMTqefxtz8mQRvTl4ch7pchc4k7cbg0/zt3soyOPxiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aqmJZje0n1JBdlrd/h3l04QGtd+8i4Ca2BatzfC8Uk=;
 b=eI3nG7kXHXEecbOnBWWVXfvavXhvZs79dyRshAr2/gLI9XxEc0MlqOZWRc2P7JjbjqbOyai6iOsmrwEgmN7ep9Q4SzuEZgULgHauRDlXWozuG+CTpdG8swF8fvmksLSMVof7HDJS+aJvgUxwzJoLp90oCxV9k+snQ9U9sUeX4QtD11Y0cvSgWO53OLirO91jPUwAWy2mhlUIPaIk0u3SFK4X+g1wMRJTdVdHprsiLg0GhiLVNWhAIPtfTYclwDFdz0WqAUEkQMtr5pALb4FYmUvv/hgbqdxHYV8IXmBhMcxSJb13T+shiA9LdhEPbJLXP7LcMcf1J31QwCv3iUY4Yg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7785.namprd02.prod.outlook.com (2603:10b6:806:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 15:12:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Fri, 25 Apr 2025
 15:12:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
Thread-Topic: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
Thread-Index: AQHbtWP/lXselMmje0eXkN1PFNQSB7O0dQJQ
Date: Fri, 25 Apr 2025 15:12:34 +0000
Message-ID:
 <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
In-Reply-To: <20250424215746.467281-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7785:EE_
x-ms-office365-filtering-correlation-id: 07f560c0-3ae4-4324-159b-08dd840b9b6e
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6dEoOZOj4tPAZubvlSTC8VXqm3BLxEDY5mjJlDwbXtQ81YgFn1wkrijrl7iCaKraMx45hhSRApQvrBLeme4YWxyu0vkvTdoHpz7BdBxdRa80y4+LSiDZoJjv3DRKLzsIpkMGpysIevs/+fg2mutFlan1AKq1vkAmhNQEwpJ3D0O6n3mfH6GXKXJySQdP60ZvIeV1ktw1iaJePoZTqUhRLL1Y4JlDk/G/L9shj5T+So05Y+7KxbZPuaUaHMx2vKU/SZhFYMsEFu8XipGzWCpqx0pB2Q/Ca7UD5UBpX5GXlRFGR6kJNsTtVx0WeAX/dtPDTvE6kMsJACgRERypSSYzWVqanIRd0jnBkHihP+JcL4FVFkIwV1VP4Q4vOYVEYsBEFXk2Rm36dD60JU/XXjj/FSRO0exErLkv4Pj1yCw/hNhEtyZb52jzrYIpXY+Dz0hqLDVbZMVL6hrcK7thtyqBd4+ZNvtD5M7YsS9lbUz8OMk/V6qUIzuZkeqBTny0tF76tG07YoZP4xByqElr9RFsRBBFV9UTzS3+ylrSMBaWde7djSBYkpqPKQJNUhNRqAPTyAyqWV52X6KO6h6GjjDZeU+PYpZh0cQG0XvmZXO3gRhe6cHGxKSYFpbhs7Juu2TBwdg3DFnOlZ4NtIUTyyEec7D7zEqqQpapayr7dBgMjcAAwhZcLfZ24ri9/k2Z/8k3SQPB3jhRjEJR/7QSmsSoZw7muFlOcZOrShSr84PYf33vqzVfVBsrGdKru/vjEvnKkQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|12121999004|8062599003|461199028|8060799006|15080799006|440099028|3412199025|41001999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uVdiQun1h6D25+C9EmlMWv5JLm/jshHgzyu/79N2D2/XmW/56hSE1olectxH?=
 =?us-ascii?Q?6F9UcAlAlUvlE5Ok9YF1tWSbBx+Ex1Kyryk3bbYviTY9+AxLKx747n1/jN13?=
 =?us-ascii?Q?xSgjjud1oN69jtmUKT3hp2iiTOaf6xypN0fNw2pdvMdnfdrcBqLpDvthlgRw?=
 =?us-ascii?Q?6El6kJDM9+cnRdIitcbJJdPGlK2GqWW9oWhFizLOGlqISwr9Z45PgG7Z0eZn?=
 =?us-ascii?Q?+4j5ZIYblkpPICLNP347isvFSIafSH60Og9tnypb0JycT0mKOXFsZCF1glQq?=
 =?us-ascii?Q?aNn8TZGhFee8fC21041XKb4SYJC/Jo7Gbhh6Nd7hOvEIvKuIL6v5ww7dSlQd?=
 =?us-ascii?Q?Sef8QHK8dSQU4Zn36XtU43ud6oMI7csJaSukaoXJ8raP48up8OHN3wmOxfZK?=
 =?us-ascii?Q?sZvbX7RUu1Wf7GT+cEfR1oSWR5Dtji3lLpCpqC6SQmfsI1vadMziK1UJS67+?=
 =?us-ascii?Q?ADITI6lVq6X818sZvP37g2buZ0w5LvjaPFaj9qnVUQRQsIKFdl4WiNrKn5js?=
 =?us-ascii?Q?XSPMO+Z9AIB2yGs6RKKaEKbzxyu5VBVRpeZIbzJBKCHxNalTPmb6CsCXtqtB?=
 =?us-ascii?Q?B7yX+vGpmGn5oDSyQ6xnp2zXnsqJ8yjO0WMLXqnHE2itk0h01UyZr4NZM6Ot?=
 =?us-ascii?Q?pf5gGdkmtJwsjH8Jy5gkOpE0uEJmTb4pC+P0qv6bXlnyXcB3NK/H1IDoxGx5?=
 =?us-ascii?Q?wZ4050yanE+4Qpb+O6gHgdxK9qMdSnNHbnGWbBk8rir87dMKKvsxqBXUUsTr?=
 =?us-ascii?Q?4lU7DbdTJzK1JmwT9LvTfAs8PfEI1p565xAQ+XyH7sPfa/0kZ4QYJOqNDqm9?=
 =?us-ascii?Q?C62WQCqT/2iJBfT2w3yeXDz6qEPqxBXkzgWeH1JTsuAobNwL4tODc2gcUSiV?=
 =?us-ascii?Q?1a6fumqDZNv6yuPTb9bZvOZ8UmjtilB7gjqhdlYKfjb6t+ggxJEIXb0EOInN?=
 =?us-ascii?Q?n0zqePDlbRR2zHePRVjvaWqZ5D3yemyyEzkIjOSOTGqe2UTlAItQzT+ri69t?=
 =?us-ascii?Q?kJBLuB9MCnGbqqveSIvRBSmUcIOxSQudUi3zREktLHASJtAhbBFyVTfx4M/y?=
 =?us-ascii?Q?Ool7VPGgwU2bGjkKeoGiN4NoYFU+X632DlGtveMWxwfPokb/eQd4ARSDr/50?=
 =?us-ascii?Q?2+v3f5G0+jK9ClMvU2TWv6BZ0yx+4eATkg91icBJ6lF9zaSvipU00A3izoix?=
 =?us-ascii?Q?pmLR71ZIEHbfjLiw?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/igAv5T43ZVTIbQbz4XidFWJHE2xa6PmbKZNh7DDd9oivWaql5S8eXUID7s7?=
 =?us-ascii?Q?Mk2/3zV8/nGnis4PVINnf+05e7lg6OxD+NQIz+z+sn2qj3G0GJcCTNnLKy84?=
 =?us-ascii?Q?uL1mt4ksfo8a0pFqzFBVR6Wcd/9wIwMMzacvWgtVFhUZDuPFBm5zCgRzuYx8?=
 =?us-ascii?Q?lwZF6/4rnDjgRZfrfORGhaC0BwvO2HKoJXZBkRkRN2HeQXetkvQr7cpdSLcR?=
 =?us-ascii?Q?AO5Y+BoAZHr2jZYUeGIc2KN4CAy45rCmcbda4y2I+QWi1LIjV4rBlj038k5D?=
 =?us-ascii?Q?uikakN3qoandMU4OouF8VUawD+UskLukYRYzFMb8oYliasvh+bFDnBAJ8r0+?=
 =?us-ascii?Q?qxgSBfcxozJIbabP3PqEGKLrguaeIpfKD6TxIK8HvgJV9XtLzbp8LVyipihb?=
 =?us-ascii?Q?J1Gh0bKQNBO87bCTeQOCZ3XpCNlBosMQ1A4II5Ba/V5210a1pbBr1g7qDVEa?=
 =?us-ascii?Q?ah6fRWmtgIRQ7JwpJyLImVQNmA1g+/Fg460ZVMBxBcnItkdbblgTssHUh+hm?=
 =?us-ascii?Q?8IrxAB5qq7LugToB67in8Yo5sysrRUBWcxQ6ioGjE1S9BBLT3BoS+/1KlCAd?=
 =?us-ascii?Q?aRTgHSXbZCWWhzr/Qx1XQsOkEzQA3cAFLo80uFAw/ZIS1VGyCljAh/apugqP?=
 =?us-ascii?Q?qCemH32BEW1MkYErRk48A//ecIeqmaHXRZLWEzpigss5U76QKa9/TqxXbpd7?=
 =?us-ascii?Q?y21SYHxE00tICI0WgMWIAS0pUyNKeN1cSCd7UNgDfCCOnu9rEY5gsy6sLFBC?=
 =?us-ascii?Q?8WxFOZfysrZ6IKqr0mzXRocxJPEpgZofwsLXnOXI/2LBJVATvnIsCuflZL5u?=
 =?us-ascii?Q?FZfuuPR8pP8bMPgOeYhA0zHtkFwB5+kj6w5tahU9RIB0wHe5mqUFl0n9whFe?=
 =?us-ascii?Q?W21GBTkrApvL0cfat57tsps2vOHAoOno2dUo94BZMd5Bq4S/KRFAORHFlyul?=
 =?us-ascii?Q?mqYKpqaRQHF9y/jHasIr8HeNSZhMaIPuowrP2BeSt2ls4Dl+bNjvaiBVWZ8J?=
 =?us-ascii?Q?U3AF7oF4mZcUqo14U6g5M/ihpnsp1thbhKt1jpW3l0gXhw/MVOojQNpvMhlu?=
 =?us-ascii?Q?l8FAldRfBaQkYPZy5da50u9K9JP9f6iFcbrgybuLvXdiuCPOW/2OAYcHZjUm?=
 =?us-ascii?Q?Get7w5idid07jiD76UXci0Cn5vE5NYdiHPJ43CaAvF/UQZ8dfQ9QR+b2NM/1?=
 =?us-ascii?Q?ykQI1U8zHB2SZDwlnnb9xCE+sgqZNoApsMPK4TT6pRXkBpmcnugHCcxtHxA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f560c0-3ae4-4324-159b-08dd840b9b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 15:12:34.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7785

From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, April 24, 20=
25 2:58 PM
>=20
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that START_VP hypercall but passes as VP ID to it what
> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>=20
> As those two aren't generally interchangeable, that may lead to hung
> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
> whereas VP IDs never are.

I agree that VP IDs (a.k.a. VP indexes) and APIC IDs don't necessary match,
and that APIC IDs might be sparse. But I'm not aware of any statement
in the TLFS about the nature of VP indexes, except that

   "A virtual processor index must be less than the maximum number of
   virtual processors per partition."

But that maximum is the Hyper-V implementation maximum, not the
maximum for a particular VM. So the statement does not imply
denseness unless the number of CPUs in the VM is equal to the
Hyper-V implementation max. In other parts of Linux kernel code,
we assume that VP indexes might be sparse as well.

All that said, this is just a comment about the precise accuracy of
your commit message, and doesn't affect the code.

>=20
> Update the parameter names to avoid confusion as to what the parameter
> is. Use the APIC ID to VP ID conversion to provide correct input to the
> hypercall.

Terminology:  The TLFS calls this the "VP Index", not the "VP ID".  In
other Linux code, we also call it the "VP Index".  See the hv_vp_index
array, for example.  The exception is the hypercall itself, which the TLFS
calls HvCallGetVpIndexFromApicId, but which our Linux code calls
HVCALL_GET_VP_ID_FROM_APIC_ID for some unknown reason.

Could you fix the terminology to be consistent?  And maybe fix the
HVCALL_* string name as well.  I know you are just moving the
existing VTL code, but let's take the opportunity to avoid any
terminology inconsistency.

>=20
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       | 33 ++++++++++++++++++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c        | 34 +--------------------------------
>  arch/x86/hyperv/ivm.c           | 11 +++++++++--
>  arch/x86/include/asm/mshyperv.h |  5 +++--
>  4 files changed, 46 insertions(+), 37 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ddeb40930bc8..23422342a091 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
>  	return hypercall_msr.enable;
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> +
> +int hv_apicid_to_vp_id(u32 apic_id)
> +{
> +	u64 control;
> +	u64 status;
> +	unsigned long irq_flags;
> +	struct hv_get_vp_from_apic_id_in *input;
> +	u32 *output, ret;
> +
> +	local_irq_save(irq_flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->apic_ids[0] =3D apic_id;
> +
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> +	status =3D hv_do_hypercall(control, input, output);
> +	ret =3D output[0];
> +
> +	local_irq_restore(irq_flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> +		       apic_id, status);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_apicid_to_vp_id);
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 582fe820e29c..8bc4f0121e5e 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -205,38 +205,6 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, =
int cpu, u64 eip_ignored)
>  	return ret;
>  }
>=20
> -static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> -{
> -	u64 control;
> -	u64 status;
> -	unsigned long irq_flags;
> -	struct hv_get_vp_from_apic_id_in *input;
> -	u32 *output, ret;
> -
> -	local_irq_save(irq_flags);
> -
> -	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(input, 0, sizeof(*input));
> -	input->partition_id =3D HV_PARTITION_ID_SELF;
> -	input->apic_ids[0] =3D apic_id;
> -
> -	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -
> -	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> -	status =3D hv_do_hypercall(control, input, output);
> -	ret =3D output[0];
> -
> -	local_irq_restore(irq_flags);
> -
> -	if (!hv_result_success(status)) {
> -		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> -		       apic_id, status);
> -		return -EINVAL;
> -	}
> -
> -	return ret;
> -}
> -
>  static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_e=
ip)
>  {
>  	int vp_id, cpu;
> @@ -250,7 +218,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, un=
signed
> long start_eip)
>  		return -EINVAL;
>=20
>  	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> -	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> +	vp_id =3D hv_apicid_to_vp_id(apicid);
>=20
>  	if (vp_id < 0) {
>  		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c0039a90e9e0..e3c32bb0d0cf 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area =
*vmsa)
>  		free_page((unsigned long)vmsa);
>  }
>=20
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
>  {
>  	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
>  		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> @@ -297,10 +297,17 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	u64 ret, retry =3D 5;
>  	struct hv_enable_vp_vtl *start_vp_input;
>  	unsigned long flags;
> +	int vp_id;
>=20
>  	if (!vmsa)
>  		return -ENOMEM;
>=20
> +	vp_id =3D hv_apicid_to_vp_id(apic_id);
> +
> +	/* The BSP or an error */
> +	if (vp_id <=3D 0)

Returning an error on value 0 may be problematic here. Consider
the panic case where a CPU other than the BSP takes a panic and
initiates kdump. If the kdump kernel runs with more than 1 CPU, it
may try to start the CPU that was originally the BSP. To my
knowledge, SEV-SNP guests on Hyper-V don't support kdump at
the moment so this problem is currently theoretical, but let's not
leave a potential future problem by excluding 0 here.

Also, since I assert that we really don't know anything about the
VP index values, we can't exclude 0.  It may or may not be the
original BSP.

Michael

> +		return -EINVAL;
> +
>  	native_store_gdt(&gdtr);
>=20
>  	vmsa->gdtr.base =3D gdtr.address;
> @@ -348,7 +355,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
>  	start_vp_input =3D (struct hv_enable_vp_vtl *)ap_start_input_arg;
>  	memset(start_vp_input, 0, sizeof(*start_vp_input));
>  	start_vp_input->partition_id =3D -1;
> -	start_vp_input->vp_index =3D cpu;
> +	start_vp_input->vp_index =3D vp_id;
>  	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
>  	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 07aadf0e839f..ae62a34bfd1e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct
> hv_interrupt_entry *entry);
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
>  #else
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { retu=
rn 0; }
> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip) { =
return 0; }
>  #endif
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> @@ -329,6 +329,7 @@ static inline void hv_set_non_nested_msr(unsigned int=
 reg,
> u64 value) { }
>  static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0; }
>  #endif /* CONFIG_HYPERV */
>=20
> +int hv_apicid_to_vp_id(u32 apic_id);
>=20
>  #ifdef CONFIG_HYPERV_VTL_MODE
>  void __init hv_vtl_init_platform(void);
>=20
> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> --
> 2.43.0
>=20


