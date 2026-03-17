Return-Path: <linux-hyperv+bounces-9495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SErdOi9ZuWnYAgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9495-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 14:37:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA582AAFF0
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 14:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C03323052E4B
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 13:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9690283FFB;
	Tue, 17 Mar 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F7tjipjz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92722820A4;
	Tue, 17 Mar 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754475; cv=fail; b=ufjbt8ELd00l+BIsC35o11D7lk8ECptaYaecANBA4UEUP/jac5oYG2xfaNUJ8G1NV7bs+fMsSgNq4xwG85fvrI5GExiZiZo+5xPx9mWA1cJ60taFHB2lDVMsq2Ta/ZXC85iubY6nTUFf/hOhbFEA5THegq195RIYLDlKo9KDyUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754475; c=relaxed/simple;
	bh=/q678mM44JpUdxXYBo/Ae5tIURJJUEGigua+/4LkQRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xf7eiluGlxmYn6hV49072Co533ANga6OfQNM1bT+Req4+dwEqN2IcH7j+uCchLliSdDTqT0dLAuXMd45h75/YFQoKGbxuQHA5rN6ZO6sghIBMjq6tkgHg8zRhs8WgH4fdJsQniqnDGPD25HoropJBYFpVZSrYMOsczPXj0ppi1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F7tjipjz; arc=fail smtp.client-ip=52.101.69.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+9c4AeQAUj0ZaVl1ICW9TVk4YBmpnEgvPXcMTi78QQqnSwwQaO4vOev/k2YGL4USfIE11H4kvJa/Go1gE0rufZCNa5UZXcCpECAyImZQY4F+qvnDr48+sW08CCufU6ra4Pkn2uMq66dVwgCDEendRNIp3KxCTzpBwBwNpk8zqps+lZCR1JXPiZIT73iOaz78+ca3qSJDgB0nLN4X8a4CiAIhyNmPnixftt+iQgebLXPGP++fxC53rOyh8vCpjVwP2ERPdofTyvbadTWBeRsvkR1HKU+SLCDyWu3hV6ZkJ9cCSeKLU850b8KCPflYX5aabdYF4CfS6pL1oq8CJnjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuHJz8S8Gmfh7cbAvRJdbYaBgnqOa85jgrozlI6QSck=;
 b=xehH1f8YgCpyOL8XxP58/chL9M6y/TqIb4LgPoM65Vp9LsAPDoh2eJYVP/T/fL1qGFT1OttWQEt9u+SbHZlWeb4renI/wJ6XHMP1TXqoKBA+3fOrOf5Ycc8zFvUsWonBNhFtG1akNgYXt4+0Yf4+g6VekHZBmwF4I1AzOCTnRUGgGIEwbZw7hU0jsYDZE6MY9viSpG0eZtoI2ji90q4S/a3WwHl5CbEedoGbHLB8oWDijIb7sIyfRs0JdHz1vg4VYvB9AeNFgGYWbnyMzzg8NZ3+cR/cub1N/v6jsoo+tu4LzCsRvJvfmUz5FAnhs8T7VdltzIDu8b4RsIWgS3x2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuHJz8S8Gmfh7cbAvRJdbYaBgnqOa85jgrozlI6QSck=;
 b=F7tjipjzGuOrI7//gOmsNG1OdliuO01qFiT9CaNa1xqDXa/SGrykqCVelqRBZz5HmO4hudFEeHwNxbCkKmsczcZXlU2pFFokCHsuaJ9VxxXy/CRDSvqCMu5d6rQePQl9Ph0Z+nU90qGQVvVdDEVOTN61sU9m+zOCWctAHI5SCjNPpzlWV8hgnIaJudX6N5v+uQfwkI1+P7hPFrH11YnEvpUy+0ZCjMw7yhuwnOb4d/cHVMz7C+AOvkthLnQ9eqAXmYTcHhhSWy2vkg96IYJlZA0ky0V48s/F6OSSLTkcEP/cMnpB61sgocRXinJuaBnK7N3jU36cRljSsO/sPvXUyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Tue, 17 Mar
 2026 13:34:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 13:34:29 +0000
