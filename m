Return-Path: <linux-hyperv+bounces-5153-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C150A9CF07
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5066C3B1C1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB719992D;
	Fri, 25 Apr 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lTvBs5ut"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2015.outbound.protection.outlook.com [40.92.18.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A542CCC1;
	Fri, 25 Apr 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600148; cv=fail; b=apK/zuq5VR0oYtUPr/BBhMk4PCPFOq7hM6fkQ0r/6Rp18R+aOhKo++mRdIpeMkoi2LpeQURUwuSfQmldBFkNBCMBNcqRjCTNR7iBg2w2BGhcNMfDPlAbAq2G923fc7svmR4KVRoGC6kfjc9xmItn8Xs6mqbfE6+u3xgk0mByYeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600148; c=relaxed/simple;
	bh=iITVv0xW+HDuGDbmQcVYQiNl1BUAVV+TsNI1YPpQJTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cH4jhWGkoyJ8DPKadTcTsb/jR3VCjxGHjUTpCt155MNyJanEZOlNBos04UUUPoC6ZsJFBhCkQ9YgMGtwjMzJYeBy07YfNNMulojz5IdzElht2eh/YEN/r2XYgflM+4sx/eW95h4kUgu6+QDduquBoQzy/2dFuo5xfl7tCU2b66k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lTvBs5ut; arc=fail smtp.client-ip=40.92.18.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crRec37OEmbycY0ZhB0Kwp4KDJX9Uv/qVtjBSpzWEZ59QOiIqX9uei8KueTXXQkYE90TkzSJLPT5Sw+KFNuaKXqnw4PDr7bjCLeNIk4ShwMi9zSeVSGLqT+PC840qbNV/y+ieYKrT9Tugf3+p8TGH+cYkYZ+tgFZiIcI5b+7JL+LLqfy9GSzo6l5uzSXlYdU9t5+rKFUSVhdawm+S+aWbcSx32sELUY4AdWVS86JWojkWoy1GMhsSF3wLhkQveUVJVjtGM07Dm/1Ghm5f7H39L67IIc6v9GnXQJRXr+GfDZLSOO8vY1IQBJ3koUKWZclLOCfDGd0Y5OMFRWxuZ8Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMBQOUxfvewdfKOBgQy6oXHYgj+I56e4nV5kDrhUEaA=;
 b=wFSiprBP/1i3HpuLy3e1sSKJ2FVX3hOqxI+D6AFLGvDmXPUiV+/ZVefr3Wn4+xRtmRx+rkmtPVMy6m9hW9LtrVy9h7NdKfyRW9vRznxeU1m1T6SqhtBPqOGNk7NkwniStF3JV/7nAddiWx3uGE2vuGBjsTsBbtp40ASirlFI2I8XCuFO6pfZhY8hrgjHmxxmUO+R1nQlM9gJ9FpjmG4CghyF0nxbZaJuRo+NDgvctwDDu9DaG1t3Pf0GvDV7omv+gq6TiSIZaIQzY25dkxhJB2HrDlfgQ4Hul6aDe0SOB2pWRhhl6mZeGzEgB+mTdQrUjIV3P3idiS05gDnR8+p+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMBQOUxfvewdfKOBgQy6oXHYgj+I56e4nV5kDrhUEaA=;
 b=lTvBs5ut/3CHyWlNXcRXmTr17DNA6Dexm7RNyNyzrX6IprCJuvoooP8/TAtjCKrqKoXeLBiEsAZGDp8UoV/heqLSilNIHSm3yqAtK74hyLexsOAGsOJcXw6VHSnUU9YKFRvMKNlWnffGZR5C6bYybwdA1TdPoG50hU9ujvisF0JmI71OJUjVAqBzsUxqipYPWM1PmFP47Jvnsl+RJvvNyPOJ8THo1Z0iqtGDxzX8rcuN2ax5+kH5BW8XMIQDHcBHTlI58JcWhRI1ON4mQdddInHKgPQfLzZ3yoJIHk4MIGkY07BefT8bzpR6zdvBBy4c8H+XVaEsYAnv1rSHBGFeHA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7425.namprd02.prod.outlook.com (2603:10b6:303:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:55:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Fri, 25 Apr 2025
 16:55:42 +0000
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
Thread-Index: AQHbtWP/lXselMmje0eXkN1PFNQSB7O0dQJQgAAgaoCAAADhQA==
Date: Fri, 25 Apr 2025 16:55:42 +0000
Message-ID:
 <SN6PR02MB41577E8A06C9F8BA66A8D68AD4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <SN6PR02MB4157E849025C4A6B64933150D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8a235e4f-f4ce-445e-9714-380573033455@linux.microsoft.com>
In-Reply-To: <8a235e4f-f4ce-445e-9714-380573033455@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7425:EE_
x-ms-office365-filtering-correlation-id: 0593a250-5518-49d0-5478-08dd841a03cc
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwU46ctkesNAQSdI89rGQphJ1XIFBIpVdNgD/hrPFCv/amjlwhb8Z4s+pEbnyaccfuunt17GGYc3BUvaPq4OtGYroTJUZGOYjgRZXZJmonQQl0U3xLuxOaE3fBb90ytoAs6dqyHStBFpaPzXbyGoRyEWDgCp08/eO98wgjF6b9f5ka++dR8NRqXtsEBv3q5iQARxW9eBV8gOh8t+xsjMQWRzISlEoXeM2KKqVNx+KC+8Y3TcXft1vin4iwftXY3x88qXn/8cIS7BNbajigTZxCWvLhzTe4GFsS4O5MKtbX6CHPRzzkbayoqphS+PELyncMyyYtCO52Jl6mLMgsQ4xzmHVoPpEEvps7bEQYgvWIsSo/lYQdLCsW4lTXrWvGI1t69WpUJHaFt/AVRqztCXj2PrMbdzACg/hdCeD8NEQ96OJo+ONQ0e0nyAt/CM+Ed2AIUTriTi7H25cXCPjNEkTbj0SYZJtj++vKQryFpl7SxakiEHigaP0PEayFP8lS+H7oZimzAZrOkMN71cPo20XLjE0PMGpOEk1oBzjQqqoY3SHWbvzbaz5Ys4gpEsaVmh29AUFXKRnQPQDgPtCZ/ULp9BEIJD9FS8u7tbrMzeydQEOtAzjD7vPGI/0C7wk9A3c5N3wYAQGyQ3UzkyJlAplXSbh06VwVBQgee9iICvZlWNsdhLR/btyqaOIqN2z6T+xpfDeJKcDGdR0gmRU+Cq4QJUxdq43Sf5EiSeJXs/OSailDCwzFN8TuSfG3en2O7F/S4=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|15080799006|12121999004|19110799003|8060799006|102099032|3412199025|440099028|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JRdXTDy/JLqa+ZuTmvMsEprrPJvU2c8bf8UTI2cNVf9Q47UctTgCzhjiIFRr?=
 =?us-ascii?Q?foVojJMiuOuU22NmXoRkjSJ6Mue2YopFQ5Iez5tzPWbMqv9/uKH7FGT3LYZe?=
 =?us-ascii?Q?TOnIf9U3N7lEhw7/vSTWgAF6TYq0dkN2ERF3E6LPY+UOSB82g2kCUphUOHzz?=
 =?us-ascii?Q?Wn0oKLFfqeb0Uw1ZMk9VQej60LO0xv4Aw0ysR52TFu6nD3OwTkluqf2azxqh?=
 =?us-ascii?Q?35LBuyHVlxow4KzCBTIO+m0emKheLZiy8fGxgxNZrdEEdO90sBt2KVmacrs6?=
 =?us-ascii?Q?CNb19+uFoKe06mJwyrNIBaO5BD/2fGp8zYDOe0t9qsb/Vlb3QGMaSnEN5urZ?=
 =?us-ascii?Q?G02Mb6Ezylj99b6FB/oIh3WnjbMSx7CSQAy3KMDwRw+SiQBVTxg+rTbradTA?=
 =?us-ascii?Q?0t9YRo2C+uiyyCJXQC1ZKPo/8jS+FU9e9kdHYFwN21h7CehbbLWnpeu7XWnl?=
 =?us-ascii?Q?UmciN9AafJBP6a555nO18Q3ZJzQPYJ+K8Aa5KsiC20oxnQz8ElsPMygm+2Pu?=
 =?us-ascii?Q?QBEYp1hQzYd9za6r9F38BwqHdmao38h5Q2annV0qKIBtuX53dygKzGi+JdTR?=
 =?us-ascii?Q?5nq4fZEe/j0Ajxe6VZYC/vcgAuCepvCU6reC+6Hod7ONvinS7SwLVqb0zZur?=
 =?us-ascii?Q?rn5YlgVTPNgjxezgWUQS+gU5rM/ItANySOpFU4XmYV0Hn1dx2lZaKSB0fKzG?=
 =?us-ascii?Q?Ys26kDjwm0lpBPCx7wx0GjNkUNbtKWRq3tI4S+EB/j8iLXVUbCuicFHkcWe9?=
 =?us-ascii?Q?pFeocMj5vEslTQH8TjO2QIImhPok1rsw8eNY0sR6aq0nDZ5vB06AQgXHDC5h?=
 =?us-ascii?Q?cWJe+l82e4xTQfgrIQyU39ox93beOrbaN7dvUkXjynFYvEEJh7BiSpmwwtf/?=
 =?us-ascii?Q?DI/X93+fGXM6FxpQySLB+Un5GucJqTwirnvr5NbAqSx/xiZyKkus50KTcnME?=
 =?us-ascii?Q?pR14U9DPsryXazanD0HJy1hFUNDHyVItnJsqdSzie44v7/GXC5FX/V5csNE7?=
 =?us-ascii?Q?lberRyFWokC8GVo4eZAIfyfSoBeyc4ZfyX4ezjyrZq94PRjKHXcdzT8cdQXx?=
 =?us-ascii?Q?QgwaDWC3gMV6R+4McbfVXZKQL1vskBC2FmeyIOAkX33UaLBmlJcmVY9g9sRN?=
 =?us-ascii?Q?fSlWze7bjeVlV1kCtT4VS7nIs+AurZvfwI/XkcVDd6l6ZORIH0oBsa8HeC4O?=
 =?us-ascii?Q?pHIU2z1SRbbTJLLx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MAud3ocpwxxSRbvRN6p1IjCeYeejcJnVyZkFJe+UGc9Pggf1ZjF1ha3tcBru?=
 =?us-ascii?Q?dLdKQCD3MW+4sEswtunZu+xU4ap2qJvRyE0fJShtMmljN5lrygYPkbaES3pB?=
 =?us-ascii?Q?GnlTYjbqGVk5LqtecnJoHmIxdjUU2TRE6+Ee4pFW3NTDgFcKeR7xM05wSDp2?=
 =?us-ascii?Q?obZvw1+bk1goUSB25YxyBk3/YKZVZDF0i5GA0Xza5kY3mlb8tb0IQkXz51hx?=
 =?us-ascii?Q?ZWLFfhOjNbe/LCQc8ZT0+819O0iyD+HYWzLc48dxVWmRDOvuk+pqCCSDxLkN?=
 =?us-ascii?Q?1HUFknId5mc+lOvXUwIOwelzQ7qa634z4cmsI7Et7bUOpjuB6d5zF4uP/WHg?=
 =?us-ascii?Q?B+MRinTXASXlGL8uCgYva18h1uUkYw3LRRz0AZiKMC8VTcSk2AJDgW6SBc/e?=
 =?us-ascii?Q?QdOB2Z8AG0z0t7Z/DDiVw6WUPtmtz01HC0OY2XFUYJEL27dcTexGX3tyx5G1?=
 =?us-ascii?Q?5yivVwPN9dktSxmg4AyfqLsAIjzsP02hmRWVi7Q1IgAfGbjC9+DQP7yphd0D?=
 =?us-ascii?Q?P6JlaBwFOc9LKWwRVn5SS4I/hBhoO2zLF49ovHUb2ZLSuTq3LpNqkuVqxezP?=
 =?us-ascii?Q?H9eO1f2CyU+8nhu+UAlOXiUeNVB9SJpdx2pFgFUkFOEkyZ89NLdkaVtAJFW/?=
 =?us-ascii?Q?tdyPB8TMdDUmec7s3mj8KqaRq44jYeewvsUhKNYJJaVU6G6X4L6bKOVxMaYy?=
 =?us-ascii?Q?IYm2aIcfjc8a67+89+7ctEnnNfysThtj7J+wGJ7s/YUbxBjFwrB7Z2B3e+Qc?=
 =?us-ascii?Q?Aq8roX2mqhpKI1aydIYNk/9aOcGAEmaim1CtanDQnrI42mdQTxw6mCJAwdOG?=
 =?us-ascii?Q?xvVws6C4WJQHnVMzY7yqK91Aa/gZWDI0rAEeT6M5OZBfBkY1X/fwic698SrW?=
 =?us-ascii?Q?dHzMNOolD+90ur4FXgNyHPw7tqepYx1UWNuhfpqbgi2YHqVOVHrMaAJ3EGye?=
 =?us-ascii?Q?6KE1adPgXGvNJ3nl8mFDwA9aWF7wE/AbuV+Wu+d3qrld/TG2rjtEBR914yt6?=
 =?us-ascii?Q?SUYD3e1P64g8x5HAnogVx+xmGZElPJnZq8C8xTAJtCERaezJoKMBfLTCu7MN?=
 =?us-ascii?Q?oxDhbOuStOUVz2uDXzgoh9iUqIJXNUTFBXr8UaXHj8LBbe8fib9fkXq3DDW3?=
 =?us-ascii?Q?OrbtzFSyvxYHX8gPjhK3J7b/3g9emO/EEQnrAKLBl30btMslyuT4exi6vsbm?=
 =?us-ascii?Q?s+JqTLjLoxiAut1tBTttI1xPowEsLyEOlAoYqZfshL2FyTfkjQzCmU9ByPI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593a250-5518-49d0-5478-08dd841a03cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 16:55:42.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7425

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, April 25, 2025=
 9:36 AM
>=20
> On 4/25/2025 8:12 AM, Michael Kelley wrote:
> > From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, April 24=
, 2025 2:58 PM
> >>
> >> To start an application processor in SNP-isolated guest, a hypercall
> >> is used that takes a virtual processor index. The hv_snp_boot_ap()
> >> function uses that START_VP hypercall but passes as VP ID to it what
> >> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
> >>
> >> As those two aren't generally interchangeable, that may lead to hung
> >> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
> >> whereas VP IDs never are.
> >
> > I agree that VP IDs (a.k.a. VP indexes) and APIC IDs don't necessary ma=
tch,
> > and that APIC IDs might be sparse. But I'm not aware of any statement
> > in the TLFS about the nature of VP indexes, except that
> >
> >     "A virtual processor index must be less than the maximum number of
> >     virtual processors per partition."
> >
> > But that maximum is the Hyper-V implementation maximum, not the
> > maximum for a particular VM. So the statement does not imply
> > denseness unless the number of CPUs in the VM is equal to the
> > Hyper-V implementation max. In other parts of Linux kernel code,
> > we assume that VP indexes might be sparse as well.
> >
> > All that said, this is just a comment about the precise accuracy of
> > your commit message, and doesn't affect the code.
> >
>=20
> I appreciate your help with the precision. I used loose language,
> agreed, would like to fix that. The patch was applied though but not yet
> sent to the Linus'es tree as I understand. I'd appreciate guidance on
> the process! Should I send a v2 nevertheless and explain the situation
> in the cover letter?
>=20
> IOW, how do I make this easier for the maintainer(s)?

Wei Liu should give his preferences. But in the past, I think he has
just replaced a patch that was updated. If that's the case, you can=20
send a v2 without a lot of additional explanation.

>=20
> >>
> >> Update the parameter names to avoid confusion as to what the parameter
> >> is. Use the APIC ID to VP ID conversion to provide correct input to th=
e
> >> hypercall.
> >
> > Terminology:  The TLFS calls this the "VP Index", not the "VP ID".  In
> > other Linux code, we also call it the "VP Index".  See the hv_vp_index
> > array, for example.  The exception is the hypercall itself, which the T=
LFS
> > calls HvCallGetVpIndexFromApicId, but which our Linux code calls
> > HVCALL_GET_VP_ID_FROM_APIC_ID for some unknown reason.
> >
> > Could you fix the terminology to be consistent?  And maybe fix the
> > HVCALL_* string name as well.  I know you are just moving the
> > existing VTL code, but let's take the opportunity to avoid any
> > terminology inconsistency.
> >
>=20
> I percieved ID as both "index" and "identificator" I guess but maybe
> "idx" is more like "index". I'll send out a fix for the terminology,
> thanks for your help!

Yes, please just call it "vp_index", fully spelled out, as that's consisten=
t
with other Linux code for Hyper-V.

I briefly got confused because I searched the TLFS for the rules on
"vpid" or "vp_id", and found no matches. Then I remembered that
it is really "vp index". As for the connotations my brain assigns, "index"
is a modest integer suitable for indexing into an array, and the Hyper-V
VP index fits that description. OTOH, "id" has a much wider potential
meaning, including something as large as a GUID. Of course, given the
nature of connotations, other people might have different
associations. :-)

