Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B306613625
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJaMYu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJaMYs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00731007E
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667219003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQCx1YM0kmrgAAcvKhWafunY3KuhCAquKBUmZJVCfV8=;
        b=OXxETfR4g8DTtsYOgeAYKp+EQgjNGaqLLCMi4dhrYZ+lPfcfdS5h5O8mwAFhR877yun0Zf
        nn2XbQOGwj8SjrqEVIoXsAliYDbiWm27JjHNCKViA/plFCtoSisI7Dw8DPfoOt6SWLCrcj
        xhNghWqsLn4MotOmVecD81rNWnwv9F8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-TQUp28VVOFip_uYG1GUg3Q-1; Mon, 31 Oct 2022 08:23:19 -0400
X-MC-Unique: TQUp28VVOFip_uYG1GUg3Q-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so444594wme.7
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQCx1YM0kmrgAAcvKhWafunY3KuhCAquKBUmZJVCfV8=;
        b=GSJhn/K0baKLDcudOx1g6yX4pOMe/NLY/sd3Qzg30HOBTFZ/OcBVSc8EKfgtPmct53
         4NBzye2rdKmM1JjRHnjDzvcge4ArhB01t79hyolcpMLyeKkH4wk2fvOFPJ4l46DfKIl8
         F7wZnzJJhkgCji7kaCy9oJjbo1f+ZA7m+myGlFxeAXyudZDRQ2ZcFbejI/IY4BZEAALw
         xfI7+026Tx0SDj9i/PqRFL1k9z9HjWV/PrgRGi21nhLjaeBdxyC6mbtmd4wzhAK3pHEy
         aA/wN+a5RyYIW1rtrGP5afiRCAqh1usojPsIxJt5tRM0g4znlAf2/E3GRV9AUu/Rjkss
         sRjA==
X-Gm-Message-State: ACrzQf3G+EI0buFapIaAO8ZpikSYs0D9R2Bj04ZqR4vOFAiBIx2y7PES
        x9RuvWt2OoFNxtVno8DR5HcGSebzVQiMUO8N38ylkpL24OtjBNv0vaUAwNyUp0uYiZIgaXtwvpj
        tJcCYOLWA8ycu2cih9Avpz6tt
X-Received: by 2002:adf:aa8d:0:b0:236:588f:71f with SMTP id h13-20020adfaa8d000000b00236588f071fmr7582891wrc.205.1667218998717;
        Mon, 31 Oct 2022 05:23:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7e34dAcxvP3Vi0CwbwP1YeMi235O6q6VyKCYvEf93eDT38FEWiyAv5s+MTc8QNv7Bgz3ny/w==
X-Received: by 2002:adf:aa8d:0:b0:236:588f:71f with SMTP id h13-20020adfaa8d000000b00236588f071fmr7582855wrc.205.1667218998538;
        Mon, 31 Oct 2022 05:23:18 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ci8-20020a5d5d88000000b0023662245d3csm7011927wrb.95.2022.10.31.05.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:23:18 -0700 (PDT)
Message-ID: <63a804b4-ab2c-f5b7-73b5-edefdeff038e@redhat.com>
Date:   Mon, 31 Oct 2022 13:23:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 11/21] drm/fb-helper: Cleanup include statements in
 header file
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, sam@ravnborg.org, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20221024111953.24307-1-tzimmermann@suse.de>
 <20221024111953.24307-12-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10/24/22 13:19, Thomas Zimmermann wrote:
> Only include what we have to.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Nice cleanup.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