Message-ID: <5262eafa-7f94-41c8-85d7-a2b8d7f27c5a@siemens.com>
Date: Tue, 17 Mar 2026 14:34:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Move add_interrupt_randomness back to
 real interrupt
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <1b53653a-98a5-402a-a224-996b26edaa97@siemens.com>
 <20260317110535.Smn9viQ7@linutronix.de>
 <f718a22c-bbf2-4206-ba7d-391243c84f60@siemens.com>
 <20260317132252.AJlwEyMh@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260317132252.AJlwEyMh@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9799:EE_
X-MS-Office365-Filtering-Correlation-Id: e5885c16-20af-4241-5b3f-08de8429ea3b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	oWVZnhtUx5yHM0h2I8AXkdXwRxgHtLYRZ7wy2NJjWTHoxuNP238UPexRZqAxq5H1mmHDykC1JSX77qP+d4EGb5nYTaDEgmImMU7PYvcEq3nTiFddb4YkDq/FI1ONv3kC+ChFtLai52XB3xMlG/vhY0RbpsXb00qpYKtPf2FoSyzfQS1+QngtDwg6CJkvqoCKIhLFn3kuaQg0JkuRdzaCTHYBuLDWDcuhQ/BQULABrhS2cRSmKqRv0ENDfH0SnBlYQLxbO/RrhB3qwG8vjw+2zO/xDN6FR8O2YJIctHYjboupEWN2ou7MmUAVVOQA/XxFnECdaqzhqHrximsEJPy56srQiIzs4J5cq43PaJj2WC0migD1wCmGImUfU3DwcgIYyUqu1/G3TLAwE5erhRAPbe5rApOkkjqtXt6EGT6/f03ovyAaCXcU7f/AwAETQKDj7DtJWj2JodW53FJRn6UMfoJ7ibZdpq3itbXIDPX5E0cnXGU6cMaty+Ud7HdSLcBwKQP5LhvD1FonUAqDlI6WhyDglF3a56aPtqX+F1Uu1/SVVy7B55MA1i6b3zMqBOgZhQsfG6TCyUwbkyLvHDeLSIyvXTJjqpuiNsJyaAVg5c1ElZhpeRITn/oyKN9JFXCAXJKPxxKiY424NHf7Ln3kfRdO1amDf0sqXa16uEqoARpTW4xQA7TPB5IThOdkHXIVW8b8ChT19lwttg+jPMCE7rFN+ZUxdSFSilzspZMHVp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZRVlhveTNCaTIzZ3dHMVprekg3RGxyVnNkOXRxekhkbmZxcWdIS0E4b055?=
 =?utf-8?B?RkQwV09Cb2FQVW9Vd2R0VHRtUUliVVFzclluR3ByMnZOM2U4am5yL1o1RzNz?=
 =?utf-8?B?RGNWSy8rZE9zVE1FSmJ0VVYxTWFCK3FQNFlOWjdpRWt6OSt2THdsMjNvNEpE?=
 =?utf-8?B?ZEFRcWJSVGtqbzlUcU5OR3V6dURTRUJGRHlPUDIydGpqMlorY2pFSExRbTVV?=
 =?utf-8?B?YjV3WGlvaHB2VENXTm5hdXZDZVB6Qm1TNDBUeUNIUnFXbGJ4cmhGRnhjVW1V?=
 =?utf-8?B?WjBDNXhRaE12eXc2MmduK3pWaFZmeVh3R2gzMi9MNmlXVVl4bHRLY0kyNmlB?=
 =?utf-8?B?TlRlR0tEQmZscmRncUUzZHNaeTNYWTdzMkpqUUljK2hRUVlObjQvOEdobG5X?=
 =?utf-8?B?YVpYQU5zUjY4STNOakRHaVNYVHRmSkhqK25LYkRUVnQxbHBkT0UwQkQ3MnNm?=
 =?utf-8?B?U0dGUVpyQjhTbDlXbExtTU9FVEZsZzg2Q1k2MGZZc0VaNzRxWE84RHBSamZu?=
 =?utf-8?B?QkxSS0VLL0JBZTVEU1ZrbE9uTzhQUFlmaUpmYmRET3FmMHpJSzJvWTBQOHFD?=
 =?utf-8?B?cGgzY2orRndVUDRKQ2NkQjhoWkh6MU44cHVSQmVobVZaK1hUQS9rZ0NmVjY2?=
 =?utf-8?B?OXJWM0ZIdW5rWVNtVUFoRWIzNUl4RVJxNUY4M0dDUEwzVG8zaDFDWUFxUU16?=
 =?utf-8?B?bE9DMytZYmw2OTJLUWoyWjFlMmJOZEo1MVNoczZCYUd0VzhIOS9jajVnWGp4?=
 =?utf-8?B?ZmFhUHB1RldscSsxRFh4anFaNWRzdlliRTYrSDh0KzVkRjRUZ0wyY1RHQ0l4?=
 =?utf-8?B?aGl1UzZVVDllMHVIMG1LdFdCZDhaMHJRYVptYnBzb1hvQTQ2MlhkaUJRTlk0?=
 =?utf-8?B?Zk9mZ1NtQ29hR1QvYnNqcDlOZ0d1OU1ySUw4cWNEdDF2Yk9zZVRuYkViZXds?=
 =?utf-8?B?SzIvb283dDRabTFvZWtMRU9VcFlDV2d0aWZJeWQ1ZjdZTXhaaEc5WjNmVXhq?=
 =?utf-8?B?RWcvRUpnZlF6c0ZKZ0pidWx6VXR6em1KTmc1SFVwcDhuUktpY0xzOTB1d2h5?=
 =?utf-8?B?clEyYVpGR0QvZGNZNXF1MGpvRG85eWsxOHVYeDY3dnRxcW1RSU9zMGhVS2JO?=
 =?utf-8?B?V1c4Q3JMWTJiTmQzM09YVEFsTWdQajl6VVJSRlVVY0RPelFCYkZXZW1pbDFo?=
 =?utf-8?B?UG9uczhjOUNEeUl1Slpmd1BPckY0TlpJRFVkcXNha3l5TndIc0Jtd3NCR2JE?=
 =?utf-8?B?VkJXYldaQUFIb1dqYXJTSlBhMUNNUUJjRTAxMndyN1g0ZWJUdHhISmFHRjBL?=
 =?utf-8?B?UTk2ZmEvYVR5WmVoVmlzYWcyNE41T0tDTy9EMzlGZkI2TzR5OGxxV0lQaS9F?=
 =?utf-8?B?azJJUTh1OW1lYWYyTjAvdXVJcDF1R2UzSHY1MVBqN2tYOVlaTk9hNDRhUkYz?=
 =?utf-8?B?dmxEa2JyRmtGYXFpamJyWmQxMHFjQlYyTFNyT3Jic2trK1hxMGh1Yzh0RzMy?=
 =?utf-8?B?NmJkRlJrWEtNbTlOcy9KZ00vWlIreGVDNzhWY05zZWc0WC9jcDkzSUp4MWVZ?=
 =?utf-8?B?NUhPOUxOSFpsVjUrL2tYWEZKbDRBOSswV2NLcXJuYWVPMEZwWEJIbEUyT1pL?=
 =?utf-8?B?UHA3N3R6N2ppVEs2cXpUTnhsZm9WQmpwOFJ0ZWRQQWxzYVFaVEtkRXVqWTZR?=
 =?utf-8?B?ZDNOaUVwRE84RTNReGxTUG9KN1hnWXhVdXM0SFVkeWNrUWc1TDVtNVZ4ZUF6?=
 =?utf-8?B?c3JtVWJMN051U1h3OEgvRndieHRDYk9KR2lKVXdxQ0ZzanpFeFM0UGJDTmpX?=
 =?utf-8?B?UmJQME5IcTFhWjVCYlQ5d1psV2QxS0pkMzhXSGNtTGpDV2NRVzlldkl2ZHph?=
 =?utf-8?B?d1FuZnFuQ3E0UENUeWZCMTF3WW5Ba1VGcmFpZTNSZ0VzTnUwWHdheFhmRUpJ?=
 =?utf-8?B?MHQyT2o0NXpTUVNZbTk1ZTR6L24rME4rQmlLUzNjOWJLWG5RSm16aW1CUGlz?=
 =?utf-8?B?Ui9OL3B2NWVSd3pnVGNETVJMSlh3MW5KQ2dsS1NXMlFseWJaZG9Cc2hGbXpH?=
 =?utf-8?B?YUhWdDNGU1Z3YzJnbHZNbDRRMFAwaFpVTDRtSWM4L05PU0ZreHFpVFlTdzVm?=
 =?utf-8?B?Qzc5SVREbitRb1JsL2lDTHM1YS9mR2M5WUxaL1QyQkRWSFdaS2pOYkorUkRs?=
 =?utf-8?B?bUlLZWtiY1c2NjVoYXVySkZ4MDhTUjRmUnNhUk1NWjlQVjRJRDc2TTRqaitC?=
 =?utf-8?B?UHVuOHIyUlJHbnpSNTNYUktRT3NtV1VERWI2UnNjTnBTOExNeldib2pXZGtk?=
 =?utf-8?B?RlVIenhFeTlWOHV0TFR1VVF4clRzY0xaeWxQQVZrTWIzNnU5aFYwdz09?=
