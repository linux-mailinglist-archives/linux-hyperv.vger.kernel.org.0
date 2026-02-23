Return-Path: <linux-hyperv+bounces-8954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLIaEPBznGmcGAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8954-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 16:36:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B1178D02
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DDA5303DA15
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D6299927;
	Mon, 23 Feb 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xjrqdonT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C936208D0;
	Mon, 23 Feb 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860882; cv=fail; b=gFyGaKOi5AZ9Ti6ii3AslUtcRBdazgZEguQoPwcDchLZsRW27Soxn/Z3SkvFeSfCJHfAjF3pZdPtoM/JGO9KgApDcETDyxkapYpTnPXeokSeTOqZ3O9jnVh+fKF5Aje1Njvmm/PcMFw4zsFu9WLK8KEMFCUvwZ7r+JTok0Hk7I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860882; c=relaxed/simple;
	bh=5XzoNGGIrT9v7UN3/f0nNyFRztbT5aiDZpLhEi6ZosQ=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=TYb7uZCapH8WGi9fWiekJQY0FAqgcFmTcb6rHwQ4uMan3862LihFaVaSJIgFsZYFVYNh6Yms5B10NRJwFKyIr4YL/ClfBj76JjilIMmAb4DEBHcHvSZAmTr4py7t7VtroqtGrQb3DA1HgDcYKX4ScSs1YI/NmXzIYmmnbi7CDuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xjrqdonT; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHEScGG3kRINnl4UXWQPsbxjeDYX21N2p2GdwE/4CrjXpykvyq7+VAZreHXaR1Tv74Uu6iMQQFbQ6qT9sLlIa/LBdYXxg4+J3ijRDV3wKgNVY3Woe6eMncPBiO1nVnk0+U5+Qhn2T9YijK2+vNXDIxOF87qddh3gzkSVdf7n/o9Acq1sILz8TEDGBkvKlksr4J0jMCv4ZL3UHJT4FPbE9WUOLLbfMBw8BZzZAQB8v7biUDcZ1VdhUhOyRl/+Gakms81c77EIIR8K1QRGjnAYGsDmDrXV8alTDzsy7Ce0PNY2eL5w1+9IyrEvzQoocWw79xld1bJVUBOjjBedta+fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN8jcoHR0ebIma0XeN1qQOrPrnj+bF9K8FiHZ3nvEfs=;
 b=Wp0Zz2nZLW/Swxga4GpWGOLtIyrXbEtLStrFN8HkOq4bROP2vqI+BXlI8+dROJRTJTOoJGrVYfvZhr2VbCUeIkTN+PffPCaWc9RzK9Cn/q0sfIomHmByvH3510gXPhQuTqsH0TmJGkDwYOC1FVJjk5vJHnxP6xpaY17N0pCWPrQuTjh9I8ArsQR7/3Nz+0bH/iEAgiDUMyYtTDo+TmgemjL/zDnDax6VyfcLCAMd3zhcGIlapMUhIP30kxxypuWPKwwpEa27iOyzNr784I2L/3hqROYxxDT4a+CJtjYkTSIhnnNr+zesmIZn/QSDuVGL0NWmOYAN1N7MgR6gQ0Mb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN8jcoHR0ebIma0XeN1qQOrPrnj+bF9K8FiHZ3nvEfs=;
 b=xjrqdonThB5nYhAJ8Z0zxC7aPJGTV0UunktKaiAmaHhCfc8lu5Memplj49SocDHUTC4+D+P5hCrQoMyZ3+QXp3AFF/qwKwDgmfGW7hg5Rcja7vUwltgc5I+c+2HZJ7vWQrFozYtHOezN5mPSV1FmqAkENHdpDOkLsodcMr+XiLsiLCR4HfmrfN/NxTl5wc+Ipy/AvaQwtNn7Ir//0MzYG9SO3logpPXDcdJQN+07C2gxHr08MKJ853oat40kMvPaoIA6SjH5Z7YQI7sQOOAkJzsRb7PNhFF42O4dt/59mgKlzrUAQoo98fOHYEJb6+A1YeQE1YZwGxmaERiqewx+wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 15:34:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 15:34:36 +0000
