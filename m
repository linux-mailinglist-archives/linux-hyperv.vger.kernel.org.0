Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6AB143FB4
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2020 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAUOhj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jan 2020 09:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgAUOhj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jan 2020 09:37:39 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2B22070C;
        Tue, 21 Jan 2020 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579617458;
        bh=hha4biDp81wEOPmWi3GEIfBbYU2CcuiLqOjxy9uS7Yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mCLSoItwpAg/CFYjzmuAV3O4ploxDv+LIqVKIxtWxkJrhA6yO0fXXHl1TT9i/JoJY
         kZ5rpwrzhgGcfbDMstxSXzo0NI1VwmbQLf9DGkAlnxe+rXDEkzUHjdNRbaO0SSO31k
         wsW/tv/6+XqC2P4qknAWhGk8S+bX2d/MoEVU3y0I=
Date:   Tue, 21 Jan 2020 08:37:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
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
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: hyperv: Move retarget related struct
 definitions into tlfs
Message-ID: <20200121143736.GA96172@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121015713.69691-2-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 21, 2020 at 09:57:13AM +0800, Boqun Feng wrote:
> For future support of virtual PCI on non-x86 architecture.

1) Don't make up random subject line prefixes; look at previous
practice and follow it, e.g.,

  $ git log --oneline drivers/pci/controller/pci-hyperv.c | head
  877b911a5ba0 PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer
  14ef39fddd23 PCI: hv: Change pci_protocol_version to per-hbus
  ac82fc832708 PCI: hv: Add hibernation support
  a8e37506e79a PCI: hv: Reorganize the code in preparation of hibernation
  f73f8a504e27 PCI: hv: Use bytes 4 and 5 from instance ID as the PCI domain numbers
  348dd93e40c1 PCI: hv: Add a Hyper-V PCI interface driver for software backchannel interface

2) Make the commit log complete in itself.  This one (and the previous
on) is not complete without reading the subject.

3) This patch claims to be a "move", but in fact it also *adds* union
hv_msi_entry, which didn't exist before.  It's better if you do a pure
move that doesn't add or change things, plus a separate patch that
makes changes that need to be reviewed more closely.

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
> +	params->int_entry.msi_entry.data = msi_desc->msg.data;
>  	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
> -- 
> 2.24.1
> 
