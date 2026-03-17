Return-Path: <linux-hyperv+bounces-9483-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC6TOUwIuWm+nQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9483-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 08:52:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8F2A5207
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 08:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F83E304BCC0
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF723932F0;
	Tue, 17 Mar 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BANjzG55"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18816391854;
	Tue, 17 Mar 2026 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733789; cv=fail; b=iWjLuC+maxTwK+XzUqraZfPVnNV4DvISd/GRWP7f5ZiGhV5kDesyxLLX6fk7Rl5QW7BDy+nv8yjrX6Lhyvw5mi8gcxSfUBbjwdpXFvLAR4gf9f8giF+VOKJfNWkgXMNHLyrl6kRF6g6qaa8Y7eEegB5vvB3Iyn79FRhjMxfp3Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733789; c=relaxed/simple;
	bh=sY5CdqMFH0H9qFlLqFK3zHmpi6Zj1t52WHpeAkKuMYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nd5HH96bJtEAYrqa+/ntzK3ZMMbJydJxM+oaXtQMqnszCu97M5N8Ov1PFI9gmYgl6UDHgNdTkp3blwbxa1Bm9rJESdp1UyG/u9awtwqsndowgO/8bwTv+4cQXPJ2AMmByYYFzke9tAdsqyyCmGaSLNh9MTmL37Lr1wRWsGdcS7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BANjzG55; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3Y3fWCsEBQTvyB64V4dYQmVFmEzyygr7nWtzAVGapUucspdn2FrY0dvhSuInrWtmeYvfmquvlRvzMHHnc3IGTWsH4PRJ1wEOACdsAAYe0npQLRgIPBOwpf8bLsMz3ZrlO64NxfpBbXUbJNCWvozjQonYyTzjOI/Hif/j97gVMt5NfTaq1ZqKrTS2N/NPU5FMQLFXGWOgaz21O/CCRAkQHuHzEzJO+TXhJHVJwEXxBZLPFZvJ1yrpeeP0Kj6EBHzAJA1x9vGKt6YY53ByW3ByKJz5e/RhxyHgR0vN09pwWsoAA//TOZiZkz9Bu2j/rneIvhzlFPjzlbedXSyjUwhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY/rggEovDG0jQgrovOUyO1jToZXebi88B/mDSUn1Vo=;
 b=yUKey69VLoI5HuBkKhOo9pOJTlehqxdoAz5xxwxN5jTdvTVff6D3cAfX13J13Tos7O3Qck456XjJiZL1xPUaJ7yM6dpRdfxxz8TkZB/cExf9mABGfjBsckvWA1n9aZvCvhyI2j2Dm958QQZ1OJxbaXLZZ9SHB2RpKGzrpppn4fH7JqWbL01LqYR3X7J1Rt+cn8ET06C0HpRw6FPCe4ro8KtTNPyHVXJZLWkBeHeeOTeyjxET+qGrSB6Mtr57lry4fj30nY6mpYrItGLvZ3/23F22GkS3Qa12sUVYcpkIwaXIzWOzSdaxWZoSE1S9J18PgqtMdn8x6DYD+hbNCMWb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY/rggEovDG0jQgrovOUyO1jToZXebi88B/mDSUn1Vo=;
 b=BANjzG55MJYFRvCiaKOyOR7KR4CqGhOir3qO0mu/tqQbgnOCYDlRQAbGxxHG2RgEb56s18I6MIP4ibzYtTLN92bfYr6KdxsD6c9muoR1/d6C73Eg3NN2jPTlUlBjkb2ELXj7ASRXZp6rLKmH6MqHz2liEjTVmgcsesK9orZ4C4LBWpf4v8OEbZ8p+ZZOwp4NErAFQEaWrsAYD4nvTp4rjT8vskxLoxGOEFaeJlfhKTlNQOM8tLGsvrZamF6a3Y8K3fPiqJ4Ryq50gTLkz+UdZfNWPx0O2QWO6o7Yt1cHvKQ6v2C9x0OTyQxwGs56b/EIajnNsatplQHHwSnk4+OfrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 07:49:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 07:49:40 +0000
