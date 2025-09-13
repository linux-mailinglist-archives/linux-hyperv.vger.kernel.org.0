Return-Path: <linux-hyperv+bounces-6858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E199B562BE
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 21:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED40561B3D
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6A24501B;
	Sat, 13 Sep 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EpS0Ndn4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FE237707;
	Sat, 13 Sep 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791507; cv=none; b=RVfLavAA5ZisCpT41VUrDUfpEoSWx6C39KDaRd13ujs01cEFqN3lxoUS4uLB0+JlO1wWVLS1LvR7Qx3QR7uEyVCWBF/rJwUh2kP9wDhcol02S5K15METiGNVVbbKJwMGpGCl8FByVAxhRY/OKLa8JQlHJBa2SX46Hwe4eN6WSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791507; c=relaxed/simple;
	bh=GmyT4KEuyG5HUvouYFjgR3lN6INeTeGQ8o7tBo8xkKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKjxa2aGrkp25YMeetQXGCpCbr0gEyfloLOCmm48fT3VuJJE4mF8bocIMc/TOCPdvt2Un/DT5XPj45fBZ+TvAOkbz/LZhG07W4exokAaIWTCbKFKFDnabiqGM1IKqq+uJZD1H5QaPaZ7UHB8maA0rAGsD80CrIcQMV3DaH+Ahyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EpS0Ndn4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DIhoZS029712;
	Sat, 13 Sep 2025 19:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=I7vFW
	x6QoDICcMW7eI6EkF19tCzi1t6IlZ+zm24p+/0=; b=EpS0Ndn4iGPXtyGGNpuVs
	CBHIaOROoMLq5OOWJysNHk8fFEHfcZ7Qwv6J8Du7wIaFVp4gL6wGqvjudu1URR/6
	FIEAgYvenVbXcWrUfj9kuFWTlitzGs0tYVFRwu6Rvu8hkcWolltTyimK+iwbGKyv
	e9WXAi2Kbb0qMLMczIAeME8iBQt+By30ldgyuDMwFX2r2IXOOFW10w0AhIQoggNb
	neTeD2iBIIcECHxmqkdlqzCjj6qHIvdNnz/X7rswBYovSdmVdbWdXTuFXhsutVj+
	H6dQTexgsSTVmR7NqEnPNynBZpcRuv96jwubKlHczhz3uV9jcAagVlshkJ+h9nKZ
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72rfvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58DIuq6d015522;
	Sat, 13 Sep 2025 19:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y29q1pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58DJOrfV027951;
	Sat, 13 Sep 2025 19:24:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y29q1pe-3;
	Sat, 13 Sep 2025 19:24:55 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drivers: hv: vmbus: Fix typos in vmbus_drv.c
Date: Sat, 13 Sep 2025 12:24:44 -0700
Message-ID: <20250913192450.4134957-3-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-13_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509130186
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c5c509 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=uT7C1XsjW1afKEansNwA:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: 0EEWmENh14iAbAaH_UZDTO-VzuhA8YBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfXxKJ4VS9DMKlD
 9YOJFBxRJUsBd1e9ajS4Zaa897TlIS3tq+awoHBitc6A3fAdkLKsPq/69xRQTmwCzSiDA1RGoAM
 aLvD56w9MaksyqmsqNjMaaicfq/ThXVjFv18/t5d3ZoD8HVXrs2lUVkV9/WUDcCEzF86HJtu8Aq
 j3uvZIH6lBcr54lH4h3D3YET/JFB3hXAl+BdggqMiYCiZxj0AQzqPbwd1UM70g3pmZDonhoeLzp
 Ls0lsir58fGae3EIoH0MaRGyZoxji2jwATnwpQ98czT2fO3BXwuB9CNaSEWQIPreZ4UL7KW7YqH
 /zXrxm5qlVXJ5T/mOwhhSgUpiNciBdEDj0nv/pMr3m2A3N4bjw+UepMOiB8jIhKpd79W+d1Ra4J
 BxoT3VaZe3bOZ0iHJqWC3Bc4y+f4vQ==
X-Proofpoint-GUID: 0EEWmENh14iAbAaH_UZDTO-VzuhA8YBt

Fix two minor typos in vmbus_drv.c:
- Correct "reponsible" -> "responsible" in a comment.
- Add missing newline in pr_err() message ("channeln" -> "channel\n").

These are cosmetic changes only and do not affect functionality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fbab9f2d7fa6..69591dc7bad2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1947,7 +1947,7 @@ static const struct kobj_type vmbus_chan_ktype = {
  * is running.
  * For example, HV_NIC device is used either by uio_hv_generic or hv_netvsc at any given point of
  * time, and "ring" sysfs is needed only when uio_hv_generic is bound to that device. To avoid
- * exposing the ring buffer by default, this function is reponsible to enable visibility of
+ * exposing the ring buffer by default, this function is responsible to enable visibility of
  * ring for userspace to use.
  * Note: Race conditions can happen with userspace and it is not encouraged to create new
  * use-cases for this. This was added to maintain backward compatibility, while solving
@@ -2110,7 +2110,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = vmbus_add_channel_kobj(child_device_obj,
 				     child_device_obj->channel);
 	if (ret) {
-		pr_err("Unable to register primary channeln");
+		pr_err("Unable to register primary channel\n");
 		goto err_kset_unregister;
 	}
 	hv_debug_add_dev_dir(child_device_obj);
-- 
2.50.1


