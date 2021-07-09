Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588643C222B
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jul 2021 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhGIK1V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jul 2021 06:27:21 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53950 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIK1V (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jul 2021 06:27:21 -0400
Received: by mail-wm1-f46.google.com with SMTP id w13so6010400wmc.3;
        Fri, 09 Jul 2021 03:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cAfemKVKaAPq40ft5rYBbrNJJ0FxZzS3NBhkFBnKSzI=;
        b=YAW3U4TOhh9jayB20oqIkMIbn+6IlNyrt+m2wQxcJG+1ope3QDQS/7WtJ2qyEdcAij
         nXCyzZKfc+AKkbCp5bv3Yjcgh7ZTClRW3LkkSEw619K1hchuypXujudHmFJgvXxkTaJo
         XFgFNgr8P8vr99RzkiTqpoU2crGGqHcu1/GAfCFhEph4C3H51XdXOmr2OsVQrrwTg5Qq
         CJYdnLOFbjEaQ5+zykCHG9c+aU+f2odg4DQfOQJP6CMbVaXWEg3swaWWdyyRmOUZ9PRD
         25UvOunY5Asg1XBjfOmRKMIrgef9FygU1izOS9xTevHyEN/MLIoTt1c6OhbvaDk/c8g2
         wZpQ==
X-Gm-Message-State: AOAM531IIt2ZSzlc1hyEz6ZbSXVdtTkvxWhvrTnITClw+GcSYULIdLFK
        2Lgg8pVXdSPtA+vQkgKDZaU=
X-Google-Smtp-Source: ABdhPJz7KdWD9EJLU17W1kLv6XakRSsjJEumz5JxJkpi9BFIWNd/m8DAe9BoZPX7TXQA5ORW8lv8ug==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr38611656wmc.163.1625826276878;
        Fri, 09 Jul 2021 03:24:36 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j1sm11370711wms.7.2021.07.09.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:24:36 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:24:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 1/1] PCI: hv: Support for create interrupt v3
Message-ID: <20210709102434.c4hj4iehumf7qbj7@liuwe-devbox-debian-v2>
References: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB20025B945D77BBFDF61C6DA8C0199@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jul 08, 2021 at 11:04:49PM +0000, Sunil Muthuswamy wrote:
> Hyper-V vPCI protocol version 1_4 adds support for create interrupt
> v3. Create interrupt v3 essentially makes the size of the vector
> field bigger in the message, thereby allowing bigger vector values.
> For example, that will come into play for supporting LPI vectors
> on ARM, which start at 8192.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 74 ++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bebe3eeebc4e..de61b20f9604 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -64,6 +64,7 @@ enum pci_protocol_version_t {
>  	PCI_PROTOCOL_VERSION_1_1 = PCI_MAKE_VERSION(1, 1),	/* Win10 */
>  	PCI_PROTOCOL_VERSION_1_2 = PCI_MAKE_VERSION(1, 2),	/* RS1 */
>  	PCI_PROTOCOL_VERSION_1_3 = PCI_MAKE_VERSION(1, 3),	/* Vibranium */
> +	PCI_PROTOCOL_VERSION_1_4 = PCI_MAKE_VERSION(1, 4),      /* Fe */
>  };
>  
>  #define CPU_AFFINITY_ALL	-1ULL
> @@ -73,6 +74,7 @@ enum pci_protocol_version_t {
>   * first.
>   */
>  static enum pci_protocol_version_t pci_protocol_versions[] = {
> +	PCI_PROTOCOL_VERSION_1_4,
>  	PCI_PROTOCOL_VERSION_1_3,
>  	PCI_PROTOCOL_VERSION_1_2,
>  	PCI_PROTOCOL_VERSION_1_1,
> @@ -122,6 +124,8 @@ enum pci_message_type {
>  	PCI_CREATE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x17,
>  	PCI_DELETE_INTERRUPT_MESSAGE2	= PCI_MESSAGE_BASE + 0x18, /* unused */
>  	PCI_BUS_RELATIONS2		= PCI_MESSAGE_BASE + 0x19,
> +	PCI_RESOURCES_ASSIGNED3         = PCI_MESSAGE_BASE + 0x1A,
> +	PCI_CREATE_INTERRUPT_MESSAGE3   = PCI_MESSAGE_BASE + 0x1B,
>  	PCI_MESSAGE_MAXIMUM
>  };
>  
> @@ -235,6 +239,21 @@ struct hv_msi_desc2 {
>  	u16	processor_array[32];
>  } __packed;
>  
> +/*
> + * struct hv_msi_desc3 - 1.3 version of hv_msi_desc
> + *	Everything is the same as in 'hv_msi_desc2' except that the size
> + *	of the 'vector_count' field is larger to support bigger vector
> + *	values. For ex: LPI vectors on ARM.
> + */
> +struct hv_msi_desc3 {
> +	u32	vector;
> +	u8	delivery_mode;
> +	u8	reserved;
> +	u16	vector_count;
> +	u16	processor_count;
> +	u16	processor_array[32];
> +} __packed;
> +
>  /**
>   * struct tran_int_desc
>   * @reserved:		unused, padding
> @@ -383,6 +402,12 @@ struct pci_create_interrupt2 {
>  	struct hv_msi_desc2 int_desc;
>  } __packed;
>  
> +struct pci_create_interrupt3 {
> +	struct pci_message message_type;
> +	union win_slot_encoding wslot;
> +	struct hv_msi_desc3 int_desc;
> +} __packed;
> +
>  struct pci_delete_interrupt {
>  	struct pci_message message_type;
>  	union win_slot_encoding wslot;
> @@ -1334,26 +1359,55 @@ static u32 hv_compose_msi_req_v1(
>  	return sizeof(*int_pkt);
>  }
>  
> +static void hv_compose_msi_req_get_cpu(struct cpumask *affinity, int *cpu,
> +				       u16 *count)

Isn't count redundant here? I don't see how this can be used safely for
passing back more than 1 cpu, since if cpu is pointing to an array, its
size is not specified.

Wei.

> +{
> +	/*
> +	 * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> +	 * by subsequent retarget in hv_irq_unmask().
> +	 */
> +	*cpu = cpumask_first_and(affinity, cpu_online_mask);
> +	*count = 1;
> +}
> +
