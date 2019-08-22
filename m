Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9454C98DF7
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbfHVIju (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 04:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfHVIju (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 04:39:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2807C057E9F
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 08:39:49 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n13so1774971wmi.4
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Aug 2019 01:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1G74LHLrsWvUSFOFRiuwPg31y9BxmHy+eemqbD81aoo=;
        b=bQnBwHdb53IUt38EtfenC8SFXS3W520HA1P7Com+kx28fMgFbJThvu22RR1zTbI1sB
         AJQ+0nqbqcs4Q2rmYZWZp+xbLJU4nkG4wWjpzQQ8sEw09xgBkGRc5pgQpjTZhEcyCgyg
         z0ticc1XGcYqf4rzTFLgEinyCsS81iKLKok0rH9ZvKw0Qs207oy+XJjzc2lA1RDJy4xj
         v8ZX/X4LQJmjGcr/GdzxSEUnAh6jtEab2YGbcXkjWIUoXWwan2jhzUpKWxgBjbEYadkH
         ZBJ8laxygG7wUCrAPNMSBESihJfxe41QXpAMMl5AK7rmsyS0R7AWyjll8tgVIsuiSjwo
         Kukw==
X-Gm-Message-State: APjAAAXPmRTLrAN7lOU117J+vfH1IZUQbh+uNC208AIN3E6arozR27d+
        zl9BEDOlIh9DJ7iuDTVoqP30ue+NGJG/xAAeRbD0TEY/z6oZtaQoiiPauNRhvEGjmZjchzqA8fL
        XzZPLMCwskRK/AdpnuRV5dvUj
X-Received: by 2002:a1c:a584:: with SMTP id o126mr4930135wme.147.1566463188407;
        Thu, 22 Aug 2019 01:39:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2J+YaWKSPJhnayRR+gWUpkar/H3AzFK5rRtAD4OK1TGp8qXqYF0ivcPwnqhAMmghUwtqNNQ==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr4930111wme.147.1566463188178;
        Thu, 22 Aug 2019 01:39:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q20sm77625914wrc.79.2019.08.22.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 01:39:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
In-Reply-To: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
Date:   Thu, 22 Aug 2019 10:39:46 +0200
Message-ID: <87zhk1pp9p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
> hv_sched_clock_offset for their sched clock callback and so
> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.

CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
clocksource on 32bit" patch. Do we still have an issue to fix?

>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> This patch is based on the top of "git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> timers/core".
>
>  drivers/clocksource/hyperv_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index dad8af198e20..c322ab4d3689 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -22,6 +22,7 @@
>  #include <asm/mshyperv.h>
>  
>  static struct clock_event_device __percpu *hv_clock_event;
> +static u64 hv_sched_clock_offset __ro_after_init;
>  
>  /*
>   * If false, we're using the old mechanism for stimer0 interrupts
> @@ -215,7 +216,6 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  
>  static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
> -static u64 hv_sched_clock_offset __ro_after_init;
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {

-- 
Vitaly
