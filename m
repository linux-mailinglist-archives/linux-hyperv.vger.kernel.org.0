Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFE20CB07
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jun 2020 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgF1XCF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Jun 2020 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgF1XCE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Jun 2020 19:02:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7120C03E979
        for <linux-hyperv@vger.kernel.org>; Sun, 28 Jun 2020 16:02:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so323457oie.8
        for <linux-hyperv@vger.kernel.org>; Sun, 28 Jun 2020 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFXV7zU7d2aO2yFJ0oYL5tOi9HgfSWnYg/siYuUTMNE=;
        b=Hfb/I2m1gGJnZKNPvol9THHFrIAtmv1c4D4sy2J9+xyMtOupWHwLfCIM72+Tuyr2Kv
         W977mIPw/xsghganl8Y4mJDxxvc6X60aTiEAyIX1V7WRxv1nyumkG0JAz9ma/83YAa03
         UqoTqnaWgFcE4WQgWUHYJREadcLcjrsTpZQKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFXV7zU7d2aO2yFJ0oYL5tOi9HgfSWnYg/siYuUTMNE=;
        b=VPV/8tzhOLh8TmZLU6mlHu6pOKt8+mtrV2ULyW5SzWc9d29Z4+mj03IRzNto4IOv1Z
         5L34MBcCVnipQ2FLy8nuM++TfEjnKYwkEps5zIsvE2CIbbp4Sa5zRjJ0zRdIC7bdKbtr
         y9G2dYh/dEWpakX7Bot1V+cWn2mAxN4SEuLUey4WmmFNXWCpcu8fBRmVPW4QrvtB3iK8
         hiLehjGif3swrJapVI1f7jODe+CIXeLRbEi3GI0crHJLM8cHso3tESAxc4oGSBi3q6cx
         pn32d4b+KNLw4msBqFTBOsk5U7AT8ae2ww37pJdh85n1x+gw0VcR+WMIZqraxeeaRPHP
         hP8w==
X-Gm-Message-State: AOAM532zib3Zy43zo6JrtOpY3d3MtJmsI+EVAEnFN/I5JeKRKbwhhfHh
        SCPBbc43w1CqGwDLpdbPjFXqngM8OBSRe9RTGXsziQ==
X-Google-Smtp-Source: ABdhPJyT+a/pW+st1ahh4OYWn7YrmSdQdK9rMlURfY4eL3/ugaSOalgbTcVXrcx6ZTTC6m9tRQuBf/OZ4alnE1vq2uU=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr10224136oig.128.1593385322913;
 Sun, 28 Jun 2020 16:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200622110623.113546-1-drawat.floss@gmail.com>
In-Reply-To: <20200622110623.113546-1-drawat.floss@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 29 Jun 2020 01:01:52 +0200
Message-ID: <CAKMK7uExRNRV8spaBzaO8syPiFGw-8f5ZHLhtZj159JsRFMRPw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] DRM driver for hyper-v synthetic video device
To:     Deepak Rawat <drawat.floss@gmail.com>
Cc:     linux-hyperv@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        K Y Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Wei Hu <weh@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 22, 2020 at 1:07 PM Deepak Rawat <drawat.floss@gmail.com> wrote:
>
> Hi All,
>
> First draft of DRM driver for hyper-v synthetic video device. This synthetic
> device is already supported by hyper-v and a corresponding framebuffer driver
> exist at drivers/video/fbdev/hyperv_fb.c. With this patch, just reworked the
> framebuffer driver into DRM, in doing so got mode-setting support. The code is
> similar to cirrus DRM driver, using simple display pipe and shmem backed
> GEM objects.
>
> The device support more features like hardware cursor, EDID, multiple dirty
> regions, etc, which were not supported with framebuffer driver. The plan is to
> add support for those in future iteration. Wanted to get initial feedback and
> discuss cursor support with simple kms helper. Is there any value to add cursor
> support to drm_simple_kms_helper.c so that others can use it, or should I just
> add cursor plane as device private? I believe we can still keep this driver
> in drm/tiny?

Simple is for really simple framebuffers, if you want a few planes or
multiple outputs or multiple crtcs then just write a normal drm
driver. We've worked hard to ditch all the boilerplate and replace it
with defaults, so the difference isn't much, and if we don't keep
simple helpers really simple there's not much point.

Also once you don't use simple helpers anymore I think migrating out
of drm/tiny is probably a good idea.
-Daniel

> For testing, ran GNOME and Weston with current changes in a Linux VM on
> Windows 10 with hyper-v enabled.
>
> Thanks,
> Deepak
>
> Deepak Rawat (2):
>   drm/hyperv: Add DRM driver for hyperv synthetic video device
>   MAINTAINERS: Add maintainer for hyperv video device
>
>  MAINTAINERS                       |    8 +
>  drivers/gpu/drm/tiny/Kconfig      |    9 +
>  drivers/gpu/drm/tiny/Makefile     |    1 +
>  drivers/gpu/drm/tiny/hyperv_drm.c | 1007 +++++++++++++++++++++++++++++
>  4 files changed, 1025 insertions(+)
>  create mode 100644 drivers/gpu/drm/tiny/hyperv_drm.c
>
> --
> 2.27.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
