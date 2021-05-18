Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873153870EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 07:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhEREqy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 00:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhEREqv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 00:46:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45F0C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 21:45:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d16so6489907pfn.12
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 21:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=0uTzP8bfDg5xGex7AZegUPneohvxogqMnDFj+4FfEqE=;
        b=Uj+rH+KO3nKG0sTNvSoZfr7oAMEbLiCRfx+dI+YvS9ViwW7vMU7R/wEbCx/DAwVRbV
         vnoJqVOlfgufisoz2PjrsiqgH3nn+6Aq0eogD+djtDgyvqlEVR7okpF/Aw1nXMmkRHyZ
         9jmypi/wehgzQ6+VqWowcE17ZlB4N7qT8SbPvG4lAVYT+tg5uEiGG3a5jMW3XbnPiU9d
         NVY6IU8uLIH5ovIHavoWVTl5Lp+mG0RWOrItfiLD5Cg0Z49+7JJc7B8OGkQZRtbj05kc
         KEhMVTddJ/Vyfqi3K2sq+sqbTXA1hD3JcZntT69xc3v5khcvPg8WJpmJh7cgT69gGz0v
         0KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0uTzP8bfDg5xGex7AZegUPneohvxogqMnDFj+4FfEqE=;
        b=TyJjDHeemX9lRDWdyrN7xLdXIPSYR2PgR3Z7IhUBNKiAJT0l1afYqmmzZ5s0tZi3Ne
         fv/5Ove3nB9CLs07t2SLYXJ+wioIBdV5kO8jq5rUwTbDnVVUJ3xCMQxgUwjXwaNXlJcO
         cn72V9eMLAu2ZTtoJalZBxMoKIc3yYlNNzZ2eqn7LEQpoFWn1JF2GFAei7+J6EBlinPi
         iafVjLu/3riAyyoYytOPa5mzt9Z1YHUMA1ajx8bGfDaHhPo0exNIXVgvaNgljNBUY6qP
         O9dqqaBa/lN4SvaOHJRTmEYNSXhe7QUinJd5ApvYW5Y7SNHCakkmYtkFGYQWjJweNoYn
         DNrA==
X-Gm-Message-State: AOAM532uLEFoH5DkxuXGz6YHutnga4vC9FpkF2/VUq+IhbjO+i0uuSc0
        P8yro+o57F6DaomvNwypJyQ=
X-Google-Smtp-Source: ABdhPJxDSbqeG9WueFoP/nL0tlNMtKISInDtOmc+0gdFC6b1lAntImV5v77eugpnt0GOi+wxUrDnIg==
X-Received: by 2002:a63:d45:: with SMTP id 5mr3147016pgn.72.1621313123515;
        Mon, 17 May 2021 21:45:23 -0700 (PDT)
Received: from [192.168.1.7] ([106.212.13.216])
        by smtp.gmail.com with ESMTPSA id np1sm806576pjb.13.2021.05.17.21.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 21:45:23 -0700 (PDT)
Message-ID: <5476fe6d3ad2fd243b58778e5d9397aeb85f1a97.camel@gmail.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add maintainer for hyperv video
 device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Mon, 17 May 2021 21:45:22 -0700
In-Reply-To: <20210517172503.ytpuucwphtwhcgsi@liuwe-devbox-debian-v2>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
         <20210517115922.8033-3-drawat.floss@gmail.com>
         <20210517172503.ytpuucwphtwhcgsi@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2021-05-17 at 17:25 +0000, Wei Liu wrote:
> On Mon, May 17, 2021 at 04:59:22AM -0700, Deepak Rawat wrote:
> > Maintainer for hyperv synthetic video device.
> > 
> > Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bd7aff0c120f..261342551406 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6077,6 +6077,14 @@ T:       git
> > git://anongit.freedesktop.org/drm/drm-misc
> >  F:     Documentation/devicetree/bindings/display/hisilicon/
> >  F:     drivers/gpu/drm/hisilicon/
> >  
> > +DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
> > +M:     Deepak Rawat <drawat.floss@gmail.com>
> > +L:     linux-hyperv@vger.kernel.org
> > +L:     dri-devel@lists.freedesktop.org
> > +S:     Maintained
> > +T:     git git://anongit.freedesktop.org/drm/drm-misc
> > +F:     drivers/gpu/drm/hyperv
> > +
> >  DRM DRIVERS FOR LIMA
> >  M:     Qiang Yu <yuq825@gmail.com>
> >  L:     dri-devel@lists.freedesktop.org
> > @@ -6223,6 +6231,14 @@ T:       git
> > git://anongit.freedesktop.org/drm/drm-misc
> >  F:     Documentation/devicetree/bindings/display/xlnx/
> >  F:     drivers/gpu/drm/xlnx/
> >  
> > +DRM DRIVERS FOR ZTE ZX
> > +M:     Shawn Guo <shawnguo@kernel.org>
> > +L:     dri-devel@lists.freedesktop.org
> > +S:     Maintained
> > +T:     git git://anongit.freedesktop.org/drm/drm-misc
> > +F:     Documentation/devicetree/bindings/display/zte,vou.txt
> > +F:     drivers/gpu/drm/zte/
> > +
> 
> What is the section about? Is this a mistake?

yes this is a mistake during rebase. Will send correct patch shortly.

> 
> Wei.


