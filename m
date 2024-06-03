Return-Path: <linux-hyperv+bounces-2280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780418D827D
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE1B249D1
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jun 2024 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020F12C481;
	Mon,  3 Jun 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Hqcgmw4m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167212C473;
	Mon,  3 Jun 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418358; cv=none; b=Vk/eOovX1rtovngQD33wcFTz1tsOUENVxJq7oWHjIIkuDlOAfn+NRPefGKpXBrAbMD50P4EbdgXOKdCcxLNL7DYlxk9cqoBEgxaMajy6MT/GW7Xs68CHKfCTICBVr1+VzP5LZFXDuYgx/E4lqc9xiPrtd7U4dA/3EcNCTKfKZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418358; c=relaxed/simple;
	bh=LEM9nLCZweC6fzBGd3LiqBJyI0EVR5DWYNV+RHxhfJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rk9j9+yPewQeBwWkcfpqTv/2MUBRkd96DN9uvKLncenknwEqkwIwWeL8LvNvxyVGw8zoK+QqXBUX33BV8gf5Cbs2FbbzDo9+qlb17gWRUNQTHVawf2rIrDf61oFVDX+5MOspdqPCl2cPHh1zlYtsNrCpSRcyyZD1TBaDnCVrwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hqcgmw4m; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717418356; x=1748954356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LEM9nLCZweC6fzBGd3LiqBJyI0EVR5DWYNV+RHxhfJc=;
  b=Hqcgmw4moR5xrn3ljGdNG2NQIqkjpx77ho9zS40XDNG2X3wb34CUkuya
   X/mt32h+rUIU0pzJci/Ji1fsu/fcQxsni0pycwJPYZMybmJ9+da3Bqhe+
   QRLyxgI0JOR7uXmU/EF8JF1RKBIpsXNd0o16tFy+L44kcuJp+QW/q6oJ0
   NhAJzLZ0M4xuF5Aw+lk8aZ6MkwDPrIcWdT4qJPG61eu3enuINwaherele
   ghX+9sPDzlaZ4vZOYHUNDgiwNl+85sbGEvJA0Sk9jhg6rhrPNTEVHkd5V
   SipaiU+scw1XcuBPMYKDZUtj4XS3gEvmCQCTM12MAE38i40ax4V1plv7I
   g==;
X-CSE-ConnectionGUID: mGTV6IY0SjuqO4B8d/I3Zg==
X-CSE-MsgGUID: cs2mH/dwScqctcaN/BguNA==
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="194291692"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2024 05:39:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Jun 2024 05:38:36 -0700
Received: from [10.159.227.221] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 05:38:23 -0700
Message-ID: <7e618af0-51a7-4941-a386-0ac68c66d358@microchip.com>
Date: Mon, 3 Jun 2024 14:38:22 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] mmc: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <keescook@chromium.org>, <vkoul@kernel.org>,
	<marcan@marcan.st>, <sven@svenpeter.dev>, <florian.fainelli@broadcom.com>,
	<rjui@broadcom.com>, <sbranden@broadcom.com>, <paul@crapouillou.net>,
	<Eugeniy.Paltsev@synopsys.com>, <manivannan.sadhasivam@linaro.org>,
	<vireshk@kernel.org>, <Frank.Li@nxp.com>, <leoyang.li@nxp.com>,
	<zw@zh-kernel.org>, <wangzhou1@hisilicon.com>, <haijie1@huawei.com>,
	<shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <sean.wang@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<afaerber@suse.de>, <logang@deltatee.com>, <daniel@zonque.org>,
	<haojian.zhuang@gmail.com>, <robert.jarzmik@free.fr>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <orsonzhai@gmail.com>,
	<baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
	<patrice.chotard@foss.st.com>, <linus.walleij@linaro.org>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <peter.ujfalusi@gmail.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<jassisinghbrar@gmail.com>, <mchehab@kernel.org>,
	<maintainers@bluecherrydvr.com>, <ulf.hansson@linaro.org>,
	<manuel.lauss@gmail.com>, <mirq-linux@rere.qmqm.pl>,
	<jh80.chung@samsung.com>, <oakad@yahoo.com>,
	<hayashi.kunihiko@socionext.com>, <mhiramat@kernel.org>,
	<brucechang@via.com.tw>, <HaraldWelte@viatech.com>, <pierre@ossman.eu>,
	<duncan.sands@free.fr>, <stern@rowland.harvard.edu>, <oneukum@suse.com>,
	<openipmi-developer@lists.sourceforge.net>, <dmaengine@vger.kernel.org>,
	<asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
	<imx@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mediatek@lists.infradead.org>, <linux-actions@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-10-apais@linux.microsoft.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20240327160314.9982-10-apais@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2024 17:03, Allen Pais wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>   drivers/mmc/host/atmel-mci.c                  | 35 ++++-----
[...]

For atmel-mci, judging from a few simple tests, performance is preserved.
E.g. writing to a SD Card on the SAMA5D3-Xplained board:
time dd if=/dev/zero of=/opt/_del_me bs=4k count=64k

      Base 6.9.0 : 0.07user 5.05system 0:18.92elapsed 27%CPU
   Patched 6.9.0+: 0.12user 4.92system 0:18.76elapsed 26%CPU

However, please resolve what checkpatch is complaining about:
scripts/checkpatch.pl --strict 
PATCH-9-9-mmc-Convert-from-tasklet-to-BH-workqueue.mbox

   WARNING: please, no space before tabs
   #72: FILE: drivers/mmc/host/atmel-mci.c:367:
   +^Istruct work_struct ^Iwork;$

Same as discussions on the USB patch[1] and others in this series, I am 
also in favour of "workqueue" or similar in the comments, rather than 
just "work".

Apart from that:
Tested-by: Aubin Constans <aubin.constans@microchip.com>
Acked-by: Aubin Constans <aubin.constans@microchip.com>

Thanks.

[1]: 
https://lore.kernel.org/linux-mmc/CAOMdWSLipPfm3OZTpjZz4uF4M+E_8QAoTeMcKBXawLnkTQx6Jg@mail.gmail.com/

