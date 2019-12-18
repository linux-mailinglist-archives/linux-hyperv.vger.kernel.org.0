Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E99123F3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2019 06:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfLRFrj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Dec 2019 00:47:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35544 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfLRFri (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Dec 2019 00:47:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so986159qka.2;
        Tue, 17 Dec 2019 21:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdMMSS5mGXhXxSzn8vN5OSqGco+TdXWURJZsejhpNlU=;
        b=IbnAbj6RtNE27gTD/82fE5rTu6luXBFeErBAampq/mDtF+82hybj1EYlIJDNleRtWb
         Tc4xby6WNKEe1VSWAzvQ40QRBdEwkpaoip/jXm9+Y+0/Tdp34uz38tiuwZMmV3ZpCX+7
         bO+zDh5JQqe502cQCnq8O8hMlBmXcXFxstpyjlB6KqjnSJs6eyObBs9hyl+/FL3Y1wkq
         k9CEZwWyoAAnbiVWo5OLtx6PDUm03DNKDOhovQncKCIVwQztzjY5dDfDcORDypYn1Ciq
         IFdm/4n/bUxaAX34UFIFDcwT7AykhHSdACqkLGLZmGzdHLujESdTVCUvUhxVm2CULKmL
         Uzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdMMSS5mGXhXxSzn8vN5OSqGco+TdXWURJZsejhpNlU=;
        b=PHAaRmQ+kvY3lUAHSGkf3gM9bzsmYyVT0MzB1ncsSksX/G8VyB5MqKVAcL6GkiiHvq
         NHM577f6hjKmBqwRhfzwSf+k/MvOhWVVTB4nb2muvnsXvNbYUo6imjQ5t/D4ubSlkCVp
         YdCeW2MKvfh0LSDY7cbQihkbGOngo1E83a5c2dcZeRF5TT3aQoTS/4CqkqWrItd8LqMP
         +oxMmiuoVVP4Z0wkMdNcyLB1rBKY+GPrzUAC36GR9NVdeu8qyE3rZtvpHrp3oLWYGNWN
         MrvGzVvC4YWrdi63SeFWn/wk1BKWJ+qRzjJrkutXrpmi9GypIsnrWLFWjPrEqxoBkrB0
         UNBA==
X-Gm-Message-State: APjAAAVFj+s0/i7JgNKpwMi71FR5isFGEzpbjdQzUX+rWBkYrj7Y0CBk
        w2VeSgDWKTvdRx+n0ziozU8=
X-Google-Smtp-Source: APXvYqxaNz0RO1lOZKINUdqFpRia863ytJsrYewYWjT74VbIG5he6WOrbsQMH4RbQA7++XwYkL1Icg==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr790211qkc.288.1576648057742;
        Tue, 17 Dec 2019 21:47:37 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t198sm354933qke.6.2019.12.17.21.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:47:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 751CC22223;
        Wed, 18 Dec 2019 00:47:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 18 Dec 2019 00:47:35 -0500
X-ME-Sender: <xms:dr35XX1gdcqGAIqLT51JyHjdGnzLF1l4WLjUXPweExjBpT4Ci871Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephe
    dvrdduheehrdduuddurdejudenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dr35XQd4G4lVVfUNeZx2swRweY951aczqjlN0OH0Ok8mYQMGgCrtzQ>
    <xmx:dr35XeAEw3MdzyfTpxLn4CyJvUYuy7W7U_PYH1XUlribC_owMFWxJg>
    <xmx:dr35XX93UVrpEnOnntHX8srZBT8vFtWAMQ0ErbFr4ymsIt3qA4Z23Q>
    <xmx:d735XRpK3pJiUKvIRHERfgQkVY3faW59Xm1i2MFCfRkSRilXSIUcNFuGAOc>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06F2B8005A;
        Wed, 18 Dec 2019 00:47:33 -0500 (EST)
Date:   Wed, 18 Dec 2019 13:47:32 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 6/6] arm64: hyperv: Enable vDSO
Message-ID: <20191218054732.GK97412@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
 <20191216001922.23008-7-boqun.feng@gmail.com>
 <87y2vb82lz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2vb82lz.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 17, 2019 at 03:10:16PM +0100, Vitaly Kuznetsov wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> 
