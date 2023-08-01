Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483A476BBE6
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Aug 2023 20:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHASFB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Aug 2023 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHASFA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Aug 2023 14:05:00 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADA103;
        Tue,  1 Aug 2023 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690913099; x=1722449099;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EBv6JVGOs2YmwHJAAF4cuU3Qin2mAY06omTTqgVcIDo=;
  b=aUQf0LFTh5vfIPIIyH+fe/TIejwZX19fi2iSzthCJvNokzVxEb+bm7Xf
   7hfzZek2q9Ag0AromAP8GVxF9aN7tZYiIikPcM45AOrOdEkIoGNpaCYJA
   L3rsajHKY5ohdmakTOg1RGHLGrqzRzGAKVlqOdgquqGI6ILzaTkiA8JLt
   6Qegw9RbVBIto+XV0CBUaormfrLysEA00FCZYXG9xfBcoX+BDhabmbneb
   ehhlH9PQNG9mvPUKFYZoqv8T6fRUQdP4Uw4Ta3Op6B+0z/G0o1usr+XAo
   1pwk+TsRpRvA/IQ6y6Mb+qkCeK2JG1NAzJWu1KfqKR3LjZEgxbWifK13q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348978672"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348978672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732073655"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="732073655"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 11:04:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 11:04:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 11:04:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 11:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI3CE7H2qCAXT+Qdj1KQjA3Y3jykaNfkyofXaV0BYJ94X3V+HFzdCJu8BY+1aqEq3zye4A0B1sovILRTIsXN16mdu09uPHHcLinBi9Dh7q2DGi8reFxRWEY+/wOSGNh4nh/sfuHGWeALVuxM9bD9tLo2Kci7tA2B2CLR2xZUajPHyUMfAN4jzzAJMV8WT2TPDLeP5THkaF+7A8jIM59NZcqzsdciJs7dALuOQtyVCRodjPpvUKwTuNhiOoleCt1+azJTNiqWAspzLsf+JpUcCHXnDJKsLHZpNuAB6au3PZw7n9yGnYDkPuHMTPEjSoiO4mxqOMetlrefieHFtTYk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjUJeDAo2tXa5PEvziHQrZiFCIZgxAQ4FwYf5icZuv0=;
 b=aqZ2+xMph8Rg0MHhpr23q+ZrAzvMAUBxBKzZINQTweNu/ipYDp9uDJuV95g/KzAyqKuE0pwe63kWoKx2bZ7HGpfJH/o7yELLfeDu+HjdDkzuX0+C91NxMCNwShlXVJiJ70Yf4BO52i8XM5yQY7cbO84U2jHktleIHA5OzImGqJGsW+80g4N/uNl6SsjXV6slDzhE+evpcSXNEUv8qBS2noxtOhmXiMx9IxoJ8nE3ZS9J7s8qQQkiPjbXECdTFh7lksiRVN49OQ3Bgjdc3Om+21pv2q6drcmUcNHUJzsdRDkZ9bQ1r2JVyLcKJF1FPNvfPSXbRbBWppHdgk/mh96MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14)
 by SN7PR11MB6873.namprd11.prod.outlook.com (2603:10b6:806:2a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 18:04:30 +0000
Received: from SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0]) by SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:04:30 +0000
Message-ID: <8ccbfab0-e24f-b758-cd11-27b6d8ab1d48@intel.com>
Date:   Tue, 1 Aug 2023 11:04:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V7 net] net: mana: Fix MANA VF unload when hardware is
Content-Language: en-US
To:     Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
        <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <longli@microsoft.com>, <sharmaajay@microsoft.com>,
        <leon@kernel.org>, <cai.huoqing@linux.dev>,
        <ssengar@linux.microsoft.com>, <vkuznets@redhat.com>,
        <tglx@linutronix.de>, <linux-hyperv@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <schakrabarti@microsoft.com>, <stable@vger.kernel.org>
