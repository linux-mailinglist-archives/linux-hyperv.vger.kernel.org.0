Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB4651D71
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiLTJeF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiLTJdo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA31123
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzV1868qdOe1XrhL7OcqYIS/A7VjHb9o4AzfKTps9Yw=;
        b=CtrWn1OBODksqJrqL5e28n92WBrWJgbQroZm+2OnvYzRTyqv2zJddboX1veEo5VZD2MoV4
        abHGd0iBIFHoqD1z2BE/7adjmFwcFPeatt43Zl55gMvhM53eDL2imJABdK2xNLJNdc/d2W
        iuOA6yJTSPakBYf2PURB63bEBWQnvSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-vqR_KSfpPa-bfNWwqJyzRw-1; Tue, 20 Dec 2022 04:32:56 -0500
X-MC-Unique: vqR_KSfpPa-bfNWwqJyzRw-1
Received: by mail-wm1-f70.google.com with SMTP id h64-20020a1c2143000000b003d65ff910e1so51238wmh.2
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzV1868qdOe1XrhL7OcqYIS/A7VjHb9o4AzfKTps9Yw=;
        b=OZuU81ewZy84eaEwqLlZgWpgaGQmPGJomOqNiCj0iEMEbQy4q0/qgN8dQlwGmZov5k
         TTOjye0oZZJGT+dK3JcofPvDo/Vmk2qvlZmp6Xf+8SA4K4yOP//XDHnSngUuerHsjKzT
         CCBws7SWCYPj3P98JZ+cJjcW0ra+jz40F1iUswf1Rw3QnCyTPCU0p0c5K5Fr07oGighq
         eahROyDl7bqR/49PhfCuW/LiCoHd6bGHgU3hLWD3cMV4PKobHv6+1W5KvSyvq4Hp5MOT
         9mMAxY/1nPP0LSlMYYXdEaP/zp9zcuot9WF5+OMQYJtsfU4lMGFNnMy9kLByBVmCppfx
         ldyA==
X-Gm-Message-State: AFqh2koOnUwNljRcnLjbXZ1AFpA14pomnx+FxV4dTUQCDsrTbgqevfIx
        OAFq6DKtO4e5/VeIY2Ih9kfGOkjBCI8woTPNSpYS8cFg7IG035zGi6CxNFYkG26tFLB0U+l3FIs
        9Q7RGP0zpdy62O5AOMXV+YH7a
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr1014188wmq.5.1671528775022;
        Tue, 20 Dec 2022 01:32:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtkJLPUngoE7Rdpiz+7rMSQUZVxCPiiE7/wiftR1AcmdksgPntUPs9xb4hKM0A1bxh9x31lEA==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr1014168wmq.5.1671528774842;
        Tue, 20 Dec 2022 01:32:54 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c510d00b003c6f8d30e40sm25405979wms.31.2022.12.20.01.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:32:54 -0800 (PST)
Message-ID: <12990f75-6b72-7ed7-0593-1c542d71f0f0@redhat.com>
Date:   Tue, 20 Dec 2022 10:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/18] vfio-mdev/mdpy-fb: Do not set struct
 fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-10-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

[adding Kirti Wankhede and kvm@vger.kernel.org to Cc list]

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in mdpy-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  samples/vfio-mdev/mdpy-fb.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> index 9ec93d90e8a5..1de5801cd2e8 100644
> --- a/samples/vfio-mdev/mdpy-fb.c
> +++ b/samples/vfio-mdev/mdpy-fb.c
> @@ -161,14 +161,6 @@ static int mdpy_fb_probe(struct pci_dev *pdev,
>  		goto err_release_fb;
>  	}
>  
> -	info->apertures = alloc_apertures(1);
> -	if (!info->apertures) {
> -		ret = -ENOMEM;
> -		goto err_unmap;
> -	}
> -	info->apertures->ranges[0].base = info->fix.smem_start;
> -	info->apertures->ranges[0].size = info->fix.smem_len;
> -
>  	info->fbops = &mdpy_fb_ops;
>  	info->flags = FBINFO_DEFAULT;
>  	info->pseudo_palette = par->palette;
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

But I think an ack from Kirti Wankhede or other virt folk is needed if you
want to merge this through drm-misc-next.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

