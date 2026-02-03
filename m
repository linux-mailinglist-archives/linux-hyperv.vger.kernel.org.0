Return-Path: <linux-hyperv+bounces-8672-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIODE42OgWl/HAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8672-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 06:58:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F4D4E67
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 06:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 395E03024DFE
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACF8367F21;
	Tue,  3 Feb 2026 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lOrOax1e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127532BE621;
	Tue,  3 Feb 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098273; cv=fail; b=s75/5aebFfmc6d83KyxkegfnMHFl7jDujOBDlTlO1tzpkIgro2PX5R3q9fv+2x5mvsUck63g4MohRrCQ7h0Tn/WFhDyu3mVBQNeWm/vv2pwjxo0d6CDlX28eKBuf9NDj/EPPBlatN2U0yn6mG9iV1J56Mjc/pMb+1j1lMb+qD6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098273; c=relaxed/simple;
	bh=vu+k4dr2l/HKYzjG8w6zK5WtAIcWVDEicId8cwkgBJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KfpjYDOsgiVOV1YWA3CLO2NMSUOkmAroXUo1rmIpWmjvxlYbhTFyDmwt5S4JnpM4KtF5atJ9BzXRmeD+L83VgyzNddQQnWb6CPMOz9US6ewpHD+G6QjsI8PyP6t2uE9dZZXq7m+g3a+zMX/u4ygytcdVtd6EBBKOi7EkaAoYGxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lOrOax1e; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFE3pv/ix7YjHtzGfoyL5g0j7/HBgMVz7SIpm8lXv35J33/szDuWq/JdpJR3b563OpjVOYeSwketxyRaumiFUpXJOwp2oWUxkX2/IN9bX8nqRkgGyvudFlgI+vMzqRUPoUpBzg0lKWiTg5zyDsXdiTbXmo5o/Xei8JL7sumsPqrS0MvNH1IYDMI4UJU8RKQtp57TqnA6NtVgRSI81Ra0AVKUhwDXisbpYYFvFd7NMMX0WKEGmDYJO2BG4XTBVEWOFbP02W5srDUhHb64c5o7dLbPa2KyEbQ+gH4Lvsntr4XRCc10fmET/Un6GLorepoocMJBp6KCNBZgtoxYDVohxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BdToFHUPb0+erwpIMsCaDtLk7VtEp4AF2QEXvfTvY8=;
 b=XTMcHz2Pifor5punjyWFt6AhV6UeRDWy+tvwso9nz4XQiQo9W1xlpjXa9Ek2zPNRGQlM5Yp3BJ2Ai87GQydj04/EraT8c3jq4wuOEoJjyVADaWLfFajoK5sZ3FiSU5acgKN3Q7foY8IDiIUnwcYd69CPqCQo4+4WeoTeyLWugqnel/xBm/Tu0wOQMO6XP412XTrSFBpxZTYVT31L8HvRTJjTWIVPCFu+u0yX7l/8ydmxzJh+SDC6UPUYVt7pp+J4llLiV7hsO2JDxbk5QHAqfwc8VYjcDKDl4f9Umh6C004Er8E3nqDsejXDNjkeoD5NIFvh30b8pdTbwlci7RCd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BdToFHUPb0+erwpIMsCaDtLk7VtEp4AF2QEXvfTvY8=;
 b=lOrOax1e2oM1S1+NUJop/NnMNx56C+IxDY8TKdU1+Gky7wV6LDM7McOklxyNRtbWS71fyhF0RCdX9dJlb5nvqttjkJ0eZlmPPTGkDHbtZ3PZvqA+XH9mn3LPFNnAWStOWNvCaP3/Cb6L0kmqWPT9C7hWJDPL5xpf9gyKno3rPyETerrQPmMTnxDreFkZMMakHOcS0FrNjd7xOb2ub4t6bdf3uXDsVtAmaeyv4gRhb8pXTC+EhFKxtRuA+4O1pFmL5QNugNc5Ce8hvydugMyOMM1p+FcfXkuFGFvzusulf0DPHQY+aOnGw2LUUDFNb8p7SxOzknAaG8vaRroYz7w2hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 05:57:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Tue, 3 Feb 2026
 05:57:47 +0000