Michael

>=20
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> >> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> >> ---
> >>   arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++++++++=
+
> >>   arch/x86/hyperv/hv_vtl.c        | 34 +------------------------------=
--
> >>   arch/x86/hyperv/ivm.c           | 11 +++++++++--
> >>   arch/x86/include/asm/mshyperv.h |  5 +++--
> >>   4 files changed, 46 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> >> index ddeb40930bc8..23422342a091 100644
> >> --- a/arch/x86/hyperv/hv_init.c
> >> +++ b/arch/x86/hyperv/hv_init.c
> >> @@ -706,3 +706,36 @@ bool hv_is_hyperv_initialized(void)
> >>   	return hypercall_msr.enable;
> >>   }
> >>   EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
> >> +
> >> +int hv_apicid_to_vp_id(u32 apic_id)
> >> +{
> >> +	u64 control;
> >> +	u64 status;
> >> +	unsigned long irq_flags;
> >> +	struct hv_get_vp_from_apic_id_in *input;
> >> +	u32 *output, ret;
> >> +
> >> +	local_irq_save(irq_flags);
> >> +
> >> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> +	memset(input, 0, sizeof(*input));
> >> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> >> +	input->apic_ids[0] =3D apic_id;
> >> +
> >> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >> +
> >> +	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> >> +	status =3D hv_do_hypercall(control, input, output);
> >> +	ret =3D output[0];
> >> +
> >> +	local_irq_restore(irq_flags);
> >> +
> >> +	if (!hv_result_success(status)) {
> >> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> >> +		       apic_id, status);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(hv_apicid_to_vp_id);
> >> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> >> index 582fe820e29c..8bc4f0121e5e 100644
> >> --- a/arch/x86/hyperv/hv_vtl.c
> >> +++ b/arch/x86/hyperv/hv_vtl.c
> >> @@ -205,38 +205,6 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_inde=
x, int
> cpu, u64 eip_ignored)
> >>   	return ret;
> >>   }
> >>
> >> -static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> >> -{
> >> -	u64 control;
> >> -	u64 status;
> >> -	unsigned long irq_flags;
> >> -	struct hv_get_vp_from_apic_id_in *input;
> >> -	u32 *output, ret;
> >> -
> >> -	local_irq_save(irq_flags);
> >> -
> >> -	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >> -	memset(input, 0, sizeof(*input));
> >> -	input->partition_id =3D HV_PARTITION_ID_SELF;
> >> -	input->apic_ids[0] =3D apic_id;
> >> -
> >> -	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> >> -
> >> -	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> >> -	status =3D hv_do_hypercall(control, input, output);
> >> -	ret =3D output[0];
> >> -
> >> -	local_irq_restore(irq_flags);
> >> -
> >> -	if (!hv_result_success(status)) {
> >> -		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> >> -		       apic_id, status);
> >> -		return -EINVAL;
> >> -	}
> >> -
> >> -	return ret;
> >> -}
> >> -
> >>   static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long sta=
rt_eip)
> >>   {
> >>   	int vp_id, cpu;
> >> @@ -250,7 +218,7 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid,
> unsigned
> >> long start_eip)
> >>   		return -EINVAL;
> >>
> >>   	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> >> -	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> >> +	vp_id =3D hv_apicid_to_vp_id(apicid);
> >>
> >>   	if (vp_id < 0) {
> >>   		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
> >> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> >> index c0039a90e9e0..e3c32bb0d0cf 100644
> >> --- a/arch/x86/hyperv/ivm.c
> >> +++ b/arch/x86/hyperv/ivm.c
> >> @@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_ar=
ea
> *vmsa)
> >>   		free_page((unsigned long)vmsa);
> >>   }
> >>
> >> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
> >> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)
> >>   {
> >>   	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
> >>   		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> >> @@ -297,10 +297,17 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_=
ip)
> >>   	u64 ret, retry =3D 5;
> >>   	struct hv_enable_vp_vtl *start_vp_input;
> >>   	unsigned long flags;
> >> +	int vp_id;
> >>
> >>   	if (!vmsa)
> >>   		return -ENOMEM;
> >>
> >> +	vp_id =3D hv_apicid_to_vp_id(apic_id);
> >> +
> >> +	/* The BSP or an error */
> >> +	if (vp_id <=3D 0)
> >
> > Returning an error on value 0 may be problematic here. Consider
> > the panic case where a CPU other than the BSP takes a panic and
> > initiates kdump. If the kdump kernel runs with more than 1 CPU, it
> > may try to start the CPU that was originally the BSP. To my
> > knowledge, SEV-SNP guests on Hyper-V don't support kdump at
> > the moment so this problem is currently theoretical, but let's not
> > leave a potential future problem by excluding 0 here.
> >
> > Also, since I assert that we really don't know anything about the
> > VP index values, we can't exclude 0.  It may or may not be the
> > original BSP.
> >
>=20
> I believed that the BSP is always 0 yet as long as that's not in TLFS,
> that's not true, I agree on that. Probably not this function's job to
> check that the processor shouldn't be attempted to start, will fix!
>=20
> > Michael
> >
> >> +		return -EINVAL;
> >> +
> >>   	native_store_gdt(&gdtr);
> >>
> >>   	vmsa->gdtr.base =3D gdtr.address;
> >> @@ -348,7 +355,7 @@ int hv_snp_boot_ap(u32 cpu, unsigned long start_ip=
)
> >>   	start_vp_input =3D (struct hv_enable_vp_vtl *)ap_start_input_arg;
> >>   	memset(start_vp_input, 0, sizeof(*start_vp_input));
> >>   	start_vp_input->partition_id =3D -1;
> >> -	start_vp_input->vp_index =3D cpu;
> >> +	start_vp_input->vp_index =3D vp_id;
> >>   	start_vp_input->target_vtl.target_vtl =3D ms_hyperv.vtl;
> >>   	*(u64 *)&start_vp_input->vp_context =3D __pa(vmsa) | 1;
> >>
> >> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/ms=
hyperv.h
> >> index 07aadf0e839f..ae62a34bfd1e 100644
> >> --- a/arch/x86/include/asm/mshyperv.h
> >> +++ b/arch/x86/include/asm/mshyperv.h
> >> @@ -268,11 +268,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, str=
uct
> >> hv_interrupt_entry *entry);
> >>   #ifdef CONFIG_AMD_MEM_ENCRYPT
> >>   bool hv_ghcb_negotiate_protocol(void);
> >>   void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int rea=
son);
> >> -int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
> >> +int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip);
> >>   #else
> >>   static inline bool hv_ghcb_negotiate_protocol(void) { return false; =
}
> >>   static inline void hv_ghcb_terminate(unsigned int set, unsigned int =
reason) {}
> >> -static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { r=
eturn 0; }
> >> +static inline int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip)=
 { return 0; }
> >>   #endif
> >>
> >>   #if defined(CONFIG_AMD_MEM_ENCRYPT) ||
> defined(CONFIG_INTEL_TDX_GUEST)
> >> @@ -329,6 +329,7 @@ static inline void hv_set_non_nested_msr(unsigned =
int reg,
> >> u64 value) { }
> >>   static inline u64 hv_get_non_nested_msr(unsigned int reg) { return 0=
; }
> >>   #endif /* CONFIG_HYPERV */
> >>
> >> +int hv_apicid_to_vp_id(u32 apic_id);
> >>
> >>   #ifdef CONFIG_HYPERV_VTL_MODE
> >>   void __init hv_vtl_init_platform(void);
> >>
> >> base-commit: 628cc040b3a2980df6032766e8ef0688e981ab95
> >> --
> >> 2.43.0
> >>
> >
>=20
> --
> Thank you,
> Roman


