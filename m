Return-Path: <linux-hyperv+bounces-2491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CA916219
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4345DB277F6
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38A149015;
	Tue, 25 Jun 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTy3URH4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3114900E;
	Tue, 25 Jun 2024 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306837; cv=fail; b=S7IYo2OE1reMZfvRahIDc9TfSBeivvr13cEEg8BuzizM/fSWz8AMdgDTOA6TE87nEH7Z+MikuDRsb5x8E1cD94Oe+J1SX+70LKz8sqpEHvysDb06EqDsGPnMua7TbG62MyyufiCCjMUghk3vVQsUAdqQEnh4IlanGdCBSZ7i4kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306837; c=relaxed/simple;
	bh=p2uERUAZ9k/TDlFkXvBr3A3ZjEILhPMVd00BmI5FjS0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XD6JlfjpM2XiM/Q3OnDDFjUemTcVNdSiEUmvtmRu9r79pNK+5rjcduJZJRwomwywnpuaUari4BSt7wkD0cwvI5FspRpXxIuMlEydWwOUXhmQi86I7Dmqjda0MAbDCdRfuWDk1I4LOud3u7J7k4Wic//VIDyTLj1EKzq9N/KaCKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTy3URH4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719306836; x=1750842836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p2uERUAZ9k/TDlFkXvBr3A3ZjEILhPMVd00BmI5FjS0=;
  b=LTy3URH44E7wbzSTtYVe297LVSdOgCLYcBrfWLdr4sdYMK0a70aYSgLs
   2f66Jy2iEfyG/10XRKc276vWEGLqp1YSgdfDo7hVhaQOr648QpkSZz6Hx
   x9g7DsmfN2O949VJYlXXvbprjYshlsqhTJIsq7CReB7JA497lyATaVncj
   k0i1EmHgNhX2CXeThZdOPjqbVEhiBNal1QC2WhdkDnEdGT//kbPysaBPX
   BtKUZhcV2cCgajQL65RuA6xEBwE3L7gIKWDfZJ6SA6PfMCieTQMgQ0/C4
   sDbm2eTgk5+mcLXptXqLLzTKK5aHrwdNsoSol6AOAO+aGyY5CNZO9ok0w
   Q==;
X-CSE-ConnectionGUID: 45sHJUPaQiWPw2IpY8Ez2g==
X-CSE-MsgGUID: wTIcG55fQTajL2VkC7n6jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16444089"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16444089"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 02:13:56 -0700
X-CSE-ConnectionGUID: FOfPwiRVTaeA8o6n16ZrWg==
X-CSE-MsgGUID: h0mCl7XrQaKvZoYGjUFrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="81121717"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 02:13:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 02:13:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 02:13:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 02:13:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 02:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjXdJQCnxP7pEwUZJmh6f8WiHlmoR5wATchama4r2yWa418Xk1fsNZ+9zQplxYEcwtl4t5gvbNC/DQuC0JdX+TMoZKChZxMJ2CXpEu9fnLFE63cqlOQ5TUuuvXMo5Q+PdCB1WlBrm9ep1QstSxUuFUbYc+ekhEVp158iNE5hdiXY6hhBaFbnJ9qd2NJiAH4y3+Apzmu7/0WIajtD4eAd4oLuGAXC3kIGc6L++kNC1DxUrXRapafBLnD9OZjejFfZEzCL9anfyv58snHZQKIOQKlSBxjL1eLDEoAjSgf/fayI+WbimFLtxB1qunxJfV98sXqxErOV13pfqcuPh8Rjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1iRZfAMXlDV8Ic25IcCkvID3oEZPuLl4XenkODxT4M=;
 b=CaP4MuP/xF1PR/oZ82pSwph4SkAu5rWfjjmiEiyfzK+0iDgV8V85I8hisjtgs2CElkzR3mkHw75d9wXnEEaSVisRbULaoJZ9ypO2fmMY4v3g5MKu8AMqU5yWDoNlBLjg8hXeNA9WATVr4Yhqoj2z3L8fD45aOxW5qCMh16WBtwzqJmK6CwR0FLx1t16eVVGpc9yqoqICQyfhkEd/QALBUVCgSv2lwWd6ytBvJwzy9jMkX6pxdJLm789Z/cx+sDuYhGs2ihbw0wJX457N1uqGjxCG2j0dhFFDqeuGLDMtf1x3vb3seeUXp1ApctowWZIPAPJJXS2gdULAFOYr2hii2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 09:13:48 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 09:13:48 +0000
