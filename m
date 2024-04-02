Return-Path: <linux-hyperv+bounces-1899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1818953CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942CE1C209C2
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BF57A15B;
	Tue,  2 Apr 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pe5Uc6ck"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0C22079;
	Tue,  2 Apr 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062183; cv=none; b=Z7iFFpmAo34fGrPUzj8GB3P7ci2CyzkCbJL+4QJvKPjL75jt35B3D9XjBCTi9vIpw6LBlCy720zbEjh0XbG3BXYikPH4MmxSxwu9eKZ3bTmlmjZrTyry/1K5p/NlwuiUkpr5FKWW4IRf6UXnhrfabyFgvHC5ih3sTeVAeZ5+CRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062183; c=relaxed/simple;
	bh=AfVaTNGQeOUO+KCvOtgnYBzWx3gO68HaZOShlsAKjYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDXvv4spv4w1zJhwmYLp2AAH7pTjE0J5VKYE+9/trElQUFqN5UYkJMdtmJBTAgwwl5wUc5uaTtyqV29IaPDU+mVfVPy+2WbhbnTjohIiDXcgTIumNTnblIJCHvaJCThDyCMbUu/rzzj7MomH3MhfreuZLNUsPEGQUKM9JuRhTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pe5Uc6ck; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432CTJno003298;
	Tue, 2 Apr 2024 12:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cqNk795UztyaS7ZOTqsgy3G6Bzl6LkH6VxOUkSRZDWE=;
 b=pe5Uc6ckRQGoPKRDNGIuCZjvW9CCS78ZFZ5tCAUFKWtooQXGOnFCZ2arOYqT0xeUfP9s
 i4nIUcoggh26pYRIFcstX8a6Q/BDARG/hcAEayONrnB5YNXSAm/JIoNr5SJfcycY16CA
 e9zGUDQN1y8Kyrq8qI+b4dRBsPxOkEEkqpZIwwWRhh8fTIRQZaCqfPV0r8cUA0cmrVx7
 rChB99m0wi/ueQInDYrziML0F+2pBTAHeMDVoXJTZu0mGDrkh2dmIPEKpmb8G6OlEe99
 AzzIa6xN8mX9IAf+/t7s2yww2L54PyTzeX3pEIxkFGiL2TMXRHzkwqUYgFPO+MipSvOa nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8hvx82nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:48:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432CmLxL001953;
	Tue, 2 Apr 2024 12:48:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8hvx82n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:48:21 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4329nZeD008463;
	Tue, 2 Apr 2024 12:48:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2txsc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:48:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432CmG0h28967614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 12:48:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E5A2004D;
	Tue,  2 Apr 2024 12:48:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5982520040;
	Tue,  2 Apr 2024 12:48:14 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 12:48:14 +0000 (GMT)
Message-ID: <ea4ac7a3-13ae-4d22-a3d9-fcb7d9e8d751@linux.ibm.com>
Date: Tue, 2 Apr 2024 14:48:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] s390: Convert from tasklet to BH workqueue
Content-Language: en-US
To: Allen Pais <apais@linux.microsoft.com>, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, keescook@chromium.org, vkoul@kernel.org, marcan@marcan.st,
        sven@svenpeter.dev, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, paul@crapouillou.net,
        Eugeniy.Paltsev@synopsys.com, manivannan.sadhasivam@linaro.org,
        vireshk@kernel.org, Frank.Li@nxp.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, haijie1@huawei.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        afaerber@suse.de, logang@deltatee.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, andersson@kernel.org,
        konrad.dybcio@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org, wens@csie.org,
        jernej.skrabec@gmail.com, peter.ujfalusi@gmail.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jassisinghbrar@gmail.com, mchehab@kernel.org,
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
        linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-8-apais@linux.microsoft.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240327160314.9982-8-apais@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ku4a1547K_GAebsL_C6x0-P2EehptrTF
X-Proofpoint-GUID: nppBqWZFDQLnaADD-aCs4ILGDo6MGGqc
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020094



On 27.03.24 17:03, Allen Pais wrote:
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
> Note: Not tested. Please test/review.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/s390/block/dasd.c              | 42 ++++++++++++------------
>  drivers/s390/block/dasd_int.h          | 10 +++---
>  drivers/s390/char/con3270.c            | 27 ++++++++--------
>  drivers/s390/crypto/ap_bus.c           | 24 +++++++-------
>  drivers/s390/crypto/ap_bus.h           |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype50.c |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype6.c  |  4 +--
>  drivers/s390/net/ctcm_fsms.c           |  4 +--
>  drivers/s390/net/ctcm_main.c           | 15 ++++-----
>  drivers/s390/net/ctcm_main.h           |  5 +--
>  drivers/s390/net/ctcm_mpc.c            | 12 +++----
>  drivers/s390/net/ctcm_mpc.h            |  7 ++--
>  drivers/s390/net/lcs.c                 | 26 +++++++--------
>  drivers/s390/net/lcs.h                 |  2 +-
>  drivers/s390/net/qeth_core_main.c      |  2 +-
>  drivers/s390/scsi/zfcp_qdio.c          | 45 +++++++++++++-------------
>  drivers/s390/scsi/zfcp_qdio.h          |  9 +++---
>  17 files changed, 117 insertions(+), 121 deletions(-)
> 


We're looking into the best way to test this. 

For drivers/s390/net/ctcm* and drivers/s390/net/lcs*:
Acked-by: Alexandra Winter <wintera@linux.ibm.com>


[...]
> diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> index a0cce6872075..10ea95abc753 100644
> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -2911,7 +2911,7 @@ static int qeth_init_input_buffer(struct qeth_card *card,
>  	}
>  
>  	/*
> -	 * since the buffer is accessed only from the input_tasklet
> +	 * since the buffer is accessed only from the input_work
>  	 * there shouldn't be a need to synchronize; also, since we use
>  	 * the QETH_IN_BUF_REQUEUE_THRESHOLD we should never run  out off
>  	 * buffers

I propose to delete the whole comment block. There have been many changes and 
I don't think it is helpful for the current qeth driver.


