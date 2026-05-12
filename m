Return-Path: <linux-hyperv+bounces-10799-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLTQJwXzAmo9zAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10799-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 11:29:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F90D51DB87
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1DEF30237FD
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5483A6EEF;
	Tue, 12 May 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z06KNnyL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C034968EF;
	Tue, 12 May 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578165; cv=none; b=F4UArwt4U51rR7lMAcKxQ+upSYu7tIicuyEVQt6yONxygHccc90XJUil5mZqvcH4PVgwYphI3dszQAChJJMVbzWdIdnzGXXUzksssNG8RifqXh2HAIhZTRUoAh++magg94ZhOut7tzfvaWWEnnbwuX44iAL9LyaIcB92P7LzqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578165; c=relaxed/simple;
	bh=UedU/ADpo+6Nda3wWDKjp8RRbP27seMizuQRikelBfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5hDIxDKM/EYsckFMT9UbWY1R0DIkSmogGrP1Sd3Mz7nTvQQp4KSg97ZdCbK1ECIxD+A1WKK8PAvFpUBPvfGvZbS2yme5OPSxsTHHQHw+VMq/By+ULUjveKMBA6vIqkxHuzPX0NuNKO6gv/1kBgKRwef23KUK1SFfhZX7FMYJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Z06KNnyL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id CBF3220B7167; Tue, 12 May 2026 02:29:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBF3220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778578155;
	bh=d0HSDQiu/+ZSH+To71bXYepZSX04JlsMG9XoPwkGYHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z06KNnyLHZeSjz8C/8rsYHKk0OiHcPVJSr0gS0WDQM3yQhpQWcX/JfaWr3XqFl4lH
	 fRRzAYsHc07ImVoNI8Svw97syLC3AgyIsxfdfqT3bHsVkGmrmKwLnZWPmGpKhCjd/q
	 ybTU0U53H5uDE5DpluPd04ldHjQaTDF3rUO2zBaM=
Date: Tue, 12 May 2026 02:29:15 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH V1 2/3] hyperv: Implement irq remap for passthru devices
Message-ID: <agLy6zLJ0gRBR2nM@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
 <20260512021242.1679786-3-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512021242.1679786-3-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: 7F90D51DB87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10799-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schakrabarti@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:12:41PM -0700, Mukesh R wrote:
> Implement interrupt remapping for direct attached and domain attached
> devices on Hyper-V.
> 
> Please note there are few constraints when it comes to mapping device
> interrupts on Hyper-V. For example, the hypervisor will not allow mapping
> device interrupts to root if the device is a direct attached device. Since
> the target guest cpu and vector info is not available during the initial
> VFIO irq setup, we work around by skipping this initial map. Then later
> during irqbypass trigger, when both guest target cpu vector are available,
> we do the map in the hypervisor, update the device, and enable the
> interrupt vector on the device. Rather than special case direct attached,
> we do same for domain attached also. This implies irqbypass is required
> for MSHV pci device passthru. Also noteworthy is that the hypervisor
> will automatically setup any direct hw injection like posted interrupts.
> 
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c         |  18 +-
>  drivers/hv/mshv_eventfd.c           | 423 +++++++++++++++++++++++++++-
>  drivers/iommu/hyperv-iommu-root.c   |  14 +
>  drivers/pci/controller/pci-hyperv.c |  10 +
>  include/asm-generic/mshyperv.h      |   3 +
>  5 files changed, 464 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 8780573a4332..02f9a889c014 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -197,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
>  
>  	msidesc = irq_data_get_msi_desc(data);
>  	pdev = msi_desc_to_pci_dev(msidesc);
> -	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
>  	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>  
>  	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
> @@ -233,6 +233,20 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		return;
>  	}
>  
> +	/*
> +	 * For direct attached devices, we cannot map interrupts in the
> +	 * hypervisor because it will not allow it until we have guest target
> +	 * vcpu and vector. So defer it until irqbypass. Also, do the same
> +	 * for domain attached devices for simplicity.
> +	 */
> +	if (hv_pcidev_is_pthru_dev(pdev)) {
> +		if (data->chip_data)
> +			entry_to_msi_msg(data->chip_data, msg);
> +		else
> +			memset(msg, 0, sizeof(struct msi_msg));
> +		return;
> +	}
> +
>  	if (data->chip_data) {
>  		/*
>  		 * This interrupt is already mapped. Let's unmap first.
> @@ -272,7 +286,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>  {
>  	union hv_device_id hv_devid;
>  
> -	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
> +	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
>  	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
>  }
>  
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 90959f639dc3..1f5c1e9ee9b7 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -7,7 +7,6 @@
>   *
>   * All credits to kvm developers.
>   */
> -
>  #include <linux/syscalls.h>
>  #include <linux/wait.h>
>  #include <linux/poll.h>
> @@ -15,7 +14,8 @@
>  #include <linux/list.h>
>  #include <linux/workqueue.h>
>  #include <linux/eventfd.h>
> -
> +#include <linux/pci.h>
> +#include <linux/vfio_pci_core.h>
>  #if IS_ENABLED(CONFIG_X86_64)
>  #include <asm/apic.h>
>  #endif
> @@ -27,6 +27,377 @@
>  
>  static struct workqueue_struct *irqfd_cleanup_wq;
>  
> +#if IS_ENABLED(CONFIG_X86_64)
> +
> +static int mshv_parse_mshv_irqfd(struct mshv_irqfd *irqfd,
> +				 struct pci_dev **out_pdev,
> +				 struct irq_data **out_irqdata)
> +{
> +	struct irq_bypass_producer *prod;
> +	struct msi_desc *msidesc;
> +	struct irq_data *irqdata;
> +
> +	if (irqfd == NULL || irqfd->irqfd_bypass_prod == NULL)
> +		return -ENODEV;
> +
> +	prod = irqfd->irqfd_bypass_prod;
> +
> +	irqdata = irq_get_irq_data(prod->irq);
> +	if (irqdata == NULL) {
> +		pr_err("Hyper-V: irqbypass fail, no irqdata. irq:0x%x\n",
> +		       prod->irq);
> +		return -EINVAL;
> +	}
> +	*out_irqdata = irqdata;
> +
> +	msidesc = irq_data_get_msi_desc(irqdata);
> +	if (msidesc == NULL) {
> +		pr_err("Hyper-V: irqbypass msi fail. irq:0x%x\n", prod->irq);
> +		return -EINVAL;
> +	}
> +
> +	*out_pdev = msi_desc_to_pci_dev(msidesc);
> +	if (*out_pdev == NULL) {
> +		pr_err("Hyper-V: mshv_irqfd parse fail. irq:0x%x\n", prod->irq);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Must be called with interrupts disabled */
> +static int hv_vpset_from_hyp_disabled(
> +			struct hv_input_get_vp_set_from_mda *input,
> +			union hv_output_get_vp_set_from_mda *output,
> +			struct mshv_lapic_irq *lapic_irq, u64 partid)
> +{
> +	u64 status;
> +
> +	memset(input, 0, sizeof(*input));
> +	input->target_partid = partid;
> +	input->dest_address = lapic_irq->lapic_apic_id;
> +	input->input_vtl = 0;
> +	input->destmode_logical = lapic_irq->lapic_control.logical_dest_mode;
> +
> +	status = hv_do_hypercall(HVCALL_GET_VPSET_FROM_MDA, input, output);
> +	if (!hv_result_success(status)) {
> +		hv_status_err(status, "apicid:0x%llx dest:0x%x\n",
> +			      lapic_irq->lapic_apic_id,
> +			      lapic_irq->lapic_control.logical_dest_mode);
> +	}
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +/* Returns number of banks copied, -errno in case of error */
> +static int hv_copy_vpset(struct hv_vpset *dest, struct hv_vpset *src)
> +{
> +	u64 bank_mask;
> +	int banks, tot_banks = hv_max_vp_index / HV_VCPUS_PER_SPARSE_BANK;
> +
> +	if (tot_banks >= HV_MAX_SPARSE_VCPU_BANKS)
> +		return -EINVAL;
> +
> +	dest->format = src->format;
> +	dest->valid_bank_mask = src->valid_bank_mask;
> +	bank_mask = src->valid_bank_mask;
> +	for (banks = 0; banks <= tot_banks; banks++) {
> +		if (bank_mask == 0)
> +			break;
> +
> +		if (bank_mask & 1)
> +			dest->bank_contents[banks] = src->bank_contents[banks];
> +		bank_mask = bank_mask >> 1;
> +	}
> +
> +	return banks;
> +}
> +
> +static int mshv_map_device_interrupt(u64 ptid, union hv_device_id hv_devid,
> +				     struct mshv_lapic_irq *ginfo,
> +				     struct hv_interrupt_entry *ret_entry,
> +				     u64 *ret_status)
> +{
> +	struct hv_input_map_device_interrupt *irq_input;
> +	struct hv_output_map_device_interrupt *irq_output;
> +	struct hv_device_interrupt_descriptor *intdesc;
> +	struct hv_input_get_vp_set_from_mda *mda_input;
> +	union hv_output_get_vp_set_from_mda *mda_output;
> +	ulong flags;
> +	u64 status;
> +	int rc, var_size;
> +
> +	*ret_status = U64_MAX;
> +	local_irq_save(flags);
> +
> +	mda_input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	mda_output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	/*
> +	 * Map Device Interrupt hcall needs vp set based on vp indexes used
> +	 * during vp creation. Here we have lapic-id of the vp only. Easiest
> +	 * is to just ask the hypervisor for the vp set matching the lapic-id.
> +	 */
> +	rc = hv_vpset_from_hyp_disabled(mda_input, mda_output, ginfo, ptid);
> +	if (rc)
> +		goto out;	/* error already printed */
> +
> +	irq_input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	irq_output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(irq_input, 0, sizeof(*irq_input));
> +
> +	irq_input->partition_id = ptid;
> +	irq_input->device_id = hv_devid.as_uint64;
> +
> +	intdesc = &irq_input->interrupt_descriptor;
> +	intdesc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> +	intdesc->vector_count = 1;
> +	intdesc->target.vector = ginfo->lapic_vector;
> +	intdesc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +
> +	intdesc->target.vp_set.valid_bank_mask = 0;
> +	intdesc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> +	intdesc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> +	rc = hv_copy_vpset(&intdesc->target.vp_set, &mda_output->target_vpset);
> +	if (rc <= 0) {
> +		pr_err("Hyper-V: ptid %lld - (irq)vpset copy failed (%d)\n",
> +		       ptid, rc);
> +		goto out;
> +	}
> +
> +	/*
> +	 * var-sized hcall: var-size starts after vp_mask (thus vp_set.format
> +	 * does not count, but vp_set.valid_bank_mask does).
> +	 */
> +	var_size = rc + 1;
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, var_size,
> +				     irq_input, irq_output);
> +	*ret_entry = irq_output->interrupt_entry;
> +	local_irq_restore(flags);
> +
> +	rc = 0;
> +	if (!hv_result_success(status)) {
> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
> +			hv_status_err(status, "pt:%lld vec:%d lapic-id:%lld\n",
> +			      ptid, ginfo->lapic_vector, ginfo->lapic_apic_id);
> +		*ret_status = status;
> +		rc = hv_result_to_errno(status);
> +	}
> +
> +	return rc;
> +
> +out:
> +	local_irq_restore(flags);
> +	return rc;
> +
> +}
> +
> +static int mshv_unmap_device_interrupt(union hv_device_id hv_devid,
> +				       struct hv_interrupt_entry *irq_entry)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_device_interrupt *input;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(input, 0, sizeof(*input));
> +
> +	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL)
> +		input->partition_id = hv_get_current_partid();
> +	else
> +		input->partition_id = hv_current_partition_id;
> +
> +	input->device_id = hv_devid.as_uint64;
> +	input->interrupt_entry = *irq_entry;
> +
> +	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int mshv_chk_unmap_irq(union hv_device_id hv_devid,
> +			      struct irq_data *irqdata)
> +{
> +	int rc;
> +
> +	if (irqdata->chip_data == NULL)
> +		return 0;
> +
> +	rc = mshv_unmap_device_interrupt(hv_devid, irqdata->chip_data);
> +	if (rc)
> +		return rc;
> +
> +	kfree(irqdata->chip_data);
> +	irqdata->chip_data = NULL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Synchronize device update with VFIO.
> + *    See: vfio_pci_memory_lock_and_enable()
> + */
> +static u16 mshv_pci_memory_lock_and_enable(struct vfio_pci_core_device *cdev)
> +{
> +	u16 cmd;
> +
> +	down_write(&cdev->memory_lock);
> +	pci_read_config_word(cdev->pdev, PCI_COMMAND, &cmd);
> +	if (!(cmd & PCI_COMMAND_MEMORY))
> +		pci_write_config_word(cdev->pdev, PCI_COMMAND,
> +				      cmd | PCI_COMMAND_MEMORY);
> +	return cmd;
> +}
> +
> +static void mshv_pci_memory_unlock_and_restore(
> +					struct vfio_pci_core_device *cdev,
> +					u16 cmd)
> +{
> +	pci_write_config_word(cdev->pdev, PCI_COMMAND, cmd);
> +	up_write(&cdev->memory_lock);
> +}
> +
> +static void mshv_make_device_usable(struct pci_dev *pdev, int vector,
> +				    struct hv_interrupt_entry *hv_entry)
> +{
> +	int lirq;
> +	struct msi_msg msimsg;
> +	struct irq_data *irqdata, *parent;
> +	u16 pcicmd;
> +	struct vfio_pci_core_device *coredev = dev_get_drvdata(&pdev->dev);
> +
> +	if (pdev->dev.driver == NULL ||
> +	    strcmp(pdev->dev.driver->name, "vfio-pci") != 0) {
> +		pr_err("Hyper-V: irqbypass: non vfio device %s\n",
> +		       pci_name(pdev));
> +		return;
> +	}
> +	if (coredev == NULL) {
> +		pr_err("Hyper-V: irqbypass: null vfio device for %s\n",
> +		       pci_name(pdev));
> +		return;
> +	}
> +
> +	if (hv_entry->source != HV_INTERRUPT_SOURCE_MSI) {
> +		pr_err("Hyper-V: %s irq source not msi\n", pci_name(pdev));
> +		return;
> +	}
> +
> +	lirq = pci_irq_vector(pdev, vector);
> +	irqdata = irq_get_irq_data(lirq);
> +	if (irqdata == NULL) {
> +		pr_err("Hyper-V: null irq_data for write msimsg. lirq:0x%x\n",
> +		       lirq);
> +		return;
> +	}
> +
> +	msimsg.address_hi = 0;
> +	msimsg.address_lo = hv_entry->msi_entry.address.as_uint32;
> +	msimsg.data =  hv_entry->msi_entry.data.as_uint32;
> +
> +	pcicmd = mshv_pci_memory_lock_and_enable(coredev);
> +	pci_write_msi_msg(lirq, &msimsg);
> +	mshv_pci_memory_unlock_and_restore(coredev, pcicmd);
> +
> +	pci_msi_unmask_irq(irqdata);
> +
> +	parent = irqdata->parent_data;
> +	if (parent && parent->chip && parent->chip->irq_unmask)
> +		irq_chip_unmask_parent(irqdata);
> +}
> +
> +/*
> + * This guest has a device passthru'd to it. VFIO did the initial setup of
> + * the device interrupts, but we left them unmapped in the hypervisor
> + * because we didn't have the guest target cpu and vector (required by
> + * hypervisor). We have them now, so do the map hypercall.
> + * Also, when here, it is expected that the device global mask is unset
> + * but individual MSI/x masks are set. Goal here is to map the interrupt in
> + * the hypervisor, update the corresponding device MSI/x entry, and enable it.
> + */
> +static void mshv_pthru_dev_irq_remap(struct mshv_irqfd *irqfd)
> +{
> +	u64 ptid, status;
> +	struct pci_dev *pdev;
> +	int rc, deposit_pgs = 16;
> +	struct mshv_lapic_irq *ginfo = &irqfd->irqfd_lapic_irq;
> +	union hv_device_id hv_devid;
> +	struct hv_interrupt_entry *new_entry;
> +	struct irq_data *irqdata;
> +
> +	if (!irqfd->irqfd_girq_ent.girq_entry_valid ||
> +	    irqfd->irqfd_bypass_prod == NULL)
> +		return;
> +
> +	rc = mshv_parse_mshv_irqfd(irqfd, &pdev, &irqdata);
> +	if (rc)
> +		return;
> +
> +	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
> +
> +	rc = mshv_chk_unmap_irq(hv_devid, irqdata);
> +	if (rc)
> +		return;
> +
> +	new_entry = kmalloc(sizeof(*new_entry), GFP_ATOMIC);
> +	if (new_entry == NULL)
> +		return;
> +
> +	ptid = irqfd->irqfd_partn->pt_id;
> +
> +	while (deposit_pgs--) {
> +		rc = mshv_map_device_interrupt(ptid, hv_devid, ginfo, new_entry,
> +					       &status);
> +		if (rc == 0)
> +			break;
> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
> +			break;
> +
> +		rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);
> +		if (rc)
> +			break;
> +	}
> +	if (rc) {
> +		kfree(new_entry);
> +		return;
> +	}
> +
> +	irqdata->chip_data = new_entry;
> +
> +	mshv_make_device_usable(pdev, irqdata->hwirq, new_entry);
> +}
> +
> +static void mshv_pthru_dev_irq_undo(struct mshv_irqfd *irqfd)
> +{
> +	struct pci_dev *pdev;
> +	union hv_device_id hv_devid;
> +	struct irq_data *irqdata;
> +	int rc;
> +
> +	if (!irqfd->irqfd_girq_ent.girq_entry_valid ||
> +	    irqfd->irqfd_bypass_prod == NULL)
> +		return;
> +
> +	rc = mshv_parse_mshv_irqfd(irqfd, &pdev, &irqdata);
> +	if (rc)
> +		return;
> +
> +	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
> +	mshv_chk_unmap_irq(hv_devid, irqdata);
> +}
> +
> +#else /* IS_ENABLED(CONFIG_X86_64) */
> +
> +static void mshv_pthru_dev_irq_remap(struct mshv_irqfd *irqfd) { }
> +static void mshv_pthru_dev_irq_undo(struct mshv_irqfd *irqfd) { }
> +
> +#endif /* IS_ENABLED(CONFIG_X86_64) */
> +
>  void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
>  				    struct mshv_irq_ack_notifier *mian)
>  {
> @@ -264,6 +635,7 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
>  	/*
>  	 * It is now safe to release the object's resources
>  	 */
> +	irq_bypass_unregister_consumer(&irqfd->irqfd_bypass_cons);
>  	eventfd_ctx_put(irqfd->irqfd_eventfd_ctx);
>  	kfree(irqfd);
>  }
> @@ -286,6 +658,12 @@ static void mshv_irqfd_deactivate(struct mshv_irqfd *irqfd)
>  
>  	hlist_del(&irqfd->irqfd_hnode);
>  
> +	/*
> +	 * Cleanup interrupt map (kfree chip_data) while in a VMM thread as
> +	 * unmap needs partition id. mshv_irqfd_shutdown() runs in a kthread.
> +	 */
> +	mshv_pthru_dev_irq_undo(irqfd);
> +
>  	queue_work(irqfd_cleanup_wq, &irqfd->irqfd_shutdown);
>  }
>  
> @@ -383,6 +761,45 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
>  	add_wait_queue_priority(wqh, &irqfd->irqfd_wait);
>  }
>  
> +static int mshv_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
> +					struct irq_bypass_producer *prod)
> +{
> +	struct mshv_irqfd *irqfd;
> +
> +	irqfd = container_of(cons, struct mshv_irqfd, irqfd_bypass_cons);
> +	irqfd->irqfd_bypass_prod = prod;
> +
> +	mshv_pthru_dev_irq_remap(irqfd);
> +
> +	return 0;
> +}
> +
> +static void mshv_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
> +					 struct irq_bypass_producer *prod)
> +{
> +	struct mshv_irqfd *irqfd;
> +
> +	irqfd = container_of(cons, struct mshv_irqfd, irqfd_bypass_cons);
> +
> +	WARN_ON(irqfd->irqfd_bypass_prod != prod);
> +	irqfd->irqfd_bypass_prod = NULL;
> +
> +}
> +
> +static void mshv_setup_irq_bypass(struct mshv_irqfd *irqfd,
> +				  struct eventfd_ctx *eventfd)
> +{
> +	struct irq_bypass_consumer *consumer = &irqfd->irqfd_bypass_cons;
> +	int rc;
> +
> +	consumer->add_producer = mshv_irq_bypass_add_producer;
> +	consumer->del_producer = mshv_irq_bypass_del_producer;
> +	rc = irq_bypass_register_consumer(&irqfd->irqfd_bypass_cons, eventfd);
> +	if (rc)
> +		pr_err("Hyper-V: irq bypass consumer registration failed: %d\n",
> +		       rc);
> +}
> +
>  static int mshv_irqfd_assign(struct mshv_partition *pt,
>  			     struct mshv_user_irqfd *args)
>  {
> @@ -509,6 +926,8 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  	if (events & EPOLLIN)
>  		mshv_assert_irq_slow(irqfd);
>  
> +	mshv_setup_irq_bypass(irqfd, eventfd);
> +
>  	srcu_read_unlock(&pt->pt_irq_srcu, idx);
>  	return 0;
>  
> diff --git a/drivers/iommu/hyperv-iommu-root.c b/drivers/iommu/hyperv-iommu-root.c
> index a2e0f6cc78e6..dc270b0a80d9 100644
> --- a/drivers/iommu/hyperv-iommu-root.c
> +++ b/drivers/iommu/hyperv-iommu-root.c
> @@ -217,6 +217,20 @@ u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type)
>  }
>  EXPORT_SYMBOL_GPL(hv_build_devid_oftype);
>  
> +/* Build device id for the interrupt path */
> +u64 hv_devid_from_pdev(struct pci_dev *pdev)
> +{
> +	enum hv_device_type dev_type;
> +
> +	if (hv_pcidev_is_attached_dev(pdev))
> +		dev_type = HV_DEVICE_TYPE_LOGICAL;
> +	else
> +		dev_type = HV_DEVICE_TYPE_PCI;
> +
> +	return hv_build_devid_oftype(pdev, dev_type);
> +}
> +EXPORT_SYMBOL_GPL(hv_devid_from_pdev);
> +
>  /* Create a new device domain in the hypervisor */
>  static int hv_iommu_create_hyp_devdom(struct hv_domain *hvdom)
>  {
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 50d793ca8f31..702a8005651b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1744,6 +1744,16 @@ static void hv_irq_mask(struct irq_data *data)
>  
>  static void hv_irq_unmask(struct irq_data *data)
>  {
> +	struct pci_dev *pdev;
> +	struct msi_desc *msi_desc;
> +
> +	msi_desc = irq_data_get_msi_desc(data);
> +	pdev = msi_desc_to_pci_dev(msi_desc);
> +
> +	/* Done during bypass setup in mshv_eventfd.c: mshv_irqfd_assign() */
> +	if (hv_pcidev_is_pthru_dev(pdev))
> +		return;
> +
>  	hv_arch_irq_unmask(data);
>  
>  	if (data->parent_data->chip->irq_unmask)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 8d5c610da99a..88b3aba6691c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -332,6 +332,7 @@ u64 hv_get_current_partid(void);
>  bool hv_pcidev_is_attached_dev(struct pci_dev *pdev);
>  bool hv_pcidev_is_pthru_dev(struct pci_dev *pdev);
>  u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type);
> +u64 hv_devid_from_pdev(struct pci_dev *pdev);
>  #else
>  static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>  { return false; }
> @@ -340,6 +341,8 @@ static inline bool hv_pcidev_is_pthru_dev(struct pci_dev *pdev)
>  static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
>  					enum hv_device_type type)
>  { return 0; }
> +static inline u64 hv_devid_from_pdev(struct pci_dev *pdev)
> +{ return 0; }
>  static inline u64 hv_get_current_partid(void)
>  { return HV_PARTITION_ID_INVALID; }
>  #endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */
> -- 
> 2.51.2.vfs.0.1
> 

