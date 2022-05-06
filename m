Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6F51D61E
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 May 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350709AbiEFLFS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 6 May 2022 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391128AbiEFLFQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 6 May 2022 07:05:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7056266F9C;
        Fri,  6 May 2022 04:01:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437CF1042;
        Fri,  6 May 2022 04:01:33 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.65.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48AB53FA31;
        Fri,  6 May 2022 04:01:31 -0700 (PDT)
Date:   Fri, 6 May 2022 12:01:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
Message-ID: <YnUAB9gkv5SBk4p6@FVFF77S0Q05N>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
 <878rrg13zb.fsf@redhat.com>
 <YnPf3KPBXDNTpQoG@FVFF77S0Q05N.cambridge.arm.com>
 <87y1zgyqut.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1zgyqut.fsf@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 05, 2022 at 04:51:54PM +0200, Vitaly Kuznetsov wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Thu, May 05, 2022 at 03:52:24PM +0200, Vitaly Kuznetsov wrote:
> >> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> >> 
> >> > On 05/05/2022 09:53, Mark Rutland wrote:
> >> >> [...]
> >> >> Looking at those, the cleanup work is all arch-specific. What exactly would we
> >> >> need to do on arm64, and why does it need to happen at that point specifically?
> >> >> On arm64 we don't expect as much paravirtualization as on x86, so it's not
> >> >> clear to me whether we need anything at all.
> >> >> 
> >> >>> Anyway, the idea here was to gather a feedback on how "receptive" arm64
> >> >>> community would be to allow such customization, appreciated your feedback =)
> >> >> 
> >> >> ... and are you trying to do this for Hyper-V or just using that as an example?
> >> >> 
> >> >> I think we're not going to be very receptive without a more concrete example of
> >> >> what you want.
> >> >> 
> >> >> What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?
> >> >> 
> >> >> Thanks
> >> >> Mark.
> >> >
> >> > Hi Mark, my plan would be doing that for Hyper-V - kind of the same
> >> > code, almost. For example, in hv_crash_handler() there is a stimer
> >> > clean-up and the vmbus unload - my understanding is that this same code
> >> > would need to run in arm64. Michael Kelley is CCed, he was discussing
> >> > with me in the panic notifiers thread and may elaborate more on the needs.
> >> >
> >> > But also (not related with my specific plan), I've seen KVM quiesce code
> >> > on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not sure if
> >> > this is necessary for arm64 or if this already executing in some
> >> > abstracted form, I didn't dig deep - probably Vitaly is aware of that,
> >> > hence I've CCed him here.
> >> 
> >> Speaking about the difference between reboot notifiers call chain and
> >> machine_ops.crash_shutdown for KVM/x86, the main difference is that
> >> reboot notifier is called on some CPU while the VM is fully functional,
> >> this way we may e.g. still use IPIs (see kvm_pv_reboot_notify() doing
> >> on_each_cpu()). When we're in a crash situation,
> >> machine_ops.crash_shutdown is called on the CPU which crashed. We can't
> >> count on IPIs still being functional so we do the very basic minimum so
> >> *this* CPU can boot kdump kernel. There's no guarantee other CPUs can
> >> still boot but normally we do kdump with 'nprocs=1'.
> >
> > Sure; IIUC the IPI problem doesn't apply to arm64, though, since that doesn't
> > use a PV mechanism (and practically speaking will either be GICv2 or GICv3).
> >
> 
> This isn't really about PV: when the kernel is crashing, you have no
> idea what's going on on other CPUs, they may be crashing too, locked in
> a tight loop, ... so sending an IPI there to do some work and expecting
> it to report back is dangerous.

Sorry, I misunderstood what you meant about IPIs. I thought you meant that some
enlightened IPI mechanism might be broken, rather than you simply cannot rely
on secondary CPUs to do anything (which is true regardless of whether the
kernel is running under a hypervisor).

So I understand not calling all the regular reboot notifiers in case they do
something like that, but it seems like we should be able to do that with a
panic notifier, since that could *should* follow the principle that you can't
rely on a working IPI.

[...]

> >> There's a crash_kexec_post_notifiers mechanism which can be used instead
> >> but it's disabled by default so using machine_ops.crash_shutdown is
> >> better.
> >
> > Another option is to defer this to the kdump kernel. On arm64 at least, we know
> > if we're in a kdump kernel early on, and can reset some state based upon that.
> >
> > Looking at x86's hyperv_cleanup(), everything relevant to arm64 can be deferred
> > to just before the kdump kernel detects and initializes anything relating to
> > hyperv. So AFAICT we could have hyperv_init() check is_kdump_kernel() prior to
> > the first hypercall, and do the cleanup/reset there.
> 
> In theory yes, it is possible to try sending CHANNELMSG_UNLOAD on kdump
> kernel boot and not upon crash, I don't remember if this approach was
> tried in the past. 
> 
> > Maybe we need more data for the vmbus bits? ... if so it seems that could blow
> > up anyway when the first kernel was tearing down.
> 
> Not sure I understood what you mean... From what I remember, there were
> issues with CHANNELMSG_UNLOAD handling on the Hyper-V host side in the
> past (it was taking *minutes* for the host to reply) but this is
> orthogonal to the fact that we need to do this cleanup so kdump kernel
> is able to connect to Vmbus devices again.

I was thinking that if it was necessary to have some context (e.g. pointers to
buffers which are active) in order to do the teardown, it might be painful to
do that in the kdump kernel itself.

Otherwise, I think doing the teardown in the kdump kernel itself would be
preferable, since there's a greater likelihood that kernel infrastructure will
work relative to doing that in the kernel which crashed, and it gives the kdump
kernel the option to detect when something cannot be torn down, and not use
that feature.

Thanks,
Mark.
 
