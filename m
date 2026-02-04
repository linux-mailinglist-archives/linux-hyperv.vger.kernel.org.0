Return-Path: <linux-hyperv+bounces-8707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AQbRLcX0gmn6fgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8707-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:27:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8EE2B06
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B9E3036EFC
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F438E126;
	Wed,  4 Feb 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EeifAvBz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5B38E10D;
	Wed,  4 Feb 2026 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190015; cv=fail; b=guqhProX7nsD0OI0kUs92GHMj8ky+vDYDb/wZWCMaxeMGeCz4M3XiJbjFFMk5M6v+OOuH5HNwIKNaX6GlIIkX1d7RZggUtrS3Q3OlC2Tczcli1NHzKVLPgOgyy5lSfHHMfynD5RZ/JrjbpbVv57W/S+2OUERMqEDRn5REfTdylg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190015; c=relaxed/simple;
	bh=x7qfmGGVvm0+pYQAojlOSiqAdXff+aAEfZ/4u6O89hU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svx3FGjCIlDn+EkMjyX1yIQQRD/yuVxmeAS0I20nEMqrQN4Lsh9pzAeQxkKXW90niqH+Zzer8Ef73lljOPgNWHWTPTC+xM3qfaWFzKIeDlMqNs0KmK8UTgiHQnoyFvTbwWTfejkDHgOkBzhq+4+euRhYNCfBSXlKUbQxXKOIl8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EeifAvBz; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSn4jbanLV99HQ9FGHQCN39b3glzT45MedqVfMDizg+E/RyC2cwNpyp9Pa315gsrsjlcDbsoK9B32ylVAVjPNMlsqo/uWx63BxVqxU42k+F54B8UWe0AHGY6L/LXckZpGqBW+BiJZtsk/C52HnR8NistAdToi0sgcAp0J4+XM9WOFyCC3CS0zdbV1LTSrejWVOXjydJ9XXXZs8lWeB0awl+mJT2OLjQg9/yV/xrPsJnAP6LH8UWoDZ3S9R6sNiwOkkAU4ScaM88M1Y2pfqoE4gPO6ufGOp3t6+t0CilxU7w06mzafqjrARQCneWKOdyvoylsJcOH3kiv0crbsKOFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX5LucJg1nqE9bUbSUdEqfp2X4bVikq9vRnTH9ZzD+s=;
 b=xSVbKcJXD1X2p3dTOqhp0cxZHwGafIx08jR2hBIs3MjZOO46RMLKkjeMudJ/AbBdqOaNdrECr+gs9yn1jUQGqwscUndjOaqijPZ7z8awhiqbTU4QSLjMppqWMwX6oTXGCmCn/4WE9089io6BZCRKenQB9RyXZCJYBQU3frHgG3yjlVgUNkbwxjJCfT+WLIGzGxM3nxHLeG3J+s80N3rNZ5yEA/J33YNhCZZieM5sVgXv+h6b+KksgigEz0ulpXtERKjwX53YdUjFf+pZ1W/WJ8lsRSXHH8e77iAKCjRQgfxiMnjjBU6yVCSJGW7W9zh8dcDhOVEOhu2yj2gCHO7o/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OX5LucJg1nqE9bUbSUdEqfp2X4bVikq9vRnTH9ZzD+s=;
 b=EeifAvBzNUabyrilgjr/m3SBHQ8Vnq4/SIYC5IfX6ARYSPfBKv6YsrK9c2DjNFm8mSoWV0TUpUvCPORWHNFBpZFFuR+IV2Y3ehRK7Z/cugksuoToW1W1MrOHHJMi7noXRrDDsJpPf9h9wQ9JHW48tfTj0IuZZocLMS8mler0i03lU7KeKYs1Yn9nNmWUwIk6ybpE85vMZq2OQOZ07v6ool0L0G/QARdsCJnh4TfwF3hTe0ATOuRoXmIOInXes/oOwk1L3W8fUYPuA4uXCGQfQXYACwzC9EuVJjTTlMJtg2jP0DNVz4UVsNgPLWZX0Dzrz9utx6sdCRPJ8KSnLFMAjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5570.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 07:26:51 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Wed, 4 Feb 2026
 07:26:50 +0000
