Return-Path: <linux-hyperv+bounces-8792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F1KObX6jWnz9wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8792-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:07:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9C12F3AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD063019F06
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Feb 2026 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280351EE7B7;
	Thu, 12 Feb 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="A2+9UDqN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA119D8AC;
	Thu, 12 Feb 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770912380; cv=fail; b=fJUnwMbSRlhIZxYFuOOYynDL5QmBilowPoazAehDfveAofr628+RJVRRvyhOJDNAh1NtFx3NHp7TQXzCHUYnJzAk16yBQbxpLuiJN7Yetdlalvdy4rr203iJW03cB6HWV9RnamWnZkMraGj/KArsHBMffXbGxFr6XoDinxtzYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770912380; c=relaxed/simple;
	bh=NfWqXDI14/lsEyCTgpF8erJxk/ia826JF/Z04G2uEvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxlG1okFIMIxYy78yhTBDhYwL9EUTbZMbP27lMZD0V9DPAHKIflf9i2vK9LI1TD8O/DhOT+uZWJBIgTGxe1m+Xnz8jTRbYjPFe+c9hSejkEtrE4MLnLdef9oZThamnojTQAsCmxbqQFqn/55YwZ/jc56C5ETNLscwWy5Q78Bfa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=A2+9UDqN; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj0oOU607HoY2Z22njloqwJPWM6CkjyC9oQTmAf/bY7QNRvM2pVann/dQTks/pcDfSaNVMxm7pEIL0sw65fL/wHlkUsQyf65p7wRX+wXvx3IRwK26k/ZTk7tMOM4S2KVDEejgpYgPA9iTqoGsIDt967HxJ3/DVyr7oJLOFd+8tAv6dZmYTMxn8CH4Ra6GPjhE+d0kbic0/ABaFxk+YUrJk4wCP6YDJNorHD/b5dVgNLLDHf9lJkrCIjCtZpVvMIGgrG2l7N6Ai4zajLmGVhQ+QncNdq+88LFjQooAtmN6LDNxGIUZ33zccGkkLK76fhQRPbQT37KT2GOkpdI06kogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrVd4/NH4x8l0D8zH1ZgOPxWBW1PCAWMvboUf11U8u0=;
 b=klWP4EqNGSqvjs6u8TBozBsApypFa+gttzO6WhAQe8bIB2kGsKcLZaka9olBs1nftKsVXXsBn4MB0SyGoUyMYTQQB06nSt0sYFZkyC3jewT7cp3C16kW4WOte3/qcoz+rprQZwhHfoyMdFkbdfpIqPOVg/uJLft5M2BZFsJH9jJX6sEIgj9T552XuK6WDluLydXtVuKqri7VasPRUQ9hCnGYn6vHByMwCJjm0hHFtFs9tD61hV3a8qWkUP0bfb+wOzRc7cGjvIRfl9k3QRo6NSxDA6ItN6IxokkRxRwrkKvdholikwG0kkcxZ4KVVgtongHjUzlMumM9yd0vqc1ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrVd4/NH4x8l0D8zH1ZgOPxWBW1PCAWMvboUf11U8u0=;
 b=A2+9UDqNCZm7ruGnffVTkSKZ7LL/KIWag7lvvNX2RquCmWTNA1r/KNaM3uEgEIDpJXI25YtVacf2DQBCCnmGhYAlN35/EyQ2wfpntuS3cIo3xYxKBFP4aiD4eNjv9jgHrKIsLbvqngYVwiDKNNvbhjjlCoasKSZV6D2w4AXHDOOnTUEGSKAUw4Hta5Zm9lqzruIZKyFxqnLaGuZ22WY2pstHy6NlbeCNXo55G2m0Pbr2DYVOir5jrOxdZHumYwflVZv86r/sL3Wrkc1mgFhMTAJ7gTN/P33sVdwKA3V4xmuMN5oGo6lfX0wXHIoDTmk8f1vVbE665o/FCJDFcJ/YwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 16:06:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 16:06:13 +0000
