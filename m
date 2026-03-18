Return-Path: <linux-hyperv+bounces-9522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ4/Gk+IumnSXgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9522-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 12:11:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1D2BA90F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BDD432096E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B973CA49D;
	Wed, 18 Mar 2026 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bRrxksLa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6173BA229;
	Wed, 18 Mar 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831804; cv=fail; b=ZVFlZTKPau8rg8wA7izyhe2DeRr9LdNAcfdWxwiOvzEyfH3Li8GYBsSxScMKMxfFOtxEPjXAOVUd4kAuNf7/tqdGD67TfeILBOb+DR84L7NIVAP6LFImtqP1vy5zUH9jXKZWcPSfM8OqQ49KMR8w02yFyniXbZ3nDm/C5ihhUxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831804; c=relaxed/simple;
	bh=lXVkaiA+EapO1UWY2bsVkSBlfEUwleDnvSaQ0ArZSCY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBItvW+dcMSXJ/PM2IwL8XmWtVF8vFbtzQFEPgONQMQQcP+JMrC1W/D5X/+JP40lyffcjGBetlYCFPcYEK1cnfP1looUwKN6Mh8swtFdZSmB4YMoAVyHqBonb0bAVCSZNlVxQLvlxH532foF0LSRNKfiZwNrPI39beVfZgrNRtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bRrxksLa; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFek8K0Q8Aisv1c4uor8JezoSMWoxXZL/NHxNCppbEXvF/lutdxGFbSAaF6AIveS/6warnu/sRXSA3EsHNACoSGERmzY2xJmVDyok9HZJ2wubH8tOuKdtTv6xES7ald9Qh7fGyyxbsV9bwwK3tVFTpGFv/BYdgyICaXTMkTCiv9RT7LAV+4FQdxspzcx4MxFt+mMvsGOsaTlu6yqOAyoBa95P3C/tjrKqPTH/jqJuezRjULwHqDnpUmRX5CpAvJA+2fvLTqf9TmaET+xiMdh10c+ijPX/5JsNUdNPmmZjMOmUjJ41zfedzIAT3p8NLXANt46uIMYuuzTZzO0yxb9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+xkKTLHV+T0cIK7g628P8vgKQ2JkBbU+u1UFlEkHb0=;
 b=c2VdfCiI3+7bmBLKwjdOsGlo9gyKwOGfs2nQXxEMRAs8njiDiWgG5C8ltAUII1ZMJ/EOeCqbFRlr8oLZKHTVkCopW4JbZ8x2aTTgjScfxMjfhkxw9LcdovHsPT2IWxseS1xYdrjZgMs6KxbmBGyhvlXigV2cd8UWcGqpLGsMvRdDGDgOBlinfpkmk2P5cDzKnI/B+SZLPARQsiK9fEa7edSfydSUwspXeXcbxgdT+/0Dthts9dFEupZnqR0kPEE4TEecRC0Nx9GoJWSjcMgidWjFQjQbzVt16zEApMUpYnm7a5GcyLpZY00ryy4TIHX3eE6EAULPbKx4t9+nEnYygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+xkKTLHV+T0cIK7g628P8vgKQ2JkBbU+u1UFlEkHb0=;
 b=bRrxksLa/etkMgptNsl9zftiA+U/Tcsv0OE70QYd22iBukjL9ZjeEjGIgpVtVuOC3ToLZtQtQ/CO0xCL4v8jlXOTpk/dq55LZ/CoE3/YtumVB7BPNTs6df/ngzORmtbZYT9trW11tbBSqOnaiI6NuODeAYAJb2lbW4hllFbSJ6tbAiirEMWXU99JWP2klxYysldwJckueitEGvRH76080aAkfDq4MMQLo3rlfNtE75QsK/XX7eWUeUshm5gNYO+Dnk7pDMu1lHUPdmZMWo4l1cJjRD0AvWxxaK5uKJpkJOYsWlV/0WJiMy9b86QY1PC20bMOeTW31XdiUyoLChTybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3515.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Wed, 18 Mar
 2026 11:03:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:03:17 +0000
