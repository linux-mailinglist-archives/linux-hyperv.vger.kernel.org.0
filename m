Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A22C191558
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgCXPti (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 11:49:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27003 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727551AbgCXPti (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 11:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585064977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDeYcAUSbBq7ywkS5vACQpnT9b7hAluwSzLUAQ2Mkuo=;
        b=LfReCsaAKGWSs2ejdQ33hwwsitETjkyaWAn6EPgvtRTD1cx8z20+xjBB+6+je2LrOrjQqD
        gcuZMDskcE7okah0j1zWNXGYQ7/eLzraJwoUB/+CDH7MS92b9bTFpS/edRbj0apTj1KWl3
        OsI5N1wA36Q9EikoMaNgJNA9oMCxmJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-4wixj21aO8iQliTjHVF9nQ-1; Tue, 24 Mar 2020 11:49:36 -0400
X-MC-Unique: 4wixj21aO8iQliTjHVF9nQ-1
Received: by mail-wr1-f69.google.com with SMTP id p2so9404848wrw.8
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Mar 2020 08:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gDeYcAUSbBq7ywkS5vACQpnT9b7hAluwSzLUAQ2Mkuo=;
        b=Y1EA6QgQ+231+j+DobqbChHBkUAnwyDBxJfCyrURs4pnglG6IhmHVytBPz/VNmgxFr
         D0mCLm+VPIIk8zLtWIZE6GODNIsLhJaGGWTKXgAKljsjv/NFt37suwjMBlG6MY75Dx47
         7hrAKV+g7N3cFSyruaKXKot3EDGsO2gSQE+44XNekUHT/p558nPvoxPcdZTM9AhRUOb4
         vx844xzsIyvkwTeySP/e8fsX0XWP3gxwfNGVZCsOH91lsJRtqp19vo/TLPeqJ7Wy3LNN
         QiScRPKbKmm5qf9AKDY6J/W2mya4C8IhM9jADBKVgvrnH5yMfZ+A8rScsqFIv/SCETVV
         vP6A==
X-Gm-Message-State: ANhLgQ2HoNtOj8VGlRYJ85/yYQQuqXmRUoXh8+TNq23ZbFei0q/XPqds
        jf6IxAJO33ChwEyZTLvrqavPHpq+JZQxXwhKnwKPS1W/YQWnKELiW0JOIG5gsFYsfZQx7YEvlf6
        aa5d87Dq8y6RPLDCZX+bPXPEX
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr21284977wrn.253.1585064974714;
        Tue, 24 Mar 2020 08:49:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvieeuVU2W0zTxEOUqjpUVow4Ua37PmuvDaQdo6jPYZN+iJoR9w2Z7lCsv/HlVC3WP9EqY7jg==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr21284953wrn.253.1585064974406;
        Tue, 24 Mar 2020 08:49:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y7sm6862882wrq.54.2020.03.24.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:49:33 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yubo Xie <ltykernel@gmail.com>
Cc:     Yubo Xie <yuboxie@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix hv sched clock function return wrong time unit
In-Reply-To: <20200324151935.15814-1-yuboxie@microsoft.com>
References: <20200324151935.15814-1-yuboxie@microsoft.com>
Date:   Tue, 24 Mar 2020 16:49:32 +0100
Message-ID: <87ftdx7nxv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Yubo Xie <ltykernel@gmail.com> writes:

> sched clock callback should return time with nano second as unit
> but current hv callback returns time with 100ns. Fix it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yubo Xie <yuboxie@microsoft.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Fixes: adb87ff4f96c ("clocksource/drivers/hyperv: Allocate Hyper-V TSC page statically")

I don't think this is the right commit to reference, 

commit bd00cd52d5be655a2f217e2ed74b91a71cb2b14f
Author: Tianyu Lan <Tianyu.Lan@microsoft.com>
Date:   Wed Aug 14 20:32:16 2019 +0800

    clocksource/drivers/hyperv: Add Hyper-V specific sched clock function

looks like the one.

> ---
>  drivers/clocksource/hyperv_timer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 9d808d595ca8..662ed978fa24 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -343,7 +343,8 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_tsc(void)
>  {
> -	return read_hv_clock_tsc() - hv_sched_clock_offset;
> +	return (read_hv_clock_tsc() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }
>  
>  static void suspend_hv_clock_tsc(struct clocksource *arg)
> @@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_msr(void)
>  {
> -	return read_hv_clock_msr() - hv_sched_clock_offset;
> +	return (read_hv_clock_msr() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }

kvmclock seems to have the same (pre-patch) code ...

>  
>  static struct clocksource hyperv_cs_msr = {

-- 
Vitaly

