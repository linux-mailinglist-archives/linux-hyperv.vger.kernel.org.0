Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14309748679
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGEOhP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jul 2023 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjGEOhN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jul 2023 10:37:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A95CE;
        Wed,  5 Jul 2023 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688567832; x=1720103832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cEtIh/0+Z4ueMopepY9PfEt321OBa8v8OILwDfcmQa8=;
  b=ZUIV27y03P9bsuReBH0t1vMcyxh7W5rfTKZCm1KbUl60LnN3+y8oJwRt
   rSo0d9hwfzLJRP+P+FNsU23CtfYcvhBV3dCKZfnhB9ePymSUvrUp7/6zl
   DDVI5nPfFpa22Ou3rzW69NplBfLGHVyVIGqAGBjSisIaSGuziTmbIYj9N
   emvPol1SF11jjtuMVMTQg365wujIDwDz4Zum468r24Y78BDTWiPfv76ar
   ZbThNaIHnWe0aGuS6266SDETXHYXhHHRWECoc+a95enoSy2Xil2s6o68I
   yvJdmnqxZ2e1Auq8jYIPiy9wasy+tpm113bZhGgnmEohqla3lfG6xCr73
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366842684"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="366842684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 07:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669425056"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="669425056"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2023 07:37:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 07:37:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 07:37:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 07:37:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 07:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0uYnPpP33fkH+/JrSuT/zqWZ8VJ3XnpYgVkrxmJ+t9jwpf0FhigGkVuGL0yb88KfSnCb5UePByuiJxIZFlnvHDwYvZ3hTkJ1YpN6wKXrY5tze96WyOnqkA9kFIKf7PesuIYKflKfWcFN0DRLMzQb9rq7nOykXS/7q3GZByyCzPqAYslm5GCtOtjPkGZNrElH8lvWuwNF8cEkuPNZcU/Ebc3ngqZfTBOy0hj56vUKoJ3+h5lGNijEhj00RUXNisBPGL62VsXB7si2+BpSoNN6fo6dGH7JSWoDSeu3ivKEH73cOoRk4XuDCwRns0VZNJeKEKc5PLUG821uRp8DSEOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHRX7hXrs39eexeXhgb/rpYD3EDjlFmcNW7odIYLlS4=;
 b=UPMBs6Iu8vU3RehzSXt/yfkQewABaaZ7VYcO5x2aHyyiC3WWMHsQpPNrJHPU8GDTPEEDDB74i9jHfGmqLICs1BDZwu/G9m8dupfEs8gbwe6Tm5kKgMFZWFtzhviaft9tksfj407Jx9viDz3J0saQXGICeeMe0mrygKLANVcsPevnLkVRWEWaEh4j4IoZ9NdYgUeMTb5+Rd1DSVOfIPsYwVVhxDywOfeyJBfZoaT+41Nd2jvVvS4pT+XyqU++T+l3kDwwpUqHA/NAZbDCnzcVZBqWtnZpAEFmJkgFvvtVoeKYs75U78ppgkPL3sxouXTGAHe+f9hKtGavobxrUezKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 14:37:02 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 14:37:02 +0000
