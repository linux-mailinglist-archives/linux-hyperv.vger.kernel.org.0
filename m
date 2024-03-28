Return-Path: <linux-hyperv+bounces-1871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32252890A71
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 21:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D760D29B0B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63513A3E8;
	Thu, 28 Mar 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/hBLy32"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC29137C26;
	Thu, 28 Mar 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655943; cv=none; b=pZmjU6ZkqXVOf//CxLy/6nqh0c/7AeXxNHl9VhCxFPUubtpawB8B2XospJqNFWy6Kp7HxxrDv1Kvt7U17u5hNVG6l8xLwkN/XX6zedkb8ThQEKtMrwYpfmUnyJcssJhUuoXJSKjCKy32yIBD8vbArHgNKGJRsgL7bvUY5EJazvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655943; c=relaxed/simple;
	bh=ZJAY5ItgPFNW0LMb5RnANZBqjmUyKGO9ruTQ3rdhYns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abfveTTXjwSRWjJUr+Lo11Kpq6tFXn5GNOxhI/yHvChv+yXpJhGOU1T9LZK1AblxQzda+SLD1idv+hhhn07yG+vYCbOU5JE0s4cH18uqYgS2R4v4GrzFZnh0x3BIv1ztP2MselkYsUHTkRIdr4BKMeHHfwqqH0BoBITpqoLcp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/hBLy32; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e0425e5aa8so396526241.3;
        Thu, 28 Mar 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655940; x=1712260740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vnKBKhBKsmsJMY/bC4lZDp0UO96Fq//Yoyy126bkPGI=;
        b=i/hBLy32YYW/o8j3jlyT+58N73XWr4B7nEUysc6HQGvHX/dXUUf9BrlAekuhzfeCpX
         OvvCSJrGdFgHBFHmzE5U84AhiSl2pfojaS40NgbQugrYHm0z20LUq4Ewv9RNV3pDuLHQ
         zuBPLjn9y0+Cf/ARg2ussYnyELP22NkypxWVYl24RlmHKFpbHhYYqDzwJ2Xq+A9TxAGe
         ucSWRgOMxDU90tsotlsQ6iW/2+pm5dxix7jkl6GSfclY2iG1IbaRFdKLtHsmstq3sHaO
         mfQU844pkCEw8CnS1c9f9Ma+W+I4ZeGLcdOa5G5j5urWobzqiZBgjYWl9ctwB5B95LZZ
         96DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655940; x=1712260740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnKBKhBKsmsJMY/bC4lZDp0UO96Fq//Yoyy126bkPGI=;
        b=j1Nfg/elcADLj8v9Rfa1f8MY3Bg8dCs8vvXnwKihxiwznCN8ntr9B+b6BoPd3cbWZQ
         SxazB+FMzP4bROJnYL2N65+v+YHAcywwg6zZC0aHDkQ4NHxlmg0NARNrqJgyi7uCQB1Q
         lUlHwUhR7pWAXod58qgvox0ygBz4xgYXycKh1mCN8Mg68dL2kw/+jnDyYv+zPjrvKj1X
         jeBmAHMv7QIx98rR8UQ1xphHEeeCg8oQY5Qcg8FqUZQW2e6EAvkZrUtdoFdt9nOFrKAV
         8kC2RMLKNaZXbi57sxq6mLi4jPlIbjhqNeUSRUbdgdLpXx8bm69n9/NLdaxSF09D5nBJ
         n86w==
X-Forwarded-Encrypted: i=1; AJvYcCU/5nSbr5ngakMEsCsYdcLYd69F+RxWN1k0X17193zxtZvSKXcNU37ePENQVUwzR9JX57ubYnL83GmOPMDcvjr+1sEFzky1L02TT7A5gP+OF0v0IFU4aBEb4msHu9AEOtq7Flle8Un0goMzFekKxiDs34Nc4Go1n2Q4g8t8JJM0QnJD3OUhhxwq0FjiAP4b5akZamLB+meyJpG95a7Zf8zIARo8itSz5WCJibjv88Ww5fZMu934l3JMjEc18EZtmxbJSghLZxf+wY610IziqyX3/PGzkC/Sbm7dddFLUS5YrtiLAyuiLJysKvha7cG7X8kyJUjHTxFmyou8D/6it3n+be/XrVQAcdP6X5wfwwaYNHv7gdLGsc4cPAOkJYipeY+T2d9+dgI/Aj+fvFr0pDRt2h60IbHDvK4JdeDQFmOob9puQCyfnao3dtv0IN26BcTta8yI7nxgeUT9t6bXu3VGVzSxk+rH/Ob+LQMbt6SWprby3SRayDzqjXtV6sbAUMfXg7gOdBt4uV6c1ALEkw6d5yCdrKJx98a56QyPaK+XgKZOlemc+IH+TUBNyiQpQAjUs3UvAV9Z7Hir0Z9SJhk=
X-Gm-Message-State: AOJu0Yy/VcUJSpofnXO/IqOfIdWHC4xhGlkhm1fqBNHfw8iG3a9kL9gJ
	W/91jjuRRU1ayHwki3FsghQJyFFhoQYVUqg3AGtZ0OtDwtvHgZS/KfSrB9FMsqaoVjySTImChu1
	XPB6iTimdOT3ab4DOWy6pvRPNr23TrbbqUJEj5w==
X-Google-Smtp-Source: AGHT+IEsqiTQ+RuhLXyb/Y+jV0DgOZDtp/0zVM9owKFV3xn7f9aoxOYdP+JeSKGOIKqBlapOYOkCUtaaLw32MikZSqo=
X-Received: by 2002:a05:6102:2a65:b0:476:cf52:e1b7 with SMTP id
 hp5-20020a0561022a6500b00476cf52e1b7mr141814vsb.28.1711655940207; Thu, 28 Mar
 2024 12:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-7-apais@linux.microsoft.com> <ZgRePyo2zC4A1Fp4@mail.minyard.net>
 <CAOMdWS+1AFxEqmACiBYzPHc+q0Ut6hp15tdV50JHvfVeUNCGQw@mail.gmail.com>
 <ZgXDmx1HvujsMYAR@mail.minyard.net> <CAOMdWS+nB5EENp_Vb=k1j77nrch5JgbZP2XYPJ2ieTja14zB0w@mail.gmail.com>
 <ZgXKeL36ckOyNpI/@mail.minyard.net>
In-Reply-To: <ZgXKeL36ckOyNpI/@mail.minyard.net>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 28 Mar 2024 12:58:49 -0700
Message-ID: <CAOMdWS+KrT2dK0XiEkZJT0aHnre1sr6gMMSkdxuXZaUh5e2e8Q@mail.gmail.com>
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

> > > >
> > > >   Fair point. Could you please let me know once you have had a chance to test
> > > > these changes. Meanwhile, I will work on RFC wherein IPMI will have its own
> > > > workqueue.
> > > >
> > > >  Thanks for taking time out to review.
> > >
> > > After looking and thinking about it a bit, a BH context is still
> > > probably the best for this.
> > >
> > > I have tested this patch under load and various scenarios and it seems
> > > to work ok.  So:
> > >
> > > Tested-by: Corey Minyard <cminyard@mvista.com>
> > > Acked-by: Corey Minyard <cminyard@mvista.com>
> > >
> > > Or I can take this into my tree.
> > >
> > > -corey
> >
> >  Thank you very much. I think it should be okay for you to carry it into
> > your tree.
>
> Ok, it's in my for-next tree.  I fixed the directory reference, and I
> changed all the comments where you changed "tasklet" to "work" to
> instead say "workqueue".
>

 Thank you very much for fixing it.

- Allen

