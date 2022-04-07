Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E824F8042
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiDGNQ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiDGNQY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 09:16:24 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B1B53F3;
        Thu,  7 Apr 2022 06:14:21 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id w4so7754707wrg.12;
        Thu, 07 Apr 2022 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StoUKCkj0ckT+oznBnUV4MpEJLxKOboDM1phKSbSnVI=;
        b=MCp54664Mkg6YMHt7becN4LSovpa8OrVd9Zxd0X9zatXXYqe8zdRaEeWYXQEwXsagT
         pDq/FjPyieskSdD9HERIUHZp5L4sZ7r2GOSvZ5xFmLHMJ1EF7FAE1o4XAiKDZRrRXeOk
         lsQXvIKYIoi6EhzIeWysBb/T1LaEvEkm8zHQ8xuviEhqLu8sI3MS4+fG7muBweoG9hmj
         Ug2CJqYgHgW0ZVH4bHeyrDHi6yzkcmLFB4dkq2TwR3nXYJscdWdiurzbjv+NIqs6dI8B
         QjEb7XEWlAIGa81earGIhcM31KAPH0VQ1XHhfy7XBHwTEUx1Y2o9DOolrLeGGAfwvjad
         3ntA==
X-Gm-Message-State: AOAM533w/I0Jvhok116xC/iyo/DuGNCuXN2cn4mQRhD+Tx8WeJ5phufC
        z55gFK9jPky25qoJh9MB4Ds=
X-Google-Smtp-Source: ABdhPJwYS8v1XjLf6ynFOc8VYIK9N9bjrMLjnsFxFf4PmaQPhVJ/3bI0ajLbuJv53Ev+i1iTpbiq5Q==
X-Received: by 2002:a5d:64cb:0:b0:205:8d25:704f with SMTP id f11-20020a5d64cb000000b002058d25704fmr11052344wri.518.1649337260047;
        Thu, 07 Apr 2022 06:14:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b0038cbd13e06esm7846181wmq.2.2022.04.07.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 06:14:19 -0700 (PDT)
Date:   Thu, 7 Apr 2022 13:14:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, decui@microsoft.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2] drm/hyperv: Added error message for fb size greater
 then allocated
Message-ID: <20220407131418.dr4agu2zebcdlsyg@liuwe-devbox-debian-v2>
References: <1649312827-728-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649312827-728-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 06, 2022 at 11:27:07PM -0700, Saurabh Sengar wrote:
> Added error message when the size of requested framebuffer is more then
> the allocated size by vmbus mmio region for framebuffer
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v1 -> v2 : Corrected Sign-off
> 
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index e82b815..92587f0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -123,8 +123,11 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
>  	if (fb->format->format != DRM_FORMAT_XRGB8888)
>  		return -EINVAL;
>  
> -	if (fb->pitches[0] * fb->height > hv->fb_size)
> +	if (fb->pitches[0] * fb->height > hv->fb_size) {
> +		drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater then allocated size %ld\n",

then -> than.

> +		current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
>  		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 