Message-ID: <10ec70f2-27a5-477f-b6e9-164f7b7545d9@siemens.com>
Date: Wed, 4 Feb 2026 08:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <20260204070004.GM79272@liuwe-devbox-debian-v2.local>
 <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c377fab9-54f1-4eb9-8810-013a8bfb340e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d1e501-3e19-4db7-f4e1-08de63bec361
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzFvVHVKKy9mS3dQTk83Y1NrWHdGV3VBN0VQUG52bkNPQ01FcS8wb2lqYURO?=
 =?utf-8?B?RjZYTklDNGRmN0twYzhxczJQcE1EZC9BUFpiZ1RkaGpZc1R5cStGYXlFWmpt?=
 =?utf-8?B?UURCQzBQZVlibHdZa1hIb2FQTHEzbmxDc3BJTGU2SE4rWC9zN2VnWjlIeU5L?=
 =?utf-8?B?TWpnejNoVUlWbWxrL2pSRU1CSjBLeS9wTWRFYm5rOTdUNjFTU0sxYjdjbFpt?=
 =?utf-8?B?YjlMaHRCaEtTU1ByYXExWUlVMzgyelhnaGxHVFdLQVUrSW1ZbS9RWjg1MXlE?=
 =?utf-8?B?TXpMbDY4ZjBXU2FEeDJ4dTJObzA5NnpWNmdMOFFDWWlBWmhMZ3lsWStrTzBR?=
 =?utf-8?B?QXN5Wk1zYXhsMWpobUR0dnY1QnJ6RWpkYkQ3SXBHZHJKZ2lVSTVJblBNV2JK?=
 =?utf-8?B?TTdCemNJbW1LL2Y5aXk4SmJKYlJGcHAxNm9UQzlFMm5PTGUyWGUvZG43WWla?=
 =?utf-8?B?bVg0VWZxcjdtNHI2WW1hSldVZ05GdVZZWEZ5TnlOM3M0OXpsSS9PV3hlVE9P?=
 =?utf-8?B?eDRBZ2FFS1Z2bHpuaHFmaHJORTh4L2VIM240MXFvWnRCMEZtM3JFdVdjeFk4?=
 =?utf-8?B?SWtCTll1R3hhUUJDR3lLcGplbjFaMnVLV2RZbXJnZzdKaVJzZmdyS2hWQm1O?=
 =?utf-8?B?eXpCOUpUdVpjcVd1UlFmQ1hCMHhIY3g5blhiZ3E2TE5OeWZNNXV2RGNBS1RF?=
 =?utf-8?B?cytmN3ptQTRqbXQ3ZFcwWVFkTWdhb0lsRkZ0bXNiZnNac0pnYmJnY2NrbGlu?=
 =?utf-8?B?MEF5LzdsWUpnSWg2eDhnaDIvcnRGbTl6SUU1YThGMCtLNGZUc2IvME9OeHps?=
 =?utf-8?B?MlpOWDExM1BidERmeGRFZk02VTFvMlFOeFVreW5KdW43WFovQ29HZW5MWG1T?=
 =?utf-8?B?dE5UclJGS2pOdjdPVmFINE1GSWZuVXhwcHpNMEI3VnVZbWtnbExheHJibDQ1?=
 =?utf-8?B?cEkxRXFoNGNxbXhicGJ5Yi9UYVhIejdmbFQvMUhEaTByUEJwaUE0SWthbDg2?=
 =?utf-8?B?dE9tRC9EMFJnOHQzS0FJRG1tdFVkekloZEJhRFRzbHMzYWVxZWdnb3pSM0ha?=
 =?utf-8?B?UmdkSDZGWVdHSlp1dzZndHR2V2Vla3ZkQkxIcVdtY09GVDRLaW0rS1k0NStq?=
 =?utf-8?B?dmlTS1Q5R1FNUHMzVjR3MUtJcXVzTkt3TCtvT1VpUm1yQUxGblFIZkxBeEc1?=
 =?utf-8?B?WWsvVnY1OGRHUXVNZTlBQkVpN3ZmdjNLNG5BaW0xOGRzekc1dkFrMVMrZ1cr?=
 =?utf-8?B?WjhYMERIMDRVYnF5bjBQdEh2VVordTgyZEpWSDJ1YWduY1RHWE1jVWdtS2hL?=
 =?utf-8?B?R0dpcFdhZGhweDc5RThjcTM1amUyc1hWejd1U0RhSmt5MVFJMG1Jalh4bDEv?=
 =?utf-8?B?bmtrSXRINW9iNk1lZnlHZ0MrbnpMangzckpzRnZFNFVweEJNMXVsSm0ydnlP?=
 =?utf-8?B?SkxLdnB6K04zNEpvUjh5dHg3bVFkZW1rd3BTNFRGNk9RbXhWUDkwNUpPRjJK?=
 =?utf-8?B?ZHN0eHFEQ2Y0WUJPWHVEUjU5YkZlL3liUmk0TDFTZWtOeXFCeHNKSjI2T2xa?=
 =?utf-8?B?bXJaeE1MVU9YaFhhTWlpQTJaS2RwdlMybi93N3NLRkdaNzhhYWxTTWl6WHhV?=
 =?utf-8?B?WHlpenI4eEh1SjRWVS9ZcUs3MzRwdSt5OTRjYlNMc0VDODVDblRiOHdWZDk3?=
 =?utf-8?B?R3Zld1lic0tja0FnOUhlRUtqNHdDV09leEZCb2d2ZCtKbXRHbkVZTjR1TGJ2?=
 =?utf-8?B?OHNiMXJTVm9PUjBQY2xKNHNzekJ3eDU0aFNZS0tKWXI2TjF1UUdJZzZqYWhQ?=
 =?utf-8?B?VDBBOFFaZXJPM3BlZUFCeFVzZkVTM0pDYVF2T2xqRjFsUERiZzIwOVhzaHB4?=
 =?utf-8?B?enYxMkZzNVhQYVFEVDZMQXl1WUpPTGtvOXJDYnQ5MUpRQzhsK2s3NHp1dkdB?=
 =?utf-8?B?Z1hGUTlGbm5WL3ErT1hoTWVMT1ZFbmNYUkJ4NnlGK1FkZUdzQ3Jydk1UR3dR?=
 =?utf-8?B?bUNucGVQdm9xMFEzdlpyVGNXTE0zbHc5UnEzYnY0dllETGY1NFllcWU0anZY?=
 =?utf-8?B?UUFINjgwd2NLaHpwM3VlUkI5Rmt5bXpUbnNXQWlLa3A1dUNQQWNZbUZpZVpN?=
 =?utf-8?Q?OPsM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTFIaWxyM3RBUTZzblpnSXNmZ0FDYWk2eXgxU01mNlJjVVk3WG5pSXRXdnp6?=
 =?utf-8?B?dHpnMGR3dlNtVjZSMFFIelE3U0tqdkh3WEZOL0FQNGhsS25USWxLQ1RtRjR0?=
 =?utf-8?B?WnNWaXpCc1hzelgzbXFQTW9STFVka1AxdnlEZUwveVdFR0tMNFIrZCtoUUh1?=
 =?utf-8?B?ZXc0ZUNUcXRFeTRLS1hrektTYlhsalp5ZXkxMlZ4cXBWUHJFL0VIMkhLekFH?=
 =?utf-8?B?bWFDNUQrZmxkS05PZmg0RzRwcUw1VDZaQS9PNWhjbUJXUGZmMGdMbXRXdG9P?=
 =?utf-8?B?cXFlUlJOazY2cms0eW1jMithOEpQSCtjTm5PNVdCWjMzdnZJU2IvQk80TkdB?=
 =?utf-8?B?RTB4L3NlR1lIZmpoT0ZNNWRQaHdZQ3NjcitvR09ERkt4L0FqTncwSEdEd3o1?=
 =?utf-8?B?aWlrT1oxSWNKUEVXcjlMcUN0U29IdG43dmc1YnQ0ZXNwNGo2dGh1Q09KajQ4?=
 =?utf-8?B?Mlp3Wk5tcWZ6VFp2YkNnNFZZSDdzU2Q2eGpYVzF4c1BXeDVUOXBxbTdpVlBh?=
 =?utf-8?B?TCtzQnRKdmlFN3VQMWZrdkxlakxrRDZEMENGSHVDUUZSbHk2K2dEQUIrTEZw?=
 =?utf-8?B?eWs1ekVTV3lIQ0F5S2JkN2lpME5WeVh5OWNkK2ordFJKS3h1RkxKcFBHU0Jv?=
 =?utf-8?B?cDNYNTR1cVJQYUtrb1JxZXZUNVc2dVlSYURlTW9yTmgzekphZGY2Y3Q3cG5n?=
 =?utf-8?B?VWxwcjBjVEd6cUttNnc1K1FHSThhenk3Y3pOajcwWnppZ0k2NWUwbENJYmFr?=
 =?utf-8?B?UGNhU3lYZ3NTVVdrczk4TUc3Vm81cVJUcWljbEFlMm44ZEI2SlQ1M1MrbGp1?=
 =?utf-8?B?dlZiKzMvVTZCMnY2M3c5d1JkYUk0cDJ3c0pVWVV4OVJ0WHVmVm05TWJ0ZFVH?=
 =?utf-8?B?amJNaW1nNjErdCt6TlFFZlVoVVpLWnpEME00b0JBNzluQjl2RWZCVUc4K2lQ?=
 =?utf-8?B?Ri92MFpqUExhWUxtUU0rMjlMb2kvK21oa0ZyQlFqWXI1ZDAzcDNYMGpWUjRH?=
 =?utf-8?B?dER5SmYwN0VGZTQwaXBKTUpOTWlEWVQyTUROanREQmw0aVBQeFB1YW44YUFu?=
 =?utf-8?B?VmQxZFpxTU0wYy92RktUTUhEc2g4MVRyNU1XN1ZjR2p3cXFsUTdLaDVoRURX?=
 =?utf-8?B?R1RZZWJuNnBkQlk4SnBoYnRraldzVFhmZzRaMGVVNkhNUkZsczNnbTZIdDh3?=
 =?utf-8?B?NGtZSVRac2JKVEt1MjZrVlNBMFpXcGJIYXkvYU80YlpOOHBnd3pzWFJvSUI5?=
 =?utf-8?B?VGJpNHBkVmVjTDFlU2VWdVFEdGtHQjNJWGgzSWdqWDdWUDJ5VGZaT0lET0gr?=
 =?utf-8?B?bFBjU1J3cU9ud1NOSU9CU1VyNUJldVZvWTJxTExtSDJrdGxOM0xES3NickFx?=
 =?utf-8?B?VUdaTlQvTjRSTW1zbzgxMXdRNXZYRTRWZlZkaW95dXRDNmdjaTJ6OTdRay91?=
 =?utf-8?B?Mm5HdHVreW44QjlKVk5sclpsNzJVeFpwRlFOVWE3amRkaFhzaU1xNjlyckgr?=
 =?utf-8?B?UXVVSHc4YkZpd1h3VkpGZ3VFS2xhQVkvQ1dCRWFnczFYVnZKZDJNdithZW9K?=
 =?utf-8?B?SVVURHpSVkRsRThBMFJER2NFWkdzVW5DcjB1SEtGb1RRWUhJZUcrQnJVSGJo?=
 =?utf-8?B?dUo2dHhCTXJhMDNrWHJ5OUx1SHFkWUV0ZWRKZ2NQVTZKUE5pVkdMbVJPZTEw?=
 =?utf-8?B?SzUwbG1iSm9qaGY4N2VhL2xUQVRudjBsbmVVYjR5MUgxRjVwTTRqMnZjTWdo?=
 =?utf-8?B?ZFF5alg2c2ZVWWc4NzVUR25CMGR6YVIvNERWc2FPdWFCRTQ4b3BLTEVWV3pm?=
 =?utf-8?B?eEZ5RFgwOC9CVDBDaVRmVEl6SlRrSjBLMWxkNlZiWFg1d2oxdFdiUUs0eWsr?=
 =?utf-8?B?M1VQZC9XZ2YxTkozVDVTTEt0aXpjNUkzU25oZmlWNURHT2d5QThSTDE2Qnpo?=
 =?utf-8?B?bWloenM5MnArYmRCS2xRbm9lbTRMWWV5RmF1d2NqaHBLM1M0SGRIRUdVWTl3?=
 =?utf-8?B?VlBsN29PV0plK3o5aVZRRHJJNDN2VjRmb3BOTFdrNGVEbjBwVHovaUFVUGwy?=
 =?utf-8?B?aHhJRWt6TVViTGNTOTYxaGFKUFlOcm05Y0lOdnREbVRQbVdhNTh5NnZhbE9j?=
 =?utf-8?B?RFFKQkRkSXluZFBYRjIzb3FkeVhXMk1ha2xCTmhNVDF5K0NVMS9vSzcxajli?=
 =?utf-8?B?Vnk4OEp4NStsRG9kMHpoUkJBQ2xXc3Fka1NPWVZnL0tscXFoazBDUk5EcmUy?=
 =?utf-8?B?Sms5ZldlKzBSWkRtM0U2c2oxcDhYVjlRZmlIM0grQU5TVVFIZnp4NkVuVmpi?=
 =?utf-8?B?UGZlNG8wc0Q3RjFCMWplaHNnaHNYMjU1cDFpVmxMd0lUb2xicUp0QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d1e501-3e19-4db7-f4e1-08de63bec361
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:26:50.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbfYhtKQXCP9hVCe5FuABUdFI5qAVrv3k2D71tJWbn6x1am4TnWm/MZ7rHzgBDjGRjj6MiXfP/KIqyWQ8CioAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5570
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8707-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fosdem.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 0FF8EE2B06
X-Rspamd-Action: no action

