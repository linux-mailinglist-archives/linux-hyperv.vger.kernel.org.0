Return-Path: <linux-hyperv+bounces-8726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIJDDc46hGnX1QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8726-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 07:38:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873ADEF0C8
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1914B3011110
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2722354AF9;
	Thu,  5 Feb 2026 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OsAsEulk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE99354AE4;
	Thu,  5 Feb 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273462; cv=fail; b=PO7SEqoF9G2VMqGq+zIVrVMO52ouF0atvQMGTmFHv7zVSQ8aZ3A/8yQtAiLx8F/SPyBkRrUUNftiBmltgPIYQOLRtdLT7lm4gYpePF43PpWbdCqTP2ZXu5xJCdMim0z8NzM6/cNY77oZeM/Wc3MaTwrLn/jTU9VuqDRVcmCLIUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273462; c=relaxed/simple;
	bh=FJyLqMY8dcNve6wNOZqevViH3TRNqilO0KRJLQnmfak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eWyYwPRDi7zVF8vM1106H8+RHK38cDsCNp6Ey63xT/ZikDgrKcuSW5S9/q1kB8VS1Dp39kL93k3KrsemW6zPWxmtWgK5Eps/YyAN1jwXqiIqNc+tTdJSp2xT0cp+RKKSgdyaEa2KmwFal7fzPZDE6H34LwYczb8FwR3JiXOHmRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OsAsEulk; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3ULiPCWDwzrhqqZT4G2XL1OwQywor2TfYmZQkg59PR64XoVwriuVxP3Dul7tR2dwrG6ZDUjJ/I6T/22O8Yvb3caUa7AXe4daMU+4NFS+R8Z2gyNeOL5AiSJNTmpdOyP/VYReYxnD5p/Hir44+1Ju3nPqGsAqf1gOuS0mPunulS7505n17EMhdFIjwctx19Dkavas23s3Owxg6L1ryF4vixoXc2TzObl6d2HiMeQ1/w9asPM6dHmtn9q0lxRvfI4A7MBJzS9Htt9K93w9xcQE53RhWchMi1/PgM4X2GBdCYpbgEoYutH+FrFGbzbO3O5ga7/qD3eF6MHj4L56+9XcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StB3Flu8/vPqJflF57fGYAdBEkIP+fl6vjzVIT9fnL0=;
 b=e4k+scZfcNotXEF/UjcstZS5Z18yYaLTWzhmxUxz62n912kfqcRMDbJwPMuVDqHJRLHOorEV0Eg4VE3JnDl1qLUO2Mkletw97VGUp2OGpGwR1DqA/qLeFRnu5N84BnSw2Qep2utQduJrYJdIayJic+nh4ye8C1fCYIC7Nc5Omgb6P0rBMPoboHtDXVrfTHHkPyXOXrFquRXODQtm4PYRXs4tylz4FI1DyzkOf0JNP2pn/IZSmNgfACRebtK08fe2iXJyB5tMD2fAvazVeBWTh2ApHPyxueq5R7oeI+nXHpvqSOpTaSPPV+vFURmirO7xXUFLiooUlifj81alv+Dwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StB3Flu8/vPqJflF57fGYAdBEkIP+fl6vjzVIT9fnL0=;
 b=OsAsEulkZ6gMchNx9I8HXYifEQzpHI1KRNwMIEASWs6vRlxePeQdo61NVeSdcexWk2bd5z/N4elhhSa6cYLm6m19xmSkJqrwmTBHsIU1rLUdVGlnODJUnTSGh0XyWXs6dwH+fMqC2gyXQ+w2WMV+SUoiICXIuhuzHKPwMmKni0HgARcbXOh/sv2zpFhJbIPQ6aDiRtItwyU3M5A8GpY4ty+UszDMj21F8r3peSf2wb1P7qDW62ggtnBVCJsms6IM44jm/hxUIEuGkE9QT+soBAdjy4POjA1zwjBvTVSxNgZi+7fX55OsRm4KEs2pS6l/3zODLmViO8CLBJ0I8QGuFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:37:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 06:37:38 +0000
