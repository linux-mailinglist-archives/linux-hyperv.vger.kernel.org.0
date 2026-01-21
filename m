Return-Path: <linux-hyperv+bounces-8416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKZbER0ZcWmodQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8416-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:21:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E18775B31E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B641C62E357
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB73A35B9;
	Wed, 21 Jan 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gs3PyHrJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA6397ABB;
	Wed, 21 Jan 2026 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014170; cv=fail; b=ptsYPMKFuTxrfjnpwPo8pbsZlnvFd+vBAfys1WQYjvP8fFeTm/nHGLFvZzZfDphXwgDni90Fa8Is3/UqIfS0xxjNWT96C7hRYq0tVsgbX3Zq1ho9s9mf424HtioOdIBo/ws2egdmHuJDh6w+Jzf05rQQqS6IQoOpkvHPzjN82xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014170; c=relaxed/simple;
	bh=/jUSNX99l+X4I8FiCRJQmYBFU5PolTacXM8k6tjdtNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tKuQjNhlkzCF8b3Klq7V4i0LGzX3vPz8vQ/F4sz7fTGUmsAekVEh8ehH752C6Cp25h2ppfVtzUQSjRmKVMUaY4GhwQv4g1NuRkfkP8vPt/yrP8aYrV9IjkSFkU1DBypAr8JAX/DQTlirjmPMXnKQY4bY1vcBnMLY17Ubn6Nly7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gs3PyHrJ; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrfgBfU5HrCBYbHeXu2gt1Abn5+0nBZxThPjfqyUak5GO+e8NIelDnc7R84fmUZb1+mNz/PGaqHJkGO8yCtBXSs7Z7aLmJpv/RIPoiV2jjJ1jHCSa6nZ/ypZi7vQ0qfoFugvhd7iYdAW7l+IC32ySUgxMwVkR58XOChHRuhHhCvwPE97GBKHAaOoxbVIahhPKV2CbV2rPsxzS8Taf5B1PYlCMy4fB5LXSHAUQJqvYfKlTOYX11gXis7tg/HwWEyfDbi3lbSXvWhKttcDyiCx7uFF9UD/Bu9gPw/5PiwsuVBsQ5ZlmL9i9EtHb9Eq45mY8wwwuRYFFmMRlhZUtnswtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZCqxqY/zfM3qLfWMT47rl8oOw7lbVp9FlXzYKhzKOE=;
 b=F+PvWV6k4Nz3d12ESth6RGmyNVYC4Nkow//wHKgVW7M8CLgSzkhgiibVagbhxE/ELlPgG0kD4yfj82G11uJwCnHEZ96qv4dBC/wKUHfXSJcTNhxKwPGNxXxhA2duYsGLGghVp1jTGVZG70W3fhA3v2MIG6KrMxGzurt4TDtite/KBwIRR8XqBlTWRZpbAA3qzBtxT5wXqfs31TkbTygucdMFcu0FjGgDe71NJgwHE0phfm1LlTvHx9BZGzbaISPJPdAFLuh8bLl26ibp8m59e3oedHr5i3AUqocZbWUZpw4nwfqTLbFakZdDMRYEQXWCQB1GITdB3tRUV1PYe/xTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZCqxqY/zfM3qLfWMT47rl8oOw7lbVp9FlXzYKhzKOE=;
 b=gs3PyHrJnEc4FW2j/B1QOL6uL00eWbwxhCsbJ6Hbxv63x9pfuktSHqxRB2FFZ81zSSWwwOFqj7jPfe23Ff1irTBoWsPop4c77ETcrTyLj/p1Zu7ug7oI5SrUpiv3KZSUqeeSp+6lXrM+1at2YcmNemlMJrFbdvQI1VloiBi5LPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 16:49:26 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::4eda:ca5:8634:5b27%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:49:26 +0000
Message-ID: <4daf0901-20a6-4c9b-9b56-32efef24e5e5@amd.com>
Date: Wed, 21 Jan 2026 08:49:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] net: atlantic: convert to use
 .get_rx_ring_count
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
 linux-net-drivers@amd.com
