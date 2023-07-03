Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC17460EE
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jul 2023 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGCQtB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Jul 2023 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCQtA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Jul 2023 12:49:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89259B3;
        Mon,  3 Jul 2023 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688402939; x=1719938939;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NyhItRZUjIN+vEZj9mPS3BD4LsAsIVBEdlq9gWsvm6k=;
  b=aZKhmqUbgpvmo6kBIk1E9IAFGuL0+RT3vHol42AEpN2ZA310MBXoewWW
   +s5U//wWDpD1kwk1RvvxVDTFedUApv/yAGQzu7mqSZO8jgEYgU3y1tmOj
   grcSmJuLQZN82RBhjtpaze2IJJHsqNHC6yeFMB+RmJB7SxWysEM/XB0rG
   T8oj0PBY0X0sSCwM77aqhGzCxH5SsN6xm499yCQ9CATYCv+uCd+aZxfJP
   6LmoGKp0RPE8LyUDz/Pk7aIL+2zlr7fDN9eoghcUlALWtuMEreA4bV3Er
   g/Bh4XkXx/DyEGNQuZ+HlDKZUHuSHE3u72qmpBaGRWflo8jzoO1HCPeWj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="428966784"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="428966784"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="748175767"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="748175767"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2023 09:48:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 09:48:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 09:48:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 09:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqk7uXRKJRKk/12fftGDYX2ChIl8tPYOHrHxarZBhHKST48W6C8W+TY1oNHxq5tmCnqD84kUKGYFW+UkxWiXTwMPNRnE97rtoDjyf0gLS3wtDK8Ew6mcpvrtRapeFS4njwmZNNwlicU5DceiaLlQtsDNjsdW2XjOIWnIPv1MmmiUAx+7F5g2Tp4MBuCfbOsnpMzvEOfI9OBYmmFO9ipyFUJKBKSdPQwznznA91axQwTM+pEy7VGs+ZJduV7PkCCii6lGN01owJtKC8GoV8tYXyVPAcRG/fWgULivoY66xsQqltCtsn4mjGQmZxy24lduPhQAIp57OvWhSUkdmE/V3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tbbh9hs6HWDss2guJhlwRjH6gMb8HDOwH4pIMUWKHQ=;
 b=GTWt5m5oAoSaBVJwQ/FXitJzz8PKxlNzgY6YZzVkF1H28LJZXRodj378AiR/t2yuB/lw8x/xxl5/J/j+lhlIn+NoRvBUndBjZh9uQuavKW1Z6lJjoIUNvkT6oQDCiFzdhUMiR1Ds0///TG9Okp0O3o5ZWXz7RHQSguJafPXRb+mQD+YYKO3CG1H7ZL49ZQ03P2Yty5WVc4QYsbOwECDaUq9Tl+qK+72nVPKLEBRsysVY3vVZxZsI84hZ2geLUM+lKgv/euNYO5yqeX8HU9cJIMB17UiU9o3AAqrArJ6vEiBIWAQhPLtqyjiba4etJQm5sq6pIfNighD+62JDBjxl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:48:54 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:48:54 +0000
