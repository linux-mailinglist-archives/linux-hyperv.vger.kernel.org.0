Return-Path: <linux-hyperv+bounces-5397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD9AAD453
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 06:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F69F1C06C57
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 04:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B41C5D46;
	Wed,  7 May 2025 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uCLsJgB0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111D1C54A2;
	Wed,  7 May 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590640; cv=fail; b=C8pgz96wGYfiDqNUkbyYnf0O++bIJrwhKF4hiuFT7sXfShS4fPUPqVt3zAwAPBHjtNRpI/+v/8LdHv5Hdh2+bs/gf3N+y7UZYnQWn7DiAX8eBmSx+H06YK9ma8B7TlfbydbhZ5PcDIs39GIWSFu9taZIEaTKOi7+CvOTenfngKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590640; c=relaxed/simple;
	bh=Hyza+RaKykYh/Nv7+FTcpft5SJRDsiXgSmDohw6nop0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BBH1wBeXPzL3QARzTxWHOtr5NEbR5WqpSpYiPGkrpyeHkcle+TuY7rMACTtfEv9vDPDzc6URQAMztdhhAlTLxrKZmkfGKGFSpqH/YNer6XLjOzT1NRrHhv05ufytqrkPY+wkyvlDt6LCl8CyFuCynPNttfq6VhtRRQR4KRnN85g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uCLsJgB0; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfjrPvwsW6TIUvbP1dcQODdGDFuEmvp7UQe+tkkzSluMaKcHDuOB2zdFLteg3ma6yu75hcg0QBz+L3pFjIoT1bDDSSl9D6rk25KVPBOGz+exC2ScwM7xfh4gTCnxBJEZDEnrH9Wvf1z6BW7rSWn93kzZ0m+rhx+CHJ5BsQ5chL71xiN5y69cgfyk6QmJvbAX30UJeAIjuUUYgzHadspTvfM5DWz+iA6HGN69SgKs1kNnSqhzaE/tHssTtCB3jhqtFpWmXMeGszeYGkSH/vUkCRzSgXSA3uPU56FaQGAikveKGWR69JWH1gPnvzI1LKWy8ZbTJ2zotTb8p5sHZo7/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9MpCMvLEyfpxiF1+c5G8bJ3y1nVVBCbEGPf5TSTU9Y=;
 b=B4tU0cpdAcIDj/UDJqKGBmlQ8bSOpijK901+Urbeo1U+JW9ndKSE2xHq/zI1jmg5VvN4UTp+vW8HG6EsaFAOK+wAWmxTbeAtOBUJbwx5paJuKyTy1iBHJRgQmBMfAeWx3GynGB6kDbD8ncZ4Jq8K4TyJjT2bZU0zv5o0eohx4mFo+6CG4Q8Ds9f0peb8S+2C98xnIqIwV1Ta8WByFVLwk/T/5+JYKJZX5H65EsvxV3XTnzaiFhKFLR7YBXBhqeHIML9wWJuxo4/Vfo+VRhCFFaA2r7nbobLbGFUDP3wUHZu2Lff3jz+Kwu5GF7s0XHm99iNtGhFXXYNna7wklC0H5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9MpCMvLEyfpxiF1+c5G8bJ3y1nVVBCbEGPf5TSTU9Y=;
 b=uCLsJgB0zUgk6T2FMq65tFzqmG3I9aEem1jKTAWd2cq7K44oZGEgq5FwTBn+eCYYM5ND6Icn7tC0bRC7QzG+wqIBX4aHs+EYO1fsot4XPMHytbcLfYDvSRU50ZSof8hjI2/xxZIpPofnoroagxeFJfENimVSL5Q/e/NgITumfEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 04:03:52 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%6]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 04:03:52 +0000
