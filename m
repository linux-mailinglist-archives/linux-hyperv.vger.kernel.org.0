Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14337A40C
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 May 2021 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEKJxh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 May 2021 05:53:37 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50855 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhEKJxg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 May 2021 05:53:36 -0400
Received: by mail-wm1-f52.google.com with SMTP id n84so10786448wma.0;
        Tue, 11 May 2021 02:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RklOnvzK32YLQfMzsNoB451WXrK3neV8tKeIMCPlix0=;
        b=cpp13s1427dOHaeJw793idhbHOkjz8h/vt3MtQ2Wf4p9AyKNo/JW14SrhpWYkz033B
         WVdR5Ip62eoeh48pWKAP9LTnnZepV7f2DY214HWzniXwfcn3Erd/NYCxxClR0OEUmVLO
         xg2Lg4PuYCB9DePsiKQ+gfUZXSIaGRu4MwjE1XTZAdweTeirFi95Iky0XTqh2QjQO3XK
         BEsuRvj0hpVc0Qa//3zYI4k7MzgWrygaoypXyYUYm5ez3rjSw2ObKrKBCYJksmYN0BAJ
         RWMWIQCgAwBF9zGxXUbnys7sd8hhLQOk5P0ofNQ25RQdImYIYDE/VDbG6frXwxmdZDec
         JI+g==
X-Gm-Message-State: AOAM5311mIMZ5yeDrHTB7GaiV6Cd1vuG2KN2gJTt+RVzSJxmqqZ9h2/r
        fa6GMCaepXuolITKzXsAGBdFJpwd9Lc=
X-Google-Smtp-Source: ABdhPJwaQpzAMwrj3Bn/NNytP+SaiZESwQSXt90F2I2+1DtFYCcXg897cvQMnvEaKE2yOIj60GNnbA==
X-Received: by 2002:a05:600c:3596:: with SMTP id p22mr4493909wmq.34.1620726748906;
        Tue, 11 May 2021 02:52:28 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l22sm2904540wmq.28.2021.05.11.02.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 02:52:28 -0700 (PDT)
Date:   Tue, 11 May 2021 09:52:27 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Message-ID: <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, May 09, 2021 at 09:13:03AM +0200, Christophe JAILLET wrote:
> If 'vmbus_establish_gpadl()' fails, the (recv|send)_gpadl will not be
> updated and 'hv_uio_cleanup()' in the error handling path will not be
> able to free the corresponding buffer.
> 
> In such a case, we need to free the buffer explicitly.
> 
> Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
> in 'hv_uio_cleanup()'.
> So, another way for fixing the potential leak is to modify
> 'hv_uio_cleanup()' and revert to the previous behavior.
> 

I think this is cleaner.

Stephen, you authored cdfa835c6e5e. What do you think?

Christophe, OOI how did you discover these issues?

> I don't know the underlying reason for this change so I don't know which is
> the best way to fix this error handling path. Unless there is a specific
> reason, changing 'hv_uio_cleanup()' could be better because it would keep
> the error handling path of the probe cleaner, IMHO.
> ---
>  drivers/uio/uio_hv_generic.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 0330ba99730e..eebc399f2cc7 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -296,8 +296,10 @@ hv_uio_probe(struct hv_device *dev,
>  
>  	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
>  				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> -	if (ret)
> +	if (ret) {
> +		vfree(pdata->recv_buf);
>  		goto fail_close;
> +	}
>  
>  	/* put Global Physical Address Label in name */
>  	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
> @@ -316,8 +318,10 @@ hv_uio_probe(struct hv_device *dev,
>  
>  	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
>  				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
> -	if (ret)
> +	if (ret) {
> +		vfree(pdata->send_buf);
>  		goto fail_close;
> +	}
>  
>  	snprintf(pdata->send_name, sizeof(pdata->send_name),
>  		 "send:%u", pdata->send_gpadl);
> -- 
> 2.30.2
> 