Message-ID: <b084a7b6-c394-4337-82cd-8b9cb911d8d5@siemens.com>
Date: Thu, 12 Feb 2026 17:06:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
To: Michael Kelley <mhklinux@outlook.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
 "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
References: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
 <SN6PR02MB4157B6A9C8BEFA312F0D9D68D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <eb5debe8-b7d6-4076-b295-9a02271c2ee6@siemens.com>
 <SN6PR02MB41579F60E39CA2A3CA8A5A75D467A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <1b569fcf3d096066aeb011e21f9c1fe21f7df9b5.camel@siemens.com>
 <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SN6PR02MB4157DB59F0F7BFBF56612651D465A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:4e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3198:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d658576-165e-4f17-ddd7-08de6a50a4d6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SndveExqU3dGeU0xUVNydHBMcmtyT3g1eTJMQmo5bVR5ZjY5MGJVcGFJRFls?=
 =?utf-8?B?QTRacTF1RFRkNDIzdWJsY24yMFFvVTNrQUJLc3JtaFJTTEZ4eCtLckttZmhq?=
 =?utf-8?B?ai9Qd05yM1pmS001ZWJxeFY5MXA1ajhqRnJUL1d4UFlzNDJ2K2U4RGhEbEpw?=
 =?utf-8?B?NkJmckxmT2xSSGtjN3hwaFI4OE9qWXFmRFhhMDdRcmtSd1ZDUnJRVUwrNWJN?=
 =?utf-8?B?aGZDTDI1OVE5TFFJZTJCd0o4S1Z6S1hhL09HYVd3ZUlUNVFkazlJa3hyZ1lz?=
 =?utf-8?B?dzk0Vm1ScHFwR3lobGdiTlhCdythdm9BQVdJM2NPbUlsWVllOWVONG1KaFov?=
 =?utf-8?B?UlJuRjZVeCtEa2FIN2p4TlJhenBuSFJZN25weFl6ZStNTGhHdzJ6ZGhjN2Ji?=
 =?utf-8?B?SzUyenFUdHdxMTBtaW9Ea3MzYTFIVGFOK0lSaFpVUmVtZzhJeDlFcS85ZXN4?=
 =?utf-8?B?UzJ6MG1JNC9UNGNsQ29Zcm1aZVJoMW9yVTFBNDZuVVhVazNqOUFoWENFMXA3?=
 =?utf-8?B?bTJ2dXVjVVZucGlwQ2ptQkVWVVdaSnpvak9Yb05udkpwdnd0MytTa1d5dEg1?=
 =?utf-8?B?ZmdlKzZTWjJFcDdxVjVjdk14dEk3dXd4em9HcTlTamJtbFRnUW9weTA1a2JJ?=
 =?utf-8?B?UnMrT093aHJLbXl0c1dGN2RvNGR1emdlYjBiRCtZMWQ3YkRGczJpcmxoMjYw?=
 =?utf-8?B?TklUN2c3bDVCSG91WVR0bHFyaHhCUjhBOCtIdk10YjZoVHFLVnV0bDFlWllB?=
 =?utf-8?B?ZFNrRG5nb1UyaVlweFd2UTRqUVhDNzQwdHpGV0VudzVDUnl5R3NJNjkvN1c0?=
 =?utf-8?B?NytjM2hXdVdQTFlIeGttbWEveFJSR0E4bU1LYitNdXMxOE53eWNXaGp4R2l6?=
 =?utf-8?B?UUg4WXhmV2pra3lDZ0VZMEN5SWJVbGl1aDNsbEU2SDhuelVsRDc5eU5ydTRL?=
 =?utf-8?B?QzhSTHBRSzR5Y2hqZGFpMXE0MlZCZTAzNmJqdG9FVmlLTENKNjBTdzAzL1Jn?=
 =?utf-8?B?STZXSG5MZWJtNU9UK0hnbXIyKy9Na3YxaS9oclFKYTU5TEwxZnJxZytCQ3hu?=
 =?utf-8?B?V1BVM1g1bWNUNUY5WXNYUGYwVjUrcVltS3k5MzJsTUlGMDhUaVEyT3pZSTAx?=
 =?utf-8?B?UGV1dkZKeldubkoycmp3cU4vWk42WkV2ZlJvOVRkNUxCMllra1hlNzdKd1dn?=
 =?utf-8?B?eUdxaXdibzd0SXh4c1JRbi9KNGcrYjlndXJ5bTdnSGxVcll4WDlRbG05WHhL?=
 =?utf-8?B?TmR6N084UDk1eXdibGppckdDL3JSQmsvald3US9Bc3V3eVVvbDFvVGt2Tjk4?=
 =?utf-8?B?NWVoR0ZZb05jQVV1RVhCUGc2M2psNTdZTHNmU0ZuTXN0eGJrYW5hY2FjK1pm?=
 =?utf-8?B?V1BkMjIvdDNiOFVvSk42MklwSGI0ZTdqeTJYRFp0TlVzL2xkbFM3S2tnSDJ6?=
 =?utf-8?B?Nzg2U3hkRjBrOHh1Q2RQM0FORTNzTU81K0R1VVBaaVpwOWlodEZMVERza1Ns?=
 =?utf-8?B?SDFHUTgwM2Q1bUxNSGI5YTZXWWMxVmg2QzBFS3k3a01RdlFCdHdnSkZzUTlT?=
 =?utf-8?B?cnlBZ09BOEtObzVreVRVKzJtN0VmT2Q5c3gxMWQxVVpvSWNEd3BYN0hyNmtw?=
 =?utf-8?B?SUlKQ0dLdFBFNEdhUTNYQUdTbVJ1Zm00ZVJqT3pvUVcrRTI3VnQrRDZ1b09P?=
 =?utf-8?B?RUdYN1FFL2g1REVwQlQvV2xpUG16NHdEWFFmSHNnRCtjTytBVWg2YmhDWURI?=
 =?utf-8?B?Mk5SNjVINytPaEp2aUJnTHo2anozV085cTdjRUNzODhzdXgrMng1MXVKSzNw?=
 =?utf-8?B?ZVQ2dGIvYXowdElybmhyQTRDZWdLSytiekRpZ2FZNUtDenVBZUJ1RGJIcEpT?=
 =?utf-8?B?eVF4bWpxcC9ZeXYvN1ZpdGljWHlnVlBrYk93eGhRWlE2cG4wV2o1eDM3Mk0y?=
 =?utf-8?B?MnZmZmh4REl6Q3QyYzZWckg4OUExYTl4d2VBTGZtWEMvQWI0Tyt2SmVuWHdD?=
 =?utf-8?B?TFRuSlJnbHVGL2ZQRGVoWTJKT1dTMjZUWGpQRnY2alB4ZUJaLys2V0NiYWdX?=
 =?utf-8?B?QURDUWF4eHNjekpNQXpycTEzTFJTdWl1cHc2WVRmdTZsV2pOd2JnT3B2ZG9a?=
 =?utf-8?B?SGNYaWRhZHNrZDBRenNVR2loZEhmR3gwbXJ1M0lwdTJla0pocmpoTXJES2Fk?=
 =?utf-8?B?Q0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUlkb3oyWmR2ZUYzSGdpemplREpONC9oQ2EzT1BDRzUrdHhRNlMrUjNtTVhz?=
 =?utf-8?B?ZEdXTDNMcG5kUUZLbHluanY4b3NCRnc3WU5VNkMwMndBSEtmRGhmalJtTDRH?=
 =?utf-8?B?UmZJYVBNTjdHUlpzRzVBOGxqL2FtTnVhZ2k2V2VNT0tEdXVsNmFXMm9WLzBM?=
 =?utf-8?B?YTdNcHlkNHEzV0Z3MGhsaUFsdWpSSlZVWURXQ2J5RHJtak1GcE5UVXNJZ0dU?=
 =?utf-8?B?UUIzRWJ3aVBKdVF1NS9vb2JiMHRmaXJKR2xyUjd2R0w0NkpxY3had2dHNTVR?=
 =?utf-8?B?RkdBZFQ5Tjc5S1ErRWhmUVZ5bmVSMHFaWk1xdldOOWdzYWFsTExIUkdTa05z?=
 =?utf-8?B?SnpJSlUyUG82aElFUFpMSXBCUWtUcUMvWEJ0aXVnKzNKRWhnVks4WXNVUnpk?=
 =?utf-8?B?UnljQ2dLR1hlMFJ2bi9NVWN1eGNHUE5TdGhaekkzR1I3VFdWSnFHWmxPdm40?=
 =?utf-8?B?MEU0dlBZV3JQTGNFditHdFRaNHVydkJ3a1FqMnBadW54bGpMemYzVThxcWhn?=
 =?utf-8?B?M0ZYMGU0RjVLN2VVQW1GWlZqUzVXTzFOR1dpNm9lNklZWThZUHdoVk1sS2pM?=
 =?utf-8?B?UEFYUzBjYlk2eFlJWTU0WTRFcDhTMlBpbXNWamg2LzdMUEVOUlBLQTg4WkFj?=
 =?utf-8?B?cHpxNUdFd1ZXZzZxRWROZ1Z1U3NsLytQUjVwRW9jODZ0UGlHM3ovMGZaZW9Z?=
 =?utf-8?B?QlhnWUVtYlNzVE1yRFZ6VVN0bGRNZVFVQStjTlJTbzhEZFJWZmRjc2wvaUJ0?=
 =?utf-8?B?Y3FENGRxYVFGS0Z0VC9adlZyZSt5cjNmdW5peU1HRERoWk1wNHBwUXl5ZXZZ?=
 =?utf-8?B?dFNvSUJGRVFST1pvQzJEUHlqaHcwc2tHdWxiNjlTQjNKWUVmb29xSVR1aSs5?=
 =?utf-8?B?R0pHQWhjRGlXWmxtVDljNENxODBTV0RVSDVHZFU5eGo1dU0xcE5FbGx1SVJB?=
 =?utf-8?B?ZmhQV0czWXUyd3ZQREtnZytjVHcwWExaMzNWRjRnUFlzNnZ5SlhaWGVqVFdU?=
 =?utf-8?B?eFRqVUFBWU5ZSFV0K0RVQ3hQSGxBU0pyaWpKTCsycW81dkdycC8ySERpNmtC?=
 =?utf-8?B?V2plQjEvNEVPY3daZUMxUVZQQ1IveVhzSkI0U1IwejVrKzZ3ZzhOUjlaV2g5?=
 =?utf-8?B?SW01YjZHc2JvQVBIMWs1bWc4MVYvMlpQakxkY3M1K2JNYjlqRjNuZFBPZXBO?=
 =?utf-8?B?MWlMeml4NitxRjFNL1Z0aXUwb25rejNpaDJ5akR5WSs5cW1LSlNaRHEvRDl2?=
 =?utf-8?B?NXc3QzRRWE1YNkJFcXQzaWtOODFJRlVHNlpxWnluOHpPZ2wvbGRQNG1TUHhW?=
 =?utf-8?B?cDl5T21INGxvTTh6VlA0MFpUWGRROHNxK1Q1dTBCWG5RaCtuTHVrWEVTM1lG?=
 =?utf-8?B?aFkzdS8vK3JWcG1RWjNBQy8vSFRtZUlZYXlkR2RhbHZFZG9GZENHM1dZdWVz?=
 =?utf-8?B?WGh1VGR1YlJXdVY1cEVVSnk0WTkvL0JVVzFNRWNZdVZyT2xWN1hkd0lXTkhQ?=
 =?utf-8?B?QndJZGxNd1VyZ3JXbVRXOUt6bVNTNzZwbVpUbUl5MjJRS3RZdldkQkJ0MktO?=
 =?utf-8?B?QWx5ZGtVTU9laGJtTDNXOXJieWQzOGpEbE5vb3FKYzZ1QnNBR3RmbW40cTFi?=
 =?utf-8?B?aTlVTVlGU2hNekt3aFNzM245RHIxazVmdnE5ai9WNlVzNmhyM1AvSHMvd05S?=
 =?utf-8?B?aHMwLy8rMktIT1pIWWlhZGZnaXc4OFcyQnRWTytWQWtJR3RhZmRvOE1rT09E?=
 =?utf-8?B?YlZZcUI0aGdkUEFaaDhFUnZtWEtGTC9nOXI5U3phd0wwNS8vMDhkNHJIaTF1?=
 =?utf-8?B?ZTRSSmdoK3phK21PYU5TRHkxUzFqMTBOSGJVbDlEZ1VDbFkySXExaVJZTTYz?=
 =?utf-8?B?L0grSURheWdyR2xHand2RG1QMUQzZmJUdmVpRnFMKzloVTJONkpvWDZaVFp0?=
 =?utf-8?B?bVpOWXFvSG9tdEp0cDdCVmNkRU1FcFExcVVaZ2FZSHQ5RmtMWkt2TEpHcHhI?=
 =?utf-8?B?WUVOQXNyRStycVJ2MlcyOFNoRTNZdlhRT290dXNKc0xVTTdCUXVoYThUc0VM?=
 =?utf-8?B?TERmNW1zT3A5NU95STVhTFBLOEF3bk9rMGUxdlJlbzBPTStUZE1VRG1TTTJW?=
 =?utf-8?B?Y25YTVd3M0Vhd2N5d3hrMzZNdXQ5QUxVZmk2R3dHdjc2ZHcrLzBaMHZNKzFN?=
 =?utf-8?B?aVBEUUF0UGllOWdKb2tFTnVMK2hwaXFBcGFIaFRaakhoeHZER0c4OCtBbFFw?=
 =?utf-8?B?ZGNjWVVxVitQZ3RKYnV6cGtoc2pOTnR2RmhFVDZjd1llWU9uOFNsS2VWK05X?=
 =?utf-8?B?QWh2d2JKSkMyVWk2S1Fkc0ZWMkx3QzNiVTh2Y2xlWGJaTWh1TnNBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d658576-165e-4f17-ddd7-08de6a50a4d6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 16:06:13.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qFUPQ9Tv5xg86ixL1tbPapxwD+xSLGbJiWNZD5cmFSShcG62bnKP4aXJi7gPU7psCRSko+myiKBmHNgP+WEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3198
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8792-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,siemens.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.microsoft.com,anirudhrb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:mid,siemens.com:dkim,siemens.com:email]
X-Rspamd-Queue-Id: 4BB9C12F3AB
X-Rspamd-Action: no action