Message-ID: <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>
Date: Tue, 17 Mar 2026 08:49:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260312170715.HA08BHiO@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a07a3f-0e8e-49b7-1280-08de83f9be8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oDMhgURNVOO2/Vpl8AvNU4MwgwnMt/ctYBfG3LbxwRkrAoiRVmoHa3EIwTmBGQnD/Hlj/rqUD2YPUiA6hZUe3rvzeM1MZVYi210GUyRx43VcSYiWnXoFzbN+PjBw8HynGlKsGz1wAmApLQ38plygD26BwnzKdC5GZfFAVmLPYsVStUcbqEO67hYx8wLGQo9DdchKbH/kVdHKbGexOhdRkHWNGvxgNxsCeJAZjp7yfQLqmn2Y1Y6vbtmfp0rv6Vg3eG3N8VcR+apptT+UmjAuSueCDPsboZgRepXwGVoRG7W4MK2nMf4k7KLDU4zdFISKgWffNBIw+4lFhYMaNAVxR0OeaLCHUpUJM3bg4HRbhSB8PEf1Pf2FP6FFJmOR00F3meg3i8nVnCsuF83OUwzLqRT4FQtbFl2IIP0HQ0Ya2wrgPfwyL5F2wa+kSDWSetzrBXmmCBJ3Az+1Cj19S95YRjKcw2uUdoR1+Ju643ByfyZB/mjT+iDvzm+XCt15ArqigQrOfu5Zjl+pK0J2kl2cFd/djxjXk4bnmFyyrH9R3ErAbwq5A74FzGRe1iSXLWV3Hjk4Uc2SfuoefMvamCIhLLTHTCZVWAphPoXv4MczQY7UO9gJOqy4HFCou/6u0ZATrgN2n4KoWl35Q3/zitWJPvSm35K+trmK7GwlHOCvw3F+uAzj4Om64wwiiI2QFTa2l0PA7jPU5ybBc72JL1OhJU/tKy6eOlg1AP4OErlDUzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE9ZcHViRnc5SFVuYzFnQm9yYTdtY0FRYVRQZ1Ridm5SM1oyMVBBUVZRT3Yz?=
 =?utf-8?B?M0FqaWNMdG1iRnI3OG01OTg3V05JZTJUdzN6Q0xlb2hNUFdhTDZaUm5PZmVl?=
 =?utf-8?B?eTQrRnRsT3FneDE0c1Jkam5aRTUwZlJxVWlHV0ZnRElrZjlaN3FQc3NwaXZ4?=
 =?utf-8?B?WHJCVWVuQkpuZUc0RzJtR0pxZ3RDOTR3aFgraHlLY1kva3VqQlpwSkoxdWlV?=
 =?utf-8?B?SVgwK2YxZXM3cWxGZnp5dnhWMWJIZjM0VEpKK0JNWGJUbHp5VDkrN1VPSjFn?=
 =?utf-8?B?b0VXN0JlSmVyK09BNEpzeWRNeGZseTV1Q0s5YWRTME93SU5MQ3VKK0JQdEd2?=
 =?utf-8?B?QlNOUmNaUGNLV2E5U3JQTWVWUndxcFc3OHFGbnAvUWozTXYwTnM2T1RLUUNl?=
 =?utf-8?B?T0RJN0NxV1R1VGhCdElIZnJ1VGtYTWRjZjVNN2NIS3V3YmlpT2xrSE1GQ1Nn?=
 =?utf-8?B?cm9nY3lnRFh3VGFtQUx4YTFGckJGVXBCMXR1aDc2bzJBa0ZXWTg0RkkrcXlo?=
 =?utf-8?B?dDF3K2JWT2haN05tTHc4VitGRVp4QklwR0hWWjNSSFZoOCtYTUZUc3hvdTky?=
 =?utf-8?B?Q2hmSmpKNk1FdEordS9kbGR0d2JXY3Vua213dVg2aFAwOXJ6bDJrLzljQ29Q?=
 =?utf-8?B?MWMvOVEyZHdnN0RvOXJScVZmcGswbjlFYVk2THpzQWlVbkJ3K1BscXlWSmsz?=
 =?utf-8?B?blNONStHVVVWOFBDWndlSmFORXZRZ2YvL1NVeFFXNFd3aUVzbVpRVDBXNlVi?=
 =?utf-8?B?RE5VMVcxVnVYb0dLcS8yYzBKbTZKaDJJMW1UU0VZM1R6S0V6MTc3RUZ0bUZm?=
 =?utf-8?B?SmcyTnowNzJUaE4xMlk4dkU4d2gvVjVFVi9FVjlJd3ZPaVVLcGF4cVVHaWdj?=
 =?utf-8?B?ZTV6WCtESzBBcHBUY3VMdkJMS0R4L1Y2K1pSQzJCb2h0ZEgyLy91UW9pSjdm?=
 =?utf-8?B?R0hwUTc1TVgrWVdmbDA1OXBOakZia2RiZDBvQURvSXJneGZDMjVyK3ZwalFF?=
 =?utf-8?B?WXFad0IrZUVWUmxzSHN2K0RaMm1yY2REVnVQQmI4NlFZejJsZStYUzY5Qm84?=
 =?utf-8?B?UXR5NFBkT2ZPYlJQc0pwN2lzNEdtU2c1Z2pTNWxESTNFNDkveHRQN1Y2cXBM?=
 =?utf-8?B?Nkh2WlBXOVVESFRES3RTTTJZVGd2K2wxdlRNbUhjOFZ2ZXAzV1JaaURiMXgz?=
 =?utf-8?B?RVJhb0JNUnYwRndFZ2VXbnlBYlFPZGZ0Q28xMDlLTmxzNEtoNGFaVmJVYUVT?=
 =?utf-8?B?aGlmTUJEcmlyZGxOTkFlSy8vSmVkWm4ydUlxRGtrR2VZTGNNczU4b2tQQnd6?=
 =?utf-8?B?M1NtaVhEL3VaRFFRVlduZVFDNFR0RUM3TXhaTUNuSmQrWlpNWjRQdlNtbUdt?=
 =?utf-8?B?ekR2NFBpRjE5VXFJZmtLTkt4cGc5RFQ5OTBrMFRoK1ljY1hSNS8rMkQ2OTE2?=
 =?utf-8?B?TlJDUWhCcjQ1bEU0Q21Qa2FYY2toeUJlK2J1TUJNUHhwNWhmbmVraHEvTlRO?=
 =?utf-8?B?cUJUdHZiK3FuNkxYdENTbWNBYS9OMmZTTmcrVUljS0txTHFKTnA1MHhtVXp2?=
 =?utf-8?B?ZEJWQmRzSGFOMEZ3bG11MEZNUHJwd0kvc3AxaUhGZ2xrcitYWHYrcmMyUEE5?=
 =?utf-8?B?ZS9wL3F0SnJlOWlrM2k1bUVpN3RmYmZGempCa2c3TnJLajl6UEc5U2dWVDJj?=
 =?utf-8?B?U1ZQYW9ia2lqYndjdzNpZ2czc3llaFJLajhhaC9ZZ25rZURRV2dIU01Kc2hk?=
 =?utf-8?B?NXo5RTdwRVdHMGdtQjdsSVNpekMzaHJrMGZ5Tkg0djRsRmhTT2R1R0dhMmhI?=
 =?utf-8?B?Y3hyUTVqYzg5U3A1dEtFSklVWUlXWHdwc1RVQ3FPR0RiR2JoUnkxekdQSTJQ?=
 =?utf-8?B?V3d1amNsK2M5QUdTVnFZRVo0dXJENEtoZDNwZExScjVycElmVnpBSTJPSitW?=
 =?utf-8?B?ZGxKYkhIZE5zWGZLZGtLTFllYVZxVlJmTEdpVURYaWRnV3pmV3VwVnVFMDVX?=
 =?utf-8?B?aGZxZzFpQnVDWjBBY0Q1MGZNdXRWQUdId3lzbWtJU1RHTnBzVHR6cHZEMnhn?=
 =?utf-8?B?WEpWZDlQNEtIdUVFalc3QXg4N1VHTDE3V2xtSE5jVkFCaFBBWTg0anZDanUv?=
 =?utf-8?B?SFJSck1HeElIQVZpS09hc3crTUhLaWdsUUNKQjF1R0pXbjBTc3c5bUZTN2Y0?=
 =?utf-8?B?bjhrVzZFTUQ4bTMwT1Q1eUVnNUtWODl5M0NmdFBlYU9JSTV2M3RRbStKK09s?=
 =?utf-8?B?R2IrbXkyZWNpVjAzMWQ4WkQxRHg2aUpySDZOUFpjdzdRSG1ubWF6WWZCWUF3?=
 =?utf-8?B?SVBDL2s2RU5oWCszQVFWaGVrMElBSkhjWmVRUmZZSnFtWTUwSkhMZz09?=
