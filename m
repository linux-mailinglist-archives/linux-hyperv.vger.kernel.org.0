Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6451BFE5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiEEM5G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEM5G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 08:57:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4EEC527C5;
        Thu,  5 May 2022 05:53:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D8F106F;
        Thu,  5 May 2022 05:53:26 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027A53F885;
        Thu,  5 May 2022 05:53:24 -0700 (PDT)
Date:   Thu, 5 May 2022 13:53:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
Message-ID: <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92645c41-96fd-2755-552f-133675721a24@igalia.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 05, 2022 at 09:44:25AM -0300, Guilherme G. Piccoli wrote:
> On 05/05/2022 04:29, Marc Zyngier wrote:
> > [...]
> > Not having any 'machine_ops' indirection was a conscious decision on
> > arm64, if only to avoid the nightmare that 32bit was at a time with
> > every single platform doing their own stuff. Introducing them would
> > not be an improvement, but simply the admission that hypervisors are
> > simply too broken for words. And I don't buy the "but x86 has it!"
> > argument. x86 is a nightmare of PV mess that we can happily ignore,
> > because we don't do PV for core operations at all.
> > 
> > If something has to be done to quiesce the system, it probably is
> > related to the system topology, and must be linked to it. We already
> > have these requirements in order to correctly stop ongoing DMA, shut
> > down IOMMUs, and other similar stuff. What other requirements does
> > your favourite hypervisor have?
> > 
> 
> Thanks Marc and Mark for the details. I agree with most part of it, and
> in fact panic notifiers was the trigger for this discussion (and they
> are in fact used for this purpose to some extent in Hyper-V).
> 
> The idea of having this custom handler from kexec comes from Hyper-V
> discussion - I feel it's better to show the code, so please take a look
> at functions: hv_machine_crash_shutdown()
> [arch/x86/kernel/cpu/mshyperv.c] and the one called from there,
> hv_crash_handler() [drivers/hv/vmbus_drv.c].
> 
> These routines perform last minute clean-ups, right before kdump/kexec
> happens, but *after* the panic notifiers. It seems there is no way to
> accomplish that without architecture involvement or core kexec code
> pollution heh

Looking at those, the cleanup work is all arch-specific. What exactly would we
need to do on arm64, and why does it need to happen at that point specifically?
On arm64 we don't expect as much paravirtualization as on x86, so it's not
clear to me whether we need anything at all.

> Anyway, the idea here was to gather a feedback on how "receptive" arm64
> community would be to allow such customization, appreciated your feedback =)

... and are you trying to do this for Hyper-V or just using that as an example?

I think we're not going to be very receptive without a more concrete example of
what you want.

What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?

Thanks
Mark.
