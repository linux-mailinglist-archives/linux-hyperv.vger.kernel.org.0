Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD112097F5
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2020 02:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbgFYAr2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Jun 2020 20:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgFYAr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Jun 2020 20:47:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDADC061573
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2020 17:47:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so2103028pjb.5
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2020 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=05voGHapV3v2tFXJ01TbMw21PCVprhpQaXbrlBrqygY=;
        b=FVOb9GIfBGZ922ZCKREGsKrLGYAuqMPyiKgSLOBvk9Zo4hrf2pVzCVps/xq6fAtGjo
         nvdV/tBax4EN45Mge61+BA1qJsG0KI09cVvmIft03LU5Mke/DZNk/zVq2gsqktAD9w5V
         Ia8OUwtNHXXBbJUGuBTHjdUNZJKkYiMx7porkR90WbxjAWWkFQPm5lUwymAwjGho9ANr
         jKaAwktoh0Pru3tVJlxwARxJ6Iruu1/38rk5xY6C6/vTxiDmAn3XUDOxpIYRW+Btea30
         qJ6N9jSM534sia6UxDV6033vAsF6pNYVSl3e6/BPL71m/lKk1p9Mgj2yTtOTF/qt9o2b
         COlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=05voGHapV3v2tFXJ01TbMw21PCVprhpQaXbrlBrqygY=;
        b=QNpSf9xHZHCi091EnMLl6O3mJ80A2f6xrmIAwlK4T1LvsWcTJyXhHx95qEp2lrVWD/
         jkpdwsJZIQx5ekN4GNVB0epf9iCKF6jwx8suDRj4KG5JHb0BUA+HTKzqDIquxjY0J3Qb
         KCldUs2qco9vpvsWOsK0XX9HjJ5+hB8B3RZuIKVvt+i1QQ7Tb249Uz/5gMXlfoRpecEN
         RdNv799rig9X9D2wXIJHpJ6AlJiuEBQtEJYGt/3TowRdY41Ih3EJq7YjkRrt91yY9MQ0
         L20wWKN8dG0w81SEXnRRFXl1iTpiLqfno4ziOvGUvv5lQKccFK6JRoA0PWsUwclUSIpz
         hfQQ==
X-Gm-Message-State: AOAM533IiS+mdIavaOTfPsqm2+VkuhX+kEyiJQdtiLHCkJ2HbNPQRy14
        pfso+a7WMtIEJy25bNbjvqo=
X-Google-Smtp-Source: ABdhPJx2JugfcpQsNsP+qu0DqzyhWFIb/RDnlrCiM12R4lWEaL504i0IX2I61z5IXtK8bgEKpBE1NQ==
X-Received: by 2002:a17:90a:7401:: with SMTP id a1mr453250pjg.218.1593046046228;
        Wed, 24 Jun 2020 17:47:26 -0700 (PDT)
Received: from arch ([2601:600:9500:4390::aa23])
        by smtp.gmail.com with ESMTPSA id s36sm17901897pgl.35.2020.06.24.17.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 17:47:25 -0700 (PDT)
Message-ID: <94e6d4d0e047d306d96717b5cdd2442b21ea9932.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, dri-devel@lists.freedesktop.org,
        Michael Kelley <mikelley@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Wei Hu <weh@microsoft.com>, K Y Srinivasan <kys@microsoft.com>
Date:   Wed, 24 Jun 2020 17:47:23 -0700
In-Reply-To: <20200623161742.u6hnb7iodptv4s6t@sirius.home.kraxel.org>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <20200622124622.yioa53bvipvd4c42@sirius.home.kraxel.org>
         <f6923296368dc676df10e75593ebc18575efc476.camel@gmail.com>
         <20200623094225.GJ20149@phenom.ffwll.local>
         <20200623161742.u6hnb7iodptv4s6t@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> > > Thanks for the review. Unfortunately only the first vmbus message
> > > take
> > > effect and subsequent calls are ignored. I originally implemented
> > > using
> > > vram helpers but I figured out calling this vmbus message again
> > > won't
> > > change the vram location.
> 
> /me notices there also is user_ctx.  What is this?

Not sure, I will try to get in touch with hyper-v folks internally to
see if page-flip can be used.

> 
> > I think that needs a very big comment. Maybe even enforce that with
> > a
> > "vram_gpa_set" boolean in the device structure, and complain if we
> > try to
> > do that twice.
> > 
> > Also I guess congrats to microsoft for defining things like that :-
> > /
> 
> I would be kind of surprised if the virtual device doesn't support
> pageflips.  Maybe setting vram_gpa just isn't the correct way to do
> it.  Is there a specification available?
> 
> There are a number of microsoft folks in Cc:  Anyone willing to
> comment?
> 
> thanks,
>   Gerd
> 
> PS: And, yes, in case pageflips really don't work going with shmem
>     helpers + blits is reasonable.
> 

