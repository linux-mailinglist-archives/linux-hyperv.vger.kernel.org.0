Return-Path: <linux-hyperv+bounces-1851-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDF88EBD4
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05961F2FB72
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4614D70E;
	Wed, 27 Mar 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckfkJpte"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1354148835;
	Wed, 27 Mar 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558706; cv=none; b=NamUCOA6s8va22fN1OXqR9cz0GO31GxqzVh4wM4FmWwHTP1ou/QtBcGPzmtsMM/RDky7oG1+l1cNQb5sWYQx1AOPVH+9cuw3906q7OCNAiZLeHwxvv7uAgAJvMGlFmTTLvuectVWX5hIMWTwOow2XSagvX6xQHSqU/XorqiexMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558706; c=relaxed/simple;
	bh=68oAjuOe+OtmBLErtbaq8rH3+7CTr5nb8XNBRGIt+ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4p2lr+qVpZCC7imiw5JoN5CUaazlBgoNXP5JqJceMvz4+DeHa9uHzyshOCAQaXInYOHmpI0JEnbcY/4Q8X3sKMbdV1gIGGec0YsFUQk187B0bizsVAQcaRgaM5I2oyS/AQb5hSLvmAyeGkIdplgzBGf8Zh1TbtxJHksgPF3/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckfkJpte; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-476794adf30so2697024137.1;
        Wed, 27 Mar 2024 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558704; x=1712163504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUltN/NJxMhxZV1CH62BOvzy406AgQtlnwGFiPeOm1M=;
        b=ckfkJpteGm7XCNtho31GGIx7rxeiwCLcEehHDPmagJO6GPaPsWqjOulaA7fSfUpWoR
         hgUj3obgxGj/lPR48GbOHyNuU2HKlqGvmSHhhUSj5CQy8SsiWlhkwnbzcP9ln2NghDLN
         mBJH/c8bZdVY7fqCuSfLf9TVA5f8Gsl/zxuFprg8bmtGhe3atKajWGyi1MSWoiFVe5A0
         6bBYOndui4T4Jo1unOE4DIHpb0JkW+kc3oCeZundaguc/nPxmxax2GkNBPYa11vHe6cL
         G1NSBEolZikMOWPAYyQVb16SEbKd7IMl7LVlXZ/hJeQQ1NGF5XsLvcQzWfcHkJpRrEnE
         F15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558704; x=1712163504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUltN/NJxMhxZV1CH62BOvzy406AgQtlnwGFiPeOm1M=;
        b=NKQ12SJFoFCjMiu00meIisUAH99XJ+YdaN2UVhlUWPfndyYs3NsfFVaYTrlnbvGfrG
         UtIrJLyqDVrDTn0yDNT82InomIaYFgEl9Ife35vrv+/gFsA6FbZTcHeiEeu2r7wDEkuZ
         Fo/qwiUmXHTG/pGCf3vLM2PQuDtqhxpONR6iPpqVyAb2WlnEVaO/MpE6HclyEHztvhZl
         kMbNDqxGZY/UG8f/HMQhZRm4zBaNvA3GeswpjS42+/kASTixhu99mgwqV0OMJEjeaK5r
         JjeelFNnv6T/SPpeOyEdbPk9MsSZVH8ALqnERB105wg7ft6rfzwdwF6gntlTM5ZaZDYZ
         EVWA==
X-Forwarded-Encrypted: i=1; AJvYcCULFYzDpcr45FafFATbKzaC4rFzgGCcNAmUm9bSqi7dJu7CyTfwNBAfcXWW1+ZYsOjNY0tKTeRdC1fb53E+gIdT1vZmPdPIvZ1SA+ilcx5uG25vD1UK2SVkb0T11xVilFfd8Ec1jpuAliGdmnIiXNjI15hMAgQ93AF2qOMutKsUvAaiELn3jFmqG0WHmj2MkSgQxn+pBVRR1QBhcar0i5u2lV0UkUDrT/NPLWVyTWTnjez+aXpZozP4IB25x0cS83Ulvah1a+2LtL1NBSkUePPLc6VwR1x0QcOOhtPot9rGFSZCIZH+0J8HSj11KppR26/R3/8SymJXSqLS7fjhxtLY7Qdjz8p/qOV1Nd2X6Y6sdoX3+ybC9OoRl2op5p2feUivOz1Q2xXVLbOg9kW7co2Dbu31ZJmdzISl4C0v1SkWum3Bc168LggOiQKO5A7hySxdLRKn0J58eo7GHXQX1GD+o2d6H32mnQgvpOKAUdVqv0725cIfSaYGpfXFYaA5zRnpw/Y1Dgj+x6RfWqDRLx/+fMQttTNky+r98U5CNHd//FRYzGWHKShU5TLTqWWFpXihdCRQBN5bZow7fvvU3C4=
X-Gm-Message-State: AOJu0Yz6IZ0/Jwk9cnnAAAKCmz6PUwebNCazfsdzXY5JmW/KALiVNNI8
	jT9niDdu7bjt+B7F/fCZVUvTh+FGKWa6rjMt3YBPkRYKHEC7tm7ijuamn90sR/hK0KnWquZCWRl
	xLvBVC13cU6dkbxwdHXCz3hggp/Y=
