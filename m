Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FCD5F3701
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Oct 2022 22:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJCUZR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Oct 2022 16:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJCUZH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Oct 2022 16:25:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2CA1C434;
        Mon,  3 Oct 2022 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664828705; x=1696364705;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h+ywqoVI4MxLkFx+thMhBrPOXtkMukHCbdG3wLyshNA=;
  b=myKzW+0HzdxPUIbAOb8QuRqaqdECHivFF7k/TzrZDe+C01W1/QxX6+aj
   VZCOdz7mBBAyrmLRnxdIveTKujW8hzH8voNgbS5+yCrnOK7Ki4Y7f5RCw
   54UOOfG64petQn4eMUxoIbP4Qvq1m+uBmsiSQIbf6RkamMDUFPoCU/1dC
   Dt8TctVZH/xoOZ4GGiqBrhOIKIzVVUapvi1VNWsCKYnKABg5NYzw0NvY5
   bEl7+FcOw9r6JPd0B+Pe8GD4+7Exfgd0zwT4oMfTAO9/07KzPQF59WjKm
   PkJxxamzCnluUwPlbay5j5h6Tye+8x9zE3XgDMTaJkMwOBUH0iW98NC7S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="364651005"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="364651005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="623686046"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="623686046"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2022 13:25:04 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 13:25:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 13:25:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 13:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCcYyMVJLb6bgGMNOnV+izub5RbZulpHEoSPU6XcgFYDonWdOcWDN9gmGa0wasNunIpXDPElpjbchTwH8x0AT5MWI8xyqBWizOY7c7K6sLUCtmqkLzO6llXaiiFogWjBJfqTdTTIqMxLOly4HsPmM+KNWtq5x6Y3pWPN/ndCzptq1/Yg8mhKkL+VXL3L2bn+dNX0AHF1rHpePBTcMACQcijjeTnYxVu70GjpXoki4+ceTVoufppEJm5dmVcmrz170FMCghRDZTx+XCXTCFB25jv9k7rSfHTbyLIEkKobOo1W7VxyNVdl/wtogZH+VHNTx4rtBVR2TSTHYbIhD+Q8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhZpzSbfq5KKokFr53BAwxGXMnJlTkSWcfqXK9Xe+c4=;
 b=GclSSlnF4DN6eWs0jsdSZF8GDp4nxJ3wPIhE7jr0k5Rcie0mQqiPbTgXxHag79GSLarN7DFIzN+4OPG62FpHrgTdE1kXpI0dUotBRXpWx9dAzeil0sAD19fk68vfQ+ZFDllAuMy5kAnMBEUT2zx3mJj81HMs7tPUiu4HLcBkfV74I+ebyYi+BSs2EiikMrSW2CMPVExVhhfQizp1KYwc/q5v/oUgZP/xrY9GuExLClfUvJeWxWt2i84TbeRHi6+LKPppsgEhGkLDIFyxB0zJU2/mOwaoDMNF8eouTmBpeAdaOADanBW0AXzbeVDKEvlj6TX3V+SXedU6k02kqt1DQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Mon, 3 Oct
 2022 20:24:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Mon, 3 Oct 2022
 20:24:56 +0000
