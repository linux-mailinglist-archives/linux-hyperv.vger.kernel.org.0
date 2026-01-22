Return-Path: <linux-hyperv+bounces-8471-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPYWCqtxcmlpkwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8471-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:51:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E872D6CB6A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EC903000FF1
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453763876DD;
	Thu, 22 Jan 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wlhjnt9c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1A378D9F;
	Thu, 22 Jan 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107878; cv=fail; b=ivlJpox6hbs+OikaRsRDEEZ9p3BYFNLhtVfkdZJ9anJuX07ewADk6yj2JSoqD5pnD67eWOALmcE+aywL9+t7CvKC2HXD7hvYAOiHd5yw89lshhL6cHdXHUxBPmxM+kmAv9FoBH/Au81mUvD4qidl646I781YEirvBotCd484XrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107878; c=relaxed/simple;
	bh=4aAXlyRHQ6gdeFfJOrxSMVvbriRXrorGcaJri1g26u4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i1T5IdAcBYHCOY4l++h73pqz2NoRHLhYLw9BZZ9pB5KrPvBtCIf9UmrMugfMBzMI/e/cTqO76KhGt2UHNC7ITAdgnOD5apPJkgjF3dKgiRb8i/ZkYm0MjtwjulEndLvQK1PVgH7Hr/SJVsxT+b6wtrEacaJYYnxXgBbJO9V+Hr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wlhjnt9c; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqhZvB0ZUHMmpBvD4WmRr/jX52ZIQ2exhFs04DDYlAk2shjiRl01KpuOlGKkbLZtsLvGgff6P9nCMWu7dTotCQNOztrpwzLkvy8yxhvh3S6KblYClJe/Vgq1a4I+okOCTPRWMRaZg2c/wzrYr4hnzwXB/eNZnXyLB9wk5Wnx1KxtRJVbr70kU9oC80dc9kcB6x9QvWDNkL3V9L+kRyu5k1YMVV13nVvB3xhL4T5/4dM5F+NcA4W7b21vlz8N8F7H9R/G1KXqwhWhVz61N+Wrf4674HezURS/Dof12GaMj+wO6yHtCW7DGCK7oOLJMFXjAtwCaHOjvmxIN1aAILLvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM+WriaYO5JYHF5iZYEicojnT71VIqCy3lJHy+e/sug=;
 b=qfM6RQa3lm4BaAk1yyvLPZ3PnBwUkkUYBKANfxTVIcjjoRGphN+u5hlZELS262pp2/vtE2qZqzohKW5bzjMw7zH1Ql0Qvd5PeLKXSe6vD+EEuF8ID154cnDAX4Q5z09LQZ7NosPX6ug7yG7yBZFNT/IgNCEkDYRhN06MT6k4IApg0PEd/DMlO1hAmdTLkZak0nAh9VMuESlPJuFdEvJgmx21N3rR9B4cuglO8PRuUeQvfPBYDMjfA0uZSIYfv3/O1be7RFa0fzWwgDfyQ2EJFrt0Oph3+Ry8qrG7BeC+o2esSs4uYjaccxzotdxak/Pqnshmk2dpN4Op9XGdsPgoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM+WriaYO5JYHF5iZYEicojnT71VIqCy3lJHy+e/sug=;
 b=Wlhjnt9c4AtZkGk8eRjOIiEjvERVKNwSZVrrUQajVIAUqOv9tq8SYhtHvNnDOEVOJ8/PeCp9zEOL8TTByGut6qY8/tAE4Lv18hruEq7APG90Nhq75ZmT7Mv1s0IotI8jhci6VhLZfsw6nDdmscB+U39Ge9zVDG5CS4aHGpHiSwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 18:50:58 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%4]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 18:50:57 +0000
Message-ID: <cdeb577e-e674-493a-8dfa-d6f547cbaa50@amd.com>
Date: Thu, 22 Jan 2026 10:50:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] net: convert drivers to
 .get_rx_ring_count (last part)
To: Breno Leitao <leitao@debian.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org,
 linux-net-drivers@amd.com, Subbaraya Sundeep <sbhatta@marvell.com>
