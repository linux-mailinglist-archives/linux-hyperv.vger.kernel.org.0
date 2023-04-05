Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E76D7B79
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 13:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjDELhA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbjDELg7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 07:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18D5B9C
        for <linux-hyperv@vger.kernel.org>; Wed,  5 Apr 2023 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+DpvBDLH+Q2wPQSf5T5cg/6dNPP/wKGiFxJjQmEyog=;
        b=IxiXzVH1pPYRcK+6rSSimcWB6C9QxFOiWK0gXNGhrVrYKmDuPodPvLymsab9lzhRJk6fHj
        oercBs/cBIcx0x3jis+gVMqc4Up6VdJGkfl6EWU6VKVsVtzrdheTdaLmRfYyqayyrD3Hoy
        2A7fxB77OVxc9LdckrOaEPmiAKsrrFM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-oN74Fq3XOleK_JwAj-Ny7A-1; Wed, 05 Apr 2023 07:36:02 -0400
X-MC-Unique: oN74Fq3XOleK_JwAj-Ny7A-1
Received: by mail-wm1-f71.google.com with SMTP id u14-20020a05600c19ce00b003f0331154b1so9071576wmq.3
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Apr 2023 04:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694561;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+DpvBDLH+Q2wPQSf5T5cg/6dNPP/wKGiFxJjQmEyog=;
        b=GcUGMVlf18loaudlaal8k3no/fwTu56Xpg33lD0fc/q0PpPu7hDhajjBQYvs316zMX
         NDxk5ngPDM55NDZ+7C6g9jU20AQD4HWTVfykuZ1/zq6ydVFpNY4jC+7LFoi15oS+l39i
         ADYKS5VLtsysry+ZzWpFKglUtIeYQ7SSPeHu4NhJ+gnU1Op99phMM0Kkcohstil+uqU+
         kQvCu9aL6aSLVjWcQDyqdVGlHKEp+oHM7hMsiw2Te6PrO5mrf2S0EWyWTTvdJQDYI/Ni
         lIr9qLtwIXnX6K9BnFrJ9Aq1pDA5kUDNvCm+7r+TWIXzMoDx1dElpof4+oSxdWaFhftB
         o+MA==
X-Gm-Message-State: AAQBX9fntNACsPq2s5GEjhjhNnEBKw2kCNYyUKpLajl4GTeBNMjRXjhU
        KxmTNXZiuqWFLd4XUHIxrJ7KjvpQiuQOrL4nZHSCl7jHxhU/Egp8PJjnbWVHfM7lyACiVxytgDu
        oFMdStBMfMcauwnVdpqFF3ehE
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr4156044wmo.5.1680694561794;
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVORkVRtNCVnhi+nkM7YfPRljFYApx+IgQsLCU6O8KIvYjIzhapPCjaV21ZdY+Tdfz0i9VhA==
X-Received: by 2002:a05:600c:2312:b0:3ef:6396:d9c8 with SMTP id 18-20020a05600c231200b003ef6396d9c8mr4156021wmo.5.1680694561477;
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003ed4f6c6234sm1954392wmj.23.2023.04.05.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:36:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 6/8] video/aperture: Drop primary argument
In-Reply-To: <20230404201842.567344-6-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-6-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:36:00 +0200
Message-ID: <87sfdebly7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> With the preceeding patches it's become defunct. Also I'm about to add
> a different boolean argument, so it's better to keep the confusion
> down to the absolute minimum.
>
> v2: Since the hypervfb patch got droppped (it's only a pci device for
> gen1 vm, not for gen2) there is one leftover user in an actual driver
> left to touch.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_aperture.c  | 2 +-
>  drivers/video/aperture.c        | 7 +++----
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  include/linux/aperture.h        | 9 ++++-----
>  4 files changed, 9 insertions(+), 11 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

