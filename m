Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027A56485A
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Jul 2022 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiGCPWO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Jul 2022 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPWN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Jul 2022 11:22:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835C559D;
        Sun,  3 Jul 2022 08:22:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a11so8194520ljb.5;
        Sun, 03 Jul 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7h/oDkelqUvQhnXMEHsIGaLApBCL4bVp/zpTNjHKaa0=;
        b=Ajde41bE2wU0CLXRYXxA4RUv0bp0nc6vv24Jkv3jO+pNmgV5SruaUwkgdZh2uTckb2
         LjwBe+5chzPdn9GsqinhSMRPDH/BkAH/rWbDiCgv3b73DzTdIIwCuu7rSSyi6XgKQgam
         QzYkv4hEeMuDSoYQBiHL7V7XX8PuwVWoX68+MhlsNYB1tpAW+qusPDMIKzVjewkktdka
         B8RzQXojCPXGgXsFV0Py1qu3xQ+dQ+Ph5W2hTs/NfGpTe8YoyNytz8Jxlg3eba2Qpapr
         0dHtsjY/VCs3nDTxh/rSpBzNfE0J7lWIPD0uFnZAO2fN8qfYU1kzNyc0DtqVW3j5bPa6
         jQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7h/oDkelqUvQhnXMEHsIGaLApBCL4bVp/zpTNjHKaa0=;
        b=SEh/L2/IwM+8X+EYW/d9V+NLQeHJljo3ZMCLaN/0nI9/mNNeYOseL/KSj+UdejcU5f
         M6G4A0FBxvMjOzBNpOBxZvqHqUH1TxtaT6Rw3FmL3N/rGYkXf8Jdd2teyHohU898Zeu8
         5YotdNeTrpXZJiYcb2bmrYOSpPUQq71vLW+VhJ5gHila11sfu0RI+URxoFmdKh1qMTpE
         lujhwdQFcBtbt3pdowTBVclP+L2BW2YOo5yoREVbNIV5aufgg6gCEpEZ7mGCisAlg8yn
         NIgPoe9QBwJ0vu0FxMJMqqI3iiTQa1v8WlZ3nUIeCJ3u/cjf+Bt2RAabzF/mzL519q/Q
         5M7g==
X-Gm-Message-State: AJIora+dXoR765ehfTIhs2GNiZMzADbqQbBjoOIh00GOV290PHu+DZNr
        Zcr2YAN10bJXtG84jykjRmE=
X-Google-Smtp-Source: AGRyM1trX48ruuzycgoteqtLbzXdO1QJTxFK4a9qaPKv/Ind+sZ8MDYf+3trOk+5IJ6FZryqObKQIg==
X-Received: by 2002:a2e:9941:0:b0:25b:c885:3143 with SMTP id r1-20020a2e9941000000b0025bc8853143mr14475290ljj.477.1656861727485;
        Sun, 03 Jul 2022 08:22:07 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b0047255d21132sm4758576lfs.97.2022.07.03.08.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 08:22:06 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] genirq: Add and use an irq_data_update_affinity
 helper
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chris Zankel <chris@zankel.net>,
        Colin Ian King <colin.king@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jan Beulich <jbeulich@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        Juergen Gross <jgross@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sven Schnelle <svens@stackframe.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Wei Liu <wei.liu@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
References: <20220701200056.46555-1-samuel@sholland.org>
 <20220701200056.46555-7-samuel@sholland.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <c7171195-796a-e61e-f270-864985adc5c3@gmail.com>
Date:   Sun, 3 Jul 2022 18:22:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220701200056.46555-7-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 01.07.22 23:00, Samuel Holland wrote:


Hello Samuel