Message-ID: <3f10478f-f608-483e-802c-6c28bf9b0ce6@siemens.com>
Date: Mon, 23 Feb 2026 16:34:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.18, 6.12] Drivers: hv: vmbus: Use kthread for vmbus
 interrupts on PREEMPT_RT
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 Sasha Levin <sashal@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bec1fe6-1032-4543-5e60-08de72f10cea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MThVenF3UG9YOWlBSkdGNVRsL0Z2VTJiZGRMbEdjS0hpcG9ncTZtSW41bDZw?=
 =?utf-8?B?RWpJV0VJNXFhTFVaWVZwYnE1b002c2QxUUhFQ0V2UUFnSUlyRklSemFLc0Y2?=
 =?utf-8?B?RkRwVHFuOVNtdHUySnY4RjhmcFZKTzlXSlRsREtjcnA2dVNvZE1yV0piN1M5?=
 =?utf-8?B?Rm9sRWxKdVJKdG84QXV6SWtJUW1PbDJEZUZLOFQ5ODBYUHNCdDZBMWJVcEhD?=
 =?utf-8?B?bGF3cDM5VTUxNXYrWGhXWW9hWGNqR1AwMjNGdGxpK291aytQMnVzaDBOVm1n?=
 =?utf-8?B?dEcxK2hCTG5oZnVZSEpMaUV1L3M2SkM5ekp1dmd2OXN6bzh2d3ZhdzNMTjNP?=
 =?utf-8?B?bFlCUnNKM0NNNnRTUlU3V28yMWFWU2tURCtLNVFkbk9YWStQQmJJUVQ1WkEw?=
 =?utf-8?B?TkRoUFpEUm1Fb0VseG01YjQybFVDZ1BwemNxZnZ6djFxeStnaVpCU3g0Y1du?=
 =?utf-8?B?Q1ZSV1hsMjhuVGlJZytCeURTQVBUZ0pnU3A2eGoxZnBieXg3Rm96UUZEbmY2?=
 =?utf-8?B?MzdTbVAxVmlPVlpzSDkxYndVWlV6Qy8zVm9ucjU3Mmw1Y0ZVRkZ5Mm9IVUlB?=
 =?utf-8?B?enZubGFZRmtuSWlWUHZxZUx2RGtoRHUzak9TdVUvWCtQOUhUQ1ROcm9lT2x5?=
 =?utf-8?B?elBxYW9QcXQyOUFiUlV5QlFJNU84NGt4NDJlRi82R21rZDE5a3RBVUNNZG15?=
 =?utf-8?B?a0ZvVmIvQWVlY096c25MeEEwM1A2Vm5YQ3NHYytvS2djaHE1QUcvdERsbE1K?=
 =?utf-8?B?Uk0rUzYrZmpWVHpGcHVialJ5bHVGMkRqM0hlYzk2dk9yUC9aNmlXOEcyODFv?=
 =?utf-8?B?dUNkRTBmR3Q4cElvM3dWdWlDaE9Zd2RDaUlzYmZZUkNYWmdXcVN6am4vU25y?=
 =?utf-8?B?c3ZaWFRwbExBM0VnSmlVcENubGhvTmN0MGpOY1N0K0FkeXBmTHhsN21MNnp3?=
 =?utf-8?B?WjU2WFM1L3o3MStoeFRMbG14cng1dmxkeWFiTEdiWk1uQkpmVlpxbVI2UW8w?=
 =?utf-8?B?Znc5NG1GUklNQjdhSXpKQkdJN2xUSko5RmtQanl4U2ZRMmJFUno2TlU4b2Uy?=
 =?utf-8?B?RE9KNTUxbEJBODJLWmJQRld5ZWNUTElEZVU1cUc5VW1tODBrSGM4MzU2dTg3?=
 =?utf-8?B?OHZDeFNYVkdFSzV2RWlvbjVDVUk2ZEpBMllJVlhobS93VXF3L05tVzZWbDNh?=
 =?utf-8?B?VTVUdGQ0Si9tcEdFN3VVZjZuUjRFUnR2akg1NzRmcElBY2ZDb3hhVFc1Rlpw?=
 =?utf-8?B?Mnkrd1NTY3kvTDQyZ2VZT0NuRFBiOXRqKzIzakZveDhYV3g0VnJSVUJYQzF2?=
 =?utf-8?B?Q2VSRHpFNkgyZk51eDF5aWpsRVZTbXMrajZXeHVYaHhkb2hHUmkza3YzWU41?=
 =?utf-8?B?MzdpVW9ORHJ1TlNWQXhWRVJERXBSR25va0s2V2xiMUtRWmw5b0Vaa2pCVzl6?=
 =?utf-8?B?bzFiZi9DUzhFR2hwMXQrc2RTc0JVN3dJQk1GRUk2WVhhUWc4c0w2SEw5SWJ1?=
 =?utf-8?B?QjlYTkVEd3dRWGNZb3BNaGdoZnltLy9ETXkwWVEvbDBndkRtbWhmSVNJa0RW?=
 =?utf-8?B?RC9UN1NOOHZ0ZTY5bjN3ZHhiMU1VVnZZWnJ4NTBJRFpmRFJROXNYeUpsSURm?=
 =?utf-8?B?cFIwVGdvZzE5WVJaeWJMNWsvM2lNai90OFExRWZGQWdNZUF2c0NTQmFiRjhs?=
 =?utf-8?B?WVRhMUlhWnp2TFpGQ3pzOVFyZWRGZ2hNVTk5Uis2dFpFOEkxY0RpVko1cVI0?=
 =?utf-8?B?WnZ6K2x3U2lIc0JxZXQvTEtVa2xJemx5a3oybW0rZU81RkpZQ3ZlVmg0dEZX?=
 =?utf-8?B?YzluaGpQM20wSXZtbkk5Wm8wZzF3akpsbWlUenpkTUE1VE1wWmV0c3h0enli?=
 =?utf-8?B?ZE80ZW9uUHVqc1o3QUNlcUdGSFJIOUU0SUxtRVpOOTJieklHZlJkTm9KVWEr?=
 =?utf-8?B?c3VLdytBcENWbldMSlBSeUd6ZXU4SFJWZ0NvdmU2NTMwZ09jY2JYc05Kd2I4?=
 =?utf-8?B?SlpxSGdTTk1IVFBpQnNHaW1xVVArWWlRY1ZQTStXdWJ2bzI3R0JzMWtZVnBm?=
 =?utf-8?B?K0NuekhaRndVKzA3UllneDZlbmVLb1NvenhzV1FPUW8rK1dxekNKVEhRZVBk?=
 =?utf-8?Q?nv4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJGekZseWRxU2JqNDdDc1doS081SjJhZ0QrdEtIYWF0ZU1jY0ViN2xQMDlk?=
 =?utf-8?B?RFlHdGk5czgvSUZKOFp1d2hUVldJRUh0TjlPSmc0aXR0WCtPV0NZeVN3d3Q3?=
 =?utf-8?B?VlpYYWI0S0NQRnpxZ0pmcGxyaGlpaksvYWVaUDVuZjNGblZVZW85S0ZRZXlx?=
 =?utf-8?B?UnlpQmlhcGtGWFcvL2ppT29qQUdBMEo1aE5FOEhWemVtMmYyNWRWbk8yRGl4?=
 =?utf-8?B?MVdnL2VPWGhaMnVqWkJ3cGt6RzBVcVBXWjB6R1dPM1pDMkZxcWZqbGpUUURt?=
 =?utf-8?B?VmNUc3J2Ynd1SGhSb2hTTlpIV3lDaStteC9yT1Rhd2psckErQ3piQ3UxRVJ6?=
 =?utf-8?B?VkRLamxDQkYwSzJOUUJmejFKSC9ZNHpMWkY2VGNGVktmZm1LNTF6TytZNmpn?=
 =?utf-8?B?WktOUDFqQTgrcXFBQnAwVjBhT0xqWklmVGpnbVRObEFnNEk4UFB3OTFBTkkz?=
 =?utf-8?B?c1pqTGlvUUlLL0dueS9XNDFOWS96RFJjSUhCVDZZNjdMWndHUFBPcFdPeVRV?=
 =?utf-8?B?NjVreGdZUHUvekhOU2Y0NDJqeWFMNUNmZTJtOVhvc2JHbHNlZlEyUTJDemhE?=
 =?utf-8?B?QkFQYVpBVXFudHMxM3FVcU1neitRN0dyTzlMTy8xZ0d2T2Y1NzZJVnRZMWw0?=
 =?utf-8?B?cXRpaG5LVkQ4VlAxRHFBSlRyRVZ1aGxVZGlkREdMU2dqVzdSMHFiQW5FZmNW?=
 =?utf-8?B?eDZpOUtQMEFkNjdiVld5a3RnbzZHYzdvRTUxYS8rK3dhTlgyQXZrNUlybmVy?=
 =?utf-8?B?elZPcGpKNWRyM09OemVETFI0OXAwMUJqcDRTcEpuWEY0eEc4WDVpODAyK1NF?=
 =?utf-8?B?TTVpWHdnWkkrWXBYRzlnYWZSQVljaEI2RDN4MnhVMTQwZG0vOUFleDdFSFhB?=
 =?utf-8?B?WFdJQWlFcy9WQUdqTSsrb09xNXZSKytuWTJWSkhQOUMwNFVlQ0FKNjlGZm50?=
 =?utf-8?B?NDNkOUNNM0RxSyt2WnNRNEhINkhSUHdmZVBvamE0Q25wakhXeU4zQkhTSlR5?=
 =?utf-8?B?MGswb3NjTG5YdFkwOElFNkVUTFduVG1LV0dnNnFnYXNhRGJ0amF2b2ZubDVK?=
 =?utf-8?B?RXk4NXlqQ2xtVzVWZ2FDbmdhRWdPZTZpZVdiM3VyU2pheEQvWFlBVDJwcVBG?=
 =?utf-8?B?aXRLOEZWTXlSMnpFSmVPSy9lMjZYMTNpaEZjVk11WFhkR3RxWjB6cWZNWWht?=
 =?utf-8?B?M0x4SlEvcnQ3dlNDcks4RW0rSVdyUEFGZVdRWjhnaFlRUnFmZ05hL2FYdVdK?=
 =?utf-8?B?a0JIZTFaVDE0Ym5YMWhoVVBjdCtTbDZrSzYydWZzQm1CdzFXWHpwREYwb0VT?=
 =?utf-8?B?dmY5WGI4T1VQYkJZbzJSL2U1dnJPN2tGZ2thYzY1cmw1Zm5kL3hoMktFRlFN?=
 =?utf-8?B?ZmNoSDAveTFXWGhHN1JleVNZQkwrRHM2aHYzc1A1dWQxaUd0dEd3My9iNStl?=
 =?utf-8?B?UjBvWGJkenVVcDArYWNPTUgzUHlZT2t1Z1ZCM3hwak9XaUl0bW1vT0lacmp0?=
 =?utf-8?B?ejNCWXZwWGxBcEVHSStMZXpFN05WTU82VHo2cWQ5RGR6R0Z5ZWtTR3NoR1JE?=
 =?utf-8?B?azl5ZytNdTJhMTdqTUhGRjFOTTQ5ZlpyOTRieGM1MGxCU251Y3FBdjE5OUVV?=
 =?utf-8?B?NndZQlNoc2tSVVhvN3dyMUE1M2hUaTJvbDJBSnVnVTIxcEJHUHBDWXlBMjJF?=
 =?utf-8?B?TUpibyt2UXpDb3BUZ3hlTzUxbVNtZ0YvUFlRTnJJcmw0U29vNlZtVEUyMnY3?=
 =?utf-8?B?Zng5c0VUd2ZBcktrZ1RzbXNUN0swN2FRTnd0eE5jK3VrN2RYdS8za1FwWExq?=
 =?utf-8?B?ZHFFM05lZ09kM3VGTUFRRnRuNHJRZ0NoWUIvQ3dqVnNlNkV1TGFUc09pMmg4?=
 =?utf-8?B?bnRpVk40U3BRTVRWVXlBdElxTHJybytFVWJSOTV0bS80RmpOYks0OStMRWtY?=
 =?utf-8?B?bXFzOXBsQ25hMmRvY20wbjI4YlBZamcvbjk5U3N1WkFmUHZqbnI3U3FQdHow?=
 =?utf-8?B?bGZ5YXpGQXphalNhVTFzbHBVcTVlajVwcDN2YVUyOU1keUt6ck1DaTNONXRL?=
 =?utf-8?B?VXIzd2tpN2VPS09wWmJuQVkwUFk5N2k2TStzdmtsV1RubXNGekpZNnRoSXNP?=
 =?utf-8?B?c3Y0ODUwUzFFR0loTk9ldTZHbXExa003YWpVZ1JVVGU0ZGhFS0NPNXJkRnlx?=
 =?utf-8?B?SkZZY0lpeFIyQkl6V2tjU1hsenBadkdYditDNWVzTzQwd1ZIT0p3b2ZRd25Q?=
 =?utf-8?B?YnpJU21JV0hzZnp5bTc4Q3BLRTc2WXBIdGt3QnoxSGtCZ1pkQzZyZHVPUFJL?=
 =?utf-8?B?ZndURmVyWlJGNjVncTlQY3lBTE1BV1lBb0N3Q1cxTzNnRFl3dXZ2Wks0cE5a?=
 =?utf-8?Q?tqkCq8Y21NYisTZY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bec1fe6-1032-4543-5e60-08de72f10cea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:34:36.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgr5nWFUpU48lZFyiKkq9Yvgp8pyo+w1XvZR55gefvVricIqjX49AXBWog23fhc8+erkuZHHB4w2LI91/YyHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[siemens.com,outlook.com,kernel.org,microsoft.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8954-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB8B1178D02
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit f8e6343b7a89c7c649db5a9e309ba7aa20401813 ]

