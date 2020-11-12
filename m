Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63C32B0852
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgKLPYr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:24:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbgKLPYp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605194683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
        b=hMIJI9aym5yni2izh+hbLXqhyhtVnz7r/Mh6NGGYzcfRQRC7+9mXraJ6ov5xSCxTepqLCl
        Bbq9sIcPC66jgnwK1HqmHl5P/HB1bYf+ldZ6XlAh/agGDteS2vjd9P1eER/mShHJyWhOgX
        j2+mJHd3xyX8USyyIP2lJ7oVCeeS8ZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-7l_la6zuOdq--aYZt12FDw-1; Thu, 12 Nov 2020 10:24:41 -0500
X-MC-Unique: 7l_la6zuOdq--aYZt12FDw-1
Received: by mail-wm1-f71.google.com with SMTP id j62so713322wma.4
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
        b=DEQrzxNTHzFtsSoVfKgKtQs0OUrydXrBaDOS+e7/BSYQ0vtXKEuCuk2tM2+Ni5ePRC
         2gMNsqdU/EHPJwFbW8UEVbYvRp/hGXdqKtYUK/dj8IRjYvCHTige3v8sNaYxzThfG+V9
         x44c6ByKMaJjyoEeCCoytiGrxIjk6fRYZgSRVOA8pvkPKW4pQDoIdz6UGFydmffMUecZ
         9Oh95JxsycvpTDqBd/LXYfo91N9ZQlkLKNlxgmDuUFWN997CqVo03+71MAgTUSgDTvMn
         LvdAJ8VQ8+jbd+BcAyuacTJ9ly9FlsNPdMXIGnBG6oAqcwXB8bFgTJoY+PlBWaUp9TgS
         G1Og==
X-Gm-Message-State: AOAM531WcVSd6MwK3AfLF03aXlzPLbBtYNyjZyveYjCGyvxCkzwkEK52
        5rPZ4NMuVX5p/KZzHHbictR5XTzN4wSwVSadt2zgGhSDnfkZr1Kzkr5KjbdrD7YK6VK9fpDwD+4
        ORKDN9iIGvQvfZ2aUMAVaDszq
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117233wmf.189.1605194680191;
        Thu, 12 Nov 2020 07:24:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX21sudMRdY26dySOmO/to1hNdt6R88HOOtUfizeNAVKSfSVnCXeomIzbUIzj2x9YbFyGcVQ==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117208wmf.189.1605194680020;
        Thu, 12 Nov 2020 07:24:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h62sm7096528wrh.82.2020.11.12.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:24:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v2 03/17] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
In-Reply-To: <20201105165814.29233-4-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-4-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:24:38 +0100
Message-ID: <87imaay4w9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e5..37c4d3a28309 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	if (hv_root_partition)
> +		return -ENODEV;
> +

Nit: any particular reason why we need to return an error from here? I'd
suggest we 'return 0;' if it doesn't break anything (we're still running
on Hyper-V, it's just a coincedence that there's nothing to do here,
eventually we may get some devices/handlers I guess. Also, there's going
to be server-side Vmbus eventually, we may as well initialize it here.

>  	init_completion(&probe_event);
>  
>  	/*

-- 
Vitaly

