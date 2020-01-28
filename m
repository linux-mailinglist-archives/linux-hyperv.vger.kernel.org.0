Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE214B418
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2020 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgA1MVB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jan 2020 07:21:01 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:52158 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgA1MVB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jan 2020 07:21:01 -0500
X-Greylist: delayed 1943 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 07:21:00 EST
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@misterjones.org>)
        id 1iwPM8-001o2H-Sm; Tue, 28 Jan 2020 11:48:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 28 Jan 2020 11:48:32 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        xen-devel@lists.xenproject.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/6] vDSO support for Hyper-V guest on ARM64
In-Reply-To: <20200128055846.GA83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
 <ef6cb7ba-b448-cfa5-abbb-1d99d1396ce5@arm.com>
 <20200124063215.GA93938@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <4cdf2188-8909-4b90-ca78-92cef520b23d@arm.com>
 <20200128055846.GA83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Message-ID: <58c453d060066ebaed24cd13e22de1c5@misterjones.org>
X-Sender: maz@misterjones.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: boqun.feng@gmail.com, vincenzo.frascino@arm.com, sashal@kernel.org, linux-hyperv@vger.kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com, catalin.marinas@arm.com, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, mikelley@microsoft.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, kys@microsoft.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2020-01-28 05:58, Boqun Feng wrote:
> On Fri, Jan 24, 2020 at 10:24:44AM +0000, Vincenzo Frascino wrote:
>> Hi Boqun Feng,
>> 
>> On 24/01/2020 06:32, Boqun Feng wrote:
>> > Hi Vincenzo,
>> >
>> 
>> [...]
>> 
>> >>
>> >> I had a look to your patches and overall, I could not understand why we can't
>> >> use the arch_timer to do the same things you are doing with the one you
>> >> introduced in this series. What confuses me is that KVM works just fine with the
>> >> arch_timer which was designed with virtualization in mind. Why do we need
>> >> another one? Could you please explain?
>> >>
>> >
>> > Please note that the guest VM on Hyper-V for ARM64 doesn't use
>> > arch_timer as the clocksource. See:
>> >
>> > 	https://lore.kernel.org/linux-arm-kernel/1570129355-16005-7-git-send-email-mikelley@microsoft.com/
>> >
>> > ,  ACPI_SIG_GTDT is used for setting up Hyper-V synthetic clocksource
>> > and other initialization work.
>> >
>> 
>> I had a look a look at it and my question stands, why do we need 
>> another timer
>> on arm64?
>> 
> 
> Sorry for the late response. It's weekend and Chinese New Year, so I 
> got
> to spend some time making (and mostly eating) dumplings ;-)

And you haven't been sharing! ;-)

> After discussion with Michael, here is some explanation why we need
> another timer:
> 
> The synthetic clocks that Hyper-V presents in a guest VM were 
> originally
> created for the x86 architecture. They provide a level of abstraction
> that solves problems like continuity across live migrations where the
> hardware clock (i.e., TSC in the case x86) frequency may be different
> across the migration. When Hyper-V was brought to ARM64, this
> abstraction was maintained to provide consistency across the x86 and
> ARM64 architectures, and for both Windows and Linux guest VMs.   The
> core Linux code for the Hyper-V clocks (in
> drivers/clocksource/hyperv_timer.c) is architecture neutral and works 
> on
> both x86 and ARM64. As you can see, this part is done in Michael's
> patchset.
> 
> Arguably, Hyper-V for ARM64 should have optimized for consistency with
> the ARM64 community rather with the existing x86 implementation and
> existing guest code in Windows. But at this point, it is what it is,
> and the Hyper-V clocks do solve problems like migration that aren’t
> addressed in ARM64 until v8.4 of the architecture with the addition of
> the counter hardware scaling feature. Hyper-V doesn’t currently map the
> ARM arch timer interrupts into guest VMs, so we need to use the 
> existing
> Hyper-V clocks and the common code that already exists.

The migration thing is a bit of a red herring. Do you really anticipate
VM migration across systems that have their timers running at different
frequencies *today*? And even if you did, there are ways to deal with it
with the arch timers (patches to that effect were posted on the list, 
and
there was even a bit of an ARM spec for it).

I find it odd to try and make arm64 "just another x86", while the 
architecture
gives you most of what you need already. I guess I'm tainted.

Thanks,

         M.
-- 
Who you jivin' with that Cosmik Debris?
