Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099546E29CF
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Apr 2023 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNSHq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Apr 2023 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSHp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Apr 2023 14:07:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 020DE83CB;
        Fri, 14 Apr 2023 11:07:43 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 202C42179263;
        Fri, 14 Apr 2023 11:07:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 202C42179263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681495663;
        bh=vrTl5Ep5devbVecjQ6jAI5gZaBXZaMXlbw5ZKByZUZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLR94xfw4mfXwonzEA8XTEXGARFL/FomL1UtMFLtChA6mRBwBbI7M2wqo5Hn35QmD
         qgdYXzkWrT/+m9wWm/fA6EZoFvX6zxOuenxKDip0xvOzdZjW+D3T7KlQvRITLnZecY
         NHBohp/XeamzyyXQ/vSteUenpSDBNAWyudrT5nL4=
Date:   Wed, 12 Apr 2023 13:31:38 -0700
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Expose an helper to map PCI interrupts
Message-ID: <20230412203138.GA1782@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
 <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
 <87o7nrzy9e.ffs@tglx>
 <20230412161951.GA894@skinsburskii.localdomain>
 <20230412163616.GA1535@skinsburskii.localdomain>
 <878reuzzuz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878reuzzuz.ffs@tglx>
X-Spam-Status: No, score=-18.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 14, 2023 at 09:28:52AM +0200, Thomas Gleixner wrote:
> Stanislav!
> 
> On Wed, Apr 12 2023 at 09:36, Stanislav Kinsburskii wrote:
> > On Wed, Apr 12, 2023 at 09:19:51AM -0700, Stanislav Kinsburskii wrote:
> >> > > +	affinity = irq_data_get_effective_affinity_mask(data);
> >> > > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> >> > 
> >> > The effective affinity mask of MSI interrupts consists only of online
> >> > CPUs, to be accurate: it has exactly one online CPU set.
> >> > 
> >> > But even if it would have only offline CPUs then the result would be:
> >> > 
> >> >     cpu = nr_cpu_ids
> >> > 
> >> > which is definitely invalid. While a disabled vector targeted to an
> >> > offline CPU is not necessarily invalid.
> >
> > Although this patch only tosses the code and doens't make any functional
> > changes, I guess if the fix for the used cpu id is required, it has to
> > be in a separated patch.
> 
> Correct, but if the interrupt _is_ masked at the MSI level then the
> hypervisor must not deliver an interrupt at all.
> 
> The point is that it is valid to target a masked MSI entry to an offline
> CPU under the assumption that the hardware/emulation respects the
> masking. Whether that's a good idea or not is a different question.
> 
> The kernel as of today does not do that. It targets unused but
> configured MSI[-x] entries towards MANAGED_IRQ_SHUTDOWN_VECTOR on CPU0
> for various reasons, one of them being paranoia.
> 
> But in principle there is nothing wrong with that and it should either
> succeed or being rejected at the software level and not expose a
> completely invalid CPU number to the hypercall in the first place.
> 
> So if you want to be defensive, then keep the _and(), but then check the
> result for being valid and emit something useful like a pr_warn_once()
> instead of blindly handing the invalid result to the hypercall and then
> have that reject it with some undecipherable error code.
> 
> Actually it would not necessarily reach the hypercall because before
> that it dereferences cpumask_of(nr_cpu_ids) here:
> 
> 	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set),	cpumask_of(cpu));
> 
> and explode with a kernel pagefault. If not it will read some random
> adjacent data and try to create a vp_set from it. Neither of that is
> anywhere close to correct.
> 

Thank you Thomas.
I sent a patch to address the problmes you highlighted:

"x86/hyperv: Fix IRQ effective cpu discovery for the interrupts unmasking"

I'll update this series after that patch is merged.

Thanks,
Stanislav

> Thanks,
> 
>         tglx
