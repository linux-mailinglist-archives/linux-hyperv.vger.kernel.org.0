Return-Path: <linux-hyperv+bounces-1864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E68907AE
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D042979D0
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A4D130E46;
	Thu, 28 Mar 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Gk2UXH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB991C6B0;
	Thu, 28 Mar 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648461; cv=none; b=NPCm94nwK8Zk8QS37dKMlZA6rD9WssCfvjCiqjttdHV8wd6o7S5n1cChqU4bnniBbCnv6vRrKpNZV8Xh6wpEBluuMLXcM4AOYhKTMM96uA+ZGr7V75h1awmlelfNshmXnzsezV+MaEmQnuXHvRCaDRQ8JFmLgGtgUtXud4ipeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648461; c=relaxed/simple;
	bh=8O7B4ndnzZYI74uzyfTuc1Y0kP3Ph8Ksu/YsD5/bHbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDwbcnk/NVZGHopHF+9E6a5ACd6/3Xwq2U9uPUPD2edyS1a8ZF6Npz9r38DhbblNEoPp0nKnGWM4dErg/h7rHauieLOr53c3SJCoCN3oOXnn5gQbZiKFNUmaiMLE8PXUHubXAUn5BJL1OicNxMGvnRo9diz+UOkmqTZ4MoeCuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Gk2UXH; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4766e56ccccso458661137.0;
        Thu, 28 Mar 2024 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648458; x=1712253258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nG7pFQ9K9R/mz80FNkdLLBY0bbfjalJJC6HLc51WLAE=;
        b=k3Gk2UXHiumnTtQzUB5dWG4O3lJ/rdGCnTHv4cw5+txAcVZMp7wM8q7EP1sSHBOhzi
         9jgkvMiBfXOsask9rcESwhrkgm1O0/tzU5vQFiV8KVbSzZUEziBlYxlscbifgz8Ou05E
         PETzvJISmjgT/ETJriHk8L4xbIFeUq9mA4uDGd8nRZYgjkBBR64cMnB6D4+T0CI9hROM
         rkSSRoHd1aTNPlVZHkLE236WMJwgP3ydTW6ubmJ4jpDug5K3t0qLjTGsv9zlFpY4m1t/
         CyF8NdRjTmjFrzBjn/gdn3FOuxFXHq17FlYQhaZsa8w49g0sDLQ8toG+a8D6zwrC8h60
         RBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648458; x=1712253258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG7pFQ9K9R/mz80FNkdLLBY0bbfjalJJC6HLc51WLAE=;
        b=eT/+O+jrTK6nxgGsPXuIkb1GIZK8hv11fRhvmFbyl0DEDRHTcU5rInne6ytrgllic9
         h6W/qa4Pk2wiy1J36k+Ahv3Mx11CM95aXgIT9dnkULoJBOTlcPE4NRGrLXubTpWzjNNQ
         jpfe3+FS9J9wZlCGgJve+6mtnEZCSA9sxUVE6JMCvDIBIHh/UiM7lzYKA9smiqUxK5w+
         bv4IGmT4AeTef00u1j+qnJ5ltvr5pdJjS/r9sjvWeHJh3Gl8R1GYQV4paP56QbibVF2T
         ysuVIgLbdT3X+ITqDOXFb7DZ8yU0mTDV6yihLZRKOOTCBJI4K/kzY8GshLMDbPBNrNsz
         ysAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYOF0hIoI1e+3HsyG4vssWlb15lSFhXbLrdlgZCapX8aQRQP54uXCkntP97HXzYjEaKptQOxHQPF/zGf+iigwJDotg/beuTw1T+gD+d+SBHL/YOLUYchlSnQiBMKMvgE4piyP+LfKP5M8+lOjFevuGZceu0lwX7uHZuiVQCA3iYBFRNuTU32TI5Gse1qbm/YSqjfzhje+L2vp3/TU4i3yzjOCH8s1L43ab4jKaw0+iu0hVjCHzXUnWMz3SA7YFxLTiXZx7LGTPOQBbVfEVoRtmxravLkHnItvxQIzSpYGmSJHaCJmLzMY5su3ITsSy5yuhtXuPtK/KxfbTMxNe3K+kNfqz+SxxFNvzVDOnQVYTFuq7f2J93d9RGSdLnqEZ3HnpKSVQphQoA7C+gW82apSArhcxPRjHWac5oEhTuCkPhyu0uCHL3mF7/cQUEbFk13efUmjPzRmt/2OJQ9arQdw/2xsbajiHgjvMZf3GhqJ6JyrAjfRPRKAlqt+3nkVgdxvHDNxqfFNKzEozSIOdkg+ROjdDZIKJXvHWOTPgoTUOw2+7jIZlF5wS70vSSXeug0gkI3BLwIm6F370VKBkm8=
X-Gm-Message-State: AOJu0YyIM20Svv9uGi+jdHk/0lIZ/eGfa7KMyiG83Ky7uxPYv2FlcLU+
	kU34FfkrYXeynbk6InYlfS18PwAg2KuTdsh3D4eS5r1EY91kmY3PNVjjGJC7iBnD6NT21AFPmQA
	L9EbcS4NPlZDMv4XyRizwYKLOP7Y=
X-Google-Smtp-Source: AGHT+IGBQCwISe8ItG/2YCXarhKnEHlwL8nEFQuoDJ++KAY35MV4NPvZiqYz3quZfRGkQvsUcmc8+OZbNMhL2JCbvQY=
X-Received: by 2002:a67:b64d:0:b0:476:fc98:c73e with SMTP id
 e13-20020a67b64d000000b00476fc98c73emr4018043vsm.34.1711648458714; Thu, 28
 Mar 2024 10:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-5-apais@linux.microsoft.com> <42c445b4-a156-4c43-bf98-bd2a9ac7a4fa@rowland.harvard.edu>
In-Reply-To: <42c445b4-a156-4c43-bf98-bd2a9ac7a4fa@rowland.harvard.edu>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 10:54:07 -0700
Message-ID: <CAOMdWS+4T7rw577q9iW_oin8bbVF4m6Mpx-L2riqno5QX_L=WQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] USB: Convert from tasklet to BH workqueue
To: Alan Stern <stern@rowland.harvard.edu>
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
	oneukum@suse.com, openipmi-developer@lists.sourceforge.net, 
	dmaengine@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> >
> > Based on the work done by Tejun Heo <tj@kernel.org>
> > Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
>
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index c0e005670d67..88d8e1c366cd 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
>
> > @@ -1662,10 +1663,9 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
> >       usb_put_urb(urb);
> >  }
> >
> > -static void usb_giveback_urb_bh(struct work_struct *work)
> > +static void usb_giveback_urb_bh(struct work_struct *t)
> >  {
> > -     struct giveback_urb_bh *bh =
> > -             container_of(work, struct giveback_urb_bh, bh);
> > +     struct giveback_urb_bh *bh = from_work(bh, t, bh);
> >       struct list_head local_list;
> >
> >       spin_lock_irq(&bh->lock);
>
> Is there any reason for this apparently pointless change of a local
> variable's name?

 No, it was done just to keep things consistent across the kernel.
I can revert it back to *work if you'd prefer.

Thanks.

>
> Alan Stern
>


-- 
       - Allen