Message-ID: <d9f9add2-27e9-4b17-a122-d14918968ea6@siemens.com>
Date: Thu, 5 Feb 2026 07:37:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
To: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
 <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
 <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
 <SN6PR02MB41572C9E3650A6E581AA32C2D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SN6PR02MB41572C9E3650A6E581AA32C2D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 969b9450-f0b8-48cf-1387-08de64810dec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTN5WWd1WTFvejROYkdEck04YzlIY0dTT3NicU14UzdaOTAzSHduOE1wWkIr?=
 =?utf-8?B?OWYwNzJrZEl5SFJhL0lsKzlUVHN3UkMzK1NHUllmS0pydEVjbnU2YTU0OGpV?=
 =?utf-8?B?Nk9NV2pqalljMFFzcU9GTzAzNXNwc1M4Q2p2Mjg1c0lMMWFkVkQrMitLWndX?=
 =?utf-8?B?UUh1dFlBSUl0N2o2R2loS0poTmROMjQvWEFUU3pHbUJmTWdPVmtodnVBM0R3?=
 =?utf-8?B?MGM1bzhkK0M2OWRydWhNZU9jMmR6NUhTelNrWnJoeHZrZ3I1cEhLQ1hITUVD?=
 =?utf-8?B?OWV1bFpYZnBJMm1mWWhubFRUanhEQjhjWVhGMEJtU2FGdXlrb0hteG9IKzNQ?=
 =?utf-8?B?ZW04V29PeVI4Zy9BKzRNK3NvaWZLMUhVUlVPUXF1WHhrTjMxSkNVL2M0VTli?=
 =?utf-8?B?dUlrU21nRWU1dG56aCt1bmtxYUVlS0ZWVTNnTHJGdmJSRGtlV1RJdGxYVGQ3?=
 =?utf-8?B?dFFsbEpsTGJEK0xOa1ZLUHpJVFVqdmR1T0N0Q1ZhL1ZiZVVQb0Y2clFDWC9a?=
 =?utf-8?B?YStHQUJWdTJpMDlsaDArcE40SFg5cFZOdFN4QjlOR3JTb1JGMXRjK1MyQUk4?=
 =?utf-8?B?TVNBbXF6cnZxQmtlMTRQcklNdDFtQW94UE0yNzZCRDkvS0I0dkszK1kxMHBD?=
 =?utf-8?B?dnlBQ2FnVnNMS0tQS0c0dk9lWDgxU24ycVhuNVhxSXE2eWdzdkdTbVdSVDFz?=
 =?utf-8?B?SjBHdlpOQTRNZzhtcmFhRVRUUzBaODkrZHFVK1lhVXZhRGcvQ04rb0JmTDFJ?=
 =?utf-8?B?Ni9MZGVOV2RWa2NwbVpKZkQxVmY2L2VhWnRYK1BRKzM3Vk82aDl5SDdCRUNj?=
 =?utf-8?B?L1dNTUkwWmhiaUZtTndITDZBL1dwVHhTLys5MWlpZ1IrWVdzRzJUQXhKWFF4?=
 =?utf-8?B?R2hJTVVxd0tmRHZGOGQzV0h5MkJTNFoxelNCYnVEaXJEZW9LaDljdE1QWEJx?=
 =?utf-8?B?WGQreGx6Nmdzc1VGL2Y2ZGRZdEtNSWZac1Zyc1MzUEIrbGdtdHh5R2l3SDNv?=
 =?utf-8?B?Q3BrZlJlbDlwdWFMb1N5amJUcGxzZDVDdDBpRUQwbE9zNHNZSkwxYldETk9s?=
 =?utf-8?B?ZFVKR1pVZktSVEU1UkpmblhJWHJsYWpSRkFDZTlGamtia3o0c21WSUs4N0Zy?=
 =?utf-8?B?Q1VUeEl1cWVrbGpiQXJaTTl5R0ZnaWc0bmJYM2cxL01ZK2RFYXJ4TUpDd1l1?=
 =?utf-8?B?dCtscytYRExCem5pU1YzVDdHejgrOEFuYVoyc0xOOUVTOHhsdlNxZjRVVU5E?=
 =?utf-8?B?UFRpQW54Wk9mMUxlclBGbm5IYVBPTmlwY3YyOHRudXVrdmRlRERTZldQbWI5?=
 =?utf-8?B?U096QnhRWFdMUFV6eDg5aGQxL0JCVG1uQU45dHV5MjlBR0UwWjBQc052bEI4?=
 =?utf-8?B?bzBseC9lTThybFlQYmlXSDFTQkhHb0YzZGF4U01GTTZxam4rT2Y3c2I3NUxT?=
 =?utf-8?B?UDEzaGdqaGJ6SUp4MURubXBvZlNmNjlQUncxNnY1T1hSNjNCeGFKV29IKzM2?=
 =?utf-8?B?TzZqSEphQ0tkNnRXSEx3a2l5TjhkR0dDa0g0aHFkeEx3Vm9jNWNNdVFFL1RK?=
 =?utf-8?B?ZGQ4VE9rSmMxSFFtMGI0TEQwMzZUaWRkSzBYbXplblpVZ2t6ZEgxeVNRTkll?=
 =?utf-8?B?b3laUjlYLzJ5RmlXSWdLdXlESWlhODNBV2pDYndJUTJnQUlmTFhGdHNZcmpB?=
 =?utf-8?B?ZXBNekN1cmVFUDIzaUxGVzhtOGc1eTFISS9TUmViaFlSV0JoRjF2QzRsakhk?=
 =?utf-8?B?REYxVUZrQXVMdjZUckhBb093M1hZYUJPaHBIdWlyNkJMai93N2U2c0RLSWJt?=
 =?utf-8?B?QjhwbU1uVk0rZEUvaXlmREs2dDJGMG1rVXBRUG1aZ3dXT0RxeTZDOVdtYWht?=
 =?utf-8?B?bFNZSE05a2hDWm5yRmtJdlM4YTJ5M3lMWXVlbC9vM1k2c1c1K05UQ1VhYlha?=
 =?utf-8?B?MnFYYXZkUmErWXpZYVhQRDd4ZVFucStmQUlOYm9FZXdFQXAzRi93d0ZxU2Jh?=
 =?utf-8?B?S2szTVFHZTRZbmluS1ZSdVY2UnNoR25FZHczOHNtR3I2ZUxBTXZDdG1hL2g3?=
 =?utf-8?B?T3F4NWc3dnQ0L0sxV2FNdmFBWjJlUXBLLzREOWtkdnJsYk01NmV2VkhETXhM?=
 =?utf-8?Q?POrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnFDMVRwSzc4TnozOEdtWENHRW9aNnk0azlzOG1kdlJnbVpmVm54Q3RBaGEv?=
 =?utf-8?B?YVpoVHY5L1U4U1RIbVV6Q3dHS1p6WERUeDVsZ3UrQitjcENwaEtRZVZNUE5v?=
 =?utf-8?B?RGR4aFJmZ2tYTm56WTFwQ2JGS003MjBHenBSTW1MQ21Kc3o5SnVGTytBd1pU?=
 =?utf-8?B?MG5HWDRJWU5hUWtZSUxWRWZ1blVGU0VBanRoL2ZoSjN6TnhTN3JFL2d4YjBO?=
 =?utf-8?B?Z1NJN3Rvc3RDeWN2YklFQTJaSS9PbWlxdHM3Q1Z3UGIwNWFrV25QK1V6MmpR?=
 =?utf-8?B?VEl0ei80dFJLT0V1RTllL21QOWl6azFnU1A1V3h1d29WMHZ0bEdCbHkxRE5l?=
 =?utf-8?B?U1RoKzhWTG15SEdmamV6RTNuNEdZbjN3ODZ1L0ZPb3pKUTlXUEI3VUNHREd6?=
 =?utf-8?B?azUydjNDVFdJRFNMRmQvWnY2OVFKOEhpcVhJTWQ3S0FraDZnUUptZS9jYnIy?=
 =?utf-8?B?cDRhSWhmYUZFTk02SkJUUm5PUm9ZSndjTkJVck9iVWdzQU1zTnZwNjlTellQ?=
 =?utf-8?B?K2l6dlVKZE9PWG1BaVd2dGh4cXBhTzZybzZNaXMwZS9Pb0UrckFCUGRVRG5B?=
 =?utf-8?B?aVVJWEx2QXYrbjNUOXVzUmtKdFFYVVJwSWVxZC9BMmd1TkxrQjJENmZlcElY?=
 =?utf-8?B?Wm5wNjE4UnptN04rYlVWTXRSRjJxZVc3bVRZSit2OXNZUXg4RnFxdi9qVVpi?=
 =?utf-8?B?Uyt3NkJwZzVtTDg2aUJVZ0ZWZjhIbkpVTmE3L1l4S1ByYVpuVFRRSm5TUXFG?=
 =?utf-8?B?eTl1dG1sY0xUY25raDJXQzM5bHNMdXB6UWQ1R05CeWVELzV6eFRTN3ZGN3g5?=
 =?utf-8?B?cmhoKzBkS1ZVd2RlQk1XeWZCZkxub0dIWkgrelVYY3dtbTUzNkMxTlVBYmpL?=
 =?utf-8?B?YzIzSm12MWpYd2NtMUQxeklZcFp6OGJGRUlhc0xxT1dTNHRsZnRibE1YV0JP?=
 =?utf-8?B?M0srbUFPQjRzSUZCeElOamx0azlIREs5UVJxRVJyRVhKU29veXJEK3pDM2tn?=
 =?utf-8?B?OUtyZVFmenkyQ2lucUVpOFNPeTBEKzZmVTNPSFdqenNxaDBSR1dCN2sySTJj?=
 =?utf-8?B?aVNEamtYNUJqODN0R2NnY3pRVzdoYzBKT1AxUjNWUVFSclFIUC9USmhiZGJO?=
 =?utf-8?B?azhvSTZvYmx0TkxnS2lLdFJPaUd2TERBb2JRS3RvMFVGY2tkb21senZ0RlM3?=
 =?utf-8?B?TytxZU5hZS9QbHB6SEwwaWQreEFrTjlmd0l3ZTFhMlRjSUJla3NNeXhuZnlU?=
 =?utf-8?B?LzB4dzkxMDhnTDlzcXRlNnFYL3UzSkFLd2VyMW1mTnI3Q0ZEKzRmRG80UjVD?=
 =?utf-8?B?TEJJejBBckNaN0h3VTNZODkvUXNqSkw2a1l1aXF0UEFmQi9Wb2ZZQWs3THZv?=
 =?utf-8?B?aXFVYXFiMjN6K0M0bnc3YVFCRHVJWjdqaUwwQVFnaGpxeEFxeENQSnRhNXNq?=
 =?utf-8?B?bnN6TjhQZHV1WDJNcFY1dHUxb3IzcWs1L284dUNGMDczOGlBZWtMK1ZTeWtw?=
 =?utf-8?B?NHBFMEdENTU1Nk8zdmpIY3BodGdTVC8vRFBXVG1hMFJSQW9VQUJNTTgxdFVL?=
 =?utf-8?B?Sk13VWVEK3BZYmsrbmVWVnlHWS84NFFqT2hFSkFXYjloUzhBQVpucTExZ1NX?=
 =?utf-8?B?VEcweERMR05ZblJCUnNWYUt0UFVkZlcwVHk0MDRMeVVNbXFWRi9GbWF6RnBE?=
 =?utf-8?B?OUFuUHBWanllQWRTSnRaVnZ6YmpDQWZEMG5kRCtQNHhoMUI0Y3p6RkdhWko1?=
 =?utf-8?B?cnZSRFphVHNvREhUMmFXWU9mbmN0VzNnbjB5c0lHUVQ1QVJvaDdrYXBocjFp?=
 =?utf-8?B?WnVqTEhnZE53S0k1ZVdJRDRiM1FKWVRVaHZXeVk1VXAzZTVhZDFsUXI3Z1Jt?=
 =?utf-8?B?LzhBZVVCZGxxM1I3QTlOM0pJVGVvMU9qU0xSUGM1NStkKzBTSURZdVZVR0lN?=
 =?utf-8?B?S2ljalBkd3NMWXZveENTSFhlcEFRRDdJZm1hc0Rmc1NoWFlqVkxtY25ndCto?=
 =?utf-8?B?ZzlDVXVXMDhMdC9PWWhoWEdmbzlydnpYcXRSYm13THQ3bGhmNDFKV2dQTjRp?=
 =?utf-8?B?WVlGMkFnVVg5UjhZaGJ1MzlJY1ZPK2lVbUVTQUcxdjl0TEhKSFJ3U1FZbThm?=
 =?utf-8?B?bDZ3RjBSNnl5dWFESExuTTV5Q0ZJeG5ZeEo3c3NHUE1FVHZRcTZ3TTFWR21k?=
 =?utf-8?B?OUU5c25wK0t3WUZZNVpvTXBMMmExSFJGMVhsSEVKZW52MHQrZGZpL2dhTFly?=
 =?utf-8?B?NEdZaVBMOCs1cm5IMEtQWURiRmZTeHA1QzYwSkJTbWFRRDZnRnJ1WllEUmRr?=
 =?utf-8?B?bVlQNXlJeUFNWlI3NFZUSGtHUzNrZzlLU1pvMThMcDNYa2huWkF4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969b9450-f0b8-48cf-1387-08de64810dec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:37:38.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuv0N70W48xywVXE580+4udfKLg3eJ5j91Y6jgHH/zBMLjqlbItz/4TQTetVjXZzbUS/TmNyitAfSEgY7R3ApQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8726-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,HansenPartnership.com,oracle.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873ADEF0C8