Message-ID: <7f248f1f-a4ad-442d-bd85-23e57e58eeba@siemens.com>
Date: Wed, 18 Mar 2026 12:03:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <SN6PR02MB415753FDA0DEEA0B4A8B9994D441A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260318100138.GimjldpV@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260318100138.GimjldpV@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: b13e494f-d8c3-49e3-5131-08de84ddf519
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	oZodjc/CQgOrL+C/Mdz0npGgD/eZ4DNndvV6SorHJ0gq990+OtliJVDh+N+mpAljVkTUaKMZoEPeN80hVFgqmGZnsDzEjhAJwxgDPN/2g985UiaZ0sXlZwQL4oS4a105g/odEQVvPWa8D6FD7MH64PiLbEypmQeJPDb3XdYraKOrPA65fkwuhxOFw1DgPG4H82YXA5JquoQ6otby+Pv7Otg5pg76XXfAqbc9yCB7PIOAVoO1Fhd4mG1d3u/FLfhehsCxo7VFHTlttXyoO6D9fApvWBwDSan/2SSL6UC4UZ2mT9ZB2gHCIo0vdh0xVGgyPft8FAhl1ToM7jCTPRB0GLtpvmsBtmxJKjX/NVzjHprREne7vi/imGO9UeV4BI0iv7FIRd0m8M1Z54/bh3c+xYQT2RM9NSQuBaVci0lSDWoFdgk486aacfeX8k/3anhu5AlE5Fghg9dbYI90ey89T9O1s7tjWya1UDVmypX7ikjWowHM9iZU/8S3Ae2zq0SLtexKR2FJb+Sj0T8wv75NlErvgM7WpcfShmNBnbm3DTjVflDO10dkMRRCDd2xV2umDQTa8vajOmHdUH1dvXzsLEFE1wKljxLJ5YxOH3tOp2yGs0AKOBIjfXHrTTuxjfw1h0p2EcvA39ldjKDcqApwWfvjmQtfaDblKVmz2WULspu5zZCMyAz5aXGOgqdYlqkr1rOhoaQIkHEgSZhVW4u0jJRqk8zz2SWKX+P1oquKEK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRhY3ovUjFtZnN2ME4zNG16ZHZjZURVcDZlcVVMVEkyZG92M0NpQkhZOGp0?=
 =?utf-8?B?dGNTc0VqSjhSaE5tOHQveUpuRUNOUkpYOFN2OThtaUJ6bWxnSk9oOFJBc1BL?=
 =?utf-8?B?S2pEYzlzNzcyOHMzdHArYnlZK3R4UTBsRlU0ZnpwQk56MW1HaEx2NURFOFJD?=
 =?utf-8?B?b012clhReTJvcTFUZGtYMlZuOEl6U3ZSV3dvc2xubFFDQ2J0UWk4cXJCbS9x?=
 =?utf-8?B?Nk1vVnczYlN6UnlXRkVCM3pSaDZ2R0ZLbDJ3eGxXU2FxdEl3UmhuMlNpVUtM?=
 =?utf-8?B?Mkk0OVAzeHhJbE5Jb3dBSW1QT0JPcDBiaUVaczUwd0k2TGtQWUNxUzRhSlRw?=
 =?utf-8?B?ZENLOWFOTUNtblhXSm1TUDhHSlFwNEFaRmxzRm5qZXQ0YXR4R1JrSGZOWE1j?=
 =?utf-8?B?ZUxUTmttZndyTUpISEtsa1ZDdmhxeE54bWM5eFFkRFUyTENvQ1ZGRVY3SFdJ?=
 =?utf-8?B?ZWhSeGZMdWJGamNQcEhIK0dQazV2bWtUTlo3WE9IZU5CQmRPSzdoRjlQOUFS?=
 =?utf-8?B?MkFzNnNMLzJFd28wb3Q0eVVyZVg0dEEzb0JxMVBBSE91WEZVS1YxdC9hR1dP?=
 =?utf-8?B?R3FuNGNkUjdXVFVnRlU1RVZjKyt0UC9WbGdXcEQ4aGU1TEFBTWlWMnR4bzRr?=
 =?utf-8?B?ZVlhTEVXdmtyOWFjQ3d0Wjcwa1dhNmxDdER1ckdua0I2MjZYNmIvSEVvQUdy?=
 =?utf-8?B?aWNMU2FTUGxwbHROL1R0YVVwUjFRUVhpaStUMFZEd1NxeVpiZ0RqQjBkZXc3?=
 =?utf-8?B?dmlVelhDd25DN1Fhb0I3OUIxODF2d0tkYkI2VlhjMUUvUWR3OHJ4dCtCQzh2?=
 =?utf-8?B?eUVpdHRSUEFSNWJIVjY1VFY5Ui9BTUVDTWJLU2liOE52b3RrZFlZWUlGc2F0?=
 =?utf-8?B?OWlmc09obVAzNFlhTlV5cmVkcTRSZVhYRzdmb3NSQVRCQ0lZTTNiYzdxSmxQ?=
 =?utf-8?B?bmZta0RWMldMMkNEcUFzWXdqUG9meEIraFhxZmVhd2M3YmlCU3FReGl2Rkxy?=
 =?utf-8?B?MjQwUU9sRDR1SWcwY2l3dEtwRjVTSlpoVjJncDdDeW9qY0pVcVE3U1Q4N0Nl?=
 =?utf-8?B?Rm9qZ0xkUmp0cXVacVhGT29TZzJjR1JidlZUOWpIaDE1TGVUSFBUVnRyVVZY?=
 =?utf-8?B?Rks1YkV4WlpzNDlPOXVBbXRSdDVuYnAwY25mcmlPK2QycVQ3MnpsWExsNDhn?=
 =?utf-8?B?Uk5BcGZqNlcrWEhvU1EzNkkxNCtzakV6aGF2QWNmbVArU09QVllSTmRqYkcx?=
 =?utf-8?B?aWx5eTIzdkJhUVpkck1yeXhFNjJ0WGpVSlJnZmoyMUE2SnE3bys1Z1BsZnIr?=
 =?utf-8?B?QWpmYlJRalBZQzdrcUhsMHNPOS94YkF2WTFZUTV5dHY2VDVSbTMzc0pvRjRL?=
 =?utf-8?B?UUlnZHVER1k4NHY0WHREMk5ldzAvOUYvVE1FeGxtNThTMU1Ja0FZV3BYejdS?=
 =?utf-8?B?UER1WnZrZGFLQjFqNUxWQlVwWjFQV3Y5OC9xWUxNbWZlSFIzbzM3Mk8vZHRN?=
 =?utf-8?B?aEoyeHlMcjU1VkFlSHJjQ3dTeG80ZTI5RnFnU2FISWNRdTZIaEVFbmR1U0lk?=
 =?utf-8?B?QzNUZFZJUFBoRktmcTNONzA2VGpmL3RFT2ZvTVp2aEZ2M2dCV3RYQ2FsNnA1?=
 =?utf-8?B?MzR3OHFwNmdsZysvY0VQQXU3UzJoUWw1NEp4TDVKQ0NrT3BVb1JaYUtGRTg2?=
 =?utf-8?B?Q1dScHJ5c2Z0RStaNVZ1MXBlSEtTNVVaWUNYM0NXM08yNStVbGowWjNPd3Z4?=
 =?utf-8?B?dXduT05OUFoveGZEbjJqcFdYdG1DcERiT3ZtWVpkbjUvZHgvQ1ZsdW5tZ2pN?=
 =?utf-8?B?dzd2WVJ2KzNtdWpIdUJPRVg3NjZvVnlSdEdzeUVGKzhhdSttZC84bXdIaHBo?=
 =?utf-8?B?WjZQaFZhVVFaVWt0Vk9CbU9QL0twbVVOeDF4V1BxQXhBY1l1UEhyeHFJa3hG?=
 =?utf-8?B?YlRZZlVwTVVsM3diK3p0b3Z4aC9iQWZzakF1YjAxYkxvMXp6QnBySWRKVFda?=
 =?utf-8?B?b2VCclkvZjZOZGFjTEtBTDZVS2dHUVM5cm00cGFMbTNGeVk2UDljRlViWEN0?=
 =?utf-8?B?bUk2cjVDYUlxaEhCdHBnQlJpOFZ2Z200SzA0L3RkQWMzMlJHbTBKbFpwejhV?=
 =?utf-8?B?aXZnckNERnBMSzNtOWZ1c1VuVG9mU2JTaWw3SnBTVlJwOGJnNHJEaGpDSTNj?=
 =?utf-8?B?Q2gvbDA2OG9ITDV0cTRIMlg4ZG1ZK21VSStZckRnaklTbVppOGxkNDhBeUFv?=
 =?utf-8?B?bVczanl6NmhGRnh3RWwwRVd1RktYbGxzWnd4RmQ4dmdIekYreFVxN0toNGp0?=
 =?utf-8?B?QUtsK1VZdFNiQmVZclRXdTFWbmZDdGF1VXdiUTI3bHJtbnZTQU9aZz09?=
