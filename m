Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870BE422A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2019 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbfFLKiM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jun 2019 06:38:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54995 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408931AbfFLKiL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jun 2019 06:38:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so6025576wme.4
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2019 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A1jkMuy2ezqCdqyisgnv02b0t1awTPsqQ7eTgJGgrxg=;
        b=d0LH065dyrOa5jwhALXwu2QBQfUwJI3P3SHmQLj4zAfbVDDV8TEwWYnt9+VAuKH9Lu
         Lvw84c9GXDAiqiGln00TcXZAMlrRA3DIO5ZLjSUyZitEtEc/7gPZwAx6j3THY2QV4EVH
         5WNtdEq/xQB789L1xafOc0riKtKyNJgpReQDOSYTciEneXgu8Aaq9kxL74PHl8Sh6myf
         /cj/y6hdqUzOTrV5sFMz13vB2xCAILtXcr1p1sA1Y6Tx6WlWiBX/JMVsiq/bAxIxKSt7
         abPJWMRvF/PSCm50dg8AkjD4LqH9BVpPkQLZ9+oW4nJBsyqLYK/PVS3V9jb9ooBRfJep
         97bA==
X-Gm-Message-State: APjAAAWjhDkyDzfZ5vWZbOIDARLF9be3ou87PCmCgB4HIHQby/BZ3oX3
        juI7+1nLBXsNT/dY/Ji//Ljy9Q==
X-Google-Smtp-Source: APXvYqxXO+6aHPpfLeLSipxttxiVN8qTTbQpyRvwqi+hESAewbXZNZZ6k/FIv5A28SvjTqPy+7RCkA==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr13723692wmh.68.1560335889404;
        Wed, 12 Jun 2019 03:38:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 6sm17809682wrd.51.2019.06.12.03.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:38:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 3/5] hv: vmbus: Replace page definition with Hyper-V specific one
In-Reply-To: <210c56ddb1dafc20ba289e6be9165efe8a5e818c.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <210c56ddb1dafc20ba289e6be9165efe8a5e818c.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:38:08 +0200
Message-ID: <87k1drdr73.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
> not be 4096 on all architectures and Hyper-V always runs with a page
> size of 4096.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  drivers/hv/hyperv_vmbus.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index e5467b821f41..5489b061d261 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -208,11 +208,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
>  		       u64 *requestid, bool raw);
>  
>  /*
> - * Maximum channels is determined by the size of the interrupt page
> - * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
> - * and the other is receive endpoint interrupt
> + * Maximum channels, 16348, is determined by the size of the interrupt page,
> + * which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to send endpoint
> + * interrupt, and the other is to receive endpoint interrupt.
>   */
> -#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
> +#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
>  
>  /* The value here must be in multiple of 32 */
>  /* TODO: Need to make this configurable */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
