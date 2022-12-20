Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87F651D89
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Dec 2022 10:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLTJgf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Dec 2022 04:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiLTJg3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Dec 2022 04:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3BE7
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=DQf1sAgvUmpbBb6WOSRRbstBdpoNhZQhOIcRqeC6hgW5b5k9f/Jh3aJaO/xQ4YMy4l7sFU
        YHGeKo2rKM5V2vI7UphsUha9T02uFy6utgjEoRaTjdLvdGLeggGvZL29EELsUHh1pWBhqQ
        1jugf4K7spOmm+PAZvAfgI2hebCEm7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-EuuF0zO1MhG-8544Ve9B0A-1; Tue, 20 Dec 2022 04:35:34 -0500
X-MC-Unique: EuuF0zO1MhG-8544Ve9B0A-1
Received: by mail-wm1-f70.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so2688332wma.6
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Dec 2022 01:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4eLv+5To8BjnLItTbs6pq8g5LjZHk9PMjLEQIi8Lo=;
        b=AEPxDyc6qLfPxar0TYzT9Q+54oz9UJNiFZv+ocVtnOuK9w5kD015tFc3WPD3HpM1lh
         hk7oy/B8FRZO2rc2xVRwjf4XOVQ22aAlv8XdkW1GzkZMU2n93iD6F5L8E8npJXq23Pgv
         gC1gNVLK1boDCqNRCXjInCVv5GKH33WFVOFOM03b93SCNvR6Z2Wo2yBVz+kJGXA06PTN
         VOAON0uwP4AGYL9cweBax9P80ce/HJmuTE56nFAoeKoJdNEr8e6eXB1TB1TYgCoa2mGA
         MoMIYQeiKXT3ykALMA0f1PkbYPq3eUBDxpx2l/iq/W+cSUGimfZ8PcafNfB3wtUQAgVZ
         UXIQ==
X-Gm-Message-State: ANoB5pkFtxzMKtFX8nTzxgAX0IkPD60j0NPPNa8T/MYjNol5YsMn4pr5
        fHHfP4A8bva/fHwnOFm5PRaluV6Xkub11LoPriMXPUe9b0aVVkDK3TTkNB71QuZC3YyuGT1AyzG
        cogcHOQ3B/kbD6r1FqCT0nZ0j
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id b12-20020a5d550c000000b0024227131fb9mr24605042wrv.16.1671528933090;
        Tue, 20 Dec 2022 01:35:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5UgRh9FZeAQW/rgYS4tJcqcpMr2W2F1LauhongkzEysTbAsUBQfYpe3JzD17C7VFjb9x9qPQ==
X-Received: by 2002:a5d:550c:0:b0:242:2713:1fb9 with SMTP id b12-20020a5d550c000000b0024227131fb9mr24605033wrv.16.1671528932912;
        Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b002365cd93d05sm12313762wrs.102.2022.12.20.01.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:35:32 -0800 (PST)
Message-ID: <c8c3d52d-896b-b38b-00ac-b1686fc4ecaa@redhat.com>
Date:   Tue, 20 Dec 2022 10:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/18] fbdev/efifb: Do not use struct fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-12-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-12-tzimmermann@suse.de>
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

