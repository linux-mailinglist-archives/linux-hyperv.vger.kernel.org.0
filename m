Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8924150880
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBCOf4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 09:35:56 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39481 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgBCOfz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 09:35:55 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so6882741qvk.6;
        Mon, 03 Feb 2020 06:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHZXEZfxcArrJOwFLOO5B25gH5Nf7M6GMePV8H95wz8=;
        b=AN4jrTsY0Be0qFeBI9ikRLgxslO22TK9D1lt7ekoGyu3ID/zgEWhSNVupxjTkfAwxZ
         RyklxvFtDIJzsnMWV9zv2YBMZWMtNgNTSG0RhwM7waizdUZJv4Yolq1UseGtKmfN4AlG
         523oxjEUuqbaxJghOAZ2wLYFOObEbNB8BYnW43sb7bdgk+n6zPYYiiGZrSiXYaZAJF5U
         D4dnArJCuHz5mLrlCfrFE5sAmPQcA6ikoOOc/SmeiOyF6oLimoxK+FiVMdIY1FjMIbbp
         0XLFnJjUPmrI4YCpuDOGG2azN0IBRGLHF7Ee7qkkwezHahQF5sj8HAx2FTsGIQDMI92c
         qHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHZXEZfxcArrJOwFLOO5B25gH5Nf7M6GMePV8H95wz8=;
        b=Qj4R9ps0BbKwstnXV53H/CEEx9XMMpxoLxXjXK4g2U1mMuMKxkYXQYmwB6ErziT2iV
         L4KnFG12bTN+Rj8OBTICLdtfoOwSbd76r2F8CETQ4l7SWV7r1vROkkITKOWDmMUv/OLn
         OgYGoqadk/WIl/ppftN3FTCwc/zA8bqSp/1OYcQob/Kl5dYEtVejNIzq6QmyuM0H5RCc
         ahpnaTAvnIhaxt81rqeEoG2iKmdFnWEK4y7A381Cy2XIelDCJe/KI36XXXV/zg32NrkX
         Wh/FfdfE1zO7/gMsRmMHMKujAr9/ve0e9nVdc4+PBmpxwUUtTQBYTzYnnwNWkWp5jvI6
         MEjg==
X-Gm-Message-State: APjAAAUZIqXn/OnYtzF8R+yPMXpceN7WMd+mNjsQQAbnaBt59ReJsFOR
        Gdv6gZr75mB/KEo/zSVGjzY=
X-Google-Smtp-Source: APXvYqz2HVVFSAa8uHQTrlSI3OhLdRF470sd06dYwwzRxF3/fPsupj9vDFDZEBqMNubVa0aYJMX5hg==
X-Received: by 2002:ad4:4b08:: with SMTP id r8mr23469453qvw.250.1580740554339;
        Mon, 03 Feb 2020 06:35:54 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y26sm10320882qtc.94.2020.02.03.06.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 06:35:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id F307E22076;
        Mon,  3 Feb 2020 09:35:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 09:35:53 -0500
X-ME-Sender: <xms:xy84XttKeqh-gEQBxwPA7O1wcftgh5R6j1HrJc4iCNBRU1xMSuoZGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:xy84XrUwqTqDlXrEOy3a-4hDTr1RqwBGNrCO4l3nOYY4diUTEohGaw>
    <xmx:xy84XmrxUVgY6rxtgT_eM73yjc8rIyKzW2JEtf46MXyzuQgJjmNCLA>
    <xmx:xy84XmrMHXee9CTrkoNKbXcfj7xPp4QGXyZGcdYPkESWy6NUGo3-aA>
    <xmx:yC84XrVUQM4PYFvQRz9qqQmG05aMITRnwhR3rbkEWU1bcpyLopjULeXBLiQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFF233060272;
        Mon,  3 Feb 2020 09:35:50 -0500 (EST)
Date:   Mon, 3 Feb 2020 22:35:49 +0800
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
Subject: Re: [PATCH v2 3/3] PCI: hv: Introduce hv_msi_entry
Message-ID: <20200203143549.GG83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-4-boqun.feng@gmail.com>
 <20200203095140.GE20189@big-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203095140.GE20189@big-machine>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 09:51:40AM +0000, Andrew Murray wrote:
> On Mon, Feb 03, 2020 at 01:03:13PM +0800, Boqun Feng wrote:
> > Add a new structure (hv_msi_entry), which is also defined int tlfs, to
> 
> s/int/in the/ ?
> 

Good catch, will fix.

> > describe the msi entry for HVCALL_RETARGET_INTERRUPT. The structure is
> > needed because its layout may be different from architecture to
> > architecture.
> > 
> > Also add a new generic interface hv_set_msi_address_from_desc() to allow
> > different archs to set the msi address from msi_desc.
> > 
> > No functional change, only preparation for the future support of virtual
> > PCI on non-x86 architectures.
> > 
> > Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h  | 11 +++++++++--
> >  arch/x86/include/asm/mshyperv.h     |  5 +++++
> >  drivers/pci/controller/pci-hyperv.c |  4 ++--
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> > index 4a76e442481a..953b3ad38746 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -912,11 +912,18 @@ struct hv_partition_assist_pg {
> >  	u32 tlb_lock_count;
> >  };
> >  
> > +union hv_msi_entry {
> > +	u64 as_uint64;
> > +	struct {
> > +		u32 address;
> > +		u32 data;
> > +	} __packed;
> > +};
> > +
> >  struct hv_interrupt_entry {
> >  	u32 source;			/* 1 for MSI(-X) */
> >  	u32 reserved1;
> > -	u32 address;
> > -	u32 data;
> > +	union hv_msi_entry msi_entry;
> >  } __packed;
> >  
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
> Given that this is a single statement, is there really a need for the do ; while(0) ?
> 

I choose to use do ; while (0) because I don't want code like the
following to be able to compile:

	hv_set_msi_address_from_desc(...) /* semicolon is missing */
	a = b;

But now think more about this, I think it's probably better to define
this as a function..

> 
> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >  static inline void hyperv_setup_mmu_ops(void) {}
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 0d9b74503577..2240f2b3643e 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1170,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	memset(params, 0, sizeof(*params));
> >  	params->partition_id = HV_PARTITION_ID_SELF;
> >  	params->int_entry.source = 1; /* MSI(-X) */
> > -	params->int_entry.address = msi_desc->msg.address_lo;
> > -	params->int_entry.data = msi_desc->msg.data;
> > +	hv_set_msi_address_from_desc(&params->int_entry.msi_entry, msi_desc);
> > +	params->int_entry.msi_entry.data = msi_desc->msg.data;
> 
> If the layout may differ, then don't we also need a wrapper for data?
> 

On x86 hv_msi_entry is:

	{
		u32 address;
		u32 data;
	}

and on ARM64 it is:

	{
		u64 address;
		u32 data;
		u32 reserved;
	}

So currently, setting msi_entry.data doesn't need a wrapper for
different archs. But now you mention it, probably a better way is to
provide a wrapper hv_set_msi_entry_from_desc(), which sets both address
and data instead of hv_set_msi_address_from_desc().

Thanks for looking into the whole patchset!

Regards,
Boqun

> Thanks,
> 
> Andrew Murray
> 
> >  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> >  			   (hbus->hdev->dev_instance.b[4] << 16) |
> >  			   (hbus->hdev->dev_instance.b[7] << 8) |
> > -- 
> > 2.24.1
> > 
