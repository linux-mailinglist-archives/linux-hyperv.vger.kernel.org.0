Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A84F8676
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 19:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346523AbiDGRpz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Apr 2022 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbiDGRpy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Apr 2022 13:45:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8136228D02;
        Thu,  7 Apr 2022 10:43:52 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 602E320DFDAB; Thu,  7 Apr 2022 10:43:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 602E320DFDAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649353432;
        bh=EoJK1cBRSxo9Ig4qPEGnpUnvdRWX31TX6ZeHZVK0Sw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqTrtOYyF1p+M94p4/7WCsFlHG51vKhNy4mvHF4IgNrX88YCoKDmGlber6C+PU7Je
         gm7T1wrWqdvjjNBzFQIkbv2z3IsbJSfObH0naSckjoJTo6dyU9tRsbwEomKpsOlzGX
         10snADbS+QSCPY6kQMgDFDAXyqvFMlVEJ759PBSU=
Date:   Thu, 7 Apr 2022 10:43:52 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Deepak Rawat <drawat.floss@gmail.com>
Cc:     ssengar@microsoft.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] drm/hyperv: Added error message for fb size greater
 then allocated
Message-ID: <20220407174352.GA10647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1649312827-728-1-git-send-email-ssengar@linux.microsoft.com>
 <CAHFnvW2V0tz25D4YMxYMNqYs5uMkbjEoc6p93e6naBhvybzmoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHFnvW2V0tz25D4YMxYMNqYs5uMkbjEoc6p93e6naBhvybzmoQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 07, 2022 at 09:28:53AM -0700, Deepak Rawat wrote:
> On Wed, Apr 6, 2022 at 11:27 PM Saurabh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > Added error message when the size of requested framebuffer is more then
> > the allocated size by vmbus mmio region for framebuffer
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > v1 -> v2 : Corrected Sign-off
> >
> >  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > index e82b815..92587f0 100644
> > --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> > @@ -123,8 +123,11 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
> >         if (fb->format->format != DRM_FORMAT_XRGB8888)
> >                 return -EINVAL;
> >
> > -       if (fb->pitches[0] * fb->height > hv->fb_size)
> > +       if (fb->pitches[0] * fb->height > hv->fb_size) {
> > +               drm_err(&hv->dev, "hv->hdev, fb size requested by process %s for %d X %d (pitch %d) is greater then allocated size %ld\n",
> > +               current->comm, fb->width, fb->height, fb->pitches[0], hv->fb_size);
> 
> Any reason to add an error message here. Since this function is called
> whenever there is an update, avoid printing an error here.

Recently we hit an issue where userspace application was programing the bigger size buffer then the actual allocated size for framebuffer by hyperv vmbus. This resulted in black screen, and there was no error message it was failing silently and took a
 while to debug this issue. Although the function will be called in each update but this error is printed only in fatal case where pipeline is fail to set the crtc for desired resolution.

> 
> >                 return -EINVAL;
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 1.8.3.1
> >
