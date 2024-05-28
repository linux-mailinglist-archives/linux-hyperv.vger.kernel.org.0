Return-Path: <linux-hyperv+bounces-2247-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E725D8D1E49
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1671F1C23026
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89CB16F859;
	Tue, 28 May 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zAY+mxhX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CD1DFDE;
	Tue, 28 May 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905767; cv=fail; b=T7KV9k9QkL+OhWT2snqWkKuP6kcFYl1GOvUXBJ5U4aSi8B1+LwwrS9ToAqZ6m0ZHODYy5AS2FfaIwTXzBCbAt9bCxDdnt6XbvgLuRYI3FksM4SykgrJz+9PmqzrZE4xEpor6+NNjWIVoLYVzJNnOgU1tP0ngziWTpSv0rZfpGq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905767; c=relaxed/simple;
	bh=Gx3Bb/CT9SWi4Bbb90iGIjb/49sXBvZqqE+DEx4J6qE=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=pOtLICvufF18T6yH9DNALkNTgaeyqZmFkgXEr1vARz+BQR4ABSHdsC1I+G7jY6PAm2jpuvVRjdt+Lu8D55R9KiqAxqg6x6Be8SltZPd9qg/jIMfgKoXVqwNYuDZYr6xPJAdRww1BFGR/X1k+PbZSwiDS5PpSAK6NMUsiMn/Pk08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zAY+mxhX; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP2C6xOImG7i6uJDxXusG4v4v359lojrJMVkKTCrTrPddAmA1XrxB64ij6S4TnCiTD+CQzofBeBRo83zrbPfhKkarVmxSbN/TWGw68LDURmyYeqvl33DEW2onpy3gt+M0WkmGMpDLpmW805xkgQzGJzJQruoJhzxxumwN7n2lgRIZDNTCbvajntMrBcIFnYpQga0u+049yS6y3xAahl6vPrDm59aDPkgfRbsIEM2ZKLC06RzW4FtBTnLlILUUJo7NWb14KAIjrt499Qy/LjT5HzdsLt0TmMXy8kxitGIdi39YzIZ1bD45qfRunRbEjNGSilMu7pmZepf+P0sdsFplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10KGGjV3C6GGdkoXQDxe6mBBleVbv+rk4X1pq1vXnvY=;
 b=V9b32us36lHijVLEd/9XV2p+v6pTRWph3EhmLBKTKLDEParW0DF+fhiCb4DqPiIBBETvC1rXU5Z4onxDykxZGH7TS9UVEBcTfU0buZP0KRMzk1hFTJO9ZnG4epPHHuXJXDUJFZ4WWlKI+zQM4LpIiaQ6wjqyEHwe/EZ0Kexr3fsxh3qTVC8bCsyBPJtYdRVfWf8rbKLgwnRhcxj2xrruC5dtunbQcZlJ6DzmpcIziHw4s/Mh9Ld4qOKA4BsU/2kCUvL8KBP1MHUT/NvQne+Rut+p7CSUIp4tD7wFK5RzWQdNQJWi6NaYtGYSNagnIs9P9WZ8dVFvsK9/UjSEQ3o2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10KGGjV3C6GGdkoXQDxe6mBBleVbv+rk4X1pq1vXnvY=;
 b=zAY+mxhXTWOpEmTd6lKcwiMn6+DvFeMY+kKGDqCByRu0os5dEylUhRXRR4HmIz6PzGR5LmlI1MLmXmoiRX5P/jQw2zazc3EwwmviIykTRGcY1oBZ1h5D9WO4LUyRvox4ihjhYgpFpnr8uucYT3pzpDNODpUxeuBEBHBF2ZzaTnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:16:00 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 14:16:00 +0000
Message-ID: <eb470f47-9957-a8d6-c5c2-aaf5ccc8b9db@amd.com>
Date: Tue, 28 May 2024 09:15:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>, Dexuan Cui <decui@microsoft.com>,
 Dave Hansen <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 KY Srinivasan <kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
 "tytso@mit.edu" <tytso@mit.edu>, "ardb@kernel.org" <ardb@kernel.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20240523022441.20879-1-decui@microsoft.com>
 <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
 <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
 <SN6PR02MB4157B940ED0A5F39D49A897BD4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
