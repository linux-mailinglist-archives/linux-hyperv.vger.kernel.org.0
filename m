Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1635B2C2C88
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 17:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbgKXQPo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 11:15:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgKXQPo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 11:15:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so22950191wrw.1;
        Tue, 24 Nov 2020 08:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m6LUpEp+/uERflUN1VYyJwsVSt5oWiPm5dXyToestxI=;
        b=dIyyVI9OW7k86NRDKELLGrEaz016RgcWNC+pyi3DkM6w/Vu82nRN7zYFLhsW9Lb/X1
         XrmLgrssXty/nOQrbKAms6Wddv5RGGIcbGewGXi8aynGts1ZIBQGuyl/XTry48uw+Znd
         fXLJNIss+w777UUHxSKjpO5Wmwn7LzJIe3bnVIWoPPVCCoC2w61ppWLLDRIG2MeBB3hg
         mjuv3OprRQeyJ14s9874xXodmhMncarsKMuJ1eRGc8XhCtJEMJqwylQZ8pMzYYliV5wr
         OtDhG5CjPeDHMIdV5etxvSfBof6GlmUnipK4nUWsou1PLJUD0197bYj4GQ64Jc95cTOn
         TO6A==
X-Gm-Message-State: AOAM530ZMdSaqqQxg0mRQgO4rGiXlwHiBzwbz+YSXSpf4uuLgGWfA4tt
        RNMUm229iSCGwFwqiGsmPUoUjFr9OOs=
X-Google-Smtp-Source: ABdhPJwd0TIkkSkUOkdVVXYWEsCbLPC+s8IUMVYhGqvvrpinTcPgLkSCSUOSfzVnK/tE18pVIKegQg==
X-Received: by 2002:a5d:5001:: with SMTP id e1mr6121571wrt.20.1606234540732;
        Tue, 24 Nov 2020 08:15:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f16sm27588405wrp.66.2020.11.24.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 08:15:40 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:15:38 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 12/18] virt/mshv: run vp ioctl and isr
Message-ID: <20201124161538.4d6iqbwnxzwhmo4e@liuwe-devbox-debian-v2>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-13-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605918637-12192-13-git-send-email-nunodasneves@linux.microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 20, 2020 at 04:30:31PM -0800, Nuno Das Neves wrote:
[...]
> diff --git a/virt/mshv/mshv_main.c b/virt/mshv/mshv_main.c
> index c9445d2edb37..7ddb66d260ce 100644
> --- a/virt/mshv/mshv_main.c
> +++ b/virt/mshv/mshv_main.c
> @@ -17,6 +17,7 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/random.h>
>  #include <linux/mshv.h>
>  #include <asm/mshyperv.h>
>  
> @@ -498,6 +499,240 @@ hv_call_set_vp_registers(u32 vp_index,
>  	return -hv_status_to_errno(status);
>  }
>  
> +static void
> +mshv_isr(void)
> +{
[...]
> +
> +	/* Hold this lock for the rest of the isr, because the partition could
> +	 * be released anytime.
> +	 * e.g. the MSHV_RUN_VP thread could wake on another cpu; it could
> +	 * release the partition unless we hold this!
> +	 */
> +	spin_lock_irqsave(&mshv.partitions.lock, flags);
> +

This should be switched to rwlock variant, otherwise vcpus can't run
concurrently.

You will take the read lock and only the ioctl that changes the list
will need to take the write lock.

There may be better and cheaper primitives than rwlock. Not sure if RCU
can be used in this context.

Wei.