> Some architectures and irqchip drivers modify the cpumask returned by
> irq_data_get_affinity_mask, usually by copying in to it. This is
> problematic for uniprocessor configurations, where the affinity mask
> should be constant, as it is known at compile time.
>
> Add and use a setter for the affinity mask, following the pattern of
> irq_data_update_effective_affinity. This allows the getter function to
> return a const cpumask pointer.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v3:
>   - New patch to introduce irq_data_update_affinity
>
>   arch/alpha/kernel/irq.c          | 2 +-
>   arch/ia64/kernel/iosapic.c       | 2 +-
>   arch/ia64/kernel/irq.c           | 4 ++--
>   arch/ia64/kernel/msi_ia64.c      | 4 ++--
>   arch/parisc/kernel/irq.c         | 2 +-
>   drivers/irqchip/irq-bcm6345-l1.c | 4 ++--
>   drivers/parisc/iosapic.c         | 2 +-
>   drivers/sh/intc/chip.c           | 2 +-
>   drivers/xen/events/events_base.c | 7 ++++---
>   include/linux/irq.h              | 6 ++++++
>   10 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
> index f6d2946edbd2..15f2effd6baf 100644
> --- a/arch/alpha/kernel/irq.c
> +++ b/arch/alpha/kernel/irq.c
> @@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
>   		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
>   	last_cpu = cpu;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
> +	irq_data_update_affinity(data, cpumask_of(cpu));
>   	chip->irq_set_affinity(data, cpumask_of(cpu), false);
>   	return 0;
>   }
> diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
> index 35adcf89035a..99300850abc1 100644
> --- a/arch/ia64/kernel/iosapic.c
> +++ b/arch/ia64/kernel/iosapic.c
> @@ -834,7 +834,7 @@ iosapic_unregister_intr (unsigned int gsi)
>   	if (iosapic_intr_info[irq].count == 0) {
>   #ifdef CONFIG_SMP
>   		/* Clear affinity */
> -		cpumask_setall(irq_get_affinity_mask(irq));
> +		irq_data_update_affinity(irq_get_irq_data(irq), cpu_all_mask);
>   #endif
>   		/* Clear the interrupt information */
>   		iosapic_intr_info[irq].dest = 0;
> diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
> index ecef17c7c35b..275b9ea58c64 100644
> --- a/arch/ia64/kernel/irq.c
> +++ b/arch/ia64/kernel/irq.c
> @@ -57,8 +57,8 @@ static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
>   void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
>   {
>   	if (irq < NR_IRQS) {
> -		cpumask_copy(irq_get_affinity_mask(irq),
> -			     cpumask_of(cpu_logical_id(hwid)));
> +		irq_data_update_affinity(irq_get_irq_data(irq),
> +					 cpumask_of(cpu_logical_id(hwid)));
>   		irq_redir[irq] = (char) (redir & 0xff);
>   	}
>   }
> diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
> index df5c28f252e3..025e5133c860 100644
> --- a/arch/ia64/kernel/msi_ia64.c
> +++ b/arch/ia64/kernel/msi_ia64.c
> @@ -37,7 +37,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
>   	msg.data = data;
>   
>   	pci_write_msi_msg(irq, &msg);
> -	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
> +	irq_data_update_affinity(idata, cpumask_of(cpu));
>   
>   	return 0;
>   }
> @@ -132,7 +132,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
>   	msg.address_lo |= MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
>   
>   	dmar_msi_write(irq, &msg);
> -	cpumask_copy(irq_data_get_affinity_mask(data), mask);
> +	irq_data_update_affinity(data, mask);
>   
>   	return 0;
>   }
> diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
> index 0fe2d79fb123..5ebb1771b4ab 100644
> --- a/arch/parisc/kernel/irq.c
> +++ b/arch/parisc/kernel/irq.c
> @@ -315,7 +315,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
>   {
>   #ifdef CONFIG_SMP
>   	struct irq_data *d = irq_get_irq_data(irq);
> -	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
> +	irq_data_update_affinity(d, cpumask_of(cpu));
>   #endif
>   
>   	return per_cpu(cpu_data, cpu).txn_addr;
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> index 142a7431745f..6899e37810a8 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -216,11 +216,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
>   		enabled = intc->cpus[old_cpu]->enable_cache[word] & mask;
>   		if (enabled)
>   			__bcm6345_l1_mask(d);
> -		cpumask_copy(irq_data_get_affinity_mask(d), dest);
> +		irq_data_update_affinity(d, dest);
>   		if (enabled)
>   			__bcm6345_l1_unmask(d);
>   	} else {
> -		cpumask_copy(irq_data_get_affinity_mask(d), dest);
> +		irq_data_update_affinity(d, dest);
>   	}
>   	raw_spin_unlock_irqrestore(&intc->lock, flags);
>   
> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
> index 8a3b0c3a1e92..3a8c98615634 100644
> --- a/drivers/parisc/iosapic.c
> +++ b/drivers/parisc/iosapic.c
> @@ -677,7 +677,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
>   	if (dest_cpu < 0)
>   		return -1;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
> +	irq_data_update_affinity(d, cpumask_of(dest_cpu));
>   	vi->txn_addr = txn_affinity_addr(d->irq, dest_cpu);
>   
>   	spin_lock_irqsave(&iosapic_lock, flags);
> diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
> index 358df7510186..828d81e02b37 100644
> --- a/drivers/sh/intc/chip.c
> +++ b/drivers/sh/intc/chip.c
> @@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
>   	if (!cpumask_intersects(cpumask, cpu_online_mask))
>   		return -1;
>   
> -	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
> +	irq_data_update_affinity(data, cpumask);
>   
>   	return IRQ_SET_MASK_OK_NOCOPY;
>   }
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 46d9295d9a6e..5e8321f43cbd 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -528,9 +528,10 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, unsigned int cpu,
>   	BUG_ON(irq == -1);
>   
>   	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
> -		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
> -		cpumask_copy(irq_get_effective_affinity_mask(irq),
> -			     cpumask_of(cpu));
> +		struct irq_data *data = irq_get_irq_data(irq);
> +
> +		irq_data_update_affinity(data, cpumask_of(cpu));
> +		irq_data_update_effective_affinity(data, cpumask_of(cpu));
>   	}



Nit: commit description says about reusing irq_data_update_affinity() 
only, but here we also reuse irq_data_update_effective_affinity(), so I 
would mention that in the description.

Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com> # Xen bits


[snip]

-- 
Regards,

Oleksandr Tyshchenko

