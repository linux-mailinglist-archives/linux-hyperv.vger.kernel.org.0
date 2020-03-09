Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CCF17E294
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2020 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIOf5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 Mar 2020 10:35:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39041 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCIOf5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 Mar 2020 10:35:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id e16so9396400qkl.6;
        Mon, 09 Mar 2020 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5jAy914ctIMdKta9JuUGrpnLf6WaH5WzoC+86aivxiI=;
        b=Vod/MyYbR1Dx57lAsnEqZPeHZr9tyCwDnK+o0lvYZc/yGoeG5Zkw7CZ8kT5elNxeET
         WCvV606gKdzZ5BaBqNV9kFav25u78hItE24J7zWedXDF9RiBY8mnR++LAPYyaSkj8Owm
         TEfN4h6hoWcUKnepRRBhc70Fe1enkjr6IJ1fsj0egtXMsL7MkIWVIikXBhPbUg4DrHrm
         hsLd40H7pWYfheUDbVLO4fds7pnLwPA7aqg0F8lg26nh7bKEjjk+mMAXgWg2T2QPo59U
         T/9xWCGKnn1atfS4StLR0AU9yw+Y+9UfY48Htb8TtnC/IElGiSL6qMjKwcd+pOSrli9+
         nGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jAy914ctIMdKta9JuUGrpnLf6WaH5WzoC+86aivxiI=;
        b=luRhWHhY/C6X+ttPcHo8foyKeOMFsnxIH8Ov2rM2urvhezS7R/wTBdZaGcvLm0zzsX
         LYp9b79ICKvcIJWmPwPXd5jjIhlovadjgagPBp/O7tyhjCqWdF0BrH0fgVoYk+B7qeOA
         5T9Ic0wmm4ssT8QGcKpKyB9GmdQk7wQllb2Ibs9qpm51kcbbqvk5SJxhZ7PUlZRuE2/H
         jJXcBnsvGtDgTI79k6BxMhd/zKbZ1TbfHscOmvMUX4rprokCURbHqOwzl81S+WsL8LIK
         axyoYHDivqh8xt7p9VNl3sx9AH9ui7Rxg/NwK1LNjVKyQMl7GewMWvpPBWvFwgTboQ6E
         dc/A==
X-Gm-Message-State: ANhLgQ3Il4e82fYnUFXBasJsyMrx6zAdf0ffzxfJlj87R9872JmR9Et5
        9izRLSerK5aJoIde2N/UtbY=
X-Google-Smtp-Source: ADFU+vsKCcBzRKWf1W59h0lUF1gUHp4hBeMziSwnCnlwUZ3NK0Xa2PKr2UG9Epf8gMM6h0BqAQsmmg==
X-Received: by 2002:a37:67c4:: with SMTP id b187mr7681788qkc.209.1583764555383;
        Mon, 09 Mar 2020 07:35:55 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p16sm22360496qkp.12.2020.03.09.07.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:35:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0786022148;
        Mon,  9 Mar 2020 10:35:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 09 Mar 2020 10:35:52 -0400
X-ME-Sender: <xms:RlRmXh7AhVcgDalB_YgnDdCKIk9Cw4yFlgdun8y9ZgunLxIiENoeMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduuddurdejudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RlRmXvyESB274MuNPqwBvmeuuDIpkZZIsJKS-4GP_DH8P-fo2ApRSA>
    <xmx:RlRmXpc0aLy-UzpXL4M6i3X152o-XVdssVXbhfZUsVQhyQv91Oasfw>
    <xmx:RlRmXsGhCxIzUY-W_t-VC1u3qWDVLhAmhPBAvm0olHuhVrrPsd9iEw>
    <xmx:SFRmXpuz8Gn8qa90c8fLB50qXqcHDDcwz4iSNzcJmKoyhwmQ5ZG-HmWSNEQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03317306130A;
        Mon,  9 Mar 2020 10:35:49 -0400 (EDT)
Date:   Mon, 9 Mar 2020 22:35:48 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] PCI: hv: Generify pci-hyperv.c
Message-ID: <20200309143548.GB118238@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200221023344.GJ69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200221104454.GA8595@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104454.GA8595@e121166-lin.cambridge.arm.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Lorenzo,

On Fri, Feb 21, 2020 at 10:44:54AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Feb 21, 2020 at 10:33:44AM +0800, Boqun Feng wrote:
> > Ping ;-)
> > 
> > Any suggestion or plan on this patchset?
> 
> Hi,
> 
> I shall have a look shortly, thanks.
> 

Any chance you got some time to look into this?

Regards,
Boqun

> Lorenzo
> 
> > Thanks and Regards,
> > Boqun
> > 
> > On Mon, Feb 10, 2020 at 11:39:50AM +0800, Boqun Feng wrote:
> > > Hi,
> > > 
> > > This is the first part for virtual PCI support of Hyper-V guest on
> > > ARM64. The whole patchset doesn't have any functional change, but only
> > > refactors the pci-hyperv.c code to make it more arch-independent.
> > > 
> > > Previous version:
> > > v1: https://lore.kernel.org/lkml/20200121015713.69691-1-boqun.feng@gmail.com/
> > > v2: https://lore.kernel.org/linux-arm-kernel/20200203050313.69247-1-boqun.feng@gmail.com/
> > > 
> > > Changes since v2:
> > > 
> > > *	Rebased on 5.6-rc1
> > > 
> > > *	Reword commit logs as per Andrew's suggestion.
> > > 
> > > *	It makes more sense to have a generic interface to set the whole
> > > 	msi_entry rather than only the "address" field. So change
> > > 	hv_set_msi_address_from_desc() to hv_set_msi_entry_from_desc().
> > > 	Additionally, make it an inline function as per the suggestion
> > > 	of Andrew and Thomas.
> > > 
> > > *	Add the missing comment saying the partition_id of
> > > 	hv_retarget_device_interrupt must be self.
> > > 
> > > *	Add the explanation for why "__packed" is needed for TLFS
> > > 	structures.
> > > 
> > > I've done compile and boot test of this patchset, also done some tests
> > > with a pass-through NVMe device.
> > > 
> > > Suggestions and comments are welcome!
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > Boqun Feng (3):
> > >   PCI: hv: Move hypercall related definitions into tlfs header
> > >   PCI: hv: Move retarget related structures into tlfs header
> > >   PCI: hv: Introduce hv_msi_entry
> > > 
> > >  arch/x86/include/asm/hyperv-tlfs.h  | 41 +++++++++++++++++++++++++++
> > >  arch/x86/include/asm/mshyperv.h     |  8 ++++++
> > >  drivers/pci/controller/pci-hyperv.c | 43 ++---------------------------
> > >  3 files changed, 52 insertions(+), 40 deletions(-)
> > > 
> > > -- 
> > > 2.24.1
> > > 
