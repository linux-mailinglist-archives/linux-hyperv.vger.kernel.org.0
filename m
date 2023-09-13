Return-Path: <linux-hyperv+bounces-28-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0D79F144
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CCA2818DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C305391;
	Wed, 13 Sep 2023 18:40:33 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB437F
	for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 18:40:33 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63925A3
	for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 11:40:32 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5008d16cc36so148218e87.2
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694630430; x=1695235230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+kAAaz8DPw8hDMu58WJTq8XnZOBUPzC1oE9LVRkCzk=;
        b=jh964z9Prx3opJGDPIXXV+Af8EZ/su98pBUU1mjM2+RHRBo3gaId/ptUKec6r3VTfF
         YIj3g71MCezTDuIgfsLnoG8JGWWf8zIzerz6oPZX+3Z2EZvGmIgD7KukjpEMovYRaAGv
         WEGCW4QNBxE942cVg50NA8z16Tf1khM+vQ1N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694630430; x=1695235230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+kAAaz8DPw8hDMu58WJTq8XnZOBUPzC1oE9LVRkCzk=;
        b=tpN8TPlnBKMZOHclAJc9j2IlUkNyElBPmsyMvcr4NlntrAYYEJW+XFBJwq83lKBB2y
         1xNDqJdz7IYcWWP4jMzACmXCgU8XDdgsTSLVNHKNHRCbFchEgwSWmEJeccSHr3xnwnng
         HT2sS+FI83bQZY+p3yC2UA6N5EREQ9h6U5EQeEf3l/EryiLuZNxD3YjPer/XKiJx8NiW
         uB9q/RXmlxw1b2J6p9y60wmUYiBfWpZ2F5Nbfc3iMCnSE8CmDYhnKTPNENZnhEYEgJTk
         R88g+79c/5JBoesBpTN8M4N9wJE0gMUu6M/OIXrzgJvlXUbZmjuWYoUo/UZdh/4FW/zp
         MucA==
X-Gm-Message-State: AOJu0YyijXwK23UKeN41Nh8oKR/vwJkfZEW8JtNoFiqw9LfFS5Q88Wzz
	zuRdrO8SzVTjCAOH5Fy8Ig7v7Xr2ppcUUJBBTwUui7Uy
X-Google-Smtp-Source: AGHT+IETT6X5IgbsgZcpdtoYFs73V71UIq9hTqDXM5czKzUmre9jtY/SSargEKsyl92cqFE8loY/ew==
X-Received: by 2002:a05:6512:3a91:b0:500:9796:fb6 with SMTP id q17-20020a0565123a9100b0050097960fb6mr3424123lfu.40.1694630429805;
        Wed, 13 Sep 2023 11:40:29 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id m5-20020a056402050500b0052568bf9411sm7580479edv.68.2023.09.13.11.40.29
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:40:29 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2551a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 11:40:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1c24:b0:401:a494:2bbb with SMTP id
 j36-20020a05600c1c2400b00401a4942bbbmr161937wms.5.1694629925852; Wed, 13 Sep
 2023 11:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org>
In-Reply-To: <20230901234015.566018-1-dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 13 Sep 2023 11:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=US2G_s8_UtaRMBDLgOJqJzDzxMpg0C0wJ3TabUsuZsGg@mail.gmail.com>
Message-ID: <CAD=FV=US2G_s8_UtaRMBDLgOJqJzDzxMpg0C0wJ3TabUsuZsGg@mail.gmail.com>
Subject: Re: [RFT PATCH 0/6] drm: drm-misc drivers call drm_atomic_helper_shutdown()
 at the right times
