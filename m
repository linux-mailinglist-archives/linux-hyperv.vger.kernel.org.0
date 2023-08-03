Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0D76DD4E
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjHCBgk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 21:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjHCBgX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 21:36:23 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B935BC;
        Wed,  2 Aug 2023 18:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691026543; x=1722562543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r8vJE8l3zuZ4BobmQd10BxM0ZbmChZQudFLILQ6vHIk=;
  b=Nuq8orbcxKGi2reIE8M6s8Z1nqObraBQR6t/y3eHLdhWvwSFwFmEZfA1
   jHydksusq4env2/tmjP6DgEhw3HBh+9lkN9rcXKg7FQGZT8Xd3FOAHheQ
   e4m7vs8V3ixkxHU8XqMqJbho9uPEG6tBCLk1m3C46jomSBZ4nM2PobHSi
   0Lu3uhvuQUberJo6k/m3K0n00BO0Ix7ybXyZnSXJD3Gw6oQSAnj445Qrq
   8lNymerA+2S/pbYtu33uKBD3Kx2i0b0RJp3pDBytCbP0nps5G2Fdzpnyy
   6Sr0AWn79kLHNisPxR6LO3EyF8EbCcGTxIdxwDBtXTjvc9WzxugZEyAkm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359784342"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="359784342"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706372859"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706372859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 18:35:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:35:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvXw911pOhO4EuujoeH801N6Ffbq9bUzxa278ctH5lQmZlk5Z9hmGr11fmAWz760g1WLB/gH2zxle6Vxqovr93E7iFy5fYdkhn9V/vIbmJPBU2ggMBX0eRQXLrmusa84jKS7ZojB/YNFWIKcENfgkQX77/TzRuYW8FWZX5AR6b+ubwb/9G5bM81J6stSG5AHFiyJlfq8ORdOfk+IJEdvZOarol7i8E2xGPTwy3vUm0KYNk9zOd4GYerXUfdEjWgTLEc5WAivBPE7FTrxXcu11kyQJ4eyp7ay4XmNzTsZZ+gbvMNOCpohW5J3jVxE1HjI9qKSuQEK2frYJ/lVHuK9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejs60nj4qdcgnPGIVRV9BbLtVP7irAhx4dI9c1SYTc4=;
 b=B+P5x4E/Rg+hLvpzktffrqN00goGjsnBoODQ4h9jF039dI0Kxsa26uI2wVmiQvFWNMIuRRVNlpyd8m3S+gocaH6G8S3ww+d+hfTo7iBq+ig5e4gq+8eICINCkuRXBNp0hfvKKA52tbGmvRp3eONNqlyml6A+NwUe9xN9K3vUomnUbIUpyzppUMNO8YnWMPD/4To8/wYuff4kulUqaQj4COUu0TbcS40yC8C0RAHjXIePHOoZocnqZ6Au8j6TX3/VqQnIOEn7KdeHQJCtid2wufm7zZD8QGB2U0DfC/zIyxUEMOaxCTBRWo8MoVRuQce8QC+eIFbjpZ0WVytnQ0RHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 3 Aug
 2023 01:35:38 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:35:38 +0000
