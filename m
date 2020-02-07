Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C30155360
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Feb 2020 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgBGH6j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Feb 2020 02:58:39 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34285 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGH6j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Feb 2020 02:58:39 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so549319qvf.1;
        Thu, 06 Feb 2020 23:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+8c5JlWjjqu/EOlhqk0EX1eBg+PJtRvkzYvzmRZHcMI=;
        b=qiKu014Sm8xKPMGVSlXuquzuUREIFaY73Cyv3jv2Amdb2OXXwA5EjdZXc5a6EygFht
         +p9qKxwg3+t7wGAUv+zaO35AhSMiTKqtqAJdiNqtn98YQlQ+2EGxF5WTJGAeJwgYUsCE
         zC7gnWWd2noEGaw71PQ7fJJjpAfQFe+FiHrTJ8GFPIiZOQRv6YAJWMwxCLkvky4ntbx2
         fUNGNp/1ZN2CfsHTp50gdZ7Rz7HNS3WPBorilcY3G36p5YWxIaPeKk8zUd5r6PGLEgLr
         50yg2KyhpMW2JRIAU7FpDJB0DbaKQ0s7oSH2bcjDfoYTidgwsCf3m/4DTqxdtfr79f+R
         DZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8c5JlWjjqu/EOlhqk0EX1eBg+PJtRvkzYvzmRZHcMI=;
        b=EHfwsl+9Xpu4E+QuuxExZesHU3RSSWxlI8rV7EvFygb4ok7vedX3k17P6HtCLfQlKq
         1VsR/+QdbWkZPFMCfMpU78+qQaDoJW0rwszpBkmudpc+MkecGfYsmir6CGSQUKLDxycu
         E1G6D6b32n7gb8jyMsrr5eMH4K+bI28N3Ep1yT3AJ1eB8G+lu/trj7+8VbSi7iZmMwEh
         eeKwEuHuHB2yynKj+FlsH6FZahwbC7/6/409g20JqT+DC9EFXvQLaLqCMUDr1TTaJFYv
         PsMnDEiL2qSxByoRUNFvgNpiPxug3+QBgK1QH3a4h+kniTBnyfiI+1olrjnIHfVFhGv7
         AhZw==
X-Gm-Message-State: APjAAAVigiM6+b0Ac0GdZCAQtEp7XXN1Cfw7v8masaG+ckzusLX0cFRA
        OZQMKJ1fb/R9eVGEenTNRXo=
X-Google-Smtp-Source: APXvYqyifZVH92EM74YFa00SfHJpC3ZjhwzPl3XmYDjwFO5nTJ3u+tQMe5PmEMMxRgDwBFdXU9Sn1Q==
X-Received: by 2002:a0c:ef0f:: with SMTP id t15mr5831089qvr.123.1581062317814;
        Thu, 06 Feb 2020 23:58:37 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h34sm1034523qtc.62.2020.02.06.23.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 23:58:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7291322036;
        Fri,  7 Feb 2020 02:58:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Feb 2020 02:58:34 -0500
X-ME-Sender: <xms:qBg9XhX9Y2iOTWxtghZ3ut0uPHKGNMqr6BfhP89W6XwaoGdiQX-fzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrheeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehmihgtrhhoshhofhhtrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphephedvrddu
    heehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdei
    ledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrd
    gtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qBg9XiA27hLZAMgsakD-uluxltqhG7ipDNUyMG_S3vqsbTAjtWA8Tw>
    <xmx:qBg9XkQOYJSNbyCL00KjscPH25xlFbQVpBdrHIElKzRQxTzJqJ988A>
    <xmx:qBg9Xqmaeu9Ywar_0cw-qxhMYHkwTc08SdbMT2CNuiTRORDETofTfA>
    <xmx:qhg9XsFne-gX1foW3TSEGcDHf41aaz8evIwSFmiJP70AshzgOzs8DdAwnzc>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4467A3280060;
        Fri,  7 Feb 2020 02:58:32 -0500 (EST)
Date:   Fri, 7 Feb 2020 15:58:30 +0800
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
Message-ID: <20200207075830.GB69108@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-3-boqun.feng@gmail.com>
 <20200203094118.GD20189@big-machine>
 <20200203140902.GF83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140902.GF83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 10:09:02PM +0800, Boqun Feng wrote:
