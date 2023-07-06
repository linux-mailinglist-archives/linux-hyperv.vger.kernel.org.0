Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08B0749AF6
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jul 2023 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGFLlk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jul 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGFLlj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jul 2023 07:41:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38701BDC;
        Thu,  6 Jul 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688643677; x=1720179677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nbk4uC63t0mfEQJQk73vsIw+Xu6oMrosvBay9EVVKyM=;
  b=H+r5rnvCGHYoPOMSpBR0VOMzBzVHzIkaXuQMM3ivCT0ErkgCHJrlrpst
   5A0h+afdyzI3dc+R8uxeYGJHrtz0CQUYvDOI0Nxrqfs0lBXbzWCtSfsWK
   5WTOiRc0h5c3uVZN3JAMJYwUX+twE2j0LhCCRtBRzsYGWMKtIc5CvRIsV
   gBRoIBA6q3EEIuWVg3Vh0ct7vHhqzl6f41rbTG+uG4gihAnufKqNlDZof
   QMJFJcJ3Zx2QW1Fs0UnLk+QLkEkNGKreiI/Mu4uPYaHTewFaIW+0BMWpS
   qHNqV3Z45jYSxE2ba7f8fTVFB7KmOfTjikN3Qdcbo5oVFTiRj9paN1YyK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394335486"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="394335486"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="966190147"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="966190147"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2023 04:40:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 04:40:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 04:40:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 04:40:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 04:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWwTbwbTWb8anOs+Y+1bYJmBbE+24AMWbRhBlyGMVA9BKS+MKMb/UUr0k9HJWEBXCY03IgMifaUlPtSUxGhD3AqhrYsjhsy7HZneHu/XDN3sJe8dYVwrHWTqA/hKXTTHQx5utye13tpYDHsxW4aFgzC2nEGyREZ+xEsxiryzhSPlPu4SM7DsAybGjXTuLojSyj0nBA6GM+ELs2QdIj0QaGLbFx8NCAE2RA/Tlk2dHW1QJ2C3kIcvKH1V1OX10BAZkVzcweU9WSYQXXpLhpgRgFrqmSh7FYmgp0sCDavRAepoV5UD1ChwydeDjJpGMyxIEPZo54g4r7qscr/FKJ0mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ofz8E/OhEeQT7tmg0SFzO+VPQ1v62k3iVWW3Kt1CU8=;
 b=WgHCX4EZTJ31KCcRCIeYL7rJMtKoZ7z5TxZbdIu4FIJcIvLOVJHe3fVcli/VSamhSscpembm1a2FdfVQJDDuSQCqp0ffcp91SLmKUOdnKyzDiKVUoJ3CNKPoat9qUQcskIK+AnD72e7FITrKmeFHF9fkYe9JmD/mWrxJM7/N/oeerQKozbkm9bU1rlPqtBGeuQEs39A0BDnZ/rsKayc3EvGAyN9IkJbMDKVyevKk9yKG/bytUiYAEFASJlvbwLk3kBZL3P6uq0aneBL6Zx3dF6HAX8ffzQoEufzzN8+BJy1cHBQxUOmPZsXAXOtwH30WDmpRSewVwxJYkpfv8d9Jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BN9PR11MB5482.namprd11.prod.outlook.com (2603:10b6:408:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 11:40:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:40:35 +0000
Message-ID: <c7e4a416-9da4-7ff2-2223-589fd66f557d@intel.com>
Date:   Thu, 6 Jul 2023 13:39:07 +0200
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
 <7e316b51-be46-96db-84cb-addd28d90b0f@intel.com>
 <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <PUZP153MB0788A5F92E65AC9A98AF03AFCC2CA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0299.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BN9PR11MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: b7954c41-4f5f-4462-5ed2-08db7e15d022
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6EXS7Qowm4X9ke7Ah+VgArmevJ49jMngaoT987pZf+PZJ57WizqberNZkkOZN1PRiB8/sArE+jdRZzYeYpQrIoo1KxcXoP48pnqc88SifgVCNhPsFG85Z75MyWmZXouoDa1CDW0FN4p8fe7qiUMOg7NPs01+hxS3hUBwnhiK5IAwfxWHwEDs67BPVOJv4GspuqPwa11XTYW6KnrljqSQFpDqeFNmknXhiUKQWv/QaW20zCGKgrbmqenqZ+yO5Izh7vy/75on9N419Kqt+nvjn/WIe6CcyCgyeFxjcM8YjaCAe+EwERU7fEXJG45YelUA0maHeqeHCw9cIFFCOZiMoFXO7bU84wgupdrAgsBVG+A0MmIAYUhBDL23Mn7gPXkkIJv9mH/xYUmNp28rzXO6pIte54b7NhWSWirgew8C5vmzaRhXksaqH2TY0qMkkdDFuWI2gpqcQ14iEjUYmeC9+dK7LPdol3zvCYBWeqWN4whE5p352HO6cpISYdrBMSQ/i4CQQCy5uPAbJW4uG6pd6bgmbURfV7NcN6zTQR+VNvDiOyfJi8irZw5NcfNAIUbNSI9dEjT9El9WbXzwjkVHh1SmVDPFeeLXID5DSeKF/Nekv4nh07lJ5oP0m4rmPdusx/9JZQuMfdF9ehnP43uPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(5660300002)(8936002)(8676002)(66946007)(66556008)(66476007)(316002)(7416002)(4326008)(41300700001)(2906002)(54906003)(110136005)(45080400002)(6486002)(6666004)(6512007)(2616005)(66899021)(26005)(6506007)(186003)(31686004)(478600001)(82960400001)(83380400001)(36756003)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBsT3FmUVRLaFRyaGdDaWh3bS9yN2JDQjlrdWw3YUNjeVY1VlJRY3luM05X?=
 =?utf-8?B?U0pjTGY5TkdmaFo2ZEhRRHZQUGJNZWtsSTExb0publRWWldTN3ByN05uM2hN?=
 =?utf-8?B?Z3pmbUdxSnZTclhwQU1UTkx3L2xtYUlhR2ZJVEtNdnlQVDF3c01vbDFxd0lr?=
 =?utf-8?B?QXgvUEgwVVBrdTdISmdjU3lEUWlCMnpPOEJTbEE4ZWZvSHdyUGNhemxYZTI4?=
 =?utf-8?B?NEdKSk5uS3lTNkZHM3dRYlQvemF6UVdhVlpQTVc4ZGtLM0JJelRnSlczZmtV?=
 =?utf-8?B?Q1ZNYm5zK3VYemhxcm1hNWFWUVp0VGVIUG1EZGlGbURwK0cvVDQvUVI3VjB3?=
 =?utf-8?B?c2VZMml5MDRqalR6bVo3dEpKSTV6Y2ZNR2RGaS9kTytrVjZUNDZ5Z0Z6Z1lE?=
 =?utf-8?B?NTNFRnNjaWVGUkVTWEMrL2RibmVhU3g5WURSZ2taZ2poRmJpQTlYaXlpbHpj?=
 =?utf-8?B?WWIxb2F0TkUzdVYyU2tHM2g4aWhvOXZITTlidlRqNVEyay9USUh2MEhrRDRx?=
 =?utf-8?B?Nmd2bGxldE1ibksvdFVJWWxJZWh0UDRvN0JETXljVWN6UTZrQk1VOWkzM05o?=
 =?utf-8?B?cWVzbVkwL1BRUkRIeVA1eUlDTkZzMG1RYXVOdHAxbWxFR2VvbUFiUU1Zd1Mx?=
 =?utf-8?B?VkJUQkhrZkNxOTdMQjU3Ni92UHlWTVJyOUpJN2VVNjdhZkZucTVFck5rcSsr?=
 =?utf-8?B?b1B3RE0rRW8vL1hpb3R2aGtTb2dOUzdubE1Vc2VUOWlUQ2pNM0pIeEtNTTlF?=
 =?utf-8?B?dEpqbjE5UHJMV2g1a3NSbDk3dFBMaGZwT0laYTBRamVFb3Q1RUxWZWZQRkRh?=
 =?utf-8?B?QkMxUjlxQlBNajlDSWdhOStXbUhrNDFOV2kxaVVETUxHcll4by9yN3hjdTlp?=
 =?utf-8?B?MHlTWjY1SEZpbFRydWpSMGE4TmJxT2pCVHFVZVBuZHo4QjUwMFAyaWVlMGlY?=
 =?utf-8?B?YzZaeVdmbDcrSENXR2d3Z2tnaFdGR2pzcGZYNk1NMzM2RFJTUFVxbHMxWmpU?=
 =?utf-8?B?ZDdWM1pmN3UrejB1QklWcU5DWXEraVkvQTJuQ0JSN1pJRjg0ci9NM056SzJq?=
 =?utf-8?B?b0Q2d1pkVmdUL0Yvd2RlN21IL2hBVkloNlJpc212MEhhVjJ4SkE1dmlFS2dj?=
 =?utf-8?B?M0pjU01CWlBOQnNVUkM2UTZMTFhWcjd6djBETmRjQ0dySkx2RUh4bElaK0h3?=
 =?utf-8?B?cjU3TXprcmhBblJFT1hRcEk5Z1RNclRVcGluZFhINUF6SFZocFk3bnkyV29Y?=
 =?utf-8?B?T3NlRXV3Mi9qSkN1L3o3T2h5NlJsbHFWTUptcGMzL3IyMjVVVGZ1WWNxcUR0?=
 =?utf-8?B?MTZCbnpLcnVWR1NLVThnbFkvcDZaeC9SL3gxVzBPaHFrcmkwQ0h6SmNsTVFB?=
 =?utf-8?B?dmtjTFl2SzN3ejR0OEYxY1hnVTN0VXo2REhFR24xckJhVmt6VjZJVGZpMUNE?=
 =?utf-8?B?VTJZeDBtMlJNTkUySnRvNi9KSGo5MDhBQ0FGckpLVDd4LzE0SlY2NW5mRHN0?=
 =?utf-8?B?M0Rhd3dEMnNaSWs5ZUdiY2hUUGIrb3BERjJPRVlSM2diL3g0eThDRm8zNkpk?=
 =?utf-8?B?SmZGaGNGaG9MbmdYdXpwcERnQUFXRUdiaE8wY1NkTUFlUW9XOFgvZkhyendN?=
 =?utf-8?B?ZE54VlZiZE5UTTJjMG5KellmMGF0ckZvQjBNekF6L05xQy9nQThySDB1WnNF?=
 =?utf-8?B?aEkwam5pU1BreDh6T2l4T0ZYNStnanZodFYzT3J2U0JnYXkvN0hrQkV6Q2Vs?=
 =?utf-8?B?VTFCbnBzZmcvS1RoNmpVckoyUDV3Wk5UVktLQnAzbmhkUlRSbzFGK0s2RkF1?=
 =?utf-8?B?RTNubXpHTWFHTlZ3Mll1WjZUM2pGV01heEJicWtkejRHZTkzdGVudzFjaXlr?=
 =?utf-8?B?c2RLTC94c2JPdVRZY3VTZG5FUVhIbTlyVTFCR1hHcjd0RmhzN2d4a2NTMkpI?=
 =?utf-8?B?YU9MQnVPY1BhaHB0TkxDL2VPYm5Zdm4yblFUaVpiN3dUcEJlaUZ0N2NpdFh1?=
 =?utf-8?B?U09ydjBQVWplL0NtTkxqU3hZWTVnWFVTb2FNK2tVSTltSHZOYjFaUUVsaVlE?=
 =?utf-8?B?MHBXckRGQ0FDMmh2K3JxVldyaFlwd3JobUFnd2NWTFBCRmh1WUIyRWdudDJN?=
 =?utf-8?B?cHBYL0NnTlFvazk4UTBpREFNQ09iaHdianIyOGRYUjZuQ1l1UUxadlRXeHRj?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7954c41-4f5f-4462-5ed2-08db7e15d022
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:40:35.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GXgTBPUEmvhe4S8vs1G5SmWza3miZ3J9RFrXdkD75kidOw58WUulkpHIX0dsGG4bfjD5QJz+uvO5Lucrsd3jqcfSaqTNKVw5lZ66pMfR84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5482
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Date: Thu, 6 Jul 2023 10:41:03 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Wednesday, July 5, 2023 8:06 PM

[...]

>>>> 120 seconds by 2 msec step is 60000 iterations, by 1 msec is 120000
>>>> iterations. I know usleep_range() often is much less precise, but still.
>>>> Do you really need that much time? Has this been measured during the
>>>> tests that it can take up to 120 seconds or is it just some random
>>>> value that "should be enough"?
>>>> If you really need 120 seconds, I'd suggest using a timer / delayed
>>>> work instead of wasting resources.
>>> Here the intent is not waiting for 120 seconds, rather than avoid
>>> continue checking the pending_sends  of each tx queues for an indefinite time,
>> before freeing sk_buffs.
>>> The pending_sends can only get decreased for a tx queue,  if
>>> mana_poll_tx_cq() gets called for a completion notification and increased by
>> xmit.
>>>
>>> In this particular bug, apc->port_is_up is not set to false, causing
>>> xmit to keep increasing the pending_sends for the queue and
>>> mana_poll_tx_cq() not getting called for the queue.
>>>
>>> If we see the comment in the function mana_dealloc_queues(), it mentions it :
>>>
>>> 2346     /* No packet can be transmitted now since apc->port_is_up is false.
>>> 2347      * There is still a tiny chance that mana_poll_tx_cq() can re-enable
>>> 2348      * a txq because it may not timely see apc->port_is_up being cleared
>>> 2349      * to false, but it doesn't matter since mana_start_xmit() drops any
>>> 2350      * new packets due to apc->port_is_up being false.
>>>
>>> The value 120 seconds has been decided here based on maximum number of
>>> queues
>>
>> This is quite opposite to what you're saying above. How should I connect these
>> two:
>>
>> Here the intent is not waiting for 120 seconds
>>
>> +
>>
>> The value 120 seconds has been decided here based on maximum number of
>> queues
>>
>> ?
>> Can cleaning the Tx queues really last for 120 seconds?
>> My understanding is that timeouts need to be sensible and not go to the outer
>> space. What is the medium value you got during the tests?
>>
> For each queue each takes few milli second, in a normal condition. So
> based on maximum number of allowed queues for our h/w it won't
> go beyond a sec. 
> The 120s only happens rarely during some NIC HW issue -unexpected.
> So this timeout will only trigger in a very rare scenario.

So set the timeout to 2 seconds if it makes no difference?

>>> are allowed in this specific hardware, it is a safe assumption.
>>>>
>>>>>
>>>>> +   for (i = 0; i < apc->num_queues; i++) {
>>>>> +           txq = &apc->tx_qp[i].txq;
>>>>> +           cq = &apc->tx_qp[i].tx_cq;
[...]

Thanks,
Olek
