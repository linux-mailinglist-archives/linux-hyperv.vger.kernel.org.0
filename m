Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A821B463A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDVN2P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 09:28:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33586 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVN2P (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 09:28:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id v8so4961623wma.0
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Apr 2020 06:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4cYGujY/qY6QL9bdTIQnjPVs04r0qN6NCp1qmsGvVP4=;
        b=NvnHzTW7lGyk3vKR6+4pIciMPTHm4JIuOOUYUr7Z5zpnPKfzmQw3oLOisezV1F4Sak
         HeZTLU2sOwjinLlf6bx2Qng5xN5s+3nkRhn6IU8ZCf71182sRt1xImKLHL+P/Jk/Mo/5
         YTb8zLkUvJ0pVz2shWypHaEzPnzLE8mv6obS3za4kTrqPxwZn/wDZ92gV9nuy09oZKQr
         xVFn6tg8IGxWnItnwjN29tN7NZvmpFqZ7CvpD/pNoygEo6O1BX7RnD1AM59be3famtfl
         1932bgTVtFhhdrtOrBG69ydjZH/J1VOhsPYhyDjYrazU8C7vuCnLsODv+up5Z8CMgTsV
         K/bw==
X-Gm-Message-State: AGi0PuaWtAo1CkONXVn0i04eNOtXPTbQZMgZzWgXsrPDuCpKg2L5a08n
        HDoGJ6ShTjAb0FQa4NrnRg8=
X-Google-Smtp-Source: APiQypJBeaaNfQJ7at8HtsCrMN5b/IZtD9mHBD8qYsF7ZX0q9QjVLVLQ/sysD5jTN/Q9EBiKD1Z4Cg==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr11230591wma.163.1587562093322;
        Wed, 22 Apr 2020 06:28:13 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id v10sm8556701wrq.45.2020.04.22.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:28:12 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:28:10 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1] hyper-v: Use UUID API for exporting the GUID
Message-ID: <20200422132810.va2lrzjwbtcwlfpp@debian>
References: <20200422125937.38355-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422125937.38355-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 03:59:37PM +0300, Andy Shevchenko wrote:
> There is export_guid() function which exports guid_t to the u8 array.
> Use it instead of open coding variant.
> 
> This allows to hide the uuid_t internals.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hv/hv_trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
> index a43bc76c2d5d0..579d19bdc0981 100644
> --- a/drivers/hv/hv_trace.h
> +++ b/drivers/hv/hv_trace.h
> @@ -286,8 +286,8 @@ TRACE_EVENT(vmbus_send_tl_connect_request,
>  		    __field(int, ret)
>  		    ),
>  	    TP_fast_assign(
> -		    memcpy(__entry->guest_id, &msg->guest_endpoint_id.b, 16);
> -		    memcpy(__entry->host_id, &msg->host_service_id.b, 16);
> +		    export_guid(__entry->guest_id, &msg->guest_endpoint_id);
> +		    export_guid(__entry->host_id, &msg->host_service_id);

I was about to say I couldn't find this function but it seems to have
been introduced in d01cd62400b which is currently in Linus' master
branch. That's fine then.

I will queue this up to hyperv-fixes for 5.7.

Wei.

>  		    __entry->ret = ret;
>  		    ),
>  	    TP_printk("sending guest_endpoint_id %pUl, host_service_id %pUl, "
> -- 
> 2.26.1
> 
