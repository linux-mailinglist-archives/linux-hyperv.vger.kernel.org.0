Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5C5F9E3B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Oct 2022 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiJJMAu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Oct 2022 08:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiJJMAs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Oct 2022 08:00:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0411C08;
        Mon, 10 Oct 2022 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665403247; x=1696939247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qc8KBo61qGqvxBGTFRD0uMSQ3WRB4ADFVjvxWhvj5ig=;
  b=RUk00x5Xjmu1ISlygnYv8LCHNAtkaaU1Zg70D5Jqi7eEKEPYvd0E0/ts
   JMjD3jvemB4+Rx0xj8BJ6AoXMBWFKZbpPcEvtxZQPQ8vk1ZC61NP7xKLs
   k8A2eV/Lr6W9zEHbBwq+5djN2J7noGhYUI+4NNg43DPG7/NavOuIrYi6b
   wF2niALGE9qF826qUzgj2UaT4Vfk/GcRjIz3dvR9t4gXHaVuHshIuxM5y
   BgP1cig18gSU+EkpOjdPeHy9hR9zAxdYi+0+A/feNstjHI9Ou112dOZJ6
   coVeMn2oEFI2fqDid/YOjlEc32EQrRzioX+4aEf7lvpjbqrKgDWVZ8FNX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="302944434"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="302944434"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 05:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="625946134"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="625946134"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga002.jf.intel.com with ESMTP; 10 Oct 2022 05:00:30 -0700
Date:   Mon, 10 Oct 2022 20:06:01 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
Message-ID: <Y0QKqS2Ojr+7KYmp@liuzhao-OptiPlex-7080>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
 <YzqiSK/s/oExlSrb@liuwe-devbox-debian-v2>
 <Yz7kd9oTs2Zn4YD3@liuzhao-OptiPlex-7080>
 <Y0MzKa1nzfP+mhtX@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0MzKa1nzfP+mhtX@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Oct 09, 2022 at 08:46:33PM +0000, Wei Liu wrote:
> Date: Sun, 9 Oct 2022 20:46:33 +0000
> From: Wei Liu <wei.liu@kernel.org>
> Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
> 
> On Thu, Oct 06, 2022 at 10:21:43PM +0800, Zhao Liu wrote:
> > On Mon, Oct 03, 2022 at 08:50:16AM +0000, Wei Liu wrote:
> > > Date: Mon, 3 Oct 2022 08:50:16 +0000
> > > From: Wei Liu <wei.liu@kernel.org>
> > > Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
> > > 
> > > On Wed, Sep 28, 2022 at 02:08:40PM +0000, Wei Liu wrote:
> > > > On Wed, Sep 28, 2022 at 05:56:40PM +0800, Zhao Liu wrote:
> > > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > > > 
> > > > > kmap() is being deprecated in favor of kmap_local_page()[1].
> > > > > 
> > > > > There are two main problems with kmap(): (1) It comes with an overhead as
> > > > > mapping space is restricted and protected by a global lock for
> > > > > synchronization and (2) it also requires global TLB invalidation when the
> > > > > kmap's pool wraps and it might block when the mapping space is fully
> > > > > utilized until a slot becomes available.
> > > > > 
> > > > > With kmap_local_page() the mappings are per thread, CPU local, can take
> > > > > page faults, and can be called from any context (including interrupts).
> > > > > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > > > > the tasks can be preempted and, when they are scheduled to run again, the
> > > > > kernel virtual addresses are restored and are still valid.
> > > > > 
> > > > > In the fuction hyperv_init() of hyperv/hv_init.c, the mapping is used in a
> > > > > single thread and is short live. So, in this case, it's safe to simply use
> > > > > kmap_local_page() to create mapping, and this avoids the wasted cost of
> > > > > kmap() for global synchronization.
> > > > > 
> > > > 
> > > > The kmap call in that function is not performance critical in any way,
> > > > and at this point in the initialization process I don't expect there to
> > > > be any contention, so the downside of kmap is not really a concern here.
> > > > 
> > > > That being said, kmap getting deprecated is a good enough reason to
> > > > switch to kmap_local_page. And I appreciate this well-written,
> > > > well-reasoned commit message.
> > > > 
> > > > I will apply it to hyperv-next later -- I doubt people will object to
> > > > this change, but just in case.
> > > 
> > > Applied to hyperv-next. Thanks.
> > 
> > Sorry Wei, based on Ira and Fabio's comments, do you agree me to send a
> > follow on patch to remove that BUG_ON()? Or send the v2 patch?
> > 
> 
> I just sent a PR to Linus. That PR includes your v1 patch.
> 
> While the code can be improved, BUG_ON that does nothing is harmless.
> You can send a follow-up patch to remove the BUG_ON.

Thanks Wei! I'll do that.

Regards,
Zhao

> 
> Thanks,
> Wei.
> 
> > Thanks,
> > Zhao