X-Exchange-RoutingPolicyChecked:
	uZM+H9BNzhvbhahh/iOrX6qdqsYFnZlsoT2eQYTzUJqO7UGpiRGxg0JcWKef0/vaUqzzACi8rYjxi8uYaFIKBuuYCsCMFqZ+samPf3/7XMz3Kldd49TKrj3R2GV7JsLzuc5jub0HVvn9o6FrwnZSwnhDjKyHlkDhwq+ueDEDWIW40rD6RU41PyljEL1slZP+5FMab+Aq4HSLQXM3lK0iEtQ2z8yvUcOr8mmpP0W9U3zCv7gQrSJtpJqbdCbvRKzg8Cb4OfUeCw0Xr+nX95bRgluTJ7vE3fdKG6oRCusfsHHxzk4l8G8bOOkkKX69ypQ8ibWJUZAknb0EILHCtIajsw==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a07a3f-0e8e-49b7-1280-08de83f9be8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:49:40.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDzp7Ut360HPnRTDwAaSMdOSxnld/tAFaLVGvD52lEIAx+yx6n3j2cOOSt0m9jkLdL9Dz6cEOxY7SPkYpmODpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4088
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-9483-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 79B8F2A5207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12.03.26 18:07, Sebastian Andrzej Siewior wrote:
> On 2026-02-16 17:24:56 [+0100], Jan Kiszka wrote:
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/cpu.h>
>>  #include <linux/sched/isolation.h>
>>  #include <linux/sched/task_stack.h>
>> +#include <linux/smpboot.h>
>>  
>>  #include <linux/delay.h>
>>  #include <linux/panic_notifier.h>
>> @@ -1350,7 +1351,7 @@ static void vmbus_message_sched(struct hv_per_cpu_context *hv_cpu, void *message
>>  	}
>>  }
>>  
>> -void vmbus_isr(void)
>> +static void __vmbus_isr(void)
>>  {
>>  	struct hv_per_cpu_context *hv_cpu
>>  		= this_cpu_ptr(hv_context.cpu_context);
>> @@ -1363,6 +1364,53 @@ void vmbus_isr(void)
>>  
>>  	add_interrupt_randomness(vmbus_interrupt);
> 
> This is feeding entropy and would like to see interrupt registers. But
> since this is invoked from a thread it won't.
> 

Good point, will move this to vmbus_isr.

>>  }
>> +
> …
>> +void vmbus_isr(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +		vmbus_irqd_wake();
>> +	} else {
>> +		lockdep_hardirq_threaded();
> 
> What clears this? This is wrongly placed. This should go to
> sysvec_hyperv_callback() instead with its matching canceling part. The
> add_interrupt_randomness() should also be there and not here.
> sysvec_hyperv_stimer0() managed to do so.

First of all, we need to keep all this in generic code to avoid missing
arm64.

But the question about lockdep_hardirq_threaded() is valid - and that
not only for this new code: I tried hard to understand from the code how
hardirq_threaded is managed, but I simply couldn't find the spot where
it is reset after lockdep_hardirq_threaded() but before returning from
the interrupt to the task that now has hardirq_threaded=1. I failed, and
so I started a debugger. That confirms for the existing code path
(__handle_irq_event_percpu) that we are indeed returning to the
interrupted task with hardirq_threaded set. I'm not sure if that is
intended that only the next irq_enter_rcu->lockdep_hardirq_enter of the
next IRQ over this same task will reset the flag again.

With that in mind, the new logic here is no different from the one the
kernel used before. If both are not doing what they should, we likely
want to add a generic reset of hardirq_threaded to the IRQ exit path(s).

> 
> Different question: What guarantees that there won't be another
> interrupt before this one is done? The handshake appears to be
> deprecated. The interrupt itself returns ACKing (or not) but the actual
> handler is delayed to this thread. Depending on the userland it could
> take some time and I don't know how impatient the host is.
> 

Good question. I guess people familiar with the hv interface need to
comment on that.

>> +		__vmbus_isr();
> Moving on. This (trying very hard here) even schedules tasklets. Why?
> You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
> You don't want that.
> 

You are referring to the re-existing logic now, aren't you?

> Couldn't the whole logic be integrated into the IRQ code? Then we could
> have mask/ unmask if supported/ provided and threaded interrupts. Then
> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
> instead apic_eoi() + schedule_delayed_work(). 
> 

Again, you are thinking x86-only. We need a portable solution.

>> +	}
>> +}
>>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
>>  
>>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> 
> Sebastian

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

