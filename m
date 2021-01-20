Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0990E2FD546
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Jan 2021 17:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391207AbhATQRn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Jan 2021 11:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391386AbhATQOq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Jan 2021 11:14:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB97DC061575
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:14:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d22so15407374edy.1
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Jan 2021 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3YaCJQ8LfKzkGjKHvvi/q44WKBCWlUY5g3M93ES9N4=;
        b=Qt+31s0k7Mjn6X5fLAPTZQBwGj66PX2q4gx9kZJM9UU0Fj9zKf9iGeB0nLS2LYGKMg
         LWmex1RpYlfY9c7UusCIbs5ju8pv3J++sSocIjMB0TZeXaiOMpwKWUVIWcYTMDBCKshV
         KjCry0XhhdgozhMjbeK7T8OsOyK3HHOJ+FpG/iMZXDHOmzjR91e20ux83TWKRlkXNvni
         weYgzqBxlQMq5jxc7aAh1xOhFkoVzr449eIWCGojiBzCQMwEra67oRs/VMHKqTTvdp1/
         WqdjBF3YCBKno8Fy90iju+Cvm4YwOeOtDaQ98rEw5RykZWJLVHF0vaAlgEtzzw2llV+X
         YTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3YaCJQ8LfKzkGjKHvvi/q44WKBCWlUY5g3M93ES9N4=;
        b=BYl0gzFHs05aUvzan0+pTK2bBLlHITWEH7AX0JJsAM3FbjGvnjOizuPVTPnN/oMM5x
         gv4HXyeMFkeSRQvVd5P/6DaVCb7yXJOHKOZuxsAxFf+RK5tz3hTGKqxnn5AHwYcwprSE
         bViGrA0Bn9wb01XWNFGAOCfhg9p45wlrNHR64r046cUpyZ/S+Z6VoNH1HdHYTZlJCzCk
         9AiVc83SZxZmevIiW/8KPuaqdtwvo7GSSCkduq1Q+/LCs7tFsgLeBcBPjZKrwLhwzMar
         JAA2al1ulL84J4Yv5N9aWgeFoYIJZfElCUh3BO0EwP0CwidVZUm2Omq3od/6p1r3CMoF
         YGDA==
X-Gm-Message-State: AOAM530KOK1vMkKGC/hPkV+mOHuBqj0abX4LKtO1iHxu5878Cc5Q7tso
        R6DTSAD0EaTft9menWjGF7bROPOdydVdSyKzOXDKqP1t4JJIYw==
X-Google-Smtp-Source: ABdhPJwSZ/KSHBr1sBpNSdWGO8It3AqUEuSIdP5w2bhyco9/KW73LkGrKMnaE5mNEUQEA2lqr+GLf+3ATR5p3G98/nA=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7702645edq.153.1611159243691;
 Wed, 20 Jan 2021 08:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-6-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-6-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:13:28 -0500
Message-ID: <CA+CK2bBTjUWEOrFKi4pYpEe355sve6b7AjKGc7cQRRe3c-DTrQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] clocksource/hyperv: use MSR-based access if
 running as root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> When Linux runs as the root partition, the setup required for TSC page
> is different.

Why would we need a TSC page as a clock source for root partition at
all? I think the above can be removed.

 Luckily Linux also has access to the MSR based
> clocksource. We can just disable the TSC page clocksource if Linux is
> the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/hyperv_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..269a691bd2c4 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -426,6 +426,9 @@ static bool __init hv_init_tsc_clocksource(void)
>         if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>                 return false;
>
> +       if (hv_root_partition)
> +               return false;
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
