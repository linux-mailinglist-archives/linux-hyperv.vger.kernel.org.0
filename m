Return-Path: <linux-hyperv+bounces-5130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873BA9C314
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 11:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3170D17C00C
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BC2153C7;
	Fri, 25 Apr 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JGvMzB3a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022085.outbound.protection.outlook.com [52.101.126.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EB21638A;
	Fri, 25 Apr 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572465; cv=fail; b=FDrXNhQsq+rnzDl1JMCUdXmecPITamFehvd2zeG8evm518rUZHZzqM/fzUNcj6gi7Wgo7qcn4l+E6h+aWtRaozHuumKsaPd7CBNOhST4IloHqg/+0euWBdKSoBnDd47p1AODt/rG57lpOifP6f4g6rlIoqqNb1wjIhILihhPtG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572465; c=relaxed/simple;
	bh=W5cgqOMNVq4GGn9r3IFjyjheRS6dByUvRyO38VkT3s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4kXjnqEMmm2zbZEHkP4Qe000H87rh/9xboDT2+EmUTsIYRXka+Sh8q5nahsMn3rMYa1BlCv7jPqiGHc1UP1kc5UFwixSd82q3E3TWkNKOFICuRkQMcE4iQK+AwSRl2GbStEDl8amZeuQiZ3+RrQsDCfVLBQyftuMYUuNVrgiIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JGvMzB3a; arc=fail smtp.client-ip=52.101.126.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSIJEVuG2ZNg/CKfDN8+YYg6qDoc1cf/fUcR/C2shwnRAwYY8dOT/qVu29oGxqXO+jv/QOSAMiZdJxJRcbytxBMEYMtBCtgL7ijzPP/08+ELbkvtFOsLUy7EKpTTUiTePRzrXW3UlspSq5ErGq8fXrH3i4Weq+xvY3TOSB3fWEq+L6dcGjsJa/RD3/mLseUojiVMh3hwrX+sKYANLb6sgZ1aikCiD4en9zJ8ZVEycAU4GxGcNmy55DeKisb8RVMqRUcJ3xt2eQmw8y2GffxIQrNdXdVD+VHpu0P4L/7B8kcK20no06Fbh7L3zWHdOe6z+Byp/LYUlt8qVopbe76DhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5cgqOMNVq4GGn9r3IFjyjheRS6dByUvRyO38VkT3s0=;
 b=t9cS988hG2fqrlX1INcHFFoiQK5KxL18r/vyv4MvareI5FoK0FJKe6hEWPzSIyIf+NfhzgF4lgSvpp8JCfEKfghz0I4KyzNWZXWz1nQ21tiXXWSSwR9/mCdLbp0eq2zjVzLJgCDFtWe5SPydX9GaqBLex2gwTxdp+axmVlDhAhFPgUwljkOOYZ1mY71Mxjl/mHNUE1jtsGessp+laJU8DgQ/Gx7avxhOb7GnncAeEy4u+yPoo5EozyEjixzJQSTzGruRa3vkS7c4925i/5/ceLDOPlSQcqK6qQKM+fWIcKsdonEIUQzaFVPt20snu8y0e+VPu1bxnJUwmwgwTThXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5cgqOMNVq4GGn9r3IFjyjheRS6dByUvRyO38VkT3s0=;
 b=JGvMzB3aE1TcxU6UuLgDSl/Hucuyj7Ofonr8IHC6At1Dgdh71CYGynjBKw4hz0mRv+Z/B/74jJ3pZEaMvYQwGGPOn+VNlNtUQx7gBQzQZCU7XNYX2YXGOXHvR0ksUIytFWXrh7tj0xai8PtCtRQB4t1Wcj0xpCe3BLVEwQNv94U=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by TYSP153MB1045.APCP153.PROD.OUTLOOK.COM (2603:1096:405:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.12; Fri, 25 Apr
 2025 09:14:07 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%4]) with mapi id 15.20.8699.010; Fri, 25 Apr 2025
 09:14:07 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY
 Srinivasan <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Allen Pais
	<apais@microsoft.com>, Ben Hillis <Ben.Hillis@microsoft.com>, Brian Perkins
	<Brian.Perkins@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP
 ID confusion in hv_snp_boot_ap()
