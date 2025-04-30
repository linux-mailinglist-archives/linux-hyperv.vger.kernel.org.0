Return-Path: <linux-hyperv+bounces-5262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B585AA54F3
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDA21C22637
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9AB265631;
	Wed, 30 Apr 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hE+ANYdZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DF25B1E3;
	Wed, 30 Apr 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042295; cv=fail; b=kJK/yNsZwwqrOtxDf22i5r5VZgfO5X/iMIKNixAqlSDaJCKt4qdQhGUh+m2gZzTTEyDye59KRxrMxydzVGLlghKJvY1dg2KWr//2NIFyYFr36+1Y4VOWkvypRk3ppH0Sml83I2wOHGaUU1S2HQTFiDVir2a8wzWTyamOhqriWdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042295; c=relaxed/simple;
	bh=fv5vc4RTWQojF8ra55cs1TEclpWoGDJTZu0sD8CtePc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kt4dCYRxnYi76GsyCSf7lRE5KirhdYmo8iQu042HL4Nu983il74lt8j8o30ao8sbwUOjfjqxp4gH6z1bSZchm9jNPexX6I4zwhKJorUkfEEIB4wRk/Ebo/lG56RKuJfTIT73ELCtFKNRb6EDypVxVeY6OYHOoDAfu/be/ckk42k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hE+ANYdZ; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqmaMsnon5VL1aBeveVd2TXd5HEjagM9Qm/8BnjkqJeDtYHBcKrn0ePY+OKLpHKAfF3uAQnRkpsQl2+a02jLvSta3axrIKZjEwWYpRumWo4cuSaJwKdu8NuKTiKwHBGCB5f3bphg266JZQNMeC+F171x5jD1VjEeJ1d08gVB05x9SQZrstLpKesUpmLZx6N8erceURSbkgOf8RVKKeVHp35ZCDfWMny7ZPMr/xEw+KJcUSOOjwntAABbHUGYLelJYGdo5BXyAqXn4j393HeW89w88Uy3do4aWGAc/liHE7XOpqjhY8qw+FsyOIVNpfdGd/tIrV7FtPrz2nX5Zl2MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgXIoSI4QvsLbtyX5IB4UVA0w8TEiDwzpUqAn45KTE4=;
 b=POqI79+CgTdQOalGxqahtH6KJq3w1oqrRLepFEsDZkHLeFZEXDdI8Bvoo3uVQsUSRSQcOjEMpSYVOLygdp703SlO3CGV7nNdD3beG9dPsUl25EWpGaOkx2d7H+OQkVTH0nsPdf3x8oJbgVrMv2l+k8DlnBnqr8OADEs2BpAtfUStF8X/+F5IOWfwmy5IWPcvguF3mZ7KK+8bLMkQpzxYKebKCMtOaP4nNYtRDCnDg+JezMlxPiuRS1AzC6ietocLdSy5yLULtVK92+ZjIochY16kA+jZKFXw6IaY/bSTJmU+ZMX1Opyq2q2f8C9fIo+mmOQcQCbmnKjcp0U4M/YTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgXIoSI4QvsLbtyX5IB4UVA0w8TEiDwzpUqAn45KTE4=;
 b=hE+ANYdZGr9EWNf2JIr7JowNgIYceQ/f2t5cb22FdBcED55KjlEw2dnEKlG1kese5yNQL/ek3mHrOq146w4WIyCfTEckkSxZZnmJe3xnIcVWw/0tcl/h8KtJrF+tNJxfNRF6zjae01m075ct8WIFlNh9yJMx0wIuOJolpTQ+iqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:44:51 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:44:50 +0000
