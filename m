Return-Path: <linux-hyperv+bounces-1353-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C3817C82
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 22:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C74287490
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EABF7348A;
	Mon, 18 Dec 2023 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEO3gUIU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBE42361;
	Mon, 18 Dec 2023 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702934284; x=1734470284;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7EP8D4mJajaLnjA7Xh35GmO7HJ6raYgcidr4flyqdHw=;
  b=JEO3gUIUNdWcpbv8MJBOrxRck+UU6IAzAsciZPPO1/LFFkqeSmgBl7xU
   OvWDeiA2kSyUMpvzHCfl7YA9x2VFl9L2UitPHIoloNKiwjaARgHdSpZvg
   4+q2LXtGov6s+264BS5vK+Zvy+nf9DVYZfQ8lLkF10bj8IINKThYSxq90
   aQuynPMyhHEcpvm6l2IMPLQIZ49Fs08Px7Q0aQSEmwwoYWGCUSSJHVq5j
   ZCNCzPff9E3sLKTju+3dfPP2RnvSVjG5xTtQKcLVq2CDcfA55ptpRNst4
   sADq+yflnJtT+FA42kF4lUY0HacYC7dWPKQbcv6LPw2t/JMtzyVXLnI/i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14255095"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="14255095"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="948919241"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="948919241"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:18:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:18:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:18:01 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsBj+DDf1OexQOVK9z1tBKxoErnoBK5kRVdvkcisEx05tsEgR2xP3ILRZMwvTbh5Oq2yG2+9x4tXJIVUcAHc9MEkVbdyi8fv/gi1+bqL2uZVMM3Qr5zpftdmVI1YzVE5yDOFbQrXZp7FWWCjTSsfnx4jsSghJob4x2Y6fZvZMh7r6prwjYTxkEFxkr7K0pj46Yl5r39uuMKiXV2RofvwjueS2BtWLeSvb6iqr/6gssitZLHhGWQAh3JD/LBFQGtRbJVh5VuN/LGv0pPUBP8Wnf5J+P1dkW8Gnlzh8PZASjBCa9Z3sf+DLsMMqzTV4E0+ry+NTUkaaz+edFHc5Mnj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KIOfdfpfjPRSpnZqRZw4D6PxFOl51daVakrQn3z9Xk=;
 b=dlvCK4MiIuGFN4mQ7qvTFKG9s/DOoxe15A1oun0Bp3PdZ40YcS5eokK2VMQLLH/5DSJ45e43v2SBrT5cz6eRgeGh3fcEGZLq6ULbkWxqJt2CfiHj1YyUZjnollmiS6EUqPOrtNKZHe+V7MBb94C+nCGw7zVFl8rpxyowxcOUgMAFQQrnBl3uuOAzIhLxqDj1KRcMlPTOezYCgxJsA5Ib5pHRXYRmScu/1JW2yISLOoHA4TjP5LfbxpNgaFl6Jr3F6ejCT/3LCISzd0Palka0b4BFo+hgqSXukq5vuEMVOFqh2Xu2kRVAwP0vhjEPYeffkT2bMcVJqxs53Kr3ixzVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7941.namprd11.prod.outlook.com (2603:10b6:208:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 21:17:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:17:57 +0000
Message-ID: <9ba04aef-ba13-4366-8709-ea1808dd4270@intel.com>
Date: Mon, 18 Dec 2023 13:17:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: mana: add a function to spread IRQs per CPUs
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
 <20231217213214.1905481-4-yury.norov@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231217213214.1905481-4-yury.norov@gmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 22e3fead-51e7-4d20-7c11-08dc000ece0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqJYQrIDinmrQn9RAf6QKMyHXvl8mdUAGnB4ersl5mmWQ67pYyGZVlJzOaHIdddHwc8W1tCMD7QiIv/n+13vb6ofpkYEXMiTcNULRUc/5bYBuade5r//am6U1wtBb50j8eH0GgtJYcvoz+EZmXf1O0MnbULysozZXf0DJ6Dd1IwhLqkb7Wh6OlauYk01b/pxjSdBKqqqYwSkqlGaDYWYkOYifVRLm1L2Ju+GATklAoEyMQMc+vrjs2smY4r2c3LRK9OeUTUFmOQQ4eB8hd+ZlMl86VhHnB3vr1nd0mNjJxV2/IIDJyl29BBX1yuIU2WpwE627u6Gnl7IuyBCvWe4jTpwBvqZxLpTyg2LnFTsnKQWMGu7QSJzJFMCmC8XUGNB+CGji/XjXov3OSeq/O675DLWhh/Yp1EhksDE78SOJgroWcoJfCsH1Em19Pcoz5LG+JefTtRk1kUqRZCAmrvBBzdnRvWDTPTh0jO9goZzZYKUhYGDK3y06V2sgvWXxB3zatRhuehhgmUp0lo/Vxt/X4pDlFaHEzhWoWp12omsMOaHH02OuKaCRsRjCU1hkrIzbBB7dDwalFbMu9Q2rcaI9A0EwbVxKGLBFlNpJHbvMceKkh9yIgEMJW5AlwcoAYwEAKm1z6RO8nJT5oJLSoRyREfAUy1chdVZhy/HNgjh+oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(26005)(2616005)(6666004)(53546011)(6506007)(6512007)(38100700002)(921008)(82960400001)(31696002)(36756003)(86362001)(8676002)(41300700001)(8936002)(4326008)(110136005)(5660300002)(7416002)(4744005)(2906002)(478600001)(83380400001)(6486002)(316002)(66946007)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtWQTd4MG5ZamV0ekwrY3lMZTBlTmNpNXVEYW9GdTlDekZpd1RsWFdCOTVZ?=
 =?utf-8?B?YmkrQ0tWcWxLRHhFS1dwbForM0xQbDFkaHNER1NSYWxlUEZWeUcrUHlVU200?=
 =?utf-8?B?Z2k2MWpFTW9ReitJMlc5aHExdDA5dmpZdHhxb1piV2kyaEdQRHlublJJeXha?=
 =?utf-8?B?bVVJOCtUTHBMTXRDZy84dGxWMmp3eXRRazNSdk5nT1lZS2VhekJsamhvRGlF?=
 =?utf-8?B?NjBZSVNkRzJRNVJNTzR1YXF5WDlMM04wQ1NEMFI5MXNwQzV1eHB1d1pkWDZM?=
 =?utf-8?B?RnBwVUVhZzlmZy9saVo5S0F5V1JUNmlpZ1dEYmRBTjZJUkNxQS9DUnhHOXds?=
 =?utf-8?B?TE9SL1RtNDdtM1ZSOElqZGhlYytrRXFZQXAvTjNueTBzN3hSMXJrUXVSbTdD?=
 =?utf-8?B?UkNsVGZUYVlObTZ3MVp1R2pIb0NJOEk0aG9IeWFzMnZyVmt6WEVML3RldGlR?=
 =?utf-8?B?WjEzY2lBTGlaVlRQV1pqZWg1UVhRakZKOFE1dXBiT2JUR29nVlFmU2t4UTlu?=
 =?utf-8?B?YmQ5VWNlTytoMjU1NnBTUDZsUFV3WnRQSm5YWW9WRVBNdlp2b09KTkpHSEd1?=
 =?utf-8?B?STlSZTAwc3JvOEkvaE5zMGRxeEJSaW1KM0JyNEhGd3kxMFE4TGRZQTAwVVYw?=
 =?utf-8?B?S1FaVGlCenJ0ZUVOOXA3UGZsZ3VMN3dpTncyR0NwNzJyL1k2Uk9vem9tNW4w?=
 =?utf-8?B?bDEra3VCcHdsNXQ4SnZ5VXcyUGs0WDRIUWw3eWsyd3Faa1VNVytUbkRMZk1x?=
 =?utf-8?B?NEp6WWhQK2xTaGZKZUdiSVVTdHFqQUZyZHdHUDRWOEJWQWYvZ1k5eHpvU09p?=
 =?utf-8?B?Z0hHZlhmbVA1Zi83dXJnZE1nWjM1dzYvTGUzSlJ2enVTQTF2QWFyMCtWeG1H?=
 =?utf-8?B?aldUWnN5d1lGajAyNVBVNGM2VnN0U044Sm9NSHExdDNwSHJnRGJTdlFOS3E5?=
 =?utf-8?B?Z3prWjBqOWlqb0ZIWjFDR2tFajJkQVFsYnpPWGlnaEQ4OUViZVBkVHBTNER6?=
 =?utf-8?B?NGRxVkYzc1daT1VXbDFUVWpNeFh0NkV1cWZXT1lXOTZSdS9aclBtMDJITi8x?=
 =?utf-8?B?aW44Sm1sR1dGQndrUmhqZEFkaTlMV0RXSzNYZTNDNXlRdGNpSXhlVHpXcWk0?=
 =?utf-8?B?ZHMybTB3dmxTNXdKc2RvL0F6b3lCeHZYOW8xanFlWk1Gdi9ySkxkc3U2blY1?=
 =?utf-8?B?VG96MEQyZVRXSGZVZk1VcUI2clhIbjVGOHYybFdmeXgvdW5wdE9VOXNrcTVV?=
 =?utf-8?B?OGtoNWJBS29nWVoyRk4zMGYwenMxUUxWSGx1MHZ4VFpubmFJTDdLRmhaQXNj?=
 =?utf-8?B?a0xBcHNFOXEyUmlGYnAxOXVlZmVvZWJRNitDOThHb0dhcXNlZDAzL0FZVDh6?=
 =?utf-8?B?NnluUTQya3F1NjFwSXJBMnZzdE45WXhzS1QwRnkrZVBucmcwTVUwOTlOMCtT?=
 =?utf-8?B?Umg1Z1h2VjI5dFdENlppYU1ZR0NWcGppaTBPU3U0WXpRMHZoL3JFWUtpMklp?=
 =?utf-8?B?YzUxSmt2TFBqd0dlcjZwaTM4TnQ1cUpnNW4zdHpHaythekpTczNEMmp5ZUVa?=
 =?utf-8?B?MDk4dGpINUxVTVJMVUk1RFdYcysvT3FjY2hRZnZoWHBmK0xXbVJlTkxOS0J5?=
 =?utf-8?B?MDM3T2VETC83YTd1VFJRSXFCODF3OFFMbkNNUnRZNlRnOCtNLzAzSEpLZi9T?=
 =?utf-8?B?MUxNMTRaVVNRdWorbVVnNFZJU0lmM3dYTjA4NDFOVWRQTjR4QnFoeWJOUkdV?=
 =?utf-8?B?cjNkYTFiNm9URHhIa2ZTeGdPKzhDa08rSzdkL05PV3p4K1BCb05EaUQzeFg5?=
 =?utf-8?B?K0RQQzBMbnIxdWNPN2JVZWlHenMxSXNIQy9WVVR2bVNwMVlFY1BTYXVuenp4?=
 =?utf-8?B?K3YyRWNnYTY4UGZRci9MNE5UZExxMGlyK3orcDNlSjMvY21paFFQdGxTNGo0?=
 =?utf-8?B?OHlpZDcyUW00WVA5M2Z6VlBheXR3eTE0Nlo1bWRBbmJaOFRSdmtBWEhSNk1Y?=
 =?utf-8?B?M2E3TzZNR3dCNVB6cDM5RE5vZXZ6czJoTWNWNEYwajJ6UmdGTWUrSFlGZ2ZQ?=
 =?utf-8?B?UXJDRGRqQk9zQWpTZXdsZjF5NWZZMUNOY1A1QTNZbUxBWDFsOHhHL2duOFpM?=
 =?utf-8?B?LzZpVkZCaFZqd1QwWEc1NXJvYWZySko2WVBja1pmckpZRlMwOGNlMlRINEk4?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e3fead-51e7-4d20-7c11-08dc000ece0a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:17:56.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIsxFVsUW/F/alX1CdPLQJrQ2y5Xs4rTdoEi7Bs9zFprqQtWe7Yg2e+pMYY+Hg78Fk+8C/w/3VkSj07fTxsoyHkr4YBcbXIHJGCWGa352KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7941
X-OriginatorOrg: intel.com



On 12/17/2023 1:32 PM, Yury Norov wrote:
> +static __maybe_unused int irq_setup(unsigned int *irqs, unsigned int len, int node)
> +{
> +	const struct cpumask *next, *prev = cpu_none_mask;
> +	cpumask_var_t cpus __free(free_cpumask_var);
> +	int cpu, weight;
> +
> +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +	for_each_numa_hop_mask(next, node) {
> +		weight = cpumask_weight_andnot(next, prev);
> +		while (weight-- > 0) {
> +			cpumask_andnot(cpus, next, prev);
> +			for_each_cpu(cpu, cpus) {
> +				if (len-- == 0)
> +					goto done;
> +				irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> +				cpumask_andnot(cpus, cpus, topology_sibling_cpumask(cpu));
> +			}
> +		}
> +		prev = next;
> +	}
> +done:
> +	rcu_read_unlock();
> +	return 0;
> +}
> +

You're adding a function here but its not called and even marked as
__maybe_unused?

>  static int mana_gd_setup_irqs(struct pci_dev *pdev)
>  {
>  	unsigned int max_queues_per_port = num_online_cpus();

