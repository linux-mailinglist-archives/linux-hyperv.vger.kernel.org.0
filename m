Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7401465E3
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWKkM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 05:40:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37264 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWKkM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 05:40:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so2061153qtk.4;
        Thu, 23 Jan 2020 02:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDcQGglpaul1tPS+GCmx20FNALyPlED6w9cqoaLS8mU=;
        b=fR4TsOo87FGGZXrttxAbeEpOCX1chbBMJBjQVjOD0knypYOYbHwOVBwSjlqjtrHumF
         tGFxV/yrY/gto/6WYnkE2hSa4K//Q3JUdbdEmPg7UUrYC1xUC9E7KIEYVc69PcCg9HWa
         gu4Itf82JY5MSWlmGYO4CdxZZ/LeZQoJIie3L3v/N7KNVGRZw5U790FeI7dJls79vxXn
         YTwTtTChRmKe6sDH92jHsXO+FajFVJ54MvgvouLKXPSi5pDVMsEGxkQzkQ90lbkg4CJd
         2brvlGfbf4vxqTp6w8LYDYAVdRK/3he0/ZHiIMYqt2NYoz8HMO/xj3kl3H0zG8pkhh17
         iXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDcQGglpaul1tPS+GCmx20FNALyPlED6w9cqoaLS8mU=;
        b=PRr2OxgYm6MwVHNEKRzWoDX11L3bVR8MD+j6v/RqI+VF4J8SKTLGB98fXYYw3bHxHc
         ZafAtSW2JiM54+46Gd87UxInmxa212fEkF57pAF7sbyRJ1c7/+HfieaAZkE76ukALSjO
         x0Ug83jcXhLwIgkiWg3/jWQ/pFPGZAgYqcmYRR+K5Lu7mTBjkD0E4ZUsUDzvgjBln8dF
         PdReyDaW8LBgRxT9fnRj6GOSP5yfvxPEIzC/DrLG0yCCkALfsUslhi/4lmRpQQrq1qiD
         ns19o0aQJMu5XpHtFWJneknZ+BjF57axoHuL1Xdnma6M/A1iOixofHgCA5gsDI2DwJsA
         BvMg==
X-Gm-Message-State: APjAAAWRWE8jj7hzeEgaGeh4fZPqRPcoBed17wbJeo0+ZljjN9NMJqVN
        6HbFyK2UeH/jpaWMqPcH+vc=
X-Google-Smtp-Source: APXvYqxew/CEDapez6dF5/McKNlZA9U6YEbQY0A19f8GX4NviQ99xw9pTwdp012PbULYqmb7ktISUw==
X-Received: by 2002:ac8:7356:: with SMTP id q22mr15119734qtp.162.1579776011333;
        Thu, 23 Jan 2020 02:40:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u4sm668037qkh.59.2020.01.23.02.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 02:40:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2FA0F21AEF;
        Thu, 23 Jan 2020 05:40:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 Jan 2020 05:40:10 -0500
X-ME-Sender: <xms:CXgpXt8ROVDUikj5RrZ6vXMJbD7g2XQ37UXIW-sznFJP5BAW2uFGmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphephedvrd
    duheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CXgpXuL0IYlP24rOfxk7qhDaMJrXHFgjGQrKJ43q0lGLdmAL_nL_iA>
    <xmx:CXgpXizYdlqEJMgY0PeIV1kM-3h6tDqVMHpB7XLFanm_JV0LQrK-Wg>
    <xmx:CXgpXiXtpgeV3GLbdRYiFvbYFcD4ugRsU0qE-NIkdKzfvd_WgfVtIw>
    <xmx:CngpXpiNQQRwLD6lR6mqcBNzNgRcmNC6R7AIY1X6GDpNz55tgFbnVpwt-hk>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id F320F3280063;
        Thu, 23 Jan 2020 05:40:08 -0500 (EST)
Date:   Thu, 23 Jan 2020 18:40:07 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: hyperv: Move retarget related struct
 definitions into tlfs
Message-ID: <20200123104007.GB55410@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200121015713.69691-1-boqun.feng@gmail.com>
 <20200121015713.69691-2-boqun.feng@gmail.com>
 <87blqxf9es.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blqxf9es.fsf@vitty.brq.redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 21, 2020 at 10:25:47AM +0100, Vitaly Kuznetsov wrote:
[...]
> >  
> > +#if IS_ENABLED(CONFIG_PCI_HYPERV)
> > +#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
> > +do {								\
> > +	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
> > +} while (0)
> > +
> > +#endif /* CONFIG_PCI_HYPERV */
> 
> It seems to be pointless to put defines under #if IS_ENABLED(): in case
> it is not enabled and used you'll get a compilation error, in case it is
> enabled and not used no code is going to be generated anyways.
> 

OK I will remove the #if IS_ENABLED() in the next version.

> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >  static inline void hyperv_setup_mmu_ops(void) {}
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index aacfcc90d929..2240f2b3643e 100644
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
> >  	struct hv_pcibus_device *hbus;
> >  	struct cpumask *dest;
> >  	cpumask_var_t tmp;
> > @@ -1200,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
> >  	memset(params, 0, sizeof(*params));
> >  	params->partition_id = HV_PARTITION_ID_SELF;
> >  	params->int_entry.source = 1; /* MSI(-X) */
> > -	params->int_entry.address = msi_desc->msg.address_lo;
> > -	params->int_entry.data = msi_desc->msg.data;
> > +	hv_set_msi_address_from_desc(&params->int_entry.msi_entry, msi_desc);
> 
> I don't quite see why this hv_set_msi_address_from_desc() is needed at
> all.
> 

I will add some description in the next version, the reason that
hv_set_msi_address_from_desc() is arm64 and x86 have different
hv_interrupt_entry formats. So a generic interface is needed so that
archs can have different ways to set ->address field from msi_desc.

Regards,
Boqun

> > +	params->int_entry.msi_entry.data = msi_desc->msg.data;
> >  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> >  			   (hbus->hdev->dev_instance.b[4] << 16) |
> >  			   (hbus->hdev->dev_instance.b[7] << 8) |
> 
> -- 
> Vitaly
> 
