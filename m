Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E51151420
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Feb 2020 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgBDCNd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 21:13:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40236 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBDCNc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 21:13:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id b7so1222041qkl.7;
        Mon, 03 Feb 2020 18:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZmEGXacXxicuuPoJQtVnZbvxG0RFnbvOKhiEeP6vow=;
        b=KVi4gby9PprqxfGEEC+4ouLgLiwpLisNZBv8dGQhj8U16REXKcxfbNCTW84pL3Pfrk
         dYOKdGaqVn6s+Nl0twegaWDeGN69OZYAAxMiiqMmKKZ8s1PaQV7eNZ410S6X3lBkVcVP
         19oTCOs1bPLpPVGVtGUDsInHS4wqJJSgC3eSWnE/HkIC08rCCLG0QuXnNZ5sxPEdi/TC
         of3F1/BTRLd2zVbWEiVeZtyBE5nRJxoMJrz3/1y/Qxw0n+A/zv4k7sSJ2P6kV7aIazXZ
         VU/DUSZp7vYFUMhuhhbDVKoqNwSGkXoSMJIu4hhJbZ/R+y5fH+0IqbY8hbsLr16c1vKx
         oxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZmEGXacXxicuuPoJQtVnZbvxG0RFnbvOKhiEeP6vow=;
        b=duc9MaercplkGV5iLDMOUB2farcqklsTc2pHaewFwySk/BPVWaosyP7Jc3H7VHzbZq
         eVUAEFNB/6fHOcl1C7gtVFoQODvjTZf9jDvWWl/9wnpBpu4Awl0evO0JwVPNkeMfoB2k
         g+qQXE3MCWWul1JxfY+y1GPmQdmk0kOTMx4rMldoqyJCJWijNinLK3f7xVNOSj5nloZl
         QjC4DYdlD1LeOZGF7Q4LlhnIM1/bmyEq3+6hJgyNp3KSTrDZNiRjbYsdQBP9w21MIYqB
         78vNLmWwepMDFCTjnU8vcEtY3EZXZAKEfhkzE+mClUy1H1dd+OIZYiV3KSpjpXIVi8o2
         3Vyw==
X-Gm-Message-State: APjAAAU3v3GsXsLymNM6sCN0uxZNPDnha7s/J9/wPKICDvDCBvanAsjK
        tzHKuJ9nGTTxnRp7fbzhaeg=
X-Google-Smtp-Source: APXvYqz5Ms8KUiDTqQ+/nuTELvlSFK9eOOh8AFmWmwRebL0ckOFYlc2O0lnRebTQvyLb5G3YcWC4wg==
X-Received: by 2002:a05:620a:ce5:: with SMTP id c5mr25694582qkj.49.1580782411625;
        Mon, 03 Feb 2020 18:13:31 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f26sm10743199qtv.77.2020.02.03.18.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 18:13:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id EFBE722129;
        Mon,  3 Feb 2020 21:13:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 21:13:29 -0500
X-ME-Sender: <xms:RNM4XroX4ED5nLLTtnhMzmQtsFGh05NaZLBSk2l16WX-NH5qGJcb8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RNM4Xnt5B3BsSnOBYJ83rKXOnPs1jjiWjda9LccU84dAeiYARLVT-A>
    <xmx:RNM4XmVBjIpuJQCDL4m3qbpZZjWPjSr2h8uFSVtBFhmX3C3Slv5Zcw>
    <xmx:RNM4Xj0Kaovit0lFRiXKgjHxuPoogsQaIQVlT8V6pGOFr_-e05ODkg>
    <xmx:SNM4XmK_iGvA1SLWIFwSAfO1rgItoJMqReOtGvuK0_5f_76115Ra-POAL5I>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id E95B130602DB;
        Mon,  3 Feb 2020 21:13:23 -0500 (EST)
Date:   Tue, 4 Feb 2020 10:13:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 3/3] PCI: hv: Introduce hv_msi_entry
Message-ID: <20200204021322.GH83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-4-boqun.feng@gmail.com>
 <87d0av20nj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0av20nj.fsf@nanos.tec.linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 03:41:52PM +0100, Thomas Gleixner wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> >  /*
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index 6b79515abb82..3bdaa3b6e68f 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -240,6 +240,11 @@ bool hv_vcpu_is_preempted(int vcpu);
> >  static inline void hv_apic_init(void) {}
> >  #endif
> >  
> > +#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
> > +do {								\
> > +	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
> > +} while (0)
> 
> Any reason why this needs to be a macro? inlines are preferrred. They

Making it an inline function will require #include <linux/msi.h> in
mshyperv.h, which I was trying to avoid. But now it seems pointless. I
will make it an inline in next version.

Regards,
Boqun

> are typesafe and readable.
> 
> Thanks,
> 
>         tglx