Message-ID: <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
Date:   Mon, 3 Jul 2023 18:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V4 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Content-Language: en-US
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <longli@microsoft.com>, <sharmaajay@microsoft.com>,
        <leon@kernel.org>, <cai.huoqing@linux.dev>,
        <ssengar@linux.microsoft.com>, <vkuznets@redhat.com>,
        <tglx@linutronix.de>, <linux-hyperv@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <stable@vger.kernel.org>,
        <schakrabarti@microsoft.com>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 893acd2d-26d5-4fae-4cef-08db7be56274
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAnv6VWrwUcmY9mvzGlS9webzMva/7sLDMqfyjcmAMRdAjLBpkU/Qbs07foyKHinmYmVL6AYHfb+c6eAJDhEoGnK9I7Mrf4rc1sPB7aQbwZcALU8sKcICXAIrfJJ/b0U3tvP8lHauL/Bl+Ju86yHbj3fZabBfFVhtqm+iApCEDy+pH9BxL9/jt7qavrnWwVX+Yb5XsY+Igw7jWNdWoqJ5tHGX2kmbdjPGWISz1FBJbViYu8Uf81iwK9p7Zo5ZbWhl5DlXr2bnVIhLLghyRYhQg+B6z1sSdlAmsjWeXadEtPXRwY+Ua1oP7CguFsgCmPwRx9hpBMLGKH0Q5O0pdHK2rym08pDOhHnU+FhiSN3VnsF6B14sXwmfTSlJKVUlIlk586zZi6G4ra0VdO/Han53a8FJELJ0gdTC3W4Ac2lwXCHIY4wQCxsYJ4cpmSrhqRbY2c84NcgqeVPoBPKC7JcOY6u1FVbVlM5L6EjdGSLxVZq/2BnDYvpmcRjw+0hJ2N0frfGh5NmjGHyDxRWD9xqlIG3ek6drIGibbSQotoQmnkCUmP7Uxt63rOqNECAfMwaNqdUT1HHln++3V4UgDrOdKItpXc1AGXU6Yj1XoLo8NSLb95jcO3eZOvlXgq7ZkbnFFhQJg4rjNmzpez4ztcFng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(2906002)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(36756003)(8936002)(8676002)(31686004)(31696002)(5660300002)(7416002)(316002)(6512007)(66946007)(66556008)(66476007)(38100700002)(4326008)(45080400002)(6916009)(82960400001)(6506007)(2616005)(186003)(66899021)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWd3djF6SVlpc2YzS05pUm1VYWN4OXBsZjZWTjBsV2czQXc3dTdEc29NVE1n?=
 =?utf-8?B?U0Z6U0huN2x0ODd0SGRBK05EZ2hFcGcremlJT0kydlBYQUtWTTdpcWlvODlT?=
 =?utf-8?B?N2RCVTJIVkR1OVBob1AzN1E2MkxEMjRkOGJYdVI3c3BDMHVteWloVXFvSEc4?=
 =?utf-8?B?NWxVSERyZG91dUJrU29uUDdPVUtXN0V1QlhpS1oxSGtOdk9aaU5OSkVMcHhi?=
 =?utf-8?B?WW9IdS9Ca0NTSUgrQTFuZXVxOE1USUpVM3NRWkNJbkcyblJwUTlQY211Q29G?=
 =?utf-8?B?NXA0eVhHUHJvSkx2dTVPZTdMN2xpTlJhRXBxSXI5RFA3bm4yZCswNFJabVZO?=
 =?utf-8?B?clptdlkzVXpUamJkZXpJZlJ6ajZQUjd0bzl4SzZJTEF6VmV2K0tEY0ZYOFVa?=
 =?utf-8?B?TDFiRVhORHlyNW0rM20vS05VUUtMTU9yc3B5cEUwMW9TTG9iNm9yU2RMN2hr?=
 =?utf-8?B?WXUwZ1N6bUZVbTl2UElkbzhwTU5BN2czRzhlMEZzcEliV0ZITS8veWVxQmVO?=
 =?utf-8?B?cmFKUzM4bnVFSHVmdkJ3dXZUOXhaMHlLNkpnSVoxVng5ejBjaHVVdys0bHhE?=
 =?utf-8?B?a3QvWDV4YjRIcW1jOU9MdlJUTi9JRkhIVTdqZStIbFZwSXlkTlE0eHNpVjhV?=
 =?utf-8?B?bnBLbzRHemNGSURZR256NjM4TjhBNk9LTHRIVURDTmw3QmtKTzU0TngvcGdp?=
 =?utf-8?B?RUZxSWJiblhNLzFrL3JSNkFzWkJ5cXo5WTlhSjEwMGwwNXJndXEwN2tsR0dJ?=
 =?utf-8?B?YTVnNjF5aHdzd1plMHdkUU5jLzlNN1NDL0FRTDVZb20yMHNtYjRxTy9hR2kr?=
 =?utf-8?B?eG1VaXlYS28yaEZBZnd3TFREUFY5SEUwNWFHc0NkUFl5b0tNQ0dVSkhybGk4?=
 =?utf-8?B?YzdFNjRhZm1TWXV4VTB2MjN2ZjNpdGxMRFJsYlRLcWNjci82N3o2c0dra1BC?=
 =?utf-8?B?WWYrN0tycGwrUzZQak83QnRHUUlYM0RVdHJyUllQZURhRGs5RGZRd05RYlFI?=
 =?utf-8?B?SXBzSVRwckFzTjlXcDA2QnBCdW5rb1o5OTFuZ1NtTmlJYVFmVzArdForZEt1?=
 =?utf-8?B?TGpTRGVPeHo1UjhyM2lWQ0I3MlRJeFhtN0ltVlFrdDlFaTFpMnBYNVRCa285?=
 =?utf-8?B?UzJYY3RtM2YyZ1gzbmFIMTFTT1FhOFZvNGNTTVVHWFlOQUU5Z0xPL2lRWlhT?=
 =?utf-8?B?cXV1ZE5LbzZ4WlRJMlVEaXlPeHVEZGt2SFIrZm5COXB0elhiVnZEN3dLOUtU?=
 =?utf-8?B?cUozSzZiMmZ5MkpRNE5KSVpER05XZ3pTcDhQOW5oL2NSMURFM2hNTEpZNGY5?=
 =?utf-8?B?ZGprLzB2OVVHaS96b2d2bHFEK3dLQXN0a2FPOTJaYVIyUTNhV3lOUlkrK0Na?=
 =?utf-8?B?cGpJaHpUYVIveWUvWWRZaDBLdy9vNWVaWGgvM2pBcTFPVUZkTDVnYmdvMTJV?=
 =?utf-8?B?QVBMcU43TUpMaEhPdUZJelpqN2tyY0doMUpQMHNhcTB4d0dhRzdUbDA3Ulkr?=
 =?utf-8?B?aURMenFmaEY5b2dkaGZWVkRXTFd4MjVZMkxZN0Uwd0hWa3VVR3JNMkVmdmdD?=
 =?utf-8?B?N0MrZDNrZ3BBZ2VaU0pFVXpzM2lWRVdtaGpNUUpBamU0aVZWeXlLdXFST3A0?=
 =?utf-8?B?SDRYeEpwc1JqajIycDZvcEhGTTRtcHJvZmpDQkx5aE9nMFM0RjhYeHdpTzFC?=
 =?utf-8?B?elhkcmoyaVM3TnpZUko4enVKdVE3dnFDQWM5bTlFRDFJemkyc3BFL3BSNFlT?=
 =?utf-8?B?enlqbnMxcG00V1lEYVkxcnE3aEd4azJDckdXUHRJaEwyU2tYS2VJYVlaNUxP?=
 =?utf-8?B?N01vT3F4RmF6cFFRVGlheGtQVzN3MXE1bk1RTlIvNjhPZktwdnpoMVFvNXow?=
 =?utf-8?B?c2ZqMzhCZGZINDR2RTZsVkNZa2JXcXVGcTRablRaYWN0U0FMQXVLc2FaaGVh?=
 =?utf-8?B?ZTAwNU96Sm96RDNCMDRSd1VSY0dBbUZXaVMweXgwYnhJZDFjakQxTzJ2Snlp?=
 =?utf-8?B?S0xtSXBwSVFQRjRkRWxxaGFNdDRLTks2ZGg0R2lIQkhONkNzamhXN1lFT3RN?=
 =?utf-8?B?YkNGREFMUUQycnJOWWxOMnFtSE93OXNWcFpHWXpUdnNpQkJ0Ui94SGdBZ081?=
 =?utf-8?B?QTE1UzZYUklxS2ZQUDlJbXdJdXdjNktNV1o4MTBwL0x5ektCMy9LNitBdlYz?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 893acd2d-26d5-4fae-4cef-08db7be56274
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:48:53.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evbX9nlrHpMy2AP8ClxrQv7x9EvMEeZoJXAn0w2sp/agJwxfErqYAg7gSYp73f4PmfkAU86RFLex2zBIui7d58bure70JCM1O+aQEnxcE04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Date: Mon,  3 Jul 2023 01:49:31 -0700

