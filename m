Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CA651DED
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiLTJrw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiLTJrX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73111123
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
        b=gCuf+TYmqs899gY3Z/Oreyd0KYIY0DmbgF84SxgL4fK8gHs6rM+m4KMKh3W8ZuretoEyfs
        3mR18buTB6Pw7lrccI31YEKwjFJ2MW2Jbccl9uxljMrNmCuv7x0q20GuZSp95/cQS6epi5
        hb1g0hL5vDbxBQS1TNFLmZcx5FN3l80=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-GpxP9x_GP7OCeucB4oyTpQ-1; Tue, 20 Dec 2022 04:46:37 -0500
X-MC-Unique: GpxP9x_GP7OCeucB4oyTpQ-1
Received: by mail-wr1-f69.google.com with SMTP id m24-20020adfa3d8000000b00242168ce9d1so2091694wrb.15
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykdKuygOSTPkcM25esQW4i241lwYH2V5lSGsmvsr/ls=;
        b=zgGr3mJDV2PsROCw5zDPJDBvsWClXATDBwwcBp8+RGIAMLNitmT4QXrFkYSvm3XjZy
         ArPgmroufvbrJdNhjgHluWNtycV+fX7FudJpVRoglPFBqKtNuf+pPy07nU+CEZ3kHAQr
         GU0fpBLYp/NnA2QAM9DojyP2/QW026qjcdCDG0VTeVXbmHGzDc9BB6zCTexuPqjf3DLY
         7IrzEK5bZi5heXcphEexW6RNdeVvYwawcjdrmQpJcwyJe7PnFaCF78OsyfZ3hf4tJGoT
         VUT40m2ZNliiiWAUEU7TARrVgavKn4kACA/KFs8XzrKBDWIJN4FqBK5KjY2qwcrJmYYg
         K3JQ==
X-Gm-Message-State: AFqh2kqySOx/T2VjZDK6eMp+yrW1ot9E2PM0GYwSucxX/M87Q9gPvtm3
        TPXoxSy0dtojrulmksJ1z9HIFFAGbT2z4pkSu6WDbWwwwqPD3wny/9TzK591swzo2H6Vl9QYb4h
        4+0hXKusvMSS8gkUjmDpIFo2e
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id bs24-20020a056000071800b00256ce1b74acmr19147677wrb.29.1671529596405;
        Tue, 20 Dec 2022 01:46:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvJLK/eM71NU46wbs2aboKoDtpTCvPv8+GeJSh+yzufeE4NK5CbBNZkmGr9N2Pg6bIDfe3F3Q==
X-Received: by 2002:a05:6000:718:b0:256:ce1b:74ac with SMTP id bs24-20020a056000071800b00256ce1b74acmr19147664wrb.29.1671529596230;
        Tue, 20 Dec 2022 01:46:36 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002365254ea42sm12325758wrs.1.2022.12.20.01.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:46:35 -0800 (PST)
Message-ID: <978cd907-65ce-2a89-e046-17a75c0ab832@redhat.com>
Date:   Tue, 20 Dec 2022 10:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 18/18] drm/fbdev: Remove aperture handling and
 FBINFO_MISC_FIRMWARE
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-19-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-19-tzimmermann@suse.de>
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
> There are no users left of struct fb_info.apertures and the flag
> FBINFO_MISC_FIRMWARE. Remove both and the aperture-ownership code
> in the fbdev core. All code for aperture ownership is now located
> in the fbdev drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/video/fbdev/core/fbmem.c   | 33 ------------------------------
>  drivers/video/fbdev/core/fbsysfs.c |  1 -
>  include/linux/fb.h                 | 22 --------------------
>  3 files changed, 56 deletions(-)

Nice patch!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

