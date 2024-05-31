Return-Path: <linux-hyperv+bounces-2268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B58D6833
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 19:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E021F26269
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 May 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF817B404;
	Fri, 31 May 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PsL9h2ho"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41152E3F2;
	Fri, 31 May 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176897; cv=fail; b=nvvc+qO3NyT3IBHnhq4Vh7xon6MFSYHIvbyaOcofiLenNMRRhj4Qlotw6oWNyVF0QONAO4F8v0EkZkeaUWlXfwtbnJ5mNcsEXiTHn1Lna7IsyfKmw8Xpoqror7LtNArZHJBHg/iKap36gYakuWpDyq/1Xv37is/WUao8q/nfFl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176897; c=relaxed/simple;
	bh=HGbbPn0j7cSGbgxUWMBBu1dBJhQERpAie1cW8BITsbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1f4EJ4gLH50MTf3hnihz/00SNgxz8VCy4Uwj4E4tw4tFGt6lYQq3b7mJPorOjETE6hkPnBjhxCR/4Z/XZtzIukuFO0l9V8q2qVnKOyFqhsgM9beZcef8N86PqbAAKOdjkSh6JNQhw14u5dFwLZaqzrSG7T2c/F0V4DvCTHTU9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PsL9h2ho; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJhbAgIpyuoPRsYceDKT4/CEC4zFyR6+1rDCuuM37JLKHizlbb0+hInhYaW9BxJfN3AqI3qfw4S6P1RLlRbxYOqghpjrQyqdIpgXMu1Im4hu+cxxzJa4Hi4jOxoBpHrnaa470ML8O0zsVA4ZCoisaOn2cl85Mer4f5wvuvN0L+opyzW+vQ1z/QpeF98uVe9tIMB80TQrl6lrqTEsLgkdRTgBX5H9A958Nkn/3J3FayRsKdq/bebN9Yboul/8cVwcn23272GC4Aorv0mNOU7q5nZShyyrRkNP/8lrYyd1ct2lKSvXOz9E6qr0aiJTlTHZszUJhK2lmIDb8HBSp7Z2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoaySfdFh0dO4uC3xsOiM+R0hlt1UwwokZlhF1tZNqs=;
 b=kDRwA6hrWkT1LaPvSHQuNJWm2IOnUkHWgE4oP7sO8L4/2qKXwTKzRwGMkBPg7/W5WHNh69nRD5Xnc4X93JxLKn+zHkRVEEBltlJ1SB9zyFJ98tt40WNvRNq/m5P4CsN/vApWMToMddTYhSQXWg83YMR2u4l6OZofvVJhc4xhARLGXwRrn7+xOKn5jclfm+2giGE9wzOsxC6D0znWCSM+2KXF0LbMMxi++ySnPDp3UxzKSVJBL/nVh8b3VALRaxMQ0mPvFaTKIIkEQ3S7OJ21GjKKnk/qEw6iUrzQW72+xfq09AhCkvxLvf5nkT3UhdS1wnhFA2/vhrSoV1/Y3UrGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoaySfdFh0dO4uC3xsOiM+R0hlt1UwwokZlhF1tZNqs=;
 b=PsL9h2hoYa8YDeAJaHrKB34M7Rfdro0R1dJNTRnj0Vj+h50EFBaB1M+ROpItUmPQ9LH8/bDIFjWYU4XlbkJKhOwOFHqkqJNZA+hbxOZjZF/G/dS+JeMcMLHIx7NapdhfBDG+HyHyEdBPLwy2XEWBQoHBmOxI1wZrfpMLGI3J+8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 17:34:52 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 17:34:52 +0000
