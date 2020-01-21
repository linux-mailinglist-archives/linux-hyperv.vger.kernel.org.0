Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA514396F
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 10:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAUJZx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jan 2020 04:25:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727962AbgAUJZw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579598751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTWClkvRm84UsaK/GnS4LaoXz+1p5+iKBQeI9MLnG6A=;
        b=WtYQ4hrK83qcoGyyEhGptXJJm+o0nM3NSWs3RpBE6srYQjdtMN4SKxhrSuxu1RCW0azu+n
        Zr0YFqbCcf1KBZurIT+ezofkLbGDDP3402X1ZSkyJAddvR4htr7Mp/mNW3k9eq0jYGZf4E
        HIe/hF+khnR9hy6CnORjUxkWRDhd0k0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ca7DlTkdPqusxviANpg8wA-1; Tue, 21 Jan 2020 04:25:50 -0500
X-MC-Unique: ca7DlTkdPqusxviANpg8wA-1
Received: by mail-wm1-f72.google.com with SMTP id o24so250425wmh.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jan 2020 01:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yTWClkvRm84UsaK/GnS4LaoXz+1p5+iKBQeI9MLnG6A=;
        b=M9+jP6XpXlFDN718yvfRsPhJZ4X33mWNeq7wZQu63F+V8L3gngANDIjfSSamNViC7K
         pW4MwO2MOCAHJUb4Sg+Bbwx21/EnBn1kKmPNpvrIFmD8HMq0OGk//qqR4PpC/7nBZ00R
         PIY9JjHkUrNqVr8dWEJ9Fb95Px3hxJnPXqcM09Rea07MipANXy2fv8c5zFZFsQs8xe1u
         Rx066gSP3jIuXoaHMlgj5/fIWYIpJ3DkqnCvwG0YgHGO3BYIxorinJMrdgwDDGOAq3tF
         s8dIS0cAo+P8PBg0dZYEuNgUCNtAGaJvAIfL0t1IsPJtSk662dj7iJmc7OChx4+k/xkh
         47iQ==
X-Gm-Message-State: APjAAAXq6fWQ0jKgXJu03piIpIY8jTjjs5OV+eU1ypRW8XHucGHQcqhI
        BEpfzJjuoK2uv1W77cClFf/mGc87pGwZOzoEpj7uxl+Cldxt7YzxSLmB96MnBwWL7UaE+RZKdV7
        h8vM4PRWtx2wXOv/XryPdA63e
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr3469026wmg.161.1579598749666;
        Tue, 21 Jan 2020 01:25:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwntllOcXBc5ZbJO2Sw42hDG7IYCOlW+56XpA6R4RYZb3Npr2xPu9XRyD+bLAu6RHPhX+isXQ==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr3469002wmg.161.1579598749442;
        Tue, 21 Jan 2020 01:25:49 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x10sm50834685wrp.58.2020.01.21.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:25:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list\:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: hyperv: Move retarget related struct definitions into tlfs
In-Reply-To: <20200121015713.69691-2-boqun.feng@gmail.com>
References: <20200121015713.69691-1-boqun.feng@gmail.com> <20200121015713.69691-2-boqun.feng@gmail.com>
Date:   Tue, 21 Jan 2020 10:25:47 +0100
Message-ID: <87blqxf9es.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:

> For future support of virtual PCI on non-x86 architecture.
>
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h  | 38 +++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  8 ++++++
>  drivers/pci/controller/pci-hyperv.c | 38 +++--------------------------
>  3 files changed, 50 insertions(+), 34 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index b9ebc20b2385..debe017ae748 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -912,4 +912,42 @@ struct hv_tlb_flush_ex {
>  struct hv_partition_assist_pg {
>  	u32 tlb_lock_count;
>  };
> +
> +union hv_msi_entry {
> +	u64 as_uint64;
> +	struct {
> +		u32 address;
> +		u32 data;
> +	} __packed;
> +};

While Hyper-V code is full of this, I was once told that 'Union aliasing
is UB. Avoid it for good.' Maybe we should start getting rid of it
instead of adding more?

> +
> +struct hv_interrupt_entry {
> +	u32 source;			/* 1 for MSI(-X) */
> +	u32 reserved1;
> +	union hv_msi_entry msi_entry;
> +} __packed;
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
> +
> +/* HvRetargetDeviceInterrupt hypercall */
> +struct hv_retarget_device_interrupt {
> +	u64 partition_id;
> +	u64 device_id;
> +	struct hv_interrupt_entry int_entry;
> +	u64 reserved2;
> +	struct hv_device_interrupt_target int_target;
> +} __packed __aligned(8);
>  #endif
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 6b79515abb82..d13319d82f6b 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -240,6 +240,14 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> +#if IS_ENABLED(CONFIG_PCI_HYPERV)
> +#define hv_set_msi_address_from_desc(msi_entry, msi_desc)	\
> +do {								\
> +	(msi_entry)->address = (msi_desc)->msg.address_lo;	\
> +} while (0)
> +
> +#endif /* CONFIG_PCI_HYPERV */

It seems to be pointless to put defines under #if IS_ENABLED(): in case
it is not enabled and used you'll get a compilation error, in case it is
enabled and not used no code is going to be generated anyways.

> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index aacfcc90d929..2240f2b3643e 100644
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
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
>  	cpumask_var_t tmp;
> @@ -1200,8 +1170,8 @@ static void hv_irq_unmask(struct irq_data *data)
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id = HV_PARTITION_ID_SELF;
>  	params->int_entry.source = 1; /* MSI(-X) */
> -	params->int_entry.address = msi_desc->msg.address_lo;
> -	params->int_entry.data = msi_desc->msg.data;
> +	hv_set_msi_address_from_desc(&params->int_entry.msi_entry, msi_desc);

I don't quite see why this hv_set_msi_address_from_desc() is needed at
all.

> +	params->int_entry.msi_entry.data = msi_desc->msg.data;
>  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |

-- 
Vitaly