X-Exchange-RoutingPolicyChecked:
	BCl68ejNlw/G+DqO63NwrqJns2hTyvU+EYFSCiNvk90Ojf/YWujSWlfOF6HEZw5gbaUyMsU5Vyvm+sBZclTHoUrYOC+H+AUR9EoFP1xpHUkGhrej3bbZZjTW/YhgSEURMWYI+hnUwh9TVSF6ydEhEOoO4TzTkDAT/KdbkInfvrMcFzrSGhnGjsGcOcMOnQdIA7x4J9X3kpeHqjECmteNXXK36ZvsnMln+HeaTSo5ljECctZEvRtOgzuF5cFORpN36Ax8TT9GXHkFxKxW/C3w9CcaQRSdPyvL6Bwfk8DjpTZtFNldU65S1P8FGJ7XXHcFPwykkGOYGTISJNUVc0JGRA==
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13e494f-d8c3-49e3-5131-08de84ddf519
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:03:17.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2shhdyQxqgItoj2h+gduo2kDmHsD0byas1Zyh7JZmpq6j2DEYOR87eoIpEquuZyXUit7Q3LzIMZ3cohjJZ8YnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3515
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
	TAGGED_FROM(0.00)[bounces-9522-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,outlook.com];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com,vger.kernel.org,siemens.com,gmail.com,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: BAE1D2BA90F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18.03.26 11:01, Sebastian Andrzej Siewior wrote:
