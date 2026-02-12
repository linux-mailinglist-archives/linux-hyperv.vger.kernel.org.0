Return-Path: <linux-hyperv+bounces-8793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP//JUb/jWm0+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8793-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:26:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCD12F634
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CFD93011104
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 16:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAD2609EE;
	Thu, 12 Feb 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nlRZQAeL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010023.outbound.protection.outlook.com [52.103.20.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD9286A8;
	Thu, 12 Feb 2026 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913381; cv=fail; b=r+bEHrWBOwGTW1vsyPMz+o1l7xx5lUoCdN1vjBMEhHX3snADXVnL1C/dPEPaSSE85fTRpZJ5EOUoBgCtgC/YBpxHEobquXk5Yvl/HfwmONkR1WcGtUyqlNOf5cdDEO1eOgKpWW+8pxYjZOshXoSZ04ycGwnWTrz5xUhVTDQeknU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913381; c=relaxed/simple;
	bh=4VSFPb+OTPZEm7qdQrMUK2/RtWTxaAoKakdC5WblCAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohOuOV+aty6XdVjvNlkJgRvARGLFLDhjpgwFaEQKT0LEJgGhY9IFJCG/80MhVDo4MOmfniiAC/qRe9+Ej0fdZ64js5Vfe5vw/atUgdN/QxUF5H7H8Df8VUU48L19XFr6Mtt1SSvcB5Kus+NLDSBgGuxSdfJMcQjAC+juJ2B0iA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nlRZQAeL; arc=fail smtp.client-ip=52.103.20.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSLVl0jXNwq2xT5veo0rgTQflW2WV1q+JfLCXpmfnasPrsl2aJBy8ikflvy5z9Hvzo4tE23PxVBNS1Kx/SR6fA4WN7M8ZG1cxyv8xZD1wVQUMWoF1axeZR/Y1Q7d6l+dsuVb7PIhCLSin4gEfRqFO54BFdYzNOV6/kNXehoK0cXTCw6z8NTkrvb/JSZxGFGEmy6GGUpTjysJszd2ZO3lHeTomM3l5wfnKXJ4p4/w85fVUtb2dpLflYPT1yIvZKbaDBCgkJwNa3Biwz8pnKfAIGriNlTxYfXacvmlnuRzAS3uqBTDJDQdISJ6Dl6XfAs4GiNcmlDhb4mcQWUtbm//XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VSFPb+OTPZEm7qdQrMUK2/RtWTxaAoKakdC5WblCAg=;
 b=ULtvtVwnZbV1rKgcSHZcjDSVI1ICVHxIjjk9Qh+I8bkPr1k2R6jdkoMMRGhZOhGGP6y6auoemzN/05TC04wHn9oLD2vLNmCk63lt86WqxIObObFTyYU8MCo9YOol827j1gyxAbmmCH1U0qNxyn6ya2TJOTKbx9kC/N4s2SfPunJ+ZxCUPQdpAJ35RDur/0Cb/INA5FWI++iBljlTqPAKp6N6XEAlLPgi7DH0/rYS0as8s04ax3UMLokDxGeIeYkmGZGBn99NARtuxyKxSDTkp1yEejKSeT0LR2mRWQqYuiDwyOE9AiZOXtV00+GoiZLXK40qbcYX9mdd+HxL7KXNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VSFPb+OTPZEm7qdQrMUK2/RtWTxaAoKakdC5WblCAg=;
 b=nlRZQAeLrMtrbKteMh11/9Cu9wBy/soQc8yynMEZ1QuabYTTGvkLZC9ZlXNOp18bSqaS0QDLO7MnjGyvvjuRunimXekqZJHDHExC1yM2uFn7wOQw33OYX5Eu8SgeHrdlaKWWeZ8wuzxGBn6phfiiMyuu7K5rfRAsL9GjWKu8EnDTCvnInVVlwKo33yT0Bb1ypcgWATW1kl1m47597j575LONt7aVcY63hYXj8OaoMoC+zx10GZWj1KD418h4EkyRx8mF51in90WWiDi9myvS5L9beXB4JXeTyZaPGGBF15C9AXFYExgWY6b+hTocftkvf69/mNwxJu0WQrBrNX1bVQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9425.namprd02.prod.outlook.com (2603:10b6:930:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 16:22:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 16:22:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Michael Kelley
	<mhklinux@outlook.com>, Florian Bezdeka <florian.bezdeka@siemens.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, RT
	<linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Topic: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Thread-Index:
 AQHclScm1YuvygUhI0+fe3CZOPBAobVzKaaQgAITHgCAATQUcIADxGYAgACBIqCABJJLAIAABK3Q
Date: Thu, 12 Feb 2026 16:22:52 +0000
Message-ID:
 <SN6PR02MB41579053E288C5577CBDF438D460A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
 <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
In-Reply-To: <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9425:EE_
x-ms-office365-filtering-correlation-id: b7e6834d-ca61-4ce7-c577-08de6a52f8f4
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8062599012|15080799012|8060799015|461199028|31061999003|51005399006|13091999003|3412199025|440099028|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0laUFdob1ZiSmx1QkprN0NRdGt3Q1dFQko3eHBWZnFrRjh5ZSszRkdJZERx?=
 =?utf-8?B?TFoyM2VHRUtDemgxVmdiZHo3WkRQbXlMYzI3NlNNc0VPQXJKVzk3b0gzWkJk?=
 =?utf-8?B?UEwxb3ZGeTNJOElMMUNRd01hTmpvU1hyRTFuWS9HUmNiQUpHZE51K0lDeW9E?=
 =?utf-8?B?dDdaallvT3J0UStWN3VUNmxCa1R0Ky9KWWFpWnRsNEZkREZlVUVRWHo0KzJp?=
 =?utf-8?B?bEdtaXFWYksxRG11MHpNTkNwZjUzV0lOYzZGTGR5ZTJIQnZHTys5VE9IeGd1?=
 =?utf-8?B?b2JsMXNBRWo0YmpEcG9aY0o3cWhSTzltTC9iMmlRaFo3ZitxQlpYbS9HeExU?=
 =?utf-8?B?VzVySVhidFhwelc0R0M3cUt4U2ExOVF6NTdialBvbkZiVzlOSEtyaUtmSFJR?=
 =?utf-8?B?RVovcGtoNGE2ZXZNOHhta2FmYytLWXpLcTdhVEUyMmJQK21WRUE3K2hIamU0?=
 =?utf-8?B?VlFwT2VwMVhIL3d6V0tFYW5SNDFHZExLTzZ2NzRVMmQ4Q0Z1cEwxRE5VR0V0?=
 =?utf-8?B?ZGtEUDJia3pNNC80TVErNjlkMGR1UG8rVU93a0FyTndiVytBMzFHdTdhVWVZ?=
 =?utf-8?B?YXZsd0ZZbVNQUkJTd3ZYcEdIKzN6Nmw2emEwM2tWaU9iT3FDcEVEZHg2c0Fw?=
 =?utf-8?B?VWdRZWlnMVl2OVZabzQ2VmptNHU2V1gwOXFGM1EvcTFHSlFCaW9UeE9kWGpk?=
 =?utf-8?B?Nk5odWZhNk80a3Z4bDJvdXVnU1Y0cHBnQUpSUDd4L25XdVpqSWd3OG13QVZY?=
 =?utf-8?B?blZ2eDNzb3V6VThuSm1LYmVGcyt2VXIrR1F5RWJPWUl5Tm9XTFdNeGEydTEx?=
 =?utf-8?B?L1RkWlZlNnNJdFhPUGRiU0ZkbzRsclY2ci85STByTTAzeWFJQmFiS055WW8x?=
 =?utf-8?B?VmFPYmRiY29JRllBUEgyaEI5aFFmaWgvZG9VVFVwTlJKOFNzSHF0TFVkTEV2?=
 =?utf-8?B?dGd6Z3NVckhxTlloL1RzZlEwc1lEckRqbjRZTXJ5NS9PUTQ1clFRVVBSTVRU?=
 =?utf-8?B?Z29GdmZBNlRybTBSemxBQXRNMWVDdUFWeGdHeEFobHF2UVhtRGRCelZONURO?=
 =?utf-8?B?ZXdvb2JuU1B3VUNoOFBockFBNkRWeXNCMGEzaFB0Wm5SSTJ5Z2N4T1pkR1Fj?=
 =?utf-8?B?eTYzZzBwM1k2Q2FFNDkySnBLSURPTXhlN0k0WUpGVFFuMHNDRVJOUEpBRUlQ?=
 =?utf-8?B?ZDAvbjJscW4xVVNYN1plUy9aWkhCTTBoQ3MrWTA3M0FLQVFNWFVWN3FQMURP?=
 =?utf-8?B?VldzU3JMYU1JcnlKbzlYL1NoRXF0dExMVG04eStHVGRjQzM5MDZYWTBkcjFN?=
 =?utf-8?B?WFJtVWE2cXNQOW1DU1FLK280anRsdXBrNHVQQlh3UDBsUklKZE1LMVEycjFn?=
 =?utf-8?B?aW9LUXg2RXVOUFVjNzNxemNSSFdiNTQzdFV5QWV2Y0QxQmk1VzMwUU42NUE0?=
 =?utf-8?B?dHAxNzNtWm5SU2UzZ1FwaU1rNDBXTkEvdW5WTGptVFJ5WkpyUENHZ05nZ1Nv?=
 =?utf-8?B?ME4vVUYwaGVoSnEvOEdhb0Q5ODRQN2QrQ2xEbUxCeHp2QjNrQm5mcVNuSVRn?=
 =?utf-8?B?bHJWUjFVdTB6SnMxUnY3MXdyZCtNMDQwa3hUVkNDTHJDZmtHU3paQ2dmYjNS?=
 =?utf-8?Q?3mx1vuNN6FlxGBdojAoO/4+kLSJ+ZbKfndQWmSrqCNC8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3UzaFlCaGZuaGZ4WG1OM0VOUG15aVBma3V4WnhFdlEzM1l3cHdaV1EzSnNY?=
 =?utf-8?B?a2hROHRnbTJzaER5SmxaYXc4ZE5jTHBGVTB3WVlQa3VaYmU4ZnVFaGtHN0xQ?=
 =?utf-8?B?aGdUU3JEQi9uUjVHamFBWHdtTHhYK0FCdW1zY1F5VUxqZUZNaFFDdXRMKzVu?=
 =?utf-8?B?WjdrTk5vZUc0ODRHT3RjdjFxVEZsbkxHMVFjZHV3N2YxOW1WMkdJNWFwUnRK?=
 =?utf-8?B?OHJVUGgxTGpxQVIrSlVMYWliOUdHbHprTWZNTE9XMWpUbXJVWmlLcGRDbVJ3?=
 =?utf-8?B?b0ErRTg0UXlFY3hkampvRi95OEVYc3VCRG9OSHQ5WExCMzEyNlRFclNrQXp3?=
 =?utf-8?B?Y1ZUcmVrZjZtVk5WYzd0eXdsWVZtSmUzWlBYV1FxSGJtRzJtc3hwZGtWTitB?=
 =?utf-8?B?clgyRTZnTVdmZlQ3azZsUFRvd1FtSTM5b1cyRHdzYWp3L1lNUmJ2RzhqbEhq?=
 =?utf-8?B?dElrT0FNK1QzMU44Y1Q3V3J1aDlRTzczZkdDeXFHWUZDYUsrQlhvUVVRM2to?=
 =?utf-8?B?bUlrdDdRSEp4NXBTUFkwZzZ5Tlg1VnZvbnNTSUg2MkxEbzFrL2dOSjZjVDA5?=
 =?utf-8?B?TkNLMHB4d1RFbS9rckgrREw3MkQ2U3ltcVhCL1VPNUpkeXl1SkRTS2FaQmNn?=
 =?utf-8?B?QW52TzVmank5OHRlODE5YUQzWjN4WDEwVml4YnVhc2JtMFJjYnhMeDJSWEpY?=
 =?utf-8?B?TUc3eFpRRXVLZi84SFBmL0lZRytwa00yVWt6UTdwRVFlV1ZxWG1vWld5NjEx?=
 =?utf-8?B?SlNDeVA0TkVZVHc3Rk1hcWJFN3hHcHNsQTBLa1NTL0RWc2pPTUprdDJuQzM3?=
 =?utf-8?B?bTc0TnhBblRJcEZUa05FNi9COXBjWFphdDEzZHJtenZtYnhJUjJpV0tVQ2pM?=
 =?utf-8?B?OVk2Q2o1YWpPZlFTQStKWHFYc0hwRVgza0FBSjdwZDJac3pqV0J2UVdJbmhO?=
 =?utf-8?B?azBpNVVOVUZwUFpNV3c0Vmxrem5KUGw5SXp1TWNWMlB6emdRbUkzQTZ0akFo?=
 =?utf-8?B?V041WDd1LzdvZi9OQ0RQNFFBNTJJMnpMV2hUdlo4aTMxZmtWaThWS29yUXdn?=
 =?utf-8?B?ZGN0Ris3ejk0eExqQWpOUUhKTUpBUS9BcmZUcUhISUZDTi9PT29hOER5YjRM?=
 =?utf-8?B?R0RXQThkOWVvS3llMmM3dllLUWRKQTg3UlgrRnhUYnQ4WTlOanNWYkNmdWNK?=
 =?utf-8?B?eUtudGF3WWdIL0dvWHN4dXQ0b1daRmtCdGtqUXlvbHRIdHhDM2tiRzFxK2pG?=
 =?utf-8?B?Wnp0Z1NySHovd2I3UVJHR0pLK3VjcWRnR3d3Y1MydG1EKzJtK3NvcW12ZnVJ?=
 =?utf-8?B?NnM4VmhySXJhK0lLaTBBK2tRZk4xNG5UUy9tQnZ5MVUvdDNUNkxMbTZMRG9Q?=
 =?utf-8?B?em9oRTNwZVlkTG1IL1ptY0kzVERPaDdDY2RnSjFBc2phWEpaOUhrN0hiRjZE?=
 =?utf-8?B?T1E2eHFOaDdveVpYZXgwOTBmaWNqT3dONHA1bWVuVlhmV2R3THVTMHVBNjRq?=
 =?utf-8?B?VFdIK2Zqa1VlNWE2aXoxelNsb3pQbzhMUVFEOVBXcHoyNWN5TWgvaEFBQmJB?=
 =?utf-8?B?Q0tDRjh4bk05cVJoUS9VZmFOZlFrMHhDV05DcG9wUmlvbnpCY3p5djdDb01N?=
 =?utf-8?B?NWQ2V3pRZU1BSUdsOFY5SEU4dThzbUR0dXdhOUpKc1gxZmp0SXowVEh1QmpY?=
 =?utf-8?B?MkJkb1FMQTVpTGZ3Y1I1WlY3dzZSeFluNnZsM0MzcUh4M000VlV5Ull6RE9O?=
 =?utf-8?B?TlJvSmpqbzIrY1BBZTdrbENJUm94cVhJODFKMWxVQzRkS0RuUXJtZk8zVFhF?=
 =?utf-8?B?MytVVE9ucUh5enUzNUVlN2s2OVZhNElvNExRU3JxR1VGaFRyZFVqZFJLbytp?=
 =?utf-8?B?T3NOZm8rM3doUE1XRnBwdWhmcFR4L00zb3lYUkkvMUhuSWpWZEh0bG1iWlEx?=
 =?utf-8?Q?zz+hZjbLhbHycBdXR48wIzHYXfKyGsai?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e6834d-ca61-4ce7-c577-08de6a52f8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 16:22:52.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8793-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[siemens.com,outlook.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: E2BCD12F634
X-Rspamd-Action: no action

RnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDEyLCAyMDI2IDg6MDYgQU0NCj4gDQo+IE9uIDA5LjAyLjI2IDE5OjI1LCBNaWNo
YWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBGbG9yaWFuIEJlemRla2EgPGZsb3JpYW4uYmV6
ZGVrYUBzaWVtZW5zLmNvbT4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA5LCAyMDI2IDI6MzUgQU0N
Cj4gPj4NCj4gPj4gT24gU2F0LCAyMDI2LTAyLTA3IGF0IDAxOjMwICswMDAwLCBNaWNoYWVsIEtl
bGxleSB3cm90ZToNCj4gPj4NCj4gPj4gW3NuaXBdDQo+ID4+Pg0KPiA+Pj4gSSd2ZSBydW4geW91
ciBzdWdnZXN0ZWQgZXhwZXJpbWVudCBvbiBhbiBhcm02NCBWTSBpbiB0aGUgQXp1cmUgY2xvdWQu
IE15DQo+ID4+PiBrZXJuZWwgd2FzIGxpbnV4LW5leHQgMjAyNjAxMjguIEkgc2V0IENPTkZJR19Q
UkVFTVBUX1JUPXkgYW5kDQo+ID4+PiBDT05GSUdfUFJPVkVfTE9DS0lORz15LCBidXQgZGlkIG5v
dCBhZGQgZWl0aGVyIG9mIHlvdXIgdHdvIHBhdGNoZXMNCj4gPj4+IChuZWl0aGVyIHRoZSBzdG9y
dnNjIGRyaXZlciBwYXRjaCBub3IgdGhlIHg4NiBWTUJ1cyBpbnRlcnJ1cHQgaGFuZGxpbmcgcGF0
Y2gpLg0KPiA+Pj4gVGhlIFZNIGNvbWVzIHVwIGFuZCBydW5zLCBidXQgd2l0aCB0aGlzIHdhcm5p
bmcgZHVyaW5nIGJvb3Q6DQo+ID4+Pg0KPiA+Pj4gWyAgICAzLjA3NTYwNF0gaHZfdXRpbHM6IFJl
Z2lzdGVyaW5nIEh5cGVyViBVdGlsaXR5IERyaXZlcg0KPiA+Pj4gWyAgICAzLjA3NTYzNl0gaHZf
dm1idXM6IHJlZ2lzdGVyaW5nIGRyaXZlciBodl91dGlscw0KPiA+Pj4gWyAgICAzLjA4NTkyMF0g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPj4+IFsgICAgMy4wODgxMjhdIGh2X3Zt
YnVzOiByZWdpc3RlcmluZyBkcml2ZXIgaHZfbmV0dnNjDQo+ID4+PiBbICAgIDMuMDkxMTgwXSBb
IEJVRzogSW52YWxpZCB3YWl0IGNvbnRleHQgXQ0KPiA+Pj4gWyAgICAzLjA5MzU0NF0gNi4xOS4w
LXJjNy1uZXh0LTIwMjYwMTI4KyAjMyBUYWludGVkOiBHICAgICAgICAgICAgRQ0KPiA+Pj4gWyAg
ICAzLjA5NzU4Ml0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4+IFsgICAgMy4w
OTk4OTldIHN5c3RlbWQtdWRldmQvMjg0IGlzIHRyeWluZyB0byBsb2NrOg0KPiA+Pj4gWyAgICAz
LjEwMjU2OF0gZmZmZjAwMDEwMGUyNDQ5MCAoJmNoYW5uZWwtPnNjaGVkX2xvY2spey4uLi59LXsz
OjN9LCBhdDogdm1idXNfY2hhbl9zY2hlZCsweDEyOC8weDNiOCBbaHZfdm1idXNdDQo+ID4+PiBb
ICAgIDMuMTA4MjA4XSBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0aGlzOg0K
PiA+Pj4gWyAgICAzLjExMTQ1NF0gY29udGV4dC17MjoyfQ0KPiA+Pj4gWyAgICAzLjExMjk4N10g
MSBsb2NrIGhlbGQgYnkgc3lzdGVtZC11ZGV2ZC8yODQ6DQo+ID4+PiBbICAgIDMuMTE1NjI2XSAg
IzA6IGZmZmZkNWNmYzIwYmNjODAgKHJjdV9yZWFkX2xvY2spey4uLi59LXsxOjN9LCBhdDogdm1i
dXNfY2hhbl9zY2hlZCsweGNjLzB4M2I4IFtodl92bWJ1c10NCj4gPj4+IFsgICAgMy4xMjEyMjRd
IHN0YWNrIGJhY2t0cmFjZToNCj4gPj4+IFsgICAgMy4xMjI4OTddIENQVTogMCBVSUQ6IDAgUElE
OiAyODQgQ29tbTogc3lzdGVtZC11ZGV2ZCBUYWludGVkOiBHICAgICAgICAgICAgRSA2LjE5LjAt
cmM3LW5leHQtMjAyNjAxMjgrICMzIFBSRUVNUFRfUlQNCj4gPj4+IFsgICAgMy4xMjk2MzFdIFRh
aW50ZWQ6IFtFXT1VTlNJR05FRF9NT0RVTEUNCj4gPj4+IFsgICAgMy4xMzE5NDZdIEhhcmR3YXJl
IG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbiBWaXJ0dWFsIE1hY2hpbmUvVmlydHVhbCBNYWNo
aW5lLCBCSU9TIEh5cGVyLVYgVUVGSSBSZWxlYXNlIHY0LjEgMDYvMTAvMjAyNQ0KPiA+Pj4gWyAg
ICAzLjEzODU1M10gQ2FsbCB0cmFjZToNCj4gPj4+IFsgICAgMy4xNDAwMTVdICBzaG93X3N0YWNr
KzB4MjAvMHgzOCAoQykNCj4gPj4+IFsgICAgMy4xNDIxMzddICBkdW1wX3N0YWNrX2x2bCsweDlj
LzB4MTU4DQo+ID4+PiBbICAgIDMuMTQ0MzQwXSAgZHVtcF9zdGFjaysweDE4LzB4MjgNCj4gPj4+
IFsgICAgMy4xNDYyOTBdICBfX2xvY2tfYWNxdWlyZSsweDQ4OC8weDFlMjANCj4gPj4+IFsgICAg
My4xNDg1NjldICBsb2NrX2FjcXVpcmUrMHgxMWMvMHgzODgNCj4gPj4+IFsgICAgMy4xNTA3MDNd
ICBydF9zcGluX2xvY2srMHg1NC8weDIzMA0KPiA+Pj4gWyAgICAzLjE1Mjc4NV0gIHZtYnVzX2No
YW5fc2NoZWQrMHgxMjgvMHgzYjggW2h2X3ZtYnVzXQ0KPiA+Pj4gWyAgICAzLjE1NTYxMV0gIHZt
YnVzX2lzcisweDM0LzB4ODAgW2h2X3ZtYnVzXQ0KPiA+Pj4gWyAgICAzLjE1ODA5M10gIHZtYnVz
X3BlcmNwdV9pc3IrMHgxOC8weDMwIFtodl92bWJ1c10NCj4gPj4+IFsgICAgMy4xNjA4NDhdICBo
YW5kbGVfcGVyY3B1X2RldmlkX2lycSsweGRjLzB4MzQ4DQo+ID4+PiBbICAgIDMuMTYzNDk1XSAg
aGFuZGxlX2lycV9kZXNjKzB4NDgvMHg2OA0KPiA+Pj4gWyAgICAzLjE2NTg1MV0gIGdlbmVyaWNf
aGFuZGxlX2RvbWFpbl9pcnErMHgyMC8weDM4DQo+ID4+PiBbICAgIDMuMTY4NjY0XSAgZ2ljX2hh
bmRsZV9pcnErMHgxZGMvMHg0MzANCj4gPj4+IFsgICAgMy4xNzA4NjhdICBjYWxsX29uX2lycV9z
dGFjaysweDMwLzB4NzANCj4gPj4+IFsgICAgMy4xNzMxNjFdICBkb19pbnRlcnJ1cHRfaGFuZGxl
cisweDg4LzB4YTANCj4gPj4+IFsgICAgMy4xNzU3MjRdICBlbDFfaW50ZXJydXB0KzB4NGMvMHhi
MA0KPiA+Pj4gWyAgICAzLjE3Nzg1NV0gIGVsMWhfNjRfaXJxX2hhbmRsZXIrMHgxOC8weDI4DQo+
ID4+PiBbICAgIDMuMTgwMzMyXSAgZWwxaF82NF9pcnErMHg4NC8weDg4DQo+ID4+PiBbICAgIDMu
MTgyMzc4XSAgX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4NGMvMHhiMCAoUCkNCj4gPj4+
IFsgICAgMy4xODU0OTNdICBydF9tdXRleF9zbG93dW5sb2NrKzB4NDA0LzB4NDQwDQo+ID4+PiBb
ICAgIDMuMTg3OTUxXSAgcnRfc3Bpbl91bmxvY2srMHhiOC8weDE3OA0KPiA+Pj4gWyAgICAzLjE5
MDM5NF0gIGttZW1fY2FjaGVfYWxsb2Nfbm9wcm9mKzB4ZjAvMHg0ZjgNCj4gPj4+IFsgICAgMy4x
OTMxMDBdICBhbGxvY19lbXB0eV9maWxlKzB4NjQvMHgxNDgNCj4gPj4+IFsgICAgMy4xOTU0NjFd
ICBwYXRoX29wZW5hdCsweDU4LzB4YWEwDQo+ID4+PiBbICAgIDMuMTk3NjU4XSAgZG9fZmlsZV9v
cGVuKzB4YTAvMHgxNDANCj4gPj4+IFsgICAgMy4xOTk3NTJdICBkb19zeXNfb3BlbmF0MisweDE5
MC8weDI3OA0KPiA+Pj4gWyAgICAzLjIwMjEyNF0gIGRvX3N5c19vcGVuKzB4NjAvMHhiOA0KPiA+
Pj4gWyAgICAzLjIwNDA0N10gIF9fYXJtNjRfc3lzX29wZW5hdCsweDJjLzB4NDgNCj4gPj4+IFsg
ICAgMy4yMDY0MzNdICBpbnZva2Vfc3lzY2FsbCsweDZjLzB4ZjgNCj4gPj4+IFsgICAgMy4yMDg1
MTldICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDQ4LzB4ZjANCj4gPj4+IFsgICAgMy4y
MTEwNTBdICBkb19lbDBfc3ZjKzB4MjQvMHgzOA0KPiA+Pj4gWyAgICAzLjIxMjk5MF0gIGVsMF9z
dmMrMHgxNjQvMHgzYzgNCj4gPj4+IFsgICAgMy4yMTQ4NDJdICBlbDB0XzY0X3N5bmNfaGFuZGxl
cisweGQwLzB4ZTgNCj4gPj4+IFsgICAgMy4yMTcyNTFdICBlbDB0XzY0X3N5bmMrMHgxYjAvMHgx
YjgNCj4gPj4+IFsgICAgMy4yMTk0NTBdIGh2X3V0aWxzOiBIZWFydGJlYXQgSUMgdmVyc2lvbiAz
LjANCj4gPj4+IFsgICAgMy4yMTk0NzFdIGh2X3V0aWxzOiBTaHV0ZG93biBJQyB2ZXJzaW9uIDMu
Mg0KPiA+Pj4gWyAgICAzLjIxOTg0NF0gaHZfdXRpbHM6IFRpbWVTeW5jIElDIHZlcnNpb24gNC4w
DQo+ID4+DQo+ID4+IFRoYXQgbWF0Y2hlcyB3aXRoIG15IGV4cGVjdGF0aW9uIHRoYXQgdGhlIHNh
bWUgcHJvYmxlbSBleGlzdHMgb24gYXJtNjQuDQo+ID4+IFRoZSBwYXRjaCBmcm9tIEphbiBhZGRy
ZXNzZXMgdGhhdCBpc3N1ZSBmb3IgeDg2IChvbmx5LCBzbyBmYXIpIGFzIHdlIGRvDQo+ID4+IG5v
dCBoYXZlIGEgd29ya2luZyB0ZXN0IGVudmlyb25tZW50IGZvciBhcm02NCB5ZXQuDQo+ID4NCj4g
PiBPSy4gSSBoYWQgdW5kZXJzdG9vZCBKYW4ncyBlYXJsaWVyIGNvbW1lbnRzIHRvIG1lYW4gdGhh
dCB0aGUgVk1CdXMNCj4gPiBpbnRlcnJ1cHQgcHJvYmxlbSB3YXMgaW1wbGljaXRseSBzb2x2ZWQg
b24gYXJtNjQgYmVjYXVzZSBvZiBWTUJ1cyB1c2luZw0KPiA+IGEgc3RhbmRhcmQgTGludXggSVJR
IG9uIGFybTY0LiBCdXQgZXZpZGVudGx5IHRoYXQncyBub3QgdGhlIGNhc2UuIFNvIG15DQo+ID4g
ZWFybGllciBjb21tZW50IHN0YW5kczogVGhlIGNvZGUgY2hhbmdlcyBzaG91bGQgZ28gaW50byB0
aGUgYXJjaGl0ZWN0dXJlDQo+ID4gaW5kZXBlbmRlbnQgcG9ydGlvbiBvZiB0aGUgVk1CdXMgZHJp
dmVyLCBhbmQgbm90IHVuZGVyIGFyY2gveDg2LiBJDQo+ID4gY2FuIHByb2JhYmx5IHdvcmsgd2l0
aCB5b3UgdG8gdGVzdCBvbiBhcm02NCBpZiBuZWVkIGJlLg0KPiA+DQo+IA0KPiBJIGNhbiBtb3Zl
IHRoZSBjb2RlLCBzdXJlLCBidXQgSSBzdGlsbCBoYXZlbid0IHVuZGVyc3Rvb2Qgd2hhdA0KPiBp
bnZhbGlkYXRlcyBteSBhc3N1bXB0aW9ucyAoYmVzaWRlIHdoYXQgeW91IG9ic2VydmVkKS4gdm1i
dXNfZHJ2IGNhbGxzDQo+IHJlcXVlc3RfcGVyY3B1X2lycSwgYW5kIHRoYXQgaXMgLSBhcyBmYXIg
YXMgSSBjYW4gc2VlIC0gbm90IGluamVjdGluZw0KPiBJUlFGX05PX1RIUkVBRC4gQW55IGV4cGxh
bmF0aW9ucyB3ZWxjb21lLg0KPiANCj4gUmVwcm9kdWN0aW9uIGlzIHN0aWxsIG5vdCBwb3NzaWJs
ZSBmb3IgbWUuIEkgd2FzIHBsYXlpbmcgYSBiaXQgd2l0aCBxZW11DQo+IGluIHRoZSBob3BlIHRv
IG1ha2UgaXQgcHJvdmlkZSBpdHMgbWluaW1hbCB2bWJ1cyBzdXBwb3J0IChmb3INCj4gYmFsbG9v
bmluZyksIGJ1dCB0aGF0IHdhcyBub3QgeWV0IHN1Y2Nlc3NmdWwgb24gYXJtNjQuDQo+IA0KDQpM
ZXQgbWUgdHJ5IHRvIGRlYnVnIG15IGV4cGVyaW1lbnQgb24gYXJtNjQgYW5kIHNlZSB3aHkgaXQg
aXNuJ3QNCmhhbmRpbmcgb2ZmIHRoZSBWTUJ1cyBpbnRlcnJ1cHQgdG8gYSB0aHJlYWQuIE1heWJl
IHRoZXJlJ3Mgc29tZXRoaW5nDQptaXNzaW5nIGluIG15IC5jb25maWcuIEJ1dCBpdCB3aWxsIGJl
IHNvbWV0aW1lIG5leHQgd2VlayBiZWZvcmUNCkkgY2FuIGRvIGl0Lg0KDQpNaWNoYWVsIA0K

