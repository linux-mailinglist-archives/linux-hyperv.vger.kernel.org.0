Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C540651DA9
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiLTJld (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiLTJlO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472171123
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=DhiHk/HyImR4HtOMcFN2LQsGDLUfzWRwh3sFdcTSOXC1iJq7ca4jlIQNnXv1idjBWtUnKP
        IOOySZuIBlswiIhQ7Zj5LMjCwJEspwvGbdp4Q6uBkUk9hverLhJ51jx3ipewVNL1569JWy
        BztCJxnbz4qb3FNgdCDwlF4NWX9JRBM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-jx3q-E-SOw6IcUw5DxoGgQ-1; Tue, 20 Dec 2022 04:40:32 -0500
X-MC-Unique: jx3q-E-SOw6IcUw5DxoGgQ-1
Received: by mail-wm1-f70.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso6308972wms.5
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=rqR0ZBc4NEbF6EeyiDfpZre3qwa0Ek/pcHe0lDOcDXxEAyBJstLUBHRYyCDN63VdVo
         tlFsDHTNeHuZg8bxQwLABHtTflyh87D88l0A3sSKSKrEh56QZLIuLDOBTw1xDHMC2wT5
         nEYivzZau53RboXzVkvEKi8txYMqAYyO/Aekxo6CTMvWc6IJ5rMPhbp7XPzcJgXzc+a5
         nNLc6DdYjcKC38JjAeG9JfTOxfWa5CpBgo3SztKtlb9b5yPGpGUAcdd+1f0Mp5y133mm
         ChYJarlK7GdaXEIhUyXIoz8F9DgZLOOAMoiSNrGefcgJnUuYelfEFryq+Yxh5EiuK9vT
         Urog==
X-Gm-Message-State: ANoB5plHwOMYvHTVLBpMI+rjJWpS8i9OnLsWtCKik9IU1p7AkMNlpB58
        SI/CD4Fvm5dIHOdyiMG5pDnQlPIYeGz5TZBbJjzknqF1rmFO7dEp/oxSCiRo7Gk9tYuzo7nlFP1
        Lyg/4cWrPr+yQULaqPDAXxZNa
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id j20-20020a05600c1c1400b003d0965f63edmr33960387wms.23.1671529231163;
        Tue, 20 Dec 2022 01:40:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf71wOlxFtTuSNW/9jMXBnVwUZwb2b/kuKlWfvoG3RUuoMrRINee90ZtVa/GrwK8ITxjbcPFuQ==
X-Received: by 2002:a05:600c:1c14:b0:3d0:965f:63ed with SMTP id j20-20020a05600c1c1400b003d0965f63edmr33960383wms.23.1671529230999;
        Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003d1f2c3e571sm24392373wmq.33.2022.12.20.01.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:40:30 -0800 (PST)
Message-ID: <1dd11b16-bf9d-4b86-14c7-095804a2f66d@redhat.com>
Date:   Tue, 20 Dec 2022 10:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 14/18] fbdev/simplefb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-15-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Acquire ownership of the firmware scanout buffer by calling Linux'
> aperture helpers. Remove the use of struct fb_info.apertures and do
> not set FBINFO_MISC_FIRMWARE; both of which previously configured
> buffer ownership.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

