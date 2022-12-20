Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A32651D0E
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiLTJTQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiLTJTP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:19:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B49DE94
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671527905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYPgbcL3YuPfVJ8jSVJcJdgIz73ia329cUV03P7B6jw=;
        b=bOUsTSXOlMEW133RLX9MsRAB4811MCey9OTVJnaZ3eEA571/b9gwHV5B6WNXf7edkud6xs
        liub5ALFpBwL4WsnGXAk11X1xIusxqBUe/EhDYsNZng3mc4Vtk8L9wkFIzNvPr8S7+wvi8
        YSK7xkp65bgbPBvFto8A5VDC6mv4peo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-i56NI2M5Pn-vgJwRE0zX1A-1; Tue, 20 Dec 2022 04:18:24 -0500
X-MC-Unique: i56NI2M5Pn-vgJwRE0zX1A-1
Received: by mail-wr1-f71.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so2084189wrb.23
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYPgbcL3YuPfVJ8jSVJcJdgIz73ia329cUV03P7B6jw=;
        b=YhveRSpRpdFlKvOEB6FYvqAa33x1jC/L9ltJL/QuP5xN7Kc8TKQUzD5VGYrRK2tfJu
         a9JtCH6CoZNquVGBQOIiJCjcD1HkFIOu7Zg9sGtZMAzbC9yRmmP06HxwswDGfB9GtQ+x
         srncGcK4jsSWIWhLGGlHuCooK4gl748Ih9N+emCuI5OHXqPHEMwCvCcAVywbcdTnMoJc
         BxKg4ih9Kv0r212m31p9e8E9MGA+3UQ5K5RTO98rJO2fB+ctoDiiLcbi9Gft+A/nCSXD
         QDbn8ioldkT519W4R4AqemIscT/EO37CsXZ7Yrfyl/zoNa7WejNVLxprKINFurS5QUiY
         h2yA==
X-Gm-Message-State: ANoB5pm3TH+pE1Wv6WC8OwX5zrfqh3/uCfW1Rui3gSS7wnvE2kIVsr3M
        fcPzkozluSFD4cLyzaIYT4Cke/gVDknrdXdGLJaA9tHnVIiVJdVe9fhpwiGOPG2mVirjbfoxnhh
        XpTh2hXme9oywPEYyk+WDC/P2
X-Received: by 2002:a05:600c:4688:b0:3d0:480b:ac53 with SMTP id p8-20020a05600c468800b003d0480bac53mr34783503wmo.12.1671527903072;
        Tue, 20 Dec 2022 01:18:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7a6jFw63UWWlEAcRGouWqv0+PyfmsRgEqFDZ0lDKi9NgqR6nR2LVLem8I8AFhmP6J9qXEYGA==
X-Received: by 2002:a05:600c:4688:b0:3d0:480b:ac53 with SMTP id p8-20020a05600c468800b003d0480bac53mr34783491wmo.12.1671527902879;
        Tue, 20 Dec 2022 01:18:22 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f24-20020a1c6a18000000b003b95ed78275sm14622837wmc.20.2022.12.20.01.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:18:22 -0800 (PST)
Message-ID: <3593e206-7c89-5cfe-1aca-d805ca76135e@redhat.com>
Date:   Tue, 20 Dec 2022 10:18:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/18] drm/gma500: Do not set struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-4-tzimmermann@suse.de>
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
> not set the values in gma500.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

