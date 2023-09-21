Return-Path: <linux-hyperv+bounces-149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C337A9BFD
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634352826D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBC171C9;
	Thu, 21 Sep 2023 18:47:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C819CA4C
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 18:47:08 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD306EE862
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:47:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50307acd445so2243088e87.0
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322015; x=1695926815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SgMdBTw9y+aSwwtmwk5xQ1ZAPfF4LIv2yTZ0dNleis=;
        b=eQt6wCzHRk0kq/0afH21cJZ3RZfVdRmVhdiXnvZ/pwz4LZxtLiCGTj0RXS8duqRtaD
         iJMeTjdB/L4dRbJEhf9+PsY08Dj9pOTGvZR0TMQg4BzSMy5ih5Dr8C8XQEKF3FQLaFKS
         2jnNFWUGXc5q4kvXCBTzneBdtj3HmXjdTWnkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322015; x=1695926815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SgMdBTw9y+aSwwtmwk5xQ1ZAPfF4LIv2yTZ0dNleis=;
        b=ulhS0a6mcbIDwbZK1XFty5Tcav2KP8ZTz1RQFd57rcJJShMide+/pqeglSzKIz7/jP
         GTRJPEarn9FsVNrCjswKun7ANmGf13SuvPW070+hvJF/mWJDtbUNjNGf6IU0peECE40E
         BSZ6Q1rm55numsZuTer7KVDDVqusW8NDfEiibjDfZZ7A8DxpN8DkaMYu5PfOfWWW28pQ
         zJT/Zq2sXpXmnPGXdRprOCC91YVx05SIQbU0Z7InjcImcXWf7ZiSjJceNQjCIYxkmD5r
         0dY2fYgaKnMoYyAOcb662unTy4tXChU5djKRkahJT2ZvrShXpo3DtYNZpLOOMI6FNUgl
         NUNQ==
X-Gm-Message-State: AOJu0YzOCDETXQPqg4yFusvldsffONQBKFsVPqulTeq04lNw9jQ8Ek5m
	7lis4n6BbcQlZj85GP/37uSs+5uAx1UeN2w7n6H8tm0H
X-Google-Smtp-Source: AGHT+IEG1NODDhuNfQ1+8IUx+OL5ei4dnqHdd8B9yG7hdR/gRGc2RIa8+94GJlCM9mJ6lRH81Obtcg==
X-Received: by 2002:a05:6512:2146:b0:501:bee7:487b with SMTP id s6-20020a056512214600b00501bee7487bmr5094388lfr.11.1695322014946;
        Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id o1-20020ac24341000000b004fe1bc7e4acsm392837lfl.131.2023.09.21.11.46.54
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5032a508e74so598e87.1
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 11:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1ca4:b0:405:320a:44f9 with SMTP id
 k36-20020a05600c1ca400b00405320a44f9mr98844wms.5.1695321993367; Thu, 21 Sep
 2023 11:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
In-Reply-To: <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 Sep 2023 11:46:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WRqe7twJ+eLb3DavumknCxWFK5ey007fLuWkCBrzzyPQ@mail.gmail.com>
Message-ID: <CAD=FV=WRqe7twJ+eLb3DavumknCxWFK5ey007fLuWkCBrzzyPQ@mail.gmail.com>
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc: airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com, 
	alexander.deucher@amd.com, alexandre.belloni@bootlin.com, alison.wang@nxp.com, 
	bbrezillon@kernel.org, christian.koenig@amd.com, claudiu.beznea@microchip.com, 
	daniel@ffwll.ch, drawat.floss@gmail.com, javierm@redhat.com, 
	jernej.skrabec@gmail.com, jfalempe@redhat.com, jstultz@google.com, 
	kong.kongxinwei@hisilicon.com, kraxel@redhat.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	liviu.dudau@arm.com, nicolas.ferre@microchip.com, 
	paul.kocialkowski@bootlin.com, sam@ravnborg.org, samuel@sholland.org, 
	spice-devel@lists.freedesktop.org, stefan@agner.ch, suijingfeng@loongson.cn, 
	sumit.semwal@linaro.org, tiantao6@hisilicon.com, 
	tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, 
	virtualization@lists.linux-foundation.org, wens@csie.org, 
	xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 1, 2023 at 4:40=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
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
>  drivers/gpu/drm/tiny/bochs.c                    | 6 ++++++
>  drivers/gpu/drm/tiny/cirrus.c                   | 6 ++++++
>  19 files changed, 125 insertions(+)

This has been about 3 weeks now and it feels like that's enough bake
time and several people have managed to test it (thanks!). Landing in
drm-misc-next:

ce3d99c83495 drm: Call drm_atomic_helper_shutdown() at shutdown time
for misc drivers

