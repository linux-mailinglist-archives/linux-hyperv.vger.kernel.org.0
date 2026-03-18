Return-Path: <linux-hyperv+bounces-9521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIdYHZqJumnSXgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9521-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 12:16:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D152BAA83
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 12:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9AB3202974
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3953A63F9;
	Wed, 18 Mar 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IKH4UzUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F03A3E80;
	Wed, 18 Mar 2026 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831798; cv=fail; b=d40YMetIv+HRg+k8MC0q1rzrea38R9u8itukpx2es2NLGtdC4nFEvjNGHEFEl80e5SHjDZHp5tP5xEQ08yFr97ayZgPtPJanUQ7k63n8o0sP0KQ3PNf5mJ1Quur4jNRTp4fB14VwEBz1SVC4Ebh/9/OtLWQlG6KNTwFA71ghRtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831798; c=relaxed/simple;
	bh=z0+Vy2WDwMGysNasm7SO/uF/fEcwwYZMjAPMcA33mg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUIKgw6BlLI0cib3Klkp5I4Alnxo2sle/XpVsvExiAnHpJPgEYf/prs9b/B7kjHg03ySQoxQyaIjOFcYxXwd+PAf3wQp/SbVW3ay2jRIbuC0HKroNH5OHhGXTOvE6Hj0fPLjhn/ryWiX35LBeC94H1oC+aPYFQo1oI0eTO2m59M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IKH4UzUi; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCwd5qnhbo6LDQ5r22GAfEm9QHioLepoaqN2zf3YOZu/t+y5EGObhtP735df3c6d9ESAEt1jmJ9n8pxPqdh2WZRmkxEyYdKzKIPRuBRpWsyUrPKGQutaJUGCuZJHqwOKnaQ19Fz6dI9VcIo02lviizWO+MkIRg5Lp9J/xvFZJYlEitRSUmNZ2Iu/lXNjktfHr38HCHCuHH/DZq3ZV2VnZvkeHIWxKb5tHDxZXZZqGJEuRkcggMOB2wKK1M++7FfV8tsQxFXoPTJTDhzEvr8LJoW/2ABZu+58FCHmCL35rm1l6x/dYjrmivg7X2gtqmEMfmciS2xMOj5di3+g9i5c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXC7kcJUIDgLAkXSppJLFg4zLxgTQT2n1NJkOfLyh0E=;
 b=AQ8u8R3Ltkphm9T5JvF6Su9wZJXP96m4XTl6vQ2h1eyEHg13psLfpba9Wuc7TpTHGC7tFx3SNqVQtCxkelaGC8XrnU+OdLeMfgx4y4fLESbK6iy5vp5QVqSQE12SL6QtVr7C+6Ns//cJADBPDY9U/nt/zVMSf590pP96eGDYRrwn2sDPz0zqSEgmeNbYTcZMQcwA03EE0fteNG5y4tt7VQub6nVK2AMFpGgYSd5iQbHasNr7+W4/PbKwbuAl9d7ay00G0eRCmpwjZi5Z9YOojKvnyHuTHC/0z4hM/5cAS/hbhPWAKFfLhw2y1XF1ZrQ4rCu2ZOQqOcvBtVuBjY6bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXC7kcJUIDgLAkXSppJLFg4zLxgTQT2n1NJkOfLyh0E=;
 b=IKH4UzUid4f7ihKuF11GELNTLWzdAfWPuruxSM31QQhHjyYmWJlnIpZlO0h3eJq6IGLCn25/PH2Yax9nfJPYuSZ+d+eTGdF4kiIPQz7qD7u2ZKLzJ3zve/0D2UTFsUFPHtfNwJELdfC7SLsM+wJdpKEXL86BXvZdnGhXaVkOyJMEI+p2xXN5kgvb6FfIaKxBEuzNbMOXXtjPN5BWjyr9+OvP5q961uQCJc3ZHn9jzNltAHBMYtdLqmedj2eIr6Yf9N98MSurRwunuq9EOJ4PwkACEumI9dQ0zXH6340Q3tO00s1btyT9QvCUrrneK6sbaXQTqUiz9UHWhpnP9ns8nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3515.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Wed, 18 Mar
 2026 11:03:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:03:11 +0000