Message-ID: <15be9f01-717f-51a1-6a5b-3bc4335d2506@amd.com>
Date: Wed, 30 Apr 2025 14:44:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH hyperv-next v2] arch/x86: Provide the CPU number in the
 wakeup AP callback
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Roman Kisel <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, dimitri.sivanich@hpe.com,
 haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
 jacob.jun.pan@linux.intel.com, jgross@suse.com, justin.ernst@hpe.com,
 kprateek.nayak@amd.com, kyle.meyer@hpe.com, kys@microsoft.com,
 lenb@kernel.org, mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
 perry.yuan@amd.com, peterz@infradead.org, rafael@kernel.org,
 russ.anderson@hpe.com, steve.wahl@hpe.com, tim.c.chen@linux.intel.com,
 tony.luck@intel.com, wei.liu@kernel.org, xin@zytor.com,
 yuehaibing@huawei.com, linux-acpi@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250430161413.276759-1-romank@linux.microsoft.com>
 <87cyctphqo.ffs@tglx>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <87cyctphqo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0038.namprd05.prod.outlook.com
 (2603:10b6:803:41::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 8341aa8f-b89a-4b53-5505-08dd881f7880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk9oUGVMM1N6U204bXZrMEpZTUNjbFQzVHVwZHppUmFkMkdGY0pSbk5pS0da?=
 =?utf-8?B?cXlxSzFXQVZ0bjJOY0w0SjBSQmhWYnJ6cmZCWHJMNlZEVml5Y01mOWdML0pr?=
 =?utf-8?B?bnZYZS9NNHY5anptRlRhUDBBN1V2dWdWWUUxZ0ZQVTlGQVlQMmUxUnp5UklF?=
 =?utf-8?B?SEw0WHpvRmNjb056U29xQklWdnFPOGtab0ZlNG53N1FzYm1MeFVwU3F1Y01r?=
 =?utf-8?B?QXBPOWdZUEhYK2diOEVrUkRLQkxSVDJpZUR1YzVzZ200QlpiV2tPUjNtcFk4?=
 =?utf-8?B?RGlXR0k4VzBRRWVhaGFjRjRkRHE2U1puS2NpWndUT01PUE16UEhWNDB6OE1T?=
 =?utf-8?B?MGM1T01NUUNXc2pvSjh1ckxnMmFWUk9rc1VrSTJJNlp1OENiRGt4ZGlxWXM0?=
 =?utf-8?B?R0ZGaWYzSkdySytndHZvb3oramM4V2I0aTkvdGJVNVk2RTZFcEJJRjdYSGJZ?=
 =?utf-8?B?QWd6YmJkMlhxeUtBaHRGajI2Ti9NN3JYdngrRlFiaHFIemtFVVNmWTZDRW9U?=
 =?utf-8?B?Z2VyL25yZ0kwUk1uaENKT0hIUklucVNGRTdnbURLN25XdStNTzNMT2pTN0Ft?=
 =?utf-8?B?SkVpblh2T2pIeEdTMUloZm5WME94V2hSMjM5M3lGQXRzUEI5a2kvZERyRHlD?=
 =?utf-8?B?eWNhaEtxUy9IZ3dudEN5OWpwV1U3RjBnRVNnMllqUnczYjVEb2htMmdPN0I1?=
 =?utf-8?B?ZkY0S1lnVEhueFRsMUtRakNPeHB6M2lYMjlDMkxTOEhBODFmaXVQYnpQS1NS?=
 =?utf-8?B?Y0NlcDlsRXFDZlU5blVMNCtQUGJEdldSdHlESFpnR0pZd3lWWkZ0T3JyRUlj?=
 =?utf-8?B?akMxR0l3NUFHczY1bnh2Qk1vWGUrU0FjQUh5L05CN2E0eUhHVllzMlVtRVNW?=
 =?utf-8?B?aDhwbXJCcFFFTVhjRzBkekg4N0ZZUlpxZ2l0UThySzFpWHk5WlY1Wm1GdjRh?=
 =?utf-8?B?MkVUZ3ZMUWM0NVBpS3JnaTJLMGV3TDR0Mm4wUGZTY21SdFhrNFkyZU9WQlpQ?=
 =?utf-8?B?UDFNeWI4RlV6WnY4dDRxMzBoWnhTcWdnWTRaZXh5ZWt6c2EvNFdZazMxN2FY?=
 =?utf-8?B?SEtOc1RsYkxBbk5INDArOFQ4UEdzNkhLMTNPY1NEREJ6cE10Yi9OejZuRE53?=
 =?utf-8?B?ZmQ5NVAvNnpWaVZ3ck5IdHMrTWRrZGZ5dU5BajBwR2VyZXlwaTRmQUhxbFJj?=
 =?utf-8?B?L0xXTnE3RGZOcG5yWmFpdmJoTHNVZjRidjQ1b0pWeTRMb0dRRmxHZThyRCtG?=
 =?utf-8?B?RFgvSnBhc25MZVFVREJ6YTVFNHluTEdDVTd1bVAzVFNpbDdGTm9YVmZRbDAv?=
 =?utf-8?B?NVhxdk00b0RNZW1wZUZDMVV1Q3ZqRDcxdGduYW5ic1BtTThXVy9lVndQVElX?=
 =?utf-8?B?U3pVRUJ1STZORjk1ZGVhSW9qOUwrNUl5WGlGMW9QVWJRamVMSGg2eWpwNENj?=
 =?utf-8?B?TlFXRExHRGFjR3lKc2sxckthN2FlVExWL0xjTEl6WXIwYjZpWTFBU2plSU1G?=
 =?utf-8?B?N3NPQy8xUFVkbFd0RVNCaW9mdGRXdnlrRExMYXdzUFBNY016YzAvOGV3NVRk?=
 =?utf-8?B?NVd5aEtmcHFCTDIvczJHNUczTGhhN1ZhVkUxYjRRcTlPUHFzcnR1ZDl3VHB2?=
 =?utf-8?B?S0lhRjRqOWtOZmtGdXcwYlFkVUpOWXdwdWdOMlBUTlNrTGpOWXBRK09uQVZU?=
 =?utf-8?B?RjdMR2paNloySk8vdys1NjFGUmxSekRsWkJYZmdHaXpGbVNoVWI2NkNGQWFD?=
 =?utf-8?B?Z3RuVWtSajdEM29wVDZLbFpUMTBkSVdsV0xHelRUNmxKejh3azRLSzlMVTd4?=
 =?utf-8?B?aC9MTXZPc3o2ckxTaGRDRGJNQXJzUkt2VjM1VWp1UHhhY3ZoR1lkVUZIYTgr?=
 =?utf-8?B?YjExZjhuK2oxMUxaNWRxbWI2bXNLOVNweUNHRkZQVHhwdUZhU29RWU85dXhl?=
 =?utf-8?B?di9jbTd3U0FpdnRrUzU4N0Q3NHVSUDcwNDdPeE9uVjJ6cGtVRm4reDRmb0tv?=
 =?utf-8?B?MGE0R2hQb1pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVV4OXo3emo0ZVRvZkpJd3RhOXd5RGJyZWtHRzVWRkhWV0VNVE9TVzBJZS9O?=
 =?utf-8?B?c0U2UkxsSjNVdFFuK0o5cEoxRThIR0JqcWhLdWl1VlFkWmVUQ3RhcCs2YTZk?=
 =?utf-8?B?YmhOTWx5TExqN0VBa2E4aStSQXZ6U1R4enRPUnZQYk1GWlRWTmpoRWd5SFlF?=
 =?utf-8?B?OCtRVEtPakQzK0Y0OVpJbGJzTnZpSzgxYTFpcnFVQUN4b3d5V2kxZElwSm9j?=
 =?utf-8?B?aDU3LzdQZTVWOWhmRkFIQUcwUFJ2ZVY4azBocHc3K0UvbW53dzZsK0QvVjRj?=
 =?utf-8?B?RGlaYUd6TDNLNktBc3ZqKzVVR3VCUlVCMEQ5bkc0OXFXVWZ6M0I1MkYwbWZz?=
 =?utf-8?B?c010emF0U1NMTm91N2ZNdUUvM1pNaWt0RU93dDZtMkZ5NzJWZVo2UWVReGhv?=
 =?utf-8?B?WGR2RVE4R1FUQ0ZSSTVpdUh5cWpqQ0J0WmROWldtcldSYzlRdG1OZjM3bHo4?=
 =?utf-8?B?NnI3MGowRDU5bUdDNW40U2gyVVY4Nk1ld01jN00rMk9uMHZPTHlUczlLMGpC?=
 =?utf-8?B?aWVwcWJ2NlA4aFFEY0tydU5uZVlnUjhybTl0aEQxdWQ1NU1xV2ZwVDBJaW9R?=
 =?utf-8?B?M2NIYno0ejY5U2RVazdEM1Z6QW5OZmxsZnk2Rm5naS81ajFHWFUrQjhxRmQ4?=
 =?utf-8?B?R2YrVEJvdVc1UzBoUlpBZmNaaWRJVWhpZzZnVERJV2t1N1hmTjAvQytjTEhS?=
 =?utf-8?B?M2Q4cnZpdXV1Q3lDZU03bXZiSWJBanhhZW1SeGpZTjROVTgzV0hLVEJsNHdn?=
 =?utf-8?B?ZzBkSHNlclU3Zmd3MWlSb2FWaFhsbWNsVUtvZFNLc0draVk3M01BMlByRnIv?=
 =?utf-8?B?aDJjQ0xuM3RZWjBuSWRIa1NLN2lGYlZKa0VsbVRYdlRac1BPelZNeU0wUktD?=
 =?utf-8?B?cFJZSlI3K2dzMVhuQ0NTTitzVFNOZ25hNEwzTC9tZFg2bC9ubGk5MUdyNW5w?=
 =?utf-8?B?SEF1b3F1dmtWS1BBNFdqSVA5UnpSK2J3RHNwUlNrNjZza2MxaWFSN3l6RW1l?=
 =?utf-8?B?ZHB3VnVKMFVwaG5pdVBIdkFJSDYxcGRNY2FnVHN5Qk1ESHpDb2JnNjd3OWVF?=
 =?utf-8?B?c3gvZWptK3VlaERWczNici8wZXp5SjJSNEMya3FNZkcrVlFXbGF6TTcySzFS?=
 =?utf-8?B?eThZLzRyZmNsS2JHS0VhR0JXMkF0Sno1cjF3U1hEdnJmc2JjNVQvdkM3UkdF?=
 =?utf-8?B?dDI5VCtMMm1IdlQyeUYwcUsrcFFMdjBnZ1BuSjhyTi90ejZ4RWVKbWNoYUtj?=
 =?utf-8?B?Q0xFTHRxenFFajd4WEVKL2YxeURrMURGQi85RENybHZUK3oxZlJaVjgvNVg3?=
 =?utf-8?B?cW4xbVZHRklpNHVEbGN6c2paSFkxUU1Xdnl2dlhnY0ZyVzBQZzFxd3JRenY4?=
 =?utf-8?B?UGlYYXptN0NNQXRuK2g1VHE2aWVpSC8wdXVhRFRHb29MKzFMcXlLLzdtUnd1?=
 =?utf-8?B?RUZMT0RmNVpRZ3dpblJnMlIxeHpFTlJNSlFWL0pZTzB5L3BIcUh1Ykg5WjVF?=
 =?utf-8?B?TVdHVitaRDdNd0lVYnlSZ285MkxrMERwU0pkdTd0SXh6MFZ6amYrRVp6RXA4?=
 =?utf-8?B?YjArSzV1b3VDSDB3UVdaMWpJRlY2bGY0cGlDM1VCazVKODV2V1dDTnRhWXR2?=
 =?utf-8?B?VzNSbVdtdTd3Z0paKzVFeHFubGpid2Y5WThlWlI1ZXNZdTVOM1N2VENvVG9p?=
 =?utf-8?B?SkpmOTdqTDVPZEErcGlkdDM1Z0NlNElLZWh3bDArY2hrTXlsTFN0Tm5WVWdE?=
 =?utf-8?B?eHd5STBvMW9CVlBtUFpEaGlGNDN1NjZWT1NLMjBrUkVBMHJrWGZTaFBYOXFo?=
 =?utf-8?B?UXJLdTFFTE83Mzh5VStPbEVDTkRyUGhnWGNnSDJ5TVJoMlhMWnp3UG96MVpv?=
 =?utf-8?B?UXFVQTI5Y2ZuRzlmUHJNTUdYbDdGSGFzQlZUbE83aWY0OG5UNU1UZWlkTlBa?=
 =?utf-8?B?bHZBb0lyTmVkT3N1UGV1UGZzVmdlMXB1YkV1bVQ5dFhVU0VEVHJKOFZyeEhD?=
 =?utf-8?B?azNENm9LTU5MeHpMOURZeXhGcjZvNHptMjRJNTd6YkFjOHBMYVpzaklHNHZn?=
 =?utf-8?B?VFRDSWJrL2llWnp2bXBrSXRBZC9GWmtPb25GTlM1cmZ6YW5ZdkY5cnlIakl0?=
 =?utf-8?Q?F+HKP2B2s40QjWUMUbBRS8sjB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8341aa8f-b89a-4b53-5505-08dd881f7880
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:44:50.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aySLTTZn4R+zOewqMsRD6cRTmRe2RgGe7if+RjTaq0iufpdfC8OCIEJSq5DgdjcnvWhwImijwIR1w7+1/1ZklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

On 4/30/25 14:33, Thomas Gleixner wrote:
> On Wed, Apr 30 2025 at 09:14, Roman Kisel wrote:
>> -static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>> +static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, int cpu)
> 
> unsigned int cpu please. There are no negative CPU numbers yet :)
> 
>>  {
>>  	struct sev_es_save_area *cur_vmsa, *vmsa;
>>  	struct ghcb_state state;
>> @@ -1187,7 +1187,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>>  	unsigned long flags;
>>  	struct ghcb *ghcb;
>>  	u8 sipi_vector;
>> -	int cpu, ret;
>> +	int ret;
>>  	u64 cr4;
>>  
>>  	/*
>> @@ -1208,15 +1208,6 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
>>  
>>  	/* Override start_ip with known protected guest start IP */
>>  	start_ip = real_mode_header->sev_es_trampoline_start;
>> -
>> -	/* Find the logical CPU for the APIC ID */
>> -	for_each_present_cpu(cpu) {
>> -		if (arch_match_cpu_phys_id(cpu, apic_id))
>> -			break;
>> -	}
>> -	if (cpu >= nr_cpu_ids)
>> -		return -EINVAL;
>> -
> 
> I just looked what arch_match_cpu_phys_id() actually does and I couldn't
> help myself to get a fit of laughter. x86 uses the weak default function
> in drivers/of/cpu.c:
> 
> bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
> {
> 	return (u32)phys_id == cpu;
> }

There is an x86 version of this function in arch/x86/kernel/cpu/topology.c
that overrides the __weak definition and does:

bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
{
	return phys_id == (u64)cpuid_to_apicid[cpu];
}

Thanks,
Tom

> 
> So this loop is the most convoluted way to write:
> 
>        cpu = apic_id;
> 
> which is valid because the to be started CPU must be present, no?
> 
> I'm not opposed against the CPU number argument per se, but the
> justification for it is dubious at best.
> 
> Thanks,
> 
>         tglx

