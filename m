Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC1651D4A
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLTJZx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLTJZv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D726FF
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMFhZOuihLodO313fEA5R64i9CUhN9/n0ds4HavllAs=;
        b=iLfu5zOJwI5Oa37RMUSuWteZogrGUi5rXqWlUmm9QHW6kxu8Lwq6EwejgRhm24jNKuBD8q
        X4HISrO8c6IGyPdLYFIfrpLNnMziwYGkcknoILpoMWN/prFBECDLDEr5Aasaw3Vpbll7GF
        nwBJzxJyC8HjHlfINjhGz6tlxI8y+7o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-DJHizy9VNHGMu-X_kIlIFA-1; Tue, 20 Dec 2022 04:25:01 -0500
X-MC-Unique: DJHizy9VNHGMu-X_kIlIFA-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso6299639wmh.2
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMFhZOuihLodO313fEA5R64i9CUhN9/n0ds4HavllAs=;
        b=xSqKCjxqTPgckn31ZV+RgETPstDCsOFrw4HnumRgQusbViIsl8t6RRFEsFY/w2GfcR
         2nEdsN+najhhnFkXzF1BeLX68kbtiOA5Dv9dpJEoqOjYrU3lHfx6CfFtmdoPGkdJq9ns
         Esu98ASJPj952uTh8jV1ruJMQAnjC5Y54+PGTSMHLXTpoSsDPy/qh140sIkGi8Bcpu7w
         QfflncgFL1xoYDy9Uy3TDF9cpJa/WskAORxE6AlKEb2Wb2gvNnS/507OnhDvPt/OaBLL
         kpc+0OQLSfLYioTaWI0TYQcsZyDHd6IvxvSAgQ769M/8kJthjzTcW1P8a2RDnOEaOB9/
         H7yg==
X-Gm-Message-State: ANoB5pn1rhvl+uH4X8t/zrAuxEnMRk90Zp/MIpis8VjOWkFh+WX6BLqE
        llwMuoEGw+r21hAi+tfB1xhfv7HFSXy4DNV/zEu5kbNkkDwMtlGNhPRQW121Y/mrOjddOk8G3n7
        Ul9+3xinSE6T8w64qeBGW7C8S
X-Received: by 2002:a05:600c:1d27:b0:3d2:27ba:dde0 with SMTP id l39-20020a05600c1d2700b003d227badde0mr25905732wms.33.1671528300458;
        Tue, 20 Dec 2022 01:25:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6s+ju9wPrh/cxmy7d4OakLICIinEdQttdoLSS+PoembSG//ZlaMVN/BK9U8/HRYjVObQWlOA==
X-Received: by 2002:a05:600c:1d27:b0:3d2:27ba:dde0 with SMTP id l39-20020a05600c1d2700b003d227badde0mr25905720wms.33.1671528300274;
        Tue, 20 Dec 2022 01:25:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003d220ef3232sm14440188wmp.34.2022.12.20.01.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:24:59 -0800 (PST)
Message-ID: <cc578fa7-31f0-8cfa-4cdd-981d7303412e@redhat.com>
Date:   Tue, 20 Dec 2022 10:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/18] fbdev/hyperv-fb: Do not set struct
 fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-9-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-9-tzimmermann@suse.de>
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
> not set the values in hyperv-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

