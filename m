Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC842B656
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Oct 2021 08:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJMGIc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Oct 2021 02:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhJMGIb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Oct 2021 02:08:31 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBF5C061570;
        Tue, 12 Oct 2021 23:06:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i11so1410752ila.12;
        Tue, 12 Oct 2021 23:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+yIPzmSDmsHIKfKEyAUJoRAuzYSQSAMvoqRDNKNfZIA=;
        b=eLMI0ogCJOqFvHtyWTgF7IQGk5n9WyxMJpQzprZJyjv9KAJDlilBHVPo7SFa2eD1ZV
         5kw5VIPgYMq7rThNB/9AI8s+ZrB/Gsq2kJvVM7uJAH/jTrZXGRf8w4XFQlUbEe2SJCgJ
         0zWAka6dysjfkLJYX9nqh0qYiQLdkERQLLKsAgF1OlXes4Zjmnsh5FYn+Fu1DvoCqMeC
         6uh85N3UWGSY0PKfu6lzPJ+PCEoJdV7hJnlLSFCMGh8o1qcvtM4GDDzA+m/QKYuzgsTG
         vRae6xVfLjuzgK11Fu2UTG8nG9x+aDfbgBodj16Ys+oxZa2rCpabDfCnfMuu+hV+VPbr
         MX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+yIPzmSDmsHIKfKEyAUJoRAuzYSQSAMvoqRDNKNfZIA=;
        b=b8/NL3AJ/xs5WAEWBAQSDr3WB9Mgdw35sFHF2PIqj96mbWyfAP1OMlkOcy8JBvj8qU
         AxTaPzuJw+DoC3U4vqv4oUvRH+UynjzS7/bbjvGPivLqND4ST4/yvhk/sP6sQcznS0jE
         rQI9N1gokSjJTLvFg3pEdGbN9d2+Slxv+8nN62751fEsgz4/xAHpcd74QbAkkY4Lm/lr
         dr1rsqiEzFAd5Fn3rFASJCyhtF4QYqBRJEwpmG70u9/8ArH4MWmIJF3qa+wJY3zCca1W
         YOa27jLxv5pnfYYeuGmOeOxRvzf/kc+neUxeSJIfx302+7qIt1mEBfACoeOqRq1UKFAp
         5s9w==
X-Gm-Message-State: AOAM5308gvYoN9SDq82kXCA0CcjHgu1IhFX+GkNBn2R+7m9MwLWq5bas
        1CakAKWCRgLsjJiNpV8dbS4=
X-Google-Smtp-Source: ABdhPJwThwRptXL01kBRVo2ITQm6a5ShjIXJ2M4vE5igkj1usoujsF/mBNsl7t03O2avTCFjggWUYQ==
X-Received: by 2002:a05:6e02:188c:: with SMTP id o12mr20781823ilu.321.1634105188273;
        Tue, 12 Oct 2021 23:06:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d1sm6336954ion.47.2021.10.12.23.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:06:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id F07A327C0054;
        Wed, 13 Oct 2021 02:06:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Oct 2021 02:06:25 -0400
X-ME-Sender: <xms:YHdmYT17F8n8qNbH_zgBON0kYoIlWlObqq85_pczekGq2Zv1W1F6xg>
    <xme:YHdmYSFj6oGkHk214e0g5SVlU4Lt7Vxo-N0BP2gWtzWCTByrIZTr-FNAOCVxBvwRE
    nncY0ZHzGqBg9M-Og>
X-ME-Received: <xmr:YHdmYT4zqN1XLvgJYTUJEiGJFJxGSToPeSzioDExKiJMXalfUBe4CWq9i68eTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YHdmYY3xssR3fg0NlpE9c6HggURcf7ys_BoxSrxDAOV8WQ5Bt5F63w>
    <xmx:YHdmYWFLdbUdMpHFFsG1McALvuQH9uALo0WIdGfqyHaAVyTdihkiyg>
    <xmx:YHdmYZ_a_MBi_kb7YnUJoj9xEqJgzjUxHfNxC_DTt1bk-wj3d44K5w>
    <xmx:YXdmYaOCMezmCxrF20MdRnKaLBqAxr9gQMVEbPjfu8L7pKbPMZF4-dMxTNc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Oct 2021 02:06:24 -0400 (EDT)
