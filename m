Return-Path: <linux-hyperv+bounces-1854-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9B88EF48
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F3B29C0C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE41414C5A8;
	Wed, 27 Mar 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoaXAMOJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C47D380;
	Wed, 27 Mar 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568162; cv=none; b=IqaR9I7OSVj2cn5pb2amOwEtxcvVrBX0EAMfJwD3p6Ob27Zzb/SuI1Su3Y6wltd4qJ1yDWFc4Ng818HcZ+H4ri68r0fA9/VLXzsqR2OPt/3WA8/xsqJ11/k82+d51DDgjZrzRot0tVOyCL0OWGdktpraTBXuaQ+f+Jh+QK+o/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568162; c=relaxed/simple;
	bh=T0Gc63+M14jsX7PKFtiIXFMl0tWSi9oDRmgoUZTW/2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvWLzCHlXrCLVHGZq9tEGrVrmqm7KSNrNZfM/VNeF3qr9oqwDMT0waNjexrtBYb6MyvcNR0aKcPavrM9Qx1+KwvLDE+6XbMRo3wdksFd9xC7errlqfut1uYd0vGohu9fJUvwGRXMbKgpwpdS/w4jSdfFLTpMMjUYEKK1dPlfb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoaXAMOJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a393b699fso38648266b.0;
        Wed, 27 Mar 2024 12:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711568159; x=1712172959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aojaArSnA0JfedDto4elyer8YODIKcUTNNFpLzMMgW8=;
        b=XoaXAMOJ4Ojmd7idhXiyfKsYBXO1nlVNNBH2lrYeTP5tUZYgJcfSMkvYDdSECwJe3O
         2WPWBYmKXHC3NZWnWbzWbnrHUyovIC/aoenU0HNzQCX/wvlCFvq+1zEn21HC3sezb8Jz
         SPURbZsQS6fgh2YVN3sqFKrAbjZhNNG29y5z+ZwHL1BZB0eyGa0r1WlwajFoU7kWaoqZ
         185ZvXwubU7cpqnWYSzx0ODOXGVS3Mu2DrliJPjTMaV7TwMtsw25xfnbYF5dA8TRfuQ7
         d8HeMsqPzustoXEui2Uc+vAQDibV6fBvr6di3ODvecj0COgUZeNJQykOCy7aPcLPeDfo
         WMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568159; x=1712172959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aojaArSnA0JfedDto4elyer8YODIKcUTNNFpLzMMgW8=;
        b=n8H1GZxWGCDyZS5GqC4sE0iRZ6/9XuV3nlKHKJkja+AZPJKXTt3r1bhBFrxuwpoXLP
         /AuIC8w+HXy958J1FQf+Iy8P//jBuByUSsJs7ZDJyzOxYeJqyARMljJnc3A2G5ovAQVV
         yMucFt5nfs8w5c0R/CmBVsN29G8RYl0rdhnkTA4x68Pr6Tc+sVfTGJwKvGsADzkk0z7r
         ZuacuYt2GO1+otB+99QWCJ431XrYBpUJo2gJUJx+m70N4HppIHuJ0tJcAoyw1Os/6lNk
         A7IPnFSrw34Qoq2FEpCdpDNEt2tlRguwX14hgVUljq3KsTPBv+nxZOfx3wZjSjKQheEp
         eLAw==
X-Forwarded-Encrypted: i=1; AJvYcCVCYs+LogtakcWjQysrzX6wzvIepjw4NCiF8HoEvdnW+fcNZb6q0ncljdi6I5FBFilRdUn5iZ+bKJKGewBdPfMSzBsWPfsv/XqgvyGupEJypYlJ8aUH+Smswfxo10UetclKXgE97Rq//Icad6T7MUFCuayMEwItobDtws+wo/edI1IwriKnb8wNXfmtCeGm1MhBk9yD4Nb6NeeIE2CJi3siS9XkvdLH2QMXSc9ZKCTqjMnArQ2s2S+y+7efnQKwKB7Sh+JQHr9Oali08QD7nkd9+mTNPPesNdBoy5hJdtpUyesJaRFG3rX27s82zYLOQka3WSwt0L3bww8acX1hFWejjOxv/XPiYIHXlO7Qp7cSCgMumKXmmGj/BBqgbPv+hmcJCoJzk0Vg6rREXD4G2sYYooVDZTkzg1NL6i8W/n3poH6AkiaMGuZvsFSjyjfoKCe5k+uOpdSspnFHnd38kzfXebGQ3IHl5+lOODTNJYDDZ5sfGo533LxVP86Tb/wgi5OoYubNq8S7haZuCCbHvffDGirQVz9dYy5SXNsE+g1zIzM=
X-Gm-Message-State: AOJu0Yyipuc5TsIErMTNm9jkKX/fFMTmqPVE3UYPTd1po8U8p1sC9R2o
	ZrFIl5QEdHBNhCaYvqj2qCmN3xq+VhVckML3IqGQ17mgDI+OKPapdtBwuK+1qU0=
X-Google-Smtp-Source: AGHT+IHWYCsKCZfCKe9WJ0A8h2jBWKCzprPvh9Stt4hH84aJN1DmeskwZihR1IueuTRTWs9wYxpP6Q==
X-Received: by 2002:a17:906:119a:b0:a47:3766:cfec with SMTP id n26-20020a170906119a00b00a473766cfecmr235001eja.9.1711568159337;
        Wed, 27 Mar 2024 12:35:59 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090643d800b00a4672fb2a03sm5858783ejn.10.2024.03.27.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:35:58 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>
Cc: tj@kernel.org, keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st,
 sven@svenpeter.dev, florian.fainelli@broadcom.com, rjui@broadcom.com,
 sbranden@broadcom.com, paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
 manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com,
 leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com,
 haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, afaerber@suse.de,
 logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org,
 orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
 patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org,
 peter.ujfalusi@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, jassisinghbrar@gmail.com,
 mchehab@kernel.org, maintainers@bluecherrydvr.com,
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
Subject: Re: [PATCH 9/9] mmc: Convert from tasklet to BH workqueue
Date: Wed, 27 Mar 2024 20:35:54 +0100
Message-ID: <9252961.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20240327160314.9982-10-apais@linux.microsoft.com>
References:
 <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-10-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne sreda, 27. marec 2024 ob 17:03:14 CET je Allen Pais napisal(a):
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.

infiniband -> mmc

Best regards,
Jernej

> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>




