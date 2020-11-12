Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242C62B0ACD
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 17:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKLQ4z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 11:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbgKLQ4w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 11:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605200210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYP9Gq+ts7pzjErccComK+H3r9U6J/KV+gx7+NzTNxw=;
        b=LHVv5fNsPFT48crBfIrlgDW2BYtA3E/8Rk7HdzpBgy98HtklXwZRugAy7YHzkc0GL7TBmw
        MUt+hy9in+E3D/U/sNGp8nVQHnGKKcF6tdL2eFv0LHcTrXEZj/+vNdmKwgRNZ3FvZWTehq
        rN1niKl6mleppgFx3zsk6r0AGYt+LbQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-WZwRF_QjOd6dEmjo0Aajog-1; Thu, 12 Nov 2020 11:56:45 -0500
X-MC-Unique: WZwRF_QjOd6dEmjo0Aajog-1
Received: by mail-wr1-f72.google.com with SMTP id y2so2220467wrl.3
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 08:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wYP9Gq+ts7pzjErccComK+H3r9U6J/KV+gx7+NzTNxw=;
        b=OVTQxMymzYtum5m8cd2k41f+PplysKs2gWMDU/MqkyX4J1dthrS8Vq2+CWTuN7Xbvk
         ygxqrixXltOAzm4idG2BjNyg21+TGOU7bwHF7MUjcAA8g8WtlO1NfzuTytGhayQtCv/E
         88k3rSJzjSW2zM+CPDYtEd80gn4Uq+l69TD/lLrbp1w4xymScebNbXHdW7OI/X2u1wnm
         mwqWIA6GLALCijCpUvyRR5sqlc8mE4TF+1p4FORUQzGnkLIkY8ThnPSmNqUCBSKemK/P
         VsAmK++8Vxlv0D+RGFRh8MAQDxmSQyICYEeGhAg23bt21Q0UY6yx+tur4crbJLuuIIoA
         7Y8w==
X-Gm-Message-State: AOAM531/FQPSbZZiolLdnuoZ7+AOquQfFpr7cOh8KTSGjgLf5t2oEiZ6
        vxCdD7WQYmzGg92WxyMBmSHp2HRu0arbmftitB34R6r7eWjR5guVmDVgR+QPcCzqnS3+2ACKtcx
        Z44MNf7yqC9kAmxVvifAq9t5m
X-Received: by 2002:adf:c443:: with SMTP id a3mr510015wrg.249.1605200203903;
        Thu, 12 Nov 2020 08:56:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6zhpK0qox59X6e8JQyr5bppOI0Wy0lYHwipyzYIWWWvgR2UM9kbCVk5xgd/kpNhNWxHp2QQ==
X-Received: by 2002:adf:c443:: with SMTP id a3mr509971wrg.249.1605200203625;
        Thu, 12 Nov 2020 08:56:43 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g131sm7418395wma.35.2020.11.12.08.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:56:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 17/17] x86/hyperv: handle IO-APIC when running as root