Resolves the following lockdep report when booting PREEMPT_RT on Hyper-V
with related guest support enabled:

[    1.127941] hv_vmbus: registering driver hyperv_drm

[    1.132518] =============================
[    1.132519] [ BUG: Invalid wait context ]
[    1.132521] 6.19.0-rc8+ #9 Not tainted
[    1.132524] -----------------------------
[    1.132525] swapper/0/0 is trying to lock:
[    1.132526] ffff8b9381bb3c90 (&channel->sched_lock){....}-{3:3}, at: vmbus_chan_sched+0xc4/0x2b0
[    1.132543] other info that might help us debug this:
[    1.132544] context-{2:2}
[    1.132545] 1 lock held by swapper/0/0:
[    1.132547]  #0: ffffffffa010c4c0 (rcu_read_lock){....}-{1:3}, at: vmbus_chan_sched+0x31/0x2b0
[    1.132557] stack backtrace:
[    1.132560] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc8+ #9 PREEMPT_{RT,(lazy)}
[    1.132565] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/25/2025
[    1.132567] Call Trace:
[    1.132570]  <IRQ>
[    1.132573]  dump_stack_lvl+0x6e/0xa0
[    1.132581]  __lock_acquire+0xee0/0x21b0
[    1.132592]  lock_acquire+0xd5/0x2d0
[    1.132598]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132606]  ? lock_acquire+0xd5/0x2d0
[    1.132613]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132619]  rt_spin_lock+0x3f/0x1f0
[    1.132623]  ? vmbus_chan_sched+0xc4/0x2b0
[    1.132629]  ? vmbus_chan_sched+0x31/0x2b0
[    1.132634]  vmbus_chan_sched+0xc4/0x2b0
[    1.132641]  vmbus_isr+0x2c/0x150
[    1.132648]  __sysvec_hyperv_callback+0x5f/0xa0
[    1.132654]  sysvec_hyperv_callback+0x88/0xb0
[    1.132658]  </IRQ>
[    1.132659]  <TASK>
[    1.132660]  asm_sysvec_hyperv_callback+0x1a/0x20