Thread-Topic: [EXTERNAL] Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and
 VP ID confusion in hv_snp_boot_ap()
Thread-Index: AQHbtamOlIwzG2IG/UqbRMBi4sMoobO0DOYw
Date: Fri, 25 Apr 2025 09:14:06 +0000
Message-ID:
 <KUZP153MB1444118E6199CBED8C78E6D4BE842@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
 <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=67835758-8c73-4c4d-8dcf-4832eefa28b5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-25T08:29:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|TYSP153MB1045:EE_
x-ms-office365-filtering-correlation-id: 21e7f432-ff1c-4883-0d50-08dd83d987aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFhISG5SQlF5VkRBM09RQnJrOFRmeUtpTlF4dUZTbFMrbGV6YTJyWjBNLzhm?=
 =?utf-8?B?N1B2UDgwYUJiTS9oSmtHajN1UFkwbU5Rb2FMRnVNU015T2k4RnJTMThsTW80?=
 =?utf-8?B?VkJNLy9DWWpEYlkwaFpIZVRkeUNic1RKcHNBRngzTVp5RXo0dGZISEJiR3Q4?=
 =?utf-8?B?TitnRTU1NHBpdTRFRzRMRFhJTEp6a1ovTktyeldkU1MvS3ZKQnlmNE1XZXRS?=
 =?utf-8?B?a0lKbnFhVGY3VUZtd1IweWlJamVndkZHWHUwbitvSmV5TllXZTNvZWx0UmFz?=
 =?utf-8?B?dHcrS0dveHdvdWpzNEwyczJBQkdrRWxMZjZrSXV3emlNWFd2SXpmY29GVHpF?=
 =?utf-8?B?SElPcWh4VW9VWE1QS0hnS0RJMkx2am8vNFNuR2Z6VmlnSThzelVibDB4MTVE?=
 =?utf-8?B?N1Zmdzc4dS9sbmNzQjJmdlNvNWR2T0RNQmRYdE5ESFZ2Q1U0aFNWUUxianJr?=
 =?utf-8?B?MTg5ZzJxc3Y4OHFrV0ZLRWpYYmkrcDNFRDJzeXJQclBScmZQSytuNlJ1UGxO?=
 =?utf-8?B?Y0lPaTNzZDdZTTRZOWhXT3o0TEhSN3Z5VCs4SVdXOXJmTVpsSHBhdWJ5Yld1?=
 =?utf-8?B?ZElLOVRCL1E0cHpsNkRRTGd6S0lsMmwrWTdNSVVqU0hpYnBieldqVXQvU0M4?=
 =?utf-8?B?Y3dha0dROC9wRGVmdm9CZFUwckRrUnBCRWx5b1h4bGhvYmJwcUxYN0RMbmtt?=
 =?utf-8?B?aWVwdUxPRTN1eGttY1JsMjcrNjNFaGk4SHV1MVR3TTZTbStCd3N5TFZzS1Jw?=
 =?utf-8?B?SmFwL2FTZFNwRUtlN2xSbThrcHpNaVpvNldCVzdCM1A5Rlo0b2JjOVJJQnpL?=
 =?utf-8?B?OUI2eE9abHFsejhvWW5uNjRVNFNCa096VnRmY1daajVCZmRHekpQSjdPWVNl?=
 =?utf-8?B?aDlvVVJRRHhLQThaWGZ0V1lnS0NQUXZCVkF2QzlPc1NzL0lBNG1Bb3ZiVzBz?=
 =?utf-8?B?blRQa0g1RTJaRjRWVTZVWnJ1c0NZQ0RML09KMGQ5NjNEVEY0QXN6UnFGTG1j?=
 =?utf-8?B?QzZpVlRHUFhxVEdCQVI1UW81NmdpY1NDL3NWTEg0bGJ4Rk0xa3ozVHBxZVgx?=
 =?utf-8?B?MXhUcVlvS1hSdm5VSFRraTFyOGJpNWlSUWx1dGtpRDk2VHB2MVpkMEJsMjRJ?=
 =?utf-8?B?Y0VDanB2WkVkNTllbEN0bDVwMWtsN3MvZXVkMUQ1bk5sb1pvRDVEZXRIUGZv?=
 =?utf-8?B?bTRGMVJ4WnFqUlJoYlVmYyt2d0x6eUNqM2lGV0FaSmhsRzZWaWJ0VGsrQjQv?=
 =?utf-8?B?RmRHb1hHU0MybjlqNEZUSC8yMkxZN2hXSWd4eEpHT1huS0o4UUcyYVd6Y0to?=
 =?utf-8?B?eERJVGd2WmpQR3ZlT3NGeHg4RUI0K3AvWng2V2VHOEtsdTVBczJhcGFBSnhI?=
 =?utf-8?B?MHNkM3VBM2VDNGo2ZzhBQm1KWFdyUlZtNEZiR001UFgzMHY1QktlbkM0cndH?=
 =?utf-8?B?b0t6ZE5QaFpJR3ByOXBaVElLWTAvMHJPMXREQWRUYjNIUVBZd3pidzBRaFlH?=
 =?utf-8?B?Z2pQb20wWGZ3Qm1oaXBpOXhpSDJ3V0FwOTZBdkNjVUhRanFrdGpqcVQ5MlpE?=
 =?utf-8?B?Q3BWSXBTc1N3dTlYTE1oRWFyTTlQblBqUkYvV0VMZ1FSSDVMWlBmTGNYTXlm?=
 =?utf-8?B?cHFrSW9JRGVldm91VG9iSnlhcW5LRVRyeGg1c1NhQXliT0Z6VWRGSHhndXcr?=
 =?utf-8?B?ZnlzSWZ5bGk4anZXRllvWmR5YnZRV3BxN3JoR0MzYUl5UHZsRlVicjRualhQ?=
 =?utf-8?B?STJvZFlRemg5Z2s4UnVWdWFLaXlMNDZTYW8xNzd5TnBjZHVwZmZpMkhhWVU2?=
 =?utf-8?B?RTFha0Q4ZnJTTVpsSEVSL2VseXlHdVdkaW41Qy8zR2sxbVpmL1lOc2ZnUmVs?=
 =?utf-8?B?MnF0eVlteDdJWHRjMlRTTDg3a202VmlqM0lWcTB4cGNDalUrQ1F1VkxGakRS?=
 =?utf-8?B?Qko2bHUzajBCa29aZG5uR25ybzY2SFJxTmpIMUtBRFBkdUNDd0ZCMlpWaGF1?=
 =?utf-8?B?OCtZYUYwckd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?em0rUG1zRlFxMDlUYnV1eFFrcU5Fa3NMR2xqNzNudEMxV25XQkl1SHJXY0ts?=
 =?utf-8?B?Q3I2SitYM3BKbGw1L3lRakdqVDM5bHlseUZZNlZnLzFDS1V4b3hWQjQ1anEz?=
 =?utf-8?B?cFpvQnc0bFBFTjVTdk9aNDgxNVYrUDZscldCOWlVaG9RamZRcmZ5ak9pRUpL?=
 =?utf-8?B?WHZRYmNja25YbUNKNXA1YkNPVDdJUm5aSVdVV1JkbVRRU3pMTUd6U2xMa0py?=
 =?utf-8?B?a0dYcmlnOE51WU9jakFOcWczV1MyTW9OOGNiOEhldWNIWjhDd3Y2ZUNRUE4y?=
 =?utf-8?B?ZXZ6aXh1SzdZcWxQVERzV1RTakRtL1V1aDhSY1BidlltWEcwaUp5eGZ2OG5z?=
 =?utf-8?B?Nm1GR3paeTQ1eHROUkM4ZlNjU1lTZzJPYy9USm1UVE9jb2R6TjZMTjgxQ0x6?=
 =?utf-8?B?NC8yODRKNVgvMEliZFpCTXZobWFCT3pCZkFrd1NETDBXYkJCaVArLzluN1FX?=
 =?utf-8?B?WmlLNjdUR0c0dW1hNHp3Rml3WnRGdGg4cVBIMzgvWXNySFVZQkZqODNHeDFG?=
 =?utf-8?B?bnRIWVZReUlvdE9LZTdZNUlOSm1vSGVqUUkvYUYzaUcyN00rZkYrR1NPd3l5?=
 =?utf-8?B?WEVGWkM3VVFGekNPbU9XOGExN1RjM2VPY3FHWEFYc1pyTEhSWTBTdDRDdlNl?=
 =?utf-8?B?QjRzbWdzMUFXOW9WZ29KTlJZOUNEbFRPeDBGQi9Md0lsS0JnNlhRK2FCR3hG?=
 =?utf-8?B?RTdjWWwwSnJpU1hIT2Q5TzErSkkrdzdldUczb05rM1FaZVNOWWFsREZLQk01?=
 =?utf-8?B?c2t2UHhYbFFGT0VjcTl6U25PUWFFOUZmekZSbDZEbkpNTkVISEREdzQ2aDhW?=
 =?utf-8?B?RElqOWtaTEx4UTR1eEQxeFF3S2VvbGNBUkV1KzNFYVE1YUdGNVczTUpjdnly?=
 =?utf-8?B?bTBQdFIwcjc5amdtVFFDNkxaV0k5RzlrUmtSMFEwZUdROUExRTdtMjcydkI4?=
 =?utf-8?B?cE84M2xlYU5XOXF5MFg4b2o0Vk5tNDhGeUNIeE45MHFKQVNMWVlIdnNaeFZu?=
 =?utf-8?B?S3ZMODBTaWt5T2dwb1dQQjBhTWZyOUpVVFJDZ3h0cys2TzRLUVhBQ0lXYkNM?=
 =?utf-8?B?bXFpcnJmWW51QVM1YnlpcVlTK0cwRmhIdWdYaHI1VjBwcWhsaW5rYlBpSDZY?=
 =?utf-8?B?VGdMTjVuRGNZWXZFQ2c5L3BDV0wyb3hnUVZVelVleXFma3l5dEoyckVveUNH?=
 =?utf-8?B?R29rOVltRkJJcUJIRXZDN1R4cEdLcTNVS3U4TE91dFlTSTRGMU9BeFR3Zk5M?=
 =?utf-8?B?NWVkZVJoK3FWVjFBcXBLSUdQUUlwYVNoL3dlKzc4eUVETVdBSjJ3c3JuSGFC?=
 =?utf-8?B?eHROR1JheFlTbk01Mm9mZVZlZUJKZElaaDFLcVVYZzdtOHY3TDUxNHVYbzZq?=
 =?utf-8?B?S21DU1dpNWNLRXRQUFZyL0lBWU50SWpLdEtTR0FrZmpEQVZGSkdVdGJPOC8y?=
 =?utf-8?B?VDRFT0pVN0k2eVZ0Z0x4M2dSSWpkbzhrRHBaaWdEUGIwRFpXYTNjc1BwREFG?=
 =?utf-8?B?WFhYVnQrWWVic0h4NWQ3UHp6L2U4VUJVSHhOWUcvVVo1Ny9vRjdXb0NCa0FP?=
 =?utf-8?B?aHRQRDFMVGN6bEZVd0s0NDlSdnRPMVZwRi9qTGd1WTFIWEs2OTdPYmJ0ckZG?=
 =?utf-8?B?VFY4cXMzSk00TzBBSkVCY3dKblBLcXJUd0Q2eGdCL1FuSEM2VStrNS9CdlJQ?=
 =?utf-8?B?a0JYUkF5ajhjczBORitOeU9DaEZmcks2UnRDSzhmNDlEcjNQY0srV1R6d3Bx?=
 =?utf-8?B?Q0NWc3VmM25SVXJCWnFrSlRyYzluYWNQc2tnUW4vbTZnUzBjNlVxT1hlK0ts?=
 =?utf-8?B?SHd6cDBsSUJsbHdtT3hWSnhBWDhpZEdFazB6U0trUTlLWHBsSnliUHl2eC9H?=
 =?utf-8?B?ekw0dURRLzczWjE0T2hWVndhYnlJSENSVnVQMkxhT3pMWGdid3Z0eW1SeEw2?=
 =?utf-8?B?MktyU3RWL0czOWdpTWxmaGg0b2JBN0s3MzQrd0UrM1JrMHFDUThWQTM0VlFD?=
 =?utf-8?B?WDhrQ3VobjFieXh0MWxGYTg4ZFBLVGx4MjU1aFFPNndCdU5QU1B0UEdqSldv?=
 =?utf-8?B?OEpkd2hCenRRRGFiZUNBK1dxM1NKMHBHR1lBVGVCaEIxU3puRE9iQzZQNGJB?=
 =?utf-8?Q?BNfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e7f432-ff1c-4883-0d50-08dd83d987aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 09:14:06.3346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRWcGBuNp9XKFLvGfNk7BWZntuiNSeHAVATzUpfWM3gPzy0zP3SmwpnSdkH4UJ/vitBX25qwfIBfKt0sN+c5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSP153MB1045

