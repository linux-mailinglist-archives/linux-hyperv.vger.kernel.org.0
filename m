Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C7147892
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Jan 2020 07:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgAXGcW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Jan 2020 01:32:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33853 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXGcW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Jan 2020 01:32:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id h12so756696qtu.1;
        Thu, 23 Jan 2020 22:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YSOjP9t3Qp0ku6Q8pEO918zSn1Ag2RAEJZlCm/7bInY=;
        b=leGy9UEYzaFConSl04EYhM42RL+3biH/D+bA8TOvdqfEaQTb96WtLj3lUwwEC3JmWM
         tlRdJSke1+218ugsYyGxHxcA46pO23GUHrNyOYocpRpI41btP5gqNyNcNLC/jeMMGwkO
         NANwPhkaJoGDSlGBfyAm2uKmw5l2mvMMFKjK+iFXkqxYR06ILnXuYQPploTOkumVxm+3
         a91ELQC2OaR8aT798cQpRaRNBYnMKrPNM3RZbJPNQgfiw2YrQT+kW2WQFoPvf4lDytT7
         DG7+0uPUtltHL8aOba4g9WaNenSWLtVTfMylpAGLOnYWBZPLpUQq3tisqfhxwAqwQg32
         jImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YSOjP9t3Qp0ku6Q8pEO918zSn1Ag2RAEJZlCm/7bInY=;
        b=oHuWisPiOVmt8jgoxOoZ7bxyuHhbrSXvonhultN/zlI1cLqPZARmQe7I3+riwN3WPP
         ZD/g0YghHh7httFfpXwej/Rseq3ebGU9fXhMv7d1VYTYervj8iWbB/2CuY/5wdJz7T6H
         dP6ZXremC7jyAcIR9QF446cURusbQzT0sP4NoXbujR9MuZEAx9LDGwFooG6CErh3g1Fb
         tRUm9DVulZhuNd9fU1Mv9sNY2RXH1Z3L84/7kYOM7Xz+mtDMzcxUaxZE4dW1tMEaZ9UY
         9Hl/yeP8IivrMuJonI9R9jvEbUFJt5zE8orB9KTN7Jk5wPNr3zI418jWipq5So8+6Sz8
         c6Hw==
X-Gm-Message-State: APjAAAUjgtIoLulAOI4T/ZXNP6H7QkeLmxksMsyXS4jYZyppWoKwg4Fp
        3tYmwzZvjd3IzVNBmvlgh5s=
X-Google-Smtp-Source: APXvYqyxcO1TUjAkBmEG29KiWggF+dRPMNmxgEld562L3Yy/Dxv5iJ+9K+9XBezDRCLSYNckO8FeRA==
X-Received: by 2002:ac8:5555:: with SMTP id o21mr796978qtr.350.1579847541113;
        Thu, 23 Jan 2020 22:32:21 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z6sm2417896qkz.101.2020.01.23.22.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 22:32:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7C2FC21C28;
        Fri, 24 Jan 2020 01:32:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 Jan 2020 01:32:18 -0500
X-ME-Sender: <xms:cY8qXuJ6MmoFxGQbXAkqv2cGIbThPy8yy0e0dg_Bf1qvWxjVUiIX3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpihhnfhhrrgguvggrugdrohhr
    ghenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cY8qXgJ8JkuuIgtY9MuYYKNswDWHFVOKcFwAWns9buJuaB1ckiSTXQ>
    <xmx:cY8qXlUn48io2mb2PVJsfW9bxgsbtyfocObcKIGhYJsNKZBQRhi-Rg>
    <xmx:cY8qXhkbInfA2b0zRwbYtLa9YS2tz78hxn7ZZ2QfTYDQ3KYty0HhqA>
    <xmx:co8qXpTaafBPT_QxTLx7DvvOo53z1AhGiRqFr3tNpAO8aSOdtAraHz_CBNs>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D70F6328005A;
        Fri, 24 Jan 2020 01:32:16 -0500 (EST)
Date:   Fri, 24 Jan 2020 14:32:15 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/6] vDSO support for Hyper-V guest on ARM64
Message-ID: <20200124063215.GA93938@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
 <ef6cb7ba-b448-cfa5-abbb-1d99d1396ce5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6cb7ba-b448-cfa5-abbb-1d99d1396ce5@arm.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Vincenzo,

On Thu, Jan 23, 2020 at 10:48:07AM +0000, Vincenzo Frascino wrote:
> Hi Boqun Feng,
> 
> sorry for the late reply.
> 

That's OK, thanks for your review ;-)

> On 16/12/2019 00:19, Boqun Feng wrote:
> > Hi,
> > 
> > This is the RFC patchset for vDSO support in ARM64 Hyper-V guest. To
> > test it, Michael's ARM64 support patchset:
> > 
> > 	https://lore.kernel.org/linux-arm-kernel/1570129355-16005-1-git-send-email-mikelley@microsoft.com/
> > 
> > is needed.
> > 
> > Similar as x86, Hyper-V on ARM64 use a TSC page for guests to read
> > the virtualized hardware timer, this TSC page is read-only for the
> > guests, so could be used for vDSO data page. And the vDSO (userspace)
> > code could use the same code for timer reading as kernel, since
> > they read the same TSC page.
> > 
> 
> I had a look to your patches and overall, I could not understand why we can't
> use the arch_timer to do the same things you are doing with the one you
> introduced in this series. What confuses me is that KVM works just fine with the
> arch_timer which was designed with virtualization in mind. Why do we need
> another one? Could you please explain?
> 

Please note that the guest VM on Hyper-V for ARM64 doesn't use
arch_timer as the clocksource. See:

	https://lore.kernel.org/linux-arm-kernel/1570129355-16005-7-git-send-email-mikelley@microsoft.com/

,  ACPI_SIG_GTDT is used for setting up Hyper-V synthetic clocksource
and other initialization work.

So just to be clear, your suggestion is

1) Hyper-V guest on ARM64 should use arch_timer as clocksource and vDSO
will just work.

or

2) Even though arch_timer is not used as the clocksource, we can still
use it for vDSO.

?

Regards,
Boqun

> > This patchset therefore extends ARM64's __vsdo_init() to allow multiple
> > data pages and introduces the vclock_mode concept similar to x86 to
> > allow different platforms (bare-metal, Hyper-V, etc.) to switch to
> > different __arch_get_hw_counter() implementations. The rest of this
> > patchset does the necessary setup for Hyper-V guests: mapping tsc page,
> > enabling userspace to read cntvct, etc. to enable vDSO.
> > 
> > This patchset consists of 6 patches:
> > 
> > patch #1 allows hv_get_raw_timer() definition to be overridden for
> > userspace and kernel to share the same hv_read_tsc_page() definition.
> > 
> > patch #2 extends ARM64 to support multiple vDSO data pages.
> > 
> > patch #3 introduces vclock_mode similiar to x86 to allow different
> > __arch_get_hw_counter() implementations for different clocksources.
> > 
> > patch #4 maps Hyper-V TSC page into vDSO data page.
> > 
> > patch #5 allows userspace to read cntvct, so that userspace can
> > efficiently read the clocksource.
> > 
> > patch #6 enables the vDSO for ARM64 Hyper-V guest.
> > 
> > The whole patchset is based on v5.5-rc1 plus Michael's ARM64 support
> > patchset, and I've done a few tests with:
> > 
> > 	https://github.com/nlynch-mentor/vdsotest
> > 
> > Comments and suggestions are welcome!
> > 
> > Regards,
> > Boqun
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Regards,
> Vincenzo


