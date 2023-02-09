Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75179690CB9
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 16:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBIPSC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 10:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBIPSB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 10:18:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D9B270F;
        Thu,  9 Feb 2023 07:18:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B53D0B82186;
        Thu,  9 Feb 2023 15:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55949C433A4;
        Thu,  9 Feb 2023 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675955878;
        bh=2T5zUHYVCazsgAYtZgTcfe8SjYLEmqIyU8cl5qDjckQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eWYsvstt8rVC2kP8oe3ay16xVTuLf/sCFACgyEoZCwgaj3A0griFxBDygrX9985q+
         9HDd5GtO2ua0TjZG/3cklg7nVsSLi/j/6LJrns0NWXJYdIEYyZxKI6T9/ujxhl5Hb9
         sYPCMwL+Fp+/lgJ0acHGfRweiLB6pw9qh7d1XL+ujittm4cZLmuofFQzSiDm6XRNUl
         U9SFm8Fsdye7AdSKBbYE4/mv/7QVM1l8kNXhEWG8BPqEuk/pdmxSHBsq5vvA9bMjJF
         gZNL2qtyW00r2ZBoh5Spc+xNzGqfkE9mMm/yr5UhPeGlebR5047YP5o8snIYIG5SDZ
         prq+LJioNn/lw==
Received: by mail-vs1-f50.google.com with SMTP id p10so2454184vsu.5;
        Thu, 09 Feb 2023 07:17:58 -0800 (PST)
X-Gm-Message-State: AO0yUKUsuEKQO3IcGE8JQVPRA8/hKwW5wXQgLTC1XOWSP9hkTV+ivpXj
        56wu1Uf8c4c90ZuZIKiiTeKuaKG3rN56e85CXA==
X-Google-Smtp-Source: AK7set+DUh9wxgiwFSM5nDI/7k50nb6FEU5ww7gGxV3ilVo2sXNwGjhokxCLLttHPgPNfYo6dU2Ahtz2PqpwSM28Aoc=
X-Received: by 2002:a05:6102:387:b0:411:bfcf:def5 with SMTP id
 m7-20020a056102038700b00411bfcfdef5mr833046vsq.6.1675955877231; Thu, 09 Feb
 2023 07:17:57 -0800 (PST)
MIME-Version: 1.0
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com> <1675944939-22631-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1675944939-22631-3-git-send-email-ssengar@linux.microsoft.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 9 Feb 2023 09:17:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJisFuagtm_VyzTiMzRiB18z+ZX8j63+efTDLWNaccoOQ@mail.gmail.com>
Message-ID: <CAL_JsqJisFuagtm_VyzTiMzRiB18z+ZX8j63+efTDLWNaccoOQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Drivers: hv: allow non ACPI compilation for hv_is_hibernation_supported
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 9, 2023 at 6:15 AM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> acpi_sleep_state_supported() currently is defined only when
> CONFIG_ACPI=y.  For future work to enable device tree builds, put this
> function under #ifdef CONFIG_ACPI.  Otherwise, return 'false' from
> hv_is_hibernation_supported() as Hyper-V guest configs using device
> tree don't support hibernation.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/hv_common.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 52a6f89ccdbd..370ec20d1993 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -234,7 +234,11 @@ EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
>
>  bool hv_is_hibernation_supported(void)
>  {
> +#ifdef CONFIG_ACPI
>         return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);

Rework the acpi_bus.h header so that this is defined for !CONFIG_ACPI:

static inline bool acpi_sleep_state_supported(u8 sleep_state) { return false; }

Then you don't need this change here. That or using IS_ENABLED() is
strongly preferred over #ifdefs.

Rob
