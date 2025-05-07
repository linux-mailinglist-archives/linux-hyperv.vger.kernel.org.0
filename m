Return-Path: <linux-hyperv+bounces-5396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A7AAD444
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 05:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C9E9803EA
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA101A3168;
	Wed,  7 May 2025 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NayJo1KC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129BF1C5D46;
	Wed,  7 May 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590235; cv=fail; b=lQT8NdNUMQJSG2zDIDLqQlNnEMzg+2HVWBFClYmXuw6Cw2tiWbrBFGs/iGqsR5A3S6RANUaBW8Ee5ZLoSC0XJ/YkR2CUnk1VyiiVimaSXCfPu5SmXdmnVvNsjRctM6j5BcrJ3bAfzJqroiiJnYGsi9gRucYn3/QLvatvP18qtmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590235; c=relaxed/simple;
	bh=qwQ75BI+qx/vpvdV/JQfkj0CfiKCJnIyENfLxk3qXzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5EN3xJXaeKAbf2Yw8X4M8eKOuREsxcaF0o9LGdqK9p+Ibu2V85r0hsDD27DUgRzpPCIXpTubonkXbLB4B2TN9qMpHT8gUExFL6CglHvSPgHxdoI17DJ352laXdDKiOH2QrRGRQEO4tDPblgf9WB68hQIaytaZJbWmqNHrOg454=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NayJo1KC; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6BP4HDivqeIGtu/V0ZKT8AyX1osyJqzsJrAzyiEZ1H+YSeBkLlz9HqVYkw6z5QlroUBP3DYxA1daJZ7xk8pJY0rp91nLosF4sp8LX8F3rlE2vvE/w0+a8XdnwhPZqgBhjg1+Q98YKnIUv1QFd4FjlZzMz82eitEgIkEzKRFGdN+2MloBtF+ZjVAmbtRS1ajCq21byT2TlCBoqldTvgb60TZ13hpGf/wmGG+IC3zu5PP5LJDY9uOaKY31WlQhnQq+Z/BdBFvRJ/S8LUC/1ZoD+TFTsyo2FR4d3ANzSX95IhIX+jLu6jQ0sPIWIr1JNbI7Ih7XrxGlzqpyCNhVhKNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivbGD+WGPsAihLzMKfNkhTJZLOD0AGD6SP/FCBGvGHk=;
 b=QJ6ZUaMWBz1XSeduGmd5vLXVDd8qc4qLjtAVrtAHCXlM2wWkoEq4/58xztxVixFP+TwuPBbUzxaOSu5sCel7XaZiAUaW1BOnxvdV1FMic/ULBhaD/VV7LJZk3UZ47iJiSxhAn0mnXgmi05og14evpuaY04pHWPYg95gpDsU0urtZ5FbIRbC7KACJABIaH9XzPxVzeaPJ267MoXBoB6VBTuJo1MQOdBI/fBXWSKboJ7oOYhgyiw4h+T1CQ227KVJHjjqTZfnwF26z9rVW7XMmHFOHHMG+Gh/iDP/EqBjo0MvDW6QeYOdmgiZfjE5LV7mKoz29qY1bdcA41LsO2HLCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivbGD+WGPsAihLzMKfNkhTJZLOD0AGD6SP/FCBGvGHk=;
 b=NayJo1KCMoNVaYOIx9I5l7j8EySRej6cSL/Im+hfmNeWbob2wAp+uMK57YrZkPSSm6oTn01zEL03Ft2rn/ZnarHVegQx5GHzGh2AUQMiBMMwrVHEE7KQDr8r4/ttDC/caFngHEY486wGI9T+Of14OZlKYKNoPB/XmPkmeRLTx7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 03:57:05 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%6]) with mapi id 15.20.8699.024; Wed, 7 May 2025
 03:57:05 +0000
