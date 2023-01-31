Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C168374F
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjAaUNJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 15:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaUNI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 15:13:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44EC12852;
        Tue, 31 Jan 2023 12:13:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73FC7616D6;
        Tue, 31 Jan 2023 20:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D2C433A1;
        Tue, 31 Jan 2023 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675195985;
        bh=5yc8+yDNZydA6p0jCKirT18lggfjFb0/bXzH0u/mCRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BX72k/VRYEuVh6aQgCm26Ey1zdfkKTZKVD9HF7o0yc8u+jp7II9KmJu+0t0900Bsa
         1lDP1qPKP4qCMHISifKuJ+JTBY8tj4Q2b/ENSWzjy/vwKJIEgS3d8ZgwtIhD87aRRx
         7UcQPocRL+FJe7AMmGvKR4qZDw3f8V5NU6gNPBL3FcW+tseJsoP3JrWsuZkTGjLLg6
         T2v/TKKNSY8IpLtUHPYYe7hpN3cRyiH3J0L7EO1n3FZNiRc+zjco64LRL9Nm32uCmd
         /gdEcdCLRwaBIXMdqANc0dH0YE3JxFOOMxOVKrrcD+fpoyZKEKVqbcfFAyaFD34sTp
         QE4L2NKtYeJWg==
Received: by mail-vk1-f172.google.com with SMTP id bs10so7995295vkb.3;
        Tue, 31 Jan 2023 12:13:05 -0800 (PST)
X-Gm-Message-State: AO0yUKX7fcbsD79fSWAEb1654JkT6n0y8wgTNk53QFRm0z5K7GUislXc
        jt8uZ2Fxar3ktkM3c7Z313kOFETYIls9Khpt/w==
X-Google-Smtp-Source: AK7set++JzBuL5L86jZCW1SRtJIrPMRIxoWqVfMJXyD8BZseOgQXkcH/zfA4QVkxq06MTWFIO+TBTBGTOJrsNSLkrhM=
X-Received: by 2002:a1f:f8cf:0:b0:3e8:551c:46f with SMTP id
 w198-20020a1ff8cf000000b003e8551c046fmr2791163vkh.19.1675195984619; Tue, 31
 Jan 2023 12:13:04 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com> <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Jan 2023 14:12:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
Message-ID: <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> Update the driver to support device tree boot as well along with ACPI.
> At present the device tree parsing only provides the mmio region info
> and is not the exact copy of ACPI parsing. This is sufficient to cater
> all the current device tree usecases for VMBus.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 75 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 49030e756b9f..1741f1348f9f 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2152,7 +2152,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
>         device_unregister(&device_obj->device);
>  }
>
> -
> +#ifdef CONFIG_ACPI
>  /*
>   * VMBUS is an acpi enumerated device. Get the information we
>   * need from DSDT.
> @@ -2262,6 +2262,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
>
>         return AE_OK;
>  }
> +#endif
>
>  static void vmbus_mmio_remove(void)
>  {
> @@ -2282,7 +2283,7 @@ static void vmbus_mmio_remove(void)
>         }
>  }
>
> -static void vmbus_reserve_fb(void)
> +static void __maybe_unused vmbus_reserve_fb(void)
>  {
>         resource_size_t start = 0, size;
>         struct pci_dev *pdev;
> @@ -2442,6 +2443,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_free_mmio);
>
> +#ifdef CONFIG_ACPI

It's better to put C 'if (!IS_ENABLED(CONFIG_ACPI)' code in the

>  static int vmbus_acpi_add(struct platform_device *pdev)
>  {
>         acpi_status result;
> @@ -2496,10 +2498,68 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>                 vmbus_mmio_remove();
>         return ret_val;
>  }
> +#else
> +
> +static int vmbus_device_add(struct platform_device *pdev)
> +{
> +       struct resource **cur_res = &hyperv_mmio;
> +       struct device_node *np;
> +       u32 *ranges, len;
> +       u64 start;
> +       int nr_ranges, child_cells = 2, cur_cell = 0, ret = 0;
> +
> +       hv_dev = pdev;
> +       np = pdev->dev.of_node;
> +
> +       nr_ranges = device_property_count_u32(&pdev->dev, "ranges");

Parsing ranges yourself is a bad sign. It's a standard property and we
have functions which handle it. If those don't work, then something is
wrong with your DT or they need to be fixed/expanded.

> +       if (nr_ranges < 0)
> +               return nr_ranges;
> +       ranges = kcalloc(nr_ranges, sizeof(u32), GFP_KERNEL);
> +       if (!ranges)
> +               return -ENOMEM;
> +
> +       if (device_property_read_u32_array(&pdev->dev, "ranges", ranges, nr_ranges)) {
> +               ret =  -EINVAL;
> +               goto free_ranges;
> +       }
> +
> +       while (cur_cell < nr_ranges) {
> +               struct resource *res;
> +
> +               /* The first u64 in the ranges description isn't used currently. */
> +               cur_cell = cur_cell + child_cells;
> +               start = ranges[cur_cell++];
> +               start = (start << 32) | ranges[cur_cell++];
> +               len = ranges[cur_cell++];

To expand my last point, the format of ranges is <child_addr
parent_addr length>. That's not what your 'ranges' has. You've also
just ignored '#address-cells' and '#size-cells'.

> +
> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +               if (!res) {
> +                       ret = -ENOMEM;
> +                       goto free_ranges;
> +               }
> +
> +               res->name = "hyperv mmio";
> +               res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> +               res->start = start;
> +               res->end = start + len;
> +
> +               *cur_res = res;
> +               cur_res = &res->sibling;
> +       }
> +
> +free_ranges:
> +       kfree(ranges);
> +       return ret;
> +}
> +#endif
>
>  static int vmbus_platform_driver_probe(struct platform_device *pdev)
>  {
> +#ifdef CONFIG_ACPI
>         return vmbus_acpi_add(pdev);
> +#else
> +       return vmbus_device_add(pdev);
> +#endif
>  }
>
>  static int vmbus_platform_driver_remove(struct platform_device *pdev)
> @@ -2645,6 +2705,16 @@ static int vmbus_bus_resume(struct device *dev)
>  #define vmbus_bus_resume NULL
>  #endif /* CONFIG_PM_SLEEP */
>
> +static const struct of_device_id vmbus_of_match[] = {
> +       {
> +               .compatible = "msft,vmbus",
> +       },
> +       {
> +               /* sentinel */
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, vmbus_of_match);
> +
>  static const struct acpi_device_id vmbus_acpi_device_ids[] = {
>         {"VMBUS", 0},
>         {"VMBus", 0},
> @@ -2679,6 +2749,7 @@ static struct platform_driver vmbus_platform_driver = {
>         .driver = {
>                 .name = "vmbus",
>                 .acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
> +               .of_match_table = of_match_ptr(vmbus_of_match),
>                 .pm = &vmbus_bus_pm,
>                 .probe_type = PROBE_FORCE_SYNCHRONOUS,
>         }
> --
> 2.25.1
>