On 04.02.26 08:19, Jan Kiszka wrote:
> On 04.02.26 08:00, Wei Liu wrote:
>> On Tue, Feb 03, 2026 at 05:01:30PM +0100, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
>>> with related guest support enabled:
>>
>> So all it takes to reproduce this is to enabled PREEMPT_RT?
>>
> 
> ...and enable CONFIG_PROVE_LOCKING so that you do not have to wait for
> your system to actually run into the bug. Lockdep already triggers
> during bootup.
> 
>> Asking because ...
>>
>>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>> @@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>>>  	if (mshv_handler)
>>>  		mshv_handler();
>>
>> ... to err on the safe side we should probably do the same for
>> mshv_handler as well.
>>
> 
> Valid question. We so far worked based on lockdep reports, and the
> mshv_handler didn't trigger yet. Either it is not run in our setup, or
> it is actually already fine. But I have a code review on my agenda
> regarding potential remaining issues in mshv.
> 
> Is there something needed to trigger the mshv_handler so that we can
> test it?
> 

Ah, that depends on CONFIG_MSHV_ROOT. Is that related to the accelerator
mode that Magnus presented in [1]? We briefly chatted about it and also
my problems with the drivers after his talk on Saturday.

Jan

[1]
https://fosdem.org/2026/schedule/event/BFQ8XA-introducing-mshv-accelerator-in-qemu/

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