Message-ID: <79cc4447-3261-4615-bdcd-71276ac22dd7@siemens.com>
Date: Wed, 18 Mar 2026 12:02:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
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
 <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>
 <20260317110128.k59TflVp@linutronix.de>
 <1e15ac0d-9835-487c-9a16-c55203f01a3d@siemens.com>
 <20260318090817.zuFUjrxd@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260318090817.zuFUjrxd@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:610:38::43) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3515:EE_
X-MS-Office365-Filtering-Correlation-Id: 345da92a-5086-40ad-f1d0-08de84ddf1ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	F5k/w8EF1aSZbz0Wj9oCRiy3mGEWLtWEC9DuKjlgVYwtcYbciRa3RHKeCLih0A7eK+vRHrJudQsEnfrxLkSXbXu37ExuCYlrrj/HIwkJk/pjzadFTVuV58B0Am5sULYNXwhFytePXz2I4PWNOwKNfZn7kieRL9ixGTefNY76tDCZNAZYXq9MyoqOdd3yxO7TmU5SIX+XCdA2/eUIa9e+9XOmkNlQ8mwl0rPD5v6NKjuBb+vV9+trzELyNd6KGV33FbExgTjUF5POkdQatHCXVZxX5I1g/sG/quJOKKfs8bY99Nh7gfCEd/jghoHYrtVxJ9cqelbUzwx0JZP36iCXyCKKgsBkyUkVlCfNPI3d1h0n0jN+XokP1wf7u0wQeUP1M/p8xjsK41HiJGMS98YLfLzszTKBPkojxKaAEAUttuZ1oF3I+TZ83CmtTYS2OgNijW1p2UYkjfGbFESR4b7pIXjcOCGDUSow13dvet4kkvkpoRuid1ZdFKs67/9HQLX6dNe/VN/nUrtUacYTizntNniGpXFtUBuxmmNLmljyDE6rBoqbD4eUkkNcw91ZEzKb60piDpixvpqWTGDDWxwFvaPby7o9IR3VLATnbDH6+2XhwTlzkAqH0iNQFXSqLKu9+mdyWIfSKQwUGg4W6duiZMEDcbt5nH7buWRmFB9EMfbWcqveWcwzeH9oBQvqBPjmFb3DIYTWbGxfTAMJioOVu7kamCJ5ipGOvELqM8+hiy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2phcHNUTzF0d3hwWURjVXFsSVV1bEF4Rkc5R3E0ajh3R094SkQ4OWtBYVZK?=
 =?utf-8?B?dnJ2NXNBQk9PNVZ0MmpTcVNMOE5HNVd6bS9OTlhiSzk2RjhsSEJkMmtFcmJL?=
 =?utf-8?B?dHRySVdTV2hweUE0b0NjbXFTUlNzSmF3SFVJTGdZWkp0aVQwYXU3dmNzRGVT?=
 =?utf-8?B?d3U3Z3c1Ylk0dlR1QzdYeWN3WFgwa0RTaWc2a3R0MHVGQ2VFcTFYMHpXZzNB?=
 =?utf-8?B?TGVKNmhRdmlsdHJMZ090NmZFN3ovbGx1bENKMCtQVTZRUzZPaHJLeDVGOGxa?=
 =?utf-8?B?SlhHVTAwMFBxQ1hvMlNKQ1cya1kxb2lFVlI2VUdUZlppYTQxOTBKa0lNZjFn?=
 =?utf-8?B?cVRNaU1sdmxMSWdRWjd1dkErM2FlWUdPbkEyTS8wTTRPdTYzMTRhaXIzRXhj?=
 =?utf-8?B?YnBkdnBrSEc0bXhXV2VmM01ZQ0d2VnJHVHVCbUpmb0dDaERJeHlvYVR0Y3pB?=
 =?utf-8?B?anRJdWVrTll1OHp5cG1kRGNzNklXTjJQVjdDbmp0NC9Temd6RXRMaHMwUmY4?=
 =?utf-8?B?b3Q2NGdXUnhESnFSdjFOTXowY1pnMWlicGp4elpUakQzVDBXSmlySjljd3g1?=
 =?utf-8?B?MkFWN2JXVWRMMlNFdHhxRklzRlhuQnM2NmJjZE9WVDNSd0ZGZ0M5VStPcHdB?=
 =?utf-8?B?NXRVUWVIbWN5VSt4RnpqQnQwdDMwWFdad3owN284T1BWa0tqNExiQ0ZUYVdR?=
 =?utf-8?B?bDJHSVh2dWMrdHNpc1BzVzhLT01zUlVqTkFpR044YVlKZUhURjJxSkJ6TGJv?=
 =?utf-8?B?RjlTZGVHaVRRTUVoemhNUzZha3RaRWo5WEo5dW1RazNJdXBqbzAvM3NpVXF4?=
 =?utf-8?B?UDM5bjNJWU1ZcXV3eTBQaFhWSlpOT3VLelhrSElvN29UdzUrNWxTRHA3UGpq?=
 =?utf-8?B?cnhIMVhEZnJHNzNvVDU3SmE0cHBub0VBQjFmNXdtdW1WVFNPejVjR2tiUUNL?=
 =?utf-8?B?d2NreEN6MUNOQmljdVVZSTUxZzhycnRIblVYdUNMdlYrRDgwTGlzMXkweG5w?=
 =?utf-8?B?WDh1QWw4eFJ3Y1ZkL28zMXEwUDRLK3RVRmR0WmRYVHBMeWhON2VvVHpQTTgx?=
 =?utf-8?B?cWc3SGFyd0RGSm5UZUJzRzUzYml5SWhKNXExTmExNU9BSFROTkJQUllLZGpt?=
 =?utf-8?B?UlZzRWRZQTlJTjdJOG5VTmdFelhmbWVoUjJvQ0ljc2VtYU1va3VYYUFFVitx?=
 =?utf-8?B?UDVtSUVSeUoxWW8xODl6ZElhaXkrY0lxYkFCdVlRRWFOKzl2SDI4QWZBaVFV?=
 =?utf-8?B?MEp4bVlBbnRTQ2tvZFhsNkVxYkpNVHdjeU1BbHJFYjkreW43UWxyVU1xSlZo?=
 =?utf-8?B?MnkzcmVZRXRQVzZ2MWFRc3l4YVRFcVE0VDJvODdYTWhRQldydi9oekNmVDlo?=
 =?utf-8?B?bEpaS2JiRnl1VlBxakRneHY2WjlBcU92Yi9SUXcrRU1SMVVoNTZ4eURtVk9F?=
 =?utf-8?B?anVrcm94TVpiTUc4T09IS2xjK0RhYU42b0lSM01zdUJoNm9FMmhoSHY2RzZp?=
 =?utf-8?B?a3dtZVhFN1FmZ0psb2k0SDI3amNIcmJvOWlkNnRBbFhmaW9aQ0xKVk9Ia3J0?=
 =?utf-8?B?ZEU4dzlpNGp2c1I3Z2xacUgwbkIzQmZrN3dpYVN0d0Q0Nk42ZXFyMmNzN2ZV?=
 =?utf-8?B?bGJSR3owVXZ1b2lzMjFKbkxCTURsSTBNVG5GNStYRnJqbEFmeFhicVNjS0FL?=
 =?utf-8?B?b2hsN0wxQXlQVzhIU3AwUXcxcVlXbzVzak02cm9CWWt6c2E0eU1ENE9iZzZ4?=
 =?utf-8?B?ZnUxRjQyb3JiK2JHYnViT0JrcVZTMEVqSERTN0dkdnBycHgrRjVyNUVsTGJx?=
 =?utf-8?B?NXhYNjdTRUhrUVAvQkgxTnlicVJyUlBLNHMwbjRWQWxaTWhGTmpFZ3VseTJX?=
 =?utf-8?B?UFlMQXMxY1oyZUVJSXRtRHpSQUl6UVljZzJTdXMvTkh0Rm9MYmRCTlRnM1JQ?=
 =?utf-8?B?UmcxZnVwNUlmbUlES041L0gyZmpCcUgzMitobXhlVDgvZzhsN3JvRC9lMGxp?=
 =?utf-8?B?VlpURUE2a004ai9TaEpLQ0EzZ1AvZ3F5aUxuTGFWaDJxSjJ6L2JSc1VpQTVJ?=
 =?utf-8?B?UXRvN0l4MUVrdVFWV2xqYXZmZFIxbDdTcUJBWHkxTGoyaktiSWZMOENxUEM4?=
 =?utf-8?B?MHdOUjQzS09kR1B0dEcyczY1OHQvTXpFNWNpNzI5M2FpSitOeFp0YksvQzN5?=
 =?utf-8?B?WHR3RGJyTU9Vc2FObWZiaTVFWDBlMFNXQjZ3UUFJbzdxUlJLTm9mdzFlSTl5?=
 =?utf-8?B?OW4xU2RjTjNQRkhvRWh2SWRLbGgrd1VBa2djL1RuOUZzYXdMMXRhdUtmak4x?=
 =?utf-8?B?akJaUkxwdVNWRjRYek9mVXhMRDdVUnRlaE9zc3NmQTIrelFqYzlDZz09?=