[...]
> > > mirroring the name in TLFS.
> > > 
> > > [1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> > > 
> > > Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> > > ---
> > >  arch/x86/include/asm/hyperv-tlfs.h  | 31 ++++++++++++++++++++++++++
> > >  drivers/pci/controller/pci-hyperv.c | 34 ++---------------------------
> > >  2 files changed, 33 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > > index 739bd89226a5..4a76e442481a 100644
> > > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > > @@ -911,4 +911,35 @@ struct hv_tlb_flush_ex {
> > >  struct hv_partition_assist_pg {
> > >  	u32 tlb_lock_count;
> > >  };
> > > +
> > > +struct hv_interrupt_entry {
> > > +	u32 source;			/* 1 for MSI(-X) */
> > > +	u32 reserved1;
> > > +	u32 address;
> > > +	u32 data;
> > > +} __packed;
> > 
> > Why have you added __packed here? There is no mention of this change in the
> > commit log? Is it needed?
> > 
> 
> I'm simply following the convention of hyperv-tlfs.h: most of the
> structures have this "__packed" attribute. I personally don't think this
> attribute is necessary, but I was afraid that I was missing something
> subtle. So a question for folks working on Hyper-V: why we need this
> attribute on TLFS-defined structures? Most of those will have no
> difference with or without this attribute, IIUC.
> 

I find this patch:

	https://lore.kernel.org/lkml/20181212175701.18754-1-vkuznets@redhat.com/

The reason why the "__packed" attribute is needed is to protect the
hypervisor-guet communication structures from unexpected behaviors of
compilers.

I will keep the code as it is and add some words in the commit log.

Regards,
Boqun

> > > +
> > > +/*
> > > + * flags for hv_device_interrupt_target.flags
> > > + */
> > > +#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> > > +#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> > > +
> > > +struct hv_device_interrupt_target {
> > > +	u32 vector;
> > > +	u32 flags;
> > > +	union {
> > > +		u64 vp_mask;
> > > +		struct hv_vpset vp_set;
> > > +	};
> > > +} __packed;
> > 
> > Same here.
> > 
> > > +
> > > +/* HvRetargetDeviceInterrupt hypercall */
> > > +struct hv_retarget_device_interrupt {
> > > +	u64 partition_id;
> > 
> > Why drop the 'self' comment?
> > 
> 
> Good catch, TLFS does say this field must be 'self'. I will add it in
> next version.
> 
> > > +	u64 device_id;
> > > +	struct hv_interrupt_entry int_entry;
> > > +	u64 reserved2;
> > > +	struct hv_device_interrupt_target int_target;
> > > +} __packed __aligned(8);
> > >  #endif
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index aacfcc90d929..0d9b74503577 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -406,36 +406,6 @@ struct pci_eject_response {
> > >  
> > >  static int pci_ring_size = (4 * PAGE_SIZE);
> > >  
> > > -struct hv_interrupt_entry {
> > > -	u32	source;			/* 1 for MSI(-X) */
> > > -	u32	reserved1;
> > > -	u32	address;
> > > -	u32	data;
> > > -};
> > > -
> > > -/*
> > > - * flags for hv_device_interrupt_target.flags
> > > - */
> > > -#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> > > -#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> > > -
> > > -struct hv_device_interrupt_target {
> > > -	u32	vector;
> > > -	u32	flags;
> > > -	union {
> > > -		u64		 vp_mask;
> > > -		struct hv_vpset vp_set;
> > > -	};
> > > -};
> > > -
> > > -struct retarget_msi_interrupt {
> > > -	u64	partition_id;		/* use "self" */
> > > -	u64	device_id;
> > > -	struct hv_interrupt_entry int_entry;
> > > -	u64	reserved2;
> > > -	struct hv_device_interrupt_target int_target;
> > > -} __packed __aligned(8);
> > > -
> > >  /*
> > >   * Driver specific state.
> > >   */
> > > @@ -482,7 +452,7 @@ struct hv_pcibus_device {
> > >  	struct workqueue_struct *wq;
> > >  
> > >  	/* hypercall arg, must not cross page boundary */
> > > -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > > +	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
> > >  
> > >  	/*
> > >  	 * Don't put anything here: retarget_msi_interrupt_params must be last
> > > @@ -1178,7 +1148,7 @@ static void hv_irq_unmask(struct irq_data *data)
> > >  {
> > >  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> > >  	struct irq_cfg *cfg = irqd_cfg(data);
> > > -	struct retarget_msi_interrupt *params;
> > > +	struct hv_retarget_device_interrupt *params;
> > 
> > pci-hyperv.c also makes use of retarget_msi_interrupt_lock - it's really clear
> > from this name what it protects, however your rename now makes this more
> > confusing.
> > 
> > Likewise there is a comment in hv_pci_probe that refers to
> > retarget_msi_interrupt_params which is now stale.
> > 
> 
> But 'retarget_msi_interrupt_params' is the name of field in
> hv_pcibus_device, so is 'retarget_msi_interrupt_lock'. And what I change
> is the name of type. I believe people can tell the relationship from
> the name of the fields, and the comment of hv_pci_probe actually refers
> to the field rather than the type.
> 
> > It may be helpful to rename hv_retarget_device_interrupt for consistency with
> > the docs - however please make sure you catch all the references - I'd suggest
> > that the move and the rename are in different patches.
> > 
> 
> If the renaming requires a lot of work (e.g. need to change multiple
> references), I will follow your suggestion. But seems it's not the case
> for this renaming.
> 
> Regards,
> Boqun
> 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > >  	struct hv_pcibus_device *hbus;
> > >  	struct cpumask *dest;
> > >  	cpumask_var_t tmp;
> > > -- 
> > > 2.24.1
> > > 
