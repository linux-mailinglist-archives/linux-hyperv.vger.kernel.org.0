Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1DF613567
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Oct 2022 13:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJaMJ3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Oct 2022 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiJaMJ1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Oct 2022 08:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693BABFC
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667218101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzviKTRQBMSKwIl6kvNWZgMaFQwic4ec30sKv7m652k=;
        b=HVwgxIFnTQWShJIbAp+p3yMHeOQrB6J5obh03OwUqlJlXbm90w49w/nPJiu98HKGScM9Uj
        vcR2K1W6wwdh1fa05SHdk+3fuL31eun9CsHTnQBBPzXgM2GVsUWvjC59Qd/0aT4EbN9Vql
        WRS4q8gCbvbwjjBXqhS0GpswFgCgaLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-nis2EqYPO9KEFpzDf_4E3A-1; Mon, 31 Oct 2022 08:08:19 -0400
X-MC-Unique: nis2EqYPO9KEFpzDf_4E3A-1
Received: by mail-wm1-f69.google.com with SMTP id i7-20020a1c3b07000000b003c5e6b44ebaso3372361wma.9
        for <linux-hyperv@vger.kernel.org>; Mon, 31 Oct 2022 05:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzviKTRQBMSKwIl6kvNWZgMaFQwic4ec30sKv7m652k=;
        b=25soPN67TEMXSc3DdDRbWja5UpQIe9nhbBMhzcALULeCMPi9f4fmf1N+jr4HZcJ99o
         Ax3MIowBeBobAojDZSLKXpwbi/ZnHiXp4K2rDnUa6Ypg7HvmsaYaePHnBKlN7E7hgMac
         0PNwTM5lOqKIjkcnIEqOir290cH+flswf42n0DBspOS0si88H+ix6GtHYXQK5S1a1V9t
         ZP8kNvm8pRMJdNOh+7FqiGXkZnyN6G39j8iF5Jmkm05deNy+xzESJm7oxOwZi5v0/NVV
         xl3+Q070apNVW9t+HScB/x9QfqnO9ebSm77D3J1LEqX3qoXltWV/h5ZM+xceVSCd8+Fj
         EynA==
X-Gm-Message-State: ACrzQf2R9EbMV9XZS8w1Han/4TT7jM3VZInlxgAnj+GjuFdeIcH+ZNgq
        bjjHRePncWp+0agu3DMPcg9LVWsWeyTToJ1+n46OoFxVMeuTvh9OgXntrV26zXprD0OEwEt8bJH
        Pno3qViG6ATdQYOR6cNetxljN
X-Received: by 2002:a05:6000:15cd:b0:236:9701:7939 with SMTP id y13-20020a05600015cd00b0023697017939mr7691189wry.248.1667218098869;
        Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Xfc/ao13H30KX93ABjLq4iUJ6oQF+1EOXF8gvz+3LvWSBMjjIijdjEWsEsBBK0GpYNHL8UA==
X-Received: by 2002:a05:6000:15cd:b0:236:9701:7939 with SMTP id y13-20020a05600015cd00b0023697017939mr7691171wry.248.1667218098682;
        Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bn26-20020a056000061a00b0022cd0c8c696sm6948033wrb.103.2022.10.31.05.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:08:18 -0700 (PDT)
Message-ID: <fd53a4f9-34a8-f5f3-1b1f-baf4a456bcc9@redhat.com>
Date:   Mon, 31 Oct 2022 13:08:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 04/21] drm/amdgpu: Don't set struct
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
 <20221024111953.24307-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221024111953.24307-5-tzimmermann@suse.de>
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
> the fbdev console. But as amdgpu uses generic fbdev emulation, the
> console is being restored by the DRM client helpers already. See the
> functions drm_kms_helper_hotplug_event() and
> drm_kms_helper_connector_hotplug_event() in drm_probe_helper.c.
> 
> v2:
> 	* fix commit description (Christian)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Do you think that the fbdev helpers kernel doc has to be updated to mention
that drm_fb_helper_lastclose() and drm_fb_helper_output_poll_changed() are
not needed when generic fbdev emulation is used? Because by reading that is
not clear that's the case:

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_fb_helper.c#L86

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