As code paths that handle vmbus IRQs use sleepy locks under PREEMPT_RT,
the vmbus_isr execution needs to be moved into thread context. Open-
coding this allows to skip the IPI that irq_work would additionally
bring and which we do not need, being an IRQ, never an NMI.

This affects both x86 and arm64, therefore hook into the common driver
logic.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Tested-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/vmbus_drv.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 69591dc7bad2..3ab62277b6be 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smpboot.h>
 
 #include <linux/delay.h>
 #include <linux/panic_notifier.h>
@@ -1306,7 +1307,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 	}
 }
 
-static void vmbus_isr(void)
+static void __vmbus_isr(void)
 {
 	struct hv_per_cpu_context *hv_cpu
 		= this_cpu_ptr(hv_context.cpu_context);
@@ -1330,6 +1331,53 @@ static void vmbus_isr(void)
 	add_interrupt_randomness(vmbus_interrupt);
 }
 
+static DEFINE_PER_CPU(bool, vmbus_irq_pending);
+static DEFINE_PER_CPU(struct task_struct *, vmbus_irqd);
+
+static void vmbus_irqd_wake(void)
+{
+	struct task_struct *tsk = __this_cpu_read(vmbus_irqd);
+
+	__this_cpu_write(vmbus_irq_pending, true);
+	wake_up_process(tsk);
+}
+
+static void vmbus_irqd_setup(unsigned int cpu)
+{
+	sched_set_fifo(current);
+}
+
+static int vmbus_irqd_should_run(unsigned int cpu)
+{
+	return __this_cpu_read(vmbus_irq_pending);
+}
+
+static void run_vmbus_irqd(unsigned int cpu)
+{
+	__this_cpu_write(vmbus_irq_pending, false);
+	__vmbus_isr();
+}
+
+static bool vmbus_irq_initialized;
+
+static struct smp_hotplug_thread vmbus_irq_threads = {
+	.store                  = &vmbus_irqd,
+	.setup			= vmbus_irqd_setup,
+	.thread_should_run      = vmbus_irqd_should_run,
+	.thread_fn              = run_vmbus_irqd,
+	.thread_comm            = "vmbus_irq/%u",
+};
+
+static void vmbus_isr(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		vmbus_irqd_wake();
+	} else {
+		lockdep_hardirq_threaded();
+		__vmbus_isr();
+	}
+}
+
 static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 {
 	vmbus_isr();
@@ -1375,6 +1423,13 @@ static int vmbus_bus_init(void)
 	 * the VMbus interrupt handler.
 	 */
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+		ret = smpboot_register_percpu_thread(&vmbus_irq_threads);
+		if (ret)
+			goto err_kthread;
+		vmbus_irq_initialized = true;
+	}
+
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
@@ -1449,6 +1504,11 @@ static int vmbus_bus_init(void)
 		free_percpu(vmbus_evt);
 	}
 err_setup:
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
+err_kthread:
 	bus_unregister(&hv_bus);
 	return ret;
 }
@@ -2914,6 +2974,10 @@ static void __exit vmbus_exit(void)
 		free_percpu_irq(vmbus_irq, vmbus_evt);
 		free_percpu(vmbus_evt);
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+		vmbus_irq_initialized = false;
+	}
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
-- 
2.47.3