X-Exchange-RoutingPolicyChecked:
	bmJj/7j4TIZIWdF/JQqJRUZhs6+LvjCOC3iJshxdIVZtd5qv2PqVCXpYPyBH8vPf2R01twNiUqirNqK2zhTo7Y3HZSm+sGYiDEfvDrwotA116gekaJcRXn9HWGAoW2WaHaH0Wf9gaxOMhUykjrlSyd7rQqWNbyINQTpLfDjNxyB6koFXKYKlflVqzgZFhURj9cZva4JSw3qaeAZgFyr+SjlfO//oYpGz6MYufjWgsGHAPZ/4MZpOzIXNXeiWIwTSQqk6/frZi4uzuRQlY32yqUOEW/ofZBpwYp1ZnLcl5PUS5bE/PmSDc1yldqTTYCujtNQhrBDQkAt65D+RXaK88g==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345da92a-5086-40ad-f1d0-08de84ddf1ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:03:11.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDil9GB0CcIn6X2AeoSFw+8V0wA/UhzCcDQ/XufcjfsyvyS42pB2atOq4q2TXLPrhF8eKrsEAYmeAfRBiec1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3515
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-9521-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,outlook.com,linux.microsoft.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: E8D152BAA83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18.03.26 10:08, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 12:55:15 [+0100], Jan Kiszka wrote:
>> Point is that a task that was interrupted by a potentially threaded
>> interrupt keeps this flag longer that it needs it. And that is
>> apparently harmless, but fairly confusing.
> 
> correct. My only concern would be a shared handler where the second is
> not threaded.

