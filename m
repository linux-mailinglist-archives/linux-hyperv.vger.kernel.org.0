Return-Path: <linux-hyperv+bounces-1355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F799817C8C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 22:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB11F286425
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3637409E;
	Mon, 18 Dec 2023 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh1eW72P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E17408F;
	Mon, 18 Dec 2023 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702934355; x=1734470355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6rZ2vHPijJgRNGJ/Qai5tz1jSap6Qi+fFmfqTKJckuU=;
  b=Yh1eW72PU6QKJbxSyE0I9NhC8JF18B8LgbXiN/S5kxWEfqqlG2PJEkl2
   f02DFK7RtmPIGIFpedwcEdaiopJNw7CezRhR1JPov3OYUZnR2tL71h1YK
   o2Nc8b9CS4r/i0z6eELbUcXQTSo4N1/z6LT2KlfMH3t4vZNEBOENJDeX1
   YnUmtSmy/61E2s1MaQh1FUZYHRK05sZn540JKNmnLwx23umDZHTSij3+d
   Vl4zalxEm35oALAuYTS3GHVI612tBAQevkExQnb0immaItcjJA2pRhz7D
   RRZqoBnsU0Dr3zdcQJTXKFdaIyyyZUzm3EwKJUcriKlZXCATV3Eh3gNYC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14255372"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="14255372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:19:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="948919561"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="948919561"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:19:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:19:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:19:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:19:11 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:19:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYiN7ll3G8na/VM1qdGHcsTyP6EDR4nKZt6XVNlIm88w6ibPwsU9guoBnPPQ0zVH53BoTvB8VddkntNzdppyJOkePifjlT04mFI524zLsN+1i46I/hZt5bBlrEEM8wzVCniw1D+gWe8BgTNtz8rG1Y/QrC7Ev1vT+2ijXIFlDR+9Z8o9KeDxYyNCg0gFlSZ7qE2jL0bBpPdgzgSvVF32jUHm5cHDkwoQSVE9AGx1GwNjMe8UGf6Cv8QUqnsfIl/KnZX/Fqy/UTW0bQb0IvTK+JQn7wb136wv0CuIvhRmwqaj/MuqeCIq3f73fGN/ZgSGrJtJ7QzzY+j445ppr+KiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ0LjLibyx16hekxUQdyYvwcfHeiOg4b/QQIm3lPtN0=;
 b=evbrwX/oLQSURzRFuInqkneWRMa+K9+Un54bO4kNSAmNUiI2hSi1cjr3i0ZAAdY8khpQyzWk4+2RHptWQdH0hS1iqmZjPjEJYx1iTvReWV/+ppzDlqDjNoHNEu9MIybOcexWQqSKYdgGikzuDZJY32vaffA1YQVhfLWtiB0baXx1Qk6uRfyfR0+4xv0KO62pbyqzm3+V080YNMFQuvbGYN6EcfzQf6CraKPeR+CPCI6AmxoOnt37Npm055EDBJH25kgDo3K4J0qPQprtvzfH35esgAYH4KSgxG8mVbljz0asN+9goDCMZzKpvtrazBH2va/Fl5TkHXfNpN9iLWFYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:19:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:19:08 +0000
Message-ID: <598cabd4-2de9-4c37-b982-49f8178410f9@intel.com>
Date: Mon, 18 Dec 2023 13:19:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpumask: add cpumask_weight_andnot()
Content-Language: en-US
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <longli@microsoft.com>, <leon@kernel.org>,
	<cai.huoqing@linux.dev>, <ssengar@linux.microsoft.com>,
	<vkuznets@redhat.com>, <tglx@linutronix.de>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: <schakrabarti@microsoft.com>, <paulros@microsoft.com>
