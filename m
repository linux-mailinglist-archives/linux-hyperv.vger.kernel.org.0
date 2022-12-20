Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013E4651D26
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLTJU4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiLTJUq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86192D2E8
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
        b=WnPihU+vfoHV2bn1BbhoanVL1Ohe6aVQ+nQoht4oRG1UB5JFTKWn5YRgn2w4mI1Bprt+EG
        fikBvyf23yllhuoU96+8Irj/POOpM4UMqPZV6VbYixO21TcFCBplFwEubl9wujgq+1Mm3R
        TCiFigS6kcLYld5hTCqBrvgk8r7mZ2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-dIHx2GawOE-Gej1Gxz4Vug-1; Tue, 20 Dec 2022 04:20:02 -0500
X-MC-Unique: dIHx2GawOE-Gej1Gxz4Vug-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so177474wmq.5
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OcEOi6wfApoNJ5QX9xUUF80M6DZAUCfFxv9pSqRsVA=;
        b=yu6WTYPU9+hmv7zVLNfbIahRJKQctDzKwiHcvHRj9XoGmChDkBK/Rs3xCbGPn7n9cN
         Nzz0d3QDHUU1z+0TUg2+pdoneY1+X/ap9bTOS0K8nuYuLlJmKY3bKHWx3JEmg6JVNbIn
         YW7cB5cBW+aH57aeOZ0Ti6OGFuUZlacR8EWhbltV3tvI8BO5PNMYE8/aNgL+0XFur8NW
         biRd2j5J3OB+40vvsrVeOYuOSTFsnsn+TqmFJwyDjmcVHeRVITypY/qzeEcgyzYOfcUq
         q76RW1aFzZd2jYu4mrcvq8T2uQ/HOcmR4jJ/VdW98+qPZoiwi4UnkGQQYeHCUgfn/5OE
         9/Pg==
X-Gm-Message-State: ANoB5pmhdgSgMiwZtPqltGQfV96M9mpqSEEEVO0qZ63TWuQ+vnbNLVlV
        dlX3P/t/sf/TL8/ulxI3YeePbK+9P4A2ysmbClnnl77rYAxLuBSX3F1ZPK5c7IrULWuexP7VTR0
        oMNWdNhlxgGuIW0T9PMgDl9Rn
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id n5-20020a05600c4f8500b003cf93de14e8mr33662650wmq.39.1671528001147;
        Tue, 20 Dec 2022 01:20:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YfyRC8GN1CmHHU+h6zQnG8fHr/grTiv22vuNVltDRj2C7JBfNLZj3eqwiClNyExLknW6NJw==
X-Received: by 2002:a05:600c:4f85:b0:3cf:93de:14e8 with SMTP id n5-20020a05600c4f8500b003cf93de14e8mr33662634wmq.39.1671528000916;
        Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p16-20020a1c5450000000b003d07de1698asm21890206wmi.46.2022.12.20.01.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:20:00 -0800 (PST)
Message-ID: <bf88b4bf-4c81-29d3-3518-ef149f93265d@redhat.com>
Date:   Tue, 20 Dec 2022 10:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/18] drm/radeon: Do not set struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in radeon.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