Message-ID: <52e41530-f93a-4fed-8229-ead4e806a5ec@amd.com>
Date: Wed, 7 May 2025 09:26:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] x86/x2apic-savic: Expose
 x2apic_savic_update_vector()
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 yuehaibing@huawei.com, kvijayab@amd.com, jacob.jun.pan@linux.intel.com,
 jpoimboe@kernel.org, tiala@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250506130712.156583-1-ltykernel@gmail.com>
 <20250506130712.156583-3-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250506130712.156583-3-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: e655a674-5822-4895-d665-08dd8d1b3abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdyaGJTdGdDMmJDUVpNZVpmcHE4VWo5OFV5SWxNa1VMQ2dDRVkwc3lYRTZy?=
 =?utf-8?B?YjAydDliK0ZXdU9JT1laUWFHcXRFanI2ek5nTDh2anJOS0Y1dGdJWkc5dW5n?=
 =?utf-8?B?ZEJEVFVQUGcxaUVtRnYzQk0vRzZyRW9xWXVEOUFIVjlkV2JLK1QwbkErZ0J4?=
 =?utf-8?B?eUw5WVpWbnQwbHhLZTQ5Skx6YjZnMWduODNVRHN6LzAvWmNtSmRVS0c5S3lB?=
 =?utf-8?B?YTRZa2ZQVFF5STFIR2FldkdHaUpSdlFhNjdXUUVaVzNHVGdLeVRpcE40cjhV?=
 =?utf-8?B?cGttRW1IdTlTMW5UV3Bhc1RWN0JNMVEwWlhZMEFNei8zZkNPdmdhbTdwS0tR?=
 =?utf-8?B?eGROdFk0UUg1TjBRYVNQRnpYQW1udExqL0w3d24xVnNSb01qS1ZaVWNHQUVt?=
 =?utf-8?B?T2FhSDFzd1NBUzdzcXlrZ21CMFg2SVlxVFdmNldxSmN5RU1qQWRnZHczS2lv?=
 =?utf-8?B?MDg4RXRadnloa2tvYUVLcEpQcEFyajZDcTMzSGVZbndaQUwrc2p6dkZqcVdh?=
 =?utf-8?B?STRUNHBqbUIvZ1FRN1FiZ0p1bGwzSDljNXdhVDZIQmY2aitVa1hHNHRXWXVR?=
 =?utf-8?B?ZU5VQ3ZzbDd2UFRZWXB1K091anFsVU5rSk51OTJxMmVoVmVhWFFrTGY0aUI2?=
 =?utf-8?B?a0pDNWxxUXMvcUZNdVJ4cktDVHJEOUhUMUFXWGZsU3ZlR2tYcDhOQXQvangr?=
 =?utf-8?B?K2FwK2p1ajNVQ0tyOFlORVZlNmJOeGp6bkpraHBpajlQcS9pMUtCL3RLbkdk?=
 =?utf-8?B?YXl0RzNTTzFYVlFJMzFkbkdSSHRDRzFwUzZJNXdETklLTXZsOGowNXFCQ0RV?=
 =?utf-8?B?Q2Zqbjdjc0MwRDdwai9EeFJ5QXdEaU9RWCtEeHQxZUxDOFBqRXFxV1JBRFlw?=
 =?utf-8?B?YmRQU0o1bk1GSUoycE5mUldrL2dXbWpJL1FQdXlseS9GK1hXOXg0WDhMdm5F?=
 =?utf-8?B?bmJrdk9iR1gvL05hWVZWYXk5ODhWWWY0MEFzMGpNUlVWeUtUdXlUMzFHNmRJ?=
 =?utf-8?B?Y3hoWlBudktBNUpRV0pxQnQ0azhuanRCRkZ2V2pkZmFPTHZLdlg0aEppMkZ1?=
 =?utf-8?B?eHZrVXBjZXFyQm1CMGdoL2NqLzQyQzlGdm5CdTFqbC9BQmd4VHp5blVHK2ZX?=
 =?utf-8?B?b3EyV3B3VDZtVllCaUM3K3A2Q3FKaU5hcEI2d3JmamN1R3NLaDJFdldlczEy?=
 =?utf-8?B?QW1hVVljalh1aC9QM0dtczduMXM1dTN3cHFSa1BBcXpJNGFSWUNOYXhZQWxh?=
 =?utf-8?B?YjBlbEZLY3NrUXBMQ2hzdWhwdVpuV2dVRG1ieFJmV2t1YlBHSGRtaVRPVkgr?=
 =?utf-8?B?RU5wNXF5K1FOTjkvb0IvWGhpRFFnODdOY2h2a2lTTW9rUUs0Z2JqR0t6dG1M?=
 =?utf-8?B?VnZ0SzhjRTFNbitoNDlSajhibk85M29kSjZXdXdPbHc3UTZGWFJubk1VYVAy?=
 =?utf-8?B?dCsvTjFLd2FRSUVzZTlLMTkrWmc3M3hJblFrQ3FWOGJQWXFTODZxSXVFWXNh?=
 =?utf-8?B?ZnMyMHF4dUROa0xsNk45NnFUQnJ2cnI4Um5GQThkZGV3TnF6ck1pU1A3OXdw?=
 =?utf-8?B?TExIMTBVcXQ2elZKd1VTcEljRUhqMTg1VkM1K3owQmtmbHl6TW9kZmhiSnNR?=
 =?utf-8?B?TjNyamlHeGNic0FBYmJ3b211djlRaUtaSEs0R2UvbS9hczcrK1plaTUyNUNI?=
 =?utf-8?B?OTl1c0NrMHRMaHlXT0p0dVBVa1FrSHUyTnBiMWM5N0dBOG92M2JVM3F4c1U0?=
 =?utf-8?B?V1pnNXBycTlzOFRUUlppY3g4bE5YUFFRcm5DMFI3QVlKOEovY0REUWNLRG9h?=
 =?utf-8?B?cHBqUG9NMERETmtINzE4SUFxOEY1K3V2cWRZOTdyWmk0TlFJUHlLZDdLWW03?=
 =?utf-8?B?c3haQVZTMWVVVEpqdUFkZVJHZDh2YWJyZXFPcFRFdDB2blIrdHJpZHI5cGFi?=
 =?utf-8?B?dUZmcTZQTWZob2xacWozUG1JcnRLdUJyNHFHSlRMc01UZTJkdUV2UWJLWmZU?=
 =?utf-8?B?Qi82YmJJdWd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW0vODVCZGtRdVl1NkRuUTBpYUNqVnN0aU93NituekxldUJmVVNxK1plV05F?=
 =?utf-8?B?Qjdra3ByK3JsYTBTRVFGVWhPdTBwNnp4bXFXckhoak92bU5wWFJsZHdEVmlk?=
 =?utf-8?B?THFYeFZxR0pjY2c2Z1J1bDdWUmlQVWJ1MXFZdnRVNk1SaENUTkJpTVN6OXJB?=
 =?utf-8?B?ZU12a3g4eThiNHhMb2RZMjltZENzZnU4T0I2aUtvbkY4VWVjcTZlUFo2M3Yv?=
 =?utf-8?B?K21tSC9sQlh2L2pkeHNUUVJZWHI3R3RxZDlFZGl1RjJMZmxVQTZYamZMZUZH?=
 =?utf-8?B?ZlV5VkdNaEV5cHpna0U3VXgrdGJRZ3BkNFZWdXQzRm9XVXdoU1paZWh0YU4y?=
 =?utf-8?B?RDJOQktQWitkQUJzYlN5dnBXNHlaMk11ZW5QU3M1M21yR2tTbUFFQ0E0YlVR?=
 =?utf-8?B?VU1qbEFwS0U2U3ZxaW84a1NrVlFsYmdpNnRCakx5aXZKNVBSZjdudU0vR2R3?=
 =?utf-8?B?NktlbmxvK1JNMmdIUkUwMzJUbkpZV0p1bGpncDUwNnBsMG0wQThGV2tUUldi?=
 =?utf-8?B?YTd1eVpSRDNBT1RIbVNHc1J6VCtXMjBLdkREaHdPN3E3dTJFL1BnRUxSckZT?=
 =?utf-8?B?VGd5eFMwRmpoeW9uekwrWGpTNjZqNU05MlU1NDVRQTFwV1dZZlpqWWhuN0dS?=
 =?utf-8?B?NWRmdEVZSWpBVzdhVk1VNjdURG1lT2JoWWg4bzN1RWNsazllZW9JSWx2REl6?=
 =?utf-8?B?M1BUZWFzZGUrc2hkSmFBRGlxS0VrTU0xWllvb2dGdUNZblJKOWpEZVg0NXIz?=
 =?utf-8?B?eitOa0NHblVhbjc3YksybHNyUVErMm9lN2kra3B6c2dGZTMvTlllZnh0NEMx?=
 =?utf-8?B?N1RLZ3FGMk1sUDd2d2N0Q1BWTGFzajhmN2FUTS9XNDJscEo4a1VYUmk1d3JC?=
 =?utf-8?B?ZlMvUjJad2Z6YTdqNytaQXlLOVpQdjVkOHJjQ09OZmNQZ1FoZ1I4TVhJcjFW?=
 =?utf-8?B?d3J3N2Zqek1DakFFeXJwdG84TTZOOXM5ZUVDTW9sNkNkd21ML3E0Q1UrU2FE?=
 =?utf-8?B?aXVRRUJpQVQ0UnhwcE9UbjJxMHlVOG9RWnZ0NXVEVEJySlFvc3p5T2tqajBj?=
 =?utf-8?B?czNscHo4WXRFaFcza2k5RFhLNWFoanJlb0Y3d0dBeFMxemlyU041RmdJL0Yy?=
 =?utf-8?B?clBka1VOMk1wMTh1QVNmeWlWTW05STZZZ2FVejUxZm1GTm95OCtTOXI0Q2pR?=
 =?utf-8?B?U3NLR0pVUmhTbVI4UzlNNXh3dEVwY3p2K0lHdnFNMUVCbHhvdEp4Z2R0NlNy?=
 =?utf-8?B?UG5pdnk2TVlXL2ZzcWk4ZFpBVWdQYTRlMVFFeGNROUNuZzM5N0JkZDNqdnJG?=
 =?utf-8?B?Z2xvR0JLL1djMkNlSldyd3F5Smw0blVNZTFuaXVIYVpYSG15eEdudW9QdHpT?=
 =?utf-8?B?L0N0elZYckU2TE9vS00zU3g5TENiaUFFeDUzYTFkNXFqMVh4WERxY3EvZTk0?=
 =?utf-8?B?Nkx1b0Q4Sk5WWm0zQWs0SlNwZ3E2bTJtR3lWSG1WSXBXNUxIaUJyajVveXJL?=
 =?utf-8?B?cHhHdFB6b25Kb3pyL0RlUG5CdFIwMTMzNndqQWdMYm56M1NBbjNqaUVGVW5j?=
 =?utf-8?B?Vkl5UnhwTHlWUVd5TWdyQUk3aHVTM2lSMk5aVW1LTVE5WnRJc3NMQkErNWZy?=
 =?utf-8?B?ajZvaEJwV2tVTXJFejY2bmFmVStrWmJPVnRSZitnV1ZYVUVxa2tadTU2VGhK?=
 =?utf-8?B?NWlEQ0h2bUlTOU9KQXhhRE94bzQ1R2wwS0VjZHk1SitJUFFkRk1OUFdaMVE3?=
 =?utf-8?B?U1BtbWEwZkNDL1ZMd0owNWRlcVlUb3lUcGgwdGkxRWV2OUtzd3ExNTlBaGRq?=
 =?utf-8?B?dld0bjM0bkprVStVS2hWU0RjNzZKdm5tOVdaSmdpdU1jMERlNnExcGhIR1R2?=
 =?utf-8?B?aTF1QWlxT2NDaDBHdU9wUHBHeGFPKy9XbTBBRWdQWmcyQW9qaWZsenNYTHBa?=
 =?utf-8?B?ZHhCM2VyMm1lNllaSHc5aDZQRXUwVldoMXVhUi8zbzhtUFZHbG9vZ1EvbDJM?=
 =?utf-8?B?aDFDL2JkUWk0N1kvZXhIaFRiMGdCVjlaczZvcVVUT2hRNWlIWVBnUkxwOS9I?=
 =?utf-8?B?aHFmWkZzbldYMFpyUGdEbTgzajRxQXY2UFNuRThpR3E1bEg4eXJTZlVGMWx5?=
 =?utf-8?Q?8KchPMgy17RIxl0K/wkf0GIbO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e655a674-5822-4895-d665-08dd8d1b3abb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 03:57:05.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TWCNR+5yPcuCtrFhaI7VM/X8QByGAYa0xPnpyMFjw56kVM+qM4kutyuqZ5R3Tsef+hq+n+0eLT5LFmf/jPrvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709



