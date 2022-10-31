Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA586135B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJaMSR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJaMSQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C7F02F
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667218634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z23uByta1RO7RusYzzGag4IvKSimSY8jEax7dgozF+A=;
        b=Wki74xth3H3FhtyZk5sw0JKwEJrGPqm+zyACffzefkZHAiSGgT4iGn63PZb3kPY9UMKBON
        z7+WMtfvUSSscZoRXf0zOb1J5bll/lSFE4Q+QQwK7Xg/OPoxGkK5j7c6gQaqgQKrstfh9F
        vTkdl9DNydx66Sx+fMIogrHWEdJwAmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359--_F8UfooNvG-2gd0xF9w1g-1; Mon, 31 Oct 2022 08:17:10 -0400
X-MC-Unique: -_F8UfooNvG-2gd0xF9w1g-1
Received: by mail-wm1-f72.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso2545174wmj.1
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z23uByta1RO7RusYzzGag4IvKSimSY8jEax7dgozF+A=;
        b=ugUt5nH4DuHO1aM2HAy9RLSEIS83pbEmDzvTQ83g5AqKrir4EcR7uNTspnwpD/h+uz
         umRQslgPlmUwYnjqEMSxWXb4Zf6XUcH38ufHZX4O7UJXMnKjC1UdNy6dWFSpdNZE2VwK
         Xy81VBCCgJDUP5wZ00TBcDqk5T75iIWAt1mEIvjXnZhTs2jMwDVzh8G0XnHzOrIGZ4Kq
         NIINEz+5r/fG7RpPNJx+gvQbuZ3gdbfve4MPKI6riJa2oV3rJY7MyQojSbdNJgXpQlPx
         tsr0lhR1j1XVWUtJecnj1q7E2l36i1mnBLm6leKU9W86ZTlmRbmfwnSV76bM0+pSwwUn
         lgKg==
X-Gm-Message-State: ACrzQf2IKBzjstFnAj7hkkj7YGO1d7uRKP6NTA+cDQGnTrSkDKbdng6a
        C9DMUD02gA8aTvG+an2pnDZd4db1xzjrWIXebwnFBOA8FcnmG3WyVZohx1u1eAPFYVut+nsrKcq
        agf+KFtrjFMa/IpmzcRjMgoGf
X-Received: by 2002:a5d:6da2:0:b0:236:7916:a9b2 with SMTP id u2-20020a5d6da2000000b002367916a9b2mr7921495wrs.393.1667218629373;
        Mon, 31 Oct 2022 05:17:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67BGVEVFx5kckaS0oDiow+E3wYJXdivRHIvOOROl9hHnAsaKyVcMk8ZYE1a2HK4LSTJkXvEg==
X-Received: by 2002:a5d:6da2:0:b0:236:7916:a9b2 with SMTP id u2-20020a5d6da2000000b002367916a9b2mr7921473wrs.393.1667218629159;
        Mon, 31 Oct 2022 05:17:09 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b002364835caacsm7133274wrb.112.2022.10.31.05.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:17:08 -0700 (PDT)
Message-ID: <efe0c7bd-0b14-b829-cc41-fda316952a51@redhat.com>
Date:   Mon, 31 Oct 2022 13:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 06/21] drm/ingenic: Don't set struct
 drm_driver.output_poll_changed
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
 <20221024111953.24307-7-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-7-tzimmermann@suse.de>
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
> Don't set struct drm_driver.output_poll_changed. It's used to restore
> the fbdev console. But as ingenic uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See the
> functions drm_kms_helper_hotplug_event() and
> drm_kms_helper_connector_hotplug_event() in drm_probe_helper.c.
> 
> v2:
> 	* fix commit description (Christian, Sergey)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

