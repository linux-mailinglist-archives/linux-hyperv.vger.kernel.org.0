Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A594325E0D7
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Sep 2020 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgIDRaP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Sep 2020 13:30:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40713 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgIDRaK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Sep 2020 13:30:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id j2so7499875wrx.7;
        Fri, 04 Sep 2020 10:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNy2hGieTjSAjcYv7kwR0BOvIQ7J3JLWd6JVvNnGJ0g=;
        b=sZ03nkQtO3bsUjoKBy3QLm+3u9SW6Lpvfeq1irGk3xaB8UVZSgwiFfIOjAs+/gYeQ1
         8aNDgOqAkWfXlIWn9fUfe70C5H3COjdeQ84Emxxr45a15Sl5RJOpoNgB+0bq4Wh4yscx
         GXz14XgfuJ8nOfgUP4YuW2e5LCoqQJcueFlRFYa5BWMwNcy/UauUarfmlUO5jxvMC0XZ
         ElGn1peCJabazZjZdDPZ/kLCmkwK+bzO01R+AQRRS3YAPT4QRU6I56z8JiXhWdAiOj3e
         OCcuQgr1zTsWHpUV0Rj3iPB5JqGiafm3X5Ha3PCiao01tujuWrfQSALkEjcBK5JsF/3w
         Xzlg==
X-Gm-Message-State: AOAM533obBxxceAl1ccD5rMuXaXoqhCPMYiYwiGk2vLdqAkoT3gmEzeb
        Wz/9RgycX3ySBYBWvOeP0vI=
X-Google-Smtp-Source: ABdhPJy4lxSlIVmCZUYUt5G7cHc/b9vzzBbVyS5+h60xbFD5BvIaoh1SmuoljfZVF5ACmqFJVbs98w==
X-Received: by 2002:a05:6000:100c:: with SMTP id a12mr9155928wrx.115.1599240608246;
        Fri, 04 Sep 2020 10:30:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id h5sm13026654wrt.31.2020.09.04.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:30:07 -0700 (PDT)
Date:   Fri, 4 Sep 2020 17:30:06 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v1 5/5] hv_balloon: try to merge system ram resources
Message-ID: <20200904173006.e65qow53ietxzpne@liuwe-devbox-debian-v2>
References: <20200821103431.13481-1-david@redhat.com>
 <20200821103431.13481-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821103431.13481-6-david@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Aug 21, 2020 at 12:34:31PM +0200, David Hildenbrand wrote:
> Let's use the new mechanism to merge system ram resources below the
> root. We are the only one hotplugging system ram, e.g., DIMMs don't apply,
> so this is safe to be used.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665a..49a6305f0fb73 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -745,6 +745,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  			has->covered_end_pfn -=  processed_pfn;
>  			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  			break;
> +		} else {
> +			/* Try to reduce the number of system ram resources. */
> +			merge_system_ram_resources(&iomem_resource);
>  		}

You don't need to put the call under the "else" branch. It will have
broken out of the loop if ret is not zero.

Wei.

>  
>  		/*
> -- 
> 2.26.2
> 
