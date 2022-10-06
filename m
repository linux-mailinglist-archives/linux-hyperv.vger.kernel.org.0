Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2C5F6968
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Oct 2022 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiJFOPJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Oct 2022 10:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiJFOOp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Oct 2022 10:14:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257125EE;
        Thu,  6 Oct 2022 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665065545; x=1696601545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/d+8Ye9ckZlA4mM2GLYA6fMAWkJIf5vhmZPmWG1h1A=;
  b=KefSfVkhc7qeb8U1+vUU9yHQF1RZqH5HVpJVEuX18wnu1zMwRGCOF1fq
   1TTKODF4TbH7SUO5zwF/NqmkYIVL7tx0E1RKc8ba7POSSv4oNnepL0Lx7
   nP6Z9ij56bf6P1Q4QTc5G6EiOuRMV/NKgCygXkKsnZJeLmxE5yeoFfI+y
   U4fEuucHUYCAWnfy+MGvhhOAYNYD/iGlVjQVE7f5FJhswR+hpnBiFZyAW
   GKFV1w3pkjztzNXCjfEUEOyu2OidJCO0w8rGihEesahXtwj0gkOXhary9
   XRE5d+LXfl6rkvLA33qHE/+6aEpBJxC7RaUGB39L7CoKZ8Y9HlCF/zJJB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="329879453"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="329879453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="627026853"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="627026853"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2022 07:07:44 -0700
Date:   Thu, 6 Oct 2022 22:13:13 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <Yz7ieVurWBnNH7da@liuzhao-OptiPlex-7080>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <21632541.EfDdHjke4D@localhost.localdomain>
 <YztFEyUA48et0yTt@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YztFEyUA48et0yTt@iweiny-mobl>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 03, 2022 at 01:24:51PM -0700, Ira Weiny wrote:
> Date: Mon, 3 Oct 2022 13:24:51 -0700
> From: Ira Weiny <ira.weiny@intel.com>
> Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
> 
> On Mon, Oct 03, 2022 at 07:43:49PM +0200, Fabio M. De Francesco wrote:
> > On Wednesday, September 28, 2022 11:56:40 AM CEST Zhao Liu wrote:
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > kmap() is being deprecated in favor of kmap_local_page()[1].
> > > 
> > > There are two main problems with kmap(): (1) It comes with an overhead as
> > > mapping space is restricted and protected by a global lock for
> > > synchronization and (2) it also requires global TLB invalidation when the
> > > kmap's pool wraps and it might block when the mapping space is fully
> > > utilized until a slot becomes available.
> > > 
> > > With kmap_local_page() the mappings are per thread, CPU local, can take
> > > page faults, and can be called from any context (including interrupts).
> > > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > > the tasks can be preempted and, when they are scheduled to run again, the
> > > kernel virtual addresses are restored and are still valid.
> > > 
> > > In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> > > single thread and is short live. So, in this case, it's safe to simply use
> > > kmap_local_page() to create mapping, and this avoids the wasted cost of
> > > kmap() for global synchronization.
> > > 
> > > In addtion, the fuction hyperv_init() checks if kmap() fails by BUG_ON().
> > > From the original discussion[2], the BUG_ON() here is just used to
> > > explicitly panic NULL pointer. So still keep the BUG_ON() in place to check
> > > if kmap_local_page() fails. 
> > 
> > How might kmap_local_page() return invalid kernel addresses? 
> > 
> > I think that, if this function returns, the pointer is always a valid kernel 
> > address. Am I missing something?
> 
> I think this is my mistake.  I did not realize what Zhao was asking me the
> other day and generally said to leave BUG_ON's alone and not change things.

Thanks Fabio and Ira! This is my negligence, my consideration is still not
thorough enough. I'll remove this BUG_ON().

> 
> In this case kmap_local_page() will not return NULL.  It will BUG on its own if
> it fails.
> 
> > 
> > > Based on this consideration, memcpy_to_page()
> > > is not selected here but only kmap_local_page() is used.
> > 
> > I can't agree with you, if the premises are that kmap_local_page() might 
> > provide invalid addresses.
>  
> I'm ok with the patch as is.  But Fabio is correct and it may be worth removing
> the check in a follow on patch.
> Ira
> 
> > Thanks,
> > 
> > Fabio
> > 
> > > Therefore, replace kmap() with kmap_local_page() in hyperv/hv_init.c.
> > > 
> > > [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
> > > [2]: https://lore.kernel.org/lkml/20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2/
> > > 
> > > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > ---
> > > Suggested by credits.
> > > 	Dave: Referred to his comments about whether kmap() can fail and 
> > the
> > > 	      suggestion to keep BUG_ON() in place.
> > > 	Ira: Referred to his task documentation and review comments about
> > > 	     keeping BUG_ON() for kmap_local_page().
> > > 	Fabio: Stole some of his boiler plate commit message.
> > > ---
> > >  arch/x86/hyperv/hv_init.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > 
> > 
> > 
