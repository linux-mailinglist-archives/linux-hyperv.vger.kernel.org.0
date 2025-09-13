Return-Path: <linux-hyperv+bounces-6856-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB93B562BA
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 21:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C33189C90E
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Sep 2025 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66A2475CB;
	Sat, 13 Sep 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2+Xd0w+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18914B977;
	Sat, 13 Sep 2025 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757791501; cv=none; b=snV+GhjGcoqhlTEkuMMf6BmhOOyiLPTVTU2TpNwMmoIGX7vkOdm4VdNaYTF/MdfTOmLXOYRjTSqXxc5KTfCXVVFxeFV7Z0Gunm0vQjakB6Pm7fEMWbqhrljud+OdmU4fwGGuoxoNb81e+yqCLtqhgCx7YvkDJXOAPt2KS+OipUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757791501; c=relaxed/simple;
	bh=Gc193u04EhhE/Pd1cvqWOMoJobllu2lCpcWBDhspuzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJv9pq508dy4R7a52wEGeb1qTw3zU/SpjK5c6smFSmYs/EjLSwqqU7gkhO/pxIce7OlGwL7G/AGJGWbEhm6/BPUAx42iQovswbk8RpTy4mihyDdG2cwGKLFdg2H40cT+4z6pat0cvFBwWxLFhwfUzg7TTvGoGyEN2NnGAgrZb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2+Xd0w+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58DImxj0019034;
	Sat, 13 Sep 2025 19:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=IQEmGPIieWgPXdJ/ZPndLMe+M3v9Q
	nVmSJ6OoxuDmek=; b=a2+Xd0w+5jiAuVggmuW8/KTQMcT1EY/nR7MzyVntDz+tM
	ReaW7m8bMYsL5LnL10dU5IuplaKkG3ktdtiqtXN8m/bcqO/GS6yBIAlo3Ap0JlvL
	mMgakz9rxje4uU8xwwCCd+l2SZBPyQRuJLJ8jzHK6CFHp3OYUjm86ollp6ntJXsc
	Ym246N46Dtr/1r9QrZOzp4d8DIcSkJHYBZ8MvSNOQ7gDkPviu3pWMDbhUcGwK6r9
	XwLWi57mVIqxqKxJAa+nBQpq9RA+zdE28OUqcp42Zu0xWJ90jbt3LEVhi71iUMFA
	sxWtwqDKoaIoYK/5bIWN3pbW6HzFg2lzgCj7TM6wQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fgg9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58DIh1ZS015444;
	Sat, 13 Sep 2025 19:24:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y29q1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 19:24:54 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58DJOrfR027951;
	Sat, 13 Sep 2025 19:24:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y29q1pe-1;
	Sat, 13 Sep 2025 19:24:53 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers: hv: vmbus: Fix sysfs output format for ring buffer index
Date: Sat, 13 Sep 2025 12:24:42 -0700
Message-ID: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-13_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509130186
X-Proofpoint-ORIG-GUID: 7hYGzz3wbfMsVaoFu2DCFxkoNHwVRDOR
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c5c507 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=8Y5qj_Tp2ppcPA6PZqAA:9 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: 7hYGzz3wbfMsVaoFu2DCFxkoNHwVRDOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfX8wJcH3N94c9I
 m2+P3o4A0M2dKCZo8Z7Z/pSlQONvIZQkZ/Jg34Y7PdGd5aJgrHHGlclu/bRwiGj/O6CeWIMxY+V
 dQGR6qkArYaz2XbSahmnuBwYBdpS/ojKqWoaNbj2J6fAlfs3ONDrT+IH9LGMDMDZA7kmN1Bcc9A
 prkLLwy318t7p9SLtxIUbjZExp4AaIRPxjmqVWbBu4KRbTkQx7qWwqE00ev2jP3tD0AvoF0ALRz
 UvV3GRhCGSuUD6pIQeFPHrS2LSKP7mD6ysRQAXEDVCNyPYCcSUqshGKy4tRdN+L7R9YjJ5moXMh
 hplaBqFVa0avGBJXrpHH0gI4//TibE8QhP7FoRXYElcfARdJafQjWiWcQP5eJgPalsdQ3Rf+SB4
 4OD2/I1cH6V7ZdF9jq/VR8xeMhNb6Q==

The sysfs attributes out_read_index and out_write_index in
vmbus_drv.c currently use %d to print outbound.current_read_index
and outbound.current_write_index.

These fields are u32 values, so printing them with %d (signed) is
not logically correct. Update the format specifier to %u to
correctly match their type.

No functional change, only fixes the sysfs output format.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2ed5a1e89d69..8b58306cb140 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -322,7 +322,7 @@ static ssize_t out_read_index_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sysfs_emit(buf, "%d\n", outbound.current_read_index);
+	return sysfs_emit(buf, "%u\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
 
@@ -341,7 +341,7 @@ static ssize_t out_write_index_show(struct device *dev,
 					  &outbound);
 	if (ret < 0)
 		return ret;
-	return sysfs_emit(buf, "%d\n", outbound.current_write_index);
+	return sysfs_emit(buf, "%u\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
 
-- 
2.50.1