> On 2026-03-17 17:25:20 [+0000], Michael Kelley wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de> Sent: Thursday, March 12, 2026 10:07 AM
>>>
>>
>> Let me try to address the range of questions here and in the follow-up
>> discussion. As background, an overview of VMBus interrupt handling is in:
>>
>> Documentation/virt/hyperv/vmbus.rst
>>
>> in the section entitled "Synthetic Interrupt Controller (synic)". The
>> relevant text is:
>>
>>    The SINT is mapped to a single per-CPU architectural interrupt (i.e,
>>    an 8-bit x86/x64 interrupt vector, or an arm64 PPI INTID). Because
>>    each CPU in the guest has a synic and may receive VMBus interrupts,
>>    they are best modeled in Linux as per-CPU interrupts. This model works
>>    well on arm64 where a single per-CPU Linux IRQ is allocated for
>>    VMBUS_MESSAGE_SINT. This IRQ appears in /proc/interrupts as an IRQ labelled
>>    "Hyper-V VMbus". Since x86/x64 lacks support for per-CPU IRQs, an x86
>>    interrupt vector is statically allocated (HYPERVISOR_CALLBACK_VECTOR)
>>    across all CPUs and explicitly coded to call vmbus_isr(). In this case,
>>    there's no Linux IRQ, and the interrupts are visible in aggregate in
>>    /proc/interrupts on the "HYP" line.
>>
>> The use of a statically allocated sysvec pre-dates my involvement in this
>> code starting in 2017, but I believe it was modelled after what Xen does,
>> and for the same reason -- to effectively create a per-CPU interrupt on
>> x86/x64. Acorn is also using HYPERVISOR_CALLBACK_VECTOR, but I
>> don't know if that is also to create a per-CPU interrupt.
> 
> If you create a vector, it becomes per-CPU. There is simply no mapping
> from HYPERVISOR_CALLBACK_VECTOR to request_percpu_irq(). But if we had
> this…
> 
> …
>>> What clears this? This is wrongly placed. This should go to
>>> sysvec_hyperv_callback() instead with its matching canceling part. The
>>> add_interrupt_randomness() should also be there and not here.
>>> sysvec_hyperv_stimer0() managed to do so.
>>
>> I don't have any knowledge to bring regarding the use of
>> lockdep_hardirq_threaded().
> 
> It is used in IRQ core to mark the execution of an interrupt handler
> which becomes threaded in a forced-threaded scenario. The goal is to let
> lockdep know that this piece of code on !RT will be threaded on RT and
> therefore there is no need to report a possible locking problem that
> will not exist on RT.
> 
>>> Different question: What guarantees that there won't be another
>>> interrupt before this one is done? The handshake appears to be
>>> deprecated. The interrupt itself returns ACKing (or not) but the actual
>>> handler is delayed to this thread. Depending on the userland it could
>>> take some time and I don't know how impatient the host is.
>>
>> In more recent versions of Hyper-V, what's deprecated is Hyper-V implicitly
>> and automatically doing the EOI. So in sysvec_hyperv_callback(), apic_eoi()
>> is usually explicitly called to ack the interrupt.
>>
>> There's no guarantee, in either the existing case or the new PREEMPT_RT
>> case, that another VMBus interrupt won't come in on the same CPU
>> before the tasklets scheduled by vmbus_message_sched() or
>> vmbus_chan_sched() have run. From a functional standpoint, the Linux
>> code and interaction with Hyper-V handles another interrupt correctly.
> 
> So there is no scenario that the host will trigger interrupts because
> the guest is leaving the ISR without doing anything/ making progress?
> 
>> From a delay standpoint, there's not a problem for the normal (i.e., not
>> PREEMPT_RT) case because the tasklets run as the interrupt exits -- they
>> don't end up in ksoftirqd. For the PREEMPT_RT case, I can see your point
>> about delays since the tasklets are scheduled from the new per-CPU thread.
>> But my understanding is that Jan's motivation for these changes is not to
>> achieve true RT behavior, since Hyper-V doesn't provide that anyway.
>> The goal is simply to make PREEMPT_RT builds functional, though Jan may
>> have further comments on the goal.
> 
> I would be worried if the host would storming interrupts to the guest
> because it makes no progress.
> 
>>>> +		__vmbus_isr();
>>> Moving on. This (trying very hard here) even schedules tasklets. Why?
>>> You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
>>> You don't want that.
>>
>> Again, Jan can comment on the impact of delays due to ending up
>> in ksoftirqd.
> 
> My point is that having this with threaded interrupt support would
> eliminate the usage of tasklets.
> 
>>> Couldn't the whole logic be integrated into the IRQ code? Then we could
>>> have mask/ unmask if supported/ provided and threaded interrupts. Then
>>> sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
>>> instead apic_eoi() + schedule_delayed_work().
>>
>> As I described above, Hyper-V needs a per-CPU interrupt. It's faked up
>> on x86/x64 with the hardcoded HYPERVISOR_CALLBACK_VECTOR sysvec
>> entry, but on arm64 a normal Linux per-CPU IRQ is used. Once the execution
>> path gets to vmbus_isr(), the two architectures share the same code. Same
>> thing is done with the Hyper-V STIMER0 interrupt as a per-CPU interrupt.
> 
> This one has the "random" collecting on the right spot.
> 
>> If there's a better way to fake up a per-CPU interrupt on x86/x64, I'm open
>> to looking at it.
>>
>> As I recently discovered in discussion with Jan, standard Linux IRQ handling
>> will *not* thread per-CPU interrupts. So even on arm64 with a standard
>> Linux per-CPU IRQ is used for VMBus and STIMER0 interrupts, we can't
>> request threading.
> 
> It would require a statement from the x86 & IRQ maintainers if it is
> worth on x86 to make allow pass HYPERVISOR_CALLBACK_VECTOR to
> request_percpu_irq() and have an IRQF_ that this one needs to be forced
> threaded. Otherwise we would need to remain with the workarounds.
> 
> If you say that an interrupt storm can not occur, I would prefer
> |static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
> |…
> |	lock_map_acquire_try(&vmbus_map);
> |	__vmbus_isr();
> |	lock_map_release(&vmbus_map);
> 
> while it has mostly the same effect.
> 
> Either way, that add_interrupt_randomness() should be moved to
> sysvec_hyperv_callback() like it has been done for
> sysvec_hyperv_stimer0(). It should be invoked twice now if gets there
> via vmbus_percpu_isr().

No, this would degrade arm64.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

