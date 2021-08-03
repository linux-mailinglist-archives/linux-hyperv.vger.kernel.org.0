Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4833DF3AC
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhHCRPM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 13:15:12 -0400
Received: from foss.arm.com ([217.140.110.172]:52528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237775AbhHCRPL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 13:15:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8181B139F;
        Tue,  3 Aug 2021 10:14:59 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34F2A3F40C;
        Tue,  3 Aug 2021 10:14:57 -0700 (PDT)
Date:   Tue, 3 Aug 2021 18:14:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 8/8] PCI: hv: Turn on the host bridge probing on ARM64
Message-ID: <20210803171451.GA15466@lpieralisi>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-9-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-9-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 02:06:57AM +0800, Boqun Feng wrote:
> Now we have everything we need, just provide a proper sysdata type for
> the bus to use on ARM64 and everything else works.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e6276aaa4659..62dbe98d1fe1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -40,6 +40,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ecam.h>
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irqdomain.h>
> @@ -448,7 +449,11 @@ enum hv_pcibus_state {
>  };
>  
>  struct hv_pcibus_device {
> +#ifdef CONFIG_X86
>  	struct pci_sysdata sysdata;
> +#elif defined(CONFIG_ARM64)
> +	struct pci_config_window sysdata;

This is ugly. HV does not need pci_config_window at all right
(other than arm64 pcibios_root_bridge_prepare()) ?

The issue is that in HV you have to have *some* sysdata != NULL, it is
just some data to retrieve the hv_pcibus_device.

Mmaybe we can rework ARM64 ACPI code to store the acpi_device in struct
pci_host_bridge->private instead of retrieving it from pci_config_window
so that we decouple HV from the ARM64 back-end.

HV would just set struct pci_host_bridge->private == NULL.

I need to think about this a bit, I don't think it should block
this series though but it would be nicer.

Lorenzo

> +#endif
>  	struct pci_host_bridge *bridge;
>  	struct fwnode_handle *fwnode;
>  	/* Protocol version negotiated with the host */
> @@ -3075,7 +3080,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  			 dom_req, dom);
>  
>  	hbus->bridge->domain_nr = dom;
> +#ifdef CONFIG_X86
>  	hbus->sysdata.domain = dom;
> +#endif
>  
>  	hbus->hdev = hdev;
>  	INIT_LIST_HEAD(&hbus->children);
> -- 
> 2.32.0
> 
