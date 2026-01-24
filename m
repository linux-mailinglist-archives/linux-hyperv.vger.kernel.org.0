Return-Path: <linux-hyperv+bounces-8511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB0gFLopdGm72gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8511-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 03:08:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2D7C2E7
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 03:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935F4301AA6C
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BA202F7C;
	Sat, 24 Jan 2026 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VYX6dNq9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143F1FE471;
	Sat, 24 Jan 2026 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769220534; cv=none; b=UodTwlfnxY/Uv+vTT1jxoKpUJETsQq/ZxaovZYogk0Ry3E9iKDCtqRal22vMIvZNzg2/KBt0cn6LxDF8AzHfgJpxpJ8ek5uPE6KTBChL4YDgFLXbia6yqN/QEgPdBNDQyakAf4jdkgPMq6YskAJhkOs+U0lbUX4QDpWfVTarovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769220534; c=relaxed/simple;
	bh=NmhoXlAdhdtXZdZKZ2gnrzkT1nHCl7Byj1VYtO00lKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYayW3Gr6cpIXuUeZ0vbkCqJgoLQ9Vjin4l5GDZAiIjUc7g7ycmmlGqVs80iOgRvbeoHWRo2/LZZXrCeNbne6N9Rt0xEjmBRz26Pz/a72qkGjJfBIWds3xBrJvpE8nE1uQ/U8W+gfV1+0UFWuRomt+2wb1EvBR0as16gVZ7IMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VYX6dNq9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AAEE20B7167;
	Fri, 23 Jan 2026 18:08:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AAEE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769220531;
	bh=c6Ld1KeUC9X+RCl6WYDzlflk5Bx4fsA//1oxPdJg2/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYX6dNq9u4huo54zqYdwrSmVgXHRl+zVzyOexSzOqySOFHd0v9cmKHkRaPvxlENDL
	 CYlWOq91LWMRjyvnv4ymFWWE1kBqP8dWDeLnZxPcvmzx7hVN5YBM3WcGcKGZop85l4
	 vOHTHU4Vu87G5HXwWP6tfvOhD8Nbzu+B+fijKjoA=
Message-ID: <fdd09171-b543-5036-1ad9-322bc1593018@linux.microsoft.com>
Date: Fri, 23 Jan 2026 18:08:49 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 13/15] x86/hyperv: Basic interrupt support for direct
 attached devices
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
 romank@linux.microsoft.com
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-14-mrathor@linux.microsoft.com>
 <aXAiCw9Dk7GDfagy@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aXAiCw9Dk7GDfagy@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8511-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9F2D7C2E7
X-Rspamd-Action: no action

