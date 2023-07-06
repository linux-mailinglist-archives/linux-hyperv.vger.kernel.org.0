Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA82749B20
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGFLuU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGFLuT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 07:50:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBFE54;
        Thu,  6 Jul 2023 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688644218; x=1720180218;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fCCMe7FKpOwz3k6laLcxS6yu67sFsDGWMnCCFLXEmUE=;
  b=gQJyNI5FbmUOE8SrpZDgC716ZxGP8FHIz861+FvB6WKRjThblQk1PBqW
   BpK2zF0lkOpNc+34FUU2IuBOyQ+IYeYQVgTNG93dgfL4CYD2e86lMn+/j
   emjLy9lzjQWNgOzydbey8W1LRWgcIDiSm39V8661wp/NQUhPVwyReozSA
   WWXdiqEZfNFUb1Ie1K7/faeD5UvMJhaIQw0vnX02+c6jsMd9zoPS91dvN
   BevtwKlaniERzD13daDJiHqJ660hPZ8t6H96OxddrAqSLXTGn97586xGk
   GJJDlZp5bg5j5ybCegk84fJVRe8qItWUcbYyw2rPLNDimVlvV9xCB0Xv6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343913062"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343913062"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="864076720"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="864076720"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2023 04:50:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 04:50:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 04:50:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 04:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQq3LP9Cdl//U4V2qPgVDK+e1zoHC14XObMWcGui9TpL+qEYRb1uJiihiWopgkEs7jxaiIjo9B4sntANtLq6E7sxnyWBpPKFC6lswYmdVM2Ch2yyR3DwkgiGrEbG2HDl1HFkJPxxKHRMfS81+1kxyA4VyK6kVRPV4nO+hf71+/2dFCyLPxKf9vJF9hHkAGz4ERJ1s0Q2x3qn4bn8kg8UrBfQ2KYXksLAu7+b/mB6+JGtPzNSpm4gAI/0xESXU+0MSW2XwnEvWSSYMFv3Q2vmwkfucaB1IX1Mqf7wWA5zVdwaHdORh8x2VSUY+JxAeMfNvijw+lUUR7RMWFOubfAmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Dz5vze+O2dxOrws013hwjToN0gS2W7ZB506Qisqi8=;
 b=MulfijpQ6OpIqdXOjmLY4I0MpCXR2EGWcHPlZzMPnnJVbcKEviPhHOZ3qAOfLAsBVWNiIfcRt7E8F4raGeRsRcdl7Ttg2jnZ2QgZmUlNdHDCKhIAhWKhTQKm38X737YNOxgZ7EDWARjQ5RWV47ghYCLpyVp+PAtbuLRlu0qMAUgeWi8brl8BErWNIN7+oGz7VupCVHFpeogUzCkdSkUIy2NDJPNoIith4wHp5d6E3wnWXSzLDb2NcP43oEafyPsWR5BFsBoO96KrPQcKuyW9+RFL1bzX08lnsC6JXEG8BfPExGF53u+2Q87KW6v+vbBiFqpaXQLspDzaK0NXeqwUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MN6PR11MB8101.namprd11.prod.outlook.com (2603:10b6:208:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:50:14 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:50:14 +0000
Message-ID: <cd36e39a-ebb9-706a-87c3-2f76de82f7ca@intel.com>
Date:   Thu, 6 Jul 2023 13:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Content-Language: en-US
To:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        "Ajay Sharma" <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
 <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
 <PUZP153MB0788C7D2376F3271D77CE826CC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <PUZP153MB0788C7D2376F3271D77CE826CC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MN6PR11MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 61029a79-4dfc-475f-d1ad-08db7e1728eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLnyu2jblpQYl5jTSUz0oVYbFHRfXl+gPLIhlfheQv6aHqZ1iuCLqqvafPhKIwpggZFQ7zK4N1wsLwln4SfGxx+WjJN+l2wSjNGZZTDUDdqCvIjmfg+1QzPQRuARlYM6ajRv+g5F9e3h2PmAa7NCjkE6gqjslHodFRmFaVAxB2cCMLcoSXeOWvOJTq5qzKb2rfoCLuvGJnEV90F4Hde7PSsNlYukRhiWq8RdU/QYJcMMWzZrXX/tMGjF62HzXAzdRO4XMIaomnOYY3JbdiIRtTpnASpl6pDOn5Vrps8+iOfcBPwbT5iUWe0w8CMCdC88m0jdrkjWemoLNqro2AByB3zafwYH12Qgnl1eAtdHh+gXaOGL5y8JvkU1tvHmK4NswTfpguO3Ynp6TJzxvevxFpHaz6vlEuHvMXicOz5H9Q76ifgR4eA6fsuSAvFuOY6PnR18dI8EAjDLHYc6CMCdP9YcC5Gd9vVx39ahkfZB2myqLCUD5BzW7vTLFLLsu9qeEbJIQrt9xXwyxh3m5Ikao8CHlUHBNGmwadc2jUXlHqu1Mhzsu5SyAR7Q5pXAWYLqB1lN4zymyh26fU0dMYX5DC0SUHyZI0jmTSfSI3eBA/QRjFr4scMN5jT1fcQFb2+JJxX+zkEGMND2P7Xp3+pxRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66899021)(6486002)(6666004)(478600001)(45080400002)(110136005)(54906003)(83380400001)(2616005)(36756003)(86362001)(31696002)(31686004)(2906002)(66946007)(6506007)(53546011)(186003)(26005)(6512007)(82960400001)(38100700002)(316002)(66476007)(4326008)(41300700001)(66556008)(8936002)(8676002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHljWngza1IvNmh5MEZkTGx2MVVsVmFnbkw4aHlQSjJEQ0JsbEZNaFluMEo2?=
 =?utf-8?B?QW5vd294U0o4RGhRMkpRek1mSDJlb3dveU8rVXM1YTdDQW4zcktwbXIrMjdP?=
 =?utf-8?B?aGdXZmR1S3pWOXMrbnU2Zmh1RjdoTzNSV3lhWVVySXJDek9XMFh3ekE0cXVt?=
 =?utf-8?B?WlV4UVc4eTR3ZWM5b0ZkVE5hM055RFNXdDlLSDAyMTBEam9HZUdyM0xldWcw?=
 =?utf-8?B?OE44Y29PUTFZWCtqekhQR3lpUVJnNkFORW9KMEdoOW1uZTB3ZzEwaHhFVytJ?=
 =?utf-8?B?RDd2bkk4aXZRNHRqaGJtczZxUXE3NUhSQkNNV2RoMlhtTS81TjNoY1RIQzQv?=
 =?utf-8?B?LzJ3Wi9RRVFOd1JIbERoODFEZlpaYUdoaml3b01hZklCaUxyWk9UK2VIVVVS?=
 =?utf-8?B?SjM0WlNBTy9qWWZTVkdpYUpnZVFYSXhxWUJEQnpVeXQydU1qcXNiUHdLeHdw?=
 =?utf-8?B?ZWw0NWZHbDJlUUhxOEl5M3M0ZjM1STE3OTFRTVBkcVNIbjZvWWY2OS91b3Vt?=
 =?utf-8?B?Z3o5VkVmT1pGcEIwZGViRW5halNTbHgzcnFQMkdlakpGK0RPMzJhU2l3VUpX?=
 =?utf-8?B?WHNwU3hROVh4OEJLQWtFdXdDOE9jKytYd3VENWtnRzZ3UnVFWXRiZjhzOENX?=
 =?utf-8?B?MzBwNWo0T0NKcm1FWFJJVEFBOTNRNGtnN0ZCZXAyMWlsRFk2ZFpwLzMvcVp6?=
 =?utf-8?B?SVRXWmxxVnNLUHRGb3grcU1tem9hSGJGZjVYWHBKQXpIejduMjdkV2J3cWpW?=
 =?utf-8?B?Y2NudW1DVDQ4TmJqODJvd1pYcXlUN3EzTTV1UnFEZFFBTG1KSndFVURpcGd4?=
 =?utf-8?B?YjRGTkhydUViSTRSSzNMdExVKzRQVElPQ05idDZTZ1JGSkIvaTNreDc4dXFr?=
 =?utf-8?B?QStlSnJQZlFKMkxVMnZiM2RKL29ScTRBWTZJTWFrRmRYcCsvbElXUkVVSDd6?=
 =?utf-8?B?c2kvQ3NLdktnZUJYRFE3MEVnWEZPZDJ2bFRJTHIyQlFhL2dERWJxV1JPMFox?=
 =?utf-8?B?K2prT3NWYlMzMDIxcGRuL3FOOVRnakVyTllkTmUyMWhVN3UzY1c2MDVPdnAr?=
 =?utf-8?B?YVJsWW1tTmRPaXliSW9wYjh5T2RIRDlGNCtxZmlMT3FMMjhDMkR0Wkc1YjNr?=
 =?utf-8?B?UURMUDkxL0JOUmk2MWlXcVhQc0VrOEdITXRDaHpLaTMvejBieWtHQW9IYVQ3?=
 =?utf-8?B?STFSTnowNnJXNCtTakFvV2gxNU9vR1FzaGxXWEt4NU9IMjh5eDJSUGVScjFY?=
 =?utf-8?B?aXBtZVJVRWZNL3Y1UGRuNUdtYlAyQnFoemZHQUQ3U2FBNDFQbVJIUTkwdTRL?=
 =?utf-8?B?VDBtVnVzWWpxUHh0dTR0VVRkV08rYjJKZXhaU3hlaXNBL2pYdjl1VnNLUTYy?=
 =?utf-8?B?K1ZWeFJSeU5oa1hrU0VyQzlWdHcxR2duc0FDWFpTS3pSaktJeXFZWW9CVFhm?=
 =?utf-8?B?V0NNQkVaYjh6cDZ0TEtRMmV3ei96VWJhZTNrMkRiKzRtWmtKSmZWQXExNmND?=
 =?utf-8?B?WU5xMmxYcXZPV0kvYk0xRG5LUEo0ZWRMRHpNWW8wcno2V0FhMUpQNk5mZUNv?=
 =?utf-8?B?YlpDUUVScm8xYlJyOTM0ZmZsTWJiY1JMQUN2MVUrMURWWDRiQUhHSWZPSjFh?=
 =?utf-8?B?aXFnUlArQlNaSDZXUjVkaG9oMUZyWEFrMTRPa2V1OSs1Tlk5RVRpUGxGaHI1?=
 =?utf-8?B?WGUrclExc0x2Q0d4bGNoUzBpTFpDTzhNU1greU1DaE9WUTRJZzZsblRJL1B4?=
 =?utf-8?B?Q1J5WnlrYUU5OUFZcGNCaW9UR0NNY3hLR2NhUXBlSUcrUG1KUjZVampiSTRY?=
 =?utf-8?B?UjVpNlNISzJ1ek90MldzK2xKYVpsYUlxMURjbXV2U0RFRXNkaVdmeTNDWXJ0?=
 =?utf-8?B?bVdwL29XclJGeTYzTTJWRy9DRmp2RmNyUkJnMzhSZldyZ01vNUt5THhiVG82?=
 =?utf-8?B?Vm5CTUxiMTQ0amJicW15aVZjQ1NvMTdPWjlGRE5oaFNYdzVTcGdJMUh4RjdI?=
 =?utf-8?B?ZkNUVDQ1Sy9SeUxQWERlaU9DTUhPNVJQZWd6dXIrV09jNTluZDhCUW9XaGZn?=
 =?utf-8?B?N2lUeGwxZStlS2dTQlEvN3NXNHEzV3d4MmxnaU40d3VrWEJ5Z0VuUmJtbldX?=
 =?utf-8?B?ZnpsU05hZnRIT3gwZG9qak5ZZHNSVWFHOXBOOExsUTVFbjR3eEVZT04vUk82?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61029a79-4dfc-475f-d1ad-08db7e1728eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:50:14.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL93YZBaAUAsVRdh3vlnfIrl52lire1OpbLn0yut+mBzYQtzzZS25fCbS094wuZS02A9QcCrIqc+dN8PyvMM5ElJWsD8G5xdZuc/H90v+HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8101
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

From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Date: Thu, 6 Jul 2023 11:43:58 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Thursday, July 6, 2023 5:09 PM
>> To: Souradeep Chakrabarti <schakrabarti@microsoft.com>; souradeep
>> chakrabarti <schakrabarti@linux.microsoft.com>
>> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>> <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Ajay
>> Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
>> cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>> tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload
>> when host is unresponsive
>>
>> From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
>> Date: Thu, 6 Jul 2023 10:41:03 +0000
>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> Sent: Wednesday, July 5, 2023 8:06 PM
>>
>> [...]
>>
>>>>>> 120 seconds by 2 msec step is 60000 iterations, by 1 msec is 120000
>>>>>> iterations. I know usleep_range() often is much less precise, but still.
>>>>>> Do you really need that much time? Has this been measured during
>>>>>> the tests that it can take up to 120 seconds or is it just some
>>>>>> random value that "should be enough"?
>>>>>> If you really need 120 seconds, I'd suggest using a timer / delayed
>>>>>> work instead of wasting resources.
>>>>> Here the intent is not waiting for 120 seconds, rather than avoid
>>>>> continue checking the pending_sends  of each tx queues for an
>>>>> indefinite time,
>>>> before freeing sk_buffs.
>>>>> The pending_sends can only get decreased for a tx queue,  if
>>>>> mana_poll_tx_cq() gets called for a completion notification and
>>>>> increased by
>>>> xmit.
>>>>>
>>>>> In this particular bug, apc->port_is_up is not set to false, causing
>>>>> xmit to keep increasing the pending_sends for the queue and
>>>>> mana_poll_tx_cq() not getting called for the queue.
>>>>>
>>>>> If we see the comment in the function mana_dealloc_queues(), it mentions
>> it :
>>>>>
>>>>> 2346     /* No packet can be transmitted now since apc->port_is_up is false.
>>>>> 2347      * There is still a tiny chance that mana_poll_tx_cq() can re-enable
>>>>> 2348      * a txq because it may not timely see apc->port_is_up being cleared
>>>>> 2349      * to false, but it doesn't matter since mana_start_xmit() drops any
>>>>> 2350      * new packets due to apc->port_is_up being false.
>>>>>
>>>>> The value 120 seconds has been decided here based on maximum number
>>>>> of queues
>>>>
>>>> This is quite opposite to what you're saying above. How should I
>>>> connect these
>>>> two:
>>>>
>>>> Here the intent is not waiting for 120 seconds
>>>>
>>>> +
>>>>
>>>> The value 120 seconds has been decided here based on maximum number
>>>> of queues
>>>>
>>>> ?
>>>> Can cleaning the Tx queues really last for 120 seconds?
>>>> My understanding is that timeouts need to be sensible and not go to
>>>> the outer space. What is the medium value you got during the tests?
>>>>
>>> For each queue each takes few milli second, in a normal condition. So
>>> based on maximum number of allowed queues for our h/w it won't go
>>> beyond a sec.
>>> The 120s only happens rarely during some NIC HW issue -unexpected.
>>> So this timeout will only trigger in a very rare scenario.
>>
>> So set the timeout to 2 seconds if it makes no difference?
> It can go near 120 seconds in a very rare MANA h/w scenario. That normally won't happen.
> But during that scenario, we may need 120 seconds.

This waiting loop is needed to let the pending Tx packets be sent. If
they weren't sent in 1 second, it most likely makes no sense already
whether they will be sent at all or not -- the destination host won't
wait for them for so long.
You say that it may happen only in case of HW issue. If so, I assume you
need to fix it some way, e.g. do a HW reset or so? If so, why bother
waiting for Tx completions if Tx is hung? You free all skbs later either
way, so there are no leaks.

>>
>>>>> are allowed in this specific hardware, it is a safe assumption.
>>>>>>
>>>>>>>
>>>>>>> +   for (i = 0; i < apc->num_queues; i++) {
>>>>>>> +           txq = &apc->tx_qp[i].txq;
>>>>>>> +           cq = &apc->tx_qp[i].tx_cq;
>> [...]
>>
>> Thanks,
>> Olek

Thanks,
Olek
