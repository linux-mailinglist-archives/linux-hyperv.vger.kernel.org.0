Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D52617011
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 22:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKBVtN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKBVtM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 17:49:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D5CE003;
        Wed,  2 Nov 2022 14:49:11 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 28CA820C28B1;
        Wed,  2 Nov 2022 14:49:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 28CA820C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667425751;
        bh=vFhP36XRDpEGRi+gltuc+VdLwPELF2AWSpHAKsqU7BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dg3AT9MQIGb+zxcA2grXl9uAU32Dt4kQkvv3KrSf7URA8+gLAippcslCGe9bYefnw
         QZyTFKRYQldBbqQfkV7WbffeyTg9eiFxfqFaWJ9DzDUNYP/0yBbbavCT8bE9YI1Fhe
         E2Stu25ZbaT7SKeyZwwp8xtuMYUOy9m+on4LAM0A=
Date:   Wed, 2 Nov 2022 21:49:06 +0000
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Message-ID: <Y2Ll0pKIBREFg4ki@skinsburskii-cloud-desktop.rtlyha0sdvfehj3ppc5ptuaytc.xx.internal.cloudapp.net>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <BYAPR21MB1688C426F44E40E1415DCD21D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLzYpFHUzYmvP_qhTMkaYhjRsgW3eaQfMYYpGiE2AHzjLw@mail.gmail.com>
 <BYAPR21MB1688D5D33AC0D7D88AF6FD7BD7399@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CA+DrgLzLATDPvO-Ngi5O5kMx-zqBVYtx+GmM=8E5y3P1X0fMsw@mail.gmail.com>
 <BYAPR21MB1688B5A6005EAA6980E07DA2D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR21MB1688B5A6005EAA6980E07DA2D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 02, 2022 at 09:27:07PM +0000, Michael Kelley (LINUX) wrote:
> From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>  Sent: Wednesday, November 2, 2022 1:58 PM
> 
> >  ср, 2 нояб. 2022 г. в 13:30, Michael Kelley (LINUX) <mailto:mikelley@microsoft.com>:
> > From: Stanislav Kinsburskiy <mailto:stanislav.kinsburskiy@gmail.com>  Sent: Wednesday, November 2, 2022 12:26 PM
> >
> > > > It makes sense to have the tsc_page global variable so that we can
> > > > handle the root partition and guest partition cases with common code,
> > > > even though the TSC page memory originates differently in the two cases.
> > > >
> > > > But do we also need a tsc_pfn global variable and getter function?  When
> > > > the PFN is needed, conversion from the tsc_page virtual address to the PFN
> > > > isn't hard, and such a conversion is needed in only a couple of places.  To me,
> > > > it's simpler to keep a single global variable and getter function (i.e.,
> > > > hv_get_tsc_page), and do the conversions where needed.   Adding tsc_pfn
> > > > and the getter function introduces a fair amount of code churn for not much
> > > > benefit.  It's a judgment call, but that's my $.02.
> > >
> > > As I replied to Anirudh , AFAIK virt_to_phys doesn't work for remapped pages.
> > > Another option would be to read the MSR each time PFN has to be returned to
> > > the vvar mapping function (i.e. on every fork), which introduces unnecessary
> > > performance regression..
> > > Another modification would be to make pfn a static variable and initialize it
> > > once in hv_get_tsc_pfn() on first access. But I like this implementation less.
> 
> > > Valid point about virt_to_phys().  But virt_to_hvpfn() does the right thing.  It
> > > distinguishes between kernel addresses in the main linear mapping and
> > > vmalloc() addresses, which is what you get from memremap().  But I haven't
> > > looked through all the places virt_to_hvpfn() would be needed to make sure
> > > it's safe to use.
> >
> > Yeah, I guess virt_to_hvpfn() will do.
> > But I'm not sure it the current code should be reworked to use it: it would save only a
> > few lines of code, but will remove the explicit distinguishment between root and guest
> > partitions, currently reflected in the code.
> > Please, let me know if you insist on reworking the series to use virt_to_hvpfn().
> 
> Your call.  I'm OK with leaving things "as is" due to the additional complexity
> of dealing with the vmalloc() address that comes from memremap().
>  

I'll keep as it is then. Thanks.

> > > However, thinking about virt_to_hvpfn(), there's a problem with Anirudh's
> > > earlier patch set that started using __phys_to_pfn().  That won't work correctly
> > > if the guest page size is not 4K because it will return a PFN based on the guest
> > > page size, not based on Hyper-V's expectation that the PFN is based on a
> > > 4K page size.  So that needs to be fixed either way.
> 
> > Could you elaborate more on the problem? 
>  
> The key is to recognize that PFNs are inherently interpreted in the context
> of the page size.  Consider Guest Physical Address (GPA)  0x12340000.
> If the page size is 4096, the PFN is 0x12340.  If the page size is 64K, the PFN
> is 0x1234.  Hyper-V is always expecting PFNs in the context of a page size
> of 4096.  But Linux guests running on Hyper-V on ARM64 could have a
> guest page size of 64K, even though Hyper-V itself is using a page size
> of 4096.  For my example, in an ARM64 VM with 64K page size,
> __phys_to_pfn(0x12340000) would return 0x1234.  If that value is
> stored in the PFN field of the MSR, Hyper-V will think the GPA is
> 0x1234000 when it should be 0x12340000.
> 

Thank you for the verbose explanation.

Stas

> Michael
>  