Date:   Mon, 3 Oct 2022 13:24:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-hyperv@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhao Liu <zhao1.liu@linux.intel.com>,
        "Zhenyu Wang" <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <YztFEyUA48et0yTt@iweiny-mobl>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <21632541.EfDdHjke4D@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21632541.EfDdHjke4D@localhost.localdomain>
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfba0f5-d1c5-47f1-6c61-08daa57d5675
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUpYK/ngny80s6HQNKZlS3JZLOs3UH/pMTJlvyGj1XtHt66v+SefQso8HKrRP0a0n41ThCrkaMOE9hRyfpURAOIHAWkPpAJQ9NAqblgJ5ijjQvnzaeJeQMawlR7zdvBt75ie5wVn3/u7prmQT5xcx5s7azdWmvfc8PW6UTNwaNNNawldLMxiq9+AckRIdAWBPFgMYCgo8Vh4VIPoI0msXvI6mzGfyk0ly5E0CAgkE9f9Ne1Kzmev7dTc/ObSVSBk/JJxAvmeOuREkZiC6d+44kMWFm4FdUt1HmF9m1mCS/8WZ3fEG941Kdc4Ocu1Z5ghOc74K0CoXoVCitUHZYtBpb43+YR3CW82YVyk1PJnH5bJpcmOQgPPnYgZxplpSdX66Lh48jHzYGvpwT9JUjMZVWU1tiI/zaG0uho1iX0+gaC//4+HTOxJK0J+llGfqQQ5rUd/Tih1sKMRITPilLHQAQp3DGoUecjBt8IBI9u7GeMW+OlXSdl2VnMqaXF88zjFF4kUM+tgs3ktrzCKO0mTrPTleQvDwWrQwVeC4wDKzeppU6YxT7fv+yW+l9tZ+Qpj32TIgQsVdwp5vu/+8aWAuOxJFNFdkakBKYAmuorCslviewc563O/rOYCJMfpCGQdPC9g8wpbqXAh79cRoj93SmVMNlPdU1FHZskhjH8uin9iLJUfOOa+P3Uv2XrP0BGvE+o6V5lFkNpvwyjqRUr75i1J27TZXVEk2EnLcRrj0Cm5UGGhYm8eVe6jxDT/FldCURdrn7ZrQnic0xHo9wzKRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(53546011)(316002)(8936002)(6486002)(966005)(4326008)(5660300002)(66946007)(66476007)(54906003)(478600001)(7416002)(6666004)(6506007)(6916009)(41300700001)(8676002)(9686003)(6512007)(44832011)(66556008)(186003)(38100700002)(33716001)(82960400001)(83380400001)(2906002)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GtCdsGkC//DXCvs8KYoYnL/sxnOK4fCZn+b3UUc3nw2Xd1hsbtUCmwW0i3vh?=
 =?us-ascii?Q?+oBXQzDjMkVWlLtn20BSm5R/qOKK3We3398U4iCcLa+F8aaf78zeJFilZ+wU?=
 =?us-ascii?Q?yqnCByRbKg2H5ASV6reD4IEwLz/x7ZrnjD1VZZteNblaXmZOQW3xgHOsSlgf?=
 =?us-ascii?Q?pInYZVMY1QSdTxj7tCQxkZ4DiH6fYp1KlsVlIbbmX+lacir85s7If/P+e3L1?=
 =?us-ascii?Q?FROpmLYwqxbe+wJyWgx/cLedtUwrBrQVsylXfY/EmbS47ylPNrkEofGHyhRI?=
 =?us-ascii?Q?jLMsRSXiJb1SZVP9zC9Z3cIIgOcHFYdFj160NxPxw2fwhvvyc8Oeq2NjsM7J?=
 =?us-ascii?Q?DSWkDKdsmZYx8h22Q9FePazmmYmLkLm9+WxW0zVOYbDfWh3q/Xm5Gw60/1li?=
 =?us-ascii?Q?JHdQ6XxrMJclgfy2EJ7kwvzyM6HIoXiT3zl7ajlIN7sRF/fGu2CsxBHdu5kB?=
 =?us-ascii?Q?2F+qo/38F1sH3WQX0xWlnaYFgBwmLhZ6CdXOAXFqSKnYaKeWTAFCbnXYJ37u?=
 =?us-ascii?Q?ql5Rm7XmZfelk753Mh9dIcHInZcCMzCOBmH3Jq+mu2X1dqk7F1GtW3ktRwoy?=
 =?us-ascii?Q?Wrnkb1a77VIgr37JDuuLKXu36fdz++FoOQTzaUqzM0tOs3wEr4DsjGm8JQkN?=
 =?us-ascii?Q?UM/V6NEILGVDiPHjIrEKs3Am2gOez1RipSFTEdMiy3SNPZiRDvNIlXPa+k09?=
 =?us-ascii?Q?yvS22w8NEqPZJJYSlB6xvmCPm+gPCOn1bs83aMnle7j4rlPoy9kQFqciC2HB?=
 =?us-ascii?Q?mzVcaux0lD1LYSOImmumUFoF0dU94FrvRGKPonQy31k3cydAWObljAh1Tvh0?=
 =?us-ascii?Q?I3vAdeYcu7gTg5hzNqXlbY3TznJwa02TsHlalzCJSP2nMRRTb2ExaMutIWJK?=
 =?us-ascii?Q?Q4pPpm4ucnLgTYzI+a73wjMTcJeQa7zDYVXmHcvQJKiB4gVDKIEqIfM30Hql?=
 =?us-ascii?Q?Ot7IB9/WsRzRE7HOBjVt3/voqAgmBl5oGmPqnMPk6TKGA7XP2TodeEppHQPo?=
 =?us-ascii?Q?+vBUpG23eN0QE4CjzoN7Z3r6qNoIMx9krYfoKKSBV7Ci9ycjAKajZbYAo/cX?=
 =?us-ascii?Q?DzJK6V6O/6Y9DrFQjZNEGMTEzYTZF5NMy7DI20lVFUTAOwpzbC5/VKFbu93w?=
 =?us-ascii?Q?mK7h0RX9D2Dwkvz2PQ/vGA6dXbtk5EJ3InxhDrn6CT422zcVuD1IDom/ldE1?=
 =?us-ascii?Q?IcToLMzujPa/tegBZ47+yvpVnBFNJGI555O0V5fd7rtmnExnTvA5efrpJZr0?=
 =?us-ascii?Q?l5bQbblkh0g140WyjZOj1cUiztwUNtykvSTo96+VaIoQSbq1p1oDpSvVA00L?=
 =?us-ascii?Q?oOJVKR5kREiPizYALlfz7j9NEER5MJgO+knchfoFwmgU+sdV7JeHIiALoAeh?=
 =?us-ascii?Q?m7PtrznlriLNOrGQHGoIx7YA+mDL0nMsZoUY9YkpRHlCnXsNZKCRSpEAo0yK?=
 =?us-ascii?Q?qLLec06lLSs/rIRgdX9GYfeM1J6d1815HHbnNDT7uMw4jf8T7rNolWueWvBe?=
 =?us-ascii?Q?7gyxFzAvgjFjyn1aezhF//qKxpu3kyX2VroUL8qqKdxycb8tMNhyMRD2m8+4?=
 =?us-ascii?Q?FJf0yeXlCw+hC6EmwaKKbQvCxslaV1CbZVhC0dkp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfba0f5-d1c5-47f1-6c61-08daa57d5675
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 20:24:56.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TQbcD5VhI77/8TUE4TLsV5Xhgc/lQVu8ZzwC1ABb3gfhHHRU7E2TRpJETTwmavYFOQ/bhHqZ52pM29ze8kXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 03, 2022 at 07:43:49PM +0200, Fabio M. De Francesco wrote:
> On Wednesday, September 28, 2022 11:56:40 AM CEST Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > kmap() is being deprecated in favor of kmap_local_page()[1].
> > 
> > There are two main problems with kmap(): (1) It comes with an overhead as
> > mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when the
> > kmap's pool wraps and it might block when the mapping space is fully
> > utilized until a slot becomes available.
> > 
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, the
> > kernel virtual addresses are restored and are still valid.
> > 
> > In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> > single thread and is short live. So, in this case, it's safe to simply use
> > kmap_local_page() to create mapping, and this avoids the wasted cost of
> > kmap() for global synchronization.
> > 
> > In addtion, the fuction hyperv_init() checks if kmap() fails by BUG_ON().
> > From the original discussion[2], the BUG_ON() here is just used to
> > explicitly panic NULL pointer. So still keep the BUG_ON() in place to check
> > if kmap_local_page() fails. 
> 
> How might kmap_local_page() return invalid kernel addresses? 
> 
> I think that, if this function returns, the pointer is always a valid kernel 
> address. Am I missing something?

I think this is my mistake.  I did not realize what Zhao was asking me the
other day and generally said to leave BUG_ON's alone and not change things.

In this case kmap_local_page() will not return NULL.  It will BUG on its own if
it fails.

> 
> > Based on this consideration, memcpy_to_page()
> > is not selected here but only kmap_local_page() is used.
> 
> I can't agree with you, if the premises are that kmap_local_page() might 
> provide invalid addresses.
 
I'm ok with the patch as is.  But Fabio is correct and it may be worth removing
the check in a follow on patch.

Ira

> Thanks,
> 
> Fabio
> 
> > Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.
> > 
> > [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> > [2]: https://lore.kernel.org/lkml/20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2/
> > 
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > 
> > ---
> > Suggested by credits.
> > 	Dave: Referred to his comments about whether kmap() can fail and 
> the
> > 	      suggestion to keep BUG_ON() in place.
> > 	Ira: Referred to his task documentation and review comments about
> > 	     keeping BUG_ON() for kmap_local_page().
> > 	Fabio: Stole some of his boiler plate commit message.
> > ---
> >  arch/x86/hyperv/hv_init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> 
> 
