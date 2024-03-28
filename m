Return-Path: <linux-hyperv+bounces-1870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82081890A42
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBE2967A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Mar 2024 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8395D13E8A6;
	Thu, 28 Mar 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSZjD/ti"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2F13E6D0;
	Thu, 28 Mar 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655549; cv=none; b=G8iCXSuIcdYKcIbYGG308uWA28EJpLf7XXNpfrfZPczb7e7/F8zJq4UHd88AlyZO8OK8BL3R/aHEzcBchYI1sUZx60XC4TDrrsYrDzh+uuVud66n41wMS8vFUzLsXhXFNOAlGB8yHIVDWY8gmoCmyRd1kfaoMScn/Re9OBWEdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655549; c=relaxed/simple;
	bh=qmQFGHYUei7BOkNgnnntn6VCVy9UtjipJi0ZJ6b8pZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJbdZtoySnpArpKIq3Y++q+4noEuikoyvfCKGgU8nniqriLp3WjGlhCSIQN2aO4CrNverX+/B/cC/BW8I6UvBtosmiOx8siUe/3mvobdXBRnWiXZaeixC20ZngOUUvSRuBphg/9H4753nOZ4nW1WhH/TYgI+Dba7Tiwa3tKER0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSZjD/ti; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3ceeb2d04so901583b6e.1;
        Thu, 28 Mar 2024 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655547; x=1712260347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT6C4kyGaXJTnO4s5bmEmPWYlNQPKErlDo5CuGDxbV8=;
        b=DSZjD/tiqsflzsxPPIOjMyejt0NBAWGlYrE2Wvot3e2jzuoCM7HG1rkaLTYcDhFPbC
         6JJVcTkheE8+myU/0c2kKCD+JeGq9uPq2wvOFjjZhhDSNSp0mCwxKDs4pYOeM9dneme+
         rQMJ5kN8T1EPBxkfQv5GDoArt3WXZnsrrLTpOXQ2PldTrs9wil7tjOS2ppDuZxDigVNj
         WMSJJEI4YSQXkA36kT/PwmFc+KbfYrbBUZOdcXvfNgFNC7npGmcxED87Trhu5D8gSnC1
         xTcLxX25ONlDU1LnLheM/+AU8swKE3a8XmzqovSYzvtKKhyDzp9rIaLDdRlOra2Of76J
         OKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655547; x=1712260347;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YT6C4kyGaXJTnO4s5bmEmPWYlNQPKErlDo5CuGDxbV8=;
        b=GHxTWz3eZFtKTpj2JYaz9XJyvfZgYbWOcFm55wd/HQ+1ybTDC7fW8VozjpP0K4Q1v2
         dYHvMcxjFAeL8D4EgosuIUAniUGwBUlTn6u6/s40SDOxasgEYKy7ii8oW8+UWv2gIuOq
         50d4z7Uy3YYWGX3ij8SJ1ifu8YgSBaWNK5IUNnorkX7fATMRHtZ2CEDv98fpLPUcoo5+
         6++7jJBP4QaVfY02gMF9NQIYByLPJy0njLlVYaJHmVcCZ7RXYaYGmmFsBlLaN43Svby3
         c5eaKKr/6a91koJPXrgEiTY6mae3zfqckAnQd/DpGNDwK6SCHuoSgDUhX9tYX7jBEZo8
         Ctzg==
X-Forwarded-Encrypted: i=1; AJvYcCXngZi6NV1xWSwl46mmaCS/lRJprCGnNUF5tvTYqkxHzjRJ9kBHF+HEe3CgNSPvgSmLgbg9WATEEfSu4arW/HaAsKqlCA66XzeaxJpfK/kir+QVpyZluM1EgCEYqVBDe09DrFYzjyOweTdyf4EZL10KMnTUjspiVwGsduQDqgdrdcoyeU1jli+yNkOMLBA+SzR3cc5GYiV6Z63pLdt0Wfwlq+DJJU4CQOQSynFm6okMnOdr+EWdKlvPZ1kVBOxTTw39YCHs+MbYN/J/dxiuiegzLxiPd+nMDcx25djrqmPMqeiZl6jU1TsQxbS/ODJGnP5jkuIUnwQtX2IHMK7WoVQeWI+LbRFlGVnqY3+f2hsPE2wUrRJ3vqFUXDTjuC53OlZBF6/X9mXEwOOABw5g+bi/8zau3uMyicxHJSNbbW7FiSm4tAzg5pSLV+bKwpxa59zZjQdfqxKHOldoTghq5dYtBdI60KdZt9EtrV4NGrJ26PZTU5AbIf8nE8q9Bw6Gqoal9ZAGLk3A4AYLQEgG5RPckvRZjCEl4m0PJ609n0wILfgk1BcZtnMbl/woNwWBAZw8j62XbJ3uVPubsSk2j/c=
X-Gm-Message-State: AOJu0YyvXq7J/e6xvMdgvbJKc/measjiCe7T07f8gLtC4S2Yx+tgo37m
	sDKyRqpR0Ualfik/5wj3qOb2zUlx8Ve+Mtylw6bHQvfE3OfGqbk=
