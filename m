Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31B115BA03
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 08:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgBMH03 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Feb 2020 02:26:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45917 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBMH03 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Feb 2020 02:26:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so4722534qko.12;
        Wed, 12 Feb 2020 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7afNFB8me/fcXvHEJ/JbjcmGZzZNdhFYzAAETu8NEbc=;
        b=CJJbyFaUT0wShMPCnHyAerAv1p/FLh/75t1o2pTxajbxTRaLR/fB/1fy2Kfe3e24zz
         qwa1XZYuPJiMeczcb1yZ3QDIo7VBJbZzuqrGM4PoXkHOUPoN0AvdpcQL1RZ8dGlonknC
         lkh0a1x/IyrJwZKWQXlLwB8XLhev81qAJSjMpO8uR087bOY+o2PsZ0UTT/H/SfTjv6Pq
         6DyiU7Hymwm6Q8NyFsjm3oIaVAj1U4Q6KPLHHZtwaOcjrD7hBUM5K2SB4pe9NOeDSa8K
         LgdRtS84sYIq8CbUZTNB6oAkiRParteG3adCzz24m8oOEnG4MA/Err8kkb0pg3SFRJTo
         iPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7afNFB8me/fcXvHEJ/JbjcmGZzZNdhFYzAAETu8NEbc=;
        b=Gfn3yNwG25ZFfK/qakolABme1DLpMZi/C89UVJCTbsYU46FEtzP6h4SNl6KGkkYTLE
         L5vhqUOD6/I9foehT+d7FAqQ3IaVdxNcDp+G4EzB7R99agGqeiSuYlsFZSzR+Lj34yW0
         msLxPFxYPTFo85VsClHGF1d+Bqxcv8ma02eEdWx2JZdobheyowYjbg8+TyyzSn30NPu+
         0BDdDrXpmlQSwvhVX/WctBT+DNyCGbCTGsPAinErkAhz2ciVLGqJ6TB1V15inn3fZyQ3
         rN6r2axnFVDV3tptXUTZqP1PwVbwuZfzAHuMo+ag++U9QzEmDeO++kwnqsbAZM1QyZuu
         omrA==
X-Gm-Message-State: APjAAAUiybmpYryzozAtQW0Yu9a9ULsxDPCr46D+5+Hw4GZ++Bsubjmi
        Zj/S0HAkHl+rh5KIT+uzAlM=
X-Google-Smtp-Source: APXvYqzKtb8FqZbfdgDJdCz94YM8zhQ+svCthzX4siWSSbnQ8pwrnAg7UAabGZKVZzYg5U1a7guSBw==
X-Received: by 2002:a37:488f:: with SMTP id v137mr13898536qka.16.1581578787579;
        Wed, 12 Feb 2020 23:26:27 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v10sm1066872qtj.26.2020.02.12.23.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:26:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B8CC221D25;
        Thu, 13 Feb 2020 02:26:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 02:26:25 -0500
X-ME-Sender: <xms:IPpEXu5yoFeaNHDeD6vxA516f4o5OC7rMP0rl1YSiCHLEltn_PDIgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IPpEXrqIW7G12ewNcbsl7DoNSfr9NoUy_5VtguMF5cLWwYCdJ10SXA>
    <xmx:IPpEXmVfkP2zdp0wyx4uWphaXE1ZF5M3TxhxISS2elWiqW_3TA-Fsg>
    <xmx:IPpEXjTDQGIjl_tTaPdZpaGNJ2ZBRXbeQ6G36gE12OcwvXQbKB-Wqw>
    <xmx:IfpEXlIbcoJqnAeJmRBvIUOUkrzj0uslNnSJvcPMdTwHCHT9P804EXXsc6Q>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 773123280059;
        Thu, 13 Feb 2020 02:26:24 -0500 (EST)
Date:   Thu, 13 Feb 2020 15:26:23 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v3 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Message-ID: <20200213072623.GE69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-3-boqun.feng@gmail.com>
 <HK0P153MB01481A125819FC7660E067AFBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB01481A125819FC7660E067AFBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 13, 2020 at 04:17:34AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> > Sent: Sunday, February 9, 2020 7:40 PM
> > 
> > Currently, retarget_msi_interrupt and other structures it relys on are
> > defined in pci-hyperv.c. However, those structures are actually defined
> > in Hypervisor Top-Level Functional Specification [1] and may be
> > different in sizes of fields or layout from architecture to
> > architecture. Let's move those definitions into x86's tlfs header file
> > to support virtual PCI on non-x86 architectures in the future. Note that
> > "__packed" attribute is added to these structures during the movement
> > for the same reason as we use the attribute for other TLFS structures in
> > the header file: make sure the structures meet the specification and
> > avoid anything unexpected from the compilers.
> > 
> > Additionally, rename struct retarget_msi_interrupt to
> > hv_retarget_msi_interrupt for the consistent naming convention, also
> > mirroring the name in TLFS.
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> > b/arch/x86/include/asm/hyperv-tlfs.h
> > +
> > +struct hv_device_interrupt_target {
> > +	u32 vector;
> > +	u32 flags;
> > +	union {
> > +		u64 vp_mask;
> > +		struct hv_vpset vp_set;
> > +	};
> > +} __packed;
> > +
> > +/* HvRetargetDeviceInterrupt hypercall */
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 

Thanks!

> Just a small thing: would it be slightly better if we change the name 
> in the above line to HVCALL_RETARGET_INTERRUPT ? 
> 
> HVCALL_RETARGET_INTERRUPT is a define, so it may help to locate the
> actual value of the define here. And, HVCALL_RETARGET_INTERRUPT is
> used several times in the patchset so IMO we'd better always use
> the same name.

This might be a good suggestion, however, throughout the TLFS header,
camel case is more commonly used for referencing hypercall. For example:

	/* HvCallSendSyntheticClusterIpi hypercall */

So I think it's better to let it as it is for this patch, and later on,
if we reach a consensus, we can convert the names all together.

Thoughts?

Regards,
Boqun