On 09.02.26 19:25, Michael Kelley wrote:
> From: Florian Bezdeka <florian.bezdeka@siemens.com> Sent: Monday, February 9, 2026 2:35 AM
>>
>> On Sat, 2026-02-07 at 01:30 +0000, Michael Kelley wrote:
>>
>> [snip]
>>>
>>> I've run your suggested experiment on an arm64 VM in the Azure cloud. My
>>> kernel was linux-next 20260128. I set CONFIG_PREEMPT_RT=y and
>>> CONFIG_PROVE_LOCKING=y, but did not add either of your two patches
>>> (neither the storvsc driver patch nor the x86 VMBus interrupt handling patch).
>>> The VM comes up and runs, but with this warning during boot:
>>>
>>> [    3.075604] hv_utils: Registering HyperV Utility Driver
>>> [    3.075636] hv_vmbus: registering driver hv_utils
>>> [    3.085920] =============================
>>> [    3.088128] hv_vmbus: registering driver hv_netvsc
>>> [    3.091180] [ BUG: Invalid wait context ]
>>> [    3.093544] 6.19.0-rc7-next-20260128+ #3 Tainted: G            E
>>> [    3.097582] -----------------------------
>>> [    3.099899] systemd-udevd/284 is trying to lock:
>>> [    3.102568] ffff000100e24490 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
>>> [    3.108208] other info that might help us debug this:
>>> [    3.111454] context-{2:2}
>>> [    3.112987] 1 lock held by systemd-udevd/284:
>>> [    3.115626]  #0: ffffd5cfc20bcc80 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0xcc/0x3b8 [hv_vmbus]
>>> [    3.121224] stack backtrace:
>>> [    3.122897] CPU: 0 UID: 0 PID: 284 Comm: systemd-udevd Tainted: G            E  6.19.0-rc7-next-20260128+ #3 PREEMPT_RT
>>> [    3.129631] Tainted: [E]=UNSIGNED_MODULE
>>> [    3.131946] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 06/10/2025
>>> [    3.138553] Call trace:
>>> [    3.140015]  show_stack+0x20/0x38 (C)
>>> [    3.142137]  dump_stack_lvl+0x9c/0x158
>>> [    3.144340]  dump_stack+0x18/0x28
>>> [    3.146290]  __lock_acquire+0x488/0x1e20
>>> [    3.148569]  lock_acquire+0x11c/0x388
>>> [    3.150703]  rt_spin_lock+0x54/0x230
>>> [    3.152785]  vmbus_chan_sched+0x128/0x3b8 [hv_vmbus]
>>> [    3.155611]  vmbus_isr+0x34/0x80 [hv_vmbus]
>>> [    3.158093]  vmbus_percpu_isr+0x18/0x30 [hv_vmbus]
>>> [    3.160848]  handle_percpu_devid_irq+0xdc/0x348
>>> [    3.163495]  handle_irq_desc+0x48/0x68
>>> [    3.165851]  generic_handle_domain_irq+0x20/0x38
>>> [    3.168664]  gic_handle_irq+0x1dc/0x430
>>> [    3.170868]  call_on_irq_stack+0x30/0x70
>>> [    3.173161]  do_interrupt_handler+0x88/0xa0
>>> [    3.175724]  el1_interrupt+0x4c/0xb0
>>> [    3.177855]  el1h_64_irq_handler+0x18/0x28
>>> [    3.180332]  el1h_64_irq+0x84/0x88
>>> [    3.182378]  _raw_spin_unlock_irqrestore+0x4c/0xb0 (P)
>>> [    3.185493]  rt_mutex_slowunlock+0x404/0x440
>>> [    3.187951]  rt_spin_unlock+0xb8/0x178
>>> [    3.190394]  kmem_cache_alloc_noprof+0xf0/0x4f8
>>> [    3.193100]  alloc_empty_file+0x64/0x148
>>> [    3.195461]  path_openat+0x58/0xaa0
>>> [    3.197658]  do_file_open+0xa0/0x140
>>> [    3.199752]  do_sys_openat2+0x190/0x278
>>> [    3.202124]  do_sys_open+0x60/0xb8
>>> [    3.204047]  __arm64_sys_openat+0x2c/0x48
>>> [    3.206433]  invoke_syscall+0x6c/0xf8
>>> [    3.208519]  el0_svc_common.constprop.0+0x48/0xf0
>>> [    3.211050]  do_el0_svc+0x24/0x38
>>> [    3.212990]  el0_svc+0x164/0x3c8
>>> [    3.214842]  el0t_64_sync_handler+0xd0/0xe8
>>> [    3.217251]  el0t_64_sync+0x1b0/0x1b8
>>> [    3.219450] hv_utils: Heartbeat IC version 3.0
>>> [    3.219471] hv_utils: Shutdown IC version 3.2
>>> [    3.219844] hv_utils: TimeSync IC version 4.0
>>
>> That matches with my expectation that the same problem exists on arm64.
>> The patch from Jan addresses that issue for x86 (only, so far) as we do
>> not have a working test environment for arm64 yet.
> 
> OK. I had understood Jan's earlier comments to mean that the VMBus
> interrupt problem was implicitly solved on arm64 because of VMBus using
> a standard Linux IRQ on arm64. But evidently that's not the case. So my
> earlier comment stands: The code changes should go into the architecture
> independent portion of the VMBus driver, and not under arch/x86. I
> can probably work with you to test on arm64 if need be.
> 

I can move the code, sure, but I still haven't understood what
invalidates my assumptions (beside what you observed). vmbus_drv calls
request_percpu_irq, and that is - as far as I can see - not injecting
IRQF_NO_THREAD. Any explanations welcome.

Reproduction is still not possible for me. I was playing a bit with qemu
in the hope to make it provide its minimal vmbus support (for
ballooning), but that was not yet successful on arm64.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

