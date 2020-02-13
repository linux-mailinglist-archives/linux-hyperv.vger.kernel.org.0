Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04B15B9ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 08:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgBMHOO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Feb 2020 02:14:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46470 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBMHOO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Feb 2020 02:14:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so4209290qkh.13;
        Wed, 12 Feb 2020 23:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FKpPI/b9lVsTM4j397MEI62s5Kvlc206miHaN/mCgkQ=;
        b=NE3iF0+ustwmNGNrLan0Nrmi4WwAaEgMXeNp8Rl2+TAfAc36KQMZ9rW0VPaBGwk7Zm
         /ud1llTS7mugGpdphgEflU3VQrT5Zb5ntpbcSmiajefEdu2B7W/eVzYDLzVz7pxH0S4P
         BikNicapv2YTXflvyKA7N2rxvIBnuTsU/M2/zwrPNQXKx+lKjjqpahofhK3k5KtvBvF7
         VIXkuAgJrtXlby3RcWIwMHdzjJlnnfKjYfN8oVtilNBWSFvE2UOOvH1g0Ug27Xr6XWEj
         ocl/uEQhVumnXQ/pogIkJwajIXKl0zYpXVhwAchZzVOQ13qu5JMTHG0KnZRsGDT8O96v
         OdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FKpPI/b9lVsTM4j397MEI62s5Kvlc206miHaN/mCgkQ=;
        b=H8u4jQLKZKXuIVu4REyehJ9UFdz6ICBF4Zj62K7acUSdHwG/H26xj8C9SdAoWr4bHY
         M7uQTEfbgQyuDI3sTYzWc+/DFjT2y8Nwt/JJClDSeT6ZGuyMZyJWb7GI+124vvDeQgrG
         V925ke8dgGDo2w7esTCkxYm7skOTl3bYktX3oXNkW5WUCCFdKQ5v1cp5jNsjnjR2Ie3e
         VrGqlk8z3RSgh6/fa4ZPItG66fGIudXPZzr26J21WGMXFa7hHbqwWULJa3gWQ8ssM3Aq
         +KV3T+oiLzYmA0wqW3BPjN+9s5UinKd0SJbjfwL+8yYEV46ef6oZk8JTCTrfGugxFvTy
         4ZFQ==
X-Gm-Message-State: APjAAAXdtjhHeVu+pA1qGhI3/SYVLUS/ffG6nf1fqa7sgQzWTLMHnyqA
        zJrRvp1XkdxSKCZimr9B24Y=
X-Google-Smtp-Source: APXvYqysdSQmM3o2+6WY0rpAdGr0HHG/ZGJYT13v8GdL0NeD7ftVmDfa8uFvMhkQNQ/V+qYghuuSEg==
X-Received: by 2002:a05:620a:13da:: with SMTP id g26mr11110738qkl.410.1581578053081;
        Wed, 12 Feb 2020 23:14:13 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 11sm861963qkc.54.2020.02.12.23.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:14:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6191021D26;
        Thu, 13 Feb 2020 02:14:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Feb 2020 02:14:11 -0500
X-ME-Sender: <xms:QfdEXl2xLpx6PCDG8CjvNphZK8x8hQybwsk3SSbJOmlUzfnq-RMYlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvd
    drudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:QfdEXmXFtqe3sl2Cy3He_Ni7VTqLhKe5ZVL40LpYYunr7eXdeGMAfg>
    <xmx:QfdEXrVlb8pVeDv2lfmKF5bWBLaNF9iPsqzPByiasVTe93Fd_21kNQ>
    <xmx:QfdEXpELSkqEgbE8ud_9z3nNhDdDoSxLEoCyX9DIUtPfRjJq16LBfw>
    <xmx:Q_dEXoeJYxTZue3I4qVS_GOlNAs9Iz4L8GOPQb7lRpKMlTe7NdUgTqALuLI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CC013280059;
        Thu, 13 Feb 2020 02:14:09 -0500 (EST)
Date:   Thu, 13 Feb 2020 15:14:07 +0800
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
Subject: Re: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Message-ID: <20200213071407.GD69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-4-boqun.feng@gmail.com>
 <HK0P153MB0148834D630E95D055CE051CBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0148834D630E95D055CE051CBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 13, 2020 at 04:18:01AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> > b/arch/x86/include/asm/hyperv-tlfs.h
> > 
> > +union hv_msi_entry {
> > +	u64 as_uint64;
> > +	struct {
> > +		u32 address;
> > +		u32 data;
> > +	} __packed;
> > +};
> 
> Just a small thing: should we move the __packed to after the "}" of
> the union hv_msi_entry ?
> 

Actually, in TLFS header, it's common to put the "__packed" inside the
union, rather than after the union. It makes sense because union is
different than struct: the alignment requirement of a union is already
decided by the "as_*" member, so no need for "__packed" attribute.

> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thanks!

Regards,
Boqun