> > Similar to x86, add a new vclock_mode VCLOCK_HVCLOCK, and reuse the
> > hv_read_tsc_page() for userspace to read tsc page clocksource.
> >
> > Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> > ---
> >  arch/arm64/include/asm/clocksource.h       |  3 ++-
> >  arch/arm64/include/asm/mshyperv.h          |  2 +-
> >  arch/arm64/include/asm/vdso/gettimeofday.h | 19 +++++++++++++++++++
> >  3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/clocksource.h b/arch/arm64/include/asm/clocksource.h
> > index fbe80057468c..c6acd45fe748 100644
> > --- a/arch/arm64/include/asm/clocksource.h
> > +++ b/arch/arm64/include/asm/clocksource.h
> > @@ -4,7 +4,8 @@
> >  
> >  #define VCLOCK_NONE	0	/* No vDSO clock available.		*/
> >  #define VCLOCK_CNTVCT	1	/* vDSO should use cntvcnt		*/
> > -#define VCLOCK_MAX	1
> > +#define VCLOCK_HVCLOCK	2	/* vDSO should use vread_hvclock()	*/
> > +#define VCLOCK_MAX	2
> >  
> >  struct arch_clocksource_data {
> >  	int vclock_mode;
> > diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> > index 0afb00e3501d..7c85dd816dca 100644
> > --- a/arch/arm64/include/asm/mshyperv.h
> > +++ b/arch/arm64/include/asm/mshyperv.h
> > @@ -90,7 +90,7 @@ extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
> >  #define hv_set_reference_tsc(val) \
> >  		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
> >  #define hv_set_clocksource_vdso(val) \
> > -		((val).archdata.vclock_mode = VCLOCK_NONE)
> > +		((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
> >  
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  #define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
> > diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> > index e6e3fe0488c7..7e689b903f4d 100644
> > --- a/arch/arm64/include/asm/vdso/gettimeofday.h
> > +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> > @@ -67,6 +67,20 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_HYPERV_TIMER
> > +/* This will override the default hv_get_raw_timer() */
> > +#define hv_get_raw_timer() __arch_counter_get_cntvct()
> > +#include <clocksource/hyperv_timer.h>
> > +
> > +extern struct ms_hyperv_tsc_page
> > +_hvclock_page __attribute__((visibility("hidden")));
> > +
> > +static u64 vread_hvclock(void)
> > +{
> > +	return hv_read_tsc_page(&_hvclock_page);
> > +}
> > +#endif
> 
> The function is almost the same on x86 (&_hvclock_page ->
> &hvclock_page), would it maybe make sense to move this to arch neutral
> clocksource/hyperv_timer.h?
> 

I'm not sure whether the underscore matters in the vDSO data symbol, so
I follow the architectural name convention. If the leading underscore
doesn't have special purpose I'm happy to move this to arch neutral
header file.

> > +
> >  static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
> >  {
> >  	u64 res;
> > @@ -78,6 +92,11 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
> >  	if (clock_mode == VCLOCK_NONE)
> >  		return __VDSO_USE_SYSCALL;
> >  
> > +#ifdef CONFIG_HYPERV_TIMER
> > +	if (likely(clock_mode == VCLOCK_HVCLOCK))
> > +		return vread_hvclock();
> 
> I'm not sure likely() is justified here: it'll make ALL builds which
> enable CONFIG_HYPERV_TIMER (e.g. distro kernels) to prefer
> VCLOCK_HVCLOCK, even if the kernel is not running on Hyper-V.
> 

Make sense. Thanks for pointing this out! I will change it in the next
version.

Regards,
Boqun

> > +#endif
> > +
> >  	/*
> >  	 * This isb() is required to prevent that the counter value
> >  	 * is speculated.
> 
> -- 
> Vitaly
> 