The vmbus irqs are not shared (beyond what sysvec_hyperv_callback does).

> 
>>>> With that in mind, the new logic here is no different from the one the
>>>> kernel used before. If both are not doing what they should, we likely
>>>> want to add a generic reset of hardirq_threaded to the IRQ exit path(s).
>>>
>>> The difference is that you expect that _everyone_ calling this driver
>>> has everything else threaded. This might not be the case. That is why
>>> this should be in core knowing what is called if threaded, use in driver
>>> after explicit killing that flag afterwards since you don't know what
>>> can follow or add a generic threaded infrastructure here. 
>>
>> This driver is different, unfortunately. I'm not sure if we can / want
>> to thread everything that the platform interrupt does on x86. So far,
>> only the last part of it - vmbus handling - is threaded. On arm64, the
>> irq is exclusive (see vmbus_percpu_isr), thus everything can be and is
>> threaded.
> 
> No, it is a percpu interrupt which are not forced-threaded.

It is threaded now due to my patch.

> 
>>>>> Couldn't the whole logic be integrated into the IRQ code? Then we could
>>>>> have mask/ unmask if supported/ provided and threaded interrupts. Then
>>>>> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
>>>>> instead apic_eoi() + schedule_delayed_work(). 
>>>>>
>>>>
>>>> Again, you are thinking x86-only. We need a portable solution.
>>>
>>> well, ARM could use a threaded interrupt, too.
>>
>> For a reason we didn't explore in details, per-CPU interrupts aren't
>> threaded. See older version of this patch
>> (https://lore.kernel.org/lkml/005a01dc9d30$a40515e0$ec0f41a0$@zohomail.com/)
>> where I thought I only had to fix x86, but arm64 was needing care as well.
> 
> Per-CPU are usually timers or other things which are not threaded and
> have their own thing for the "second" port and I only remember MCE using
> a workqueue for notification.

And the hv vmbus now provides a case where threading could be useful, at
least for arm64. For x86, we would have to check if the first half of
sysvec_hyperv_callback (mshv_handler) wants threading as well / would
support that.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

