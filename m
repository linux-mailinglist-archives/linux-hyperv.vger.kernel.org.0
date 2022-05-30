Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E5A537539
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 May 2022 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiE3F4e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 May 2022 01:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiE3F4d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 May 2022 01:56:33 -0400
Received: from mail.sysgo.com (mail.sysgo.com [159.69.174.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514A214;
        Sun, 29 May 2022 22:56:31 -0700 (PDT)
Date:   Mon, 30 May 2022 07:56:25 +0200
From:   Vit Kabele <vit.kabele@sysgo.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "rudolf.marek@sysgo.com" <rudolf.marek@sysgo.com>,
        "vit@kabele.me" <vit@kabele.me>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: Re: Hyper-V: Question about initializing hypercall interface
Message-ID: <YpRciXMHq8h/sdNu@czspare1-lap.sysgo.cz>
Mail-Followup-To: Vit Kabele <vit.kabele@sysgo.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        "rudolf.marek@sysgo.com" <rudolf.marek@sysgo.com>,
        "vit@kabele.me" <vit@kabele.me>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
References: <YoZB/+EYDDfowVbs@czspare1-lap.sysgo.cz>
 <PH0PR21MB302564FA43E1402AD13CC706D7D49@PH0PR21MB3025.namprd21.prod.outlook.com>
 <PH0PR21MB3025E5A04CBFE8BE3C4C51C4D7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025E5A04CBFE8BE3C4C51C4D7D79@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Tue, May 24, 2022 at 05:43:33AM +0000, Michael Kelley (LINUX) wrote:
> > >
> > > 2/ The Lock bit (bit 1) is ignored in the Linux implementation. If the
> > > hypervisor starts with Lock bit set, the init function allocates the
> > > hv_hypercall_pg and writes the value to the MSR, then:
> > >         a/ If the hypervisor ignores the write, the MSR remains unchanged,
> > >                 but the global variable is already set. Attempt to do a
> > >                 hypercall ends with call to undefined memory, because the code
> > >                 in hv_do_hypercall() checks the global variable against NULL,
> > >                 which will pass.
> > >         b/ The hypervisor injects #GP, in which case the guest crashes.
> > 
> > I would need to confirm with the Hyper-V team, but I think the Lock
> > bit would only be set *after* the guest OS has provided a guest page
> > to be used as the hypercall page.
> > 
> > There is code in Linux to clear the MSR and disable the hypercall
> > page when doing a kexec or kdump.   This is done so that the new
> > kernel can start "fresh" and establish its own hypercall page. That
> > kexec/kdump code does not check the Lock bit, and I'm not sure of
> > the implications if the Lock bit were found to be set in such a case.
> > 
> > I'll check with the Hyper-V team to get clarity on the handling
> > of the Lock bit in the case of trying to disable the hypercall page.
> > 
> > Michael
> 
> The Hyper-V team clarified that the Locked bit is never set by
> the hypervisor.  The bit is there for the guest to set if it chooses.
> The TLFS is indeed not clear on this point.
Thank you for the clarification. I'll update our implementation
accordingly :)

-- 
Best regards,
Vit Kabele