Date:   Wed, 13 Oct 2021 14:06:23 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baihua.Lu@microsoft.com
Subject: Re: [PATCH v2 1/2] PCI: hv: Make the code arch neutral
Message-ID: <YWZ3X4K19WS1WNcP@boqun-archlinux>
References: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB2002C5BFFD9DCB9C3B2AF9E8C0B29@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

On Fri, Oct 08, 2021 at 05:20:35PM +0000, Sunil Muthuswamy wrote:
> This patch makes the Hyper-V vPCI code architectural neutral by
> introducing an irqchip that takes care of architectural
> dependencies. This allows for the implementation of Hyper-V vPCI
> for other architecture such as ARM64.
> 
> There are no functional changes expected from this patch.
> 

As reported by Baihua (I can also reproduce), compile errors are hit
when compiling with CONFIG_PCI_HYPERV=m:

ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pci-hyperv-irqchip.o
ERROR: modpost: "hv_msi_prepare" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: modpost: "hv_pci_irqchip_init" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: modpost: "hv_pci_irqchip_free" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: modpost: "hv_msi_get_int_vector" [drivers/pci/controller/pci-hyperv.ko] undefined!
ERROR: modpost: "hv_set_msi_entry_from_desc" [drivers/pci/controller/pci-hyperv.ko] undefined!

It means that we MODULE_LICENSE() should be added in
pci-hyperv-irqchip.c, also these symbols should be exported.

Regards,
Boqun

> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2:
>  v2 changes are described in the cover letter.
> 
>  MAINTAINERS                                 |  2 +
>  arch/x86/include/asm/hyperv-tlfs.h          | 33 +++++++++++++
>  arch/x86/include/asm/mshyperv.h             |  7 ---
>  drivers/pci/controller/Makefile             |  2 +-
>  drivers/pci/controller/pci-hyperv-irqchip.c | 51 ++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv-irqchip.h | 21 +++++++++
>  drivers/pci/controller/pci-hyperv.c         | 52 +++++++++++++--------
>  include/asm-generic/hyperv-tlfs.h           | 33 -------------
>  8 files changed, 141 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca6d6fde85cf..ba8c979c17b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8688,6 +8688,8 @@ F:	drivers/iommu/hyperv-iommu.c
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c
> +F:	drivers/pci/controller/pci-hyperv-irqchip.c
> +F:	drivers/pci/controller/pci-hyperv-irqchip.h
>  F:	drivers/pci/controller/pci-hyperv.c
>  F:	drivers/scsi/storvsc_drv.c
>  F:	drivers/uio/uio_hv_generic.c
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 2322d6bd5883..fdf3d28fbdd5 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -585,6 +585,39 @@ enum hv_interrupt_type {
>  	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
>  };
>  
> +union hv_msi_address_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 reserved1:2;
> +		u32 destination_mode:1;
> +		u32 redirection_hint:1;
> +		u32 reserved2:8;
> +		u32 destination_id:8;
> +		u32 msi_base:12;
> +	};
> +} __packed;
> +
> +union hv_msi_data_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 vector:8;
> +		u32 delivery_mode:3;
> +		u32 reserved1:3;
> +		u32 level_assert:1;
> +		u32 trigger_mode:1;
> +		u32 reserved2:16;
> +	};
> +} __packed;
> +
> +/* HvRetargetDeviceInterrupt hypercall */
> +union hv_msi_entry {
> +	u64 as_uint64;
> +	struct {
> +		union hv_msi_address_register address;
> +		union hv_msi_data_register data;
> +	} __packed;
> +};
> +
>  #include <asm-generic/hyperv-tlfs.h>
>  
>  #endif
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index adccbc209169..c2b9ab94408e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -176,13 +176,6 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> -static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -					      struct msi_desc *msi_desc)
> -{
> -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> -	msi_entry->data.as_uint32 = msi_desc->msg.data;
> -}
> -
>  struct irq_domain *hv_create_pci_msi_domain(void);
>  
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index aaf30b3dcc14..2c301d0fc23b 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -2,7 +2,7 @@
>  obj-$(CONFIG_PCIE_CADENCE) += cadence/
>  obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
>  obj-$(CONFIG_PCI_IXP4XX) += pci-ixp4xx.o
> -obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
> +obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o pci-hyperv-irqchip.o
>  obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>  obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
> diff --git a/drivers/pci/controller/pci-hyperv-irqchip.c b/drivers/pci/controller/pci-hyperv-irqchip.c
> new file mode 100644
> index 000000000000..5f334f7d66cb
> --- /dev/null
> +++ b/drivers/pci/controller/pci-hyperv-irqchip.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Hyper-V vPCI irqchip.
> + *
> + * Copyright (C) 2021, Microsoft, Inc.
> + *
> + * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +#include <linux/acpi.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +
> +#ifdef CONFIG_X86_64
> +int hv_pci_irqchip_init(struct irq_domain **parent_domain,
> +			bool *fasteoi_handler,
> +			u8 *delivery_mode)
> +{
> +	*parent_domain = x86_vector_domain;
> +	*fasteoi_handler = false;
> +	*delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +
> +	return 0;
> +}
> +
> +void hv_pci_irqchip_free(void) {}
> +
> +unsigned int hv_msi_get_int_vector(struct irq_data *data)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +
> +	return cfg->vector;
> +}
> +
> +void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				struct msi_desc *msi_desc)
> +{
> +	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> +	msi_entry->data.as_uint32 = msi_desc->msg.data;
> +}
> +
> +int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> +		   int nvec, msi_alloc_info_t *info)
> +{
> +	return pci_msi_prepare(domain, dev, nvec, info);
> +}
> +
> +#endif
> diff --git a/drivers/pci/controller/pci-hyperv-irqchip.h b/drivers/pci/controller/pci-hyperv-irqchip.h
> new file mode 100644
> index 000000000000..8fbf17f03385
> --- /dev/null
> +++ b/drivers/pci/controller/pci-hyperv-irqchip.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Architecture specific vector management for the Hyper-V vPCI.
> + *
> + * Copyright (C) 2021, Microsoft, Inc.
> + *
> + * Author : Sunil Muthuswamy <sunilmut@microsoft.com>
> + */
> +
> +int hv_pci_irqchip_init(struct irq_domain **parent_domain,
> +			bool *fasteoi_handler,
> +			u8 *delivery_mode);
> +
> +void hv_pci_irqchip_free(void);
> +unsigned int hv_msi_get_int_vector(struct irq_data *data);
> +void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				struct msi_desc *msi_desc);
> +
> +int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> +		   int nvec, msi_alloc_info_t *info);
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index eaec915ffe62..2d3916206986 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -43,14 +43,12 @@
>  #include <linux/pci-ecam.h>
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
> -#include <linux/irqdomain.h>
> -#include <asm/irqdomain.h>
> -#include <asm/apic.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
>  #include <asm/mshyperv.h>
> +#include "pci-hyperv-irqchip.h"
>  
>  /*
>   * Protocol versions. The low word is the minor version, the high word the
> @@ -81,6 +79,10 @@ static enum pci_protocol_version_t pci_protocol_versions[] = {
>  	PCI_PROTOCOL_VERSION_1_1,
>  };
>  
> +static struct irq_domain *parent_domain;
> +static bool fasteoi;
> +static u8 delivery_mode;
> +
>  #define PCI_CONFIG_MMIO_LENGTH	0x2000
>  #define CFG_PAGE_OFFSET 0x1000
>  #define CFG_PAGE_SIZE (PCI_CONFIG_MMIO_LENGTH - CFG_PAGE_OFFSET)
> @@ -1217,7 +1219,6 @@ static void hv_irq_mask(struct irq_data *data)
>  static void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_retarget_device_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
> @@ -1246,11 +1247,12 @@ static void hv_irq_unmask(struct irq_data *data)
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
>  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>  			   PCI_FUNC(pdev->devfn);
> -	params->int_target.vector = cfg->vector;
> +	params->int_target.vector = hv_msi_get_int_vector(data);
>  
>  	/*
> -	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
> -	 * setting the HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
> +	 * For x64, honoring apic->delivery_mode set to
> +	 * APIC_DELIVERY_MODE_FIXED by setting the
> +	 * HV_DEVICE_INTERRUPT_TARGET_MULTICAST flag results in a
>  	 * spurious interrupt storm. Not doing so does not seem to have a
>  	 * negative effect (yet?).
>  	 */
> @@ -1347,7 +1349,7 @@ static u32 hv_compose_msi_req_v1(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = delivery_mode;
>  
>  	/*
>  	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
> @@ -1377,7 +1379,7 @@ static u32 hv_compose_msi_req_v2(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = delivery_mode;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
> @@ -1397,7 +1399,7 @@ static u32 hv_compose_msi_req_v3(
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.reserved = 0;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = delivery_mode;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
> @@ -1419,7 +1421,6 @@ static u32 hv_compose_msi_req_v3(
>   */
>  static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_pcibus_device *hbus;
>  	struct vmbus_channel *channel;
>  	struct hv_pci_dev *hpdev;
> @@ -1470,7 +1471,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_2:
> @@ -1478,14 +1479,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	default:
> @@ -1601,7 +1602,7 @@ static struct irq_chip hv_msi_irq_chip = {
>  };
>  
>  static struct msi_domain_ops hv_msi_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
>  };
>  
> @@ -1625,12 +1626,13 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
>  		MSI_FLAG_PCI_MSIX);
> -	hbus->msi_info.handler = handle_edge_irq;
> -	hbus->msi_info.handler_name = "edge";
> +	hbus->msi_info.handler =
> +		fasteoi ? handle_fasteoi_irq : handle_edge_irq;
> +	hbus->msi_info.handler_name = fasteoi ? "fasteoi" : "edge";
>  	hbus->msi_info.data = hbus;
>  	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
>  						     &hbus->msi_info,
> -						     x86_vector_domain);
> +						     parent_domain);
>  	if (!hbus->irq_domain) {
>  		dev_err(&hbus->hdev->device,
>  			"Failed to build an MSI IRQ domain\n");
> @@ -3531,13 +3533,21 @@ static void __exit exit_hv_pci_drv(void)
>  	hvpci_block_ops.read_block = NULL;
>  	hvpci_block_ops.write_block = NULL;
>  	hvpci_block_ops.reg_blk_invalidate = NULL;
> +
> +	hv_pci_irqchip_free();
>  }
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	int ret;
> +
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	ret = hv_pci_irqchip_init(&parent_domain, &fasteoi, &delivery_mode);
> +	if (ret)
> +		return ret;
> +
>  	/* Set the invalid domain number's bit, so it will not be used */
>  	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
>  
> @@ -3546,7 +3556,11 @@ static int __init init_hv_pci_drv(void)
>  	hvpci_block_ops.write_block = hv_write_config_block;
>  	hvpci_block_ops.reg_blk_invalidate = hv_register_block_invalidate;
>  
> -	return vmbus_driver_register(&hv_pci_drv);
> +	ret = vmbus_driver_register(&hv_pci_drv);
> +	if (ret)
> +		hv_pci_irqchip_free();
> +
> +	return ret;
>  }
>  
>  module_init(init_hv_pci_drv);
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 56348a541c50..45cc0c3b8ed7 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -539,39 +539,6 @@ enum hv_interrupt_source {
>  	HV_INTERRUPT_SOURCE_IOAPIC,
>  };
>  
> -union hv_msi_address_register {
> -	u32 as_uint32;
> -	struct {
> -		u32 reserved1:2;
> -		u32 destination_mode:1;
> -		u32 redirection_hint:1;
> -		u32 reserved2:8;
> -		u32 destination_id:8;
> -		u32 msi_base:12;
> -	};
> -} __packed;
> -
> -union hv_msi_data_register {
> -	u32 as_uint32;
> -	struct {
> -		u32 vector:8;
> -		u32 delivery_mode:3;
> -		u32 reserved1:3;
> -		u32 level_assert:1;
> -		u32 trigger_mode:1;
> -		u32 reserved2:16;
> -	};
> -} __packed;
> -
> -/* HvRetargetDeviceInterrupt hypercall */
> -union hv_msi_entry {
> -	u64 as_uint64;
> -	struct {
> -		union hv_msi_address_register address;
> -		union hv_msi_data_register data;
> -	} __packed;
> -};
> -
>  union hv_ioapic_rte {
>  	u64 as_uint64;
>  
> -- 
> 2.25.1
> 
