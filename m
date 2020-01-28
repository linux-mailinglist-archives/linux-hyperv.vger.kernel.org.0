Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFA14AF49
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2020 06:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgA1F6x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jan 2020 00:58:53 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45300 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1F6x (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jan 2020 00:58:53 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so5707945qvu.12;
        Mon, 27 Jan 2020 21:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c0h7rYcoZ0lnrGD/XxyJMfaoFLjp1NniklKakWoray4=;
        b=EglEFcMYyd98Eida6AY+NMphbBS8kJsP0X0ApI59nOpqCn3Nl1Szl1bHShgwoferSf
         1hZVx3Q5C0Q8xxWepxz1a4Ur3vT2JFINgCQ3nQ1oKHHE5tU/OE6EjD35QSPDEZlG/AZL
         rD9qRyuv6VbbVu8EbRHGDQIV4Liim7MuRZU2tIUqbbdRModzVoa1JJDtra+JLMB2sB+5
         HcOtgV2k0cRotMveWVwFwff8QtCBqjdDLfGs4BEQSU+iDmPNgoS2D7MI+BN6wpt7cmsM
         7GNehJKcMqlwv4JIx123sDwt+fpYXTzFR9XNgP9s1g17k0NS+OhUSc50Fhgnw0d/mV2O
         Jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c0h7rYcoZ0lnrGD/XxyJMfaoFLjp1NniklKakWoray4=;
        b=R/uhCHbuzkTL/7gMLF9N+yfDScya1y4BSJR9bxNbXKBdJVqI99ptDKQ6RXCuLU8Thx
         Yn2xd58aBywm2nV1PN6rM5xOyo8c3mzlVzBUZnllufo4AYcymqLMvsWdhLBQpArqtXzN
         7Tf7l54KtUcqk89qmoydf+mXf6OXPlTemR1rEV2+h0WIF6CwbpQFZ56UmtkPN2z0g7I1
         NDQzBMhLZNYH3zwriUJ9EOFS1ibyXWSJn7Hfz33oJLuGx+FQHnTIUNh4BksEf150O5xT
         EK+Q5VzndSuZRKFYg9CFkGBfyhaQtao4nkEOEW1hzRmAz7ll5NzynmsIsMfb5sDEcXUV
         EVuQ==
X-Gm-Message-State: APjAAAU0IEEBe5r/Z0p6JnJspaSVgK09SDwNa/v+2uidyyTNmpJMAmaF
        8f8SLTNg9x82H8ApTh+QKY0=
X-Google-Smtp-Source: APXvYqwzXesaPphmgkW9JDTlcbBg1qU7k/gLMQ7NBODzOVvGB7rzmf2XegdXu1cqnPdt8fItzyH+fA==
X-Received: by 2002:a0c:8149:: with SMTP id 67mr20879339qvc.146.1580191131891;
        Mon, 27 Jan 2020 21:58:51 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id q5sm11696534qkf.14.2020.01.27.21.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 21:58:51 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2FF2B21F57;
        Tue, 28 Jan 2020 00:58:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Jan 2020 00:58:49 -0500
X-ME-Sender: <xms:mM0vXhy1k0rqP3N2FaLwbZiAhUCyVZJmfcSWQVC-2TBHbkndq8QpYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduuddurdejudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:mM0vXuMC-EZ8Dl0ZwftIanMJYfeundzl_Luiphfhne_U03f08rRpLw>
    <xmx:mM0vXm9KXgJkqG7MmJvv0fAat9DncJoq77zQVi1J__F3fQ7hRbkPFw>
    <xmx:mM0vXr75l8HEboSTz3ODhnZ7QNzbh0ZE-hr2kAuh1FRjJZxqJ3gF9g>
    <xmx:mc0vXvc-5hiSbBlHUaXhTqglAifLLqbpCg6U9MDHPnWC4uq-yNKvoHqb1FY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2345306B27D;
        Tue, 28 Jan 2020 00:58:47 -0500 (EST)
Date:   Tue, 28 Jan 2020 13:58:46 +0800
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
Message-ID: <20200128055846.GA83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
 <ef6cb7ba-b448-cfa5-abbb-1d99d1396ce5@arm.com>
 <20200124063215.GA93938@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <4cdf2188-8909-4b90-ca78-92cef520b23d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cdf2188-8909-4b90-ca78-92cef520b23d@arm.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jan 24, 2020 at 10:24:44AM +0000, Vincenzo Frascino wrote:
> Hi Boqun Feng,
> 
> On 24/01/2020 06:32, Boqun Feng wrote:
> > Hi Vincenzo,
> > 
> 
> [...]
> 
> >>
> >> I had a look to your patches and overall, I could not understand why we can't
> >> use the arch_timer to do the same things you are doing with the one you
> >> introduced in this series. What confuses me is that KVM works just fine with the
> >> arch_timer which was designed with virtualization in mind. Why do we need
> >> another one? Could you please explain?
> >>
> > 
> > Please note that the guest VM on Hyper-V for ARM64 doesn't use
> > arch_timer as the clocksource. See:
> > 
> > 	https://lore.kernel.org/linux-arm-kernel/1570129355-16005-7-git-send-email-mikelley@microsoft.com/
> > 
> > ,  ACPI_SIG_GTDT is used for setting up Hyper-V synthetic clocksource
> > and other initialization work.
> >
> 
> I had a look a look at it and my question stands, why do we need another timer
> on arm64?
> 

Sorry for the late response. It's weekend and Chinese New Year, so I got
to spend some time making (and mostly eating) dumplings ;-)

After discussion with Michael, here is some explanation why we need
another timer:

The synthetic clocks that Hyper-V presents in a guest VM were originally
created for the x86 architecture. They provide a level of abstraction
that solves problems like continuity across live migrations where the
hardware clock (i.e., TSC in the case x86) frequency may be different
across the migration. When Hyper-V was brought to ARM64, this
abstraction was maintained to provide consistency across the x86 and
ARM64 architectures, and for both Windows and Linux guest VMs.   The
core Linux code for the Hyper-V clocks (in
drivers/clocksource/hyperv_timer.c) is architecture neutral and works on
both x86 and ARM64. As you can see, this part is done in Michael's
patchset.

Arguably, Hyper-V for ARM64 should have optimized for consistency with
the ARM64 community rather with the existing x86 implementation and
existing guest code in Windows. But at this point, it is what it is,
and the Hyper-V clocks do solve problems like migration that aren’t
addressed in ARM64 until v8.4 of the architecture with the addition of
the counter hardware scaling feature. Hyper-V doesn’t currently map the
ARM arch timer interrupts into guest VMs, so we need to use the existing
Hyper-V clocks and the common code that already exists.


Does the above answer your question?

Regards,
Boqun

> > So just to be clear, your suggestion is
> > 
> > 1) Hyper-V guest on ARM64 should use arch_timer as clocksource and vDSO
> > will just work.
> > 
> > or
> > 
> > 2) Even though arch_timer is not used as the clocksource, we can still
> > use it for vDSO.
> > 
> > ?
> > 
> 
> Option #1 would be the preferred solution, unless there is a good reason against.
> 
> > Regards,
> > Boqun
> > 
> 
> -- 
> Regards,
> Vincenzo