Message-ID: <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
Date:   Wed, 5 Jul 2023 16:35:41 +0200
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
        Ajay Sharma <sharmaajay@microsoft.com>,
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9e8176-7f1f-469d-c00a-08db7d654bb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJ3h+I/TA7vyQjQm4MJqJ5fuazP/LqSmhLBCaak+BPHt5LEh56RjUGc/J4bNvGCBOc0SU67wooE8scmdB7Ke0i+p3/5wI2tiEHNJ40lN77TffG8oxe8Z06VNO7HI21xqwQr5sMVO2xK/JcMXhXUUiMRuRn1G4SDzqDSvjRpU3P3KHavWJMe2GFbeEw5dPYnq9HfbvlIjwTePHgFN/tHF2SKmgRS9WAJjr80OVcGMR+a0R41XiVabwV2ps1QRcQpCgX54ukg6/VpX1OabYHRQ1Cs/6FgfnD2yMQwOw327Vacz2IFVIe78WbGv4WDyDCJNnE2leAPdeIG29HbU5/dN+znlwa6L9djxXwWvsux6VTAjBV7Ztt1f64bQaeyWz+8RvJx/WTBlbO1/9I1sNOocRbdniPM76TJgkTX3EzsmYvSqEWYQuWGcxa2wbnOHzN5baEMH5BOJopTIDTwL/RC3i1Sgf2uwLctKKE8hb++fg+ovxjTWQFNZ5uXn8V5gxCGqL/n8IFOGt3S0CuYYn135vZ6OK3QnnaspAk5z/gJ+WxMEnrpin6yc37lw1JLRSRRQuuzHCegnXT8/NF+IfxaGiKHTeGxvB7JxaFP8tEzLkISU81BLNyD3+k7mqjvqoDdh1BD/T62kUcmlD7s/FsiS3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(6512007)(6506007)(82960400001)(66476007)(316002)(38100700002)(4326008)(66946007)(66556008)(45080400002)(2616005)(83380400001)(66899021)(186003)(26005)(478600001)(110136005)(54906003)(2906002)(31686004)(8676002)(8936002)(36756003)(5660300002)(7416002)(31696002)(86362001)(6486002)(6666004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZEVDNHRnhBQmIrU0FmSjdKMmU5NHhpa0JLdGxyTnFlalUvQ2pIV2xMZ3Jm?=
 =?utf-8?B?STlDb0lxS2xObDhuc28yU29tOW4vcTNtS24yUnl6UCtCcTBZVnIyQnZpL0lO?=
 =?utf-8?B?MmhKTDEvbERFaTlOS3lhSGpuczh5VnRNdnVLWEYrMG1FZGVPb05TN2x2Sncw?=
 =?utf-8?B?djQ3dWY2bitzUDVBWmtPbVduM0NjbWNLeDN2YkFnKytZWjdCTGRRb3dxalZE?=
 =?utf-8?B?QTJDdlhCY1hOYVVYMlFueG1aeSt1ZDVDSE1jeW1DemY3STQrclFpTEZoWlhN?=
 =?utf-8?B?QjJ6SElwQUlnYXYwa2JHbDlURlF5UnRwZ2NXOWRUd3BDOTMzbzhzT3VmSU1W?=
 =?utf-8?B?RXVlR3V2Ukp0S1lsdzZwWEZ1Ky8xczVYS2NXMTV5M3Jrclo4TGk2R2tWSGRm?=
 =?utf-8?B?SXJVTmNYZ0VLNTJDZFpiZS9rbkRMVDM1b253L09VM3JnWFJveEdieXRMZ3FM?=
 =?utf-8?B?cU43NENwMC9jd0VtTGpUc1lnUGcrOUVyMTducVd6WWJKOGV6Yk1BTUpQY1B2?=
 =?utf-8?B?R2JJdHc1dGJ1MStkQitZTjl2Ym9XVEJueUF5OFZrTS9SVjBuZ1M1c2tCNDZK?=
 =?utf-8?B?WER0YUZGMmpIaXdoek1kVXRVTm9HVUNYMUlSVVBWZ2JETmp4QTdTYStUWTlj?=
 =?utf-8?B?NXpXVmNXM2E1TVVZaVp1bno0VWVuazd1L25wMFJWL29zaS9iQjEwaXU1WUhU?=
 =?utf-8?B?Z1BVQVlJOEt5MitueSt2OVdxclRxNE9kQlBJcXRYR081bjhRcGpNTlQxSm5G?=
 =?utf-8?B?czJjV0RYYUlMNEY5RWpFMzVXejBWWERWSVdNWTVLWkwvbS9wRU1WQWZQTFdZ?=
 =?utf-8?B?VGgycWNoQ2JCbU1iQ0V0aWc2MUdyeWUxWnFTcDFsNWVyQktvL0ZWWjh0ZFZq?=
 =?utf-8?B?K1JOUFh3TXd0anZCdWRqQ1ZMTWFyOUtXK0xhN3J4aVdTbXBGZi9DeVdvbWJZ?=
 =?utf-8?B?LzRlQjJkQjZsWVpsWDNsM2c4OXlyNmhUd2YvYkF2SUZ6dHNleEtiSThTdWxl?=
 =?utf-8?B?Z2Y5dlh2NW5kVzNtMXpLV1VYYzhDNHZTNk0yTWpnVWo0U0xZOVNycHptZUZB?=
 =?utf-8?B?ME1KRkdHcHFZMHBoUkFEODExOFk2Vm5zV0xpV2lYZnAxbkdqTVl4QmdIcXps?=
 =?utf-8?B?THJsTXhxaEJxeEVadStRdUVyWTJuUnlOZGZUWWhlUmZZODNmN0piOVVobWRv?=
 =?utf-8?B?dWxGR1VYWENSaDBiL01mZ0tiYi9aS054dFR4VXZhZ0MrZXdKQTIyR2VVcGJz?=
 =?utf-8?B?bnFDL1lCV3htNnpsdkEwdEhrdkxTQk5tVURyVitNaFQ5RklIdDlsT3FlUDI0?=
 =?utf-8?B?YTluY2Q5bEJCcmJRTWp6WnluaEhOa1huLzlKOGtQcmYzVUtFSHRXWnVjY2JK?=
 =?utf-8?B?ZnQxR1ZJb2ViS2VOcVZ4REdzMGdMVXJDV1NEdFQ3TWxkOE91N21xdW1Kang3?=
 =?utf-8?B?NEg1dVhKTmloU1VuTWJHZFBMTnp6NG5uemF2bDUvU2J4K2tIY3pnUHpGN3FF?=
 =?utf-8?B?NFp2UGdqTTNFRUg2aVZoZzdUdUJSUHNwZFpVbmJ6Uk81eUlOVGxrRjh4am1N?=
 =?utf-8?B?VGFtYzQzREgzU0RWUCtEOTNhTUZNVUdBOFE2Q3ZVSVZvWnVsQjIrMk5MMlJU?=
 =?utf-8?B?VUJxMnVBTkFmZ3BBbmlFZWRDVDV2MGR3Q0RBRlNacVJlak5QWnhpaHlDNVpS?=
 =?utf-8?B?M2QvS1BoRzVqRjU4Q1RmbVFlYldKaTVaZlNQNjYzNXU5VCtxV1JtaWNubUNQ?=
 =?utf-8?B?UGM5ZFdLVFB4dEQxWG9lOVBpMXdtVHBCYm92Z2RXTVJBMzNLVzA1VHBtSEEz?=
 =?utf-8?B?L3hXYWxNWU1TR3Fmck5VSnJ4eU15dU9qRUhURDRodkRkaE9IbmJDanNBK0FM?=
 =?utf-8?B?UDQyc0h1UkEybTd1TnFVNk5ZSTcxOC9vZVFXcnA2UHBUcWZ4V05CSnNBWklS?=
 =?utf-8?B?UXFFdm5wQkp5RzNjNkF1anFPQStBcnRld1o1MXp5eUErS2pINDJMMkdNWDhy?=
 =?utf-8?B?UWxMSldxeUtFazYrckdobVdHelhkSG5VdkxKWlMxQlVsV01Tb242SFFIS2Ex?=
 =?utf-8?B?dUladSsvcmh4S0xwallkd0tJYnNEcGo2Lzl5K3dXOXM2TFVGR3NwRENZQUdj?=
 =?utf-8?B?ZlBKajd2TTJKUDlhcHRZc1ZaVGljN3VOYjJDUC9jWnFZT3BDY2Fpam5DdEho?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e8176-7f1f-469d-c00a-08db7d654bb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 14:37:02.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AtKfE2JduWkyRwCvAOEQGN4HN9snm/tEW4ngXhVy57PpeXB5gTPFklNUxZvI4Rzds4+dYY3n+zagU8O6WClCjaec3HB1+VtQbRc071Tz+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Date: Mon, 3 Jul 2023 19:55:06 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Monday, July 3, 2023 10:18 PM

[...]

>>>  	for (i = 0; i < apc->num_queues; i++) {
>>>  		txq = &apc->tx_qp[i].txq;
>>> -
>>> -		while (atomic_read(&txq->pending_sends) > 0)
>>> +		while (atomic_read(&txq->pending_sends) > 0 &&
>>> +		       time_before(jiffies, timeout)) {
>>>  			usleep_range(1000, 2000);> +		}
>>>  	}
>>
>> 120 seconds by 2 msec step is 60000 iterations, by 1 msec is 120000
>> iterations. I know usleep_range() often is much less precise, but still.
>> Do you really need that much time? Has this been measured during the tests
>> that it can take up to 120 seconds or is it just some random value that "should
>> be enough"?
>> If you really need 120 seconds, I'd suggest using a timer / delayed work instead
>> of wasting resources.
> Here the intent is not waiting for 120 seconds, rather than avoid continue checking the 
> pending_sends  of each tx queues for an indefinite time, before freeing sk_buffs.
> The pending_sends can only get decreased for a tx queue,  if mana_poll_tx_cq()
> gets called for a completion notification and increased by xmit.
> 
> In this particular bug, apc->port_is_up is not set to false, causing
> xmit to keep increasing the pending_sends for the queue and mana_poll_tx_cq()
> not getting called for the queue.
> 
> If we see the comment in the function mana_dealloc_queues(), it mentions it :
> 
> 2346     /* No packet can be transmitted now since apc->port_is_up is false.
> 2347      * There is still a tiny chance that mana_poll_tx_cq() can re-enable
> 2348      * a txq because it may not timely see apc->port_is_up being cleared
> 2349      * to false, but it doesn't matter since mana_start_xmit() drops any
> 2350      * new packets due to apc->port_is_up being false.
> 
> The value 120 seconds has been decided here based on maximum number of queues

This is quite opposite to what you're saying above. How should I connect
these two:

Here the intent is not waiting for 120 seconds

+

The value 120 seconds has been decided here based on maximum number of
queues

?
Can cleaning the Tx queues really last for 120 seconds?
My understanding is that timeouts need to be sensible and not go to the
outer space. What is the medium value you got during the tests?

> are allowed in this specific hardware, it is a safe assumption.
>>
>>>
>>> +	for (i = 0; i < apc->num_queues; i++) {
>>> +		txq = &apc->tx_qp[i].txq;
>>> +		cq = &apc->tx_qp[i].tx_cq;
>>
>> cq can be just &txq->tx_cq.
> mana_txq  structure does not have a pointer to mana_cq.

Sorry, misread, my bad.

>>
>>> +		while (atomic_read(&txq->pending_sends)) {
>>> +			skb = skb_dequeue(&txq->pending_skbs);
>>> +			mana_unmap_skb(skb, apc);
>>> +			napi_consume_skb(skb, cq->budget);
>>
>> (you already have comment about this one)
>>
>>> +			atomic_sub(1, &txq->pending_sends);
>>> +		}
>>> +	}
>>>  	/* We're 100% sure the queues can no longer be woken up, because
>>>  	 * we're sure now mana_poll_tx_cq() can't be running.
>>>  	 */
>>
>> Thanks,
>> Olek
Thanks,
Olek
