Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6551BDC1
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 May 2022 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiEELOO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356774AbiEELOG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 07:14:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02966140AD;
        Thu,  5 May 2022 04:10:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8A54106F;
        Thu,  5 May 2022 04:10:25 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.29.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6233FA27;
        Thu,  5 May 2022 04:10:24 -0700 (PDT)
Date:   Thu, 5 May 2022 12:10:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        will Deacon <will@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, broonie@kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: Should arm64 have a custom crash shutdown handler?
Message-ID: <YnOwnfV3uAzp6cwG@FVFF77S0Q05N.cambridge.arm.com>
References: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 04, 2022 at 05:00:42PM -0300, Guilherme G. Piccoli wrote:
> Hi folks, this email is to ask feedback / trigger a discussion about the
> concept of custom crash shutdown handler, that is "missing" in arm64
> while it's present in many architectures [mips, powerpc, x86, sh (!)].
> 
> Currently, when we kexec in arm64, the function machine_crash_shutdown()
> is called as a handler to disable CPUs and (potentially) do extra
> quiesce work. In the aforementioned architectures, there's a way to
> override this function, if for example an hypervisor wish to have its
> guests running their own custom shutdown machinery.

What exactly do you need to do in this custom shutdown machinery?

The general expectation for arm64 is that any hypervisor can implement PSCI,
and as long as you have that, CPUs (and the VM as a whole) can be shutdown in a
standard way.

I suspect what you're actually after is a mechanism to notify the hypervisor
when the guest crashes, rather than changing the way the shutdown itself
occurs? If so, we already have panic notifiers, and QEMU has a "pvpanic"
device using that. See drivers/misc/pvpanic/.

Thanks,
Mark.

> For powerpc/mips, the approach is a generic shutdown function that might
> call other handler-registered functions, whereas x86/sh relies in the
> "machine_ops" structure, having the crash shutdown as a callback in such
> struct.
> 
> The usage for that is very broad, but heavy users are hypervisors like
> Hyper-V / KVM (CCed Michael and Vitaly here for this reason). The
> discussion about the need for that in arm64 is from another thread [0],
> so before start implementing/playing with that, I'd like to ask ARM64
> community if there is any feedback and in case it's positive, what is
> the best implementation strategy (struct callback vs. handler call), etc.
> 
> I've CCed ARM64/ARM32 maintainers plus extra people I found as really
> involved with ARM architecture - sorry if I added people I shouldn't or
> if I forgot somebody (though the ARM mailing-list is CC).
> Cheers,
> 
> 
> Guilherme
> 
> 
> [0]
> https://lore.kernel.org/lkml/2787b476-6366-1c83-db80-0393da417497@igalia.com/
> See the proposed option (b)
