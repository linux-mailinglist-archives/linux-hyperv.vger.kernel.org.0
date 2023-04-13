Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88A6E0F35
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Apr 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDMNvO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Apr 2023 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMNvN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Apr 2023 09:51:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5E13E;
        Thu, 13 Apr 2023 06:51:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681393870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0bKLdLVP7J8X35Ksonzci2P1EUFJoVx+hqOgN0tsxo=;
        b=vSBH5EtYDASGL4sbQBbdVCKHRPK690cHC1dsdHTPyjG4VT//EaNkuRKEwAtSykvvDutQw7
        0lcZC+HTZrn124YvlUmIiQAUTdJ+eqXZ9GZ8sPmd7+9MB6q638ERcMgZc5Z8n/w/faNmvo
        866vQxMMJgrd9DRN9NbeBg3fCLu1eVH6rZIAcaP9VMQ4PIzsz6o1G3hnIxyUqnPHKuGBgb
        1TRI1oaRl6FKk2WYfP86izckZtN7bXqrsHHGtNAD+3cSUm8phLHqllSKadOfpTcWnVuKBz
        6CA2fGH5VU35llmrQQjRf6korzcht0y1lYD9fLXje6RFsO26qg+dYI1cE7c0HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681393870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0bKLdLVP7J8X35Ksonzci2P1EUFJoVx+hqOgN0tsxo=;
        b=qEFdxh4tzkhcDplfs3FE965G5le5w/Cu7O/CTnyGIxlbA82PjMejT1h1+zIviWoNsNgNDN
        SXlYHq7iyzku94CQ==
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/hyperv: Expose an helper to map PCI interrupts
In-Reply-To: <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
References: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
 <168079870998.14175.16015623662679754647.stgit@skinsburskii.localdomain>
Date:   Thu, 13 Apr 2023 15:51:09 +0200
Message-ID: <87o7nrzy9e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 06 2023 at 09:33, Stanislav Kinsburskii wrote:
> This patch moves

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submittingpatches
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> a part of currently internal logic into the new
> hv_map_msi_interrupt function and makes it globally available helper,
> which will be used to map PCI interrupts in case of root partition.

> -static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
> -				struct hv_interrupt_entry *entry)
> +/**
> + * hv_map_msi_interrupt() - "Map" the MSI IRQ in the hypervisor.

So if you need to put "" on Map then maybe your function is
misnomed. Either it maps or it does not, right?

> + * @data:      Describes the IRQ
> + * @out_entry: Hypervisor (MSI) interrupt entry (can be NULL)
> + *
> + * Map the IRQ in the hypervisor by issuing a MAP_DEVICE_INTERRUPT hypercall.
> + */
> +int hv_map_msi_interrupt(struct irq_data *data,
> +			 struct hv_interrupt_entry *out_entry)
>  {
> -	union hv_device_id device_id = hv_build_pci_dev_id(dev);
> +	struct msi_desc *msidesc;
> +	struct pci_dev *dev;
> +	union hv_device_id device_id;
> +	struct hv_interrupt_entry dummy, *entry;
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	const cpumask_t *affinity;
> +	int cpu, vector;
> +
> +	msidesc = irq_data_get_msi_desc(data);
> +	dev = msi_desc_to_pci_dev(msidesc);
> +	device_id = hv_build_pci_dev_id(dev);
> +	affinity = irq_data_get_effective_affinity_mask(data);
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);

The effective affinity mask of MSI interrupts consists only of online
CPUs, to be accurate: it has exactly one online CPU set.

But even if it would have only offline CPUs then the result would be:

    cpu = nr_cpu_ids

which is definitely invalid. While a disabled vector targeted to an
offline CPU is not necessarily invalid.

Thanks,

        tglx
