Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F77603854
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJSC7X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 22:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJSC7W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 22:59:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142CE6F7F;
        Tue, 18 Oct 2022 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666148356; x=1697684356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lUOAbTG1ZJoa2KyDfc/R2EwdiXIk+VFFCYTRrPG9ESo=;
  b=PFXjjP1pqN7oynj2zN7NJuqcu6nf1oJfxVts2SQ8+4ttVMh4IbnAm3dS
   2O06LzJ7DHFf0Zbmre06yNaJUXRVrybqrH55K0sXyvN9vaOICkBVNny/o
   JkGjsowxGo83rXTG4CFhX8UKflUSZ3emjoeD24Oj7qfTZ2C6Jh83CfrjM
   At4y0fMrARFiYqFgSZz/0EBbMRNkHcVfKliiChCYuk09xxp/Af19HQ2Q3
   HJHi8x57BaFtC109rG002kHdYVg4QZhrYDph7IG72skFHDapjelsbWBSz
   XBSbIz2l66tabNyJlf+AKU3+KJcXhRPgu+rqIy8ipSCmXsy9VRanvGBNC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="286007913"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="286007913"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="804069521"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="804069521"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2022 19:59:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:59:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:59:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 19:59:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 19:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIorZb+FCr+/RSY0COTHYWf9onDhza5SKRYvwOkSGJ4c8fOQE3vXrN93g10O3j41zyea9EhD29WHwYayLdW0gpKnkdAzUhuPmOjklfUHX66ulgOq7zYtjN0QuB8roTb6WzspnaTSavZM+IWFqsmWXpD6MLo3VLvBdz39IQqrNbM68Imbj8kXY65nqAse0/AmYBzn2kwSo/OiJliS3fFc7sHnt+UYyM4SW0+MHnrWINZXRE/7bIgjjwiQHhSUiXqYrUcDNW8iX81u/DOyYP3U5Vdj08VwQPRYN7hV+MC8PeQtAWKEWMv7qtNPnf8AELQiU+dmT7aJEglIxmlD63yV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwY6AN4PNUcLYnjpI2vMAb6PMCLYym3HGHNR0/z/JS4=;
 b=kPk8+Ezb0p50BNCtflfp/7wCnpDFySnbXLu4v+DLfS3DVk0FLoND8iTTdlZJXmNFHju/MJO3rl5draTvi7cffq5hkSECHs9CEozy6dzFeVWXlsbABHj0f4coGT8ICGB6bWNFYa6bg3LJF4hTvbVjvKsfWMoU+wuBAqRwNEUZhsIv6MuJmuu2Sl8duRujERVNb3FNqqiKUPqkL9H0QGKxtvkO8eF4Fb+1k+0SDTPftw62OGpHmMOHS8Z4U18Fu9lA94HFmREi0JDBd+EqwVAQzIhy61tZCF77Kfp+y+rq7p+ROY3Fq9cSWJn6tce10TTgwzPvXEysA7+WRrRpSXaNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6811.namprd11.prod.outlook.com (2603:10b6:303:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 02:58:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:58:54 +0000
Date:   Tue, 18 Oct 2022 19:58:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
CC:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-hyperv@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Message-ID: <Y09n6dRN+zxsaLW/@iweiny-desk3>
References: <20221018162117.2332508-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018162117.2332508-1-zhao1.liu@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c9b97e-9057-427f-9523-08dab17ddb96
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHpJaY+mSJUGVyDiCte0uKl0cFLG0RyHFoPIkOapUWB8du+f59et33mkNBSmNyjTO8pYSq1HIXelHDJ/RAPwnLo6WpMbwPTaYY4a7pHHgsGGfzesvymebB4eOzclGdnkIpEhzQ51yAyx0S+EodbwAdg1rHJar59/SxABBc3g5PTuFWv1OYw+BSeLSxeesDdMVQQTkM+lhK/Nys4sH9kAMKme21cE4nMN19IiBU5eXIRBTbp/zryTHjhsKV/JUatOfpjGCGoTUY2pYo+RxvqFUWNiGLU3U+4JKlil3lFQIaVB6EH3wBnRTaT3j93h5t5bRC/lzs5g0UBfv01o52Ee5Ric6B+jj09x2GJgoNA7Jg56ruRAiDU8EY5lzVOUxMQRz5majDVw4tffw7qSa+Ge4mRGukOpRhTzsEUdzD40Dg72h//khDSRMR/Smq1Feug8vxSGHHZOH1CRu7tqScDNXO/y17cCXtoKISJgjAs73yQ5dip/xKD6MOh6ANCgDScsrJtqEgRmd4d59KIBQsr9churKPqi/77YnvOnyMfcZsN+2WUatyBHyuDUqUFb/Zqu/o9ARRwEoXqXPmca46XP/giX5RGm2EnmavP6qoEuy1GG+WO+gn4c8WqwLBiC28K529e98ul3+X5khE0U5zgHYUK8sRTACju11zNUwSYRooMx1mbSk5SPlzu1pRm6Wf2E3Ym2KD9iHtqABKbmfi8XNPCRkgBIgugrPtxHeMT9U8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(33716001)(6666004)(478600001)(6506007)(966005)(6486002)(8936002)(4326008)(8676002)(54906003)(66946007)(66556008)(66476007)(316002)(6916009)(186003)(38100700002)(86362001)(82960400001)(26005)(9686003)(6512007)(44832011)(83380400001)(2906002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6KO8pVUVDsfBYsHwFHhEEZMndOt6tnqVI1VKoju6eYlk7lQcJrvRjx9wVXL?=
 =?us-ascii?Q?2FKSnHJy/dpFmIPuMovR555dGgpvF0BBno7k3U2FdZJTjNf/KR4yJAfdrQzH?=
 =?us-ascii?Q?ogJOh8t6acSMz3JLnV06oeI4fRuEFA2uGqrqbv0k5t0YxB9h1TBIJMvp7HiV?=
 =?us-ascii?Q?CgPZZDe6oNrxC/4gtJJhwuRx4TIJEgjx+B5zHnK9Al0p6pvYP8z2EM64csRB?=
 =?us-ascii?Q?PP/m/IriotbHQeleGDIZmRw8Nq5WyDk9is7axWBMwH5Qbj6Ryn3gna8yMkjP?=
 =?us-ascii?Q?lquSuUBrnijvRJnW2v3B+8//yPBUEzfiykTjdtGq0VWd8/7DES1hgsM2xq1Q?=
 =?us-ascii?Q?J1jYVair1GVlQlH+NIQw/FiMy3ns4Qj763REI8Ovg7hPhzQFueAO3kW1uuCm?=
 =?us-ascii?Q?15s1konPgsWmcH+rMu5QCeWoXd3LtzheAku2qYK6kG5UVPBUMGyDPwtbqgDW?=
 =?us-ascii?Q?bGqDVacYw12EKPOUU9z8nAUXoP6a89vPnY5fekYuDTTeJsKYlFP+C6eQ0KRS?=
 =?us-ascii?Q?knl6GgGYDTicvSqqDzcE7aShxYda00/TJU49hiuxI1IQFeVncy8yaNnESC+r?=
 =?us-ascii?Q?qpXSm/aLUe6F86VkyOTdspgu6aNYUx09TEZFAPXhpZXoxNsBUt8kVTW8uUTl?=
 =?us-ascii?Q?z5KnoQIaHF9lFE1iaBXz0ExKzenWhPhSAO1JLvVJCIDkBW246v1KZrsW8kJN?=
 =?us-ascii?Q?OhLHFD1eIK/DwMF4NCBIPHyeC30CNzrQllIteoLcPPH3J3xafohqfMV2TSIx?=
 =?us-ascii?Q?XGG3mZfnY6iRebGcTu8f4UPvJMt4Bg+0G49veLXzycPmwiJU6l+iedpxf9vk?=
 =?us-ascii?Q?TZ4DWVuIFxLU96ZOfE/as9NYrju8e8t0l6Haec5HA8GUhCPOdyGrlZVHr3K+?=
 =?us-ascii?Q?dM1ETYaaGad9vw8W5S9io1n7GTrJgHv2MOkT0HNN4KaS7thyTRFH/OLkL8tj?=
 =?us-ascii?Q?eZOmUqUmbqz/rXxq3PaMHMA7kzjYgZfNV7j5JRhtfAnwL20E72FYFvz89COu?=
 =?us-ascii?Q?1934/Oga1DzOUWWaE1iWTnqjh3fB4gjDnUpjkRJ5j4x+/U9aZgkIEKzbre2g?=
 =?us-ascii?Q?lVNXawGJOqdMilF6R0KT3mOY7L9QMeQs5XISvZSRcyq1JrH9B9XDB4wLHMUF?=
 =?us-ascii?Q?sUOwvAjlguu9vZkMN9S/DomqRFhMz3B4OfYLrEnAWivXkZyt9WUt7lFsP+ow?=
 =?us-ascii?Q?Jwbn0fW79jyurKlqVyfXhXcwJ/wcZojzbOYWvXezl4dBIunpmToku2MEGnLQ?=
 =?us-ascii?Q?YXh6j2d2ftcoAtmIgjN0XNEAvARs85bpjYRajvGVaYieD8gAjJ9/9xqQ9a5i?=
 =?us-ascii?Q?eoLFv5pwLv2C+i47l3WgGI3GdQdfr0vzxCLJ4cyhx9pkUmwmMqxs6YLnt1om?=
 =?us-ascii?Q?LrDU6HdZ0jRf28gHl3QJYYlXpIg1WSWjXJyMYR9R5s1hhyD9wKpdoebgY6nr?=
 =?us-ascii?Q?0lE4BvVV8EOXns4ZLXLLYfQUEBroja1HODX/v9jJVxUroumsov/MIXFfxVF2?=
 =?us-ascii?Q?/tVo2DVyQ+qLCH00+xhHnMPG689RNJsT466N7KcVed7IoBcUnllz577sDyaW?=
 =?us-ascii?Q?MmzLOMwxFTVsD+3/36H76T/g5sZz+38mV3n12+i8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c9b97e-9057-427f-9523-08dab17ddb96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 02:58:54.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoGIIeU0uwuEqPpWXB1CjMftcEHVgY64cBxZQJ3tlP/Jm2Aa51wu2gxNB6KmOPWxzKON1K1lrDwx3RsjXqJHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 19, 2022 at 12:21:17AM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
> kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
> fails.
> 
> But in fact, kmap_local_page() always returns a valid kernel address
> and won't return NULL here. It will BUG on its own if it fails. [1]
> 
> So directly use memcpy_to_page() which creates local mapping to copy.
> 
> [1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/
> 
> Fixes: 154fb14df7a3 ("x86/hyperv: Replace kmap() with kmap_local_page()")

I don't know that a fixes is required here.  We are not looking to backport any
of this and the other patch was correct.  This is just a follow on cleanup.

> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Code looks good.  Without the fixes.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  arch/x86/hyperv/hv_init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 29774126e931..f66c5709324f 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -459,13 +459,11 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  
>  		pg = vmalloc_to_page(hv_hypercall_pg);
> -		dst = kmap_local_page(pg);
>  		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>  				MEMREMAP_WB);
> -		BUG_ON(!(src && dst));
> -		memcpy(dst, src, HV_HYP_PAGE_SIZE);
> +		BUG_ON(!src);
> +		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
>  		memunmap(src);
> -		kunmap_local(dst);
>  	} else {
>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> -- 
> 2.34.1
> 
