Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821E8651D45
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiLTJZA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLTJY7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:24:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A616308
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
        b=NqHjdVkyXrabLYecQ7zyu+04hEaQxoKC6HHkvgz88Xvwo9w5ffLD+xcZuXN4crYA2Ca6gG
        A/RCWXSzpGbEsJVInkrFXZAqaIHSS7Nn1nYC0CI3+0M3/4/aqXvq4Gy5qaO4NwbvNaCNgX
        xaOOPs1HkzGQtV5J0ReFRA7K/x10oNU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-OOlEbDPcPey4wloTOHAmnA-1; Tue, 20 Dec 2022 04:24:09 -0500
X-MC-Unique: OOlEbDPcPey4wloTOHAmnA-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so181795wmq.5
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYMKnwowgCZbmQLyZb+O1xPkwcQc1vWKiI5mpSCZQTU=;
        b=Th1cWPC7Ipdw6iGRd0uL1wBVp0LbSZ66hDtlTvnamZy3XoJTWn9jo8vWRH7TK49Urk
         TMC/khOTlf21Y5E26dKpN6oFE1OocrjopaxFI4LZruPQy2qKhgJJRKMd2tHPvf3EluKI
         XqPWCqdxVlQHZ1v8rC/0e+g/SiuWceigMBasJ8oghch6/oiI7jBbTnDPp3SQtqRSBW+u
         DQMx6kPVy24VnMM9HMxS2PRIXC1uehDUVIPGhEcITb3eGNy+Su3it0aifoikmn/D+zif
         E64ADh9ZeYRryj1b/qlHOPZV5s3mZA6N2KSkJW931js+O058hAGjTUX6/kIBTyRLm0Po
         4nxg==
X-Gm-Message-State: ANoB5pkKTB2rUBWFo2t1Z568GjgRAs2UvMg1MFI8HatNc3qgDx+6PT8/
        vRimyiDNnRI376jUuGDZEZl96Tj0Qqda6BKw3dH0/XVr5ufBDDw4CuvYquhzGfLM0QI2WF+Oe1V
        H0sfllG6Z5lMPClKifos58jUu
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr34442421wmq.21.1671528248080;
        Tue, 20 Dec 2022 01:24:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63KxuIxT0M/bl3iLHanyFrnj5hgoC/KBz3bLt1CmA/PA7eDrziJ0q3Lz1WCcHGowxEUJxpPQ==
X-Received: by 2002:a05:600c:3592:b0:3d1:bc32:2447 with SMTP id p18-20020a05600c359200b003d1bc322447mr34442411wmq.21.1671528247925;
        Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003a84375d0d1sm24663667wms.44.2022.12.20.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:24:07 -0800 (PST)
Message-ID: <e807855d-cfaa-ebab-8aff-7a3e78b1967d@redhat.com>
Date:   Tue, 20 Dec 2022 10:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/18] fbdev/clps711x-fb: Do not set struct
 fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-8-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in clps711x-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

