Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AB06059A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Oct 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJTIZA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Oct 2022 04:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJTIY7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Oct 2022 04:24:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B48BB8B;
        Thu, 20 Oct 2022 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666254297; x=1697790297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LIQIgRcbz5Lb9wHlEl2vSnyQOnSfQ4cdPljf3Dl5Img=;
  b=nKcd4EaesVfe8eh0c6coOHXHQ1NNHNxz+taxxjhR/QQawcNnybzi/P9f
   ciTdHz5MNNDINWTensI+OCC9qh4hRrUpL+ACPeqEMT86S9XkU5Hnzfdh3
   W/iVZf0vgtxB45hJEwY04kKWWxTtwbmkDm0fRCvkkV8ddZ73mXQmXn55J
   hflO/Fixcv1ojFUamp7BGofYY0rJH2Zjf/D5fkbS23flCKaQY+EZM8NpM
   cuiGcxOES+0tv7MkwjWk2tONn+kv+PQy9kViFpsO+V267zVzJkbziDUh0
   KZNyiRUqG+Z5NG5W6BuhSxWgsHyJ6ZAp9wiJleXbeSNh09HliNGpaT10m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286365394"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="286365394"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607536732"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="607536732"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2022 01:24:53 -0700
Date:   Thu, 20 Oct 2022 16:30:29 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Message-ID: <Y1EHJc7H/63F6rxt@liuzhao-OptiPlex-7080>
References: <20221018162117.2332508-1-zhao1.liu@linux.intel.com>
 <Y09n6dRN+zxsaLW/@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y09n6dRN+zxsaLW/@iweiny-desk3>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Oct 18, 2022 at 07:58:49PM -0700, Ira Weiny wrote:
> Date: Tue, 18 Oct 2022 19:58:49 -0700
> From: Ira Weiny <ira.weiny@intel.com>
> Subject: Re: [PATCH] x86/hyperv: Remove BUG_ON() for kmap_local_page()
> 
> On Wed, Oct 19, 2022 at 12:21:17AM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
> > kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
> > fails.
> > 
> > But in fact, kmap_local_page() always returns a valid kernel address
> > and won't return NULL here. It will BUG on its own if it fails. [1]
> > 
> > So directly use memcpy_to_page() which creates local mapping to copy.
> > 
> > [1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/
> > 
> > Fixes: 154fb14df7a3 ("x86/hyperv: Replace kmap() with kmap_local_page()")
> 
> I don't know that a fixes is required here.  We are not looking to backport any
> of this and the other patch was correct.  This is just a follow on cleanup.
> 
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> 
> Code looks good.  Without the fixes.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks! Let me quickly refresh a v2 patch without "Fixes" tag.

Zhao

> 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  arch/x86/hyperv/hv_init.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 29774126e931..f66c5709324f 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -459,13 +459,11 @@ void __init hyperv_init(void)
> >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> >  
> >  		pg = vmalloc_to_page(hv_hypercall_pg);
> > -		dst = kmap_local_page(pg);
> >  		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> >  				MEMREMAP_WB);
> > -		BUG_ON(!(src && dst));
> > -		memcpy(dst, src, HV_HYP_PAGE_SIZE);
> > +		BUG_ON(!src);
> > +		memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
> >  		memunmap(src);
> > -		kunmap_local(dst);
> >  	} else {
> >  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> >  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> > -- 
> > 2.34.1
> > 
