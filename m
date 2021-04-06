Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA637355171
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Apr 2021 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbhDFLAI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Apr 2021 07:00:08 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33370 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbhDFLAG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Apr 2021 07:00:06 -0400
Received: by mail-wm1-f53.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so850735wma.0;
        Tue, 06 Apr 2021 03:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hXLv08rhQFdkBrwAZnUZH1UILFCfjdTJzMm85f6AEiI=;
        b=hALu/VveLtcYhh50G1ylPB2jVkI2kcRs5YbsjVEGtToFvNbqVCWSZ9luJb/4vP5KOM
         hZrQR7fhWeu6T5ZPMx1gMPUiLu1bKgkVekH9UFD4VglWY6Eyc60zaT8HrjgYvHG6AI5W
         zhCaRkaWgIbSau++wpzaDc4S1RFUNaG5NVQkPOPVD2gPL6REGS7vC2FoZOTM2e8U/1+e
         NPDUzmDQqL6FQL/VdSCYwugn0qTTDupnBRd0pa76gU9fqiIbFtoHVHJ1kQnRs2OvH/ds
         ShJhsbFsI9M3Bddx8he74kCaF/I8ykcOmbsyBPCbvPVXS0fJDjUceKg2hV3ZCfRKBX0i
         IHSA==
X-Gm-Message-State: AOAM533aJN5PiVtRt4DuWhd7er6xaTQPRZfyQzmLMB+dgsbXyFOflduV
        jpYymUsGCsopo9xbWEv47Es=
X-Google-Smtp-Source: ABdhPJy1Gzy9d/A2A39xh3SpIm84oBKl2mdvURWEMVmzxuJvMtD2C+rihv4T8h+/8srodQtE7jZ60A==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr3600121wmc.51.1617706796106;
        Tue, 06 Apr 2021 03:59:56 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j23sm2300336wmo.33.2021.04.06.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:59:55 -0700 (PDT)
Date:   Tue, 6 Apr 2021 10:59:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: remove unused including <linux/version.h>
Message-ID: <20210406105954.g2rewdjgv6sqgjh5@liuwe-devbox-debian-v2>
References: <1617674195-113872-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617674195-113872-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 06, 2021 at 09:56:35AM +0800, Yang Li wrote:
> Fix the following versioncheck warning:
> ./arch/x86/hyperv/hv_proc.c: 3 linux/version.h not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the patch. This is already reported and fixed in hyperv-next
by Huawei's Hulk bot.

Wei.

> ---
>  arch/x86/hyperv/hv_proc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 60461e5..27e17ad 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/types.h>
> -#include <linux/version.h>
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
>  #include <linux/clockchips.h>
> -- 
> 1.8.3.1
> 
