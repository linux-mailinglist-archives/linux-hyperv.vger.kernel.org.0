Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8415080E
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 15:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBCOJM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 09:09:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43985 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCOJM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 09:09:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id j20so14261060qka.10;
        Mon, 03 Feb 2020 06:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VglaDyUpCkhXx9hrqC8HpF3hY8//yvxe/GnkNqkiuyI=;
        b=MTFWSwdpIUN8fEmK8IEJFk3+2UKh25nl1YOD3Rl+VpzxzZ1bTaYjiIE3C1XRorPZDD
         MCn/mJFqyLTkf4OTPYCPDBfAJUn/OeeSwV6/hedS2cDPjyNGl1WUxmpKaOkEyDROmZ27
         DR5AYFIts5noWIUSJsjy3GhKhecU4K7zA1dTmak0bdSxPLWtCzO1WOZ89OguEkAn3tfY
         lP6rSJ4nXepy5mSPX4rW3jtewtJyBpwDPhJI/L9KHqxuD2ex2vqjq/QjL8DFYwXfYfon
         Mil7GUMoOvKktpinmfVwku9eyKEe+nZYOC/lTRwr/QB9+dyoAfYX7ZZPQc0XcKeCYpww
         ZoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VglaDyUpCkhXx9hrqC8HpF3hY8//yvxe/GnkNqkiuyI=;
        b=JtqmbGHmrdqtE6ZyOoSd0oH0jglzqI+bNm3TANP5xZY+EnLGegnCSK5D0niNqp0sf/
         rRVPJ1lmCk2W3rsErsUsUj6CWP/fVNvFtjJA5Dm3gl9QGWM7NG7oyIYfY7q2t3OWmWHx
         1mEr47Wk//lVghN+GTlSKJcMmmEcMNakgBMfQ30HnVAHj9pUzeIfPsPiDEhQw3//sQjH
         tGq43dMOYn975cjvU86QKUYgK4XYCb1zQz2l9HdgDYydqX/JEMVAKGY1BM/QN3zzhWMF
         0kG4zlizpS7lyvmm+pN3LkEW8ZC5I5hBLJCnegnbY82/Rbj3WgF3y2a/hQE+ipAq6lIM
         jIKw==
X-Gm-Message-State: APjAAAWxQTn51sc+SWAeohiOjpeYzKWuA87m1SmnQqgtZpwBDsB16tNV
        dk5u0CRMUqmJxDzQ3IioYW0=
X-Google-Smtp-Source: APXvYqwro+2AL5hEDOifKdhLAqsxcMvlGw8iUcKsdC3VPKqmeK7aPmkU6Cq/CQ17knBfz1liZphAhQ==
X-Received: by 2002:a37:e210:: with SMTP id g16mr23584593qki.413.1580738948923;
        Mon, 03 Feb 2020 06:09:08 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d9sm9658708qth.34.2020.02.03.06.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 06:09:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9A0B021B7C;
        Mon,  3 Feb 2020 09:09:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 09:09:05 -0500
X-ME-Sender: <xms:gCk4XhDQcJFqrMRh9Orcd5rV_WSJhlhwqApM79bryhpDc-52nq0yZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epmhhitghrohhsohhfthdrtghomhenucfkphephedvrdduheehrdduuddurdejudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeek
    heehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrg
    hmvg
X-ME-Proxy: <xmx:gCk4Xjk6a0_HdOtJ1hwhQptOVIufrKwz9hJJXQhOcNy5ABrD5nJefw>
    <xmx:gCk4Xtvly7ecra5XvRQml2rympYgF_xxlnhQYeXNu59o7OHN4V3hLw>
    <xmx:gCk4XlL-H2MKZlRh5spFzqzDSH2aUeYkoDF3pgGOC1JRAZorc840EA>
    <xmx:gSk4XoZkaz1RHEYUZsvCvoPgFnccExn8_mMgTMgCYwBAA0jI1CbmjfZV0mY>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3521F3280060;
        Mon,  3 Feb 2020 09:09:04 -0500 (EST)
Date:   Mon, 3 Feb 2020 22:09:02 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Message-ID: <20200203140902.GF83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-3-boqun.feng@gmail.com>
 <20200203094118.GD20189@big-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203094118.GD20189@big-machine>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 09:41:18AM +0000, Andrew Murray wrote:
> On Mon, Feb 03, 2020 at 01:03:12PM +0800, Boqun Feng wrote:
> > Currently, retarget_msi_interrupt and other structures it relys on are
> > defined in pci-hyperv.c. However, those structures are actually defined
> > in Hypervisor Top-Level Functional Specification [1] and may be
> > different in sizes of fields or layout from architecture to
> > architecture. Therefore, this patch moves those definitions into x86's
> 
> Nit: Rather than 'Therefore, this patch moves ...' - how about 'Let's move
> ...'?
> 
> > tlfs header file to support virtual PCI on non-x86 architectures in the
> > future.
> > 
> > Besides, while I'm at it, rename retarget_msi_interrupt to
> 
> Nit: 'Besides, while I'm at it' - this type of wording describes what
> *you've* done rather than what the patch is doing. You could replace
> that quoted text with 'Additionally, '
> 
> > hv_retarget_msi_interrupt for the consistent name convention, also
> 
> Nit: s/name/naming
> 

