Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E901C61361B
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJaMYG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiJaMXt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B4F5AD
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667218957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVJodACOlUyVw6jJB0o/QffeIPQi24/sF6MmyMfBvgg=;
        b=cQR8nJq5KDjwUQjNGMu5s/Rc3/w7+X4ttuzy+F0WtDh4Fmo42XcUfKTQzJy6VHGoQMtWkg
        9fwe1XVxwk16thcxKoYeFI+3pBBcWLWLs5nwDLhdyswr6dwFns9KGWp4e80Dsy62CD8RfT
        KddJLmRyH7bmbBaTxiqOOrx4LgTpUtQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-yOJi0jRbOLyzHKlW54CaUg-1; Mon, 31 Oct 2022 08:22:28 -0400
X-MC-Unique: yOJi0jRbOLyzHKlW54CaUg-1
Received: by mail-wm1-f71.google.com with SMTP id h204-20020a1c21d5000000b003cf4e055442so5237721wmh.1
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVJodACOlUyVw6jJB0o/QffeIPQi24/sF6MmyMfBvgg=;
        b=3p1zmIU0rWkDm0T8JonSFDEH1hB6cCEpMbpKlv781V7UDHof9mhtHTvBG+//q2uQdC
         RG6+KMmfTCCeP4JPTczqT1ucaanbuOg+HGFv3kP3lHlJVZ+qsidRbpZijell43jSefCo
         SvkuGjYCM3DrElWhHNxFylLAiMdgfz/gC26bcnTwBKvxzEN4uihX/28fANIGmnsPU/VV
         Wt2lqFFLL0dX7Z1ecXuCNhk5us5+2/aaljWQeMMKC2Fq6/way9TZp6N9jANZ/t340YWN
         cbXepREY/fl0FMskmmXDfJa6iOt+hE/Jijp/17YrYaiIg8Qv0pQOjMQ67RC2hSzpPZZT
         UzBQ==
X-Gm-Message-State: ACrzQf2NyZbILr2M5c2r7+ldWm5dpUAHbI6D1GQqueV1Lz1twNbHurKz
        erW62DajKLdhTkxIAYFp4fRqKEGeeuHdwDd7iO0Jflmr6vs61rgbUrVVjodTa699okGNRj966zJ
        0os/dkc3yqpHv1VsGRRv0PuQ4
X-Received: by 2002:a05:600c:46ce:b0:3c6:f274:33b2 with SMTP id q14-20020a05600c46ce00b003c6f27433b2mr7860192wmo.27.1667218947041;
        Mon, 31 Oct 2022 05:22:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zVdpLNc1mYDp74XAWVtjpPddzcwMDONTh4D+G0X15w3fKqsphKr/pP9hn5PrcknLAkhJ5Mg==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f274:33b2 with SMTP id q14-20020a05600c46ce00b003c6f27433b2mr7860165wmo.27.1667218946788;
        Mon, 31 Oct 2022 05:22:26 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c4e9000b003cf568a736csm5157904wmq.20.2022.10.31.05.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:22:26 -0700 (PDT)
Message-ID: <ea046b06-fb0e-b7c2-8f70-b299401d9adf@redhat.com>
Date:   Mon, 31 Oct 2022 13:22:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 10/21] drm/tve200: Include <linux/of.h>
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
 <20221024111953.24307-11-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-11-tzimmermann@suse.de>
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
> Include <linux/of.h> for of_match_ptr().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