PiANCj4gT24gVGh1LCBBcHIgMjQsIDIwMjUgYXQgMDI6NTc6NDZQTSAtMDcwMCwgUm9tYW4gS2lz
ZWwgd3JvdGU6DQo+ID4gVG8gc3RhcnQgYW4gYXBwbGljYXRpb24gcHJvY2Vzc29yIGluIFNOUC1p
c29sYXRlZCBndWVzdCwgYSBoeXBlcmNhbGwNCj4gPiBpcyB1c2VkIHRoYXQgdGFrZXMgYSB2aXJ0
dWFsIHByb2Nlc3NvciBpbmRleC4gVGhlIGh2X3NucF9ib290X2FwKCkNCj4gPiBmdW5jdGlvbiB1
c2VzIHRoYXQgU1RBUlRfVlAgaHlwZXJjYWxsIGJ1dCBwYXNzZXMgYXMgVlAgSUQgdG8gaXQgd2hh
dA0KPiA+IGl0IHJlY2VpdmVzIGFzIGEgd2FrZXVwX3NlY29uZGFyeV9jcHVfNjQgY2FsbGJhY2s6
IHRoZSBBUElDIElELg0KPiA+DQo+ID4gQXMgdGhvc2UgdHdvIGFyZW4ndCBnZW5lcmFsbHkgaW50
ZXJjaGFuZ2VhYmxlLCB0aGF0IG1heSBsZWFkIHRvIGh1bmcNCj4gPiBBUHMgaWYgVlAgSURzIGFu
ZCBBUElDIElEcyBkb24ndCBtYXRjaCwgZS5nLiBBUElDIElEcyBtaWdodCBiZSBzcGFyc2UNCj4g
PiB3aGVyZWFzIFZQIElEcyBuZXZlciBhcmUuDQo+ID4NCj4gPiBVcGRhdGUgdGhlIHBhcmFtZXRl
ciBuYW1lcyB0byBhdm9pZCBjb25mdXNpb24gYXMgdG8gd2hhdCB0aGUgcGFyYW1ldGVyDQo+ID4g
aXMuIFVzZSB0aGUgQVBJQyBJRCB0byBWUCBJRCBjb252ZXJzaW9uIHRvIHByb3ZpZGUgY29ycmVj
dCBpbnB1dCB0bw0KPiA+IHRoZSBoeXBlcmNhbGwuDQo+ID4NCj4gPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiA+IEZpeGVzOiA0NDY3NmJiOWQ1NjYgKCJ4ODYvaHlwZXJ2OiBBZGQgc21w
IHN1cHBvcnQgZm9yIFNFVi1TTlAgZ3Vlc3QiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvbWFuIEtp
c2VsIDxyb21hbmtAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gDQo+IEFwcGxpZWQgdG8gaHlwZXJ2
LWZpeGVzLg0KDQpUaGlzIHBhdGNoIHdpbGwgYnJlYWsgdGhlIGJ1aWxkcy4NCg0KUm9tYW4sDQpI
YXZlIHlvdSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiB0aGUgbGF0ZXN0IGxpbnV4LW5leHQgPw0KDQpS
ZWdhcmRzLA0KU2F1cmFiaA0KDQo=

