Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98D2B1F76
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMQCI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 11:02:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44905 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMQCI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 11:02:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id c17so10413113wrc.11;
        Fri, 13 Nov 2020 08:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOFgbtEKT08GIsaRlGdHEBhLrv7nMLKYi0Qeedgqdrw=;
        b=hIVRxdck4hge8b2rg+r15sgZkwLK1JfLNPaqRw+PbSLZUrka5E3cDMA0PkN7qYZJqx
         y5pkefxPSYgK7yMUP91GiCpAmjtGpC3EJwIRh0GxsQxSoWc26IlfObOqgivLVa90yNqC
         TLEAGdW0r1J60RvlEyk9S461PaNf1uMIf5QWOhr5J/xVd3DMafvv+EuTpQpjbUpLJ5hs
         W9dZxJalxbHGmRXGCpBU5OOdn4JOJzumWg1JF/BcfRFJPzTLlhPhYbGJpo3a5EygyxLo
         sS4pzNPa60w1OGBvuRzXt6yVoile6IUYtyx32Z3lJd+bjnOMU1CzQNqHFsJyJcFzrdNj
         8wrw==
X-Gm-Message-State: AOAM533tpHJbQTJ3fnAEVC38WBloGKpchHvt1jZOMccRoV2DjeDA9JRk
        sMAIDTA+ej1TVsJL7srK69k=
X-Google-Smtp-Source: ABdhPJxLGVaamLIC1LlMIWls9KiB13YFjHlZOHL4e1EkWFYtknKo5xd/tBWWvVBzADv1/VsEhGIP9w==
X-Received: by 2002:adf:ffc3:: with SMTP id x3mr4326029wrs.32.1605283320928;
        Fri, 13 Nov 2020 08:02:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s4sm11648636wro.10.2020.11.13.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:02:00 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:01:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 17/17] x86/hyperv: handle IO-APIC when running as root
Message-ID: <20201113160158.idndhuygfgenxyhm@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-18-wei.liu@kernel.org>
 <87v9eawm2e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9eawm2e.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 05:56:41PM +0100, Vitaly Kuznetsov wrote:
[...]
> > +static unsigned int hv_ioapic_startup_irq(struct irq_data *data)
> > +{
> > +	u16 status;
> > +	struct IO_APIC_route_entry ire;
> > +	u32 vector;
> > +	struct irq_cfg *cfg;
> > +	int ioapic;
> > +	u8 ioapic_pin;
> > +	int ioapic_id;
> > +	int gsi;
> > +	union entry_union eu;
> > +	struct cpumask *affinity;
> > +	int cpu, vcpu;
> > +	struct hv_interrupt_entry entry;
> > +	struct mp_chip_data *mp_data = data->chip_data;
> > +
> > +	gsi = data->irq;
> > +	cfg = irqd_cfg(data);
> > +	affinity = irq_data_get_effective_affinity_mask(data);
> > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> > +	vcpu = hv_cpu_number_to_vp_number(cpu);
> > +
> > +	vector = cfg->vector;
> > +
> > +	ioapic = mp_find_ioapic(gsi);
> > +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> > +	ioapic_id = mpc_ioapic_id(ioapic);
> > +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> > +
> > +	/*
> > +	 * Always try unmapping. We do not have visibility into which whether
> > +	 * an IO-APIC has been mapped or not. We can't use chip_data because it
> > +	 * already points to mp_data.
> > +	 *
> > +	 * We don't use retarget interrupt hypercalls here because Hyper-V
> > +	 * doens't allow root to change the vector or specify VPs outside of
> > +	 * the set that is initially used during mapping.
> > +	 */
> > +	status = hv_unmap_ioapic_interrupt(gsi);
> > +
> > +	if (!(status == HV_STATUS_SUCCESS || status == HV_STATUS_INVALID_PARAMETER)) {
> > +		pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> > +		return -1;
> 
> Nit: the function returns 'unsigned int' but I see other 'irq_startup'
> routines return negative values too, however, they tend to returd
> '-ESOMETHING' so maybe -EFAULT here?
> 

The return type should've been int instead. That's what the function
signature in struct irq_chip looks like.

> > +	}
> > +
> > +	status = hv_map_ioapic_interrupt(ioapic_id, ire.trigger, vcpu, vector, &entry);
> > +
> > +	if (status != HV_STATUS_SUCCESS) {
> > +		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
> > +		return -1;
> 
> and here.
> 

-EINVAL would be more appropriate in both cases.

Wei.

> > +	}
> > +
> > +	/* Update the entry in mp_chip_data. It is used in other places. */
> > +	mp_data->entry = *(struct IO_APIC_route_entry *)&entry.ioapic_rte;
> > +
> > +	/* Sync polarity -- Hyper-V's returned polarity is always 0... */
> > +	mp_data->entry.polarity = ire.polarity;
> > +
> > +	eu.w1 = entry.ioapic_rte.low_uint32;
> > +	eu.w2 = entry.ioapic_rte.high_uint32;
> > +	ioapic_write_entry(ioapic, ioapic_pin, eu.entry);
> > +
> > +	return 0;
> > +}
> > +
> > +static void hv_ioapic_mask_irq(struct irq_data *data)
> > +{
> > +	mask_ioapic_irq(data);
> > +}
> > +
> > +static void hv_ioapic_unmask_irq(struct irq_data *data)
> > +{
> > +	unmask_ioapic_irq(data);
> > +}
> > +
> > +static int hv_ioapic_set_affinity(struct irq_data *data,
> > +			       const struct cpumask *mask, bool force)
> > +{
> > +	/*
> > +	 * We only update the affinity mask here. Programming the hardware is
> > +	 * done in irq_startup.
> > +	 */
> > +	return ioapic_set_affinity(data, mask, force);
> > +}
> > +
> > +void hv_ioapic_ack_level(struct irq_data *irq_data)
> > +{
> > +	/*
> > +	 * Per email exchange with Hyper-V team, all is needed is write to
> > +	 * LAPIC's EOI register. They don't support directed EOI to IO-APIC.
> > +	 * Hyper-V handles it for us.
> > +	 */
> > +	apic_ack_irq(irq_data);
> > +}
> > +
> > +struct irq_chip hv_ioapic_chip __read_mostly = {
> > +	.name			= "HV-IO-APIC",
> > +	.irq_startup		= hv_ioapic_startup_irq,
> > +	.irq_mask		= hv_ioapic_mask_irq,
> > +	.irq_unmask		= hv_ioapic_unmask_irq,
> > +	.irq_ack		= irq_chip_ack_parent,
> > +	.irq_eoi		= hv_ioapic_ack_level,
> > +	.irq_set_affinity	= hv_ioapic_set_affinity,
> > +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> > +	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
> > +	.flags			= IRQCHIP_SKIP_SET_WAKE,
> > +};
> > +
> > +
> > +int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
> > +void (*native_acpi_unregister_gsi)(u32 gsi);
> > +
> > +int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> > +{
> > +	int irq = gsi;
> > +
> > +#ifdef CONFIG_X86_IO_APIC
> > +	irq = native_acpi_register_gsi(dev, gsi, trigger, polarity);
> > +	if (irq < 0) {
> > +		pr_err("native_acpi_register_gsi failed %d\n", irq);
> > +		return irq;
> > +	}
> > +
> > +	if (trigger) {
> > +		irq_set_status_flags(irq, IRQ_LEVEL);
> > +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> > +			handle_fasteoi_irq, "ioapic-fasteoi");
> > +	} else {
> > +		irq_clear_status_flags(irq, IRQ_LEVEL);
> > +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> > +			handle_edge_irq, "ioapic-edge");
> > +	}
> > +#endif
> > +	return irq;
> > +}
> > +
> > +void hv_acpi_unregister_gsi(u32 gsi)
> > +{
> > +#ifdef CONFIG_X86_IO_APIC
> > +	(void)hv_unmap_ioapic_interrupt(gsi);
> > +	native_acpi_unregister_gsi(gsi);
> > +#endif
> > +}
> 
> -- 
> Vitaly
> 