Message-ID: <08bbd282-081f-433f-8b23-ba1cf7d95110@intel.com>
Date: Tue, 25 Jun 2024 11:13:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mana: Fix possible double free in error handling
 path
To: Ma Ke <make24@iscas.ac.cn>
CC: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shradhagupta@linux.microsoft.com>, <horms@kernel.org>,
	<kotaranov@microsoft.com>, <schakrabarti@linux.microsoft.com>,
	<erick.archer@outlook.com>
References: <20240625083816.2623936-1-make24@iscas.ac.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240625083816.2623936-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0134.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe515f2-87d3-46f3-6cfd-08dc94f71f6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|7416011|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJBVkh0dzgxcThGRDR3RU5XaU5TdUUwOEo3emtrKzJlaktjQzl6SHFlVW5w?=
 =?utf-8?B?MjBySEphd1c5VytDS3F3Q1dCaG16bXY2N3k4Q1kwQjhlZUl4cWwxb0M1ejZU?=
 =?utf-8?B?WDNUWGVGNmhKbGJPckZrV2dDMFRydExBQUE2bDB2ZTZDUk5SdmJFWVFFZUdV?=
 =?utf-8?B?bzRKVzBiWUUvaVlEOHovcWZFclVjQSsxaXdaNnNRQTFMYU1MWnE0WWcwdll0?=
 =?utf-8?B?VTJIcW1sRnlHVjZMUkl0VTVGWGdaSGhPdWIrWGc1dmpvdkZxeWpmcWs0TlhW?=
 =?utf-8?B?Qk1TUVdmQnNpUXhmQkI3UTBYQm5lNURJaXhHNkVIVkZUZlYwcjZHandtZXov?=
 =?utf-8?B?V2FDcWtDVmxzUUxLSGpJUU1KQ1E2UUkwbVlOd2JOdHpmRTNGZURMcWM1dXRo?=
 =?utf-8?B?eG5BeTZ5eXYrMEFLblR5ZytMbUVySEFLdTBiQ0RqU2hnVzVaOHVaRmxLYnlP?=
 =?utf-8?B?VHhDMFNxaGZjSGpSRks4RGpNVFBjY0taVjd3cjVNUGRTMFd6SENLaXRHdzA0?=
 =?utf-8?B?UzRMMEl3Q1kyVXRyV1VURDN4VmpjeFRzOUZLOE9CN25xc1I3SElYTWVKTUZ4?=
 =?utf-8?B?UG05Mm9rT0VSRUh0OWRNSFF5U05CU3ZHYlpHQm9wZ2JPaVhPdnNOck10bC9u?=
 =?utf-8?B?RGo3YmhqcGk1SGdSQngxRWlZNFpTNE1selJ1NlZBUFFWWFc5U2U2UUI5bFJs?=
 =?utf-8?B?ZGJFT3RidDNDYXRINmdhK1VVcjNIL0pMcS9KVm9Ra1k2aFZ5LzhNRVFKYXFu?=
 =?utf-8?B?ay9SazRzcWFBKzRXMG5McE52Mlh0c3hZVkVDa2UrWWE2WkFOMStWNDZHcjND?=
 =?utf-8?B?b21zd2g4d0tTS3pIRS9HcnlBcGU3NndXOXowYmpHVXF0cGtnelgwcWVZemNv?=
 =?utf-8?B?b1RIRm0zWGdCdXY4UWgxbjFYMkY3eDA3SFlML3FpeXRyT09Gd2ZFbXhXcExy?=
 =?utf-8?B?LzdObGI3YkhYQWs4Q21DSjZFaHJvbTRJbGt3QjZKa2xHNTRIMXJNQnpadTZQ?=
 =?utf-8?B?V1RYYUluU280RW9BVFVJamlSRENHYmFHR1JhbitrU1FlU2N2di9ZbHdOK1lW?=
 =?utf-8?B?MXFFTy9nam8yZEozUC9veUtsNGltVm1MODh4V1E2eVhGYVJvanVGL0Q1bElm?=
 =?utf-8?B?S3JNckxETWU0SFhDazFFSTVOdVdDL29SUDRQUW9ydEdXRThTdkhQK0ZFeTli?=
 =?utf-8?B?SkJvbjg0RzVZWWJoWHgwbkRqVjRKRmYzdnF0R3duMlVjT2JQc2hFcC9xZC8r?=
 =?utf-8?B?UnF1WjlRSGUvMGttdVk5UDFVWjZmMVd2ODA3THZpTk1hQTdOb0VqcmV2VWJu?=
 =?utf-8?B?bUtRNDZmczFPMmNnb0dZbTY5MTNmRmppK01WZ3BiOU5IaG1qdVB1c0lRMnNX?=
 =?utf-8?B?NGtGT0F1RnFkS0pmbWFzSFE2clFYREsvd2FPYURURlA0SW1MZHVNMHliTUtT?=
 =?utf-8?B?anR1Z2FxWXdZbHNtNURVNjZSWUpRYS9FTlNncUFuVTRNTlRGS1N6dTV3NkZk?=
 =?utf-8?B?cDVyQ1JaUFo0ejBEVUhpSVVDb1ZYSTFrTFVMcnQ3MmlXWks3MFUwNGhmblM1?=
 =?utf-8?B?Si9JNVhmNFVhY3hlZnBQVjM5U09lb25zajdXNnExeVFhYkF4alpFanoxWndI?=
 =?utf-8?B?TytobndhQTh6SkJLanU4dW9XMHk0djJyWUcvTE1WNXQ5T1RVcWZiWExxM1g5?=
 =?utf-8?B?MzlDcGFndkJ3M3NrM3dhdFlTcldMbVVOSGRrWG9kRWw2aXo5Nm1CZWlBTjZ0?=
 =?utf-8?Q?gCK03ft/0O3UET8+04=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVJrakgyaGd5cnRNY2hhREJuRzVUTXMwQXJwZVprWVN6UGFhZVU5OEFwZjRQ?=
 =?utf-8?B?eGxLRjlwZ2hJdlhyWVR0aythZy9OMy9vMzNZNDJkWDdrTUM3YTluVHE0VDZJ?=
 =?utf-8?B?L0pqcnpJcVZXek1BbFFXRTY3ZDhBbGV4aDcxRVpSYmNQZ1VLcTNVOUtoUGZQ?=
 =?utf-8?B?Y0lIdEUvUk9yR2ZPUzVVd0RwZVNSb0pvY2NuUVlXRmVYSEJSVkh4T25ML0Ro?=
 =?utf-8?B?b09UVThna1k1bkttdGJwalplY0kxcGtMbEFBZy96enRRNk43UDArTEMrM0E2?=
 =?utf-8?B?a094TnRoTWdNajhMbUJzQksyQWdZamsvT2pQVGRJVmRYRzNzNndraG5ncVk1?=
 =?utf-8?B?SCtRYllYTUVDVmM5UXdhVEpkZzJDK2VpM3crNngweUJ1OTBqbGhsZzNBcjdH?=
 =?utf-8?B?YVNUbWJXbDZGbTlabHhzVkFicWxYT0JqNjlwZGVRNUhEWk9DS2ZoUTJCUUgr?=
 =?utf-8?B?QVNDaDNxYTA3anlWbGZKT2Evc0N0NDZmTEVwd242cTRPZVNzNFJyN2lhUEMw?=
 =?utf-8?B?ZmZ6N3p1UGNwOWhidlBjZ29lbGE0QXg0ZlVQYW1GUEpYRVZ5Z3dkZDJpWVpM?=
 =?utf-8?B?TUQzV2xRNEJBK1pBUFU4VFRzcUhGWklqclBWdVdTc0haSCtlY051NHZjNlJ2?=
 =?utf-8?B?ODdHOS9oU3lkaUhzV3Z3N3laMVk4dFJQU2Z0SVZING1RUkNkb3ZBVzhVUThy?=
 =?utf-8?B?MGtZeXpkQXNRcXhvTWoweFhiK3JkRTRCVlhqSlZIeVBVbUxldzRHTjkxWlJv?=
 =?utf-8?B?dDUya1I4eHNDeFJVVmtsRVZFZHFZZ1pFNFBoOGFxZGR0RU1pam9Bc2dzNktt?=
 =?utf-8?B?QlhSWmx0ekl0cERTTmJzSkZ3QzZmTkdjZ0NTOFRzZDNSdlBDK1dzd1pzM3hz?=
 =?utf-8?B?VklLL0lwV2pVY2Q4bnpJZktma09PTGdnYUJaeTgrd3JHamwwY1FnT2Zycnpw?=
 =?utf-8?B?SDk0YWJTTzZuYm56dVc3QmVHL3RVK1EyeEZ4TmpuS200ZndjKzFSSThPSDNQ?=
 =?utf-8?B?YVFUakFERTlSMUlhUjcxYTF5Q0NGU3lXVEk0MnpYcmtqeW9yWklDc3ViOHc4?=
 =?utf-8?B?NXlyOHczbWU2eEZXampvQytuakVmQkgxdDJ6cERKV1pVQjBDVTU5SlV4UXVD?=
 =?utf-8?B?dHo2NHBDL1FRZ1RPakdTZkxCcW1YRHNYc3RuOW9icytKVzloSndSem51MHNj?=
 =?utf-8?B?MTN3eGozQWZHQXg1M0x1NlhqRFRpVHFRUDN2K082KzkyU0Z1YjJlNkk1Z3lw?=
 =?utf-8?B?OEVRNjN5bndZVVdsR3dBSzEwTW1Ga2hxVE1IZ296YVk0UlEvV0NlSDNyMzBN?=
 =?utf-8?B?ZzFnYTYrM1BOZUhXOVB2NTNhTjE3cVpiSGM3TUVCSjlLSjJWSnRvWVFsaEtJ?=
 =?utf-8?B?MVNnUEpZSE91bm4wOFJBTzhmRjlERXRvcVlPTjU0QnFzbGpwaEY0RncvOTFo?=
 =?utf-8?B?U1BoL2xWdmhqbGFXTVpZTm5YOXRBL3VQQ005aXMrTVY3MVdtYy85OTFjK21s?=
 =?utf-8?B?ZlhEMVVTMm8xa0FyR3Z4TG93TXl6Tk43YlRSTnloS3ZaS1ZLa2tvQVQ2TG9V?=
 =?utf-8?B?ZjdFa1YzTTlsS1JNb1V5WUdPZFE1NmM2RU5MY3ZKSjAydXdvR1d1RHRSdDEv?=
 =?utf-8?B?ajllaE80TTFrSlJqSXdsSFFtMVptMFF3QWV5Y2ZtUjBuajV6aVZPdVlTb0pn?=
 =?utf-8?B?VnVBOGRaVFpva3JHbllodGNLejZhZTJrSmlMSzVOa25NaU1iRkF1QWVPMXp1?=
 =?utf-8?B?UGN5UTRRMUdYc3hTaUtWQ05NQTlITllmaW94OTYyaWhWZ1VXZjExVW9YVnQ3?=
 =?utf-8?B?VGJndXVTWmRZMnhva3l0Q0h2QzN1MEFYZkdJZ081RE1aMC9aWmFVaVVFR1Jv?=
 =?utf-8?B?OFJjU2Vsb2toTVB1bmpFT25kdlFBSGg0MU5rNUZUVFVGSVBPS2YzVUtCa3Rt?=
 =?utf-8?B?cW1WMUI4VUhFODg3MU14dFUvVmpDN3M5ZGUwY3lYM04wYjNrb1duNklGRkJ1?=
 =?utf-8?B?b3NaQjhFbEZ1UWFRL3ZPRURGWEh2Qzg2Uml2bnpwWFlhZ0NKQjRNSU1PTnBr?=
 =?utf-8?B?Y09oRGR1QzNIY2ZBUDFEWGNVMlZvT2xaVWpEU2JXRWxLS0NYMDNtVXZzY0pV?=
 =?utf-8?B?OHdrNnJQYVhvNmxaTlRDZ2NjalhsZmJaQ0p0UGh1aVhZMVRGV1k0clhsa2tx?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe515f2-87d3-46f3-6cfd-08dc94f71f6d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 09:13:48.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cls5GD/Y8uVIM8JVcWggzXF2+28+g1uzJn5o7gMhvbeoiaPQdopOGl3/BAzRz/iPgQHGY/SK4YFw41cMsD0IdO/CzdRDgsBPLodBDZMKayc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com

On 6/25/24 10:38, Ma Ke wrote:
> When auxiliary_device_add() returns error and then calls
> auxiliary_device_uninit(), callback function adev_release
> calls kfree(madev). We shouldn't call kfree(madev) again
> in the error handling path. Set 'madev' to NULL.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - streamlined the patch according suggestions;
> - revised the description.
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d087cf954f75..608ad31a9702 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2798,6 +2798,8 @@ static int add_adev(struct gdma_dev *gd)
>   	if (ret)
>   		goto init_fail;
>   
> +	/* madev is owned by the auxiliary device */
> +	madev = NULL;
>   	ret = auxiliary_device_add(adev);
>   	if (ret)
>   		goto add_fail;

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

