Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05416F5DDD
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 May 2023 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjECS0k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 May 2023 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjECS0j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 May 2023 14:26:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5035B6;
        Wed,  3 May 2023 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683138398; x=1714674398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YU1LpqW36QSHkB5/jJBCAPcOaEJjCOlcwEq4cJabuDE=;
  b=d+CiJXswL++Yzxmr9sq2gPdw7LqjEMI9gfh95cQPi9amHqOPzBRxdiZm
   wltr0X4EekFy0OWt+pak7IgND6rD6kFAl9CBep4qqWcR1wBurAnSzp+EZ
   UHipCAYULg0wjhPOruRay5ZCNfLw9PWN10DzrZ8ltodWlz4yrV71spWyX
   /IMAtduPNj7O+3xLMD0n1bO0jERokKFz0FfUMl2/0TC/p9D4E08KITChk
   kD4VmoOV+5sZRQrA0f46BYAgLfwgRazW2SenF9sAMgEd/5sy/kx2T7L2w
   Q4/2T+zsWYOqtmc4O+PIDsRy9nK/WzYMv0YtjKJyRnhYlg3EuTxQsWTb/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="347551842"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="347551842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 11:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="761589777"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="761589777"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 03 May 2023 11:14:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 11:14:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 11:14:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 3 May 2023 11:14:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 3 May 2023 11:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTPuKaefgy/ZBI5yTNUOYt0GMYuuLIQiUjXpmenHdINhxGqLze9cIZ9zPCq5YA8j4dJuhi5a4VzI3cyl5cnoe2VP49Zt/wdakJHNTS5eLz8owErWD+nODsbZuUwFhGpZDo8UtYcarQUl+8ttLjNjDdb7M8HWDSKhmGLduc1SgVDdxsGh+/paOrZV7hZIXZmcKZ6oFf/iYDQsDtvQjY4nckax7+8tjdaaJPOQlOcyQP5okZuyJ/RzWlhIx62pnxiZoNo6djMY5jh5i1nw0tHovAGb/a+4162xKDz5c/jaZQScqOAses2uMSmCsRWHkhZ0LNBBGhs9RTS0wI8KsfgeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acApguog1hrw9FK2yIo2Pl8uvzK1Ho/Twm/E37M8al4=;
 b=T+T7MBorv47xi1TIOwGHyMRcmEKDOQVcW0BNGrcJ4It2pq8/VSWC+803n/LbvLlYJ95N7InSprwc7yKA6Gv0w7fZltFvXwgtjxx6NaNeCEknq03Xf5LKhiNpp+BxtYV13P43SDxS6qEAyPiOhvgRv12oHKOU/kDYj4siTaprfcrWRdmdduKKa2HBW68qd8PdC029D+lKIEIDlS00C0uq9q6wBpxIzBP1gVsWJo+7ayOYy6fFIJhQTi5yHfZS1JMCpPtUwDW5Qx6bboKr4xWvbDHQyWiTHMliPYe9q7BCOuRdJdnf7BNXeqaBubM2eK7ifzCXvNHphDgYrEUUelynhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BN9PR11MB5529.namprd11.prod.outlook.com (2603:10b6:408:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 18:14:28 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0e0:efa7:eda3:b36b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a0e0:efa7:eda3:b36b%6]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 18:14:28 +0000