References: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
 <20260121-grxring_big_v4-v1-2-07655be56bcf@debian.org>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20260121-grxring_big_v4-v1-2-07655be56bcf@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ca92d9-d757-44eb-6dd0-08de590d0944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEtuSzQ3bXZSRzBZVEVWcEdxODM5UUs1TCtYU0w4Z1lxZEFNZWNFMDVuM0la?=
 =?utf-8?B?WVFPbXN6WFNCS201TEdwRlVpdUVHYmJQcmVKZ1o3c28zRncyT0lxZ3pkNFV2?=
 =?utf-8?B?b3hKdlRvK0pqUklYMitVMkE3L3hQK0hVTU9vRVRMK0I3cXhnT2VOdmNkeGor?=
 =?utf-8?B?cnRDYWIrMnVKSFkrTURBTzlRMEtSY2MxUmh4VE9YUmcwQkxhRFMvVWN5UldB?=
 =?utf-8?B?QWtTY1lCVHRLbVJxNWQ1MDl2RW9zY1BYWnVqMXlRb0dKQnBmc01SSTNWZ3lZ?=
 =?utf-8?B?S0hqTG8rOHp0U1RscGFiWVVNQXN0cVUzc2lrMDFlTVV6NU9EQjN5RW1CM21z?=
 =?utf-8?B?QjZENHhoWmR4aGE2YVIvY0p1V0ovK09iK25pWXdqSXJSVVhNQ0xQWnE1MTV2?=
 =?utf-8?B?ZmdzR1AraDltTGhFWjhldDdnOWlDQUdObk1SSk54Qlg1OVFTRlhmUVRnaU5U?=
 =?utf-8?B?RzNEOG1jYzRnMHhsbktTbVU5S0g5cHBBNnNUZmxKRGhVQzIzdGNyak45VEhi?=
 =?utf-8?B?WDBlUk9RY2IzUE1ObHdTcXNyNXVLR1Y3MkNRQTNET3F2M2RGZTd1b1RTR3gx?=
 =?utf-8?B?TXdCMURjcytYdDRVU3F2THJ6bUtEcEI4MFV4ajZ0RUpLT1g0WEgxdVByOU1i?=
 =?utf-8?B?bDVpeWZReFIvdWxvRDNQQ1puN1p1Y2JkcWxmSUVDbDl4Z3psUkRXSnBlcDZq?=
 =?utf-8?B?Tml6UXFpeDZOWmxoQStDYkNtWThuSnZRd1BqZ3F3R1huMVo5Qkw2ZTBXM1pB?=
 =?utf-8?B?QjNpaHp0QnA0OG5idExUb0VGQmZHREVHWWtTaEdzNG5CVVhXZXVnRDdDOU5D?=
 =?utf-8?B?K0lMeUZ5Y1RqR05sYkJFSW9qaXhNbTQySjlucmRKQkduNlBzM053L2dPM0VT?=
 =?utf-8?B?N3hWNElsWFJhSlNHWXpKeG9QWHJUWTIzeVVKVGNxbnIzVm9PZ0t1WGlQQVpM?=
 =?utf-8?B?ZGY2Vk1UNnJiYThMSmxMcEgxL1VTSDhQeXBVdjU0eEk1d0kyTnNURWpSODhq?=
 =?utf-8?B?eG5POWd0akdESSt5Vk9OaGRldmpuYUt1ZUoySWZOcDdVbTJFTXZUM3dHS3RX?=
 =?utf-8?B?RnR1cVZ1WC9kenBkczc1R1ZZcWtpdjNOZ0tYcnprKzJJcTdKRWE4Njl4Mmtz?=
 =?utf-8?B?WnhZTDExNDk0VkJ1Q1BJKzJTcWIzWFhKTnNzV0dmY1hVWVFhNFcwNXRoQWtX?=
 =?utf-8?B?cmdGVDFNQ0J1MnFIY1dyNTdvV3pWTVl2RFovazc5ME9kMHdRUWtNdWhNZVFv?=
 =?utf-8?B?bmxyTFFYMVhBRWk5OGFxTTUvT0wxNit1cGtpSDh0d1VEMjhSN3FwM0F6TWha?=
 =?utf-8?B?aytqSTU4SFc0SEhVK0ZNYmh6QkdwTXlBQ0JkVjcvWnR6RUJEcWtiaGN6YURm?=
 =?utf-8?B?czNwYmlOT3RPK05Oelp3L3pVMFhibUJiUUpsSkpKR0xOR1VIcVRyQldsZDNo?=
 =?utf-8?B?WE9UQkZ4T2t2SERDbW9IOUZhcWl4LzF1d0lEc3JLMno3YmlwZ21NT3dzRWs3?=
 =?utf-8?B?VFdxdXFXcC84dE5mTTg5cGxuZzQ5VEVwQm1qc0xoeHRiMXNGZkF4dTIrS1B0?=
 =?utf-8?B?WkdyMDJON1MrdlRkOUtPZXJId012UzlkWU5Zc2lseFllRGcwK0tIN2xNSUxz?=
 =?utf-8?B?SWdhbmdDZ3lIenhmVTB5bzFLRVo1SzFrRzBmR0N4S2tVb0NZaHcrUC9ER0dw?=
 =?utf-8?B?OEQwRzJMenJiNzFrR1pHb0lCQ2dTUDVtcG1Cc0Z1N0MveC9lNkZ2ZWpsSG5y?=
 =?utf-8?B?RmxzRlhWY3pvdGdZdVJ5RGxCQUpLY0tkUURhdi95UjlZMkE5aWJtbTlWVzkr?=
 =?utf-8?B?VG9kRW5VRFVTNzJQUmJCUUViM0dDQ3ZtcWxQN2RIM3Ivc0dKdnJZVm5lb1NO?=
 =?utf-8?B?anUvV2FlaUtGOEtneklVL3g3a0Z4ME9DQXEvdzhOem9pd2FHa2hXczlDOXh6?=
 =?utf-8?B?TUIzYlNqS0FCMVdRTmtaeTBqWVRxTFYyekRJeFlhZVZ0SFBRbWsyQjRkd3Ir?=
 =?utf-8?B?dXlnTkU3RHV1bVMrbytVV25JZ3cvak5PY3k3VDZBQjBKK3ZzQU5hZDM1SzBM?=
 =?utf-8?B?TEhKYW1EYlg1T1YwYm5vZFlsWmo4MkRid1FLL0hYblRjdU1ETGt5QWdqcUxp?=
 =?utf-8?B?WUFzOWN1UVp4MXlnaHhBNnM1NldhR0UwWWRsZUhrUWFVSmhRcGdUVzZLRkhJ?=
 =?utf-8?B?U1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjBvMnN4Y3dhak9YTGE0YS9yV1dyVElBSU5PQ3I1MFd3WlJjL3dDaVllRGxZ?=
 =?utf-8?B?azF4ZGVkMUxRWkhjczFtZWxrYWdBZHA1di9HdytoNXRHcmRKV3NFWlVHWTRO?=
 =?utf-8?B?YzR6TTJlQ1NhNEFyL0RZRzR5Z2lzSllpalJVSFlHYzFwWUdUOFBiYnRpWUUr?=
 =?utf-8?B?OTNidXEwZlU5Z2UzR0Qvc3lMWEgrRUt0bEYwaGJjTmtGaVdoQ0I1MWYzYUs4?=
 =?utf-8?B?WEVvRkw3RkZVUXVYZnFrWHRhclR5b3ROOHFCbU9qUWlLc2wxM3U2aGJNR0Uw?=
 =?utf-8?B?WVdnZWxFL1ZIemdUeGlaUXJxbDBqbm1HWHk1OTl1eVROdWVlNEN5UGo1cE5X?=
 =?utf-8?B?cGcxa1llcUN2MHVxellqMjk5TGR6WmZSME4zeHdCK2RycEhEbkxZcGE0ZC82?=
 =?utf-8?B?VWpmT21lcnExMm5vZFdmblFwd2VucWJnN0JsMXZGalpDUmNhZDFjWmFlWEJi?=
 =?utf-8?B?cTk4MkRLNHc3MHRGZXBWQ25DZVFOWnF0ZWxMQVhhT1Bid3dnczZVM0V1dGpk?=
 =?utf-8?B?ZlNqVnF6OVZnbU9INjFpeC85d2RqcVp1Yno3Q2pYVFRUSllaUWtyTVhRYkxB?=
 =?utf-8?B?SDVQOTZ2aHoyMi93L20velJhZmZEV0kvVFZLNmwvMnJPU3pnOEo1QXpST04x?=
 =?utf-8?B?cGxqaERWcDZXVjBYem1oRTVwWWo3OUl2YkwyV1g5cTFoZVJ5SUpBSGRhbUJ4?=
 =?utf-8?B?TjFMTWlMNk9udjN3SFVXM0QyN0RPQWhFVkFIa3BENUU0VXNVTzkvNmtWUlVJ?=
 =?utf-8?B?M3FpYm93MGNmVStuOFhBdGxIQ0VLaDkraWVnbUZKSDZWNVhOTUU0YkYrK1k1?=
 =?utf-8?B?bzJlNDhwR1pXTmFjcWxqUUVDcmczTytET1RSbElmdWYyTFRPdXloOXJBaFdh?=
 =?utf-8?B?c3NNYXcxLzN3RnFDK0lheFp3Ky9zV1BIQ2dBMlViaUxyVGk0M3VXVng5MCsw?=
 =?utf-8?B?cERod1pJVmV1b0RKU2V4MWtXWDBWUlV0WHZUc0lGVjVwbzdDeGhOMGczcDRL?=
 =?utf-8?B?UzBPcFFxclhQd3FmWlE2RU82UkhQdGhDMitOVGpVRytHUnk1RlVrdDJ2YUhE?=
 =?utf-8?B?T0pEVlFpOWhvMno0MTlFZFl4VzlWaHUxSWRhQ3Z6R3IvUmRGMW1CRlBEUGpq?=
 =?utf-8?B?VnkyUE55SVluQlNuMVNJWVExUXFvVzBoSWkrQ3hSTUlQaEdPWk5VTFJBU0tT?=
 =?utf-8?B?TjRFQ0VhZDN2MTNoaWMxbDFpNGltUENCQWNlRjBGczdTZUtQMnFpZGJEQ0cv?=
 =?utf-8?B?bWp0VzF6OXovQ0JzRm5iQzhUUnh1bkVCdG9QV0tqWU9LRW1KMSt1TDJ2VWFY?=
 =?utf-8?B?M1FBRGxXc09PeHJNanpwT0JzT2YyMExJQ3JscFNhL25NeTFLTU9LTE15cFVa?=
 =?utf-8?B?ek9yUkNSanB0SEwyZHRwSmdIQXBGN0VIYzIzbmdHOUVWVm1hV2tCZzFWbDBC?=
 =?utf-8?B?VGRweWNmbCtQMDMxczA5azRjb2liMmhNSW1VN1lUWkdJc1d2ZnZWdE9odHY4?=
 =?utf-8?B?OFMrM3h4dW41UlMralEzaE1wNGRDWTlsbW02clpJZVZRMEZVb091ejBOUFdX?=
 =?utf-8?B?Y3h2dDMxaEUvTXpvRVRxdzhVcTdnbVA3a1dQODU0eVlZZ0RRTFA1Unl5ejhs?=
 =?utf-8?B?aFlJOTc5MTk5V0xxOHpVeUdnNThmdHBOTEQxL3NFZkhoUHZxamEweExQVnVj?=
 =?utf-8?B?RnhtRjZmbXRmZ285a2x4Z0ZtdTdTbWlQSFFjUDd6UmdlOGZ3cldhSUNOQXVO?=
 =?utf-8?B?Y2hjQkJRRHJtRnRhYnhTNk1PNjZ0YnRBUlViQW9EUUdhY25ja1N4UmFmTlh2?=
 =?utf-8?B?TFJDdnRUZnJFeVc3S3BhMGdRVStaMTBTOVFBeWlyNVhmeUtCd05qaFNEQmEz?=
 =?utf-8?B?bXEzOU1HOFRoVmpvazk4RWp3MEZqVk1oSUNmVk56d0xZbG5JQzQxdi82OEhE?=
 =?utf-8?B?QmRaVEN5eG5HaDdtQW9ZUFZ4YUFnSWdLWmVaZjQwcUtJMzhYbG1iUkd1RVY5?=
 =?utf-8?B?ekorY3Y3NVVycHJvZjBQRFJybVVKZ1NYOWVPVlJ2SitUT2FNZy81UUlLRWlm?=
 =?utf-8?B?dkFFN0lXa0tUM1F2ZjltVGZxeEZ0MWpBaldRNFoxOHFWUUJVVVlRc0VhL3NH?=
 =?utf-8?B?L0hJTjhocktGbHNiTXBLZDh6bUVTeXd1MGlRU3RGb1FjYzVhM3Q1VXJNakNl?=
 =?utf-8?B?R3B0NWpvMituZTkxOTBOd29MUmNKSlRJS0l6MiszNy8vQVpDNVNONXZpQnpL?=
 =?utf-8?B?SGYvVHkrS1J2d3o4T0RFZmM5cEs2UFNuamp0ZGJVWjhTeENEL0Z4bm9ZYmI4?=
 =?utf-8?B?RVdPZkJUQjZRQnBRQnRWT1UrSS9FN2o1VDBzZWt4TzJSZDFHU0IzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ca92d9-d757-44eb-6dd0-08de590d0944
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:49:26.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVNJ/rG4/qYj4fOEJaPvXur72WlZBvis5jvoN4lPVOWroRQqRhmMcNXfM5oMv2eogoRV2kRkzNKpWqt3Ul01JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8416-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[debian.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcreeley@amd.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: E18775B31E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/21/2026 7:54 AM, Breno Leitao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Use the newly introduced .get_rx_ring_count ethtool ops callback instead
> of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index 6fef47ba0a59b..d8b5491c9cb2b 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -500,20 +500,22 @@ static int aq_ethtool_set_rss(struct net_device *netdev,
>          return err;
>   }
>
> +static u32 aq_ethtool_get_rx_ring_count(struct net_device *ndev)
> +{
> +       struct aq_nic_s *aq_nic = netdev_priv(ndev);
> +       struct aq_nic_cfg_s *cfg = aq_nic_get_cfg(aq_nic);
> +
> +       return cfg->vecs;
> +}
> +

Tiny nit, but RCT ordering is not maintained.

Thanks,

Brett
>   static int aq_ethtool_get_rxnfc(struct net_device *ndev,
>                                  struct ethtool_rxnfc *cmd,
>                                  u32 *rule_locs)
>   {
>          struct aq_nic_s *aq_nic = netdev_priv(ndev);
> -       struct aq_nic_cfg_s *cfg;
>          int err = 0;
>
> -       cfg = aq_nic_get_cfg(aq_nic);
> -
>          switch (cmd->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               cmd->data = cfg->vecs;
> -               break;
>          case ETHTOOL_GRXCLSRLCNT:
>                  cmd->rule_cnt = aq_get_rxnfc_count_all_rules(aq_nic);
>                  break;
> @@ -1072,6 +1074,7 @@ const struct ethtool_ops aq_ethtool_ops = {
>          .set_rxfh            = aq_ethtool_set_rss,
>          .get_rxnfc           = aq_ethtool_get_rxnfc,
>          .set_rxnfc           = aq_ethtool_set_rxnfc,
> +       .get_rx_ring_count   = aq_ethtool_get_rx_ring_count,
>          .get_msglevel        = aq_get_msg_level,
>          .set_msglevel        = aq_set_msg_level,
>          .get_sset_count      = aq_ethtool_get_sset_count,
>
> --
> 2.47.3
>


