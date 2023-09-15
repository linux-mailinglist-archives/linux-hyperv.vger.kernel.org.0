Return-Path: <linux-hyperv+bounces-98-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46637A2009
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 15:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F642828C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C8107A9;
	Fri, 15 Sep 2023 13:45:06 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF99101EB
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 13:45:04 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2110D
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 06:45:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5007616b756so3451140e87.3
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694785499; x=1695390299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4UHa0/oq66alw95ljztJJEQxyAHYh4BXAB2kPfRssY=;
        b=mPnxj74v3iEDAR0cyYt4zSJpcMeAFvCWcYoTQExBWp/epIwqiETDI+AIY88mI/wGNU
         9uOc9gO1SAJzkPY/NJETl+VPHZhOAeLP/KWJgkkAedDPnQE3ivMDdnopTWUm/UyQ0Mip
         BO6FWniGUmzMHMCWGlAA18pIAmZspL+4f7PmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785499; x=1695390299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4UHa0/oq66alw95ljztJJEQxyAHYh4BXAB2kPfRssY=;
        b=dJXA8Jve/YXSoNiulAMVdzOhVKyZ7TSRGn1jWSxsg6jpPIGG5vwijkaK5J84hp+VWi
         xm2fNvlhFfDY4SW4BYlYsEXBdda5Azao9UoTl1TR7/xb7fSk5nFSEaaFi4Uox97REB7i
         n2s1KqfgNpi4TVAWWTYbLMQxLC/xEEwceL5FJRH48YMNnVELXm8MnXRoraeyP0N0rJkM
         +OFa1rZm3yNXfg/MXlMActGjb6NHD/bV3LJX7shcXkrVzE+bWYtfd4I3ciplPce+eBGW
         I3AyNPp3+mBiJPpe21dserOEfH6B7IDFmCWU6X/XgeekdHZXFRrhmpD4FVOdn8o1iXw8
         htSQ==
X-Gm-Message-State: AOJu0YwIfEwb4aN/9M3JtLNTK8UnMfUFOcSuU29Y/8FHbSEipSaOsSTx
	Xr91MMF7m6WX/mz6gOewFCMBf0a45Dy4xujz4tKy59gQ
X-Google-Smtp-Source: AGHT+IFK9RyVRYXnAE9aEXHEvdQKpwvVuGAjz5rJYilWtxxBMMF4tCYjTUgMT6gQYFq8wpHwLXOvbg==
X-Received: by 2002:a05:6512:2828:b0:4f8:631b:bf77 with SMTP id cf40-20020a056512282800b004f8631bbf77mr1794911lfb.22.1694785499552;
        Fri, 15 Sep 2023 06:44:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p3-20020a19f003000000b004fbc82dd1a5sm648635lfc.13.2023.09.15.06.44.59
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:44:59 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5009dd43130so2596e87.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 06:44:59 -0700 (PDT)
X-Received: by 2002:a50:d09e:0:b0:525:573c:6444 with SMTP id
 v30-20020a50d09e000000b00525573c6444mr118963edd.1.1694785478523; Fri, 15 Sep
 2023 06:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org>
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid> <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
In-Reply-To: <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Sep 2023 06:44:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
Message-ID: <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
To: suijingfeng <suijingfeng@loongson.cn>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, airlied@gmail.com, 
	airlied@redhat.com, alain.volmat@foss.st.com, alexander.deucher@amd.com, 
	alexandre.belloni@bootlin.com, alison.wang@nxp.com, bbrezillon@kernel.org, 
	christian.koenig@amd.com, claudiu.beznea@microchip.com, daniel@ffwll.ch, 
	drawat.floss@gmail.com, javierm@redhat.com, jernej.skrabec@gmail.com, 
	jfalempe@redhat.com, jstultz@google.com, kong.kongxinwei@hisilicon.com, 
	kraxel@redhat.com, linus.walleij@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	liviu.dudau@arm.com, nicolas.ferre@microchip.com, 
	paul.kocialkowski@bootlin.com, sam@ravnborg.org, samuel@sholland.org, 
	spice-devel@lists.freedesktop.org, stefan@agner.ch, sumit.semwal@linaro.org, 
	tiantao6@hisilicon.com, tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, 
	virtualization@lists.linux-foundation.org, wens@csie.org, 
	xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 15, 2023 at 2:11=E2=80=AFAM suijingfeng <suijingfeng@loongson.c=
n> wrote:
>
> Hi,
>
>
> On 2023/9/2 07:39, Douglas Anderson wrote:
> > Based on grepping through the source code these drivers appear to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > All of the drivers in this patch were fairly straightforward to fix
> > since they already had a call to drm_atomic_helper_shutdown() at
> > remove/unbind time but were just lacking one at system shutdown. The
> > only hitch is that some of these drivers use the component model to
> > register/unregister their DRM devices. The shutdown callback is part
> > of the original device. The typical solution here, based on how other
> > DRM drivers do this, is to keep track of whether the device is bound
> > based on drvdata. In most cases the drvdata is the drm_device, so we
> > can just make sure it is NULL when the device is not bound. In some
> > drivers, this required minor code changes. To make things simpler,
> > drm_atomic_helper_shutdown() has been modified to consider a NULL
> > drm_device as a noop in the patch ("drm/atomic-helper:
> > drm_atomic_helper_shutdown(NULL) should be a noop").
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
>
> I have just tested the whole series, thanks for the patch. For drm/loongs=
on only:
>
>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks!


> By the way, I add 'pr_info("lsdc_pci_shutdown\n");' into the lsdc_pci_shu=
tdown() function,
> And seeing that lsdc_pci_shutdown() will be called when reboot and shutdo=
wn the machine.
> I did not witness something weird happen at present. As you have said, th=
is is useful for
> drm panels drivers. But for the rest(drm/hibmc, drm/ast, drm/mgag200 and =
drm/loongson etc)
> drivers, you didn't mention what's the benefit for those drivers.

I didn't mention it because I have no idea! I presume that for
non-drm_panel use cases it's not a huge deal, otherwise it wouldn't
have been missing from so many drivers. Thus, my "one sentence" reason
for the non-drm_panel case is just "we should do this because the
documentation of the API says we should", which is already in the
commit message. ;-)

If you have a specific other benefit you'd like me to list then I'm happy t=
o.


> Probably, you can
> mention it with at least one sentence at the next version. I also prefer =
to alter the
> lsdc_pci_shutdown() function as the following pattern:
>
>
> static void lsdc_pci_shutdown(struct pci_dev *pdev)
> {
>
>      struct drm_device *ddev =3D pci_get_drvdata(pdev);
>
>      drm_atomic_helper_shutdown(ddev);
> }

I was hoping to land this patch without spinning it unless there's a
good reason. How strongly do you feel about needing to change the
above? I will note that I coded it the way I did specifically to try
to follow the style in the documentation in "drm_drv.c". In the
example "driver_shutdown()" function you can see that they combined it
into one line and so I followed that style. ;-) That being said, I
have no problem changing this if I spin the patch.

-Doug

