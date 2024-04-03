Return-Path: <linux-hyperv+bounces-1912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2623897574
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4CA1F274AE
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F014A62A;
	Wed,  3 Apr 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0GskreP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CB1B7F4;
	Wed,  3 Apr 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162654; cv=none; b=CDHlBXcmPRoxxJMZbyn5VkACDhQ9TUWXXR1fqJmAvuYqfAOrxh+6nWk9q0LkSvUDORa7/ntY57CeNM79DLrbFQTcOHCTE2ELiaQeWLf8yxujw+Gv4zKEcD503q8LZPHmFh9acDj/+Wtn9gPYKd8w9hVBMvubd0dUYwNAfYW6GzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162654; c=relaxed/simple;
	bh=M1neYOlhzngATdBbVyJaKe7fkRAK//9DrStR8GOcQu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZT2XFqARwF4Z+85DrgQGT9BNu/Qrhxwgl8kP7Kvm8wgPlOlU/6YaxP4O4hledGA1mkNbcaArPbCmwBNh874p01oMZ7M+zmfhwIFzX9WxPwNE6IJi2Zzcv3q9EeX9nmUg35ytnMDbJMJvOYA0YtYAitbeCsfo+gmgvjcjnhaH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0GskreP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4da6995e58bso3887e0c.1;
        Wed, 03 Apr 2024 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712162651; x=1712767451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aej6QFoETxeFvbQm8/sOYYAdEcWAnghw/7Ynm8n0ucQ=;
        b=i0GskreP3bhVFE7L+jTrP55NTeLGEOiadN1sTEIYfQZF05ZqD7aFwgcHEWZzggB27p
         Iu9pSvcSJvv9ctMRtptjRYbadJq2t5PSTI2cbljCYV4c1eP3C39UqNHbXsHjXVWPgRF4
         cUNtQf66y29Ij0Ux473Ma14olhaOmCPIXPj2UkCmSyIiiLfd/Et1NmcTyn3tZ2/5CroR
         JGJgD9ELhuJW4HPsYoaybFcG5Or8NO7kPPs+wVFcewF/98zylX3MkbB9YRRmtZLed4a1
         /rF+ytNHfDippVqXcj/p/3MB6p+36Kb2Su2g3ayZiSDGs4JicOJMXB6apxu1GA4my1On
         wA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162651; x=1712767451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aej6QFoETxeFvbQm8/sOYYAdEcWAnghw/7Ynm8n0ucQ=;
        b=e8yBpGhE0mKo3L6OmYGnR55qeIfLG1anmLG/C9J7ZN+3APLmsWh6CvVnaVCYsjCiAq
         hrNtZxk5KKZnV09ovVAOzQxwB01QW0NNKc7ScDXWNxQ0zT+i61WPf/HwALGzRKQ/BiSX
         2r2pgmwbGI+J8jma1PQLhQpFVG8uK0yJELN2QNQ/ZEPXA5GxeVSzqk/IdcBm3yahGwRn
         oed2hqf8dr7V23Fc6MYt4JHlKRTXO29I5BVGoVp8dN9jWEDGfcCwZ82JN9BHBfYpLw+e
         /dx+zr5qFizvfFylmLkqTFSlx5t4y2pg5rZFtWvn0zdGhdzMxA2/t5cd0Hlv5PzNvCJT
         s8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpasyVqxm4S9hgcbs8dUy8q6r+F+STTWmT6MCdat3oYYGFf+6rfr/8BT6yKy29uM1AbAIolt6SJh3lZYGu+DdYx9rzuUZiacHksRrNK21d6PVKAmcA2bpy1ts6Yz9bGXjhHCps2uWJIbPr/dVtNNfyydVyE+K1ucGwYnGAjdY8ancrFK+L0hNax/c1XJjskEYv0wHpLr3QYcYae0jP0AbcIV7ty92/ff7x1UVKg/DHrQ4m6vd6MPfODU9MtPOA44TG4uH72P9SYMTl8iJ2Ymh/B+II5LqiE8dVCoxE0cInMo7xr933GhgCTU9KJIPBF0gQ+pJTOetPWCfC4PSf48Ob4/F3T0jmLDQrzHEiBXzlQ9uOWnlsVOsi4UII2DcFQsmqCVxhtgxyxlHQxh8eD2L7lMlo4zNFCgiUX02hHGzwheLA4FNBh6P5J9lVZbQvfyrD8swvpZGH79BZRxgEksXawYvBHZWkIm5bDVqAJDXTaUbQfuH7mx3HADTE5vaD85KO48aJ4TNlbvfSjEfa2sFySReyB4JFNhSFbk7HS6ecFe8=
X-Gm-Message-State: AOJu0YwxuG7mpFcprqH+unaPXUWhDi4M8kWHnrmwwEENz8OeMEG3DaYw
	/CXUPwT+I6xRjhFEM44yzLJqF6NH9qPNdRXdt6gxeHK+bYkky7/7uoKKDbs7asmf72EjxBTb0AM
	t1tSGUHKch652xWodKB7wWjUMX4s=
X-Google-Smtp-Source: AGHT+IFEFFEcpcdQfCxRWJYlDuuUETZ0sWBciDlGUMCvLnJmEBIY1oP87nAaJSL5QQDatxb4oTnFcly4MrzzQ8OrF5o=
X-Received: by 2002:a05:6122:499a:b0:4d3:b326:5ae8 with SMTP id
 ex26-20020a056122499a00b004d3b3265ae8mr10815788vkb.14.1712162651582; Wed, 03
 Apr 2024 09:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com> <20240327160314.9982-2-apais@linux.microsoft.com>
In-Reply-To: <20240327160314.9982-2-apais@linux.microsoft.com>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 3 Apr 2024 09:43:57 -0700
Message-ID: <CAOMdWSLavg27YZgnfE2QHjO=4RNmFx_7veAURaPG_=qWX=KMVA@mail.gmail.com>
Subject: Re: [PATCH 1/9] hyperv: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org, 
	vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev, 
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

> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts drivers/hv/* from tasklet to BH workqueue.
>
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/hv/channel.c      |  8 ++++----
>  drivers/hv/channel_mgmt.c |  5 ++---
>  drivers/hv/connection.c   |  9 +++++----
>  drivers/hv/hv.c           |  3 +--
>  drivers/hv/hv_balloon.c   |  4 ++--
>  drivers/hv/hv_fcopy.c     |  8 ++++----
>  drivers/hv/hv_kvp.c       |  8 ++++----
>  drivers/hv/hv_snapshot.c  |  8 ++++----
>  drivers/hv/hyperv_vmbus.h |  9 +++++----
>  drivers/hv/vmbus_drv.c    | 19 ++++++++++---------
>  include/linux/hyperv.h    |  2 +-
>  11 files changed, 42 insertions(+), 41 deletions(-)

Wei,

 I need to send out a v2 as I did not include the second patch that
updates drivers/pci/controller/pci-hyperv.c

Thanks.

