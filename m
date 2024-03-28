Return-Path: <linux-hyperv+bounces-1868-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEC89096E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3161C2C19F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BAC1384B1;
	Thu, 28 Mar 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNbH+dr2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF480617;
	Thu, 28 Mar 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654896; cv=none; b=suRQMJOk4UNnpitTNy9j7/WlfY3TuubpGcCGMoRQigRv1qBx2WmX7THHmTirW7upeSJKgjFNdwPCekblm+ib1j3OEerRFQA3jf0w9Yxcrle8GKL7o6P/ypDV1ZUVIFGCNIXu31RP1Je8rN6VA8CrTG4hW4SF/dDgLwbDDeT42K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654896; c=relaxed/simple;
	bh=t4KQY4ygYmx+OB/j4jytyezWMylsTqngvr/2VLyyCA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAWBwEfynDA2Hy4LVHSlIGU+4fcn4fkT+L+P0cKA0sl2rvVLL3EfM76RvCJ7guKQ+8hi/drhcdiwlfMNiCbjY4QDXj4IwVpDBCQ2BlySofu6nx5fHOQdSOqFfFzkaDoppxWF9o/HATp87vIEqJ+JHGSYpUKiWftz3xNyMdcs5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNbH+dr2; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d42c30a968so434276e0c.1;
        Thu, 28 Mar 2024 12:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654894; x=1712259694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIYRUJlYf8k4Ww5l6bxXyNzs1Z7gSD0K+4rAhlyLzPk=;
        b=cNbH+dr2gW6ot8DEwnUB2fXvabAjj+01jQbhI9+1y1IG1lUzwG2ot/cuOK0cmlmfgO
         Homs/+UuR8M5g/1coScTfMeVKB8Gjz7xilM0dEp9WeVZASqeWVLGzsuJtIVfEnXvuu+7
         Kxk28CszjAKKqsaDPqFWeilUZAXGdcrabRT1WS+SBG6F+4UMuG6gDiNQD3z2Xm7Dsi2O
         U7YoNIeYvX2/wqaxsnaxHnqEj7iG2Agvepxabd9P+3MobYXVzGdDjUgYPggEj6UNnmp7
         e4pThct+uHwZAyUo3Lsm15yoTLf9uj9AxzsQC+cl6BdUsybDtY6oRPp4K0P11wWU+j7o
         Xnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654894; x=1712259694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIYRUJlYf8k4Ww5l6bxXyNzs1Z7gSD0K+4rAhlyLzPk=;
        b=rDbKGXktGip+5XnYIPjuNpImj92eFnI9qAAO8VWA2taZNDGNPNTUAEAeEvsy294k/m
         kSov6fN1zcpwViiyFJF8WvAgFWZKDSxP7u2Z3/5R//Mr3c4sYlFYESlZ7GY84SgEylZ7
         Mnr+T3y/mJ1/FwferyDO8RfGCFVtSogIvs3d41T3jnnH5ceMp/0GLbXVGdTKpyT3nENs
         ooAatDMkhw9GM06pu8OGjyvJ4rO7Rk3nb7JtznrzAzYro8DsOggqDoDGsf0wbinzFEFn
         C+0AcNkIc9K38LE+YikhboBWds3oAm7YD6gjPU3tNnS7WjvgYoeuAEeQ7F7h9iI4l7aK
         yOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIptqr43SOuMFZVW49EOi8Ov8c2VH8PlyCITsZPgtDfcOrgBJNke+3szNVaMr4gihWiA+4zX/9nuwWJyFy0a2o4kHweSPk/tq+bOoh0meQbFIi2jKudUTcSzAHbqgin0W2+7PMkgTDuvochfNmkY+u44cCsVolMw5sHhxjfOQzry58XXc3rgIQp0EdJq+IMLDAG9ju7NZ99aYtxA2MIfeCIg+g/WOy0Chvhg0a1T1Lb9ikSEMbcsjIu2jrKPsmuW0GtQHmEjKHowIETmA8nC0TUMWck3D4wa85vqdl7zJ1SMd/FHJUd5phAZPpHKwc6DhpfSjxD+8pnI6eThDzaDAlcpZG3D80ff4u//DLuhKY7+/0XquR8D554lw5ODdSTwWY7iN/limevjoqURNxDujNXcUDfBUlYRp15gcMYV9yGjrDInpsjqs/srYVmdqaZRlL6JyT5YEeqf9Jh9GfexLq7gQjS/FfGBJRlpeTGIiTGoiaBnPralKoxCKYlLBqpvId9wwnRDNPe3+zvp3iemH+4YdNDXYziJYb+MbCm/4qPZrkgNY/7p6Ecrt6hHKf4Myeqx1DK4ySwfVpaMVDm1Q=
X-Gm-Message-State: AOJu0Yyxgaxdxfl3R6arGWv0Ebar3bNFtbMdEx1QVYEoTH22esdVTUh/
	xECQs5mNpgIV6kA/mSA8FuJmVt+czZ8bCyhE8D89ME9XFKVVpcLxMxT0zmtCtM0aj3OzDTnB24U
	HILcG2WaFxFnZeuC86FskH21pq9w=
X-Google-Smtp-Source: AGHT+IF7RrkP6jmtYq8PnUCxuTgzt2Qt4CTC9MlCAHIq165hbFM88DzkJJ/z4aTnoTdb1soUmIZQWdyI4gYKg4Ogr2U=
X-Received: by 2002:a1f:ebc2:0:b0:4d3:43f8:8541 with SMTP id
 j185-20020a1febc2000000b004d343f88541mr348710vkh.1.1711654893631; Thu, 28 Mar
 2024 12:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-7-apais@linux.microsoft.com> <ZgRePyo2zC4A1Fp4@mail.minyard.net>
 <CAOMdWS+1AFxEqmACiBYzPHc+q0Ut6hp15tdV50JHvfVeUNCGQw@mail.gmail.com> <ZgXDmx1HvujsMYAR@mail.minyard.net>
In-Reply-To: <ZgXDmx1HvujsMYAR@mail.minyard.net>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 12:41:22 -0700
Message-ID: <CAOMdWS+nB5EENp_Vb=k1j77nrch5JgbZP2XYPJ2ieTja14zB0w@mail.gmail.com>
Subject: Re: [PATCH 6/9] ipmi: Convert from tasklet to BH workqueue
To: minyard@acm.org
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

> > > I believe that work queues items are execute single-threaded for a work
> > > queue, so this should be good.  I need to test this, though.  It may be
> > > that an IPMI device can have its own work queue; it may not be important
> > > to run it in bh context.
> >
> >   Fair point. Could you please let me know once you have had a chance to test
> > these changes. Meanwhile, I will work on RFC wherein IPMI will have its own
> > workqueue.
> >
> >  Thanks for taking time out to review.
>
> After looking and thinking about it a bit, a BH context is still
> probably the best for this.
>
> I have tested this patch under load and various scenarios and it seems
> to work ok.  So:
>
> Tested-by: Corey Minyard <cminyard@mvista.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
>
> Or I can take this into my tree.
>
> -corey

 Thank you very much. I think it should be okay for you to carry it into
your tree.

- Allen

