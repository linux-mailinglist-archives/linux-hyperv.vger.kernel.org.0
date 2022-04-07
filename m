Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D14F84FE
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiDGQbS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiDGQbR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 12:31:17 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61639AF1FB;
        Thu,  7 Apr 2022 09:29:12 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l36so10450432ybj.12;
        Thu, 07 Apr 2022 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDM7wlMq64JzrOWsB+7BgQsvGKPEysooG41+nOUmUp0=;
        b=KVKDK10IKH4hrbWXVdHXMgr7bRQOJ1oaOsNvUM3pw5sLy/QGpajD5M0JmmIj0hcT4C
         RreBmGFooTRgUbrJg/cUIjQSvre/H3DogX5vOfUb+oJbSm1fgryOaxHZIiG0yoyII9OP
         z8SIxf3voNWu32GFXzTOVbqS2h3XTHXICU9vbVT5QY0R/BD9t9FUaRa/uMeC+dXFchD8
         p9if1WAU9tmrooVu9Un2iHQEoMvXlTdcnl91ODWRx2RurFvlydITOGZcz/q7Plonk0Ay
         Jj48eozySQ7kwpRVrFWhdMl9mkR9lBX0TAJZbNdqSmbELGHKPGFKLv+5e70QWka8L5Hv
         f7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDM7wlMq64JzrOWsB+7BgQsvGKPEysooG41+nOUmUp0=;
        b=qs/NcFB5xmfM4YP4owAYP0d26ShsZ6qocnPMQxHPYpfBwX7Wk+cQ1ABmpyLWdabwT4
         UYBYAlIqxlqBk6WhH7W+uoT3YtdGUUFRvssfvYzG0OCMb37IjhiQ4HgEHW0Gc+WNIvO1
         ckZ1hFOCJymTb0Oif9gHmXR7q2vdzxxHoJYRNzoDihwoX9DyREyscPJQDVUc/qUQKgg8
         CiddJ7pYDnjy6z04dD3cykJrTtRLJboT9/rZ3wTisCgKKrRe8GN8lHe1w3PlmbSzKN3G
         DpaZL/0k3KbRca5J5OpDLB7zXXgcR0mU5i/dl3mp2iaWmIUOlaKaoSgSSiQWcHZpJHuA
         gKXQ==
X-Gm-Message-State: AOAM532HG0Mbiaojje/uFubD+YmSA6tdXuwq0T7s+X3bYg9FsRKKq+sy
        VdU/QnLrOlgBIrzNnL+Kp9f50WTEtpC9quV69KM=
X-Google-Smtp-Source: ABdhPJyghH3SAS7jw4XD4ro17jnPvwM4geTQKWtoA4Skyngk8dgdvRIXCcwVkW3zJsVO4yB7KIYeo+N681NWg1Dj3rY=
X-Received: by 2002:a25:9783:0:b0:63e:f532:8374 with SMTP id
 i3-20020a259783000000b0063ef5328374mr109005ybo.415.1649348944476; Thu, 07 Apr
 2022 09:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1649312827-728-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1649312827-728-1-git-send-email-ssengar@linux.microsoft.com>
From:   Deepak Rawat <drawat.floss@gmail.com>
Date:   Thu, 7 Apr 2022 09:28:53 -0700
Message-ID: <CAHFnvW2V0tz25D4YMxYMNqYs5uMkbjEoc6p93e6naBhvybzmoQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/hyperv: Added error message for fb size greater
 then allocated
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
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

On Wed, Apr 6, 2022 at 11:27 PM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> Added error message when the size of requested framebuffer is more then
> the allocated size by vmbus mmio region for framebuffer
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> v1 -> v2 : Corrected Sign-off
>
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index e82b815..92587f0 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -123,8 +123,11 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
>         if (fb->format->format != DRM_FORMAT_XRGB8888)
>                 return -EINVAL;
>
> -       if (fb->pitches[0] * fb->height > hv->fb_size)
> +       if (fb->pitches[0] * fb->height > hv->fb_size) {
> +               drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater then allocated size %ld\n",
> +               current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);

Any reason to add an error message here. Since this function is called
whenever there is an update, avoid printing an error here.

>                 return -EINVAL;
> +       }
>
>         return 0;
>  }
> --
> 1.8.3.1
>
