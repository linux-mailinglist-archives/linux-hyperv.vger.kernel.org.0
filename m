Return-Path: <linux-hyperv+bounces-6857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E059B562BC
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 21:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02481B213CC
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB562494ED;
	Sat, 13 Sep 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyIQ6XxU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8A237707;
	Sat, 13 Sep 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791503; cv=none; b=A3u7gnxoJc6OOFenSvqCUDihTJqY7YoCN4aumaq+F5vYHmhUvmh69Pse3cK88SyV7iNW68Aj7eSDbetRAsya1/RqOf6fev5dZY73Uvgrd9SQg8ncvFF0lzmJI70163+ahmeHYdQy/FBJ6GsjZlXxz8lI7fg0W78ViYa8+ov9uWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791503; c=relaxed/simple;
	bh=i7/KbjZiNfU47YclkCatx1EsxFdOiErW7C1+hzk4hJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quuwnLWhryGDAA3N8T+0HPIScaKOMOrh7F4kcC6dzbthhE0fUGwZacsMqrX1+er4+kO99KHnscH/LI7dyUni8y+N7lOE/mfNPNN+av0+C+RtzzlXesxgrz1BYBZ5wb6hH2+55J9ahC6XoJqFQtIudFbIT5/nXOBoaX1C+37UE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyIQ6XxU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DIxjRw013566;
	Sat, 13 Sep 2025 19:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=H/oiv
	UKTqXX4mSgrC4cz5DeWu58V20ZhpojDRfLlPaA=; b=iyIQ6XxURsBg4vrtsXjL2
	szSvpSbqr4D7PkJ7nU+QboSnh87cU6dyTunkcPp33VR/W5qFOog/Bjk3vdkPLHEX
	tcES6t41lFW8L4rvoRIT8Ocmi5MIYEJt+ti4VlJlENXeJeqVig6slkJ6+kKPaTgi
	8zGHZXbCfuV7mlApdragXwTkmFQZOYGJenhjNmm3Y6J8oN6H3rlpArdNMY4ak4tb
	Ny7CSzWm3jibOPKNRqBsqPWUCu+BhkatcIdkiwtuEEePduTPwfQn4X4nPTeAeVCt
	FaSoPeaV7OGjo0PrBvRbkD9lH2I/t/Z3TJowF+gQopAhaBzMHdBtd5pWzzH5yclD
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yd8gg38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58DIZOMG015460;
	Sat, 13 Sep 2025 19:24:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y29q1pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58DJOrfT027951;
	Sat, 13 Sep 2025 19:24:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y29q1pe-2;
	Sat, 13 Sep 2025 19:24:54 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drivers: hv: vmbus: Fix sscanf format specifier in target_cpu_store()
Date: Sat, 13 Sep 2025 12:24:43 -0700
Message-ID: <20250913192450.4134957-2-alok.a.tiwari@oracle.com>
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
X-Proofpoint-GUID: rs-pWcfpb6ca7OZMZ9E2x5n2UnTrEzot
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68c5c507 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=5cw9m71sidPqPUodg3EA:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: rs-pWcfpb6ca7OZMZ9E2x5n2UnTrEzot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNiBTYWx0ZWRfX7XR2MMHOP9yN
 8aynXknrfFrPTxL0y/QPn8Lw2gdObNH+1eVWvDBascswKIqcp96+pttwmUA1R4j2Qz3ZjCIDHVE
 CEmt6OxMi3gE7PPFsVpdjf2TIwawwmNjoAMIqYShrWaivwzbsCOo/d2z4VbQR+uYh8gjUpE8YWY
 l3/TGb29Sf8N8wDUVvMTCOcfCGNySrzGW1ic+L1v6gz8obZJB7t0LONHRmK3Q2DL+tRdqSDiLK/
 /XK25RA1jgCpuchrGFletGTRE+f5RzMCqFZ4opJsvIlX1RYuYTCYSiTGG3PXWbpGDPidGb5HrRq
 xU7dlP1fgWnKv9fNdOxbn2n2qRjH3sOqS4lCf00QemXVShYV3Fa/LLM2EZVBPk4TvSfCcZR5FsD
 /fpjQklnpHL7WknOcz8VfeZFFTqsSA==

The target_cpu_store() function parses the target CPU from the sysfs
buffer using sscanf(). The format string currently uses "%uu", which
is invalid and causes incorrect parsing.

Fix it by using "%u" to correctly read the value.

This only fixes the parsing format.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 8b58306cb140..fbab9f2d7fa6 100644
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