To: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc: airlied@gmail.com, airlied@redhat.com, alain.volmat@foss.st.com, 
	alexander.deucher@amd.com, alexandre.belloni@bootlin.com, 
	alexandre.torgue@foss.st.com, alison.wang@nxp.com, andrew@aj.id.au, 
	bbrezillon@kernel.org, christian.koenig@amd.com, claudiu.beznea@microchip.com, 
	daniel@ffwll.ch, drawat.floss@gmail.com, emma@anholt.net, hdegoede@redhat.com, 
	javierm@redhat.com, jernej.skrabec@gmail.com, jfalempe@redhat.com, 
	joel@jms.id.au, jstultz@google.com, jyri.sarha@iki.fi, 
	kong.kongxinwei@hisilicon.com, kraxel@redhat.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, 
	mcoquelin.stm32@gmail.com, nicolas.ferre@microchip.com, 
	paul.kocialkowski@bootlin.com, philippe.cornu@foss.st.com, 
	raphael.gallais-pou@foss.st.com, robh@kernel.org, sam@ravnborg.org, 
	samuel@sholland.org, spice-devel@lists.freedesktop.org, stefan@agner.ch, 
	steven.price@arm.com, suijingfeng@loongson.cn, sumit.semwal@linaro.org, 
	tiantao6@hisilicon.com, tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, 
	u.kleine-koenig@pengutronix.de, virtualization@lists.linux-foundation.org, 
	wens@csie.org, xinliang.liu@linaro.org, yannick.fertre@foss.st.com, 
	yongqin.liu@linaro.org, zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 1, 2023 at 4:40=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
