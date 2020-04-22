Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFE1B4669
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVNlc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 09:41:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38475 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVNlb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 09:41:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id g12so2414654wmh.3
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Apr 2020 06:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yH8qQhvLz0grcrteX0JRPFnVVfv3PIo38a3cC95JT+o=;
        b=Yjt/h1yDC4OGkM+Cqq3zqQC5vW1iL0QnjPBUFofexmHLQEoqstHC/zs7L2jpY/RYv4
         aqwOZOJveUMIXnheDB9OvdZJgFMVJ3rRXVG/hfczWkg67Tl1v7ZMGEjEele2y6K56C05
         XSGoqZsz4EGMiw4gW/nCJ4w4/V/TSMPHCNfStBu1BzrBGyEiKC6TaTTcZqndSQilYdG3
         0Q73QPg6BLCE34wNrsKsN1Mpne19BRGbu0ewrvniagLQZ3nghhb/crLUqjg/s7i30uWp
         0BfBuPAy6BRfntw8tYD3hPxyPmvLYre0JT3oNeXBZ6DcHCpe5wH/QsZZlRH9zT2k0ttl
         oE8w==
X-Gm-Message-State: AGi0PuadPkUA2NVmfIzUc7DuJy8MeA8spF/ZPsr4c/qAWsw9TP8aFoSR
        DpuFuRt2e/b66KmAvt8b4lM=
X-Google-Smtp-Source: APiQypLWAamKmfJwfM5LUMpL1xd9eXyqWH9sXnhZ8Hbs4sa5AqR85xhDXOrWYfsEyWTz/Ma8c8bg0w==
X-Received: by 2002:a1c:e087:: with SMTP id x129mr10991013wmg.127.1587562889910;
        Wed, 22 Apr 2020 06:41:29 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id 19sm7555840wmo.3.2020.04.22.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 06:41:29 -0700 (PDT)
Date:   Wed, 22 Apr 2020 14:41:27 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1] hyper-v: Remove internal types from UAPI header
Message-ID: <20200422134127.zgsympiwgvp7hdam@debian>
References: <20200422131818.23088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422131818.23088-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 04:18:18PM +0300, Andy Shevchenko wrote:
> The uuid_le mistakenly comes to be an UAPI type. Since it's luckily not used by
> Hyper-V APIs, we may replace with POD types, i.e. __u8 array.
> 
> Note, previously shared uuid_be had been removed from UAPI few releases ago.
> This is a continuation of that process towards removing uuid_le one.
> 
> Note, there is no ABI change!
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can you clarify why guid_t is not used instead? Is the plan to remove it
from UAPI as well?

Wei.

> ---
>  include/uapi/linux/hyperv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
> index 991b2b7ada7a3..8f24404ad04f1 100644
> --- a/include/uapi/linux/hyperv.h
> +++ b/include/uapi/linux/hyperv.h
> @@ -119,8 +119,8 @@ enum hv_fcopy_op {
>  
>  struct hv_fcopy_hdr {
>  	__u32 operation;
> -	uuid_le service_id0; /* currently unused */
> -	uuid_le service_id1; /* currently unused */
> +	__u8 service_id0[16]; /* currently unused */
> +	__u8 service_id1[16]; /* currently unused */
>  } __attribute__((packed));
>  
>  #define OVER_WRITE	0x1
> -- 
> 2.26.1
> 