Thanks for the suggestion on wording ;-)

> > mirroring the name in TLFS.
> > 
> > [1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > 
> > Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h  | 31 ++++++++++++++++++++++++++
> >  drivers/pci/controller/pci-hyperv.c | 34 ++---------------------------
> >  2 files changed, 33 insertions(+), 32 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 739bd89226a5..4a76e442481a 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -911,4 +911,35 @@ struct hv_tlb_flush_ex {
> >  struct hv_partition_assist_pg {
> >  	u32 tlb_lock_count;
> >  };
> > +
> > +struct hv_interrupt_entry {
> > +	u32 source;			/* 1 for MSI(-X) */
> > +	u32 reserved1;
> > +	u32 address;
> > +	u32 data;
> > +} __packed;
> 
> Why have you added __packed here? There is no mention of this change in the
> commit log? Is it needed?
> 

I'm simply following the convention of hyperv-tlfs.h: most of the
structures have this "__packed" attribute. I personally don't think this
attribute is necessary, but I was afraid that I was missing something
subtle. So a question for folks working on Hyper-V: why we need this
attribute on TLFS-defined structures? Most of those will have no
difference with or without this attribute, IIUC.

> > +
> > +/*
> > + * flags for hv_device_interrupt_target.flags
> > + */
> > +#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> > +#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> > +
> > +struct hv_device_interrupt_target {
> > +	u32 vector;
> > +	u32 flags;
> > +	union {
> > +		u64 vp_mask;
> > +		struct hv_vpset vp_set;
> > +	};
> > +} __packed;
> 
> Same here.
> 
> > +
> > +/* HvRetargetDeviceInterrupt hypercall */
> > +struct hv_retarget_device_interrupt {
> > +	u64 partition_id;
> 
> Why drop the 'self' comment?
> 

Good catch, TLFS does say this field must be 'self'. I will add it in
next version.

> > +	u64 device_id;
> > +	struct hv_interrupt_entry int_entry;
> > +	u64 reserved2;
> > +	struct hv_device_interrupt_target int_target;
> > +} __packed __aligned(8);
> >  #endif
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index aacfcc90d929..0d9b74503577 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -406,36 +406,6 @@ struct pci_eject_response {
> >  
> >  static int pci_ring_size = (4 * PAGE_SIZE);
> >  
> > -struct hv_interrupt_entry {
> > -	u32	source;			/* 1 for MSI(-X) */
> > -	u32	reserved1;
> > -	u32	address;
> > -	u32	data;
> > -};
> > -
> > -/*
> > - * flags for hv_device_interrupt_target.flags
> > - */
> > -#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> > -#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> > -
> > -struct hv_device_interrupt_target {
> > -	u32	vector;
> > -	u32	flags;
> > -	union {
> > -		u64		 vp_mask;
> > -		struct hv_vpset vp_set;
> > -	};
> > -};
> > -
> > -struct retarget_msi_interrupt {
> > -	u64	partition_id;		/* use "self" */
> > -	u64	device_id;
> > -	struct hv_interrupt_entry int_entry;
> > -	u64	reserved2;
> > -	struct hv_device_interrupt_target int_target;
> > -} __packed __aligned(8);
> > -
> >  /*
> >   * Driver specific state.
> >   */
> > @@ -482,7 +452,7 @@ struct hv_pcibus_device {
> >  	struct workqueue_struct *wq;
> >  
> >  	/* hypercall arg, must not cross page boundary */
> > -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > +	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
> >  
> >  	/*
> >  	 * Don't put anything here: retarget_msi_interrupt_params must be last
> > @@ -1178,7 +1148,7 @@ static void hv_irq_unmask(struct irq_data *data)
> >  {
> >  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> >  	struct irq_cfg *cfg = irqd_cfg(data);
> > -	struct retarget_msi_interrupt *params;
> > +	struct hv_retarget_device_interrupt *params;
> 
> pci-hyperv.c also makes use of retarget_msi_interrupt_lock - it's really clear
> from this name what it protects, however your rename now makes this more
> confusing.
> 
> Likewise there is a comment in hv_pci_probe that refers to
> retarget_msi_interrupt_params which is now stale.
> 

But 'retarget_msi_interrupt_params' is the name of field in
hv_pcibus_device, so is 'retarget_msi_interrupt_lock'. And what I change
is the name of type. I believe people can tell the relationship from
the name of the fields, and the comment of hv_pci_probe actually refers
to the field rather than the type.

> It may be helpful to rename hv_retarget_device_interrupt for consistency with
> the docs - however please make sure you catch all the references - I'd suggest
> that the move and the rename are in different patches.
> 

If the renaming requires a lot of work (e.g. need to change multiple
references), I will follow your suggestion. But seems it's not the case
for this renaming.

Regards,
Boqun

> Thanks,
> 
> Andrew Murray
> 
> >  	struct hv_pcibus_device *hbus;
> >  	struct cpumask *dest;
> >  	cpumask_var_t tmp;
> > -- 
> > 2.24.1
> > 