Message-ID: <26e6947c-6c56-d8c0-1baf-1ff006258679@intel.com>
Date:   Wed, 3 May 2023 11:14:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
To:     Juergen Gross <jgross@suse.com>
CC:     <mikelley@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Wei Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xenproject.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20230502120931.20719-1-jgross@suse.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BN9PR11MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3be5c8-54b9-4457-ca96-08db4c023b98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNgUlvKNNJaYjJgnnPrK3FzXCampfuny5QwS+vmt6f2QTBm1OtW4v4FoxRAWr2v3oX/pQ6GNPD9tjH2DacjOJtF+fYMJ7ZKqrGVjxOyQ/iBJNcqUYKpWywvlW9WNfwOtGbf11KIr2L4Wjf0LdRQhFBjWqFU3ut6vFm9r+7t2DVSMijey2HtR8mfakAYSRtjGIMkZfpRQAK6Kr2zOvbIuGsK7DfwlxsYuRCousZF4c5+tXJETZMpVknUeCIlzq5dWExFaM7JTBKHGGayNYgkxLvzaocGhFKhvBYqUXP86/sy2HTNuUXjp3BqQ6WBvknnX7VbD1vv25aUS88bTQ/EgR0bx0RAZEGdR05YEiciZTAKQa4YiNDDIUrHDUZZHRlXeteBm09FZ/PI9OZ7kby99SrNYtZKj+8jYOLe1Nx0zsDKR27rXeUr9s7Zug0EZWYebbcqV0ISZToGiqAiT6VP/C/NDZhygAF4crUWL3vej2SWNT/Cp5JniHptxrxnpaTKYRF/QaGTAXFqDwcKN08px/o0mOdEC0ofUySi/iBX1Fl2SLeDAu16SvLroS7NVSy1r6EMe1g5wuliOexjTbkPHPkT0N8Co713V7/6v/iQ++Tvzp2cxuhYdH/7ZaMtXbj4fpcqHRfKvjm5hbe5AqKwEnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(478600001)(2906002)(316002)(66946007)(66556008)(66476007)(4326008)(6486002)(6666004)(6916009)(82960400001)(36756003)(186003)(41300700001)(6506007)(6512007)(26005)(2616005)(86362001)(38100700002)(54906003)(7416002)(31686004)(8676002)(8936002)(31696002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQrTE5vd2lFV2h0TDNacUxjbXhzS3ZYSHlmTzdCRG8wcHArd1ZLK29BNlh0?=
 =?utf-8?B?eGg3RkNVVkp4eEU0TGxQZHkrYkRkMVJHTnJ3SXFwYmFCbTZqeTIvQnk5aWpK?=
 =?utf-8?B?ZnF1ZlBsNVR6QnFNRXFGbnhwR2E5QWFBUmsrZzZieWJEbWFHV1lyTlRtQkhI?=
 =?utf-8?B?S2N5cXNxaVhJUmtPREZwRVNkczRLTUZsMEtkT1F4QXBuWWw5NzUvclpMclZR?=
 =?utf-8?B?M3luYUsyUUxIT1hwRWlaUm1tc0Y3Zmpjczl6b2Y2YmNsT3Y4Q0ZlTVJrMFp1?=
 =?utf-8?B?WVltM0R3c2tRTlRUQWl6cW5SZC94bThnMXUySzlMc3lvZFptQkowUXdXZjc1?=
 =?utf-8?B?SXRIK3hwMWhXUyt6ek1CcWFtdysxZDk0ekUzTDA0Ukt5aFk1RGV1ek1GUWI2?=
 =?utf-8?B?d240NzRGUmlHMlQyUDk2NURDS2JKamp3cTl3NGZEOVR3S2g3RHlqRTNPcS9l?=
 =?utf-8?B?MUE1cS8yRTJQeE1ZNW83OUsyQTN0Y2lUbmZoZGpJdFZpN1F0ejUvYSs4Nkxh?=
 =?utf-8?B?UlQyU1RnQjB4aHVQWTVld2ZKQ1Jac3NBMm5jVzNHdlZUNmt6VEoybkt0Ni9j?=
 =?utf-8?B?MFVxYjkya2ZpekY0c1A0dmZyOWlWNS9rNU1HNDBSeFQzSkRKdkFEYkovZjlw?=
 =?utf-8?B?TDNpOXZ3RHNNUzVZZWljMnJuVC91TjFyK3IzNEwxdCtwUlJUbnFKbm5mVHEy?=
 =?utf-8?B?NmpEc1BvNEphSmRCV0tOSFRLblBLbElYS08yeFc1UUFEVnUyQVh5M0ZrMmxq?=
 =?utf-8?B?WFZ6dEN3ck1Hd1ZqYkxrSU10UTJqa3RhVmJPeTRRNHVnL3kyV045WEhMamN0?=
 =?utf-8?B?dXNzYUFYd1hmTEdTbko3TFVtenJZeHJlSXhsNk10UlZ2WWZXTkJrUDJLN2pV?=
 =?utf-8?B?anNUZ3NKN1NWcFN3QTZZdlRUbEpDVzVMNUJzZ1dXUWVyU2ZXQitxbFFZME4r?=
 =?utf-8?B?WTVwUzdkSWhyVUd2Tm1KRlh6V3d3MjFadUZ2YUlYeGd5TGZWU1djM3J6U25v?=
 =?utf-8?B?Mk0vWlBxeVhtYTViV01pbWFEaGxENnc4WDhwNDZaOTMxUENYVDNLanhLNDVP?=
 =?utf-8?B?akpFemxiWGJ4ZmUxd1VwOVVXd05wSGVuMHBnbGREWFJwR3NBSDJ6Qnl3QXkx?=
 =?utf-8?B?aGRGSWRhOUprODVrNVEvRzFmQjRPL1NlT2s5UmZ1WFR4SUFYZlJaL1ZCRWpl?=
 =?utf-8?B?L1VRSWJjT25RN1hwb1hzZnliS0VjYUhhTEMvSVFIRllTSzBSS1F4QWN0bDYz?=
 =?utf-8?B?ZVBqQTdlaXZ2eWRVcnZwdklJSWpxSUVCVlV6blFyTVk1UWcwNXRDcDNiR0Zv?=
 =?utf-8?B?ZTZJTTFXZXNIMEpzREdTS0ZJcGI2RFRoYU9rbDg1emljeENoSDdaT0V5U2l3?=
 =?utf-8?B?a01ZOEZ5U1ZHL1p5T3JzaTBEQlZMZWtUK3VPUG9TdG14eFNtanpxSzZtOFlD?=
 =?utf-8?B?ZTlIU0kxT0FiNGlhTGNRY2lETnhTM0tGYWowQ1kyd29KT25yZ1FtNmUzVFhC?=
 =?utf-8?B?b1FNMnpaV3J5ZkVIUVdmS1UwcXdORkNMVko2ZXlEUkJFbm9TYWl4citBTnJY?=
 =?utf-8?B?c256YkNJUGFPaVdIODBxVkZSZGZaWVFOZnBtWHVST1B1R1Z4azI2RGZIeDJl?=
 =?utf-8?B?aVViVyswTUZURmdrRGhmd0piYkdOMlhFV0NybFMyTWtIbmcwcjN4NGc2bm5J?=
 =?utf-8?B?NlhhR0pQSlo0ZnIyV1p2V1Y2Um8zUnhrQkdEa2FJaS8rdDR2eUMrK3VDV0x3?=
 =?utf-8?B?NENtdEVHUWxqLzJNNVJoZjRKUlhUYmoyTU9iemtSN0lNRVpNZG8xT2dXalJp?=
 =?utf-8?B?M1pwWk1Nakc4KzdWMU9memdUeUJldkdaV1Z6S29RYzlYUkhFN1lXbHBBZ2xa?=
 =?utf-8?B?L3NDMHlRb2dQQVoxR0xSWWJjeWNUMXgxN0J0MmtyNlFvME1DY05qTDEvcytm?=
 =?utf-8?B?Sm82V1NKZUY3WE5ycEEzeXUvNjJzY2dIWEdVUHZSU1kvLytFOXhtSDhFZzZn?=
 =?utf-8?B?bmFpT05rZk9YSEdqZXRUeDZaazlmdFRPTnZKQWtpRjBTYTBkQURZWUVGbjFM?=
 =?utf-8?B?NUUvUDFBSjdRanV1T0pKZlV2bEx3cS93QjMvWFFURHhXbmVnQnQ4QzdCWk02?=
 =?utf-8?Q?ps/1dgk7bcBs1d+wmhSmBhegD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3be5c8-54b9-4457-ca96-08db4c023b98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 18:14:27.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ktFFMmqRMunU622QH2XA2R1m6wBuoC/irgg/3W26PGzyAN7jZ4Tz010x8zYpjva6OQxsQ2CxSOtMsk2EVa7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Juergen Gross (16):
>   x86/mtrr: remove physical address size calculation
>   x86/mtrr: replace some constants with defines
>   x86/mtrr: support setting MTRR state for software defined MTRRs
>   x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
>   x86/xen: set MTRR state when running as Xen PV initial domain
>   x86/mtrr: replace vendor tests in MTRR code
>   x86/mtrr: have only one set_mtrr() variant
>   x86/mtrr: move 32-bit code from mtrr.c to legacy.c
>   x86/mtrr: allocate mtrr_value array dynamically
>   x86/mtrr: add get_effective_type() service function
>   x86/mtrr: construct a memory map with cache modes
>   x86/mtrr: add mtrr=debug command line option
>   x86/mtrr: use new cache_map in mtrr_type_lookup()
>   x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
>   x86/mm: only check uniform after calling mtrr_type_lookup()
>   x86/mtrr: remove unused code
> 

A Nit -> Documentation/process/maintainer-tip.rst suggests:
"The condensed patch description in the subject line should start with a
uppercase letter and ..."

-Sohil