On 5/6/2025 6:37 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Expose x2apic_savic_update_vector() and device driver
> arch code may update AVIC backing page to allow Hyper-V
> inject associated vector.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

I think this new interface is not required. Device driver arch code can call
apic_update_vector() to invoke APIC driver's update_vector() callback. 
Or is it that I am missing something? So, can you explain why this new interface
is needed?



- Neeraj

> ---
>  arch/x86/include/asm/apic.h         | 9 +++++++++
>  arch/x86/kernel/apic/x2apic_savic.c | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 6aa4b8ff08a9..949389e05dd7 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -241,6 +241,15 @@ static inline u64 native_x2apic_icr_read(void)
>  	return val;
>  }
>  
> +#if defined(CONFIG_AMD_SECURE_AVIC)
> +extern void x2apic_savic_update_vector(unsigned int cpu,
> +				unsigned int vector,
> +				bool set);
> +#else
> +static inline void x2apic_savic_update_vector(unsigned int cpu,
> +					      unsigned int vector,								      bool set) { }
> +#endif
> +
>  extern int x2apic_mode;
>  extern int x2apic_phys;
>  extern void __init x2apic_set_max_apicid(u32 apicid);
> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
> index 6284d1f8dac9..0dd7e39931b0 100644
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
> @@ -321,6 +321,14 @@ static void savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
>  	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
>  }
>  
> +void x2apic_savic_update_vector(unsigned int cpu, unsigned int vector, bool set)
> +{
> +	if (!cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		return;
> +
> +	savic_update_vector(cpu, vector, set);
> +}
> +
>  static void init_apic_page(void)
>  {
>  	u32 apic_id;


