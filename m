Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8B651D9C
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiLTJjd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLTJjc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8DE7
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=Ib6Q8VoT8WxT3qwYus5iweZRKoFB+NY3ErkFXs636JFMVczDr2ZyRjdVtOX3vVTv7CvoL1
        okTNh/0sR/XNIx957+Yw/y83IiBg/m0QLzhJb32Q23TJ7IN8qVe+fwTlZ7huXiET+8RI5y
        NMOiNOldKCA0TuEKBhXZU3NQ5URN/6E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-3d6T6apJMWuVg3ZseOKDgw-1; Tue, 20 Dec 2022 04:38:46 -0500
X-MC-Unique: 3d6T6apJMWuVg3ZseOKDgw-1
Received: by mail-wm1-f69.google.com with SMTP id n8-20020a05600c294800b003d1cc68889dso2400353wmd.7
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=mb9+0LlydrBrzmgazNuzO1rzc8ZXS7crF8a3M8EYryUtMgCXmXlji7ul30ZFc/y7Mf
         NmcvS9khW6HttwvRw/JeMh+KlhfK6DF0cSbhhNlSSAZGrGiHF0ynF6266N1aYJTBt9nH
         M+CI6gK79vexAnJaJGDUnpzRUnscFLroMuCBBrROlXKuOY5R8ccGFFJ3ohFNBuXWnA0G
         WXx3CC5FZQCOwV2Gvp55cVZz9Go80jIzQ+6fqTiwU2XDvDf7eUL5G6EDxKV920+vAMa6
         MRN7mxa1OIhC8VeIlxEt5MWBLzEt8T60y394jvbjvbPIiGNEji2g8pwH+r8s/6CoO02H
         qddw==
X-Gm-Message-State: AFqh2kqIWkSfhKG7npvegAlaV6B2YK3IbWUUYJq2RmdKHkZjNQdWoI91
        zxEBt4xi4sO79GiQU/6WcedUukj9YsHAXV2yvw6d+4A6maHSTok3HmXdblH9mK/rLq/3igAQmA0
        GzZRv9RdOilK8zh/6u7S2ED9Z
X-Received: by 2002:a05:600c:1d89:b0:3d5:64bf:ccc2 with SMTP id p9-20020a05600c1d8900b003d564bfccc2mr972469wms.32.1671529125274;
        Tue, 20 Dec 2022 01:38:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXslpFNWgJA7+1mAYcupIJ/r6e/d06O54fNaPmM/ERkGUAWuMMiWYBSHcxiARgbY+lIJOxnk0g==
X-Received: by 2002:a05:600c:1d89:b0:3d5:64bf:ccc2 with SMTP id p9-20020a05600c1d8900b003d564bfccc2mr972452wms.32.1671529125099;
        Tue, 20 Dec 2022 01:38:45 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003d220ef3232sm14481191wmp.34.2022.12.20.01.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:38:44 -0800 (PST)
Message-ID: <bc75ba60-9fb4-dec9-c7fd-23e50942f7f0@redhat.com>
Date:   Tue, 20 Dec 2022 10:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 13/18] fbdev/offb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-14-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-14-tzimmermann@suse.de>
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

