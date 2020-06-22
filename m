Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74D20437A
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgFVWUl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jun 2020 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgFVWUi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jun 2020 18:20:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE8C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 15:20:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so8201537plr.4
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=mikDJjTv3iBXAil2F4gJwj77CVERBi3Vn6zbk95TUlA=;
        b=Qg9ZfZoPFXmlSNKhq0zAE4/MoLjPryElQwaPFpqSWwAFzbvQd0uCAy1wNdspJM4Act
         ycmO5BTppQHX8UcA6kOdeMSg7fnhQmA8NWD4v8bMnFWh8m5j4qZlIIbhL+jznYae2EEX
         Jq3K5dnxMKw/jlRxOmHn6r/5FxDQHU0jiOCeMmpPG14b/Hgeeqx5NQ8/9USZKUnZcrvP
         LPV0w+kgFjV1wqN5oQcHxNPzuGGzhbNiU+hjx9ihiG7BThLBzBR9rl59SyCVOZRgnrD9
         /prVspOKE3Iu3pU605j5wWnXu07CHO6rzP3iaVpa84xibUbfuDp/anCgv/KrskmrsyiP
         U4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=mikDJjTv3iBXAil2F4gJwj77CVERBi3Vn6zbk95TUlA=;
        b=kj6MehOyeeSin7czMsz68MGlaiT0VzlKwzcvgq/hbuRZoAa7aaal5DI1atkMxFYKhk
         3c9vZdQG24cutc3zXeenqV7LeQcyX8XjRwC6Jg+sQ4uuO5Avk5hinXPrufqufOoTsiWl
         qUv+QSEq612ixx91ZNfSSNa/5Da7eJPfyo5zt05uHBI0rTiLtF5VfPAg7EQyZCKqklyE
         TBemroUVsEcw6BszAQHyL6gsHQgLpJks3MyaTWKKxHVgRxoWmGKOvJh5S3Cb2UJcNmZm
         RJwylTS9wnK8bGZJiPMbid70WcNXPOk4ziCV9pHYQYa1lJylTp+jqeU0mMiCn9PStiUs
         E9UQ==
X-Gm-Message-State: AOAM5321x8EMQC6L6J/ycc+iIB86LkAmqT1fSS8pWhs3+fuUGg0uv3mo
        iEpA3J6PMahJpmwZaCOwHMrZx1DVw0Y=
X-Google-Smtp-Source: ABdhPJwWqgYGd+aoe2YVkfvuD1whrh9WyIk5ZmjHTAZDIVp6POEhKEyMfKtpkHOmdo/rvBUlkutnKw==
X-Received: by 2002:a17:902:7008:: with SMTP id y8mr22046673plk.84.1592864437239;
        Mon, 22 Jun 2020 15:20:37 -0700 (PDT)
Received: from arch ([2601:600:9500:4390::d3ee])
        by smtp.gmail.com with ESMTPSA id o20sm448930pjw.19.2020.06.22.15.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:20:36 -0700 (PDT)
Message-ID: <f6923296368dc676df10e75593ebc18575efc476.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Wei Hu <weh@microsoft.com>, K Y Srinivasan <kys@microsoft.com>
Date:   Mon, 22 Jun 2020 15:20:34 -0700
In-Reply-To: <20200622124622.yioa53bvipvd4c42@sirius.home.kraxel.org>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <20200622124622.yioa53bvipvd4c42@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2020-06-22 at 14:46 +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > +/* Should be done only once during init and resume */
> > +static int synthvid_update_vram_location(struct hv_device *hdev,
> > +					  phys_addr_t vram_pp)
> > +{
> > +	struct hyperv_device *hv = hv_get_drvdata(hdev);
> > +	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
> > +	unsigned long t;
> > +	int ret = 0;
> > +
> > +	memset(msg, 0, sizeof(struct synthvid_msg));
> > +	msg->vid_hdr.type = SYNTHVID_VRAM_LOCATION;
> > +	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> > +		sizeof(struct synthvid_vram_location);
> > +	msg->vram.user_ctx = msg->vram.vram_gpa = vram_pp;
> > +	msg->vram.is_vram_gpa_specified = 1;
> > +	synthvid_send(hdev, msg);
> 
> That suggests it is possible to define multiple framebuffers in vram,
> then pageflip by setting vram.vram_gpa.  If that is the case I'm
> wondering whenever vram helpers are a better fit maybe?  You don't
> have
> to blit each and every display update then.

Thanks for the review. Unfortunately only the first vmbus message take
effect and subsequent calls are ignored. I originally implemented using
vram helpers but I figured out calling this vmbus message again won't
change the vram location.

> 
> FYI: cirrus goes the blit route because (a) the amount of vram is
> very
> small so trying to store multiple framebuffers there is out of
> question,
> and (b) cirrus converts formats on the fly to hide some hardware
> oddities.
> 
> take care,
>   Gerd
> 

