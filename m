Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61C423E9BE
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Aug 2020 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHGJGy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Aug 2020 05:06:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39197 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726862AbgHGJGx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Aug 2020 05:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596791211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAgJEBejyPWGx6tEh8JOWO70ZKvKRe9vL7QVxREaPEs=;
        b=FCC2Jg2Hew9Po2OnKynhY4kFDT1U4ScPYdPnqb0XR8xbuCEnISH1poage58pHbuZQS/0EL
        wY/OBKrfCS+rNK+XPDeLF+Lx15srWsr2w1/Q5l3ARyaLilOu/6Ozp1q8JjcS1wywK+oqMo
        lgxcG3nalWpW6vRUaNlgsQyYpk1AKGk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-Q2_Z6CszNWSq0Agi5rwUNw-1; Fri, 07 Aug 2020 05:06:50 -0400
X-MC-Unique: Q2_Z6CszNWSq0Agi5rwUNw-1
Received: by mail-ej1-f71.google.com with SMTP id r14so606714eji.16
        for <linux-hyperv@vger.kernel.org>; Fri, 07 Aug 2020 02:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YAgJEBejyPWGx6tEh8JOWO70ZKvKRe9vL7QVxREaPEs=;
        b=B/Dm+mCb+oJFzlsKwC+/T6ngnCBWTYViYO/1mPxCziQK0qDX5LdbtLz78og/dKftWK
         vXIuUEJsnqgjbySMyMJDfLnT9z0ExyxEcjtOYKKNtsslxKP9ef0XF24k7CYp42tWPZ7b
         6irrWq+obAmpCTfFauuZibymQlvmbmUVRIHrX0sV1J8sc2FOb6SJzsT8vPD/8FKZmIyn
         EdpmDC12+Ri+wMc9qaMXEe48gz/qR5OobxNbz548SL2e5GGvJ4Zmdk5e/0s8lMqGPkjf
         x9B2UuWW/noBqcTPBAFPxY+eaVaY1/GgUfKDGuxpE9GP6iYJOquKsltefv3gENtrdnMz
         7Wjg==
X-Gm-Message-State: AOAM53315kyk44a/BAOWC+G8geYV68MViBaImBIVAH/m8NqFn5exR2CG
        VI+qLbR1TukPlFazsYZns+klplEkUwH4yevlvQ60oF5OiO9WL8vzaihxa9jIzlObHp0dH+WHjSQ
        V2M6vQzVaHz3InrXVJiKW65GV
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr8598722ejz.196.1596791208696;
        Fri, 07 Aug 2020 02:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0gp4D1eeThNc0MfUqIzH9zOKg9l29PiJCQKRH1FdTYArhPiiYmHs1iPWe8+PWuyye41OG4g==
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr8598712ejz.196.1596791208530;
        Fri, 07 Aug 2020 02:06:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dr21sm705148ejc.112.2020.08.07.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:06:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        kys@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Only notify Hyper-V for die events that are oops
In-Reply-To: <1596730935-11564-1-git-send-email-mikelley@microsoft.com>
References: <1596730935-11564-1-git-send-email-mikelley@microsoft.com>
Date:   Fri, 07 Aug 2020 11:06:47 +0200
Message-ID: <87o8nmome0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> Hyper-V currently may be notified of a panic for any die event. But
> this results in false panic notifications for various user space traps
> that are die events. Fix this by ignoring die events that aren't oops.
>
> Fixes: 510f7aef65bb ("Drivers: hv: vmbus: prefer 'die' notification chain to 'panic'")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b50081c..910b6e9 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -86,6 +86,10 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
>  	struct die_args *die = (struct die_args *)args;
>  	struct pt_regs *regs = die->regs;
>  
> +	/* Don't notify Hyper-V if the die event is other than oops */
> +	if (val != DIE_OOPS)
> +		return NOTIFY_DONE;
> +

Looking at die_val enum, DIE_PANIC also sounds like something we would
want to report but it doesn't get emitted anywhere and honestly I don't
quite understand how is was supposed to be different from DIE_OOPS.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  	/*
>  	 * Hyper-V should be notified only once about a panic.  If we will be
>  	 * doing hyperv_report_panic_msg() later with kmsg data, don't do

-- 
Vitaly

