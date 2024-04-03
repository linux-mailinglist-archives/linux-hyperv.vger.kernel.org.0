Return-Path: <linux-hyperv+bounces-1911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE0D897134
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D5728AA63
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Apr 2024 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA0149C53;
	Wed,  3 Apr 2024 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFrcg6if"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8381149C41;
	Wed,  3 Apr 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151217; cv=none; b=r+iHO/4bXut4mVh9wfFKchJ3c6drs51yPxw/QW8QcDmt4QHQNVl0snSpqXj0shSIpzpFRjrZUDoGDdniTMUHbm7zONLRcoc/HeqByGXGKNHSylgdDYTsJWvULMCEi2HVio9NWY5e1UWNlGRmH9DKOEvGxOXQHlGmfxBiwzajXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151217; c=relaxed/simple;
	bh=Qt01KTjE4NGp5XEomZDf90wNSv9JiA1QkpnnyKlsblA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okKQmTJA9V2ou0EcVoPoGoTC20G11Agi2nqNNyDKJ8tTQsnOgKG1LMu1M6Xp6s6oTCGiH7vWSNo1cnufA0hlIGZ+YQcTZL/kg9g5hNJPlhyC1SR+SFZ+Y511y76nUsxaJpHGGVbnU1089qET6rNFvGOndKggCL/MavE3P+l0aEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFrcg6if; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e9e1a52b74so109541a34.0;
        Wed, 03 Apr 2024 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712151215; x=1712756015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfJ432sdibD0Lka67Qj4+39whrzSunQCkb9XAcwEVWQ=;
        b=GFrcg6ifPUmcvvrEYoC2e/fgnq3m6ynUXwoJW1avVY6MvV8MtWIreHzW8sGg+/Dgtb
         +z1o1duNbklzWnVoJk6bAsd1lGlStxJqDkSJbsTd303lw/NCevYRZRs2auW6JrY6UC8l
         Ykbe4uMJU6fRE5F7cS0aXAJMgQ7wf9U8FtznXnnQ0nJtQPNBguh7WC170paMLQNtV9Pc
         76sO8TjKSQUENsdMu745TLGpx8ahkqAhaVQhC/AYElH6GpweItCj4bbWGDMuoQa3TyU2
         oKXzfmQWcPrq/jeH/dvjNeNqnYRKHJbifBAzNRSK1DswOtLRgw09DdW/6BSoPyRPUi/e
         U6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151215; x=1712756015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfJ432sdibD0Lka67Qj4+39whrzSunQCkb9XAcwEVWQ=;
        b=kO4xowc508/21GLenfR1n/ijywgGMDAoh34C7NC1/x8VvWeNw065QYnd5fiurnaspW
         eP4mgmCJKUQ3S4Owsk2c6+3TPRoDcArZ9+2QlBZ94hqGF6a23oIv/0P7Of4McasxMh1O
         1JOqLhxSPvM0RFgVQlBnw3eXy7eD5VYtKyVq3pHtt6doD2Klq1nLzK/yKmpfvw7hZEVl
         6lvra/RXlBHacJpIpDkPDvkJNA/1lYZaMOxUJsWq5NhVjnS0TCqPOEYP+4FMnUQCpzIz
         IBH/1UoIjTqgsKwP5m7E+nLlll7vh3gwEPjh4NBFVXtGI8Zbdoqj46H2Ly3lt7McwVPi
         MPXw==
X-Forwarded-Encrypted: i=1; AJvYcCWq/y2WuoLVfYku4/gGat76A4J4eCMNbwKOlTmpU+P1/U1wqGBPETnqCoMmtHfU7Y1jbk6SgAJsYXltYmlW8qYSJ5Bwi1TJCi/KOXG1LWji7veSWe6T8dokathTeNxjpSj3I36+aVLIPHMihgXkW5tuytoS0LCWNIczqMVfvcf3f8vsElQ7OBOlcQnfjyXVN7wuI++P0+DHwmCtSaOR4yrdZUiO4kIpoZ9ciIm0nrjZFWNRG/QhkUzgT5WcyTKHLPAgNcCiaM3PUm027V6fR+8wzw5xK1UDyv8ren/ktAqJBzQUgt6vcUSOzDuBX4XfrkyMp61Do8ofQaOsxVu9JLuhska0UShrxjtA4mtYcm1LazrqHr9Az1MjNmi8iIkib8CwVxTcDPUP9tXJwqu+O5VPhGK3a9nfLoxLTOc8qTDXo8sEz6X/+BR5bOKyZFFbuSK8Qo2ggiB/znPLEEX01EphopPbUGd9dH1mepavTKYaXW5nPXOCucF8G1cuD9m7fiqSXxDeQbb/Sn8UTyHPRWMaBIyAjpDy9KES9YUo98VBZ9QMne8WwdI4gBa5N8Tk+AsBW7zDX+O2oiApbXR9C80=
X-Gm-Message-State: AOJu0YyAg0bfQn4eSM/nDFsw20mm33qDbjC45uaTrGRfKXWv8pY3m5+G
	EQFxVkgoAqVTKbiUNFolH2xe5/RQXnXrKlXBCOxXySJ1HRR3QpNzUBLQ3H3QyxKMb4x/IhzW4j3
	O27XhK+X9guVH61TyCqFhu+ik8dg=
