Return-Path: <linux-hyperv+bounces-8757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Db0L7aOhWnrDQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8757-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:48:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E72FAC0E
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 07:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52FE300C5A1
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628ED2BF002;
	Fri,  6 Feb 2026 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VcKkN+7G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814A5FDA7;
	Fri,  6 Feb 2026 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770360481; cv=fail; b=FHKdREa1HezL7Ln3gAy3n5hqKo67LULnoTWyDXNZWxkHzclKeYqgXhK66o8Z303TiO5DiefcEHgiidYR5IFw4a2W7G1DEWP+UPWGUGGJn9eZ9Y9KPPd7Nk8NYXIMwefxCEWpZ04yH1kgElqSfX9MAf9Dv7sBuGJF6e9XU8YBBtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770360481; c=relaxed/simple;
	bh=6HDAn0L1isG7ZeL/mXLik56QmtGajk1FCrV0kk7DSUI=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=Jd9+jB/UmfeJn5DNTBeY0KcryPVVl9vujYhAz2DhTuprdAoXEFIymY9k1K4j9NWGfwzCaaJTpHCv6qO0pw84cX1zfdfNdK0pAmOqeHdruPTABf/hyyIKugr8RywDxA4dU3AG45qmI19BrnP5fNCBq6T7upXDhcXgdME4twgch9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VcKkN+7G; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEkMgvNedX9FdPeHm9nut7MooKEvYX0cfRB7cQSI6O/b5zti9QUZYsfnajeLDU4i406VHMpFKUYeuJ2UI4E7IycOOH+8tc0fKl1Svl7/oI139M3V0cxLnzCtMNuw3C3eVjQpPDQCotIy7dWmo7xT3UwHfF7337IYWGLLCXpfA9Ep0OVR9xoAVcWlpXfvlZ/HIH6EFvzdG6ClS0WtvVP/fZzPgG+7ZKvRAB/PkmEhzpeq298J0o+i3t+/BT90TT76w28SjF99Cd2eBHyWvAHt+CGW2e6tUtjU4xCQdW8PGllT1OftZq3UCIu0bOcsDxmOnghSCFfIdmMMw/zE0jd0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwP5mRsck7/ZdDwteKQf7AhX6vs0jw2RB+KX8v7UsrQ=;
 b=k4ppiRbbscAF+hXXLSlwdqphDX/px0oluaeqb/u8CIIicrXTiZ6kPFqnGTJtyr/WKCqyIv3wEK5gALP391RSIPpOj4gHxQ1uxUFteTgXoyOt+RBfMcF89I+1QsgMPuDr4CEzaRdN7ldEhOKkmf2TkEAuZkD5o/S0YIJF4oqJbrIELQBZaManD2sJeWqDUzcDHryBT1zE+tmhJO8eNVX+ZcI8nKgPY4yznf5HjY3JxSUea1YlosfvY12pXRNFCoARg087FwO1tz7YP0jipB5dyxy0hsvCEFQk4X3j0Ivd5CizwsAqLf3SwDLrR2zxpHfWL5ZThetT4MgE1vQKdxkHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwP5mRsck7/ZdDwteKQf7AhX6vs0jw2RB+KX8v7UsrQ=;
 b=VcKkN+7G/uLWLYkPxsyhu2Stsg7cxpkaftxExP16lvau0NuB0sSIQdeHJ83xZ5Cm1el0lcI47ljdeKt2LqP1c4eTgVeVqbt0lTRw3eszF3euXZ/bRomasE0F5b7DBakvHUzpts5jXLDwJ8Y6dsNZoWgy9US5LgGams54WEpYgNDjKY1AWcX6sSQGub9OuFdwAcuqODVxbms4uUhDw/s7jKxSwohKiMbra6Mi0lgKjC6LTQfGG5qJfhQuAhxcyQb2gXyKb7lVgjn0o5quAGfg1uu3QcJ2LEp6pjFb75vmh2N97nKCWtGScpdA4FSCzQWE8AFVovUeAsyFV3FTogPrjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 06:47:56 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Fri, 6 Feb 2026
 06:47:56 +0000