References: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260122-grxring_big_v4-v2-0-94dbe4dcaa10@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::27) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ccb5cd-23ea-4b1b-ed54-08de59e72dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkNnRHJSR2pBemZ3V3RoSjJOekVQWUJxQWJYT2k2R1JXM3hwSld3SXdsWWUr?=
 =?utf-8?B?MGM0MHBkbTdxcXVid0IrU01HN0NxTnY1UFZybFdQZHNMZ3JKOFFpSXljTXJP?=
 =?utf-8?B?azV3NWxhV1IxTmt2VlhvMXBQK1hvRDRYelZHN3VKeHZEbkVXaTQ5cDJ4VWk0?=
 =?utf-8?B?ZS9icklIc0RuNllWd0pFR3hvSk4rc0FjR1UzU25qSGl1MHlrTTlpOHp4U21M?=
 =?utf-8?B?MWlBdDF3TURDdGpJbWJsNTRmRkRVejFEeTkwdjAxL0FiUUVHUjQwb1hsRGpu?=
 =?utf-8?B?L1hTL3J5U05GSkxvV2VBL005MnpUUmJoRDdxMFU2WUIvOUl2YnRLbWpsT0V5?=
 =?utf-8?B?V2xkeERldWYrYlBvNEZxSGpvOFBwR0V6d3luTXJZQjhkQTY5RWF2ZEs4TmIx?=
 =?utf-8?B?UmlvanQxQ3hSQkVGS3ZneHd1ZURqczRNSXJRbmdxd0RDYWJZMkIvdkR5VVdY?=
 =?utf-8?B?eVBYNFp2QnFSQUFkRzY1Z2pzTDlwdGYzU3lFRitva2p2WXdzTFpCTlZPSEs0?=
 =?utf-8?B?eTNqUlUxTnJrOVB4R3BQSTdBR2JoUTZWL2gxL3NyRng0aDZkSWkvTUU0b0d3?=
 =?utf-8?B?NXJNc0UvSmNCRUJmaEY5TXk1aGpQOVEvNlU3Qk1uQkhyM2g4MUVtL0hNRE13?=
 =?utf-8?B?L2FSVFVrYncvWk42YXRjRURmTXVyUzk2K2FnOVl3MXVFWUlrQU90czJGSU0r?=
 =?utf-8?B?ekh2VjNjWjUrLzNyREcxT0E1bFptM2VrZ0JTb2J2V3R5ekxuTGJPRCtHbEpy?=
 =?utf-8?B?YXFQQTBycDgyUm9lbXVsUWF2UEE4UEIvR2lQdTVRaHhVQis0QlpVYVEyVmVK?=
 =?utf-8?B?dGhoTFgzbEpiUXZUTnV0eGROTHFuc05VQkJPMlFwSi84WVlKQUVKVUswRWlG?=
 =?utf-8?B?d040cTZ2OXF5dWlDaE40dFFrUWlzWlM3dTRyNnF3K3pvUUNydWx1aXNIYlZM?=
 =?utf-8?B?bUh5NE41cmpLYm1mTUZjTXJwYTE3Zy9SSjlzN2llb2dMeFpKYXpMUkU2dEZ2?=
 =?utf-8?B?aUVjTGtJQm5DMUZUbUNvcFl3cHBaU1oxMm1ZL2ZzUjZHWExaUUY1S3dWSVlJ?=
 =?utf-8?B?MDJ6ejd1MHMzaUxXRTRVU0VQWG1TL3RQeWEwdlhvOXY0TXo1dXZYMUs4TVg4?=
 =?utf-8?B?YmJBVlZqcFU1czcwbUVGaEpHbXFoNExTaDNSOGZHS2xuc0NGdUdzRThjdXkv?=
 =?utf-8?B?RGZCbzQyWjNoQ0hKREN1NnQxcUpvRVJwNER4aC90T2lhTW8vaUVwejEzb2xX?=
 =?utf-8?B?dDM4TmVZcG1Bdkp4VnNzUE83YXcycHo2RVRmL1J3bjh2YXJuaXROeU5RS2I3?=
 =?utf-8?B?cXoxd04wbU0rSWRzUUZBTUNsTXFhQzNaNGtRRVlGU05obkJSbVpCTWZLOG1J?=
 =?utf-8?B?S1c1WEFCQk80YlR1Z2lFdngzWVZJRGhONTlxVDlKek5OTFJWWVNnM3dCTmxa?=
 =?utf-8?B?bUpNT0x3ckFVcU8zZThkK3pyOVRuaFBQaEVKa0lxRUpPbG5nTEpkcEVOaitQ?=
 =?utf-8?B?VXZ1QTljeDlVaEF3R1Facjc3Y0ZmNjRrN0RpYTRnRW0vTmpvc25LdnFuc3k2?=
 =?utf-8?B?R3JCNEZHeHoxQmpWUWhzQnEvVHJ2L0lMb0lteXdZa0F0WkpYWnZYZHhSaEM3?=
 =?utf-8?B?Y05GKzlKMWNndGtuTDFVZndOdXIrVlNhTi9Ic0xhSFJMQUJSRmQxeHYxcjJw?=
 =?utf-8?B?L01nM0RhSzhJVlBoVWw2djdaTnBkYkxPMWlXaDUralEwUFdZRXVzZ3pZT0ZW?=
 =?utf-8?B?aVY1bWd1dVZTb2ZHWm95MkQxWW5XeW9FcHRVR1YvWlVDSGFrNTRvbzhSZ0tD?=
 =?utf-8?B?YmYyQ2hhazVlTUZBRXlrYUg0SmxpYnE0TmJnWkJDT2FUcEFSSDBPTXlqMS9t?=
 =?utf-8?B?RUliZ3RlRExuOUpKR2t2bDY4c1ZwR1VmajhpT0VjekU4ODNOOVcrcGJVOG5h?=
 =?utf-8?B?WkpqUWVra1QwaWYwR3d5SHdJVlFDUS9aVnhmZXpveVZYNHh4dmNCM3dKeGUy?=
 =?utf-8?B?cU44aXhGMnNtcnZDVEVsaS83eE5XaWVPVmFLdnY5cjZCODdxYXNRVVZ6akxE?=
 =?utf-8?B?eVVTVnRCUEEyMnpHdm9yWVM3MENrbUc5RDVuWXc3YlVwTU1JK0l3eitaOGlZ?=
 =?utf-8?Q?7UuRLcgsqrbsBZCEhqZ/jQeBy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHBvOHdGRXAwK1JtN2k1L0NaYTNnZU5IbFVEemVEL09tMEdHeENZSERmRlBR?=
 =?utf-8?B?YmRvNG4ydkFYRUJvTzVsZGRPU0x6TjllYTQ1TU5ycTZ1NC9wNC9zTytiakNl?=
 =?utf-8?B?WVBGdW5rczN1UTl6YWRzVkNmdlhEbEQwS3dhVjc5czhXeWcwRktRNTdaUXMz?=
 =?utf-8?B?T0NlRXZnd05oQ28vc3N0MENBV2pnYnhwS2FtVTlLMTkwUVY1dzVoS3YyYnlD?=
 =?utf-8?B?RWdZeUlQTndZYVc5QWg5MWJESEZwY012ZkFBbExKVEdPa2xrSzJMU1ErTDRy?=
 =?utf-8?B?TXkzSVZLVDVPZ0VpeXFNMGozRTNvRit4Tjc2MlJDb2VFVGdIMTAxeW9Ob056?=
 =?utf-8?B?MWMzUHVkOHpyN3Y0UVVSQTQvTUJJTnM3bDlpbW11Z3BOaWh2YjJ2TzBkUkQ0?=
 =?utf-8?B?ZEoveFNDdHprREx1VnRSekwybFpDYnRUNkl1OS84b3RXQnJ1cTc3VFRUMWh5?=
 =?utf-8?B?MlhHVzhlQnFONFFyaFJacSt0dTZXaVpmTG1Od2ZwOHdiUXVTZW8wYStleEZm?=
 =?utf-8?B?VkhOL2hxUHJ0VEg3VE4zZVdVRThLRXZ3NDVWemlJZUxBd3NDSlhIbXB6WTdT?=
 =?utf-8?B?TFhBOEpQS3VtWXVmSVhNdytnenhmQll2dEZEYk9CTmxCUkRacDhQMlJqVy8y?=
 =?utf-8?B?RkRNQlcwUndrUmgzSGIza2lzOVEraDVQNWpiSUlCMm9oVERKRkFkekc4cmtJ?=
 =?utf-8?B?czFJbjhvSTFlMzdZcHArOGVScnhKNlFGSVBvMU5yU3dKby84aEV4K1FMdXFu?=
 =?utf-8?B?d1RZcHRQYWJtQ0VOWGN5clhzYzIvdkp2d1lHZ09McjNmMEZyTCtMbUd0VHMz?=
 =?utf-8?B?UkRBc1VuWHpXYXc3eDdRK1BDSDZTNlcwQVVyY2YwRWdERkhzTVloVFdDSDlN?=
 =?utf-8?B?dXM3ZVMwTmtBWDU5Y2JXQVV1TXp0ZkZhaXJTRzRLRVk5MGk5bi85OEJjVHJJ?=
 =?utf-8?B?dXUrZ1Vzc0RzaHNFckNzM3hrZ2tJL204OFFRaW45UERKOGp4M0xWZHZGckRJ?=
 =?utf-8?B?WWdNMEozVWE5MG1Vejk1SVhQL0YwTmZhYkdIaVV0aExNSHJ1NXVDd291ZzE1?=
 =?utf-8?B?NkVOczFqQ1E3Wkd2MUZES082SER6bVIyTjE5NmtOL2E1U2cvcHFKQXVkSC9F?=
 =?utf-8?B?dkdYOWFYNnFKWjZCRlVvclF3VzZ4QUI4NGJFZGRFb0hyUkxjRDRmMXRkN0pY?=
 =?utf-8?B?UnFpOTlLcER3SEhhOUNZNXE0eUd5YXZ1cW9zWmVCeDdiWm1VeWdSaUhyd1pB?=
 =?utf-8?B?Z25hMDZ6Y1BKN0hqdGUwLzBaemJEVVRVb2g4MWtrK0FtS2JIZE5LRlpHbXhH?=
 =?utf-8?B?TU5TeEp3R1Jwd29TVC9mSXNqUmFnenhMTGpFYnE2dUNhY3ZlMnB0SEx1K1NU?=
 =?utf-8?B?SkJPUUVPS01QSURvMmtmSUpDZGMzZUVxajdFUDFMWEE0SGxTMjlFai80WlRQ?=
 =?utf-8?B?YmMvSXZVYTdWSWdkM0wyaHF6L09TaWxJMUx6ZzJENG1vTkttM0tQeVdxMjho?=
 =?utf-8?B?OWc4eGM0V1F5c2tMZVhJTFN6TjNiSEJBaSsvZVovU0JBRGJtWmdsMGhtUUV6?=
 =?utf-8?B?U1ZEd0pBcldGRkl5cHhTa0pOK1p5d3g4M2h0bWZDeW9ZUzVQVVdkQW5zWVF3?=
 =?utf-8?B?T1FVU0RUSHNIVHMxSnJhcDdLVzcrQWdnODcyZ2lYOGZ1WGVGbGszSk15YmFj?=
 =?utf-8?B?RFEwWEhXYUlJQkpkWHliajR3Y1BsZzB2emdHTE5IV1Y4MHJPNmZqUE5yRDNm?=
 =?utf-8?B?OUtUQVp5MlJiMzE2L1A3VDdlckJpNWlMTkVsRTFLMmFaeVFEbDlqajc4WE5w?=
 =?utf-8?B?WTMvRjNBd3F3Zmw1TC9xdzZmOEhFTGFSaFVEWTBrWWczRndrMzBzM25tMjFD?=
 =?utf-8?B?Sm5YWXBPNS8zQlZJNks0Vk5wcUxFR29tbnEza0R2b1hjUTdOaVB6b0JJOGZV?=
 =?utf-8?B?b25PcE94OGxjT3dtSVhvMko3bzc2NHBCeUJJbGRoUFZKZ3R2WlRYVzF3Z0lo?=
 =?utf-8?B?MCt2N1Bib0dCQ0dLSmt3M1NDRG9FR2R1Wkl6L0pyay91cllBUnFadGd5VVNY?=
 =?utf-8?B?eEMwTXMxOWtnbzVwMm5nZ0drN0hVUTg1elQwWWd0WDV3NGxmZG5VU0VQRTZD?=
 =?utf-8?B?WUlSTHVyd0dBdXM5ZmNWTWxLUFlvTk5GdDBUNTVrb3RhaEVCd3lFcHFMczNB?=
 =?utf-8?B?V2h6QnpqWWVXWExFOTIxSmE3WkVkL3Y5VC9wMkpLUGFEUHVFMFZIbmFOdk8v?=
 =?utf-8?B?THdVMWdsYUhGdUhWTlluSUtrbnJQcXllODlWTWhtMkFZMlVIRTlsUGRuNmlR?=
 =?utf-8?B?OEFiZFV3Nm8xeFRJL0RQM2x5ekU1VmV5b0ZSR3JXaERsOE9LUGJxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ccb5cd-23ea-4b1b-ed54-08de59e72dd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 18:50:57.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2kMLJ8N6640q9Tg+/B/aFWRHrOZeAMUd/uGFdOyfuqfnATRMt2rbZ4WgWgP8eNeir6gRou9TpNNHqxLUd3l/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8471-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[debian.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: E872D6CB6A
X-Rspamd-Action: no action

On 1/22/2026 10:40 AM, Breno Leitao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
>
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
>
> This simplifies the RX ring count retrieval and aligns the following
> drivers with the new ethtool API for querying RX ring parameters.
>
>   * sfc
>   * ionic
>   * sfc/siena
>   * sfc/ef100
>   * fbnic
>   * mana
>   * nfp
>   * atlantic
>   * benet (this is v2 in fact, where v1 had some discussions that
>     required a v2). See link [0]
>
> Link: https://lore.kernel.org/all/20260119094514.5b12a097@kernel.org/ [0]
>
> This is covering the last drivers, and as soon as this lands, I will
> change the ethtool framework to avoid calling .get_rx_ring_count for
> ETHTOOL_GRXRINGS, simplifying the ethtool core framework.
>
> Part 1 is already merged in net-next and can be seen in
> https://lore.kernel.org/all/20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org/
>
> Part 2 is already merged in net-next except benet driver, which is now included
> in here
> https://lore.kernel.org/all/20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org/
>
> PS: all of these change were compile-tested only.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
> - Respect reverse xmas tree in Atlantic driver (Brett Creeley)
> - Link to v1: https://patch.msgid.link/20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org
>
> ---
> Breno Leitao (9):
>        net: benet: convert to use .get_rx_ring_count
>        net: atlantic: convert to use .get_rx_ring_count
>        net: nfp: convert to use .get_rx_ring_count
>        net: mana: convert to use .get_rx_ring_count
>        net: fbnic: convert to use .get_rx_ring_count
>        net: ionic: convert to use .get_rx_ring_count
>        net: sfc: efx: convert to use .get_rx_ring_count
>        net: sfc: siena: convert to use .get_rx_ring_count
>        net: sfc: falcon: convert to use .get_rx_ring_count
>
>   .../net/ethernet/aquantia/atlantic/aq_ethtool.c    | 18 +++++++----
>   drivers/net/ethernet/emulex/benet/be_ethtool.c     | 37 ++++++++--------------
>   drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    | 12 ++++---
>   drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 ++------
>   .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 11 +++++--
>   .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 18 ++---------
>   drivers/net/ethernet/sfc/ef100_ethtool.c           |  1 +
>   drivers/net/ethernet/sfc/ethtool.c                 |  1 +
>   drivers/net/ethernet/sfc/ethtool_common.c          | 11 ++++---
>   drivers/net/ethernet/sfc/ethtool_common.h          |  1 +
>   drivers/net/ethernet/sfc/falcon/ethtool.c          | 12 ++++---
>   drivers/net/ethernet/sfc/siena/ethtool.c           |  1 +
>   drivers/net/ethernet/sfc/siena/ethtool_common.c    | 11 ++++---
>   drivers/net/ethernet/sfc/siena/ethtool_common.h    |  1 +
>   14 files changed, 75 insertions(+), 73 deletions(-)
> ---
> base-commit: d8f87aa5fa0a4276491fa8ef436cd22605a3f9ba
> change-id: 20260121-grxring_big_v4-55037f9e001e
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>

Entire series LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>