X-Google-Smtp-Source: AGHT+IG2+7fcvBBedZik6uQF+4M2q3ObjFc26qAotYqTJVzVn8pG6NuXX7LEd77qXX8Tn8MdeN0ijCK67x3Q8xGLlB4=
X-Received: by 2002:a05:6102:3b83:b0:472:64aa:403f with SMTP id
 z3-20020a0561023b8300b0047264aa403fmr602964vsu.26.1711558703814; Wed, 27 Mar
 2024 09:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-5-apais@linux.microsoft.com> <2024032753-probable-blatancy-80bf@gregkh>
In-Reply-To: <2024032753-probable-blatancy-80bf@gregkh>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 27 Mar 2024 09:58:12 -0700
Message-ID: <CAOMdWSLipPfm3OZTpjZz4uF4M+E_8QAoTeMcKBXawLnkTQx6Jg@mail.gmail.com>
Subject: Re: [PATCH 4/9] USB: Convert from tasklet to BH workqueue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org, tj@kernel.org, 
	keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev, 
	florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, 
	paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, 
	manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com, 
	leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com, 
	haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
	logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com, 
	robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org, 
	jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	jassisinghbrar@gmail.com, mchehab@kernel.org, maintainers@bluecherrydvr.com, 
	aubin.constans@microchip.com, ulf.hansson@linaro.org, manuel.lauss@gmail.com, 
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, brucechang@via.com.tw, 
	HaraldWelte@viatech.com, pierre@ossman.eu, duncan.sands@free.fr, 
	stern@rowland.harvard.edu, oneukum@suse.com, 
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The only generic interface to execute asynchronously in the BH context is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > behaves similarly to regular workqueues except that the queued work items
> > are executed in the BH context.
> >
> > This patch converts drivers/infiniband/* from tasklet to BH workqueue.
>
> No it does not, I think your changelog is wrong :(

Whoops, sorry about that. I messed up the commit messages. I will fix it in v2.
>
> >
> > Based on the work done by Tejun Heo <tj@kernel.org>
> > Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  drivers/usb/atm/usbatm.c            | 55 +++++++++++++++--------------
> >  drivers/usb/atm/usbatm.h            |  3 +-
> >  drivers/usb/core/hcd.c              | 22 ++++++------
> >  drivers/usb/gadget/udc/fsl_qe_udc.c | 21 +++++------
> >  drivers/usb/gadget/udc/fsl_qe_udc.h |  4 +--
> >  drivers/usb/host/ehci-sched.c       |  2 +-
> >  drivers/usb/host/fhci-hcd.c         |  3 +-
> >  drivers/usb/host/fhci-sched.c       | 10 +++---
> >  drivers/usb/host/fhci.h             |  5 +--
> >  drivers/usb/host/xhci-dbgcap.h      |  3 +-
> >  drivers/usb/host/xhci-dbgtty.c      | 15 ++++----
> >  include/linux/usb/cdc_ncm.h         |  2 +-
> >  include/linux/usb/usbnet.h          |  2 +-
> >  13 files changed, 76 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> > index 2da6615fbb6f..74849f24e52e 100644
> > --- a/drivers/usb/atm/usbatm.c
> > +++ b/drivers/usb/atm/usbatm.c
> > @@ -17,7 +17,7 @@
> >   *           - Removed the limit on the number of devices
> >   *           - Module now autoloads on device plugin
> >   *           - Merged relevant parts of sarlib
> > - *           - Replaced the kernel thread with a tasklet
> > + *           - Replaced the kernel thread with a work
>
> a "work"?
 will fix the comments.

>
> >   *           - New packet transmission code
> >   *           - Changed proc file contents
> >   *           - Fixed all known SMP races
> > @@ -68,6 +68,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/kthread.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/workqueue.h>
> >
> >  #ifdef VERBOSE_DEBUG
> >  static int usbatm_print_packet(struct usbatm_data *instance, const unsigned char *data, int len);
> > @@ -249,7 +250,7 @@ static void usbatm_complete(struct urb *urb)
> >       /* vdbg("%s: urb 0x%p, status %d, actual_length %d",
> >            __func__, urb, status, urb->actual_length); */
> >
> > -     /* Can be invoked from task context, protect against interrupts */
> > +     /* Can be invoked from work context, protect against interrupts */
>
> "workqueue"?  This too seems wrong.
>
> Same for other comment changes in this patch.

Thanks for the quick review, I will fix the comments and send out v2.

- Alle

> thanks,
>
> greg k-h
>

