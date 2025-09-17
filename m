Return-Path: <linux-hyperv+bounces-6908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6929B7DE4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84E0326832
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7A3148CF;
	Wed, 17 Sep 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kHNElPPR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418D314B66;
	Wed, 17 Sep 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099585; cv=none; b=MA63Cb/VQO69HdmouQqZR/ehGlHp5aT3f5Cl/DCjAv0MKqp3iRDk/956gdWRKIY0F+Gqkz3ij0vjSsfElCGliXG8F0ZdnDpCHwSFNRdloKTT3vxJAV+sBux8f2l31921nL6xS3SmrYEXtgBi+wvkuc8ELOXqOg0EHfFxGsq12Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099585; c=relaxed/simple;
	bh=GaAXfcTh843LsuGrj+gpha5YWJVQdszk4nBFNnuIcVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2gI0GFA+aI0hTRmOStL/qKh+KO0wbUFkm4Q4FDfGyUjZhJtGh3bjxQuQLtZOsCe2HfKsdwBFbepdD0g8PMf299UqFFMP4bW6FGx18BrOP2Ea+jzuHLZTnLVJuWaUyGfbTBdYwmSTigN67JXOPlWcqAlZOBIjBfCaXmGvoGoF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kHNElPPR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H7tuWL007715;
	Wed, 17 Sep 2025 08:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=UOc5Wc7rd0WEOuTac1iTQtUAvLIUR
	A01alqCUgytTrw=; b=kHNElPPRGougfzHsT9R9ea7JT0hGzO2LBML8gOYDQMpax
	MMf745tnQmbv10Vm7Fj5nM2JT6MFAo69QQRH4FrIA8NWsmOWrJn6sYckK3zOWw5v
	K4MKp4uFEWeuWxuhEJppZdiSW1XPjJrfS2qkptImHGw6AHVHl+udPWhZyFtPPjQ5
	qq8Lc1EH3KIwGw1VguPyjUKr47XFWDSKEzwIE/sQrP42mhjEetpkbYC2Dpyg4VYF
	6fbAEhAHIFxiIUF2smMP8l/fevfLCub8DKc5jSS4VVO+G5hZUE+e7PjS8qXMEGtd
	aMPFE3AD74kNWpZSgYq+ZE0mI6Lxe6TJduUp2E6QA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbrsr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 08:59:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8CBob035223;
	Wed, 17 Sep 2025 08:59:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2kssay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 08:59:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58H8wk21016268;
	Wed, 17 Sep 2025 08:59:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y2kssap-1;
	Wed, 17 Sep 2025 08:59:36 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: hv: vmbus: Clean up sscanf format specifier in target_cpu_store()
Date: Wed, 17 Sep 2025 01:59:31 -0700
Message-ID: <20250917085933.129306-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9a0n5zNe2c6a
 RAns7M7CRspJpRRnTq3vgXtTWYM0V9V/W2sYovnmeb/FFVajeBFc/0jomj+JgrhYwD+VkGeJry6
 Hwu6Z+qp9Ry/8zhub0dxs3O33nHkH0OAx25YpOuoC1pr3eXACGWNmX6V9ll8YF+qSV6zoMLNpBR
 OMwTZzOQYGf+0+3tJbUvueWVQiHq6qGMmR2lq9oQrRaf14jvru8wKNZ05TVOWcarFbaGEpKPMzy
 TmaAsbJoOm2d74Q1bKOZQLQv0vj2nVqdr9o3Z9WibHEJJAg0efTM+fXNn8mMM8hREQtxCWYZJRv
 OrHUBIfu+KAHHlq8e/dK9E92NddamA33dGeTkfp845n/LSQNXEz3uh7xTyuCORnLZwJTDyPIU6b
 9JrFXy0S/ecUoOzXtVTZKFLXzZJFGg==
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68ca787a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=g1XmVNSvLlnCP4BV7pMA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: fAqcF2aU1vkabhApqY-Bon3j45ZCVvVa
X-Proofpoint-ORIG-GUID: fAqcF2aU1vkabhApqY-Bon3j45ZCVvVa

The target_cpu_store() function parses the target CPU from the sysfs
buffer using sscanf(). The format string currently uses "%uu", which
is redundant. The compiler ignores the extra "u", so there is no
incorrect parsing at runtime.

Update the format string to use "%u" for clarity and consistency.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
Rephrase commit message and subject to clarify
that there is no incorrect parsing at runtime.
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5b4f8d009ca5..69591dc7bad2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1742,7 +1742,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
 	u32 target_cpu;
 	ssize_t ret;
 
-	if (sscanf(buf, "%uu", &target_cpu) != 1)
+	if (sscanf(buf, "%u", &target_cpu) != 1)
 		return -EIO;
 
 	cpus_read_lock();
-- 
2.50.1