References: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <1690892953-25201-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To SA2PR11MB4921.namprd11.prod.outlook.com
 (2603:10b6:806:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_|SN7PR11MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c85917-dd8e-4391-3246-08db92b9c0ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XXSFyF9ChDkmREdoSA7/37+uuq+mJiXEi4xlu4wwWQshUp/mw9cE7TlIquntkLeiXYwwW9rCkfNLPHomx+Ay21jwsKxIlGybSEKhJU4HK85CUwa5l5WfDYguv934U/kxRTMRfWIefi5fFXxOhqesgf2ggwZlrpLVkQWE+OFsYaO/uySosozGCsxn0TCq0vWQ11tZ1+3aYLFjNmxDpV8/ynaL6ekiajX53oy5rpCFYNFJxo6GljwrGjKNMHFSy5St5Xi9xQiAcqzQe4i4LH0uMF7+lHYJO2FTh9dDPo6vC/cP19YM5ZU4gxnuQrwAcg3whCx3nVDNRgrXyZWPpaa/lpmipLFGPxSCU8/68O8XaJUy8A4wQEzMUxMUAZGb3ij0/tnXolGXRKsLh1EVhhePdtpl/pjWS9hHaNyQav3xebdP/5PJIMBnpJi3RbG7GY7qy7lmAPU/w1Acq/gkFv8bgLfCVjdrFjiAqQl2qOOf4X+KqtS7wbn24DTsS/UanoILh0op1yIYnY0y6R/fXHheIlbrxD1PWk4H9jM8mCPX8uIdJullIzrSfxMvD3PJz0tTHvXoFtVwpLg0qgRQWsXVpozHa3ayUTfcC13l5q8Qxxcfe/MpSIVmOQfdtnXYpn9FlWu1KHvi45rzC/Sc1D9buVG0pxzYYubsWyqLtToTF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(82960400001)(921005)(6512007)(26005)(6506007)(6486002)(36756003)(6666004)(8676002)(8936002)(5660300002)(66946007)(66556008)(53546011)(66476007)(4326008)(2906002)(2616005)(83380400001)(478600001)(41300700001)(31686004)(45080400002)(86362001)(66899021)(186003)(7416002)(44832011)(38100700002)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZ0M0l4VU1IZGgyNmlNaHRwTFRJdUhqQmdnY3JtbUMvb0dBak5SQVBlcVUv?=
 =?utf-8?B?Wk9xbjBISHJaZGJNRUk3Z0ljaXFBdWxRaGxsQXlRZjFGdWJYend6QUpkd0VN?=
 =?utf-8?B?ZHF5dUVDMFVIRFlIeXVHVGs0WFZrY0RuTyszQUw1NEZvbDJ5NVZOcWZwdXI0?=
 =?utf-8?B?UmpQcTBkc2poWldDQ2lJUDJKY01zOHF1OFg2VkpsOEl1ZDRudkFXeXBQMkxw?=
 =?utf-8?B?dVhlSnhxZE1oNTlXTU1wanUwRmRMYTdVWkduMzVoRGZZOVNJSHkwNjZQM3k1?=
 =?utf-8?B?Z3pVSWc5TDQ2OXg2b3hvc0Z0d0NpakdTUS9UL05laWdFdHVGYWxSbzZhZzFu?=
 =?utf-8?B?RkxBNU01MUpzNkU0bDF3Uk1zdWNCTzRTMHgwTTYzYmJtQ2N0SkNxdHhQZUpH?=
 =?utf-8?B?UlhHTWJhQmlnanMrNWNiTUdmc25FbURIOHhrazBmcWJhemwvVXRWQWhaYUxl?=
 =?utf-8?B?M1liZG9yZVladmJCNVl6SHZ4T2JraEI2cWgzQzJMUVRVeWF3SnI0OUxXaU1v?=
 =?utf-8?B?VzVrbzVDbkRtQW15Q2lqeUFPRjN0UEtXMGw5TDlKV0NRUTlLb1RNU2tKajBm?=
 =?utf-8?B?T3ErazV0ajYwdldoeTZDWHkrMUlkSFRNd05JMlNnV3g3dGw0MHFoTFVmaGx5?=
 =?utf-8?B?Y0gvVUlLV1NrVDVmZTdrRVhRc3FtazJqWUdyTVdsYldaVXFlclE0bFJJTDNx?=
 =?utf-8?B?OStBeHEyWUdLUVRld3R3SkphTldZb21UK2NESytwNG14aHBFYlp0K3hCTHcx?=
 =?utf-8?B?Uy9pZWloWHFPeXZZR0JTVXlxWjBPeEdSU1dVK01tSVRRSFdYZzZFUzNOOVZt?=
 =?utf-8?B?YWhCRU90TEg1NzB1R1hJSGR5dTdLcTJ1L0UvQ0twajVnRnFscVdDVVUvdmlQ?=
 =?utf-8?B?SStwKzRUQUpqSGJFNU42d1M2MTBNbGc0STVoc1dqTlpITWpoM21mSCsrdG9n?=
 =?utf-8?B?Y1JtMUhoZHovd01BdXJOcndOS1hQUVQ2NkQ1TzY3TVYvYTFZUkNtZzFQNngw?=
 =?utf-8?B?UVlWZk1CMDZyT3MyMEhhS1FvYU43YnhEL0pLeC8vbmNzT1dTT1Vud0w4V0Na?=
 =?utf-8?B?TFF2MlFKcUp4VnRCQWs0cnJTR0VieHE0ckdOdHhtSmViTDhPaUFUSVptN0h1?=
 =?utf-8?B?VGloK3ZLWXJ0MS9vcHJPaENzd3hzRXN6elBBVERRL3VqeDltSmc4d1lLZml2?=
 =?utf-8?B?clZCMTM3VjRqV0hEdE5wWWt6Y0tFWVd4TlBTS3ZVc1gyekhiQ1lYQnplV3Fv?=
 =?utf-8?B?ZEhLNGZTcnZrRHZzS3lOTEpDNTBNMXU2KzhjN3BQdldFcEhtblR1a25YeUZO?=
 =?utf-8?B?b0w1djNZZXl4ckVMREwxR3dWSE0rVkRMS0Jqb3JkSzBnUnFhTTZ6NUZ1UFdL?=
 =?utf-8?B?UjlzNmNRc2NYZHpPME5IZlgvU2tMWVF5aWtKd3I2TUpsd2pnK2luVFBXa1Bn?=
 =?utf-8?B?STJYRWtGMDl2MitCRkh6WWxFdEJXbVc4Q0pVWng0WlJNb3MyNnBpbHcxczlB?=
 =?utf-8?B?Q25BM3laYXNIQ2IzT2ZwUHZydGdkNDRNanpuNlo1K3ZEQUtaTmJXeWVEOENL?=
 =?utf-8?B?ZU81cVFYcyt4MjVCdmVDZVVoR1lUWDFEY2pqOXhBWWt2NmNjTFhxWW91SHgy?=
 =?utf-8?B?eC85Z0lxWWNSV3BCRzRKNm1hSzJxc1l0ZDdyS3dnR200Skx4QTV5UllMbVZN?=
 =?utf-8?B?c1BOL1pGbzVqWi8wdUZHTGRDU0NSbHdPcTN6TmVxRkZieGxVMkIxaFZXT05J?=
 =?utf-8?B?MDlMZHp2VEsvMWZFb1QvV1JDelBFOVQzbjl1UzVZYUpFYTQ2eXY4KzhIaE1l?=
 =?utf-8?B?a1VKbzgxYmxybml4VXZ1QTlLYzZnYU1GdGg5UlpKZm1jNld6QVI5cUJXWit5?=
 =?utf-8?B?QnpXR3dOT0RRRTRpS2dlbzI1SHUzQVl6NU9Mdlh1VGJicS9JNERSenlEOHlY?=
 =?utf-8?B?L2hhbWQ2VkkwNDU0YkZoM0JxNnh6d013SURESGlsbytBdnRZUFFJelY2dGxr?=
 =?utf-8?B?SzJ4bHMxRzhSZ1NOU25zb203dGhoaHB2Ni9JWEZoRXU0S1hvc1NOQm0yakIz?=
 =?utf-8?B?djB3a240dnpBWjB6YXR0UzJKUE9BSnZVeXlrRjJOWEpETFdFUmJPbnZyRE5T?=
 =?utf-8?B?NW9uZVFjOTgyN202a1dTazBXK2k0QStMOHREQno4ZkJ3NXhBeGJZOTBiV1BO?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c85917-dd8e-4391-3246-08db92b9c0ae
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:04:30.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwV8S4f5LFgL1DkKhueP2E4g82q5mrvaKG1jwvvW16w1qck5k/NDhfGoIAlRuI6RlmcN1FXK/ZLbomGzAb8D40NVKsZxTecMt8yKr4/cmGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/1/2023 5:29 AM, Souradeep Chakrabarti wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,

tx timeout in stack defaults to 5 seconds, do you not have that on? What
happens when you start getting resets while unloading?

> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.

I'd say 2 or 5 seconds is probably plenty of time to hang up a driver
unload.

> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

keep s-o-b and other trailers together please, no spaces, it messes up
git and doesn't conform to kernel standards.


> ---
> V6 -> V7:
> * Optimized the while loop for freeing skb.
> 
> V5 -> V6:
> * Added pcie_flr to reset the pci after timeout.
> * Fixed the position of changelog.
> * Removed unused variable like cq.
> 
> V4 -> V5:
> * Added fixes tag
> * Changed the usleep_range from static to incremental value.
> * Initialized timeout in the begining.
> 
> V3 -> V4:
> * Removed the unnecessary braces from mana_dealloc_queues().
> 
> V2 -> V3:
> * Removed the unnecessary braces from mana_dealloc_queues().
> 
> V1 -> V2:
> * Added net branch
> * Removed the typecasting to (struct mana_context*) of void pointer
> * Repositioned timeout variable in mana_dealloc_queues()
> * Repositioned vf_unload_timeout in mana_context struct, to utilise the
>  6 bytes hole
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..3c5552a176d0 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -8,6 +8,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/filter.h>
>  #include <linux/mm.h>
> +#include <linux/pci.h>
>  
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>
> @@ -2345,9 +2346,12 @@ int mana_attach(struct net_device *ndev)
>  static int mana_dealloc_queues(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
> +	unsigned long timeout = jiffies + 120 * HZ;
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
>  	int i, err;
> +	u32 tsleep;
>  
>  	if (apc->port_is_up)
>  		return -EINVAL;
> @@ -2363,15 +2367,40 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  	 * to false, but it doesn't matter since mana_start_xmit() drops any
>  	 * new packets due to apc->port_is_up being false.
>  	 *
> -	 * Drain all the in-flight TX packets
> +	 * Drain all the in-flight TX packets.
> +	 * A timeout of 120 seconds for all the queues is used.
> +	 * This will break the while loop when h/w is not responding.
> +	 * This value of 120 has been decided here considering max
> +	 * number of queues.
>  	 */
> +
>  	for (i = 0; i < apc->num_queues; i++) {
>  		txq = &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> -			usleep_range(1000, 2000);
> +		tsleep = 1000;
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
> +			usleep_range(tsleep, tsleep + 1000);
> +			tsleep <<= 1;
> +		}
> +		if (atomic_read(&txq->pending_sends)) {
> +			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
> +			if (err) {
> +				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
> +					   err, atomic_read(&txq->pending_sends),
> +					   txq->gdma_txq_id);
> +			}
> +			break;
> +		}
>  	}
>  
> +	for (i = 0; i < apc->num_queues; i++) {
> +		txq = &apc->tx_qp[i].txq;
> +		while (skb = skb_dequeue(&txq->pending_skbs)) {
> +			mana_unmap_skb(skb, apc);
> +			dev_consume_skb_any(skb);

dev_kfree_skb_any() would be more correct here since this is an error
path and the transmit is presumed dropped, isn't it?


> +		}
> +		atomic_set(&txq->pending_sends, 0);
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */

