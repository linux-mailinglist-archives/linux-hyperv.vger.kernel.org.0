Return-Path: <linux-hyperv+bounces-8673-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLh9DfuRgWl/HAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8673-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 07:13:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1BD5136
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 07:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6913B3011059
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 06:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA536AB66;
	Tue,  3 Feb 2026 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j6k4nmdj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18040214204;
	Tue,  3 Feb 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099030; cv=fail; b=PFr22g/9hqqX/+h82gl3o3BieUzj6gxhP5J+VyVUtNlPGCLQVaRXXf//YW1TTgpNpmsaCBOO8ChVN13ZXpv27EqIZSP7712Mxx4UwztAxMv8mZkl5U1lERO2bq8tp16OoP0ZalGAyca0cAeI8OnXNNd52lhxjF2Ud7TvAgwKy0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099030; c=relaxed/simple;
	bh=qwl+bUMf6poOlhBPELB57/R8UJRrF+gfJuKJJZH9Zc8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYoRCCLIlVbax7arFclOd/I8iZmeVXUN+QZHmkwbkP1Gg5egK2RdgHFwOVMWwmECYP05b1E6iU3jf0rm2ne1cm2mFrpMVJpLXsU/3b4aGSG9QqgoWm3NbVEvHH/QoRm+2u2Rjlw04VUfEEYycO8NgzNLYHqPd21kEXsTi/7XRy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j6k4nmdj; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsAY1TceDedJa2JxZnpGZHNNWoKc2k8fs4zsPimDttO77S3Ky6EK+5Hu2DIs4+mdYtDDk1mkxXZUnpnBPCZifDZnfESPvEbfd7dpSnCTEObhe1CGk/SXifzMeohM3eoB1L9KvcU8Ejo37ACRiUuNJfJbTvCeWQXqHxogSvl2UN9RXPwUpk9sbp6MqgmAJaygUnMpSdoncYUO8FHaI5PqPZLg4pXKZ+8ZwbJjAtcc2sMVfrGwWT3GaeuFS6qc+YcNJk/vzuTwkGO38QLAr7cG3cX7yNBdrZIXpyyQG3PzuJuFbI9H1EIg8OYcaqydIhB0XeSV+i61NHV+x9P+OVOgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/Thibamfald1OsstcchDT3n3VI4p6afZADxsM1GGO4=;
 b=een56Hl427a9VgFudBO6iqFy14X4/9cv/q1bUiYOixVax81D6/sd9eck+eDanLjkUYgjYhSJMFoyagpKd8tWruU8fu+V5LgacBlpk6iwdwsOhZH9e2bgJzrbyis/dlb7Wf+Fyaqx/Wz89MDEGJr95zT5rW3iMGbIhOtNqIzQumr6GtagzIqW4WqPTLxytWL0GvadjKsus8LEI0ZphSftENzI+f4xwN03JjF2WYugNhReb+G09mkT2b8BMJB+MnOsgkH6YtwQPY98D1lISJW3RWs7HmzHENQMBiQH7wYGR8+2jxAHW0WdXowUbyJWRSeS256LmXjh3kGNOVAuKxStYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/Thibamfald1OsstcchDT3n3VI4p6afZADxsM1GGO4=;
 b=j6k4nmdjRf5PAjrawxdiWzQAPlBEhIjpfF9ti7lVMwe0p+W1NghrW1uWVHrubx3liCvfppmyp8+rYE3ytLQvyZY0AfCuv5IEZlY5bf81Wn35fLGXfs2hZ46cQyfo7QAP6W9R9CnBDHfcMku6itN5+6MnV+Yl6t38V7kSQ55Ms6BuIzrYMXVNAsGpVpXQXTFR5Zkf9E0bWClUv3Ufz+B2lHwIm3s+HtlH9w2PhcU6Ot33yxwLOe7/M7CzQEeOu8VVXxRQ0q2FWfQMQ4GlTrJmZ2d/XchK9o1VuL0CAfrO4UDU4zKoB/WLUI5GVaFIWtFYvUM15LmJIN+nrF7lBdxj6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 06:10:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Tue, 3 Feb 2026
 06:10:22 +0000
