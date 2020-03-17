Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238BA188C39
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 18:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQRgF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 13:36:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCQRgE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 13:36:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so26811177wre.4;
        Tue, 17 Mar 2020 10:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HK4dtU6wlFNqeoi15VIX4txP4pHLLBJv5Yu+/ozsMlo=;
        b=mfTsH6hLkOkCjRj90Xkh5eCAR1D8QvYRXBBDfM8ysrjex48uAq8j5cAOBXgu3aTKkZ
         tn+83Bf+sSBGoRNjUBMS+E6fEqlG93CuiPBKbsz/G2FhW0ydRoBvR6DE8NG09NiOkr1a
         iOg3HgM1xrqUfFyy1zcz5eSFR7wANA3lZEOTpAPnMaIbRghlgBKFTS6nsDVX9kKPegpt
         ztlv4gm7AYqyvjw/6IlaGr+GNwhTvEyrVlum9UT6tWTOU3spONGeE0EGTGKvFKsS2oG7
         aA+ZcfIbLfQr4YeZRWcPWSf1K/0FzLE5sn3RmtXWIdzaYOFEPzt6pyBijk6pNJYX2O7x
         c3gQ==
X-Gm-Message-State: ANhLgQ2S7iOPCkwz0mak60Xlg8n4kBvv60XQfjg9DIMWn0XLXizdUmIN
        gEcCmHQDH202hK2JWUwlo58=
X-Google-Smtp-Source: ADFU+vu9SYdwcgSZ2H4PuIVI9Wp9pPurJ3waoqVZWzO5zEOoKjPO/99OtjvJeY7eWQrGvPrFKK8lGg==
X-Received: by 2002:a5d:4ac2:: with SMTP id y2mr69149wrs.263.1584466563140;
        Tue, 17 Mar 2020 10:36:03 -0700 (PDT)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id k126sm202548wme.4.2020.03.17.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:36:02 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:36:00 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     ltykernel@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 2/4] x86/Hyper-V: Free hv_panic_page when fail to
 register kmsg dump
Message-ID: <20200317173600.2hqznyabyj4nckjo@debian>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 17, 2020 at 06:25:21AM -0700, ltykernel@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> If fail to register kmsg dump on Hyper-V platform, hv_panic_page
> will not be used anywhere. So free and reset it.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b56b9fb9bd90..b043efea092a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
>  			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
>  			if (hv_panic_page) {
>  				ret = kmsg_dump_register(&hv_kmsg_dumper);
> -				if (ret)
> +				if (ret) {
>  					pr_err("Hyper-V: kmsg dump register "
>  						"error 0x%x\n", ret);
> +					hv_free_hyperv_page(
> +					    (unsigned long)hv_panic_page);
> +					hv_panic_page = NULL;
> +				}

While this modification looks correct to me, there is a call to free
hv_panic_page in the err_alloc path. That makes the error handling a bit
confusing here.

I think you can just remove that function call in err_alloc path.

Wei.

>  			} else
>  				pr_err("Hyper-V: panic message page memory "
>  					"allocation failed");
> -- 
> 2.14.5
> 
