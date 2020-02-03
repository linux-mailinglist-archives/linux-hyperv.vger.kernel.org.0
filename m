Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315C7150379
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Feb 2020 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBCJlY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Feb 2020 04:41:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35311 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgBCJlY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Feb 2020 04:41:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so16098818wmb.0
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Feb 2020 01:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ug26zZ8NwNX6MbD6XFC1XGn9DuxiiYnmekD3r0bSHbs=;
        b=EMKBtmenrbdEvZ13+jrPUkndzYHG4j3jJkw0MuFUP8A7i4RJzU7rdZ821A0bv47wTc
         q9jM3YhkiYtqNfBQjeX+btm0e0Z3W+PECcTkdmm6gRMEKjQ6RzbRa1A+WSO+PN4DCwE2
         G7zfQDsQ8lJB5Lleekcd3WscSL3mCHyxqJRJngPscEIaoZPrIg7r3CDGGW+kSgGxSs2j
         zAyIyF4p3tb02R8jDiuRxSUM3XrldR42iXwwbkDee5YWCKgPTS/8nqdAOcXqfy0zTvIC
         YTvo26+sR86NEW53pnCrUJYfjB8Yf7iTvvV8Iw0C7yt0jDbR0l+XOV4ipBzkLcVT8B4R
         UTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ug26zZ8NwNX6MbD6XFC1XGn9DuxiiYnmekD3r0bSHbs=;
        b=IwYwjGTE+VKH5YrbE4Im4vE1dsCHvIWNKKgwlpCGUZjbCUeCOFOIbXNt96ut64kajE
         t/7JST0chhMo2ix1zKZIbOW91Jh1w5/Cpdn8y1c/KgLes4EIbXI51QKMi5SgU8L3AWs/
         E4tN9RgQux307Kh4N3p7VQnySWdEWCvkeG5/c5iNB+9DG47CQrCay8NPkiOE9UoUv04+
         I5yuLgThRDrYDJF3lx3U2eryRlBLF6P6lS35T3Bol2CI8fgIMGDsr71QmdishXGXfpPN
         ZeZXo4qdKhI7TcbijeWQxCF3+CfciGLE4DzFzYMUpZiuBJWgt4T7BzaMDrpTcrODLdeY
         1SYA==
X-Gm-Message-State: APjAAAWp6GKtsAjg4slFHvxJkhIaEcYDowg8BbvKCWFBPNDXpvT9J1L7
        0Yp8LOQ4KjgKJ72p9Htshcl5NA==
X-Google-Smtp-Source: APXvYqxResj+dGE1o2ECZDHO94QPdR6aP+d0QknNmNfT8VIu6KZRZWZS5O5TIVJGfyQ3c8GkRqFJSA==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr27657789wmi.75.1580722880976;
        Mon, 03 Feb 2020 01:41:20 -0800 (PST)
Received: from big-machine ([2a00:23c5:dd80:8400:459c:4174:f0ee:1b26])
        by smtp.gmail.com with ESMTPSA id s8sm20064267wmf.45.2020.02.03.01.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:41:20 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:41:18 +0000
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20200203094118.GD20189@big-machine>
References: <20200203050313.69247-1-boqun.feng@gmail.com>
 <20200203050313.69247-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203050313.69247-3-boqun.feng@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 03, 2020 at 01:03:12PM +0800, Boqun Feng wrote:
> Currently, retarget_msi_interrupt and other structures it relys on are
> defined in pci-hyperv.c. However, those structures are actually defined
> in Hypervisor Top-Level Functional Specification [1] and may be
> different in sizes of fields or layout from architecture to
> architecture. Therefore, this patch moves those definitions into x86's

Nit: Rather than 'Therefore, this patch moves ...' - how about 'Let's move
...'?

> tlfs header file to support virtual PCI on non-x86 architectures in the
> future.
> 
> Besides, while I'm at it, rename retarget_msi_interrupt to

Nit: 'Besides, while I'm at it' - this type of wording describes what
*you've* done rather than what the patch is doing. You could replace
that quoted text with 'Additionally, '

> hv_retarget_msi_interrupt for the consistent name convention, also

Nit: s/name/naming

> mirroring the name in TLFS.
> 
> [1]: https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> 
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h  | 31 ++++++++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv.c | 34 ++---------------------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 739bd89226a5..4a76e442481a 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -911,4 +911,35 @@ struct hv_tlb_flush_ex {
>  struct hv_partition_assist_pg {
>  	u32 tlb_lock_count;
>  };
> +
> +struct hv_interrupt_entry {
> +	u32 source;			/* 1 for MSI(-X) */
> +	u32 reserved1;
> +	u32 address;
> +	u32 data;
> +} __packed;

Why have you added __packed here? There is no mention of this change in the
commit log? Is it needed?

> +
> +/*
> + * flags for hv_device_interrupt_target.flags
> + */
> +#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> +#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> +
> +struct hv_device_interrupt_target {
> +	u32 vector;
> +	u32 flags;
> +	union {
> +		u64 vp_mask;
> +		struct hv_vpset vp_set;
> +	};
> +} __packed;

Same here.

> +
> +/* HvRetargetDeviceInterrupt hypercall */
> +struct hv_retarget_device_interrupt {
> +	u64 partition_id;

Why drop the 'self' comment?

> +	u64 device_id;
> +	struct hv_interrupt_entry int_entry;
> +	u64 reserved2;
> +	struct hv_device_interrupt_target int_target;
> +} __packed __aligned(8);
>  #endif
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index aacfcc90d929..0d9b74503577 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -406,36 +406,6 @@ struct pci_eject_response {
>  
>  static int pci_ring_size = (4 * PAGE_SIZE);
>  
> -struct hv_interrupt_entry {
> -	u32	source;			/* 1 for MSI(-X) */
> -	u32	reserved1;
> -	u32	address;
> -	u32	data;
> -};
> -
> -/*
> - * flags for hv_device_interrupt_target.flags
> - */
> -#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> -#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> -
> -struct hv_device_interrupt_target {
> -	u32	vector;
> -	u32	flags;
> -	union {
> -		u64		 vp_mask;
> -		struct hv_vpset vp_set;
> -	};
> -};
> -
> -struct retarget_msi_interrupt {
> -	u64	partition_id;		/* use "self" */
> -	u64	device_id;
> -	struct hv_interrupt_entry int_entry;
> -	u64	reserved2;
> -	struct hv_device_interrupt_target int_target;
> -} __packed __aligned(8);
> -
>  /*
>   * Driver specific state.
>   */
> @@ -482,7 +452,7 @@ struct hv_pcibus_device {
>  	struct workqueue_struct *wq;
>  
>  	/* hypercall arg, must not cross page boundary */
> -	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> +	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
>  
>  	/*
>  	 * Don't put anything here: retarget_msi_interrupt_params must be last
> @@ -1178,7 +1148,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
>  	struct irq_cfg *cfg = irqd_cfg(data);
> -	struct retarget_msi_interrupt *params;
> +	struct hv_retarget_device_interrupt *params;

pci-hyperv.c also makes use of retarget_msi_interrupt_lock - it's really clear
from this name what it protects, however your rename now makes this more
confusing.

Likewise there is a comment in hv_pci_probe that refers to
retarget_msi_interrupt_params which is now stale.

It may be helpful to rename hv_retarget_device_interrupt for consistency with
the docs - however please make sure you catch all the references - I'd suggest
that the move and the rename are in different patches.

Thanks,

Andrew Murray

>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	cpumask_var_t tmp;
> -- 
> 2.24.1
> 
