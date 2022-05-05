Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56051C057
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiEENTM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376729AbiEENS4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 09:18:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67BF12BED;
        Thu,  5 May 2022 06:15:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 395E1106F;
        Thu,  5 May 2022 06:15:16 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89EEA3F885;
        Thu,  5 May 2022 06:15:14 -0700 (PDT)
Date:   Thu, 5 May 2022 14:15:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
Message-ID: <YnPN33qN7oVQa4fA@FVFF77S0Q05N.cambridge.arm.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
 <874k24igjf.wl-maz@kernel.org>
 <92645c41-96fd-2755-552f-133675721a24@igalia.com>
 <YnPIwjLMDXgII1vf@FVFF77S0Q05N.cambridge.arm.com>
 <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bee47db-f771-b502-82a3-d6fac388aa89@igalia.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, May 05, 2022 at 10:05:18AM -0300, Guilherme G. Piccoli wrote:
> On 05/05/2022 09:53, Mark Rutland wrote:
> > [...]
> > Looking at those, the cleanup work is all arch-specific. What exactly would we
> > need to do on arm64, and why does it need to happen at that point specifically?
> > On arm64 we don't expect as much paravirtualization as on x86, so it's not
> > clear to me whether we need anything at all.
> > 
> >> Anyway, the idea here was to gather a feedback on how "receptive" arm64
> >> community would be to allow such customization, appreciated your feedback =)
> > 
> > ... and are you trying to do this for Hyper-V or just using that as an example?
> > 
> > I think we're not going to be very receptive without a more concrete example of
> > what you want.
> > 
> > What exactly do *you* need, and *why*? Is that for Hyper-V or another hypervisor?
> > 
> > Thanks
> > Mark.
> 
> Hi Mark, my plan would be doing that for Hyper-V - kind of the same
> code, almost. For example, in hv_crash_handler() there is a stimer
> clean-up and the vmbus unload - my understanding is that this same code
> would need to run in arm64. Michael Kelley is CCed, he was discussing
> with me in the panic notifiers thread and may elaborate more on the needs.

The key problem here is that there's no justification as to why this cannot be
done in a panic notifier (or a regular reboot notifer for the plain shutdown
or kexec case).

I undertstand that x86 does one thing, and what Marc and I have said is that
fact alone doesn't justify doing the same.

We need to know:

a) What specifically you want to do on arm64

b) Why you think this cannot be done using the existing mechanisms (e.g.
   notifiers).

Without a strong justification, we wouldn't add such hooks to arm64.

Could you start by trying to use the notifiers, and if you encounter a problem,
*then* we consider an alternative? That should mean we have a concrete reason.

Thanks,
Mark.

> But also (not related with my specific plan), I've seen KVM quiesce code
> on x86 as well [see kvm_crash_shutdown() on arch/x86] , I'm not sure if
> this is necessary for arm64 or if this already executing in some
> abstracted form, I didn't dig deep - probably Vitaly is aware of that,
> hence I've CCed him here.
> 
> Cheers,
> 
> 
> Guilherme