X-Exchange-RoutingPolicyChecked:
	SUolVVKcxpOPeXLAfYFcl/VLfikQNtzIEfZ6DgwsXX2t2DfFcFijCVom4bsHFf29/3Q4ZkWyaaaBNeyySeeNbxa+wjmDFnW26ztCijRrhSXRoxu9Q9yr9/Iv6V7d5IvjHyvM4Lp7ubxnlkKopKHO//36i8YY+1C6iJ7qyLna8lydAXSaoTGKkAE6noLd6mipTSyp4+aDOc/r5n6OQ9xNrYxOPQ1ikfxFwy35BptthLlrCcZidyXb7w5QUN4kVkTJRTPq84+EcSIC/izScJdNJZS4D5iGDI59TeNaqJeLOc7uKt/NoAIXBbGeR1Ug1U7ZGSldsoakMkf7G5vaaf9BlA==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5885c16-20af-4241-5b3f-08de8429ea3b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:34:29.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fF9wjkTgxjhMx/rLmIt3tFPMrNtHMhuAtRotLPJooEL2Fn/DjfSdDMTnYEKlV+ZuC+E3Jji0GKZ3+RgI0+f9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9799
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9495-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 8CA582AAFF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17.03.26 14:22, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 12:56:02 [+0100], Jan Kiszka wrote:
>>>> @@ -1410,6 +1408,8 @@ void vmbus_isr(void)
>>>>  		lockdep_hardirq_threaded();
>>>>  		__vmbus_isr();
>>>>  	}
>>>> +
>>>> +	add_interrupt_randomness(vmbus_interrupt);
>>>>  }
>>>>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
>>>
>>> Why not sysvec_hyperv_callback()?
>>
>> Because we do not want to be x86-only.
> 
> Who is other one and does it have its add_interrupt_randomness() there
> already?

It's the arm64 path of the hv support. Regarding the vmbus IRQ, it seems
to be fully handled here, without an equivalent of
arch/x86/kernel/cpu/mshyperv.c.

> This is a driver, this does not belong here.

Don't argue with me, I didn't put it here in the beginning. Maybe
Michael can shed more light on this (and sorry for having forgotten to
CC you on this patch).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

