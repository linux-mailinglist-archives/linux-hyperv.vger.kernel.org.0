Return-Path: <linux-hyperv+bounces-8676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEwbN/kcgmmhPQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8676-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:06:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC8CDBAC3
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E266300B9EB
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E33C1966;
	Tue,  3 Feb 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="z68+TJ6M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1983AE6F3;
	Tue,  3 Feb 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134499; cv=fail; b=BjVkypUXWClG3iMijcmW2XW9Mf8XtJFJUY9X4FgOkaec8bOhuKi2AQNlRQPiDIEQhTwL5vaJAZF/qkjaSozjO4bLddoqRVW9WY3qD0H2PgKr/qn48M0LJ/Ff/vCr/XgEAJ9kiT25LRWNGdb19rde6o3ZSqieozdcI4d4mZB9lIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134499; c=relaxed/simple;
	bh=meOIumsh45+a46trwvG2tNhFXlB0Ahpge3EkEKe2qk4=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=iAI4Vv36KC9e7L5RvS18V92ItkmAyZDENhFw5ijz7kMoGOdnkADxTIt2XK3l8QrVYw9/KDN6YNKoWeJijA9Dv494kEKtJ2JD5riR/NjqZHkDfMHtsSS+7Dia1wN0nnfG1YoxIqaA3+BfuYCEThXGyuoidPNFsSaPn2kW7ajx+N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=z68+TJ6M; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEHcEgyt1Oi8muTfw5JMR7q/5N62GA6mSu1h+DenyTIzzXCoYAQgrHuunTREQf2NQJMaRWPnTIYsDuIofeVNTVVCEqeXt3E4+gOHl0o0jgnOaMVY1ezF5us6pE/4VmD+E5efoA13ytAzaQziulveYjz97HvxAMb5az+QulUoZDF2+MuRZScOgrJB5DW5eGacBqwaQoVkgEWVZnDu0PsjelzTwSiFlQz6PhEWOGewlii45glbH3B5WzyWz+Hp+N7TpEwVNcfVu4J1Uj6j7PLTeDnpRS602+pxAYpk/swwtMMBc73Zc3L0o9vsxotruAFtClqmDUopqtkaHZNtpXCZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOKvaM8A0BCSZgfoiTCCuX5E+eoxkJBB1ojGeKSCDSA=;
 b=VpkpUW67Zx3HnyWb0yPG0cOQC07gnk4XNaTMDW6M/RhYF23cFnuAj8/RBLrqYkVKkRG+V/ZtoMXqknWBsPAiGpV3Hd6jVvMc8rIyYxS06QMEfvZufya7T7nKYn/BwqAqTBxJlDo4QYIfFYLng0PA2yUfOA4CrKJ+650o0kErx2VAtHbNmaLqLbida18hqPqQ02EaGFjcEdrSOFnd/K8BpQlXKqSn0/uymxE9xvPFudrB86nPxiMz72syDWVuzvK0tUNjVa4bcldRXI4K5tJHp9Q8XwTWwN5wWFAno9lijoIToruqytMjDAi6P37BwC0/i+vDGXvyK1boN6Ejv8JHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOKvaM8A0BCSZgfoiTCCuX5E+eoxkJBB1ojGeKSCDSA=;
 b=z68+TJ6MEZR0udyHt/lai7H9ZwR7Z01tpas700oZmk9/r7xSYVJNF5enNFVRrfn9g8CM6sw5wVMISBbXK3kljCswEeAnvkHqXg9tSofTIm+Fu+sEZPvSyNYKPGOur3wnjxfjPZmen/T2bBF+edrB7nZ2xSTScJx60BzJmkUICBjDm3UWT0lqabpXX8WnnIXGOHtA3jdslTvuMnXjuEKRQP9CJc33m6gMyOZIt1dgmjJBCpr4I8K2AKo1P/iImYadziAuknjFZFzlfgOsNqAqWl87JgEQ97jtAVWdHpUOI5Pf2spkQj5C89VHdViASBFXW1y4lJKfejECcl2ITMuEwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB5831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:524::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:01:34 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 3 Feb 2026
 16:01:34 +0000
