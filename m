Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBF651DE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiLTJrQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiLTJrG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:47:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555A18E37
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=IZZrmHibyrYGzbc/bU10800R+I6pK/iRTyKA0MpxvinXsS58o+UrLK8m9SphxKR12AU6oq
        Xs2h2vpLfx5YJQv7VkdEtOxqLT3u3pr3Tyx34RQcOxUPpikXQY6PR9K36uYgA3sL5N/j5Z
        a32sjiOiakbDQc13cPGbd7iCSusdX94=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-qnpu6zuYOsqocFQtJ_G9NA-1; Tue, 20 Dec 2022 04:44:53 -0500
X-MC-Unique: qnpu6zuYOsqocFQtJ_G9NA-1
Received: by mail-wm1-f72.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so7813097wmb.8
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=W+xGkVOnFOj12htzH5Es/XMlYPot2srgGIg8x+gZRjA47z8dDsRrF3pV7rB6TErGGz
         EgLHD11fxYZbwTuVY5aX0OWaSrXS/AVHxqchZKqKTja+zK33ISBaAijpxdKh0BWdNFWk
         ADyNsQDPJ6HxAFPY4AY2YpX3EPOChS1FG/b+uBCUdcYQMTNNfkbvlrfxBG5ZA45tzeYX
         9BpW1hwKmsgzpP7iaZMW7fTMISlMnMGlwsjMp7624TytvNJG8xX1W/vSgUUwil/20vhy
         1PvdfBgg/h3miRFZYogDm2/MwaPE+h2bi1ZC3lzHFhoNGDqfCk0dM1mfe4g2CYosyBYX
         AqBQ==
X-Gm-Message-State: ANoB5pn/7wCtK9/KINjBQECddbw3NckdJJ+mR6NsKoBw6B8LxiFqBdvF
        9Od8pDVFvr2hgAILixhxZR77N+dWvr8GWRg3cShl03n8fdkiAdrT24zlNo10mZuReHmipr+6w6J
        SW7e2veT+OAF/McJrhiVZM5EL
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr34866241wmq.7.1671529492809;
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf74M8Sm1ZUMeD1MRSt8ye6pyF2JALOeT/hhACXzocPTXyP3LI6efvyoi2Xa1weHvEDgcZ0pkQ==
X-Received: by 2002:a05:600c:3508:b0:3cf:b73f:bf8f with SMTP id h8-20020a05600c350800b003cfb73fbf8fmr34866233wmq.7.1671529492648;
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020a1c7710000000b003c6f3f6675bsm21680659wmi.26.2022.12.20.01.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:44:52 -0800 (PST)
Message-ID: <cb8af91b-4d5a-6d0a-6604-d99fc4a0f0e9@redhat.com>
Date:   Tue, 20 Dec 2022 10:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 17/18] fbdev/vga16fb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-18-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-18-tzimmermann@suse.de>
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