Message-ID: <514e068c-1b85-4e39-8388-c1d2b106b4e9@siemens.com>
Date: Fri, 6 Feb 2026 07:47:54 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] x86: mshyperv: Use kthread for vmbus interrupts on
 PREEMPT_RT
Content-Language: en-US
To: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, Michael Kelley <mhklinux@outlook.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3dea0-a936-44d9-2b9a-08de654ba895
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhLVzNvcEJCOTB3aWlwRWIyYzh5ZWZBbDZHOGdLeGh0WGxqZWdITGdHL3dQ?=
 =?utf-8?B?YXY4QWtKb0cwQkEwRXRiTThwYjlLa0xIV05ONmg2c3lNRjlXNHk5dWE3bjNH?=
 =?utf-8?B?R3lLNlhXVkRFRG5XRjdqOHZNaU5ZL2Yrb2JrVlFoWklCYXlscFFNbVJILy8z?=
 =?utf-8?B?NGsxbkNZNlVjRXl3czV4SDYrTExDZW5jaEduQnFMQXJIZC81QWFDTEJNSXd2?=
 =?utf-8?B?OGJ1K1B6RGNacHMwS2FyYWlST3lSTHdsaWVDQkorZ29VVlYrRjVBL1Baa3c0?=
 =?utf-8?B?NzRZc3NWdUJaOHFPamtSOHlZeE1sTXNrYnBPcUE2YWVNZEpDNEt4Rml0VS9j?=
 =?utf-8?B?MHFrdTR0WHRvVnFFdStmbkEva3dRSG5RUkhsSVJsR1NHUGo2ZHdESkxqVnRm?=
 =?utf-8?B?L3JlQTJHaU1KQmVxRVMvRnRwa3hNV0FCY3ZXMTd4NEpQaG5LUjdHL0dGcGJU?=
 =?utf-8?B?SFVxcTE0V0puYVJmQTBRNDdXcEN4MnlBYXoxUnMrZW8xWG1rVkdlR0x0aHRm?=
 =?utf-8?B?MzEwcndsN3BzdFplbWgrWVR6U3liNEkrRzFCMHltMU5LeTRGMld6dkNsUTh3?=
 =?utf-8?B?REZLRlVDOG1XK0dlSmFuZWxFOXBEMlo3M2ZJV2FMcVgrQTJxMTUxT2E4THoy?=
 =?utf-8?B?NU96UDJObjR2WEI1SmxvaUd6NVpJTkM1bVJkaTdyUUtkWmNySmhLQkI0Mnh1?=
 =?utf-8?B?aHFpZjF5VlY3VUg0c0NJN2hvZUlNWTBMUUpROHBQV29jRmt3dmgrQnB0U1dP?=
 =?utf-8?B?VGJ1SmIrWHlHbW13NFgydDVEb2lVQ29ucUtSVlZsRFE1eEdQS3ZqekhOQW5X?=
 =?utf-8?B?SXNPQ0hFTWQ3T1NYM2wrZlgyRExUeTkrVFg4U0RGMGtCdWtkbXFhV2YwLzh6?=
 =?utf-8?B?YVhVSjdBY1MwejBHWkI0Y0JOUGRYSDd6c2RocnZsY3RLR3BOcDNuN0JseTc2?=
 =?utf-8?B?SmhMTkNUL3J0a3dENDJheFRKd0xBNmxKWStNMm1JczVXYmkveHB4M1d6K3dY?=
 =?utf-8?B?Sno4QVV5b3N1bklUak12SC9aNnpTbWo4cW5RelVDbGdXNTA4TVVwYnZlcjBT?=
 =?utf-8?B?L1d5V0ZVNk9wbE9seERWYUNmcGtoa3crMUhPNlh1UXJSajZZWHNMNnVTTVV1?=
 =?utf-8?B?TzhNM3g3SFUzVWd1VkFvU0ljNUxOUHFNSXovSzdFU0huMnJpaEZlNFpXZmRF?=
 =?utf-8?B?VnplTmVNOExSUUU1OGNYdk5ZVktxYXJxZWZCaVFxMG9DOTJCeVpmMFlEYmdi?=
 =?utf-8?B?U3RJZm1FYVgrVEdNdmNBV3VWT3Y4dHJoT1A0UUVXbmdxUGdhYll2NzkyRzhr?=
 =?utf-8?B?R1BxZksrcEJhZW5mOGRteEdDcklaTWhRK05XWXkyN1JaTjJHWkRlZVhRaFRh?=
 =?utf-8?B?UlJ4YVpxdXdtY0xxek9mMTJrRm9uOU12UmhKZ1FINzY3WEZSVmdGaTBTaVhQ?=
 =?utf-8?B?c3BURzM0WTZqL0N2Y25VbEdqMXdQY3V2SytZMmtiN0lZK2FFcHd1QytKaTRq?=
 =?utf-8?B?aEdrS0lZQyt5VU1HMmxVSGlZUWlBUTg1RGxBSk1KRXUzdUNHeXRyOGhPbkZZ?=
 =?utf-8?B?VWV6MlJsSHI5TkoxZ1BDWXBOM2x5NUt1cno4TDFWVXNpaS8zZVd3UThyOTcv?=
 =?utf-8?B?QlYxVGZ4U0JGM2tmRU9DVlhGS1Q1VXc5cmI5K0wzV3lnaktZR0FUTUt6bEdU?=
 =?utf-8?B?OHlCUk1VaXNNQ1IwOUV5RW91WW84ejBDZDBSR25SNi9tSzFPd1h5S0xMSFlC?=
 =?utf-8?B?TkhpMjFWWGtYOHVIZG0rcGZPaTdabXA2VlpBdk5md3RNOHRmUGVQaS82ZzNy?=
 =?utf-8?B?NC85cXlTdG56cTBWcklKc3doTTNEd0pPeEhKSmJpS0R6YWRVd085eVVWaG02?=
 =?utf-8?B?M3R1UUZabzQxWUxuQ0dkWU5SSWVtU1ZUbk50REx4NXVUV1FSb3VIbm5ZS2ln?=
 =?utf-8?B?TlFEbStjdGxxZWJ2NjJMVjJhOEErMkR4cUNWVE5ud013WWZKa0NyV0NyRy9w?=
 =?utf-8?B?SzJHZy9lbGs0a3dhT01taVVjN1YwbG93VTZ6dE1LTkdGOS9qTUZHYWMwNVV5?=
 =?utf-8?B?ZWNhYUlNSE51THJublFWd2dTQlRWbUJmMy9TS2dZb1hpZ0JnclBrTG9TUWM3?=
 =?utf-8?B?TURuSWVsUmxwUjJVd09HdWIzQ3VlWmVlbUdBelNQTEx6QmQwSlB3N2JEZVlD?=
 =?utf-8?B?MFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZhREVkMndBd0N2WEljUzBVYTBGYlMvYUcyWTdFRVpPSHBnTjh2LzkyWXFp?=
 =?utf-8?B?Q3MwdWVNSTVBbzZtU1I4N3gvZCtZeklFN3NmK3RDd1R6WUYxdTArT29tcW1L?=
 =?utf-8?B?c1crMWZoaCttOVNKckw5bUlWSjhyVE9aRk4yOUhtMnBMZU54dEN6WnAyYVFX?=
 =?utf-8?B?M3hZUlc4b3JiaExJU0JINXRWTWpCa2xDV3d2clNzSjNVSXFUQ3Zjdm1rQXI4?=
 =?utf-8?B?UFJJaGV0cEZRcE1PdUU3WTg2bDcwemp6SzRTeHVhQlB4amU4QTdjRXpucGdz?=
 =?utf-8?B?Z2lZeEFEUEw1ZHpabVhmMHdXOCtNTEVhZTRIOVRIbm9tSFkzdFlMWURrTU0w?=
 =?utf-8?B?VGdCeFp1TlZvUWNTRVl2VndiYnZZZWFRN2tNNU1WbGlBSTlUUmVYa2hIditT?=
 =?utf-8?B?QTVkYnkvOGVGVVZlS1pKcVdTK1MyMXRwaUNEWGxOTjdFOW8wWVVlM0RvSGhI?=
 =?utf-8?B?Tjl2UVB3NUw5WG42R1FuVkxNWnhsVithUGRzS0ttTzYySlJ5bEVnTFJ1Vi9Q?=
 =?utf-8?B?d0VsS0N2OFhaK0d2MG9ZYjBmcmFpSzFDWTkyUE9QbXpTaFZMSG16K2tLQjYv?=
 =?utf-8?B?RGNXWEJoNjdGdkt2VUpEQ1VNcSt2RXdBMTVkb3daWXRLU3crZWRTMFRaeUl4?=
 =?utf-8?B?b3FQTy9La3Fmc2Q2NGZPSCs0cHRoL1Nmbkd2SngyMGVpR0hIVk91SVdmL25H?=
 =?utf-8?B?cGxQNlRUYmVjS1J3T1hJMVdYZWhCZnRicXFzZmsxTEltYUlaMFlNV0tSaUd6?=
 =?utf-8?B?bk51eXFYY1NpcnpxZi9HalltaG96eHlPZFMzaGNLSHlTcWYwWjdEb1FVZENv?=
 =?utf-8?B?VC8xNW9iL05QaG1IaHE5aEttenkxcWluRUFDTXg4T20zRnc5TTVlS00rTzVX?=
 =?utf-8?B?d3V2cDZPRmd1NWJTbjNFcGMwODFjeHNvclRLSy9oVlhRTGtmU205eTVMYVp5?=
 =?utf-8?B?OXdWRVJKY0tRVGsrVHN0YjlLcGZMdkpYdE0vVkt4TE9wbVZrd2tSQVdLUnJa?=
 =?utf-8?B?MzhRUGlnS1BLVEdhTUVUYTFFK0FNUkdYQTNzeGNkbXlWRWx0azJoRm1PdkRp?=
 =?utf-8?B?STZXYkRlSFNwdGcrVVJ6eU5INTFjaFgrc1BIZnd6MEVSc2dRRGlGU2RoWjRK?=
 =?utf-8?B?RG5JZGl3UzJDVzJFVEhFUTROeE11OGRWK29UODYzQnBMaGxHdE5pWUN3R0J0?=
 =?utf-8?B?MmtEL3F0TlgxVkFyVHBDaFVyQ25EakhjZ2szZ0JUZ3Bjbi9kMTRMd3RwL0gz?=
 =?utf-8?B?ZVV3MVlyNzVBcDYzNnZlTlgvNThmRENlUWxacnhCTlFEY2p6Z1VMR3NFL2hv?=
 =?utf-8?B?bDVoZlBhWlFaMWRja0p2L0tpeDgrUVVQQVdpZElFMndFSHJvWURBMzlZZm9o?=
 =?utf-8?B?WU5NTXN1c0ZOYm5nbWlIcG5lT2x4Y1pRQmFVcjNPTlZWOFFMekNDbzhzWnhi?=
 =?utf-8?B?Tno5YWRsWUFHWEZjNGVpODZGSzRLTXNlWGZ1SG1ORlNCRjVhNzUwT2t0cVZu?=
 =?utf-8?B?K2lpVzk0c3ZWTncwUVExcCt5cnU3WDlaSEE5SjdoQzhRNUxvbGNVc2ZiZkRI?=
 =?utf-8?B?TU1scXh1WlF0SVVaeFhwTXRoL2tQK0oyelNRREFGZW1IUzhRaXpYMVZibFpp?=
 =?utf-8?B?UFVySWUwWmFpOWQxS1UvWGhXaExBZnFQTEtBR2pBRHB0MDNnblVLaEYzVTI0?=
 =?utf-8?B?VUZ2R0h3RG0yUlpvNzdTR2hLVGlRK1FKd2FNRkhmRDRENzdsQWFHY2t1K2ph?=
 =?utf-8?B?Y1Z0ZHFIM1I4akFueGxrZEd3NVZYeElwTmtmL1FjWGg2WVgwcDdrVmk1MkN3?=
 =?utf-8?B?OTQvY2NkY01DSTJWbExuMXZwWUJwalVvNE9NMXRCTXFCempFR2pDUXc0Rmcw?=
 =?utf-8?B?VzNyTUZkclhmc0hNUmVkK1BrOFEra2Z6NnFVcXdNMWxleTJoTUp1V05EY29z?=
 =?utf-8?B?bThFRXFGOGErNUcvSHlRZElZcTNjTkZiMklpR3ZLMmxEZjhvWE5FU2VPd3Zw?=
 =?utf-8?B?YW02QmhFbFptRXlqZWt3ZzFGdlRNQzZhSFAyOVFwUlJ6LzhtZVV2cndHNVY2?=
 =?utf-8?B?U3FNTW9ueXJIUWJyRnpFL0NGYUo5R0t1NXhEaG4zTUhvdnB2dWx5aGhoTkFN?=
 =?utf-8?B?WFZrcTNTTjJuN1pRVUpHWVN5Zk9EYTEzb2VtT2R5aWc1ZXBycWFoZlB6NnFm?=
 =?utf-8?B?SkhLVGFYcmU1dWVla1NydUhtVm5zUyttVXRhUEU5ejhnb3ZEa1oxMGxtNXIv?=
 =?utf-8?B?ZW44KzFsd3RtREFqR1NnUUlxOExjQ1hJN2NDVTc5QTBYN2VSbWZMN2IwTDJP?=
 =?utf-8?B?MEIyNENLU0oySGtKdmk4dElHeU4wRGkrUWo4aXBLbWxaR0tsenRVZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3dea0-a936-44d9-2b9a-08de654ba895
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 06:47:56.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C8x0zXI4ljoPeXXUx0qstZ5FO8ZeTHjyWcRutadDHFbuiF66uEnxlouRNmb+XdDiy0nKk6m34upycm6Q1cIyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7697
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-8757-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com,outlook.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,siemens.com:dkim,siemens.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47E72FAC0E
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com>

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
the complete vmbus_handler execution needs to be moved into thread
context. Open-coding this allows to skip the IPI that irq_work would
additionally bring and which we do not need, being an IRQ, never an NMI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - reorder vmbus_irq_pending clearing to fix a race condition

 arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 579fb2c64cfd..b39cb983326a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/random.h>
+#include <linux/smpboot.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <hyperv/hvhdk.h>
@@ -150,6 +151,43 @@ static void (*hv_stimer0_handler)(void);
 static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
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
+	vmbus_handler();
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
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
@@ -158,8 +196,12 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	if (mshv_handler)
 		mshv_handler();
 
-	if (vmbus_handler)
-		vmbus_handler();
+	if (vmbus_handler) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			vmbus_irqd_wake();
+		else
+			vmbus_handler();
+	}
 
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
 		apic_eoi();
@@ -174,6 +216,10 @@ void hv_setup_mshv_handler(void (*handler)(void))
 
 void hv_setup_vmbus_handler(void (*handler)(void))
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+		BUG_ON(smpboot_register_percpu_thread(&vmbus_irq_threads));
+		vmbus_irq_initialized = true;
+	}
 	vmbus_handler = handler;
 }
 
@@ -181,6 +227,8 @@ void hv_remove_vmbus_handler(void)
 {
 	/* We have no way to deallocate the interrupt gate */
 	vmbus_handler = NULL;
+	smpboot_unregister_percpu_thread(&vmbus_irq_threads);
+	vmbus_irq_initialized = false;
 }
 
 /*
-- 
2.51.0