X-Rspamd-Action: no action

On 05.02.26 06:42, Michael Kelley wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Monday, February 2, 2026 9:58 PM
>>
>> On 03.02.26 00:47, Long Li wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> This resolves the follow splat and lock-up when running with PREEMPT_RT
>>>> enabled on Hyper-V:
>>>
>>> Hi Jan,
>>>
>>> It's interesting to know the use-case of running a RT kernel over Hyper-V.
>>>
>>> Can you give an example?
>>>
>>
>> - functional testing of an RT base image over Hyper-V
>> - re-use of a common RT base image, without exploiting RT properties
>>
>>> As far as I know, Hyper-V makes no RT guarantees of scheduling VPs for a VM.
>>
>> This is well understood and not our goal. We only need the kernel to run
>> correctly over Hyper-V with PREEMPT-RT enabled, and that is not the case
>> right now.
>>
>> Thanks,
>> Jan
>>
>> PS: Who had to idea to drop a virtual UART from Gen 2 VMs? Early boot
>> guest debugging is true fun now...
>>
> 
> Hmmm. I often do printk()-based debugging via a virtual UART in a Gen 2
> VM. The Linux serial console outputs to that virtual UART and I see the
> printk() output in PuTTY on the Windows host. What specifically are you
> trying to do?  I'm trying to remember if there's any unique setup required
> on a Gen 2 VM vs. a Gen 1 VM, and nothing immediately comes to mind.
> Though maybe it's just so baked into my process that I don't remember it!
> 

Indeed:

Powershell> Set-VMComPort -VMName "Debian 13" 1 \\.\pipe\comport

<Start VM>

Powershell> putty -serial \\.\pipe\comport

Well hidden...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

