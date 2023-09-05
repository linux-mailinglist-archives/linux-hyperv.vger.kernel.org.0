Return-Path: <linux-hyperv+bounces-4-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47070793099
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 23:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648031C20846
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7FFC0A;
	Tue,  5 Sep 2023 21:06:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E042DDB6
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 21:06:07 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB5B3;
	Tue,  5 Sep 2023 14:06:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a5e1812378so462857866b.2;
        Tue, 05 Sep 2023 14:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947965; x=1694552765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XU7m3iUIhB2czTwQI5E0tsG1IdXbWVa4A+CGA62kvw=;
        b=lOmLQAW3WSIKRsSTw8xqcC8745jQLP9ItqyDD+qLxzk2VFL+Dojla77YDM5Nd06gZO
         /fR/XjQCyCDDpAfA2af8gKphmSFbirNpmeENAEgyTwDL1Hz6s90rhD4SrHGERXu20MKm
         hKp+hFGXsFRuQXhEh4nORdGbjpwwsPYWT6dlN/ZGdkXBp6YK13b+bEyzsrWZg2ds4Wjs
         hLpYAM+XX4N6MQ9bAWL3Q//VTDw9QXoAYKFv3FZR1uX1+57yY+hCD+scE0jHrkZJw/4N
         7Ecrhdu2ED18aSd+Ayuvesb+bKOO1vUKNPTqhmR8zqj9eijisZc4ka1/7ATBKXc6VhKX
         dqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947965; x=1694552765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XU7m3iUIhB2czTwQI5E0tsG1IdXbWVa4A+CGA62kvw=;
        b=TIX0mleiLpx8C7zlPUaUyKA6hElv4WFUvMjhbu1ktA5HO8ggmN1ytKcY7TNjUuhSzc
         3sdC+oHWl1w/Bxwfg/LIfB/Z5gY/e5wjw8jRH0IvyPpxPLovL+js6As2sH2G4oUS6dfu
         MP4bKWTLeVp+HXRAVdSKmekE/dUoNg+O9KpVCfDD2WW8k8+UnsArpG3NpYW+04BnUy4U
         FXCHZDO3UP2bUB5XVP1MthExHk6VORF1rPQWeQiJnLqcz1RWDr8ujH6DQdpUaKl7ZgDy
         aNKUHixml0xdkCOKyqpGkfnnhE1lrlsFsTMvKgDtiP8eNsZIFJ2kV326IW9CeIt24zUC
         moIQ==
X-Gm-Message-State: AOJu0YzzUCxMdTTMk3OM3cH52tJjEYxA0pLfWIdZ2XexiPSAOsyNR3V5
	a6nZ4K9RCs+exjPYo/vGlYg=
X-Google-Smtp-Source: AGHT+IGkmh9tp77O9jdKZ4K1pCktyBByW4OQ7/rwivCx3acTMVK4FoRmIlgULCUgqm2i5B0cQ60LGg==
X-Received: by 2002:a17:907:762a:b0:9a1:bb8f:17d7 with SMTP id jy10-20020a170907762a00b009a1bb8f17d7mr692400ejc.12.1693947964868;
        Tue, 05 Sep 2023 14:06:04 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b0099df2ddfc37sm8025574ejb.165.2023.09.05.14.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:04 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, airlied@gmail.com,
 airlied@redhat.com, alain.volmat@foss.st.com, alexander.deucher@amd.com,
 alexandre.belloni@bootlin.com, alison.wang@nxp.com, bbrezillon@kernel.org,
 christian.koenig@amd.com, claudiu.beznea@microchip.com, daniel@ffwll.ch,
 drawat.floss@gmail.com, javierm@redhat.com, jfalempe@redhat.com,
 jstultz@google.com, kong.kongxinwei@hisilicon.com, kraxel@redhat.com,
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, liviu.dudau@arm.com,
 nicolas.ferre@microchip.com, paul.kocialkowski@bootlin.com, sam@ravnborg.org,
 samuel@sholland.org, spice-devel@lists.freedesktop.org, stefan@agner.ch,
 suijingfeng@loongson.cn, sumit.semwal@linaro.org, tiantao6@hisilicon.com,
 tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de,
 virtualization@lists.linux-foundation.org, wens@csie.org,
 xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
Subject:
 Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at shutdown time
 for misc drivers
Date: Tue, 05 Sep 2023 23:06:00 +0200
Message-ID: <5970528.lOV4Wx5bFT@jernej-laptop>
In-Reply-To:
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
References:
 <20230901234015.566018-1-dianders@chromium.org>
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dne sobota, 02. september 2023 ob 01:39:53 CEST je Douglas Anderson 
napisal(a):
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
> 
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
> 
> All of the drivers in this patch were fairly straightforward to fix
> since they already had a call to drm_atomic_helper_shutdown() at
> remove/unbind time but were just lacking one at system shutdown. The
> only hitch is that some of these drivers use the component model to
> register/unregister their DRM devices. The shutdown callback is part
> of the original device. The typical solution here, based on how other
> DRM drivers do this, is to keep track of whether the device is bound
> based on drvdata. In most cases the drvdata is the drm_device, so we
> can just make sure it is NULL when the device is not bound. In some
> drivers, this required minor code changes. To make things simpler,
> drm_atomic_helper_shutdown() has been modified to consider a NULL
> drm_device as a noop in the patch ("drm/atomic-helper:
> drm_atomic_helper_shutdown(NULL) should be a noop").
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
> 
> Note that checkpatch yells that "drivers/gpu/drm/tiny/cirrus.c" is
> marked as 'obsolete', but it seems silly not to include the fix if
> it's already been written. If someone wants me to take that out,
> though, I can.
> 
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 9 +++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 7 +++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.h | 1 +
>  drivers/gpu/drm/arm/hdlcd_drv.c                 | 6 ++++++
>  drivers/gpu/drm/arm/malidp_drv.c                | 6 ++++++
>  drivers/gpu/drm/ast/ast_drv.c                   | 6 ++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 6 ++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 8 ++++++++
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++++++
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 6 ++++++
>  drivers/gpu/drm/logicvc/logicvc_drm.c           | 9 +++++++++
>  drivers/gpu/drm/loongson/lsdc_drv.c             | 6 ++++++
>  drivers/gpu/drm/mcde/mcde_drv.c                 | 9 +++++++++
>  drivers/gpu/drm/omapdrm/omap_drv.c              | 8 ++++++++
>  drivers/gpu/drm/qxl/qxl_drv.c                   | 7 +++++++
>  drivers/gpu/drm/sti/sti_drv.c                   | 7 +++++++
>  drivers/gpu/drm/sun4i/sun4i_drv.c               | 6 ++++++

For sun4i:
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/gpu/drm/tiny/bochs.c                    | 6 ++++++
>  drivers/gpu/drm/tiny/cirrus.c                   | 6 ++++++
>  19 files changed, 125 insertions(+)




