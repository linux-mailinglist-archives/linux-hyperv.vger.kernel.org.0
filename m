Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76592694F8E
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBMSlF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 13:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBMSlE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 13:41:04 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B1F1;
        Mon, 13 Feb 2023 10:41:03 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id u21so14273878edv.3;
        Mon, 13 Feb 2023 10:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDtFU2Jc95gLjieOysLnzEfFJTUgaL6A5DtFJMyaKWg=;
        b=xKOSdwHMWp6I/hRgP0t4YbcDhYfBNPaY8S0ONY6S67h2cAdvBwbhBjrBIjWukXeXyw
         tnf/MdTg1dIHfRlfUykhKwrDpur2iBm24nPL2ywZeOJO5aIf/a1plReU0e1zA4Jejs6v
         3FlaD6pD4vAyityca3+5lmAIgTjRjVq9oGHfqmjLLCknS9/gOlIe/1Q1HKgxDOPWeG0h
         MW5xzYALM0KFFEGixPMJuXe9DaPgaLseUGRvOT39nnq4DbVyTQwSbSf5H15qPKgmKP5n
         9kKx3YlHvq+nX4QkApFoh6i+Qhg33pQm9ATQPsXVbkw7PMfSi+TQKkDABJARsa3i8cmf
         mIDA==
X-Gm-Message-State: AO0yUKXdXlqTe4wMmE3aG9iGutjhXYfgqzoUaV9jAeLvQebR2bE0Vt88
        tntJRL5B4XPl+j1hbKoGkkRXm9BsHV5J/IrfVmg=
X-Google-Smtp-Source: AK7set9c7MrFAu9f5jlejY00/6IQgCiFdmwotU5SX7kkOfHGG0KHlQp9HH4RhJUJiR5WCISRbhRFTSlDhAMhz5lGcPE=
X-Received: by 2002:a50:baab:0:b0:4ac:cdd9:1c97 with SMTP id
 x40-20020a50baab000000b004accdd91c97mr1386918ede.6.1676313662522; Mon, 13 Feb
 2023 10:41:02 -0800 (PST)
MIME-Version: 1.0
References: <1676021646-2619-1-git-send-email-ssengar@linux.microsoft.com> <1676021646-2619-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1676021646-2619-3-git-send-email-ssengar@linux.microsoft.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:40:51 +0100
Message-ID: <CAJZ5v0ivddzCoYFd4TauH3G83KxCWQK1NZSvn25oWt_iy0LOfQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] ACPI: bus: Add stub acpi_sleep_state_supported()
 in non-ACPI cases
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com, lenb@kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 10, 2023 at 10:34 AM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> acpi_sleep_state_supported() is defined only when CONFIG_ACPI=y. The
> function is in acpi_bus.h, and acpi_bus.h can only be used in
> CONFIG_ACPI=y cases. Add the stub function to linux/acpi.h to make
> compilation successful for !CONFIG_ACPI cases.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to toute this patch whichever way is convenient.

Thanks!

> ---
>  include/linux/acpi.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index efff750f326d..d331f76b0c19 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1075,6 +1075,11 @@ static inline u32 acpi_osc_ctx_get_cxl_control(struct acpi_osc_context *context)
>         return 0;
>  }
>
> +static inline bool acpi_sleep_state_supported(u8 sleep_state)
> +{
> +       return false;
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> --
> 2.34.1
>