> From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Please sync your Git name and Git mail account settings, so that your
own patches won't have "From:" when sending. From what I see, you need
to correct first letters of name and surname to capital in the Git email
settings block.

> 
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Where's "Fixes:" tagging the blamed commit?

> ---
> V3 -> V4:
> * Fixed the commit message to describe the context.
> * Removed the vf_unload_timeout, as it is not required.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a499e460594b..d26f1da70411 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2346,7 +2346,10 @@ static int mana_dealloc_queues(struct net_device *ndev)
>  {
>  	struct mana_port_context *apc = netdev_priv(ndev);
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
> +	unsigned long timeout;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
>  
>  	if (apc->port_is_up)
> @@ -2363,15 +2366,32 @@ static int mana_dealloc_queues(struct net_device *ndev)
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
> +	timeout = jiffies + 120 * HZ;

Why not initialize it right when declaring?

>  	for (i = 0; i < apc->num_queues; i++) {
>  		txq = &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout)) {
>  			usleep_range(1000, 2000);> +		}
>  	}

120 seconds by 2 msec step is 60000 iterations, by 1 msec is 120000
iterations. I know usleep_range() often is much less precise, but still.
Do you really need that much time? Has this been measured during the
tests that it can take up to 120 seconds or is it just some random value
that "should be enough"?
If you really need 120 seconds, I'd suggest using a timer / delayed work
instead of wasting resources.

>  
> +	for (i = 0; i < apc->num_queues; i++) {
> +		txq = &apc->tx_qp[i].txq;
> +		cq = &apc->tx_qp[i].tx_cq;

cq can be just &txq->tx_cq.

> +		while (atomic_read(&txq->pending_sends)) {
> +			skb = skb_dequeue(&txq->pending_skbs);
> +			mana_unmap_skb(skb, apc);
> +			napi_consume_skb(skb, cq->budget);

(you already have comment about this one)

> +			atomic_sub(1, &txq->pending_sends);
> +		}
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */

Thanks,
Olek