X-Google-Smtp-Source: AGHT+IGa6m7tWMYIWy51l607HYGlrsX0qHDQfT9gmhvhIngwQWHc2ccP79f2XqPzu8hB8uCGkbHOGQ==
X-Received: by 2002:a05:6808:1790:b0:3c3:d1a8:6d14 with SMTP id bg16-20020a056808179000b003c3d1a86d14mr306232oib.35.1711655546757;
        Thu, 28 Mar 2024 12:52:26 -0700 (PDT)
Received: from serve.minyard.net ([47.184.181.2])
        by smtp.gmail.com with ESMTPSA id 22-20020aca2816000000b003c3d6dab111sm345409oix.30.2024.03.28.12.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:52:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:b987:69e:202a:697a])
	by serve.minyard.net (Postfix) with ESMTPSA id 4B51A180059;
	Thu, 28 Mar 2024 19:52:25 +0000 (UTC)
Date: Thu, 28 Mar 2024 14:52:24 -0500
From: Corey Minyard <minyard@acm.org>
To: Allen <allen.lkml@gmail.com>
Cc: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	tj@kernel.org, keescook@chromium.org, vkoul@kernel.org,
	marcan@marcan.st, sven@svenpeter.dev, florian.fainelli@broadcom.com,
	rjui@broadcom.com, sbranden@broadcom.com, paul@crapouillou.net,
	Eugeniy.Paltsev@synopsys.com, manivannan.sadhasivam@linaro.org,
	vireshk@kernel.org, Frank.Li@nxp.com, leoyang.li@nxp.com,
	zw@zh-kernel.org, wangzhou1@hisilicon.com, haijie1@huawei.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	afaerber@suse.de, logang@deltatee.com, daniel@zonque.org,
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
	andersson@kernel.org, konrad.dybcio@linaro.org, orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
	patrice.chotard@foss.st.com, linus.walleij@linaro.org,
	wens@csie.org, jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jassisinghbrar@gmail.com, mchehab@kernel.org,
	maintainers@bluecherrydvr.com, aubin.constans@microchip.com,
	ulf.hansson@linaro.org, manuel.lauss@gmail.com,
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
	duncan.sands@free.fr, stern@rowland.harvard.edu, oneukum@suse.com,
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-mediatek@lists.infradead.org,
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 6/9] ipmi: Convert from tasklet to BH workqueue
Message-ID: <ZgXKeL36ckOyNpI/@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-7-apais@linux.microsoft.com>
 <ZgRePyo2zC4A1Fp4@mail.minyard.net>
 <CAOMdWS+1AFxEqmACiBYzPHc+q0Ut6hp15tdV50JHvfVeUNCGQw@mail.gmail.com>
 <ZgXDmx1HvujsMYAR@mail.minyard.net>
 <CAOMdWS+nB5EENp_Vb=k1j77nrch5JgbZP2XYPJ2ieTja14zB0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWS+nB5EENp_Vb=k1j77nrch5JgbZP2XYPJ2ieTja14zB0w@mail.gmail.com>

On Thu, Mar 28, 2024 at 12:41:22PM -0700, Allen wrote:
> > > > I believe that work queues items are execute single-threaded for a work
> > > > queue, so this should be good.  I need to test this, though.  It may be
> > > > that an IPMI device can have its own work queue; it may not be important
> > > > to run it in bh context.
> > >
> > >   Fair point. Could you please let me know once you have had a chance to test
> > > these changes. Meanwhile, I will work on RFC wherein IPMI will have its own
> > > workqueue.
> > >
> > >  Thanks for taking time out to review.
> >
> > After looking and thinking about it a bit, a BH context is still
> > probably the best for this.
> >
> > I have tested this patch under load and various scenarios and it seems
> > to work ok.  So:
> >
> > Tested-by: Corey Minyard <cminyard@mvista.com>
> > Acked-by: Corey Minyard <cminyard@mvista.com>
> >
> > Or I can take this into my tree.
> >
> > -corey
> 
>  Thank you very much. I think it should be okay for you to carry it into
> your tree.

Ok, it's in my for-next tree.  I fixed the directory reference, and I
changed all the comments where you changed "tasklet" to "work" to
instead say "workqueue".

-corey

> 
> - Allen
> 