Message-ID: <aafa4a1f-ceef-492e-a842-60d684b0b01e@siemens.com>
Date: Tue, 3 Feb 2026 07:10:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
From: Jan Kiszka <jan.kiszka@siemens.com>
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
 <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: aa28ba5a-524c-43c6-0ca2-08de62eaea0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZCd1lxSWpFN2NzeWRHelFwYmI4ejlpekNvaDdmMGQ4djZTVnZKaUcyVnZO?=
 =?utf-8?B?QUNCUU1Ta0xieS9kSVNFMVppNHZwamxuTjByZnNRKzc2RUdCRlc0VUpxNnBC?=
 =?utf-8?B?SnpjL3JFQ1g1RFlUeWNsNFNtTWtMblJScHJsZ1M3aGIrbUJzbGZnNDE2dHJk?=
 =?utf-8?B?WFkySVFSSDZUM2thclBVOTNCeXZpNWhpRys5WHFHaFpYditIVWNHYzdLUys3?=
 =?utf-8?B?enVBMzMySWhjOTk0R2dSOVBtcTVLTU1uRG1zQm1aTC9BZi94U1VwNklybjNr?=
 =?utf-8?B?cFdlZHJET0ZaVzJWNXR0bnVoSmYyeFE3TzZ6ckF0Uy9PdDM2YmpqeGcya3ZS?=
 =?utf-8?B?eFJSVXI3YkgwZ2djeHUrWDBvSXUyS3RINjNJYkFKWFRRR3l3cXBXK2lCZmpF?=
 =?utf-8?B?SHZyNkRpWHdISXhkSVEyOVhVd2dHVnRIeG5rVG5wd2JaeWw1NHdoNHZvY0ZO?=
 =?utf-8?B?U2RJQ2c5YmV0RExGSkI3MGFjdnJ0VGRHeGlCTTFtdlJNN3BlSFB5eGpZcVMy?=
 =?utf-8?B?eFpkTVFBenJNaWIwa3BpN2Q0MS9wdldSbllrVzVDL3Z3TDQya3ZIUGppNWVZ?=
 =?utf-8?B?a3RWMC9neFhDa0xDU1l2Rlc3YmZDTTZ6ZktsdXFYdCtHUVNnekg0bHpzRm5C?=
 =?utf-8?B?Nlg1MmFUUzJBTHhrV1dydWdpM1JBTXVxMStnalpWN0NVWjN6Y0xYNXREbGpB?=
 =?utf-8?B?RTFvcEdHb2poUURnZHVxVjF0aDR3ZTRJM2RjVk1XQnlGdjlaY1N2S216bzFm?=
 =?utf-8?B?dlNzc2cyY2pVak94U2drWWRkQmxFbzdzSEg5aHhxZFRXTFdVM1pqQlBLTG5X?=
 =?utf-8?B?Ulp6cDJTNXFrVDlrZW8zdkpCV3pXQ295dWpvMkpkU2FZZVdyNi80a1FxdmxT?=
 =?utf-8?B?TU5hZmlnOXg5cDd3UEtqTzdsZHNMeW5QSmZ3NThNdzhPQ1NSYkhWMmZ0K2Zz?=
 =?utf-8?B?aVkwREZuUVJpVFROdzZkdTZNZUlqMmQyMmJRaTQ0UndneGc5blhMQ0FJQjZB?=
 =?utf-8?B?RThVTnJCd1RmcmNNcmZsdW5YUEY4bk5lalpTSXNWYndnUU9QQWJNUEFnN0gy?=
 =?utf-8?B?TE9VZUtKNGJWd0FLeEYwMmhmK0lwcGxiVTk1K2d3cS84TzVFaUdnNE0vMXZy?=
 =?utf-8?B?b0orWWhQb3k3WGtjMzVUTmhSbVBUUFR2d1FvaEMrMVJQNWtBYklZSW5mRGN5?=
 =?utf-8?B?RFdGRi9ybXlGWmFUbG9aVmhUaDhpUmpMNmFJMnF1UUxHNVdNRy9FOVVTSEVD?=
 =?utf-8?B?bjhtbitINnlnQ2k0N0FleHF1TlRzZGtoSjRpTGZNdVFGQU5HZ1J2MHNsdTRM?=
 =?utf-8?B?QzJUOFdRL0NVSWMvU3hiZGI1UHpMNHp0VzE0ZDA1ZGZtbWZIRW9sWndhRjUv?=
 =?utf-8?B?V0I5ZzkvNWNsMllobVFFQjV3RXZvKzRNbzBrNWx3elVNZi82TkFvN2tFSVdX?=
 =?utf-8?B?RG56TnpYcGxuK3lEdFYrbjIrbFQxNS9iVEJQK2NzMGxGZjBDVDlyZys1YWNx?=
 =?utf-8?B?U2tMaTIvWWNuSG0vQjhicnNrSUNhbE45QlpKWTQ3VVZpeGZYcXprajBZMDY2?=
 =?utf-8?B?S3VzdlhKOW5Db0pkNm1pQXg5aTV6b2xrUUlVWVNIbEcxSVFpVEVvZDBYTEta?=
 =?utf-8?B?ODVBOVNWQmo3UERRZkduT1RGN0dxbGgyaXVtWnF0aFlEcm9BaHFraGhLUUFq?=
 =?utf-8?B?VkVVNnZxUTBBOWNLOHRleURTNGhQWllCMzFORGlDZzJRTWFnYTRCaU1rNGNP?=
 =?utf-8?B?alJ0VVVUTW8yc0UxZTIwOTJQOFYxdDg5T2dVaW40bXUwcXJwMTZ2cmYvMk5Y?=
 =?utf-8?B?SEhjRXJIZEdCUUVoK3RGd0VGOTZnMDQ1QlNhWllEeG90K29NbDhUV01vYnNX?=
 =?utf-8?B?Y2l2VEVEc0pDWnZtYkNXNEx6MmxDWk9UdlRhS0xLdTJCNytzRnVYQXZTcFVo?=
 =?utf-8?B?SkozMjhQSnVUL2ZBTmhwZzJjTktJVGZ3T2xPZ0JaM09XT1hlc1NvUEZJc215?=
 =?utf-8?B?U0dxRm1JU1d2dkZ5RUd4R1paeVZsT0xGMkR5dStBc09VeE5JQVVmMENNZnpZ?=
 =?utf-8?B?MGdDbi8yZkwycUVSOXhyMmo1eVV2VzJKd0Yra2ZpZzNZVEh0dlJwRTY5citF?=
 =?utf-8?Q?HwMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZSRmJ2UWs4L1EwaHlzeThQNmtyNmgySHRlcTNsWUdJSkltVVEwVWxXR21G?=
 =?utf-8?B?T0NSWkkwMXcycEFEdVV3d0pDOFh0Z0NLSXE1Kzh5SVI5bFFETWdvQlpwbGFH?=
 =?utf-8?B?dEpsN2lKY1ppcU1zcjZ3UXk1ZE5JUms3ZnZrdWhyZFpIQU9WdStIVm1CbHhI?=
 =?utf-8?B?a1ludEwzMkxIUHR3NE56NVA2L00wZkJJcndHZUlpSzB6TzhMWCsveW5SZ2VK?=
 =?utf-8?B?SkpQa3BqTzMvd0EwcWdCa2F2OWw4ZkFua01ianAwdHVBVUcxT1BtMXFGZnpY?=
 =?utf-8?B?bS9GbVd5ZWtIUzlsUmNBZkk1SDFxbXAvQ0dZaUpiMGZpbkViVG5GR0VVUk4y?=
 =?utf-8?B?UERyajVtaGlLVER1RUN4UStWbWpTcWVybnM2TVpHOXpaTm5EN3pTb1pOUWNJ?=
 =?utf-8?B?OVZXQ2FFOENFeG9ZR3h4YWxWREsxcUpja3VNWWJNLzRHZmNkZ05SUzlNemFh?=
 =?utf-8?B?Yk92dW01eEpYQkF2VWtxTks4ZXJRdTQ0c2NBa21abUgzWjlBd0huTFFpanUr?=
 =?utf-8?B?MFRwSzNqeWc1dG1KMWN3QlNoQnBFUm1WRlp4aWU0ZDhocUphYmpNMkRJMG1j?=
 =?utf-8?B?OVVIancwMzRSVHorV0NwTHlKYmlLMzJQQzduQkdOUHE5T1FCRWhEYVlkSGpJ?=
 =?utf-8?B?T2hyd2J5OW51eFhhMUpFVzhzQWlhRDhUbSt2dDBhMktNbkR4STFOWDgyN3dF?=
 =?utf-8?B?RWRqK1FMUW10c3BGVVRacGxYb29sOUFUaFhUVlByeGxBN3NBdDV2SmZQUlFV?=
 =?utf-8?B?VUF1TGVPVmNRT1RKVVNFYmRjOUYvcERXRzdVNnBNclBZdjFYMCs5eFpFWWI4?=
 =?utf-8?B?eEtnYlRadldPVGFBQ01BSkcvTzNMNDRzcDJLTzNlOG55Nk0vb1ZidGJPTU4x?=
 =?utf-8?B?TVFmcGZnMHphZ0MvNS9EMTdHcTFlVmpkWjhZQlJCclZHb0lzajc5S1k4OVh6?=
 =?utf-8?B?Wnkvc25FZWYwOGgrZlJFUmZwR0NaMVVxSmRtaEZFRXBNaVVpQjJrNDZGeXBK?=
 =?utf-8?B?YkNEdU5Ob1lPV2pGd1VyNHlsenRuamhuRnFKSTlxeEdTYTIybVVzR1E0MHVx?=
 =?utf-8?B?dWh1bXdjbXQyVzJYbnFPSkNUUVVyTjkyN0ZYQ0ZDVGliVGhyelBJMHN1MGcw?=
 =?utf-8?B?a3ZNeVI1eUpVUUphUXRuTzk5YlBDZlFGRVp6YXF6cFJiNVhsclpLM2x3QUVr?=
 =?utf-8?B?Skw3QThoSm5MSlZaUGRRTVpndDRhNmZIUkV0cHA1TDBuNGt1YjVsbkpjTUJY?=
 =?utf-8?B?b3Ywb1dBSE1GMTNBOEVDZHVteVNtdGJjT1UrNEFpSGtaOS9pdHFJcytHY3ho?=
 =?utf-8?B?L1RXQ2ZDdk9mL2xsMEw3N3QrckdtSm9iMjJ4c3picHYxTmw2dy93L2FaSjJO?=
 =?utf-8?B?ZkFwNm50dWx1Uit3WTZOWGhEUU44eUNhUUtkQVBLN2sxZDd0UkQvejdEMTJx?=
 =?utf-8?B?YTA5SytvbU5uTENxeTRVUGhUeGNYMC9FaXd3RlpkWGNBTkg1WkNLMjdYYnRN?=
 =?utf-8?B?Z3ZjVUhPQ0xaU2cyMnMwQ0FDQXRGZENLY1grOE1zaThESmhLOTI1M01aRU4y?=
 =?utf-8?B?ZnpBUTM2STlCVzNBMFlMdHVwbmNXUDlHZnp0enlhTHlxVEt6cDhYK2tlTTNu?=
 =?utf-8?B?clNucEtQUStsdFB2a2ZTN20zcFpoYzBpbWlzaW5yS1d1RmFvUm9KZjk1dGxD?=
 =?utf-8?B?N1p0dWg3Kys0OVNkLzJ2TE53UzRvUXZVeGViTWpRMVVVb3FBVkk0NlJFU3Bl?=
 =?utf-8?B?Zi9hVUZIUUxuOHUwaisrN29YV2dOU1N3VXdFaXArSVBObXpqbmszeXhaNmpJ?=
 =?utf-8?B?d0lvNkN5blVMaTlYNUdTSXg2UmdiVnNNU2NRVlZ3YWhLTzR1UVhtL0UwU3oy?=
 =?utf-8?B?Ky9LMDhQMzRmb3NqZEdIQUJvaGdjczMydjhndFE0ZWp5YjU0RkZXRXpVMXVn?=
 =?utf-8?B?VUY0cTJIYjUzdFJrd2ptRkVTd1g0Z3FhOWVZYTlSVzcvL2FFdndXS1ZDa0JO?=
 =?utf-8?B?NjZ3ZHpwSmJyclhpd2pHSjhDanZpeHhaUkNZUEtEUnRSdkkyV3VqYUVwdzFw?=
 =?utf-8?B?MGpkK0NyRmxVNzVSd200Ly83eitmVkNibVhBNHhqYVVsdlFUUjFyUmJZOTkr?=
 =?utf-8?B?eWFTajVWb2JiUTJvbVJTaHFEVkRtWXRndG1PMkhYWnVXRHpLRDdJOWsvMUJo?=
 =?utf-8?B?TjIxRkFiQ1A2TWt1bjhHWVF2aVdEeWZWbE9XOHI4NkpMZWRPd3RQMXpTcFBx?=
 =?utf-8?B?QmdvQXF4SHArbnlsblpZRUJyQm54bzg0U1JCQUdFY2hsb0MwV0w1M01yMFJv?=
 =?utf-8?B?UG5OY1Vzc2ZPSzNqd1VnUjdnR0tzUFBIelJZdVd6QzVsbHBlQTVyQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa28ba5a-524c-43c6-0ca2-08de62eaea0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:10:22.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnAat4oImhE80rijJznKGgRg3kMG0wzvlvn21vyxn/81iOwHmEoPm9fncv8TT3SXWkD9Nvf71D0cWfkkbJBEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5888
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8673-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1B1BD5136
X-Rspamd-Action: no action

On 03.02.26 06:57, Jan Kiszka wrote:
> On 03.02.26 00:47, Long Li wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This resolves the follow splat and lock-up when running with PREEMPT_RT
>>> enabled on Hyper-V:
>>
>> Hi Jan,
>>
>> It's interesting to know the use-case of running a RT kernel over Hyper-V.
>>
>> Can you give an example?
>>
> 
> - functional testing of an RT base image over Hyper-V
> - re-use of a common RT base image, without exploiting RT properties
> 
>> As far as I know, Hyper-V makes no RT guarantees of scheduling VPs for a VM.
> 
> This is well understood and not our goal. We only need the kernel to run
> correctly over Hyper-V with PREEMPT-RT enabled, and that is not the case
> right now.
> 
> Thanks,
> Jan
> 
> PS: Who had to idea to drop a virtual UART from Gen 2 VMs? Early boot
> guest debugging is true fun now...
> 

OK, after some guessing, the patched kernel boots again. So I think I
also fixed the broken vmbus IRQ patch by threading it under RT.
Currently building a kernel inside the VM while lockdep is enabled.
Boot-up and first minutes of building didn't trigger any complaints.
Will share later on.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