In-Reply-To: <20201105165814.29233-18-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-18-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 17:56:41 +0100
Message-ID: <87v9eawm2e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ chip
> to handle mapping and unmapping of IO-APIC interrupts.
>
> Use custom functions for mapping and unmapping ACPI GSIs. They will
> issue Microsoft Hypervisor specific hypercalls on top of the native
> routines.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c   |  13 +++
>  arch/x86/hyperv/irqdomain.c | 226 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a46b817b5b2a..2c2189832da7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -267,10 +267,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	return 0;
>  }
>  
> +int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity);
> +void hv_acpi_unregister_gsi(u32 gsi);
> +
> +extern int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
> +extern void (*native_acpi_unregister_gsi)(u32 gsi);
> +
>  static int __init hv_pci_init(void)
>  {
>  	int gen2vm = efi_enabled(EFI_BOOT);
>  
> +	if (hv_root_partition) {
> +		native_acpi_register_gsi = __acpi_register_gsi;
> +		native_acpi_unregister_gsi = __acpi_unregister_gsi;
> +		__acpi_register_gsi = hv_acpi_register_gsi;
> +		__acpi_unregister_gsi = hv_acpi_unregister_gsi;
> +	}
> +
>  	/*
>  	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
>  	 * The purpose is to suppress the harmless warning:
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 80109e3cbf8f..ae9a728589a4 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -9,6 +9,8 @@
>  #include <linux/pci.h>
>  #include <linux/irq.h>
>  #include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +#include <asm/io_apic.h>
>  
>  struct rid_data {
>  	struct pci_dev *bridge;
> @@ -328,3 +330,227 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
>  	return d;
>  }
>  
> +/* Copied from io_apic.c */
> +union entry_union {
> +	struct { u32 w1, w2; };
> +	struct IO_APIC_route_entry entry;
> +};
> +
> +static int hv_unmap_ioapic_interrupt(int gsi)
> +{
> +	union hv_device_id device_id;
> +	int ioapic, ioapic_id;
> +	u8 ioapic_pin;
> +	struct IO_APIC_route_entry ire;
> +	union entry_union eu;
> +	struct hv_interrupt_entry entry;
> +
> +	ioapic = mp_find_ioapic(gsi);
> +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> +	ioapic_id = mpc_ioapic_id(ioapic);
> +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> +
> +	eu.entry = ire;
> +
> +	/*
> +	 * Polarity may have been set by us, but Hyper-V expects the exact same
> +	 * entry. See the mapping routine.
> +	 */
> +	eu.entry.polarity = 0;
> +
> +	memset(&entry, 0, sizeof(entry));
> +	entry.source = HV_INTERRUPT_SOURCE_IOAPIC;
> +	entry.ioapic_rte.low_uint32 = eu.w1;
> +	entry.ioapic_rte.high_uint32 = eu.w2;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	return hv_unmap_interrupt(device_id.as_uint64, &entry) & HV_HYPERCALL_RESULT_MASK;
> +}
> +
> +static int hv_map_ioapic_interrupt(int ioapic_id, int trigger, int vcpu, int vector,
> +		struct hv_interrupt_entry *out_entry)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_device_interrupt *input;
> +	struct hv_output_map_device_interrupt *output;
> +	union hv_device_id device_id;
> +	struct hv_device_interrupt_descriptor *intr_desc;
> +	u16 status;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	intr_desc = &input->interrupt_descriptor;
> +	input->partition_id = hv_current_partition_id;
> +	input->device_id = device_id.as_uint64;
> +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> +	intr_desc->target.vector = vector;
> +	intr_desc->vector_count = 1;
> +
> +	if (trigger)
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> +	else
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +
> +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	*out_entry = output->interrupt_entry;
> +
> +	return status;
> +}
> +
> +static unsigned int hv_ioapic_startup_irq(struct irq_data *data)
> +{
> +	u16 status;
> +	struct IO_APIC_route_entry ire;
> +	u32 vector;
> +	struct irq_cfg *cfg;
> +	int ioapic;
> +	u8 ioapic_pin;
> +	int ioapic_id;
> +	int gsi;
> +	union entry_union eu;
> +	struct cpumask *affinity;
> +	int cpu, vcpu;
> +	struct hv_interrupt_entry entry;
> +	struct mp_chip_data *mp_data = data->chip_data;
> +
> +	gsi = data->irq;
> +	cfg = irqd_cfg(data);
> +	affinity = irq_data_get_effective_affinity_mask(data);
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> +	vcpu = hv_cpu_number_to_vp_number(cpu);
> +
> +	vector = cfg->vector;
> +
> +	ioapic = mp_find_ioapic(gsi);
> +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> +	ioapic_id = mpc_ioapic_id(ioapic);
> +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> +
> +	/*
> +	 * Always try unmapping. We do not have visibility into which whether
> +	 * an IO-APIC has been mapped or not. We can't use chip_data because it
> +	 * already points to mp_data.
> +	 *
> +	 * We don't use retarget interrupt hypercalls here because Hyper-V
> +	 * doens't allow root to change the vector or specify VPs outside of
> +	 * the set that is initially used during mapping.
> +	 */
> +	status = hv_unmap_ioapic_interrupt(gsi);
> +
> +	if (!(status == HV_STATUS_SUCCESS || status == HV_STATUS_INVALID_PARAMETER)) {
> +		pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> +		return -1;

Nit: the function returns 'unsigned int' but I see other 'irq_startup'
routines return negative values too, however, they tend to returd
'-ESOMETHING' so maybe -EFAULT here?

> +	}
> +
> +	status = hv_map_ioapic_interrupt(ioapic_id, ire.trigger, vcpu, vector, &entry);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
> +		return -1;

and here.

> +	}
> +
> +	/* Update the entry in mp_chip_data. It is used in other places. */
> +	mp_data->entry = *(struct IO_APIC_route_entry *)&entry.ioapic_rte;
> +
> +	/* Sync polarity -- Hyper-V's returned polarity is always 0... */
> +	mp_data->entry.polarity = ire.polarity;
> +
> +	eu.w1 = entry.ioapic_rte.low_uint32;
> +	eu.w2 = entry.ioapic_rte.high_uint32;
> +	ioapic_write_entry(ioapic, ioapic_pin, eu.entry);
> +
> +	return 0;
> +}
> +
> +static void hv_ioapic_mask_irq(struct irq_data *data)
> +{
> +	mask_ioapic_irq(data);
> +}
> +
> +static void hv_ioapic_unmask_irq(struct irq_data *data)
> +{
> +	unmask_ioapic_irq(data);
> +}
> +
> +static int hv_ioapic_set_affinity(struct irq_data *data,
> +			       const struct cpumask *mask, bool force)
> +{
> +	/*
> +	 * We only update the affinity mask here. Programming the hardware is
> +	 * done in irq_startup.
> +	 */
> +	return ioapic_set_affinity(data, mask, force);
> +}
> +
> +void hv_ioapic_ack_level(struct irq_data *irq_data)
> +{
> +	/*
> +	 * Per email exchange with Hyper-V team, all is needed is write to
> +	 * LAPIC's EOI register. They don't support directed EOI to IO-APIC.
> +	 * Hyper-V handles it for us.
> +	 */
> +	apic_ack_irq(irq_data);
> +}
> +
> +struct irq_chip hv_ioapic_chip __read_mostly = {
> +	.name			= "HV-IO-APIC",
> +	.irq_startup		= hv_ioapic_startup_irq,
> +	.irq_mask		= hv_ioapic_mask_irq,
> +	.irq_unmask		= hv_ioapic_unmask_irq,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_eoi		= hv_ioapic_ack_level,
> +	.irq_set_affinity	= hv_ioapic_set_affinity,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +
> +int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
> +void (*native_acpi_unregister_gsi)(u32 gsi);
> +
> +int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> +{
> +	int irq = gsi;
> +
> +#ifdef CONFIG_X86_IO_APIC
> +	irq = native_acpi_register_gsi(dev, gsi, trigger, polarity);
> +	if (irq < 0) {
> +		pr_err("native_acpi_register_gsi failed %d\n", irq);
> +		return irq;
> +	}
> +
> +	if (trigger) {
> +		irq_set_status_flags(irq, IRQ_LEVEL);
> +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> +			handle_fasteoi_irq, "ioapic-fasteoi");
> +	} else {
> +		irq_clear_status_flags(irq, IRQ_LEVEL);
> +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> +			handle_edge_irq, "ioapic-edge");
> +	}
> +#endif
> +	return irq;
> +}
> +
> +void hv_acpi_unregister_gsi(u32 gsi)
> +{
> +#ifdef CONFIG_X86_IO_APIC
> +	(void)hv_unmap_ioapic_interrupt(gsi);
> +	native_acpi_unregister_gsi(gsi);
> +#endif
> +}

-- 
Vitaly