In-Reply-To: <SN6PR02MB4157B940ED0A5F39D49A897BD4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:5:14c::28) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 84795d6d-68c3-4c17-24a4-08dc7f20b334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1N5WGpndzM0cWRJQjdyMkZkVlA1WkhOcXZudkVxb3gzeDByc3hZZWp2eG12?=
 =?utf-8?B?WjRESHFnY0ZWOGkreWZ4ZjVjbGRYamZBMW9uU2h1ZkRUU1hITUlGS001d2xr?=
 =?utf-8?B?M05MMnZDSXVYN0dQRURtNWQ0SU5hRlF6Q2gxUFQweVhNWVdXNTIzcXUzeUJM?=
 =?utf-8?B?VHdZbDd1RTFRVjZIaTFCVGh2SzZqalNlam1MTGdJUWFqWVY1NnE5ZHhrblRC?=
 =?utf-8?B?bXdad2VDWDZxKzY4Kzg3ZytoeVdPVHlMdDZxSmxiMm9rMU9lTFVlYm9xOGlF?=
 =?utf-8?B?UXBtbDh6ZVlEbjEvYmd5ZGtYaWpTL256M0VzM1RBbkRvdXptL1ZlMVVHdEpV?=
 =?utf-8?B?TXZIVTc5a0l4ZHphemZsek5jQWd0dTIzQUxuUTJvaWRvS25vbC9nejkxckgy?=
 =?utf-8?B?akVSeUpQcG8xTkd1UTdnRUljbk5jbnlnZ04rc1VQWjRzNnUxMnRjTlh5dm9z?=
 =?utf-8?B?RjhWZG1ROUJXWkU4b3I5M210eTkzOFVGWHhaR1VJWW5XeFB1a2VXZzM4eGpa?=
 =?utf-8?B?LzRlZEQ5L3g1emRmeVFleU5HWTVYaVlNU2d3cksrNURpc0FyVkRvRFJrYVlK?=
 =?utf-8?B?RnF3UDNYVTltaExmNUVxUFJhbFd6MkFRcG02ZFB4VElUbCtBUHBpTm1yYXNO?=
 =?utf-8?B?R2JpYzNsUWw4Vk1HKzVzc3ZIY3JReUdPM3JRK1pHSDR0V2F5dzY2dU5ndE1B?=
 =?utf-8?B?a1ZiZDNsQVNIZXZsL2NtSzlORUtURXlJUnhIdDJsOXh0akdnQUFxcUhVeXBx?=
 =?utf-8?B?bjVrakNTWS94NlZwcUlzbmdQRDc3T2FtQW5TSU1BZW13MC9ta3Y1czNwWVEv?=
 =?utf-8?B?aWVSS2FPcWdwUVdYbU0zRlJCOURkTFE1N00wUUZ1Z0hrc1pnUFZZaDFWQU5C?=
 =?utf-8?B?bVBHZ0ZsSmxCaEZ5SzZjR0x0UGRMTnlPRE1VdzhBeWNCWEtiK0lUTnhRSzRN?=
 =?utf-8?B?SUVSYTJKanZ5d3YwTWJScWhuellyMTA0c3J6Mm9GVHJGR2E2LzdlQzFtNnVN?=
 =?utf-8?B?ZXFGSDJqdWJ5MWNMSXEzZVJOSFRaNU9wREtsVVpTcUhGZHhVT3I5L2FFT1d4?=
 =?utf-8?B?eXM2ejFJYThCL0wycTN4WVNkMTB6U2tDSDFXUmE3S3I2ZU8vWlNvM0NZM2hu?=
 =?utf-8?B?VzZzUlg2bmM5UmltMmgwb04xVTJlK1RsaW9JY0RwY3Q5WDlyTERNbW5PaHd5?=
 =?utf-8?B?QUtKQnkrbUZQaUxoeUMvemFYWkRXaU9LRHJpNWdpNndFekFEVVFFays1WkFQ?=
 =?utf-8?B?Y3J4NDVRY2kxSDE2dVJ4Sy9jeFNTS00vc1ZodWxZUnZhdm5hUGo3S3pISXNr?=
 =?utf-8?B?Ui90a1BnbDFqZ0dCbjdkRVJWTVNsVitWU2JVQm1UamZZQ3pjdDd0RlRSUWN3?=
 =?utf-8?B?S290elNrbUcxYnJGcFIyY2JWSmdNMVl6ZW5LQklSQnRSY3k1cWI5dDVYNndo?=
 =?utf-8?B?NW9QYzBIcGhBcUVPZUM3dldoaHFtb1Q3eTUvZTYyejRuUndSeThEeWExOUlz?=
 =?utf-8?B?a3E5TzhMbDJzdXdRY29IWEFUV3lVVkJNWmhtbGlmS3JUaTc0QlRkVEZiS0hx?=
 =?utf-8?B?eWNrWWxGL3A3REt4OGcyR3I2MlQ4T2huQzdrOFMzWmFhQTFwajViR1lJVTlU?=
 =?utf-8?B?YUQwaVpOZ25zdXhPN3NMTzZKZURYdE5kOUd3Z3QzT0RjMW9Rck5IQzhhMU05?=
 =?utf-8?B?Z1ZBWmsyYzNpMkMxU1dFdlpxTWV5K3UramRDL3lRVmhOazRKV0h3U242YVZ6?=
 =?utf-8?Q?t1yS7HvE5Gmy7I7lZi/IC37KnWuav2sRRzbic+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXBiYXg2dElqdDM1cEQwMENsV2hIZ0pxUGU2elZJQkxGQlVEQ1lYMlh0UDJk?=
 =?utf-8?B?RTRqRDE0Y2Q1YXAzaVJRdGVlQks1c3ZXOXY3TXBIaWsxZlRIMzZ3SDQrc1B1?=
 =?utf-8?B?V2Q1OVMrOVpEejFzKzJNV21uc29rSjF6Nnl3NDM2WUJLbXF0TVc4L2R5OEx1?=
 =?utf-8?B?bkd2RXJIR3RaTVk5Vmd2d1FYTDg1QnhSay9pVzNPSTFVelNLN0h5R3h1K2Vz?=
 =?utf-8?B?cXlmUE5yZkxsNVRFMUZtRFFMSjgwK3g2Umg4MUxUVm1MeGdKZ3pFQU9LMmJ1?=
 =?utf-8?B?S2ljcmJwY0MxTHQrTzFJYURXcVhSWGNEbVU4UWhvUUdzK1FWaXNxN1paUkts?=
 =?utf-8?B?Ukdham4rTEphOXd4N3o0Um5NbHhiMk5iOTVjL1JDbi9BSGFpNGVsR1hSdnho?=
 =?utf-8?B?KzJBc3lJK2NkN0lSNTZmVHJqbTFZem91aVhjY1ExZ3BwQkx2b3hpdXVLK2ht?=
 =?utf-8?B?Lzkxdlp3Yy9GdG9tczJJeE9aMFh2U2h6aGdOZ1FuZ3NtejBrMnFnUUZCYmFs?=
 =?utf-8?B?WDRPdm16azEzN0JML3IwTmpvUkhCK2xXRnZkUi83ZnNjUWdMdkFqV3M0OC8w?=
 =?utf-8?B?a0ltSmNNVVIyblVwblY1bXBXNmgreTFTVlp0Z1FvcS9WVGxoMzZScklKSHh5?=
 =?utf-8?B?ZzltbFlpbkNhWjg1enN0ZXZlT00wS0FvK2w4VkZtZXdWNzV1d2dmOEJPazhr?=
 =?utf-8?B?L1NhaWJybjhidVVMTHJYeDdlaDl5ZjhsdTBqYmdEUDRwMzE3dlhFYVZkNTFT?=
 =?utf-8?B?SlJNN3FrS1V0UFN2MWFlREdQNXNqUUlWanJYK0V6S1BDZUl4dEpHanJEeTJN?=
 =?utf-8?B?aTZoNFJzRHFOQmk3Q0hxTjZVZENUR3JQNTZ0V0gvTjdjUnY2RC9sSDdlY2U1?=
 =?utf-8?B?dFhTMExqNFVLNElFSzJnL1lQYnlGdEFWWmxqUS9EclR3bVBIUVRnNGdUOUcx?=
 =?utf-8?B?dDdkRHVveHV3dWhrKytKRy9UQzlMRElEUjk5aDFvZlVHN29Gd05TRVpZRGJF?=
 =?utf-8?B?ZHRMZW9HWDJnMXhQc1hQV1FYUDdJM1JBZnlLdmNVMmxrZWF1TnBoenY3cFlx?=
 =?utf-8?B?eTZBbWhsbWQ1Q0RDZEdqOGpINXNRS0ZiWDh5YWFld09mUXZpcVBIZGc1OTN5?=
 =?utf-8?B?ZW54VzluenhoeGdIZUl3bjlRdGdLejA1MEMrRGpXd1ArN2pWVnNMQnU3Tk1R?=
 =?utf-8?B?b2t4aGIxamFwU2U3NzE1YnRqY3lBUW0wT1hJbER3SzVFOWIzQkQ1TzVwTlIz?=
 =?utf-8?B?STVaK24ybXpCb01wbDNVNXJmRU0xZit3VVd2UldhNUY3aGd2UzFyYVM2Tyty?=
 =?utf-8?B?RWFEODIxSnBnV3JtRzJVNVJtNGRFZ0NoS2JPWVQ4Y2ppKzFEN29MM2RENURz?=
 =?utf-8?B?Tm00QStWNzJNR3g0Vmo2dm0zcjFUUlVPRG1wSVhqTnptc284TnlaR1YrWVIx?=
 =?utf-8?B?TzhIbGFJU0VnTEx1M3dIZHc2dU9GVE1EUGhqM2VyVUJUZ3VDenlyZm40NTlU?=
 =?utf-8?B?QTVXZUJhNXlYMUJhY3Jad2pPYjRlb1hiOU11dzdkcWxWVmpUeFNLWE90L3Jr?=
 =?utf-8?B?dlNOZDFtNnRkREJQdktVam1sQm9NZXVWOGxvOXVmZ2FXMHZNTkEwWUVpK2lD?=
 =?utf-8?B?K3BveE1BbnN5Q0k1aWw3a0xVYnZvSEo3S25pUjl2RnVTTVZGYXdhY3kwTWFz?=
 =?utf-8?B?emlKOVJzd045aFV1Qjd1YklkaEdxNmRuVFBmN0F2QWhNemV1eUU1dm5wc1dU?=
 =?utf-8?B?SGF1N3M1ZVFPSFhoODAvbWpBa2VuVjI2eWxjZFEweXhja2t4NDgxd3lkQVdr?=
 =?utf-8?B?clBVa3dJL215TlFGc08xbVIzeDJhbXRqOWp2V1k4RGk1YjJDUjAwSEk2U2lZ?=
 =?utf-8?B?ZkJRYlRBM2xpbUlPUkNyVEZ0UVkwUEt5V0h5R3o4VEFyMEJKaW4xMVJLSzVQ?=
 =?utf-8?B?R3ZjSUJSa1BsRjcwQjFXSDhvWmdvaWEwOC8zV1RJcFcwUFVneFhsUklncFJV?=
 =?utf-8?B?bUovYk1HNDZBcXZsRFJCdi9TY0RlbDdRMHVNQWJTcGxYQ3luQTkvRkk4OEZB?=
 =?utf-8?B?TEc4dlZRYjlPclNPbU9pRTNNTEMvNU1QVWx1cWxVcGZPdFR5U0Y1RUtkdlpo?=
 =?utf-8?Q?Vmt9kgRs52WbzsQbD1AZ2lH5p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84795d6d-68c3-4c17-24a4-08dc7f20b334
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:16:00.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oE5daOf+o53/my5NNSdZVDvrfSF/RFiVmWMMNokgW4JxmykrIPVv9bNdfGfMaBHT9H/fNKEVZnTARsx6nw/uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