Message-ID: <75cb309b-b05c-42a0-a3ca-de08fa1cae59@amd.com>
Date: Fri, 31 May 2024 12:34:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:806:121::30) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: df64b88d-5847-41d3-8d6b-08dc8197faa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0Z1OWJ2aS9ib2Z6YW1xV3JrZjBObzBpUUg0bmI2ZWRWSlVDMEFSZWdsMGRL?=
 =?utf-8?B?Vjc5OGQxU1R0bzRqQ1Y3eG9YcmFpUUVsRW40VzROUDg1TXRzdUR1bDJ5K0gz?=
 =?utf-8?B?dE5XL21nT01kc2ZuNUxIRXp4eW9ZYk5adVo1aDl6SzhSU1lnLy9GVEJleUs3?=
 =?utf-8?B?aGpvV3pYeFJocUR3Wm03WEtuQk81Tm9Ga0pNMVQvbHZqQnF2OFIrV0dOY0I4?=
 =?utf-8?B?N2xoeTVqU3FzNUdLTHJtMVRXb2JCaTFhMmsrSlhwL0xaZ05PWmI4YlcwNVdN?=
 =?utf-8?B?T0NvTjhWY0s3ck5HMngrRVNlZVROaHNPTlBJTytGd2pqUFltWldrQmtmK3o0?=
 =?utf-8?B?c2VCd1FBNWRRbnJQSTFKR21GV0U3eERDV1RsV3RCeEtsclhLMmhXOGhreVRn?=
 =?utf-8?B?aU9ITXp6T3l1OGttc1NNYmJxdXB2dEhHVVZXNWljd2s1MWhjdHNRbDNFS1VI?=
 =?utf-8?B?M0lVUGhxRklBTHVEU3VEY0FjTkhOK2VBZ2xZWGdYQk5JVENsMjJaaVNsdE9w?=
 =?utf-8?B?YTEzRm1JejZQbjdEa242YmJxdkZjNUlxcVY4bTgxOXhVUHpRQ1NjR1QvTFph?=
 =?utf-8?B?aHMrL1I3WmdWTjAvelhYaXRGWGR0S1hZTTEyNUh5MlBpdUlzRlNKeFBhODg1?=
 =?utf-8?B?S3BrRkNsUTBPaGNVUXFISVFla2hUS2pHTlY4NFhOV2dRK0RYSzdZVG12N2N5?=
 =?utf-8?B?b2hhVER5bG91VzZrbC9KTDNnWEUvNTVzMUlNRzhka0dXRTM2Z1JnbzVueUxr?=
 =?utf-8?B?Wi8rSTNhbHpKaVBkYlNLSlhzMjB1YVBJZk5KbytyM1VJR0R3NzhuTXk3N3Vk?=
 =?utf-8?B?SFVlTEpaczVCalNtcGd5UTRuQ0FzZ3hyQXFtRE9mSXZmRndhU0VRWkZuTWNr?=
 =?utf-8?B?ZXYvTE45c1lwbDBTOE9VbWRXaHMxT2lJV2U5QVNKYnlydW9lNUp4NVc3VXNQ?=
 =?utf-8?B?dFZaRmQ0c3UyQWc4eFRTdmlON2VqQnFlb3ZoRFhQcStQVXhOZHFPckR1ZENU?=
 =?utf-8?B?eXlNMi9vTWJJSEJLM091WDBZMUZDNWo0Z2NZcDhGMXNGbk5BTk9nSkllQVVC?=
 =?utf-8?B?TmZtaUxkS2hTb1U5K2VyeUk5eFdWc0xJWFhlankvb2NDNVZFTFNTWkwzK21i?=
 =?utf-8?B?eHRjYnEyWnJjRHJMWDRXNFJJc3RwMGFkRm5qTjhCckFSeHk1RjhIamJ6UkY1?=
 =?utf-8?B?TkpUNmIvelB4VEkyd1NUd0Z0NURhQi9jOGpPaTFBbHlxbFhuaVhpQ01iVHFo?=
 =?utf-8?B?L20rUzRjY2VVNXYzaERaR0lpcmtWUXF3MjQ0Ny83djBTOVR5MERkaVBIVXZX?=
 =?utf-8?B?UGhqSXR0bUlRcWdwaHVjN3FTVkIzNjZ3YytJSWNXaC9yby9wQWtCcFBLZ1Q3?=
 =?utf-8?B?MEZQY05DTWsrVFlqNkFxcmZDUnVPYUEvdWxTRXJlMmx2M0dYUFF3MnBvRGlB?=
 =?utf-8?B?emk5SzJvNnRaS1RRL05sTENhSFZQbERZZk52aXcxcEFxbGwwU2VDVUJpdU1m?=
 =?utf-8?B?UGY2TUp6U3BBMWJYUkJncFlYS0JLY2ZJRVdTdHp6TnlqMjRsdU5EVWZtMGtC?=
 =?utf-8?B?RXBsMllDakREYVNHd1o4QWNZcysxQnRCUy9sQW9BOHpFeEdQNURlQ2pKY1p0?=
 =?utf-8?B?alpRTERwaTZQNzVEOERJelpwQUJVWW8zWnNOc3hkQ1VJYStKdDBDV0dJTitE?=
 =?utf-8?B?R0JBUy91SXptNmNFMTJXTFVlR2pVZTNwd0F3THU5Ky9xanFSV2FsdG9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXZYUDdnVUZEY3BRM0VKUHFFNmVJUWJUT2RwMlVITWpvTnhFL3FNbG9JdjFr?=
 =?utf-8?B?OUQwYnhqaG03QnZjZjVOWlBKcndOVjE1RHlrQjBnTHFVS1VUaWZrZEtSQVB2?=
 =?utf-8?B?RlpNcjB1MzFxekRzUHp4d3FyWFRoc3VKU0hTV3JyTFZXVjRjMkJJNnpoWEVU?=
 =?utf-8?B?dWF3TisxdCtLT29mK0VxVk9rK1UrT0FPNXJzSDh5RXBESVJFcnZ0MHNPeHli?=
 =?utf-8?B?YW9rQW9LTzhCZnhpeTJ6Y0IyZC8yeTMwS1VkMzRUS01Kd2V5aGVaK2RYM1pO?=
 =?utf-8?B?aW5zQUxQSGdWWk5sVjg1VCtrdVRVcHp6cXErYkdSd0NFbUkvOTRkSzNJQW5u?=
 =?utf-8?B?M0tzdEp3Y09xMGUvTVBKeWg0ckNFTHJZb2xpVk1ERFpQU09nNHNTYU1PWHRT?=
 =?utf-8?B?bGVIdXg5amVuVTlHcFFtRmFubHJCZG5RY0ZnYkxRd3Z4elB3SG9Za2lZVU1E?=
 =?utf-8?B?S1p0dGdUQ0pSWlJjdEh1NlUySzhZMTF0YnVBNW5jd0pRejl6L3ZVN2cxT0Nk?=
 =?utf-8?B?L05hYUpkTWpoWVJzR2hLc3JUZHdDRFhLUUpyeXZLTHhzcGxuTkl4Z1hhQ0JU?=
 =?utf-8?B?YUp3R0pXRm1ZT05MVFpNRnFmR0phTHV4M2tpOGNOV2lETnFHUVV3QWRlWWtP?=
 =?utf-8?B?UFhLaU5QNW9QZm5kZEhnUWRqeUdtTElBNUtzYU9BMElmL1dSV3FnTExnZ0Ey?=
 =?utf-8?B?MWpxMEZUUE1sWWFrVm9tTGdGY2VOdkloaGUrYXJBMC85QnJOVVg4R2dzdVlF?=
 =?utf-8?B?bzZhLzlGQmttVVNKcUFxdG9aNmFybCsxNk8xalp5SWFPSU14WXRhMnh6dDFx?=
 =?utf-8?B?U2ZQUzdXdVYvSENCNWJsT21SSDdLN0ZuVjdEekhWY2pNeFh1WVJuNUh3K0c3?=
 =?utf-8?B?YjNjMGJuUVp5cFVQZFlPZHBPQTlHWWxiV3ZYVmg3SzVHRHgwR25FV1FXSU5C?=
 =?utf-8?B?VUtXcEZXeTBjYkNVUEJiWnZ2RkRYblhIeDFHWDQyUUN3WWh6bkZna3c1U09F?=
 =?utf-8?B?Q0RpL2IrTEE5dmtvb2Z4NVFLMFlpQ0hoSDMrQVlYbEIrc3hqZFJKYS92QTFm?=
 =?utf-8?B?NmN3L2w2YXc1ekVEUkdoNmlFUTZuVlplTTBsWURPaE5uZVQxNzRuSmlqc3Ez?=
 =?utf-8?B?T1ArS25TUjNjQjdJVE1sU2wzR09xcHUwTmhubTRVc0dsUllzUlRiVUR2eWZ5?=
 =?utf-8?B?TG1YYXBMcCttYnRWeCszd3lsRW1DbHF3dDJwWVhLSVV5QUZDakJqbXlOZVBE?=
 =?utf-8?B?RFNQRU5tMWpNRkFoelMyT3ZJdzM2YWNZa1FFOGVacEJUMlU0MGpJT25EMDNm?=
 =?utf-8?B?M21OTGZiQ3NxbzA4Ti9DZUkzL0Z3T0ZOTzFlYnl5RVFuOHJZc1dBOVFYa2Yr?=
 =?utf-8?B?RkwrSjZlTkVLbXh2Y1lxTHZpMEs0Ly9paEFmWTNQNmFrc0YvcEdUYSt6ZGI5?=
 =?utf-8?B?K3JWMjlsY2JBY0x1MnFRaEJxV2JIZGtxQVpJYzZnK3k1dkVwT2tROG9aU1Y2?=
 =?utf-8?B?RFZwdjBJam9UNExWcWNuQk5IMHdmdmJSQnpCdkNzWlRiUU1GNVp6d0lhbFJt?=
 =?utf-8?B?dmhGQS9taXo1eVVZeDl6M1plSWEzUklhb2Q1MFZ2RHNJdU13SGNOOEhSTmdt?=
 =?utf-8?B?UlVseGlYZk0rR0FTbU1rL3k1OUtnSXlRQk8wemR1ZVRXcHVlUUVjcmw4SnRj?=
 =?utf-8?B?RHBiUmkvYUJCUEd2T2RLRkJwaXNCYW1ubEc0S0tIU0VHcStCb1A5K2NRVmNY?=
 =?utf-8?B?d1kzVHMvS3E5cFRlVlkzdFhTTUJta2hYM1Z5VHI1RFNUVE1aVmdWMGVHRlBs?=
 =?utf-8?B?Q2d6TGxVRnp3NG14dFJiMEw0enJBZkdETmpKd21xSS9LVnJjaStnYmJ0dXBr?=
 =?utf-8?B?ZzI1bUROcHJ2c2RZWi9TUjR3K3hRN1JtZm1mVEVHeFU3bmJVcWJoUG16U1lM?=
 =?utf-8?B?S2hjUDcwaTVkVHZmMHR1TS85NkJUSmNMQzk3N3hNNkZPUmdvQ1A3ajV0Uk1T?=
 =?utf-8?B?elB2THhocWlndGJJc1RUcXNONUg0eEhIR3B3ZUdzSElpZzMwbjgxMjdRZnVq?=
 =?utf-8?B?MFo3MXI2c2lac0JSRHZJZ1E2SHhiOHVsdUt0WXl3UjZzMlR5R0FJTHVjcnZ3?=
 =?utf-8?Q?BBgkNZhiTwGfW9UBkd1RBYmOX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df64b88d-5847-41d3-8d6b-08dc8197faa5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 17:34:52.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RluoCCIPvHPGUK1eLXUJ6QtR8F7LnSAZPticLq9SNyRw5eCyRC5Dq6EbdzORfMtAvUp/yxtg1R08csf+daBqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793

Hello Boris,

On 5/31/2024 10:14 AM, Borislav Petkov wrote:
>>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>   {
>> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> -		return __set_memory_enc_pgtable(addr, numpages, enc);
>> +	int ret = 0;
>>   
>> -	return 0;
>> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
>> +		if (!down_read_trylock(&mem_enc_lock))
>> +			return -EBUSY;
>> +
>> +		ret = __set_memory_enc_pgtable(addr, numpages, enc);
>> +
>> +		up_read(&mem_enc_lock);
>> +	}
> So CC_ATTR_MEM_ENCRYPT is set for SEV* guests too. You need to change
> that code here to take the lock only on TDX, where you want it, not on
> the others.

SNP guest kexec patches are based on top of this patch-series and SNP 
guests also need this exclusive mem_enc_lock protection, so 
CC_ATTR_MEM_ENCRYPT makes sense to be used here.

Thanks, Ashish


