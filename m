Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069903B760F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Jun 2021 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhF2QCO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Jun 2021 12:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232698AbhF2QCO (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Jun 2021 12:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328F661DC8;
        Tue, 29 Jun 2021 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624982387;
        bh=mApRLgk69+mMV6V2Jp0Hts8X9JoUe+4WPGnamh9oiBU=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=jn/UYtxd6DOT82xj4Jn5ozrIOU1lYCBRLr3TmBNuywthA+if1knOf6CycPUljm3dn
         qrjGs6Lu1J28zcL8aopJN6s5OgAz8oLAytGSTEQG1DzNQPPf3gRaYpVpMxeLaaiOyh
         bVLemkmvbDMqQhIQKL1xV/Q0bjnonDenCYi8Nolx6I+32TCDLTuouRZokZI1drVfJE
         rJ0FGqtMN7GMe63abKwOLeIESoem7LfaZWgx2r5f3S3BCSvyUtxwGLzfmuIrRVi5Ux
         miLI4IVM6blF+0nBNxbMjbmWsAsTFPSHxCiyoRO2xhOx2NgTOob6j1ZWe0xWsOAKXd
         Tr8eWN67R/h5g==
Received: by mail-lf1-f50.google.com with SMTP id f30so40460638lfj.1;
        Tue, 29 Jun 2021 08:59:47 -0700 (PDT)
X-Gm-Message-State: AOAM5325nLRkV7BJpUmlMsiWkykTciFSYDs4EaRYuWaV6NtGoKoasv2k
        zp8Wr9jW9N/7ZGsYLuoiE8/hGhf6rHJj8EXImFA=
X-Google-Smtp-Source: ABdhPJxbKRPGstVIg+10tcjtk+VnYZ+lj9b97iwRcHVe57pqV9+t3IECtbTnQC+RnmS+mFeMuInfdc2gJTFJGcCpAlk=
X-Received: by 2002:a19:e210:: with SMTP id z16mr1316558lfg.233.1624982385490;
 Tue, 29 Jun 2021 08:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210629135833.22679-1-tzimmermann@suse.de>
In-Reply-To: <20210629135833.22679-1-tzimmermann@suse.de>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 29 Jun 2021 23:59:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v66wYxs7u1AubriRokPFh72ZONMxGgmGNPB5mFLOZNw_3Q@mail.gmail.com>
Message-ID: <CAGb2v66wYxs7u1AubriRokPFh72ZONMxGgmGNPB5mFLOZNw_3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/aperture: Pass DRM driver structure instead of driver name
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, airlied@redhat.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        spice-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 29, 2021 at 9:58 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Print the name of the DRM driver when taking over fbdev devices. Makes
> the output to dmesg more consistent. Note that the driver name is only
> used for printing a string to the kernel log. No UAPI is affected by this
> change.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