Message-ID: <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
Date: Tue, 3 Feb 2026 06:57:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
To: Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <DECUI@microsoft.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 RT <linux-rt-users@vger.kernel.org>, Mitchell Levy <levymitchell0@gmail.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
 <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e4cb46-b0d0-410c-8fd0-08de62e9285a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0dvUEJCN0luYURKbWFJaGNnaHo3ZFhkd2JXZVdoY3V5c3JNUHNwTnl1Qmpa?=
 =?utf-8?B?WHlsaHlKK0EzTGcrcXlRVkpMYjNTYWJ2TlQrbnkwTGxWRC9QM0FSeWc5Tzdq?=
 =?utf-8?B?SUU5ZURNM0MwZHMrWE1BSEZIbFB3Wk1wekZ4djFnRUNLakJreXlUV1Jhd3c0?=
 =?utf-8?B?MW9GWDZVWFU4eUEzaExxbnhRbnhqQm0xSkZpb1hHS0hxTUhOM2pzenRrbWgw?=
 =?utf-8?B?c3R4TVVTM2ZjaWY5Y2hReDk3d28zTWQ0R2p3QWswelRqQnRLa2hnN052bDhh?=
 =?utf-8?B?ejAwMGNvbUJWY2hFRCs2c3F5Y2Q0dG1HdElYYUFXRGRrU1dVakZrV0tRemhZ?=
 =?utf-8?B?dTA4bkJuaGc5Z3cxcExEVlUyd3BCU0J3c1NuN3k4V3Y5OFpkL3dDU3RZVGRi?=
 =?utf-8?B?QWVFZm16MGZpMmxzQ3JYei9sQXExL0JFM1daNXdpUVlvMUcvQzQzVzR0Njhl?=
 =?utf-8?B?elQ1dnhVS3Fvekd2Tk9KdS9OQUVDd3dLL1dLOTZHdmVnNzZSekdTQ2lEL085?=
 =?utf-8?B?TjVWaWY0RURrZ3BOREM0bHluL3ovUU1rbkRkeXVOTitVUStyMVVsMVZkS0NF?=
 =?utf-8?B?Q1ZXYWIvSEZIWnQ4VWNad2JBK3JadUlCbnFWcXpkQXRvSkc1cXh2cFdJeDY4?=
 =?utf-8?B?TkdWN3ZSZDNXSTg3OGdOVm1JUGJmdWJVQUJneXVBRnJlRndPMzZUd28ydkVi?=
 =?utf-8?B?dllkK3RrTk5zZFVOb2t1aVFrV2ZEVXJMSDMxV3BTM21KVWFOd05HV3c2ZGNH?=
 =?utf-8?B?WVB3RktmSERPK3VMM1ZhT3FsQUc2SS9xOU1QSU1aMzdSMTlyT1BXNkErenFN?=
 =?utf-8?B?QUtQNG9wV1g5aFVUYkJnWDJsRENtZytreHo0QlJrQWVIK3FmWTFIM3pkV2Nk?=
 =?utf-8?B?OWpmcURlV3V6N3NVTUpLV0twTDNUVndpeGZZVi9qSVk2ekdjK0pvS2hwLy9t?=
 =?utf-8?B?cGMwMFE5WDNScC9YYjdPVUZZOStUT2hIWHN4Z2FyelFPRHNXMzAxcU5FeWlU?=
 =?utf-8?B?U2RUS3Z4OUIrcm1NTXNrNkk2VktrV29mYnl1NndnWWVHbUVCRHVLRUt6YnBO?=
 =?utf-8?B?QmFiRGdBVERDTGlWNWI0d2VCaXNCcTlFcmJ1d25EQlRTWlltSGdKelQ3QkdX?=
 =?utf-8?B?Yk1jc2dmcGxaSGwxVFdYVmRCRkd6RVBtY29SWGw5clBNU3hJeHpuTzZQSVhL?=
 =?utf-8?B?bmFRRW5zMGtwZ0tjdzlPWjBqeW5MMXMvVkRwazZvNTJ1TjF4NDJGYkRvV0xD?=
 =?utf-8?B?NkphMTZYdUliNFBlT0lRTlQyamRSMUFaZ2VaaXlSNGY2SmZ1eDJJSDZMR094?=
 =?utf-8?B?R1BPRkJ1MFozaXRhUEpKMzZiajFuVm12QlJNS2Y5dFJTNlRvUUZRbGRnaFdi?=
 =?utf-8?B?enlxUkd6VFNnRnlrSDBIREZ4OCt1ejk2NDBxb2p3S294d0VRRGpPS0xGd0Jl?=
 =?utf-8?B?TXBNYXErVGdFeGdBcWRqMzNMdlBVSEV4VnhQcVpKQ1hxR3dnN3F1SnJPUUpJ?=
 =?utf-8?B?U3lPc2ZSUHBITWRjMTJMdTF5RDY2NmNhR2RtbVJpdlV5QllMdDFyZ1pjNzhp?=
 =?utf-8?B?Vkc2ZGV0WllaUDZLbHlYbjB1b054aCtPVjlRNnFYK2d6T1hnQ2RlSU81WmZp?=
 =?utf-8?B?UzJ3SUs3YldVaHh4Sm9vaVlhQnl2REdyRGp1VGFPYWZOQStYZkh6T3dkaGd2?=
 =?utf-8?B?ZmxmM3JkaWYzT2ZGNjFXM3FBdXJMS2VqM0l2TjQyQ0RCUHBML0tSeiszanlG?=
 =?utf-8?B?RmlMTCtSVnhVTmQ2OUFyc0lZclUxSU0rRXozSkNYZGhvMUJybmhSckFuc3I2?=
 =?utf-8?B?QWQ5Z2pPNWg2UVUrVUw1OXA4Y2xsb2dnRFpqOGFkVVBMcGYxRGM0dVh1V1pt?=
 =?utf-8?B?dFJ6NHIyNXN2dVlaZ3VUM1NaM2YwN3dKdUMraU9OUVAyNmlUK1BtZW9yOFlz?=
 =?utf-8?B?dy80aWFSU0NMS0Fxd2tiOTIzbGRpdFRGYzQ5WURoZDMwVkNNYjN1eTk3SHNB?=
 =?utf-8?B?TmNtWm1FelVlVXJnZnUzODdMTWJRY2xJK0N0Vno2ZFFFSkdpVkpPa2J4TW0v?=
 =?utf-8?B?WCtFZmF0STdBRHJ5VjN1L3RyelNHbmJyMmhaOVhhdlU1TGlidEdjNHpITzRt?=
 =?utf-8?Q?BSRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUNvQ1EzK2Y1ajVpZmtMUHpGa3FhZmdVUmdWclhod1dvRzlIOUxScWFGeHJq?=
 =?utf-8?B?WGRNWFFraVJSdm1uUjJQVVdkMUZxdlZHNitQRmE3T05zWTlpblNHSEVMVDNP?=
 =?utf-8?B?R0RzMXhqQW82TkJwVVRRUC9yNm5aMHpqaThKbHN0K1NCOW54NEVISEo5cTJn?=
 =?utf-8?B?M3FMUzB3QXY0eitmM3hCS1Q3THVZTC85QnZXa2IvQlc0eUVIMnJ4a3R6UzNN?=
 =?utf-8?B?UWUvNDc1K2tpeFhJTTVuRXhLdnRwY3lZNnF6WENSRkpqdlU5Y1FqRWpBN084?=
 =?utf-8?B?TzFiK2pDYnBsQUp2WWFxT3N4cnNFQVVxS0wyaDcvVFNBT3YzOThnQythVkdv?=
 =?utf-8?B?N3dYZTZFQzBPMlpDY0FVd2RzMkpzdGlJL2FSbkNkU0toWGNRekZKU0kwNUNs?=
 =?utf-8?B?d0JtblR6Vkt2Y2d1aVppTnhXemI3LzJkUWhHUVl6dFNwWVREWjBsSGNiMFpT?=
 =?utf-8?B?S3pRelU4amY0WHJRaFgvZlluRFJEMnVxWlRUQUdubmhBNWFzRU9mSjkzQjBS?=
 =?utf-8?B?QVNpWnBNYVJLamM1OTluN1pjZ2NiQjBPRUpiUUhqdjNacXMyMTFTWk5MZzlr?=
 =?utf-8?B?dmhlcDZ6V21NRUplaDRCSTBlSkVyOHpYeElqLzNLeEVyR1pUeGRlRDJWWFJw?=
 =?utf-8?B?S1VsYTY2Ylh5STVWQVFSbCtWdVZDZVZpVHhjQnAweG9NZUJHY3IwM0xDZWdB?=
 =?utf-8?B?TlVnKzJPL2lvd3RoRHNPQy9QaUF4YnJobms3SE9uMnI2MVQ2d0pNaUdBQzgz?=
 =?utf-8?B?dUNRckg3alp6NUhtL00vZzhLc2dTU3JOWTZKSGhaSDk0aWRNeVRndUp4Tko3?=
 =?utf-8?B?U1V1MWQrb3g2Q2pjQjM3ZisyNkhUdlFCMGh2WWlNWUR0Zit1LzBTeHFBVitS?=
 =?utf-8?B?S2NKSUtzZklEWURZNHZRaUlBcU1hZnFZNW5uRDF4N0hVUUhsWk5uQmMzNjV3?=
 =?utf-8?B?MFQ5OGhVWkdId0t2aE0yTXZLdWhiWE81YXdMOWZWUkY0SGVGUkJ6OWZNVXNE?=
 =?utf-8?B?aWxnY3JsdC9SQUk1ZGFOYnNrVzk0aHZVWmVXdnBVeWgzNEx4VTdKT0dUbThm?=
 =?utf-8?B?Tm5KMFF0ZUxIT2o2dHFEbHR4eEMvZ2hEeTlEWjRKMXZFY1FSUkVVbEVIM1c3?=
 =?utf-8?B?TkFoMlZ6TDNoajdqN1l5WDFuVEF1UVdOajM5V2MwQXJ0RzdpUTVoQUFIckZr?=
 =?utf-8?B?d1U0U0NDVmhjMWY3ZWhRS0IrZmNQcjNBcmgrc3dlMEtaQ1RVWnVBemlqek9v?=
 =?utf-8?B?cXR5WWxmRk1LOEE3VHd1Yk5oeEVSNU5zbE9Hb29yM3dLYks0R3hJZGd1Qlhv?=
 =?utf-8?B?aWkxKzNJa1NVWGRQZy9PWVYveFp0VmJiTjlNTnlFZmZQaEo3c1ZRQ2p0QSt5?=
 =?utf-8?B?UEE1U0JnZDhTUjk4K29aOHNWUVF5UFU2YlI2MjlIMW5sNGc2NXQxbDFLclBC?=
 =?utf-8?B?Y3ZvMWo0R0E1Zm5pRDNHaERVL1VJbktrdVF5RGRCOVZTa0xpSHZZWXVSRjFP?=
 =?utf-8?B?bk9UUmRXZjAxTC9RSFdKMUxSd21MTm9KaUN3b3RYV3pwendLVEV1YU96V3F3?=
 =?utf-8?B?RDM0bkZJcjR3K3Y0VWg1VDZjdmw0WHhIMU83WisvRFMxdDdYbkh0Slg4eGVt?=
 =?utf-8?B?eG0xaGovSjBxWkMyYjVuN2kwbnJaK2ZweWg4aCtiVjNyTTc5SCs4Z256SGJK?=
 =?utf-8?B?ZEFrcXZEWmtGMW50VEkwVHRFSHNzbTczWk5nZ2xpZGJPTklESnZjS0NsWmx4?=
 =?utf-8?B?clJ1UVVYTDRBRlZlSDk5TXZGcmY5WWFlb21sckJtL1c3YXkrZmQ4d0VXWGU0?=
 =?utf-8?B?TXk5ZTNhWjhja3pCRVhaVmtiWG80WVR6NXp3blFla2ZmeTJIQmFUQ1F6d3dr?=
 =?utf-8?B?b0dKWncyZzJZalJUU0Z1MXVNWGxiMVg2VFkwN2NtdGRPaEovaUxtTFFTME1W?=
 =?utf-8?B?ODVJV3ZBVWdGK1NXcjdGMlhsMHREU2p3K3RVRE9zRUVWYjZnOUMxZDZ3Y3dW?=
 =?utf-8?B?RFBnRGRKbjFWUWlvSUV5YjRxeGpyZzAyMjhPbXdwU0R2MWVYZVNVZWJiMVNw?=
 =?utf-8?B?aS85eFBTWmk2RmI5a1FWU2V3UXV5V21zK0tMMTFEYnd0YWNwNXRqTWhRZ2R4?=
 =?utf-8?B?QUw5dnhKWitlc2hNcEhWNUYvbU5tellxRzBqaDZsV1BzY1plSldROGpsVW54?=
 =?utf-8?B?TXBhOGlZYzNzd2pWRnV1SDFkVG95VVdCV3pmT2s3YjhUR0NYblFJaCtJSllG?=
 =?utf-8?B?cXhDNGtybFNQVllReGs1T3BkRThic1ZVeGh5NmhxMGZHckI0ZkMzN1ZmQVIv?=
 =?utf-8?B?RXZZdTdVU0hQNEZYYW10QUVRYjYvQXBMNUk3NTg0UGZPa090L2Y0Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e4cb46-b0d0-410c-8fd0-08de62e9285a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:57:47.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2Q8THx6EoogHDjjVZdKNIrtHjbqKNOFPw6Z07Yt4yRYoVZZ2emv0sGwF4BRnDx2H2fcMW+kws6IOjRAMHMcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8034
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8672-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lore:url]
X-Rspamd-Queue-Id: AA3F4D4E67
X-Rspamd-Action: no action

