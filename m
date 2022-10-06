Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC6E5F6976
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Oct 2022 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiJFOTQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Oct 2022 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiJFOSp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Oct 2022 10:18:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3212A730;
        Thu,  6 Oct 2022 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665065801; x=1696601801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SRSJhz55xV1+L4C9oLmiiuZ+SV179r52gAePvbndvXk=;
  b=UjJ4Ckpc5bfuOulutuTUrw7S8ch8oFSiCEDcQHYlUDJp0oqX28fhN017
   7beKBzh0A8B6tBcb0efaOxLpoFhCPqilR1AZvifTdVAAmZTiRW0Lz0uDu
   tE0ar8VNcqAH6+Rtkqbpu87wQXD2ZbPC5/zkAECFN0biHFIl/oIAuPN6d
   FjawZ0c9aY6V48wd1dvGO8/kwrcGh5BpfshLIJ6cT4ibIXCqz9pBTEz8Z
   d49/WuHzEwcvCr/2h9KPfoIX31gipEWI/RPLgXzr81ddVyowMxQGdJ9Lu
   rh0y1f3n0D7njCiJ8xCEOP8AySjPu7I4O0CbkLlSzCwkqrlRQa6hzcs7Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="365393186"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="365393186"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953633327"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="953633327"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2022 07:16:14 -0700
Date:   Thu, 6 Oct 2022 22:21:43 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
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
Message-ID: <Yz7kd9oTs2Zn4YD3@liuzhao-OptiPlex-7080>
References: <20220928095640.626350-1-zhao1.liu@linux.intel.com>
 <YzRVaJA0EyfcVisW@liuwe-devbox-debian-v2>
 <YzqiSK/s/oExlSrb@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzqiSK/s/oExlSrb@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 03, 2022 at 08:50:16AM +0000, Wei Liu wrote:
> Date: Mon, 3 Oct 2022 08:50:16 +0000
> From: Wei Liu <wei.liu@kernel.org>
> Subject: Re: [PATCH] x86/hyperv: Replace kmap() with kmap_local_page()
> 
> On Wed, Sep 28, 2022 at 02:08:40PM +0000, Wei Liu wrote:
> > On Wed, Sep 28, 2022 at 05:56:40PM +0800, Zhao Liu wrote:
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
> > 
> > The kmap call in that function is not performance critical in any way,
> > and at this point in the initialization process I don't expect there to
> > be any contention, so the downside of kmap is not really a concern here.
> > 
> > That being said, kmap getting deprecated is a good enough reason to
> > switch to kmap_local_page. And I appreciate this well-written,
> > well-reasoned commit message.
> > 
> > I will apply it to hyperv-next later -- I doubt people will object to
> > this change, but just in case.
> 
> Applied to hyperv-next. Thanks.

Sorry Wei, based on Ira and Fabio's comments, do you agree me to send a
follow on patch to remove that BUG_ON()? Or send the v2 patch?

Thanks,
Zhao