Message-ID: <d1dbeac3-42d1-4ca7-a8cf-8d3b27176a98@amd.com>
Date: Wed, 7 May 2025 09:33:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] x86/x2apic-savic: Not set APIC backing page if
 Secure AVIC is not enabled.
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 yuehaibing@huawei.com, jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org,
 tiala@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506130712.156583-1-ltykernel@gmail.com>
 <20250506130712.156583-7-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250506130712.156583-7-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::7) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: faa2470a-bfdb-434b-701e-08dd8d1c2d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmdZQ0UyWmc5Y090RXRjZVh4TTFBVU4zRGJlbzE3SnBOYmZWNXFBMjRRSVVI?=
 =?utf-8?B?RkZMSzZoWFRJRkhGUFJhbUVML2htcHdRRWtDZkhxSkh2eW9PeUNOa2NFZ0Mx?=
 =?utf-8?B?WElVZkoxVldXbVVsUi9GcGNpaVFoUlFjK20zVTVqZkRlM2d1ZW9HUGxEZEZN?=
 =?utf-8?B?Ukp2cXZRT2EyWWg1VmJpS1QzcnM0ckJqQ2FqQytVVlByaWxGZGYwT0xUQUxk?=
 =?utf-8?B?a0NIMzRxeFhiQ292NFgyUDdSQmR2Uk11VmNPQzBNZkdaYnJuZ09DUjYvTVJj?=
 =?utf-8?B?ajZzUnpZbG5qbHpWTUJZZUVUdWVKM2J2cG42YjdMY1k0S0NZVGFGRDNQZG5y?=
 =?utf-8?B?S0xmRkxZbTY0ZnNmcGl5cVB4UnhRcVpyTHpqSzFKNVYzMmxCYTRIRkJHZXJG?=
 =?utf-8?B?MnpRY1MwUlQ5V3pvU2tlbkJXemlrNDYrcklVYlZsMU9BUENFbEsra3R5TGpq?=
 =?utf-8?B?SS8zdTBjbG9zRkRxaGlXOThIay9KNFdnUFJ4TWwrZzVKanNocE9XSUx3V1ps?=
 =?utf-8?B?WXlQOVlwOGFxWitRL1VTc2U5cnhORzliT1lHSGQ2VS91ckNRL0d3OGJ6Sko2?=
 =?utf-8?B?QTAzQ09NdW9EV2VZenJ4WU1VME0yVWhLSWlmeTZiWUlRaW1yYXdKRitPaTFP?=
 =?utf-8?B?L3ZjY3NaTmhRa2pkS3U5UlNaRHZOQUpOdzM3Y2VwK2U4cGdWM0F0SW1RM2pW?=
 =?utf-8?B?UkF3VTdEUllUb0hEaDUxbSsySkFBUzBvS1A2QUxLSHhtc2xKQ0xLQjJFbGpo?=
 =?utf-8?B?RGlFc0FkSFlkeEFrL2dwYmd1VVJKd3ZiNVkvSmowdWpxNlg0dE1WNUlwMFpM?=
 =?utf-8?B?cnpoUG03L2JBZkdKS2JYb2x6YVo1ZFB6dk5MRkdlVndRcWlmcDQ2SzhUTjYr?=
 =?utf-8?B?emt1YXFZcTBKOURiaTJWM0hoZExyenhPOU9CQjNjNUh0NjBqeFBOcVFVeXJM?=
 =?utf-8?B?M0UrN0hxakN2NHdhM3Q2Vm42ek9vdEZ3TlJIQitoTysrTU9SSkNMbVhJMHc5?=
 =?utf-8?B?OGRMclhvRUFzTmZNWlV0dmpCRmo2OS82Um12eUphZVBiejV5VVo5SGFOK1Ev?=
 =?utf-8?B?K1F0bUZxUWNsYzVKcnBoVEdIRlVJd3VxYS96dXNLNkd6U2Naa2tZVXhBMVNO?=
 =?utf-8?B?V3MxcHUrNzY3L1lkWGxUM0cvclhibmZ5THpITEhHWUYzdmM2bEE5SFo1YnJ2?=
 =?utf-8?B?aDF5aXdlRVdkKzE5K1VCMWwwNEJSUmxSQzFqZ2xiakNENGhvejFPYjI1S1p5?=
 =?utf-8?B?encvNVl2K3VDMnE0Tk5TL3hJUTBxaERySTlHb1ZWT0p0aXpuL2xxci9BQzhQ?=
 =?utf-8?B?SHFYUHZ1RDk5blpCTERqL05UbGlPZHE4Vk1jVlJ3OWdIcUNxSlFtRkJabDly?=
 =?utf-8?B?MncyMURTWEdWZVEyQ2FEaXFXRE1xZ1liemlqMU4zNVhpTWl2Q1RyZHMwKzNZ?=
 =?utf-8?B?UWk4VjQ2RHY0R1dicnVMb1pYQ1ZQenNOZ0pGeWZPaDRlUWEzODEySm95OW14?=
 =?utf-8?B?enBMWStPQ0lBRXVrRHU0NENZTjVTZmdOTnZJZjQxSlVzUWUvc0FIZUhHRXd2?=
 =?utf-8?B?YUVXdzlWemk3TWNLdEorTjA5Rmh3S21WVENaYS9KbDdTSTVvZlorUkc4SUx0?=
 =?utf-8?B?U1VGVUdzcUx5WGdCMWtwRlU2L2xKRnlRS3o3VC9OSG5QRXhzR1ZuWVBzd0t2?=
 =?utf-8?B?U1RyNW5LYkV4aHlEVUNSZTRzclVKUTJEOThabnBoRWNXN0VNOHRNa0lTWkV5?=
 =?utf-8?B?K2VQcUFKVEtxdytGNGxWQ2EyTXJ1QUZyNTMyc25lcjc4c2lubTJTRzlKWlEr?=
 =?utf-8?B?cXJKcW03b3hmL082WmJwSUcvSEIyN2oyS2cxc2htTnB1ZnRxNXVEYllRUDRo?=
 =?utf-8?B?SEpjaUZyL1ZsUkE4YnRVYVNPZ2ErdXlZME11VmxXbFZHRVk4Q1VvbEFsZWxQ?=
 =?utf-8?B?dmdvd3RhYkM5WWVmYS9iQUJEVU9FK1JTdDN1VEZxNXU5TDI3aCtMdTMyTnlj?=
 =?utf-8?B?ZEJLcEs5OWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZXUTkvT3JtZXhzVTVYVDVZSURnaHVMdWp1Wm5oL1ZTRzNFaXdxb0pZWWN2?=
 =?utf-8?B?SWIvQzFBYmxKcmtoU2Jpd3pndlE5cnVPT1VHZjcrUXYxZHpzb01Fako1UE53?=
 =?utf-8?B?Q1ptWXM0S1lFUGNYYjFBZ1BOMHcrM24ydkRHLzY5RWtDVmVoczQ3RElrdXY2?=
 =?utf-8?B?Uk1wS0M5bkRQc1NBRS85TCt1MStMTktvQjVPTXpoNWV0ckFqNFQxTVBLQXUy?=
 =?utf-8?B?VjVFY0VqcXorMFVITC9xYURielVIZDQ5U1g2bjZnd21oajlCUnczOXVyKzlQ?=
 =?utf-8?B?Zkx0ajdob29OemdYZThhR2xMdE9JZFNvRWRudzZ5QktWK1NTVWM5L0ZFVlhh?=
 =?utf-8?B?d1pCV0ZoWEExK3piYVNub1ZJd0RGVmxnVklHWTA3T2xuS1JvbkNMeFB4eDA4?=
 =?utf-8?B?b1E5ek5xVFlZUG9mQW9CS2UzSk55VkI2cnJyaVZMbit0M1FrVkpyY1MwaVpL?=
 =?utf-8?B?S3hBdk9qQUErcWNaZHlPNVk2T3plZ3ZLV0FteDF4bnkvWjZvZUlIaFdoRFlG?=
 =?utf-8?B?dWh3eTR2SUVrWFMybmxhV3BQNmpBeHg5SGNnd3JTWFJLZmQxTGhLSDVGUnl5?=
 =?utf-8?B?Z1NiZUVVeitueFJZdnkvWFF3eDBucE11di85NzVUZ2F1eUp5VVBoWjlhK0lK?=
 =?utf-8?B?d09ESGVzNzJGNFdNZzlKclBFQkh4N0JRYlJ1TUQ4bnhjUXFPSnpqUXRoTTBp?=
 =?utf-8?B?VjRpSW9xK3IwQWNLTWJsOE1sckk5N1kyZHZJRTJMK1lCOFJ1eTVaemtUWVZO?=
 =?utf-8?B?VXpHK0NlUFZvRkdBOEI5OEdxV2w1QXVOVVFDbWtZdGpuOVdEay90UVkvUVds?=
 =?utf-8?B?M3NXYSt3RnJYNGlMR21EUHhEcWZIc3c2VkxNeSsyUEljaWtITUQyaXVFWkFH?=
 =?utf-8?B?bnZWcjltRVJKeU9VbEJrMW8wWGxnZGRDQ3pqS2R1U1lPSXRRQlBBT1VhQlRS?=
 =?utf-8?B?S1hESGdWRm16cmd0cjJYdVUzRmZlMUU0U1ppVnhrd2ZuYW1UUFlnOFVYS1k0?=
 =?utf-8?B?Rmc1Zm5DR2dSTzVYTVQ3Vk5US3VoVjRkREh3UkVYZzZyUjRJUjZxS3VEQVhE?=
 =?utf-8?B?RE1abkMvZkp2Sy90SlJ5V21JUDFlK0hZVUNROWN6LzV0Wi9XczJMcVlXelVl?=
 =?utf-8?B?NXY1T05tdXdvZTNhUUVWWXc4L2RSWWUvRXp2b2dNZGhMZldmTUtvTlYvYzRG?=
 =?utf-8?B?ZXlFQ1UzNUVOQkVlWEVYWFBvVDZvTUpLSGlTTXN1ODhvOU03MVZjQVZnUDE4?=
 =?utf-8?B?aEhpcjFOaDd0S2IrcmhnNlQvM0haWmxpcHZkZkRkRHJjcUpUeTlnelVmWEkv?=
 =?utf-8?B?ZTRMTkpsNjdsa3VSL3VrUUFvNVoxb2E0NnJmWUhwb010UWtVbDJDVVFJQzVa?=
 =?utf-8?B?OHhnM285WUpROXkzTzBVbkYxZEZLMTJuVGpFOFJsWmgxZHlrOVlKZVEvQXhP?=
 =?utf-8?B?c0N1WlN6WWMzRFNlR1BwSy9JK3RzZU04SGt3NEFqblRVakR3bEZtSy9DZVJF?=
 =?utf-8?B?NTdtT2tOQzBqYTlWVERZbi9YekhKcEdaNGRVNkp6M2NTSGFZMy9Nc1l1WDR6?=
 =?utf-8?B?UkdldkpzWnpnTmpQby9hVzRZQ21NeklJeFFTeWU0QUptNUVnR2pJVmVJRGVI?=
 =?utf-8?B?VnVSRytzdlFYNkNMSVRVeUJWRFRzR3Z3U04xTVV4T1M0UWhrT2tva1d2bmR3?=
 =?utf-8?B?WkVBTkVGM3NRbERESWNQdXVaaUx0LzAyVG5XdEFpZzl6NFZOOUxjOG5kSFk2?=
 =?utf-8?B?UTJFWHB0V0FsM1luT2R5NytuamIzalNNRFUya0VVbElUM24wQVdVaWxtYWdn?=
 =?utf-8?B?TCt0YnVvYTBzWlVWTStFOU12VTNqUDRjYzMzbGJ5V1V5ZEVzNVlXTk1mUWVx?=
 =?utf-8?B?blBXRHVrNXR3Rmw2cTMvZGVQWHpKdWhSY0RqUlRhV0xqU3lKM3JpeDlIWjZh?=
 =?utf-8?B?VnBhRlJYdjBhcU5XbWRwaThUZ2gzcVJoV2IvRk10QW93SjB6NnozQWFiT3Y1?=
 =?utf-8?B?dVFvcGx3TVFiOTlJQ0k3R0NSOEVvMlB2SCtXQ2FzbnR3UHVmTjBjcWY5QTRh?=
 =?utf-8?B?aG5UYlllOUVUbEJCWW1GZkoySG02dFlFV0Zpc2VhVGU1eEhWYitteU9nSU83?=
 =?utf-8?Q?GQY/A55y+uCOrNa5eRvNOOj+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa2470a-bfdb-434b-701e-08dd8d1c2d58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 04:03:51.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLJLCMTyXDqsH/gIVaRIYPc1l4SAiUomEO2qAuIBQ67lKu0j0GtKKgOde8rCfxKTmNYymZdAPqd9vRk8Dvl2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709



On 5/6/2025 6:37 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> When Secure AVIC is not enabled, init_apic_page()
> should return directly.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/apic/x2apic_savic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
> index 0dd7e39931b0..fb09c0f9e276 100644
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
> @@ -333,6 +333,9 @@ static void init_apic_page(void)
>  {
>  	u32 apic_id;
>  
> +	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		return;
> +
>  	/*

Why is this change needed? init_apic_page() is only called from Secure AVIC driver's
setup() callback. savic_probe() already does this check. So, if this check fails during
savic_probe(), Secure AVIC apic driver won't be selected as apic driver and it's setup
callback will never get invoked.


- Neeraj



>  	 * Before Secure AVIC is enabled, APIC msr reads are intercepted.
>  	 * APIC_ID msr read returns the value from the Hypervisor.


