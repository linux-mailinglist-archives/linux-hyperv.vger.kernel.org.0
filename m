Return-Path: <linux-hyperv+bounces-1849-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0F88EB02
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC728F2A2
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37212E1F1;
	Wed, 27 Mar 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vSMCQaVH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACBE83A0B;
	Wed, 27 Mar 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556549; cv=none; b=sxcwfFNWRtw+5ePIjGoTIYPF7/Jzh8s/pJa8oVl153xykUYcCoYQpF7MzU5te9YlHsDWN6OmyjCvpuoYF5pBrQ4Mn61ZFAwmrlk6kxd/L+xqH2z4Ua04Dd0cGlFqdTD4a4BsFaS9tF0mnKlQfTfeBtc/onoRSLPVe1cjKIL6Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556549; c=relaxed/simple;
	bh=g9NIYWY7Zqq4Jpe3GVuphoABvUpR98WMNlTO/PqC+cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0+VZwtK9f5Ae2J1rFarexkkZwPR1vpW8002AGfSHYDd7Xed82yj7jzhz/Di+7pHWcGWPlzlI0pbIJfaG5z4y99fRqwAKYIIplpNsaNRvbmAVUo+tiNcdRLsCwvT2nLS/09pfrz9RnXVM88O83NjtRigXMMuIhNyQT+QRzHhPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vSMCQaVH; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 75DD44C8DC;
	Wed, 27 Mar 2024 17:22:16 +0100 (CET)
Received: from [IPV6:2a01:e0a:255:1000:f49a:79c4:c3c6:eaf3] (unknown [IPv6:2a01:e0a:255:1000:f49a:79c4:c3c6:eaf3])
	(Authenticated sender: duncan.sands@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id A3A9F60142;
	Wed, 27 Mar 2024 17:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711556526;
	bh=g9NIYWY7Zqq4Jpe3GVuphoABvUpR98WMNlTO/PqC+cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vSMCQaVHDvOS+MJTVx5PjO8YOXxmIEoXqqAuvBYuRC535uirpZWCAg3Zcduu9rDtt
	 KXKCxUyreW9ES5/mQaKWuQmfTpoSpYf8IwCcPc988GMFZvS+1wbAKCcOjbSk3mXiD9
	 ZK8Hamum4SVmsMBE1c9pxQwBG+dsyo12O4SxF8j/IiVpKDUrPYQJdtKDuV/HWRo3xL
	 PYIWjDHKv6Iwt5jWnepwy1J7Y+fjiF4JTHXVaKfZ4ukUUftUNKj+3Aem3Jcxh8PUFu
	 tZQKCHeE4q+71+QXSA4TwBR2eiNJVHnD/WyXCPKNPqsgcwl7VuDNvLoWg/63fz6oE5
	 pvkLMrw2O9NMA==
Message-ID: <7297be25-a3c8-4e8b-9a80-ff720ccddc90@free.fr>
Date: Wed, 27 Mar 2024 17:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] USB: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org
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
 jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jassisinghbrar@gmail.com, mchehab@kernel.org, maintainers@bluecherrydvr.com,
 aubin.constans@microchip.com, ulf.hansson@linaro.org,
 manuel.lauss@gmail.com, mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com,
 oakad@yahoo.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
 brucechang@via.com.tw, HaraldWelte@viatech.com, pierre@ossman.eu,
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
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-5-apais@linux.microsoft.com>
Content-Language: en-GB
From: Duncan Sands <duncan.sands@free.fr>
In-Reply-To: <20240327160314.9982-5-apais@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Allen, the usbatm bits look very reasonable to me.  Unfortunately I don't 
have the hardware to test any more.  Still, for what it's worth:

Signed-off-by: Duncan Sands <duncan.sands@free.fr>