X-Google-Smtp-Source: AGHT+IFsoYFg4TPJZ/xBylk5B9Nfa55HU119ldFLC4g550cJsZKKSI+Id/ONzGwerMZ8W2tZHWzr/Kf097BxBvAdyL0=
X-Received: by 2002:a05:6808:181d:b0:3c5:d426:9b87 with SMTP id
 bh29-20020a056808181d00b003c5d4269b87mr1074785oib.23.1712151214780; Wed, 03
 Apr 2024 06:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-8-apais@linux.microsoft.com> <ea4ac7a3-13ae-4d22-a3d9-fcb7d9e8d751@linux.ibm.com>
In-Reply-To: <ea4ac7a3-13ae-4d22-a3d9-fcb7d9e8d751@linux.ibm.com>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 3 Apr 2024 06:33:23 -0700
Message-ID: <CAOMdWS+wH9qZ_08nVSQV1sY0C=uHMC+3NmPuFjwKzBFCgMa7MQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] s390: Convert from tasklet to BH workqueue
To: Alexandra Winter <wintera@linux.ibm.com>
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

> >
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> > ---
> >  drivers/s390/block/dasd.c              | 42 ++++++++++++------------
> >  drivers/s390/block/dasd_int.h          | 10 +++---
> >  drivers/s390/char/con3270.c            | 27 ++++++++--------
> >  drivers/s390/crypto/ap_bus.c           | 24 +++++++-------
> >  drivers/s390/crypto/ap_bus.h           |  2 +-
> >  drivers/s390/crypto/zcrypt_msgtype50.c |  2 +-
> >  drivers/s390/crypto/zcrypt_msgtype6.c  |  4 +--
> >  drivers/s390/net/ctcm_fsms.c           |  4 +--
> >  drivers/s390/net/ctcm_main.c           | 15 ++++-----
> >  drivers/s390/net/ctcm_main.h           |  5 +--
> >  drivers/s390/net/ctcm_mpc.c            | 12 +++----
> >  drivers/s390/net/ctcm_mpc.h            |  7 ++--
> >  drivers/s390/net/lcs.c                 | 26 +++++++--------
> >  drivers/s390/net/lcs.h                 |  2 +-
> >  drivers/s390/net/qeth_core_main.c      |  2 +-
> >  drivers/s390/scsi/zfcp_qdio.c          | 45 +++++++++++++-------------
> >  drivers/s390/scsi/zfcp_qdio.h          |  9 +++---
> >  17 files changed, 117 insertions(+), 121 deletions(-)
> >
>
>
> We're looking into the best way to test this.
>
> For drivers/s390/net/ctcm* and drivers/s390/net/lcs*:
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>

 Thank you very much.

>
>
> [...]
> > diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> > index a0cce6872075..10ea95abc753 100644
> > --- a/drivers/s390/net/qeth_core_main.c
> > +++ b/drivers/s390/net/qeth_core_main.c
> > @@ -2911,7 +2911,7 @@ static int qeth_init_input_buffer(struct qeth_card *card,
> >       }
> >
> >       /*
> > -      * since the buffer is accessed only from the input_tasklet
> > +      * since the buffer is accessed only from the input_work
> >        * there shouldn't be a need to synchronize; also, since we use
> >        * the QETH_IN_BUF_REQUEUE_THRESHOLD we should never run  out off
> >        * buffers
>
> I propose to delete the whole comment block. There have been many changes and
> I don't think it is helpful for the current qeth driver.


 Sure, I will have it fixed in v2.

- Allen

