Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC22B040A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKLLjj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 06:39:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgKLLjY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 06:39:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id c9so4968142wml.5;
        Thu, 12 Nov 2020 03:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=45n7xKh26/OR+rOZOpQ+07FrCUP74O0sa9y+l1HjZvA=;
        b=P8bDkqxa62qekBaYn2ccAX3bqupwxA0yDbomxUK3Z/2jqyFzbqPR3VuJwl3aBB8NBc
         T22GqedvuOzTkgYPhBLNzk3m6QKk57S6eZi0X5DnjE9b7rCBqloQsZ33eMRMFnqhOncQ
         tCh0MdNbqIG7UauMrkzTAmqOWYwpjbiO/zm98BrzTacVzXg0I0STJIhqcHrpJKmStGXS
         sPlL5LUs9yrNCqjrM5s/raXgHwm1Ft9Ng8lJ4Ldk/+QM3XWizCW+4YuO+z8Stg6BElau
         uZtKXqQn3OYQaEKUSI5/eCvrszZl1kff69FtbNST9l2RzAKKBUlYK7MWFimfCbxxu0N3
         WR7g==
X-Gm-Message-State: AOAM531lKJaXHy02h3qnqN8uWDrXPismOmlwyzQAq6NqcxHMhU+5oLaX
        MKFoOzsLl6O6ze46VnXkmO8NdRDNkFk=
X-Google-Smtp-Source: ABdhPJyqaCfapUIaPMbBhSP70YkW085L5IyJY1kq/4EGR1UOSuPvQJ57IS0cMUYrrPjucLHoQ/ZXiA==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr8820571wmj.125.1605181161896;
        Thu, 12 Nov 2020 03:39:21 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y10sm6471223wru.94.2020.11.12.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:39:21 -0800 (PST)
Date:   Thu, 12 Nov 2020 11:39:19 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
Message-ID: <20201112113919.rfjwzauro5nk65ju@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-17-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105165814.29233-17-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 05, 2020 at 04:58:13PM +0000, Wei Liu wrote:
> We are about to implement an irqchip for IO-APIC when Linux runs as root
> on Microsoft Hypervisor. At the same time we would like to reuse
> existing code as much as possible.
> 
> Move mp_chip_data to io_apic.h and make a few helper functions
> non-static.
> 
> No functional change.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

x86 maintainers, any comment on this patch?

This is the only patch in this series that's not MSHV specific.

Wei.

> ---
>  arch/x86/include/asm/io_apic.h | 21 +++++++++++++++++++++
>  arch/x86/kernel/apic/io_apic.c | 28 +++++++++-------------------
>  2 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
> index a1a26f6d3aa4..1375983a6028 100644
> --- a/arch/x86/include/asm/io_apic.h
> +++ b/arch/x86/include/asm/io_apic.h
> @@ -152,6 +152,15 @@ extern unsigned long io_apic_irqs;
>  #define io_apic_assign_pci_irqs \
>  	(mp_irq_entries && !skip_ioapic_setup && io_apic_irqs)
>  
> +struct mp_chip_data {
> +	struct list_head irq_2_pin;
> +	struct IO_APIC_route_entry entry;
> +	int trigger;
> +	int polarity;
> +	u32 count;
> +	bool isa_irq;
> +};
> +
>  struct irq_cfg;
>  extern void ioapic_insert_resources(void);
>  extern int arch_early_ioapic_init(void);
> @@ -195,6 +204,18 @@ extern void clear_IO_APIC(void);
>  extern void restore_boot_irq_mode(void);
>  extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
>  extern void print_IO_APICs(void);
> +
> +struct irq_data;
> +extern struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin);
> +extern void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e);
> +extern void mask_ioapic_irq(struct irq_data *irq_data);
> +extern void unmask_ioapic_irq(struct irq_data *irq_data);
> +extern int ioapic_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force);
> +extern struct irq_domain *mp_ioapic_irqdomain(int ioapic);
> +enum irqchip_irq_state;
> +extern int ioapic_irq_get_chip_state(struct irq_data *irqd,
> +				enum irqchip_irq_state which,
> +				bool *state);
>  #else  /* !CONFIG_X86_IO_APIC */
>  
>  #define IO_APIC_IRQ(x)		0
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 7b3c7e0d4a09..23047f98b5e4 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -88,15 +88,6 @@ struct irq_pin_list {
>  	int apic, pin;
>  };
>  
> -struct mp_chip_data {
> -	struct list_head irq_2_pin;
> -	struct IO_APIC_route_entry entry;
> -	int trigger;
> -	int polarity;
> -	u32 count;
> -	bool isa_irq;
> -};
> -
>  struct mp_ioapic_gsi {
>  	u32 gsi_base;
>  	u32 gsi_end;
> @@ -154,7 +145,7 @@ static inline bool mp_is_legacy_irq(int irq)
>  	return irq >= 0 && irq < nr_legacy_irqs();
>  }
>  
> -static inline struct irq_domain *mp_ioapic_irqdomain(int ioapic)
> +struct irq_domain *mp_ioapic_irqdomain(int ioapic)
>  {
>  	return ioapics[ioapic].irqdomain;
>  }
> @@ -301,7 +292,7 @@ static struct IO_APIC_route_entry __ioapic_read_entry(int apic, int pin)
>  	return eu.entry;
>  }
>  
> -static struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
> +struct IO_APIC_route_entry ioapic_read_entry(int apic, int pin)
>  {
>  	union entry_union eu;
>  	unsigned long flags;
> @@ -328,7 +319,7 @@ static void __ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e
>  	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
>  }
>  
> -static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
> +void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_entry e)
>  {
>  	unsigned long flags;
>  
> @@ -453,7 +444,7 @@ static void io_apic_sync(struct irq_pin_list *entry)
>  	readl(&io_apic->data);
>  }
>  
> -static void mask_ioapic_irq(struct irq_data *irq_data)
> +void mask_ioapic_irq(struct irq_data *irq_data)
>  {
>  	struct mp_chip_data *data = irq_data->chip_data;
>  	unsigned long flags;
> @@ -468,7 +459,7 @@ static void __unmask_ioapic(struct mp_chip_data *data)
>  	io_apic_modify_irq(data, ~IO_APIC_REDIR_MASKED, 0, NULL);
>  }
>  
> -static void unmask_ioapic_irq(struct irq_data *irq_data)
> +void unmask_ioapic_irq(struct irq_data *irq_data)
>  {
>  	struct mp_chip_data *data = irq_data->chip_data;
>  	unsigned long flags;
> @@ -1868,8 +1859,7 @@ static void ioapic_configure_entry(struct irq_data *irqd)
>  		__ioapic_write_entry(entry->apic, entry->pin, mpd->entry);
>  }
>  
> -static int ioapic_set_affinity(struct irq_data *irq_data,
> -			       const struct cpumask *mask, bool force)
> +int ioapic_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
>  {
>  	struct irq_data *parent = irq_data->parent_data;
>  	unsigned long flags;
> @@ -1898,9 +1888,9 @@ static int ioapic_set_affinity(struct irq_data *irq_data,
>   *
>   * Verify that the corresponding Remote-IRR bits are clear.
>   */
> -static int ioapic_irq_get_chip_state(struct irq_data *irqd,
> -				   enum irqchip_irq_state which,
> -				   bool *state)
> +int ioapic_irq_get_chip_state(struct irq_data *irqd,
> +				enum irqchip_irq_state which,
> +				bool *state)
>  {
>  	struct mp_chip_data *mcd = irqd->chip_data;
>  	struct IO_APIC_route_entry rentry;
> -- 
> 2.20.1
> 
