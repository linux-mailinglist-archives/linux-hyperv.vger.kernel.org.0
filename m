Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73B2519634
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 May 2022 06:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344474AbiEDEGb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 May 2022 00:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbiEDEGa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 May 2022 00:06:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDEA1A393;
        Tue,  3 May 2022 21:02:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f7d19cac0bso2986207b3.13;
        Tue, 03 May 2022 21:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3/oD3hhUgmP5e/isgUbw7+g1PPBvghdLqlobIHop/4=;
        b=VLwwz523wVa5T9+YMAiWIa2hQHB+9nrcrvf6MxAWFdvLCo0x1OnGKzj1cFBLowgXMa
         F45SzWgIU3s+cSzh6BKHqDYlqYUoOTlP/DSwTzBpXDEpugMjFGpv5L5yL1nWB2xwnQJD
         EeuRYbdH8HBV17g62T1SShvp34T9BuYwrJThnLnDnLJhdGSa0nZK8W8UurXcxl8Ll3aI
         CuFmoN3Ew3mEJT3PjNLT1g9uvz9IyHrcrnUAfAPHzOOpxOGBnh1C8FOhSOJQF400AJeW
         WMnxtjNXFOq3SFw9wIAD4v+TZIaajPa6RX6TP2zKpwNrgXwk+AxEfopbLgEXRwClGZVE
         vz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3/oD3hhUgmP5e/isgUbw7+g1PPBvghdLqlobIHop/4=;
        b=twBu9CF423epoCsB4SI7ml13eOKvfyAV70hxGZbC4D4mPNidsK/JNLUzts8Y56s1Hj
         G4PYA0XA3PrMcpoTAzdKu2gTx/GXSkEBGNj4b2IYf7n94ZUKzOHMEsxlZRgQ4EEBjE7f
         mgMMoGIekSFA+Q2bJI3uDkzgK9LBPnYUG2vEsCIrOEaxIvFYEtAfOsZESEZVjF39yUmu
         djcu/bG0IQpOjhxPZFHHyDtk6sVOWmYkyidHiZ5yNxnLUyF6U90WHTwfjs4iXjIPTl47
         jE4uZea5iAfRjsj5uzAsKcijJvmQwT0F6eV7aGaUzC8/+drhj1OXm+bKfHkHQZGYcwLx
         K8TQ==
X-Gm-Message-State: AOAM533ppJVRTubUJtPhG+loDC0wc3vHfvKJnXR5zHP07AeA5+X/ZZia
        2CBcFeuvGeWmbyTtgZQgMtIsgnJ2W6RaPfJRbs0=
X-Google-Smtp-Source: ABdhPJwwVfviWqFjK/Glcs4mY8hURf2iUgeAvKOXOZreMUDCs5xJ8WBeFHrhRnAuZFlZ+hOGuZ9iZ95Q7xe95PrG0k4=
X-Received: by 2002:a05:690c:9e:b0:2e9:b625:1be2 with SMTP id
 be30-20020a05690c009e00b002e9b6251be2mr18279825ywb.48.1651636974377; Tue, 03
 May 2022 21:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <1651509391-2058-1-git-send-email-mikelley@microsoft.com> <1651509391-2058-5-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1651509391-2058-5-git-send-email-mikelley@microsoft.com>
From:   Deepak Rawat <drawat.floss@gmail.com>
Date:   Tue, 3 May 2022 21:02:44 -0700
Message-ID: <CAHFnvW3TDTh_iRpF5zH4uPKnB+_AisniVgam=Fj_Gog6KOfKrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     K Y Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 2, 2022 at 9:37 AM Michael Kelley <mikelley@microsoft.com> wrote:
>
> The DRM Hyper-V driver has special case code for running on the first
> released versions of Hyper-V: 2008 and 2008 R2/Windows 7.  These versions
> are now out of support (except for extended security updates) and lack
> support for performance features that are needed for effective production
> usage of Linux guests.
>
> The negotiation of the VMbus protocol versions required by these old
> Hyper-V versions has been removed from the VMbus driver.  So now remove
> the handling of these VMbus protocol versions from the DRM Hyper-V
> driver.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> index c0155c6..76a182a 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> @@ -18,16 +18,16 @@
>  #define SYNTHVID_VERSION(major, minor) ((minor) << 16 | (major))
>  #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
>  #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
> +
> +/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
>  #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
>  #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
>  #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
>
> -#define SYNTHVID_DEPTH_WIN7 16
>  #define SYNTHVID_DEPTH_WIN8 32
> -#define SYNTHVID_FB_SIZE_WIN7 (4 * 1024 * 1024)
> +#define SYNTHVID_WIDTH_WIN8 1600
> +#define SYNTHVID_HEIGHT_WIN8 1200
>  #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
> -#define SYNTHVID_WIDTH_MAX_WIN7 1600
> -#define SYNTHVID_HEIGHT_MAX_WIN7 1200
>
>  enum pipe_msg_type {
>         PIPE_MSG_INVALID,
> @@ -496,12 +496,6 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>         case VERSION_WIN8:
>         case VERSION_WIN8_1:
>                 ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
> -               if (!ret)
> -                       break;
> -               fallthrough;
> -       case VERSION_WS2008:
> -       case VERSION_WIN7:
> -               ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN7);
>                 break;
>         default:
>                 ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
> @@ -513,18 +507,15 @@ int hyperv_connect_vsp(struct hv_device *hdev)
>                 goto error;
>         }
>
> -       if (hv->synthvid_version == SYNTHVID_VERSION_WIN7)
> -               hv->screen_depth = SYNTHVID_DEPTH_WIN7;
> -       else
> -               hv->screen_depth = SYNTHVID_DEPTH_WIN8;
> +       hv->screen_depth = SYNTHVID_DEPTH_WIN8;
>
>         if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
>                 ret = hyperv_get_supported_resolution(hdev);
>                 if (ret)
>                         drm_err(dev, "Failed to get supported resolution from host, use default\n");
>         } else {
> -               hv->screen_width_max = SYNTHVID_WIDTH_MAX_WIN7;
> -               hv->screen_height_max = SYNTHVID_HEIGHT_MAX_WIN7;
> +               hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
> +               hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
>         }
>
>         hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;

Do we need a new version for Windows 11? If the synthetic device
version is decoupled from Windows version, then I guess we can rename
the macro to reflect that.

Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

> --
> 1.8.3.1
>