On 03.02.26 00:47, Long Li wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This resolves the follow splat and lock-up when running with PREEMPT_RT
>> enabled on Hyper-V:
> 
> Hi Jan,
> 
> It's interesting to know the use-case of running a RT kernel over Hyper-V.
> 
> Can you give an example?
> 

- functional testing of an RT base image over Hyper-V
- re-use of a common RT base image, without exploiting RT properties

> As far as I know, Hyper-V makes no RT guarantees of scheduling VPs for a VM.

This is well understood and not our goal. We only need the kernel to run
correctly over Hyper-V with PREEMPT-RT enabled, and that is not the case
right now.

Thanks,
Jan

PS: Who had to idea to drop a virtual UART from Gen 2 VMs? Early boot
guest debugging is true fun now...

> 
> Thanks,
> Long
> 
>>
>> [  415.140818] BUG: scheduling while atomic: stress-ng-
>> iomix/1048/0x00000002 [  415.140822] INFO: lockdep is turned off.
>> [  415.140823] Modules linked in: intel_rapl_msr intel_rapl_common
>> intel_uncore_frequency_common intel_pmc_core pmt_telemetry
>> pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
>> ghash_clmulni_intel aesni_intel rapl binfmt_misc nls_ascii nls_cp437 vfat fat
>> snd_pcm hyperv_drm snd_timer drm_client_lib drm_shmem_helper snd sg
>> soundcore drm_kms_helper pcspkr hv_balloon hv_utils evdev joydev drm
>> configfs efi_pstore nfnetlink vsock_loopback
>> vmw_vsock_virtio_transport_common hv_sock vmw_vsock_vmci_transport
>> vsock vmw_vmci efivarfs autofs4 ext4 crc16 mbcache jbd2 sr_mod sd_mod
>> cdrom hv_storvsc serio_raw hid_generic scsi_transport_fc hid_hyperv
>> scsi_mod hid hv_netvsc hyperv_keyboard scsi_common [  415.140846]
>> Preemption disabled at:
>> [  415.140847] [<ffffffffc0656171>] storvsc_queuecommand+0x2e1/0xbe0
>> [hv_storvsc] [  415.140854] CPU: 8 UID: 0 PID: 1048 Comm: stress-ng-iomix
>> Not tainted 6.19.0-rc7 #30 PREEMPT_{RT,(full)} [  415.140856] Hardware
>> name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V
>> UEFI Release v4.1 09/04/2024 [  415.140857] Call Trace:
>> [  415.140861]  <TASK>
>> [  415.140861]  ? storvsc_queuecommand+0x2e1/0xbe0 [hv_storvsc]
>> [  415.140863]  dump_stack_lvl+0x91/0xb0 [  415.140870]
>> __schedule_bug+0x9c/0xc0 [  415.140875]  __schedule+0xdf6/0x1300
>> [  415.140877]  ? rtlock_slowlock_locked+0x56c/0x1980
>> [  415.140879]  ? rcu_is_watching+0x12/0x60 [  415.140883]
>> schedule_rtlock+0x21/0x40 [  415.140885]
>> rtlock_slowlock_locked+0x502/0x1980
>> [  415.140891]  rt_spin_lock+0x89/0x1e0
>> [  415.140893]  hv_ringbuffer_write+0x87/0x2a0 [  415.140899]
>> vmbus_sendpacket_mpb_desc+0xb6/0xe0
>> [  415.140900]  ? rcu_is_watching+0x12/0x60 [  415.140902]
>> storvsc_queuecommand+0x669/0xbe0 [hv_storvsc] [  415.140904]  ?
>> HARDIRQ_verbose+0x10/0x10 [  415.140908]  ? __rq_qos_issue+0x28/0x40
>> [  415.140911]  scsi_queue_rq+0x760/0xd80 [scsi_mod] [  415.140926]
>> __blk_mq_issue_directly+0x4a/0xc0 [  415.140928]
>> blk_mq_issue_direct+0x87/0x2b0 [  415.140931]
>> blk_mq_dispatch_queue_requests+0x120/0x440
>> [  415.140933]  blk_mq_flush_plug_list+0x7a/0x1a0 [  415.140935]
>> __blk_flush_plug+0xf4/0x150 [  415.140940]  __submit_bio+0x2b2/0x5c0
>> [  415.140944]  ? submit_bio_noacct_nocheck+0x272/0x360
>> [  415.140946]  submit_bio_noacct_nocheck+0x272/0x360
>> [  415.140951]  ext4_read_bh_lock+0x3e/0x60 [ext4] [  415.140995]
>> ext4_block_write_begin+0x396/0x650 [ext4] [  415.141018]  ?
>> __pfx_ext4_da_get_block_prep+0x10/0x10 [ext4] [  415.141038]
>> ext4_da_write_begin+0x1c4/0x350 [ext4] [  415.141060]
>> generic_perform_write+0x14e/0x2c0 [  415.141065]
>> ext4_buffered_write_iter+0x6b/0x120 [ext4] [  415.141083]
>> vfs_write+0x2ca/0x570 [  415.141087]  ksys_write+0x76/0xf0
>> [  415.141089]  do_syscall_64+0x99/0x1490 [  415.141093]  ?
>> rcu_is_watching+0x12/0x60 [  415.141095]  ?
>> finish_task_switch.isra.0+0xdf/0x3d0
>> [  415.141097]  ? rcu_is_watching+0x12/0x60 [  415.141098]  ?
>> lock_release+0x1f0/0x2a0 [  415.141100]  ? rcu_is_watching+0x12/0x60
>> [  415.141101]  ? finish_task_switch.isra.0+0xe4/0x3d0
>> [  415.141103]  ? rcu_is_watching+0x12/0x60 [  415.141104]  ?
>> __schedule+0xb34/0x1300 [  415.141106]  ?
>> hrtimer_try_to_cancel+0x1d/0x170 [  415.141109]  ?
>> do_nanosleep+0x8b/0x160 [  415.141111]  ?
>> hrtimer_nanosleep+0x89/0x100 [  415.141114]  ?
>> __pfx_hrtimer_wakeup+0x10/0x10 [  415.141116]  ?
>> xfd_validate_state+0x26/0x90 [  415.141118]  ? rcu_is_watching+0x12/0x60
>> [  415.141120]  ? do_syscall_64+0x1e0/0x1490 [  415.141121]  ?
>> do_syscall_64+0x1e0/0x1490 [  415.141123]  ? rcu_is_watching+0x12/0x60
>> [  415.141124]  ? do_syscall_64+0x1e0/0x1490 [  415.141125]  ?
>> do_syscall_64+0x1e0/0x1490 [  415.141127]  ? irqentry_exit+0x140/0x7e0
>> [  415.141129]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> get_cpu() disables preemption while the spinlock hv_ringbuffer_write is using
>> is converted to an rt-mutex under PREEMPT_RT.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This is likely just the tip of an iceberg, see specifically [1], but if you never start
>> addressing it, it will continue to crash ships, even if those are only on test
>> cruises (we are fully aware that Hyper-V provides no RT guarantees for
>> guests). A pragmatic alternative to that would be a simple
>>
>> config HYPERV
>>     depends on !PREEMPT_RT
>>
>> Please share your thoughts if this fix is worth it, or if we should better stop
>> looking at the next splats that show up after it. We are currently considering to
>> thread some of the hv platform IRQs under PREEMPT_RT as potential next
>> step.
>>
>> TIA!
>>
>> [1]
>> https://lore.
>> kernel.org%2Fall%2F20230809-b4-rt_preempt-fix-v1-0-
>> 7283bbdc8b14%40gmail.com%2F&data=05%7C02%7Clongli%40microsoft.c
>> om%7C9bcc663272304e06251908de5f42fe3b%7C72f988bf86f141af91ab2
>> d7cd011db47%7C1%7C0%7C639052938514762134%7CUnknown%7CTWF
>> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW
>> 4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=WyFA
>> %2FIUPpZDcayM%2Fj7Ky8%2Bm93bey239zVWguDspSbdo%3D&reserved=0
>>
>>  drivers/scsi/storvsc_drv.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c index
>> b43d876747b7..68c837146b9e 100644
>> --- a/drivers/scsi/storvsc_drv.c
>> +++ b/drivers/scsi/storvsc_drv.c
>> @@ -1855,8 +1855,9 @@ static int storvsc_queuecommand(struct Scsi_Host
>> *host, struct scsi_cmnd *scmnd)
>>  	cmd_request->payload_sz = payload_sz;
>>
>>  	/* Invokes the vsc to start an IO */
>> -	ret = storvsc_do_io(dev, cmd_request, get_cpu());
>> -	put_cpu();
>> +	migrate_disable();
>> +	ret = storvsc_do_io(dev, cmd_request, smp_processor_id());
>> +	migrate_enable();
>>
>>  	if (ret)
>>  		scsi_dma_unmap(scmnd);
>> --
>> 2.51.0

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