On 1/20/26 16:47, Stanislav Kinsburskii wrote:
> On Mon, Jan 19, 2026 at 10:42:28PM -0800, Mukesh R wrote:
>> From: Mukesh Rathor <mrathor@linux.microsoft.com>
>>
>> As mentioned previously, a direct attached device must be referenced
>> via logical device id which is formed in the initial attach hypercall.
>> Interrupt mapping paths for direct attached devices are almost same,
>> except we must use logical device ids instead of the PCI device ids.
>>
>> L1VH only supports direct attaches for passing thru devices to its guests,
>> and devices on L1VH are VMBus based. However, the interrupts are mapped
>> via the map interrupt hypercall and not the traditional method of VMBus
>> messages.
>>
>> Partition id for the relevant hypercalls is tricky. This because a device
>> could be moving from root to guest and then back to the root. In case
>> of L1VH, it could be moving from system host to L1VH root to a guest,
>> then back to the L1VH root. So, it is carefully crafted by keeping
>> track of whether the call is on behalf of a VMM process, whether the
>> device is attached device (as opposed to mapped), and whether we are in
>> an L1VH root/parent. If VMM process, we assume it is on behalf of a
>> guest. Otherwise, the device is being attached or detached during boot
>> or shutdown of the privileged partition.
>>
>> Lastly, a dummy cpu and vector is used to map interrupt for a direct
>> attached device. This because, once a device is marked for direct attach,
>> hypervisor will not let any interrupts be mapped to host. So it is mapped
>> to guest dummy cpu and dummy vector. This is then correctly mapped during
>> guest boot via the retarget paths.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>   arch/arm64/include/asm/mshyperv.h   | 15 +++++
>>   arch/x86/hyperv/irqdomain.c         | 57 +++++++++++++-----
>>   arch/x86/include/asm/mshyperv.h     |  4 ++
>>   drivers/pci/controller/pci-hyperv.c | 91 +++++++++++++++++++++++++----
>>   4 files changed, 142 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
>> index b721d3134ab6..27da480f94f6 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -53,6 +53,21 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
>>   	return hv_get_msr(reg);
>>   }
>>   
>> +struct irq_data;
>> +struct msi_msg;
>> +struct pci_dev;
>> +static inline void hv_irq_compose_msi_msg(struct irq_data *data,
>> +					  struct msi_msg *msg) {};
>> +static inline int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>> +					struct hv_interrupt_entry *hvirqe)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
>> +{
>> +	return false;
>> +}
>> +
>>   /* SMCCC hypercall parameters */
>>   #define HV_SMCCC_FUNC_NUMBER	1
>>   #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
>> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
>> index 33017aa0caa4..e6eb457f791e 100644
>> --- a/arch/x86/hyperv/irqdomain.c
>> +++ b/arch/x86/hyperv/irqdomain.c
>> @@ -13,6 +13,16 @@
>>   #include <linux/irqchip/irq-msi-lib.h>
>>   #include <asm/mshyperv.h>
>>   
>> +/*
>> + * For direct attached devices (which use logical device ids), hypervisor will
>> + * not allow mappings to host. But VFIO needs to bind the interrupt at the very
>> + * start before the guest cpu/vector is known. So we use dummy cpu and vector
>> + * to bind in such case, and later when the guest starts, retarget will move it
>> + * to correct guest cpu and vector.
>> + */
>> +#define HV_DDA_DUMMY_CPU      0
>> +#define HV_DDA_DUMMY_VECTOR  32
>> +
>>   static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
>>   				  bool level, int cpu, int vector,
>>   				  struct hv_interrupt_entry *ret_entry)
>> @@ -24,6 +34,11 @@ static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
>>   	u64 status;
>>   	int nr_bank, var_size;
>>   
>> +	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL) {
>> +		cpu = HV_DDA_DUMMY_CPU;
>> +		vector = HV_DDA_DUMMY_VECTOR;
>> +	}
>> +
>>   	local_irq_save(flags);
>>   
>>   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> @@ -95,7 +110,8 @@ static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
>>   	return hv_result_to_errno(status);
>>   }
>>   
>> -static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *irq_entry)
>> +static int hv_unmap_interrupt(union hv_device_id hv_devid,
>> +			      struct hv_interrupt_entry *irq_entry)
>>   {
>>   	unsigned long flags;
>>   	struct hv_input_unmap_device_interrupt *input;
>> @@ -103,10 +119,14 @@ static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *irq_entry)
>>   
>>   	local_irq_save(flags);
>>   	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>> -
>>   	memset(input, 0, sizeof(*input));
>> -	input->partition_id = hv_current_partition_id;
>> -	input->device_id = id;
>> +
>> +	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL)
>> +		input->partition_id = hv_iommu_get_curr_partid();
>> +	else
>> +		input->partition_id = hv_current_partition_id;
>> +
>> +	input->device_id = hv_devid.as_uint64;
>>   	input->interrupt_entry = *irq_entry;
>>   
>>   	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
>> @@ -263,6 +283,7 @@ static u64 hv_build_irq_devid(struct pci_dev *pdev)
>>   int hv_map_msi_interrupt(struct irq_data *data,
>>   			 struct hv_interrupt_entry *out_entry)
>>   {
>> +	u64 ptid;
>>   	struct irq_cfg *cfg = irqd_cfg(data);
>>   	struct hv_interrupt_entry dummy;
>>   	union hv_device_id hv_devid;
>> @@ -275,8 +296,17 @@ int hv_map_msi_interrupt(struct irq_data *data,
>>   	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
>>   	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
>>   
>> -	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
>> -				cfg->vector, out_entry ? out_entry : &dummy);
>> +	if (hv_devid.device_type == HV_DEVICE_TYPE_LOGICAL)
>> +		if (hv_pcidev_is_attached_dev(pdev))
>> +			ptid = hv_iommu_get_curr_partid();
>> +		else
>> +			/* Device actually on l1vh root, not passthru'd to vm */
> 
> l1vh and root are mutually exclusive partitions.
> If you wanted to highlight that it's l1vh itself and not its child guest, then
> "l1vh parent" term would do.

We've been loosely using "l1vh root" to mean "privilated l1vh" as opposed
to l1vh guests. I think that is fine. l1vh parent is confusing, as it may
also refer to l1vh parent, which would be the host. so as long as the
context is clear, we are ok.

>> +			ptid = hv_current_partition_id;
>> +	else
>> +		ptid = hv_current_partition_id;
> 
> Looks like the only special case is for attached logical devices,
> otherwise hv_current_partition_id is used.
> Can the logic simplified here?

Could be, but at the cost of clear upfront clarity. this nicely tells
the reader that a logical ID has different cases, where as PCI
does not. End instructions are the same.

Thanks,
-Mukesh



> Thanks,
> Stanislav
> 
>> +
>> +	return hv_map_interrupt(ptid, hv_devid, false, cpu, cfg->vector,
>> +				out_entry ? out_entry : &dummy);
>>   }
>>   EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
>>   
>> @@ -289,10 +319,7 @@ static void entry_to_msi_msg(struct hv_interrupt_entry *entry,
>>   	msg->data = entry->msi_entry.data.as_uint32;
>>   }
>>   
>> -static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>> -				  struct hv_interrupt_entry *irq_entry);
>> -
>> -static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>   {
>>   	struct hv_interrupt_entry *stored_entry;
>>   	struct irq_cfg *cfg = irqd_cfg(data);
>> @@ -341,16 +368,18 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>   	data->chip_data = stored_entry;
>>   	entry_to_msi_msg(data->chip_data, msg);
>>   }
>> +EXPORT_SYMBOL_GPL(hv_irq_compose_msi_msg);
>>   
>> -static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>> -				  struct hv_interrupt_entry *irq_entry)
>> +int hv_unmap_msi_interrupt(struct pci_dev *pdev,
>> +			   struct hv_interrupt_entry *irq_entry)
>>   {
>>   	union hv_device_id hv_devid;
>>   
>>   	hv_devid.as_uint64 = hv_build_irq_devid(pdev);
>>   
>> -	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
>> +	return hv_unmap_interrupt(hv_devid, irq_entry);
>>   }
>> +EXPORT_SYMBOL_GPL(hv_unmap_msi_interrupt);
>>   
>>   /* NB: during map, hv_interrupt_entry is saved via data->chip_data */
>>   static void hv_teardown_msi_irq(struct pci_dev *pdev, struct irq_data *irqd)
>> @@ -486,7 +515,7 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
>>   	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
>>   	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
>>   
>> -	return hv_unmap_interrupt(hv_devid.as_uint64, entry);
>> +	return hv_unmap_interrupt(hv_devid, entry);
>>   }
>>   EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
>>   
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index e4ccdbbf1d12..b6facd3a0f5e 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -204,11 +204,15 @@ static inline u64 hv_iommu_get_curr_partid(void)
>>   #endif	/* CONFIG_HYPERV_IOMMU */
>>   
>>   u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
>> +void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
>> +extern bool hv_no_attdev;
>>   
>>   struct irq_domain *hv_create_pci_msi_domain(void);
>>   
>>   int hv_map_msi_interrupt(struct irq_data *data,
>>   			 struct hv_interrupt_entry *out_entry);
>> +int hv_unmap_msi_interrupt(struct pci_dev *dev,
>> +			   struct hv_interrupt_entry *hvirqe);
>>   int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
>>   		struct hv_interrupt_entry *entry);
>>   int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 40f0b06bb966..71d1599dc4a8 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -660,15 +660,17 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
>>   
>>   	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>   	memset(params, 0, sizeof(*params));
>> -	params->partition_id = HV_PARTITION_ID_SELF;
>> +
>> +	if (hv_pcidev_is_attached_dev(pdev))
>> +		params->partition_id = hv_iommu_get_curr_partid();
>> +	else
>> +		params->partition_id = HV_PARTITION_ID_SELF;
>> +
>>   	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
>> -	params->int_entry.msi_entry.address.as_uint32 = int_desc->address & 0xffffffff;
>> +	params->int_entry.msi_entry.address.as_uint32 =
>> +						int_desc->address & 0xffffffff;
>>   	params->int_entry.msi_entry.data.as_uint32 = int_desc->data;
>> -	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>> -			   (hbus->hdev->dev_instance.b[4] << 16) |
>> -			   (hbus->hdev->dev_instance.b[7] << 8) |
>> -			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>> -			   PCI_FUNC(pdev->devfn);
>> +	params->device_id = hv_pci_vmbus_device_id(pdev);
>>   	params->int_target.vector = hv_msi_get_int_vector(data);
>>   
>>   	if (hbus->protocol_version >= PCI_PROTOCOL_VERSION_1_2) {
>> @@ -1263,6 +1265,15 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>>   			mb();
>>   		}
>>   		spin_unlock_irqrestore(&hbus->config_lock, flags);
>> +		/*
>> +		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0 since it may
>> +		 * be read using a 32bit read which is skipped by the above
>> +		 * emulation.
>> +		 */
>> +		if (PCI_INTERRUPT_PIN >= where &&
>> +		    PCI_INTERRUPT_PIN <= (where + size)) {
>> +			*((char *)val + PCI_INTERRUPT_PIN - where) = 0;
>> +		}
>>   	} else {
>>   		dev_err(dev, "Attempt to read beyond a function's config space.\n");
>>   	}
>> @@ -1731,14 +1742,22 @@ static void hv_msi_free(struct irq_domain *domain, unsigned int irq)
>>   	if (!int_desc)
>>   		return;
>>   
>> -	irq_data->chip_data = NULL;
>>   	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
>>   	if (!hpdev) {
>> +		irq_data->chip_data = NULL;
>>   		kfree(int_desc);
>>   		return;
>>   	}
>>   
>> -	hv_int_desc_free(hpdev, int_desc);
>> +	if (hv_pcidev_is_attached_dev(pdev)) {
>> +		hv_unmap_msi_interrupt(pdev, irq_data->chip_data);
>> +		kfree(irq_data->chip_data);
>> +		irq_data->chip_data = NULL;
>> +	} else {
>> +		irq_data->chip_data = NULL;
>> +		hv_int_desc_free(hpdev, int_desc);
>> +	}
>> +
>>   	put_pcichild(hpdev);
>>   }
>>   
>> @@ -2139,6 +2158,56 @@ static void hv_vmbus_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>   	msg->data = 0;
>>   }
>>   
>> +/* Compose an msi message for a directly attached device */
>> +static void hv_dda_compose_msi_msg(struct irq_data *irq_data,
>> +				   struct msi_desc *msi_desc,
>> +				   struct msi_msg *msg)
>> +{
>> +	bool multi_msi;
>> +	struct hv_pcibus_device *hbus;
>> +	struct hv_pci_dev *hpdev;
>> +	struct pci_dev *pdev = msi_desc_to_pci_dev(msi_desc);
>> +
>> +	multi_msi = !msi_desc->pci.msi_attrib.is_msix &&
>> +		    msi_desc->nvec_used > 1;
>> +
>> +	if (multi_msi) {
>> +		dev_err(&hbus->hdev->device,
>> +			"Passthru direct attach does not support multi msi\n");
>> +		goto outerr;
>> +	}
>> +
>> +	hbus = container_of(pdev->bus->sysdata, struct hv_pcibus_device,
>> +			    sysdata);
>> +
>> +	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
>> +	if (!hpdev)
>> +		goto outerr;
>> +
>> +	/* will unmap if needed and also update irq_data->chip_data */
>> +	hv_irq_compose_msi_msg(irq_data, msg);
>> +
>> +	put_pcichild(hpdev);
>> +	return;
>> +
>> +outerr:
>> +	memset(msg, 0, sizeof(*msg));
>> +}
>> +
>> +static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +	struct pci_dev *pdev;
>> +	struct msi_desc *msi_desc;
>> +
>> +	msi_desc = irq_data_get_msi_desc(data);
>> +	pdev = msi_desc_to_pci_dev(msi_desc);
>> +
>> +	if (hv_pcidev_is_attached_dev(pdev))
>> +		hv_dda_compose_msi_msg(data, msi_desc, msg);
>> +	else
>> +		hv_vmbus_compose_msi_msg(data, msg);
>> +}
>> +
>>   static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>>   				      struct irq_domain *real_parent, struct msi_domain_info *info)
>>   {
>> @@ -2177,7 +2246,7 @@ static const struct msi_parent_ops hv_pcie_msi_parent_ops = {
>>   /* HW Interrupt Chip Descriptor */
>>   static struct irq_chip hv_msi_irq_chip = {
>>   	.name			= "Hyper-V PCIe MSI",
>> -	.irq_compose_msi_msg	= hv_vmbus_compose_msi_msg,
>> +	.irq_compose_msi_msg	= hv_compose_msi_msg,
>>   	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>   	.irq_ack		= irq_chip_ack_parent,
>>   	.irq_eoi		= irq_chip_eoi_parent,
>> @@ -4096,7 +4165,7 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
>>   		irq_data = irq_get_irq_data(entry->irq);
>>   		if (WARN_ON_ONCE(!irq_data))
>>   			return -EINVAL;
>> -		hv_vmbus_compose_msi_msg(irq_data, &entry->msg);
>> +		hv_compose_msi_msg(irq_data, &entry->msg);
>>   	}
>>   	return 0;
>>   }
>> -- 
>> 2.51.2.vfs.0.1
>>


