Return-Path: <linux-hyperv+bounces-1936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04B89BC96
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C23B1C20B2B
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07300524D9;
	Mon,  8 Apr 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V1m9DY18"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144A84EB3D;
	Mon,  8 Apr 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570662; cv=none; b=GDwaMx5d0F2vD5YytD5yojIKNSI4sCYDBkB7rRrfLlUvaxKThN1M8hK5PpXaY1lHLRCUgton/htXO+D4TeDVO8JdYOQ4nf/oU7qWKGXYnkW5zTfpVvsKzdClp6gMeNqmeQ6uFVCTIrv/PpYrnKTe+vvY5lHw7WN5rNa7uOUXx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570662; c=relaxed/simple;
	bh=7Um93ynodoKWvmi4hudSQ6ODRbJB2kpvSRbso69Gbb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=NKjnsSbiRp4IZpjZe1msAQqMNApu96BxB5dCVMfisWNM3jfA1oZKRdgmBehRABZki2inWVx4zkNEsAycXXR8NRqZkCPqhSq7audkvpgZCo36byNGOnFGbrBFRS5oev5ka3ebc7UjI48SJVTk8FxjMLSHYj3AnS4jlacRaDOtLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V1m9DY18; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4389vTLC024196;
	Mon, 8 Apr 2024 10:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : reply-to : in-reply-to : references : message-id : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=WGRw+wpQ+8BkQKcdJ/jvqWzRkTuOQNEebcPy5PQD4Kw=;
 b=V1m9DY18uGHMz8vh9IxAKCdhy2XzRwg7vXDe5eU16f5nEfVNyFSH2bkwzlSGAU2+MppO
 4KiihhZ6Fk01FJPzdXSR1BLEuGht8lFKOYZkgyQ+XDX6d86NzlDgaIq0J9qJC+jfnfB7
 aEeGTfrHV1qJLbUVw7VwF0wJD3GQGVNebGmuEEwqhBLJ9iqNw/OPA1h1UuFrYBwI63SP
 L8QiPE5Ov/+xNvSEFsQF6+fJ779nZgk/JgjuEZ8d5Yw4SPP9YYyN9phnIKPRv8VXU/FC
 LdWtpshSMMqQ0phdyUamMRN3ZDDlZNvPvkSzaRMK+nFo6z+Im4121GSQHwYWxTP0de2t 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceda00e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:03:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 438A3KAu002830;
	Mon, 8 Apr 2024 10:03:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceda00e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:03:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4387uZ0H019096;
	Mon, 8 Apr 2024 10:03:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh3yym76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:03:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438A3FKl53084522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:03:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2E1D58058;
	Mon,  8 Apr 2024 10:03:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F35F85806B;
	Mon,  8 Apr 2024 10:03:10 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 10:03:10 +0000 (GMT)
Date: Mon, 08 Apr 2024 12:03:10 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
        vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
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
        linux-usb@vger.kernel.org, Holger Dengler <dengler@linux.ibm.com>
Subject: Re: [PATCH 7/9] s390: Convert from tasklet to BH workqueue
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20240327160314.9982-8-apais@linux.microsoft.com>
References: <20240327160314.9982-1-apais@linux.microsoft.com>
 <20240327160314.9982-8-apais@linux.microsoft.com>
Message-ID: <702594ec5852c482f96cfcf84a02cab2@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vcJ1PwKFq1RysBO3jh1OFUS_rcqMuAYv
X-Proofpoint-ORIG-GUID: X3ilzQ7TzOIWEyFQfqPrw-z8aSdSkVVd
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
 definitions=2024-04-08_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=918
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080077

On 2024-03-27 17:03, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context 
> is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH 
> workqueue
> behaves similarly to regular workqueues except that the queued work 
> items
> are executed in the BH context.
> 
> This patch converts drivers/infiniband/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git 
> for-6.10
> 
> Note: Not tested. Please test/review.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
> ...
>  drivers/s390/crypto/ap_bus.c           | 24 +++++++-------
>  drivers/s390/crypto/ap_bus.h           |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype50.c |  2 +-
>  drivers/s390/crypto/zcrypt_msgtype6.c  |  4 +--
> ...

Applied and tested the s390 AP bus and zcrypt part of the patch.
Works fine, a sniff test did not show any problems.
Thanks for your work.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