Message-ID: <d87b30ae-8f4e-611c-1cb4-9fe02abd1845@intel.com>
Date:   Wed, 2 Aug 2023 18:35:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V6 net-next] net: mana: Configure hwc timeout from
 hardware
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
CC:     <schakrabarti@microsoft.com>
References: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <1690974460-15660-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::14) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|LV8PR11MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: d5843063-1a63-4835-c046-08db93c1f0fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFT5GqZmajmmVg7woQfBByRnEnfz5rXyHerSZSb2/NNOk1kTqOz0gz3NbFAAk2JX2evwFvEAA6O4v1RGhCTDVjJJZ/knbOjFsfh3pkJstcdGWBwEC3N7XccjAiAM3NFq9sON8FXaqGk9FbEFeg1K5WpW9TrfHQBfqYdPz8kzdNclvwpZJIvcKLT9JU+vxMBjwkV8wdb+kEc5FE3fQ8MsKonBJLJT6MDQwEmWuiCQseeIXYxLWPwXbv9PGF2ZovH5fNSDLsisPxpg9c3wxyjBWLC0TPfWEKBniXNTBGXtXGYxeycOS6jYQD79IvGbyDHw8sBSOzVWb5BKHNV+4Eg4jtnwNv2PlyV8cR3SU7TYqW6L/DxvWXYwJ6aiG4rTyrCiJsQ9ssCcwyCaUVcwK77bkS6DyVOqHz8ygR0o/qU9I42Yef3hY+QVEddueKkafAIuJcxGnGu5LrHAvpeQbB/khhxnq3Dr30WeTRXV4dEivfPJEaXU7RGvmWkrvQJtYu2Liju33NkJoxIK20yHrzLQ/SV2HfrJFFI2LANsHVXF+FoNLfihhDAigUCkcinsbFwqcE1cm2Y5+dHAIsGDLFsjVfYj9SQ+hlKnO9ug9HaozZc3vw/oM0O6c0EfekNdvZeCKmOrU9BySy1W9I4XVOIkyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(83380400001)(86362001)(36756003)(2906002)(2616005)(31696002)(4744005)(38100700002)(921005)(82960400001)(41300700001)(6512007)(966005)(4326008)(316002)(26005)(31686004)(8676002)(8936002)(66556008)(6486002)(7416002)(66946007)(478600001)(66476007)(53546011)(186003)(5660300002)(6506007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dPRHZqSnppZjkvSzc3TGpHQVpGcmlJdnN4VlUxSEtVWEtObjVpTnpxZTBD?=
 =?utf-8?B?L21yb2QvVnRTN2JMSVowUGFlUkVUNG5CWU5RUi8wbTRkWXhJQ2c1ckpnOXF4?=
 =?utf-8?B?QUV6MjI3VGxHNnRsVjNjZnM0NGVkcnlLcWxyMEdUQm9zQ3R4Zk5ISnB1REph?=
 =?utf-8?B?V3JuQ1JzK1J5NUI3OUUzd1RIUmtFeTNXR3o2SEI1Zlo5VDJSTmU5bXRSdjM1?=
 =?utf-8?B?Tkl4WkJwdEJQNGtkWFhFdldKWlJGQkxGa2xNYU9WUkdXbHFXOWdSWkowbkRV?=
 =?utf-8?B?L0IwNGcxLzhWdzJhdlZsSklQS1RFNEVMdFlwY0JJaEZtVWk4S3ltN2FoZVds?=
 =?utf-8?B?YTVOUXdXU05kT2E4cmY1M3ZzQ2xzcDJDWEt4eXVJWDhoUzJ2ZXZRNXpJdmVh?=
 =?utf-8?B?YTVycDhReXFub05ndWE5M3F0R1MwSGxycWptaS9ac1YzTndPQkdXYWQrRlZD?=
 =?utf-8?B?blhKd0c1RkFEQ1EyZ3FIdDU5REtVb2JCeWJYbG5RRk5OTkFNUSs0cHdybFdB?=
 =?utf-8?B?Y0RhS0RtQnNUN3BCd3lXak9OS0RVU1NPNjd5Y05uQlN4MHlDWHVCNnpYWjJx?=
 =?utf-8?B?eWEzQ0lPOWV3QmxpWVl4MTFlV1BQcGdpODMrd20yd3VKUjU2U2ovQ3lyTzdZ?=
 =?utf-8?B?aEZSRWVIT0dJN09oVTljQWNYUktoMDZBRVdOa1BsbmI2QU9KYXRUNXpZRW9N?=
 =?utf-8?B?czUybkkxS1RPaCt6R2UvWGtKNVBNcG5wcDJsTnk1VzVCYm5HclVYNGNoYlI3?=
 =?utf-8?B?UWcwSXVEMk56cVdBT1JuWEhHYUJBVGcycXZmTVRTQ3pQcVNqNnFCcXFkcjBu?=
 =?utf-8?B?Z0ZJV1RNS2ZMYitoNlU3M3g5dUJnYU14MElad3RDdFd1ZllJazA3UytZcDc2?=
 =?utf-8?B?OE1VUkI1dFl5Y3VoN1BQR0NIcFBCTkJXSnFZbEtCVWhPb2NQU05LamcvYmcz?=
 =?utf-8?B?MG94UEJnSkJNKzhRbkUxMlRoY1FoTU8yaFcrTVB0ZzUwRzdIQlljN2grYW5D?=
 =?utf-8?B?dWNoTkNZOXJ4dWVzeW5JbFpPOGd5czdTcVhQSGVwZTNwUHdJRllrNDBXNDJK?=
 =?utf-8?B?RVI3SUhsL3h3TVgrUHlITXYyQjZ5b25rUzdacTJ1KzlOem1KNHJydXlaUS9T?=
 =?utf-8?B?b253enN0d2c0R2JlVjRRQ2VGMWJLd2E0WWgwVDN1cHpJRXcrUXFRRDB4bldR?=
 =?utf-8?B?VGovQnF4bktrYlNtajFwb0dMVldKK2dZdmI5YXZBYXRnRmM1aUtoeXIxL0Fu?=
 =?utf-8?B?YVhrdTczc050R2hJenlzMWxBeFRRZTBaOXBwc0tWSllrL09IZUtSSEdGQ2Iv?=
 =?utf-8?B?NXRoOVY4b0NFdEw5WTk5UU5NVjQrdGVITDJSSGkyOGRmUUNqMitPbUEzTm8w?=
 =?utf-8?B?YS9qVTdlYjBvYTZFd1duK2NqNjRLY083eTYyUTQrc2ZFbWRNT1RDVFhNcUda?=
 =?utf-8?B?dnh0MllGMCtCMnF4UkE3bTNpVXBNMnZ3Q0Zocy9QaWw3aFVxa09jQnJ5Y002?=
 =?utf-8?B?SXI2UGUydDA2eFZCR3QrYW0vS3YrTEg0TmRvMW9jZEJLbXJVS1BPMm95UUxp?=
 =?utf-8?B?RGw3M3YrekliOTVJQlAvMWFHR1NPRjhwOHN4RTdhK1RjYVFNTVlEOUpnMWV2?=
 =?utf-8?B?U2tUTThxYndtbWVkdnlRUEpkbkdCbVE4R2JRMlNwMStBa0NHR2RFQ0tTOWlR?=
 =?utf-8?B?QzNHa2FMckM4Z08vNkJiUTdsN0hLcTg4cThTeHQvNWl5cVY3dW1WZDdCR3FG?=
 =?utf-8?B?NzJ3UnJrU1htTkJGQzBzUDlDMU9GSThsZmFsVFd3SFVTWThNcUhERkt2Tm5D?=
 =?utf-8?B?cXIwdG1uTHdqeHdWSk9JanZXaEVJRWluc1lEaG5Ta0tkVWZERno0WUdvdXJn?=
 =?utf-8?B?NUxxcyt5eWYrYzFqaW1sdFAzTDZ0S2RvZjdIUDQycjhxdElPaHhhNTZmUjBC?=
 =?utf-8?B?eEx2aUhyNkkxT0pESDFwenVtOUlaWjVKZ004VnhFMEZqT1Z3QTJLN01DbEFx?=
 =?utf-8?B?YzJGaHFySTZtTmZKOVFwVFMrdDdVWTlzNWxleW5Mc1d5RkdTSEI0emdleUVB?=
 =?utf-8?B?UGJsaGdHTldHK3IvekFFcmZlLzBoMktrQmc5YUpabnk3endETERsY2k2d1Vv?=
 =?utf-8?B?ak04UkUvdEhWZGRWZHp0VmlXWWtvWXBwbEdRQ09ndzlIKzc4bVJlcUFMcU1N?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5843063-1a63-4835-c046-08db93c1f0fd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:35:38.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0Lz1H/xF65HvkSvACIdiAa3mFdXitBj/DRbs+YB81Fbh9Uk1I4U3ohW5ZJBMrE1JU84tEpCaOCM46odcvEMRczD+KjmCqxGItBenTbKnFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
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

On 8/2/2023 4:07 AM, Souradeep Chakrabarti wrote:
> At present hwc timeout value is a fixed value. This patch sets the hwc
> timeout from the hardware. It now uses a new hardware capability
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG to query and set the value
> in hwc_timeout.
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Looks sane, thanks!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

For future patches please use imperative mood for your patch
descriptions, no "This patch" [1]

[1]
https://docs.kernel.org/process/submitting-patches.html?highlight=imperative+mood#:~:text=Describe%20your%20changes%20in%20imperative%20mood%2C%20e.g.%20%22make%20xyzzy%20do%20frotz%22%20instead%20of%20%22%5BThis%20patch%5D%20makes%20xyzzy%20do%20frotz%22%20or%20%22%5BI%5D%20changed%20xyzzy%20to%20do%20frotz%22%2C%20as%20if%20you%20are%20giving%20orders%20to%20the%20codebase%20to%20change%20its%20behaviour.