On 5/24/24 17:44, Michael Kelley wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Friday, May 24, 2024 1:46 AM
>>> From: Dave Hansen <dave.hansen@intel.com>
>>> Sent: Thursday, May 23, 2024 7:26 AM
>>> [...]
>>> On 5/22/24 19:24, Dexuan Cui wrote:
>>> ...

> 
> My thoughts:
> 
> __bss_decrypted is named as if it applies to any CoCo VM, but really
> it is specific to AMD SEV. It was originally used for a GHCB page, which

IIRC, it was originally used for KVM clock, not the GHCB page, since
plain SEV doesn't use a GHCB, see:

b3f0907c71e0 ("x86/mm: Add .bss..decrypted section to hold shared variables")

> is SEV-specific, and then it proved to be convenient for the Hyper-V TSC
> page. Ideally, we could fix __bss_decrypted to work generally in a
> TDX VM without any dependency on code specific to a hypervisor. But
> looking at some of the details, that may be non-trivial.

In reality, TDX should also make this area shared as that is how this
section is meant to be setup. But up till now, I don't think TDX used
anything in the __bss_decrypted section, so it was never moved to a
common location and has remained SEV specific.

> 
> A narrower solution is to remove the Hyper-V TSC page from
> __bss_decrypted, and use Hyper-V specific code on both TDX and
> SEV-SNP to decrypt just that page (not the entire __bss_decrypted),
> based on whether the Hyper-V guest is running with a paravisor.
>  From Dexuan's patch, it looks like set_memory_decrypted()
> works on TDX at the time that ms_hyperv_init_platform() runs.
> Does it also work on SEV-SNP? The code in kvm_init_platform()
> uses early_set_mem_enc_dec_hypercall() with
> kvm_sev_hc_page_enc_status(), which is SEV only.  So maybe

This is to inform the hypervisor that these pages are now shared, see
below.

> the normal set_memory_decrypted() doesn't work on SEV at
> that point, though I'm not at all clear on what kvm_init_platform is
> trying to do.  Shouldn't __bss_decrypted already be set up correctly?

With SEV, yes, the pagetable is set up correctly. And specific to SNP,
the RMP is set up correctly because of the page state change (PSC) call
which also notifies the hypervisor of the state change.

But since the RMP PSC is SNP specific, SEV and SEV-ES require the
separate hypercall to notify the hypervisor of the state change.

Thanks,
Tom

> 