Message-ID: <133a95d9-8148-40ea-9acc-edfd8e3ceef4@siemens.com>
Date: Tue, 3 Feb 2026 17:01:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: mshyperv: Use kthread for vmbus interrupts on PREEMPT_RT
Content-Language: en-US
To: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1820f7d9-1849-433e-be5e-08de633d80d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0ZqVUpsWTZWWVJNUnRWRnZSNGF2ZWRKWEVQeUVDTEpIak5lZk5EWE51Qk1L?=
 =?utf-8?B?VnBXUnlHMDg2RzArTlUvRmxLd29US3M1emFRb0RNd3lzcis1Z04rSy82NHhw?=
 =?utf-8?B?S3RTTFRtUnlLMWpzQW1NcGFjY1VUb3grQVB3RXRLOHkwbEhHaTc1a3l6STcv?=
 =?utf-8?B?bDR6Uk9zbGlZZFZaRzVPaG1VSjZQVmtXM0FRSzl6dmVnV0ZlWGtWYnVldTlI?=
 =?utf-8?B?RnR0MmRnMnVXbU1uakpYMktyeU9MZ2tXTmdXdHpHMEdIMG51dHJ5cVJ3bXJ0?=
 =?utf-8?B?S1J0bE54V25Yc1lzZGwwY3pPUkVnUUxOZHZ6Zm9TdWhBSG8xSGdXUlMrUXBw?=
 =?utf-8?B?MkpORURDVlRmcWlsREgwTXJQL1ZTd3VkMFMvSmQ5dlJ4Nitmd2lLQnNSY21G?=
 =?utf-8?B?SVBxdTdrVUxYcmlJK2tYSTg4aEN6T0Zjd0hUU0V0MTN1MituTVFzRnRqNXcz?=
 =?utf-8?B?V3RZd1cvTGdXa213MGJyUmY3YU4xdUVtYTJMOUUxMGxCTWhSaEwxTm9WbGpG?=
 =?utf-8?B?ZFlsYWlMVUFBbERmZ3NGUHB3cm1UbGtOYnc2d1Q5My9TSndTc0x4cmpIdjU1?=
 =?utf-8?B?eWpCdG5ZR09VSmtHeXdtSDVIbm45Ti9OQnZVQnBDcHhGNXRoSWhUNC90L3lX?=
 =?utf-8?B?WXB2bzZtR3RGa0J0OVErNGF2NFo5ZzZKV1p0RWlqOVZ0em01Skp4T0dkUDlP?=
 =?utf-8?B?c0VJSnlmYTZIN3BiRmtnV1kwSU0yMHg4WU01Zm4xUVczeXlhN3JaTGkzUDJS?=
 =?utf-8?B?QVdHdHZZYVNkKy80a01xRDh2MTQya0RTeEZudm05U3Jzb1JNbzRNcWxYWUp2?=
 =?utf-8?B?RFp0S1JCUmY5WFFCamF5L0FTKy93cUh4SkVFdWxKL2hsYlRxN1NBUUVpTGJB?=
 =?utf-8?B?Vml5MmNHcGpYZUZEREh0cVVDWU1DYncrVG5xSG8vaG50TE9YVTlHTUxDYXBL?=
 =?utf-8?B?LzN2RkVFYkNFZjhKNU1Cc3llTlNkTFNncTZ6Ni9XZ1NWQ0xiMG4ydHJwMklY?=
 =?utf-8?B?TlFUa1RDVk9ZdStWN3ZMeUVsUVhLeTRtakhFQW0yUnA5b3dKT3JsRXdIQkNp?=
 =?utf-8?B?TEV6TFlRcTBUd1BSYitJT0VCMFVGUVM5eHhmNmZYY1FmazhlWXdFU0Q2QndJ?=
 =?utf-8?B?MEMwZzJ6SmU1Q1JEUlBCa1Q4QkEzbEpnOUJKMmIrdVZacGxRVzZMVmwwK20x?=
 =?utf-8?B?Ly9ualRGK3dYQ2NYeTdOTUl1WlhqOGtINGcwRzE1bEN4eGVUTkRmN2toWFMw?=
 =?utf-8?B?dmdVWVJMQUc1K0NyUWRxK28vMlRnUXpicDErVHhxeTBTL1k4M003R0Q1VG9J?=
 =?utf-8?B?ZlpQVk1vM1d2dXlQUGZBZi91TDJ1c0tFQkxoZWRzd0NUZWpCUUIyYXZNbXQ0?=
 =?utf-8?B?UkpFbmtBUllRbTlObHB3Tm00c2JwUVNXaDZWM00xdVYyUWlSKzJNS09yM1RF?=
 =?utf-8?B?bkgzc2EyeTRNWSs3Y2hkNk1ZNWplSmZYc3ZScFNNVkdXb2NtWmdRa0RoQzdS?=
 =?utf-8?B?NTdWRkdQVHhaUno1a0o4NHlybzRjQWRPUjVRNnRJdlhiM0tiVEdiTEtuTWJy?=
 =?utf-8?B?OEo1akFydmpDV1FUN1I5NURDM1JqTEFDc1ZwdmxSZDdMSFhUYTAzRXpXdWNk?=
 =?utf-8?B?cWhNR2FaUXNMTy9xTEVJRnRNUWpBME1zcnprV2NLL2d0TDNxczNWcXFNN2lB?=
 =?utf-8?B?UmZIWXNnaVRWNytqbDN2RldKUTBsdDUrWjEzTVVEV1VwamdCMlhLUnlwbk1l?=
 =?utf-8?B?WXJlUGJIeXVxR2xwZzV2ck9INHFkbmpLOGJ4VHluVkR2YktXM1BFSGUzaERO?=
 =?utf-8?B?NDRmOVYxc1dvaElDbEl1WUNCcEdXSEdLc3ZnWGdFRmR3RzM1YWU0WjFCV0FN?=
 =?utf-8?B?TFRYOGJkYm5yZWFzK2lOL1BtT2N0TERNNnkxSFpvOEpMa25nUnBxV01sbXBR?=
 =?utf-8?B?d3F6VXN5OHgvZlFybkhQVGhrME5QZUJ6TTNRUkoyajhvMFFoVU5OaThCUmVW?=
 =?utf-8?B?UWd4d0psVnZOd2lQb09wNkliSzBpNHpHMkpZU0VHSGt1MVNYSVcwQ3ZqTlRr?=
 =?utf-8?B?bENmZExOc0lqQW1XMDFpNitxcjNXZkdJQVdlNG41dnBSSGc2TlAvTS9jaWlE?=
 =?utf-8?B?SG1Qak0xeXVxZHZ4aC8weFc4VVBTZGlndFk1ZjlVZE81eVZGK2lYQUxqRklR?=
 =?utf-8?Q?FL3Ecf7cm8QP9OlBSBqrsXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFBsTTBwanJLMkgyeHFQNncvV0wvOGVOMFpwb0poWXkyc1pSZVdRb1FvdCtT?=
 =?utf-8?B?dzNGdlM0L2RmdUVVK3IzbkM1OC9ncVBmVmFlVTRoMFcxVDhmOXJ6LzdLWU5y?=
 =?utf-8?B?ckd4NUE0dktMSHlqY0JoNTFLRGVpaFFhTUp0bEVuM1N5QnNHclhUL2Z1Wkoz?=
 =?utf-8?B?UEdUYU5BVVEvM2dxS2F3UTM2WTRZY1NWZC9BaVBqT2FTc28yaldVZmxpSkF4?=
 =?utf-8?B?eGxlTDRLdk9Wb01RN0N1eVoyK0tNb2gyNG9QejE4TDR1YkQrWXJCSTFRWkdT?=
 =?utf-8?B?TVIvYkNNYlQ0NkZjZmpHY3Fpa0tWUkxSK1NPdW5PQVFWeWxtNEJtNjJjRXBS?=
 =?utf-8?B?TU1ZTVFuR0NHQXZKbzJvS3NuL1pjNzBOMHQwWWtOVkMvNmN0c2FGMEpmRGZ1?=
 =?utf-8?B?V0FoN21SRVF6aFhhbjNKTmZiMjR4MlUrWjQxNFozYUZkekNjK1lNM0tvbzlX?=
 =?utf-8?B?bVdjLzdRREtTb1NnTlZBZUFVWGRSUHhJbkQ5NE9Wa0tYc2xsZmdCb0k5K2xw?=
 =?utf-8?B?L21SbmxPd3VVWW5QekpMZ1d0ZU00a1R0dkVyN3Z0RTRmVTZnTWxFT3lPU2tY?=
 =?utf-8?B?YlhvYlE5Ukk3K05kYlk0a2Jnak0xY0hVbWNNQ2ZMSFBGWlhRSXpyN1VUZnZm?=
 =?utf-8?B?SzEva29PYTZVc2t5bUV4d2JKd00rOEFHVVhBQ3ljNk9QMkpDMWZucm9OeDhZ?=
 =?utf-8?B?MVBiYnlNTm1TWHpVRkZXdXdDb3dyaTl3V28wbnUzVitVQzZpTThQN29JelVM?=
 =?utf-8?B?L3lkWVpBVmRoUktId0JXSEx3dVk2V01wQ0VPeU9XU1FueUdjOHdLSzEzalp2?=
 =?utf-8?B?VTJhVTh6YXVQSVl4VFdMbTdJOEhTL2tGbUdhcytTdUdFSmo5cFFidkd0dEVS?=
 =?utf-8?B?RUdpUGV2WVdGU2o2RkFRVkNBaUJMQjg1R3A5a1ZaZll5Wlp0ZlRIbk10eCtF?=
 =?utf-8?B?STQxZEtPRVl4YlZ0TXVjK0dYQXY5SmZrMTRhaFJrcnkrK2ZWd2l0elpTZmFW?=
 =?utf-8?B?M2pUQ1BLK25sM0xWVVhkcUlDWE10cy9KVHpKZWZtRDJ5dm8reml6K2tsdWpv?=
 =?utf-8?B?ay9UeXFhZXkzUW82OW9EZGJqU2RkV1JETVYrSVE0Q3AwbXB3dzROSU5rMlo4?=
 =?utf-8?B?UloveXhjaHNxZWJBaG9HSmJNbmEvdzd3V1JtOUVoNm5scjI5RkF1TlIwMmR3?=
 =?utf-8?B?K1pDdU5ESEZ5eDhYVFNrK2VEdkNoTEoyWXllOVFvaktiQ2tJcjN1bXJpZGZX?=
 =?utf-8?B?RitCS2tjZWptV3lBSG9aQzZ0YU1iNjczdlBUZ1p0OHpFR01nazh3RkZUdGxI?=
 =?utf-8?B?Z0hoRzZnMjEyam1qL1MzdTJ3UWptbk9lZWp6RlIrYlZ4emd3dUx0TkxCWldP?=
 =?utf-8?B?VzhFY28rTnA2K1VaaVhwWlhZMkhsUUsydnlUcGhSMmpidlQ3R1ByTFdmbmN3?=
 =?utf-8?B?TkNqSDU2bURnRXFPRWpMU2VOY0dET0lxcVpkN2dHaWN5a0Q4VmZ5Tnh0ZXNI?=
 =?utf-8?B?YlFEVnBmUlpTemQ1SEUxaGpUbEppNGZWK1ltYW9aZC9FdHZwUExmTlptUDc1?=
 =?utf-8?B?ZU9wUTZFTUZzKzI0Q25FYlFpY3htZlM1VHhMZ20xZzZNU1IzemYxNmxaVmh6?=
 =?utf-8?B?Rml1eUtXR3FjTVRJM0JWbUNWOGlWWEViUytQeFpTTDg1UUVIQkVGWWdzb1pS?=
 =?utf-8?B?TXNEUS9xUDNYNWxjdHB0RUJiN256U0tYNU5MbGt5bS83VHVjU2laQUQwNDZF?=
 =?utf-8?B?MWphdmJFSElWMFpkVWs1ZUFJMitWVUZrYWp1aENhOFgvb3dENkdvUDJhdFpU?=
 =?utf-8?B?Y1F0TG5JVEMwQUF0VlpyUkxINnAvcjh2andGRHN2T1haUnlFZFBZSUJ6RDdZ?=
 =?utf-8?B?ZVJRN0tETWJqdFgyNC9WRjNQaWhTMUhIOXY1VTdNSGRBQ0syWXpzR3BqRDdM?=
 =?utf-8?B?OUtXdWdRb2ZzZExBRXRuczlyMWNHSFFkZ1V1b1Rmd3dqdEcwclBibTYzQUdO?=
 =?utf-8?B?WElPeGhmK3loWXNUTXUvNmJrdUZEbmdhNlVldDN5K2NlTy9QL1l1S0tVc0Rk?=
 =?utf-8?B?czhtR1orZlE0OGFPdWtOcEVHdEpRdSt0emM3ZTNJSlBRNUZYbkRKck1mNTJx?=
 =?utf-8?B?dDFiTHF1R1NDQmdXU1lMVTJTVm1XeXFkL0tTY3QrL3BYdHdxd0YzTlJPM3NG?=
 =?utf-8?B?eXRLS0JFK1BHTkNiaS9EbmJ3SU1WQkxSL0JNOFZxOVRsVEVxZUg4cENnbThF?=
 =?utf-8?B?TFJwR2R3VGdScHZEeFcrMjJCb2FjMzI4eDUxSVRCRDMraFp4dGpEUnFIMG9p?=
 =?utf-8?B?QVpQWGd0cDJpc0YvZGtFOFcxT0ZCcTZiUUVtZFdvK1NaTCt3MWRlZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820f7d9-1849-433e-be5e-08de633d80d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:01:34.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt4bhdDaOYnc0t83BzqNun25R+vo7CNyzCvPxkRIkwhT2ka1XgFVBLAPxGxWsfxfaSu7VWxkfKQhrTdMmbw2IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5831
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8676-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: 5FC8CDBAC3
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

This should resolve what was once brought forward via [1]. If it 
actually resolves all remaining compatibility issues of the hyperv 
support with RT is not yet clear, though. So far, lockdep is happy when 
using this plus [2].

[1] https://lore.kernel.org/all/20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com/
[2] https://lore.kernel.org/lkml/0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com/

 arch/x86/kernel/cpu/mshyperv.c | 52 ++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 579fb2c64cfd..1194ca452c52 100644
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
+	vmbus_handler();
+	__this_cpu_write(vmbus_irq_pending, false);
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