>
> NOTE: in order to avoid email sending limits on the cover letter, I've
> split this patch series in two. Patches that target drm-misc and ones
> that don't. The cover letter of the two is identical other than this note=
.
>
> This patch series came about after a _long_ discussion between me and
> Maxime Ripard in response to a different patch I sent out [1]. As part
> of that discussion, we realized that it would be good if DRM drivers
> consistently called drm_atomic_helper_shutdown() properly at shutdown
> and driver remove time as it's documented that they should do. The
> eventual goal of this would be to enable removing some hacky code from
> panel drivers where they had to hook into shutdown themselves because
> the DRM driver wasn't calling them.
>
> It turns out that quite a lot of drivers seemed to be missing
> drm_atomic_helper_shutdown() in one or both places that it was
> supposed to be. This patch series attempts to fix all the drivers that
> I was able to identify.
>
> NOTE: fixing this wasn't exactly cookie cutter. Each driver has its
> own unique way of setting itself up and tearing itself down. Some
> drivers also use the component model, which adds extra fun. I've made
> my best guess at solving this and I've run a bunch of compile tests
> (specifically, allmodconfig for amd64, arm64, and powerpc). That being
> said, these code changes are not totally trivial and I've done zero
> real testing on them. Making these patches was also a little mind
> numbing and I'm certain my eyes glazed over at several points when
> writing them. What I'm trying to say is to please double-check that I
> didn't do anything too silly, like cast your driver's drvdata to the
> wrong type. Even better, test these patches!
>
> I've organized this series like this:
> 1. One patch for all simple cases of just needing a call at shutdown
>    time for drivers that go through drm-misc.
> 2. A separate patch for "drm/vc4", even though it goes through
>    drm-misc, since I wanted to leave an extra note for that one.
> 3. Patches for drivers that just needed a call at shutdown time for
>    drivers that _don't_ go through drm-misc.
> 4. Patches for the few drivers that had the call at shutdown time but
>    lacked it at remove time.
> 5. One patch for all simple cases of needing a call at shutdown and
>    remove (or unbind) time for drivers that go through drm-misc.
> 6. A separate patch for "drm/hisilicon/kirin", even though it goes
>    through drm-misc, since I wanted to leave an extra note for that
>    one.
> 7. Patches for drivers that needed a call at shutdown and remove (or
>    unbind) time for drivers that _don't_ go through drm-misc.
>
> I've labeled this patch series as RFT (request for testing) to help
> call attention to the fact that I didn't personally test any of these
> patches.
>
> If you're a maintainer of one of these drivers and you think that the
> patch for your driver looks fabulous, you've tested it, and you'd like
> to land it right away then please do. For non-drm-misc drivers there
> are no dependencies here. Some of the drm-misc drivers depend on the
> first patch, AKA ("drm/atomic-helper: drm_atomic_helper_shutdown(NULL)
> should be a noop"). I've tried to call this out but it also should be
> obvious once you know to look for it.
>
> I'd like to call out a few drivers that I _didn't_ fix in this series
> and why. If any of these drivers should be fixed then please yell.
> - DRM driers backed by usb_driver (like gud, gm12u320, udl): I didn't
> add the call to drm_atomic_helper_shutdown() at shutdown time
> because there's no ".shutdown" callback for them USB drivers. Given
> that USB is hotpluggable, I'm assuming that they are robust against
> this and the special shutdown callback isn't needed.
> - ofdrm and simpledrm: These didn't have drm_atomic_helper_shutdown()
> in either shutdown or remove, but I didn't add it. I think that's OK
> since they're sorta special and not really directly controlling
> hardware power sequencing.
> - virtio, vkms, vmwgfx, xen: I believe these are all virtual (thus
> they wouldn't directly drive a panel) and adding the shutdown
> didn't look straightforward, so I skipped them.
>
> I've let each patch in the series get CCed straight from
> get_maintainer. That means not everyone will have received every patch
> but everyone should be on the cover letter. I know some people dislike
> this but when touching this many drivers there's not much
> choice. dri-devel and lkml have been CCed and lore/lei exist, so
> hopefully that's enough for folks. I'm happy to add people to the
> whole series for future posts.
>
> [1] https://lore.kernel.org/lkml/20230804140605.RFC.4.I930069a32baab6faf4=
6d6b234f89613b5cec0f14@changeid
>
>
> Douglas Anderson (6):
>   drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a noop
>   drm: Call drm_atomic_helper_shutdown() at shutdown time for misc
>     drivers
>   drm/vc4: Call drm_atomic_helper_shutdown() at shutdown time
>   drm/ssd130x: Call drm_atomic_helper_shutdown() at remove time
>   drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for
>     misc drivers
>   drm/hisilicon/kirin: Call drm_atomic_helper_shutdown() at
>     shutdown/unbind time
>
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  9 +++++
>  .../gpu/drm/arm/display/komeda/komeda_kms.c   |  7 ++++
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  1 +
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  6 ++++
>  drivers/gpu/drm/arm/malidp_drv.c              |  6 ++++
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  7 ++++
>  drivers/gpu/drm/ast/ast_drv.c                 |  6 ++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  6 ++++
>  drivers/gpu/drm/drm_atomic_helper.c           |  3 ++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  8 +++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  6 ++++
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  9 +++++
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c       |  6 ++++
>  drivers/gpu/drm/logicvc/logicvc_drm.c         |  9 +++++
>  drivers/gpu/drm/loongson/lsdc_drv.c           |  6 ++++
>  drivers/gpu/drm/mcde/mcde_drv.c               |  9 +++++
>  drivers/gpu/drm/mgag200/mgag200_drv.c         |  8 +++++
>  drivers/gpu/drm/omapdrm/omap_drv.c            |  8 +++++
>  drivers/gpu/drm/pl111/pl111_drv.c             |  7 ++++
>  drivers/gpu/drm/qxl/qxl_drv.c                 |  7 ++++
>  drivers/gpu/drm/solomon/ssd130x.c             |  1 +
>  drivers/gpu/drm/sti/sti_drv.c                 |  7 ++++
>  drivers/gpu/drm/stm/drv.c                     |  7 ++++
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  6 ++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c           | 11 +++++-
>  drivers/gpu/drm/tiny/bochs.c                  |  6 ++++
>  drivers/gpu/drm/tiny/cirrus.c                 |  6 ++++
>  drivers/gpu/drm/tve200/tve200_drv.c           |  7 ++++
>  drivers/gpu/drm/vboxvideo/vbox_drv.c          | 10 ++++++
>  drivers/gpu/drm/vc4/vc4_drv.c                 | 36 ++++++++++++-------
>  30 files changed, 217 insertions(+), 14 deletions(-)

Just a heads up to keep folks in the loop: I've landed the first patch
in the drm-misc series, AKA ("drm/atomic-helper:
drm_atomic_helper_shutdown(NULL) should be a noop"), but I haven't
landed any of the others yet. I'm going to give them another ~week
just to be sure there are no objections.

-Doug

