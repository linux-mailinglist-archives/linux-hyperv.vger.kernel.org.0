Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A704690D94
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjBIPvB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBIPvA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 10:51:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F1F46AB;
        Thu,  9 Feb 2023 07:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D41B821AD;
        Thu,  9 Feb 2023 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354A5C4339B;
        Thu,  9 Feb 2023 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675957844;
        bh=PcQb5EXD82ehWz/kUmq5dLcqukqM3Eq4OivEW2pmy74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bzJEBupAE5+WdVZyemB3w+F9Auwh74W7EQ7cVSPzOkhKuP2jkd5ssEr7+ub6/EcQ3
         sii9KrQMOz0O/6NBmSGupUYrX/AsitNsf3xisNi0AuPwpvHobONU/NNwwNwr3vnj37
         EIx3EeYAZ1Nu4h0oyReDZHCeh/JBPZvhrc8zALmMFqf8//sSbne9Sngm62MDA2V/K+
         5JC8NjU4kWyz5kkcQW/gom79FoTJ72/4vuNjD+NLgITmtQJoHRctwLoIKJ4mH/7nlk
         Hf44zzGWbykNMTjLtn/m8qFESy0pN82ipSlG1+z5EtJ609mEpkRr91azTtTs2ZpXyp
         hn5Cl+xAvbVHg==
Received: by mail-vs1-f48.google.com with SMTP id x8so2578274vso.2;
        Thu, 09 Feb 2023 07:50:44 -0800 (PST)
X-Gm-Message-State: AO0yUKVlt5EcmFcHHlDbdIP0M2QCQbptCceJEUYQypo80gtmuRnxg6S+
        oXrstfH7qrONDtJTf9mIwpoKGYqXmnma6nxOEw==
X-Google-Smtp-Source: AK7set+0s6rlT6DBbfpKcXjPlPYn3BYpXG9+A9MtPsC+XYb7kIjGFKHEqP71x76XyAJ72BsrEE69YTO5o8atZ4nArM0=
X-Received: by 2002:a67:cc1d:0:b0:3f3:5ce0:85ab with SMTP id
 q29-20020a67cc1d000000b003f35ce085abmr3199727vsl.26.1675957843111; Thu, 09
 Feb 2023 07:50:43 -0800 (PST)
MIME-Version: 1.0
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com> <1675944939-22631-6-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675944939-22631-6-git-send-email-ssengar@linux.microsoft.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Feb 2023 09:50:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK0WgWm-mG=fYyDVAi4uhL+fM0OD7KEF+xYYOOGNX8-oQ@mail.gmail.com>
Message-ID: <CAL_JsqK0WgWm-mG=fYyDVAi4uhL+fM0OD7KEF+xYYOOGNX8-oQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Driver: VMBus: Add device tree support
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 9, 2023 at 6:15 AM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> Update the driver to support device tree boot as well along with ACPI.

Devicetree

> At present the device tree parsing only provides the mmio region info

Devicetree

And anywhere else.

> and is not the exact copy of ACPI parsing. This is sufficient to cater
> all the current device tree usecases for VMBus.
>
> Currently device tree is supported only for x86 systems.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> - Removed #else for device tree parsing code. This should help better
>   test coverage.
> - Fix macro '__maybe_unused' warning
> - Added below options in Kconfig to enable device tree options for HYPERV
>         select OF if !ACPI
>         select OF_EARLY_FLATTREE if !ACPI
>
>  drivers/hv/Kconfig     |  6 +++--
>  drivers/hv/vmbus_drv.c | 60 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 0747a8f1fcee..1a55bf32d195 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -4,11 +4,13 @@ menu "Microsoft Hyper-V guest support"
>
>  config HYPERV
>         tristate "Microsoft Hyper-V client drivers"
> -       depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -               || (ARM64 && !CPU_BIG_ENDIAN))
> +       depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> +               || (ACPI && ARM64 && !CPU_BIG_ENDIAN)
>         select PARAVIRT
>         select X86_HV_CALLBACK_VECTOR if X86
>         select VMAP_PFN
> +       select OF if !ACPI
> +       select OF_EARLY_FLATTREE if !ACPI
>         help
>           Select this option to run Linux as a Hyper-V client operating
>           system.
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 73497157a23a..02f6bab61c37 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -20,6 +20,7 @@
>  #include <linux/completion.h>
>  #include <linux/hyperv.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/of_address.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
>  #include <linux/sched/isolation.h>
> @@ -2152,7 +2153,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
>         device_unregister(&device_obj->device);
>  }
>
> -
> +#ifdef CONFIG_ACPI
>  /*
>   * VMBUS is an acpi enumerated device. Get the information we
>   * need from DSDT.
> @@ -2262,6 +2263,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
>
>         return AE_OK;
>  }
> +#endif
>
>  static void vmbus_mmio_remove(void)
>  {
> @@ -2282,7 +2284,7 @@ static void vmbus_mmio_remove(void)
>         }
>  }
>
> -static void vmbus_reserve_fb(void)
> +static void __maybe_unused vmbus_reserve_fb(void)
>  {
>         resource_size_t start = 0, size;
>         struct pci_dev *pdev;
> @@ -2442,6 +2444,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>
> +#ifdef CONFIG_ACPI
>  static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>         acpi_status result;
> @@ -2494,10 +2497,50 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>                 vmbus_mmio_remove();
>         return ret_val;
>  }
> +#endif
> +
> +static int vmbus_device_add(struct platform_device *pdev)
> +{
> +       struct resource **cur_res = &hyperv_mmio;
> +       struct of_range range;
> +       struct of_range_parser parser;
> +       struct device_node *np;
> +       int ret = 0;

No need to initialize.

> +
> +       hv_dev = &pdev->dev;
> +       np = pdev->dev.of_node;

Set this on the declaration.

> +
> +       ret = of_range_parser_init(&parser, np);
> +       if (ret) {
> +               dev_err(hv_dev, "Failed to parse resources.\n");

If a print is needed, put it in of_range_parser_init().

> +               return ret;
> +       }
> +
> +       for_each_of_range(&parser, &range) {
> +               struct resource *res;
> +
> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +               if (!res)
> +                       return -ENOMEM;
> +
> +               res->name = "hyperv mmio";
> +               res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> +               res->start = range.pci_addr;

This is not PCI. It's a union, so use 'bus_addr' instead.

But wait, resources and IORESOURCE_MEM are *CPU* addresses. You need
cpu_addr here. Your DT happens to do 1:1 addresses so it happens to
work either way.

Rob