References: <20231217213214.1905481-1-yury.norov@gmail.com>
 <20231217213214.1905481-2-yury.norov@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231217213214.1905481-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fbd83f-c9bb-4834-c3ec-08dc000ef890
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTRbCLrCg50O2o/JmhFsZ4Z6T7Ra0eEQqU3pY29sZXUTSExWWiZ7tHCbDaPZv7m5bFHAeaSJ/8+4TLO3hH6VbI2VVrxdDMtiSv1rP9mcc5U0wRgvW4gFh41ECl+jOior5dD0VCau0yYib5Eq++ymWms7zfCNr5Feejylj2wfp+g6FCWMAEK03QdR1/r8LDxda8RU5aPeo9Kl+4+DqYNVlyWFBeJsPl8RWcB87+U08HVLdxZXBpvN6Y3Y40JoHC+Cl9caR/UmA0jCfXiHC2vU4zSnDv4umGfmXCkrHGqIWJgWfWy8Jg27CkSjkIHeNEtvQJtUplRSKUSM3e4gSsqnLUx8T0IlfQb7PoRk6dyE952R+/zh/sWaPY7uKS0DFMN+XQBljkN0ec9YMs0lwpD/D1XvLtJaldxro5JQUkFbiox/i5mwbLFyHvrxM3UwiOSCE3vG67u7OcYlfw3AKundgYbE0hmQG9AAm2l6/ACCb0dtwrUJXQLSYr3zH4Sm7cyTwb1nkiRpYCqycfoILSajSr/qI4v6dv0kXds76AAPDJ/0/fDDjVaYi4lmvlOroH/ZtOj00r7jSXB2ANOWQ7fC0jHAyXXBvghuDlsI029NpGRKvi8ekzBd5NrKLcDGgr+amNxseCirQiKYr8XYdcSQnPKWZpvvDLqRs7GyLlME8JyjPeplF98vUoRHdG7Pamfs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(53546011)(6506007)(6512007)(38100700002)(921008)(82960400001)(31696002)(36756003)(86362001)(8676002)(41300700001)(8936002)(4326008)(110136005)(5660300002)(7416002)(2906002)(478600001)(6486002)(316002)(66946007)(66556008)(66476007)(16393002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlrbkJ1R2JUQVBhZktKV21XUzlJMWRBNXVKeU9ObXQ1VjNBZlNwSmV4K0hB?=
 =?utf-8?B?dkMvemlwLyt5b0wzdC85MmdvdHpKOGlaa3ZlbloxZk8wMWo0TVJqR2lFaUlm?=
 =?utf-8?B?QWdKQzVLR2prTnovYjdQdDMwQVpDWG0rZnNPODAwam5hT09waHRiWExPSmlG?=
 =?utf-8?B?cFVjQzFwVzIwVWdiR2FGUW1wRTZUWkI2ZmpGcDZIeVNjb09oSFRmdm5LenNY?=
 =?utf-8?B?VGtiSFh6SnVhaW1GMHVadVdlVHZsK1NiazY0bDBUaEZwb1V3cEczbWVTbGFR?=
 =?utf-8?B?ZnV2cFpoRldkK0FwWm9FMHdWYTlkN1Zpa3VzdElydkJldFg4TzRWQjdNU2Fn?=
 =?utf-8?B?QVRMZHQ5am9TOGZUOVZmSGZ5cDZzZXRFWTdYOHd4QWRjNENWcHhVQkVGSFZh?=
 =?utf-8?B?MGg0THJCd3pwamIrcHQwYUpnZlV3cWRZcWNhaGlWNjAxaW9xR3R1bm01QXpk?=
 =?utf-8?B?Uk0vWXc5TVlMd1kxZHVUY3FXZExDdjh6bVp5V01Oai9zMHozQ0s2RUd0cG55?=
 =?utf-8?B?MFAwOEloQzNBdDkzV2VMMmgvR1ZSM01qSDJCaWlSNEhtdEZFblJyWEpkdEkz?=
 =?utf-8?B?MkVkTm5OSWN1QzhwU3hoeWgwSit0a1ZNNmR3WmxaOG9KQ2V6TDl5UzArLy9y?=
 =?utf-8?B?NTZFaTdjMExXVHpzeTMySWpSRVhTelovSndidFlRRUcyMG5tNXgzcVlVK2NJ?=
 =?utf-8?B?WlRhNlVuS1pxZEM0ZHlVZm5rRStrZzdBLy9iMU5YLy8zRjdrRFRIMzhBZVUy?=
 =?utf-8?B?anUxaVlUbUFrcmhENENhMWxUMS9JYnZDekJxNWlLaFJaVHVhV2dINnFOKzhJ?=
 =?utf-8?B?aHRRbFZQZ1JUMnR6azFOMDNLWTY3SWxXRVF2bTdTWXZPTUhwWDFnNDRVRW12?=
 =?utf-8?B?VTAzSFYxN1oxS2owQmFXRDFLZzJocm1pTkU3d1YyZ09sYTNuTlA1bHNqcWJm?=
 =?utf-8?B?UnZDa0dsVmQ2NmFRWlh6dzdqaUpxd3RzUllKajM5N0pmRWIyd3hHMjA1RStO?=
 =?utf-8?B?Q2E0R0pObnpaejJJNEJFSG9pWTQ0SkM3K0IyaFVXZWtnSWl2Z25nVVVNc1l4?=
 =?utf-8?B?TmVPejE2ZkZRVUwzSC95Vkpwb0Jnd25ZZXhXMzVZZFd1OVJqK1AxQUhUOWZS?=
 =?utf-8?B?bnlFaXlRN2s4eFBudjlCdUV4VitpZ015ekxhcjdqQ2dMbmROREFDT29YL0k4?=
 =?utf-8?B?LzZNU0NZM1NaS0JJVzU3Q3Bqckx6T1J4QkJPR1JtWlRBdk80TktBSXNrVEEx?=
 =?utf-8?B?Mm9iRCtUSnlMWU15UVlhb04vY3F3TGhRdnk0bHdYN2VlcFY3dDEwRFJhM0ow?=
 =?utf-8?B?Q2xBZllyekJib1FmVDNlQmtWLzNTYXRISS9SUVU2ZWU0dEwvRWxlQVgzM2pa?=
 =?utf-8?B?N09zbDl4RHRBdU42WFVqNWRrS1lnYWFtUUhXTTZhMU9HdE5RNENLeEUyMlgv?=
 =?utf-8?B?b0JlV1haK0t5eHgxaUNQb3ZQenJKV2tkcEl0WVZMcmZJNFFLNjBOS3lDSFNi?=
 =?utf-8?B?Yk4vU1huOFVhUFc0VU4xZHZHZVUxLzBNYUUwZVQzM0ZkVERoRG9qWjAvUzdK?=
 =?utf-8?B?eExaa0w5c2JJSCtKeWJSNmszMVV5VHg0cU5PaVZPRGVzTmZGSUlBLy8xcFhq?=
 =?utf-8?B?dFEvUUlkSEhkKzc5M0NqTi9MSnVzbFJJWVkwdisyTWU1bE1DbC94R0d5ejdr?=
 =?utf-8?B?S2N5V21IeURkY1ptRzFmTWZoTGt3VmJrZ3J6eVl3c2VmYjQ1bFR6L2hGY1Rn?=
 =?utf-8?B?V09JdGlZWGRWQjN3UW9saHd5anlVbHBVRjRxUnk0WXkvMHR6ODVWdVlRd093?=
 =?utf-8?B?SnZrWll6T00vVFNqK1VUZktOdzhadnhORUszVXJ0ZWNFVTYvWWdSenVSTWhn?=
 =?utf-8?B?TUhmanJsdUVPdzRXYXd3dlo0OGpscGk5QUhzem01Y1VkZ0xwZjh3QjlMOTRF?=
 =?utf-8?B?ZjFZdUhTMDBYWGYyeDNrd2RUcVFLMDhjcnpHU2hnV2QySENvcU9UV0RxVmlV?=
 =?utf-8?B?ZlNsQS8zQmhad0dVWG8wdit5VzlEMWVTN2Fwb2ZhZ0NMRTBheHpEYWVuamsr?=
 =?utf-8?B?c2Q3U1AwWDJlMlBIdW43UnkvdkFVaVVRdUE4bkE3QUQ5YTlrZ292dUdVL1BR?=
 =?utf-8?B?NzB3M3hEaHJYc2ZKbE9oZWdqZFFtaEdsUS9iTFJKVEpGcmxxYW5teGxJYzQ0?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fbd83f-c9bb-4834-c3ec-08dc000ef890
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:19:08.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9t/NxBFcGdB4LcMEerICtmyQ7AvTU2we2VtLWzBefPvTOp86EJ4IAWHFUg9gHZTuH7qJCGJ9Q603DwOjekyV1f7jbZux7zwQdIMcoZG0Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com



On 12/17/2023 1:32 PM, Yury Norov wrote:
> Similarly to cpumask_weight_and(), cpumask_weight_andnot() is a handy
> helper that may help to avoid creating an intermediate mask just to
> calculate number of bits that set in a 1st given mask, and clear in 2nd
> one.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

This seems reasonable to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  include/linux/bitmap.h  | 12 ++++++++++++
>  include/linux/cpumask.h | 13 +++++++++++++
>  lib/bitmap.c            |  7 +++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99451431e4d6..5814e9ee40ba 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -54,6 +54,7 @@ struct device;
>   *  bitmap_full(src, nbits)                     Are all bits set in *src?
>   *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
>   *  bitmap_weight_and(src1, src2, nbits)        Hamming Weight of and'ed bitmap
> + *  bitmap_weight_andnot(src1, src2, nbits)     Hamming Weight of andnot'ed bitmap
>   *  bitmap_set(dst, pos, nbits)                 Set specified bit area
>   *  bitmap_clear(dst, pos, nbits)               Clear specified bit area
>   *  bitmap_find_next_zero_area(buf, len, pos, n, mask)  Find bit free area
> @@ -169,6 +170,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
>  unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
>  unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
>  				 const unsigned long *bitmap2, unsigned int nbits);
> +unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
> +				    const unsigned long *bitmap2, unsigned int nbits);
>  void __bitmap_set(unsigned long *map, unsigned int start, int len);
>  void __bitmap_clear(unsigned long *map, unsigned int start, int len);
>  
> @@ -425,6 +428,15 @@ unsigned long bitmap_weight_and(const unsigned long *src1,
>  	return __bitmap_weight_and(src1, src2, nbits);
>  }
>  
> +static __always_inline
> +unsigned long bitmap_weight_andnot(const unsigned long *src1,
> +				   const unsigned long *src2, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits))
> +		return hweight_long(*src1 & ~(*src2) & BITMAP_LAST_WORD_MASK(nbits));
> +	return __bitmap_weight_andnot(src1, src2, nbits);
> +}
> +
>  static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
>  		unsigned int nbits)
>  {
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index cfb545841a2c..228c23eb36d2 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -719,6 +719,19 @@ static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
>  	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
>  }
>  
> +/**
> + * cpumask_weight_andnot - Count of bits in (*srcp1 & ~*srcp2)
> + * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
> + * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
> + *
> + * Return: count of bits set in both *srcp1 and *srcp2
> + */
> +static inline unsigned int cpumask_weight_andnot(const struct cpumask *srcp1,
> +						const struct cpumask *srcp2)
> +{
> +	return bitmap_weight_andnot(cpumask_bits(srcp1), cpumask_bits(srcp2), small_cpumask_bits);
> +}
> +
>  /**
>   * cpumask_shift_right - *dstp = *srcp >> n
>   * @dstp: the cpumask result
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 09522af227f1..b97692854966 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -348,6 +348,13 @@ unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
>  }
>  EXPORT_SYMBOL(__bitmap_weight_and);
>  
> +unsigned int __bitmap_weight_andnot(const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, unsigned int bits)
> +{
> +	return BITMAP_WEIGHT(bitmap1[idx] & ~bitmap2[idx], bits);
> +}
> +EXPORT_SYMBOL(__bitmap_weight_andnot);
> +
>  void __bitmap_set(unsigned long *map, unsigned int start, int len)
>  {
>  	unsigned long *p = map + BIT_WORD(start);

