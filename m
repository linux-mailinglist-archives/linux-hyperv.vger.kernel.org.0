Return-Path: <linux-hyperv+bounces-5987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4656FAE2ADC
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Jun 2025 19:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2121175864
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Jun 2025 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057761FF7D7;
	Sat, 21 Jun 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oTGAGpLD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273514658D
	for <linux-hyperv@vger.kernel.org>; Sat, 21 Jun 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528456; cv=none; b=liqqAUrctIQbl2cxWR+BpuWA2dQVm20nPrTVpi37tleN5fTX7TZsITtZMpdd9mx8o6Y7w8KXzudmhRGsdiVriuJwCflQFGbK+VyubX4hSVsdYeiu3rgSdp1/XJqiWL0kzG5Sk8k+b0SlIJcE3LQOLdce3CrvE3gafLUJtVnY+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528456; c=relaxed/simple;
	bh=Ldlw17Fl9X3GiAOyT3C1WBJIGIViA9cER697c5qGFtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUeMN07mKESvWUJsAuyeQJVdzRRg/K/KNNg5FQUg8KeasywF+3JhhpRgED1O6dOTjTsJuY941t1TGrCIfyGpT0kO1HO5BAsSmgrVTk2G7bHZ7LkXrTfDSmMIXlM7O+wEzpkkQ18STHSrtMwANNINSVOCQr6QhewKB9TESKVtTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oTGAGpLD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55LAMvfj015399;
	Sat, 21 Jun 2025 17:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ngRFg3EGU9z1exVz
	2eKvATN5wpQJpW9rJ2yLhwDpYws=; b=oTGAGpLD0mX+H3aNNTqjD1yhcoi9mc/T
	jsAtZ3yNHulB+VX9cc2rctr6Qc0uyKoCRiHhwm5PVC/CgEp+6dsQkKsU++Ap6ziC
	OQgonf7KeCTht5auHQVRAPZpQxjnL7xh65xwh/3Y3RpEdve4whr4XaBAvNIVD4LA
	KGvv9aNwVxHVB0FSKHRzoURsv8fRtiMLLQ8WmqWs4saQtl8iF/SumMfUZOcfq9LB
	a/YIon0RAiO91Axkj8xzGUe7CiUpSsS8+3M4RKJg/uroK4QYyyh6G7YgZsQRlV3N
	0X/dPvkrsS2FCfxDaCC6lNQFXqzZgM8gxadm7w0qszhmoH7agABzQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87rawt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 17:54:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEQ25o025307;
	Sat, 21 Jun 2025 17:54:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47dk67vqc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 17:54:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55LHs2VE021872;
	Sat, 21 Jun 2025 17:54:02 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47dk67vqbw-1;
	Sat, 21 Jun 2025 17:54:02 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-hyperv@vger.kernel.org, kys@microsoft.com, decui@microsoft.com,
        shacharr@microsoft.com, haiyangz@microsoft.com,
        shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
        kotaranov@microsoft.com
Cc: alok.a.tiwari@oracle.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Subject: [QUERY] net: mana: use of sizeof(header) vs sizeof(*header)
Date: Sat, 21 Jun 2025 10:53:21 -0700
Message-ID: <20250621175332.4078284-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506210112
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=6856f1bc cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=MD1BpOzwV9kDkxy97YIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDExMyBTYWx0ZWRfXxIqcwhbBiox+ 4yfKlInzROObb3U/PWwqvNphAM983QzfyU9dDUzd5KkDcDpKZTrXpDWwJCienZ42yfXUELsC81Q AIjzxboX4moL6A0jCy+f6ymZA9q/QXIolCemktCL1m0KLICUi04Edv/36BA95x8b4SfLrnEr1ie
 gIl/2bVR8rTcTa39bh5hhx4ujGvDjCmLIKDcYyaSzfmqZWBbOuwMvXdQZvWCgw1EI+SJLL24rdm D5FP/VP3MSDr/5aZmXiL+nLKLv2RKUejVT0AWMf/Y5zX4H+a+Oj778MF+00fvtXFkvm6iq0Krjw 9F8capaWauaE9tI6LpvgqO6sCL2uIyLuKgAdSxaBaIfU7nJ4LjuBeFN8fdwRMi7mrQPmnJIYsxQ
 HcEBx0wSlez6TMoTtCqYN7dSnvVjY2J8HboLzzJKdflKzp4TOmHOSes/wCRba6WE//ADnzpc
X-Proofpoint-GUID: 09nilAMCWqbskTXn60sjpYUItx0CKG7j
X-Proofpoint-ORIG-GUID: 09nilAMCWqbskTXn60sjpYUItx0CKG7j

mana_gd_write_client_oob() in gdma_main.c, I see that the original code
used: -> ptr = wqe_ptr + sizeof(header);

However, since header is a pointer to struct gdma_wqe, would not this
expression evaluate to the size of the pointer itself (typically 8 bytes
on 64-bit systems)
rather than the actual size of the structure?

Should it be the correct expression -> ptr = wqe_ptr + sizeof(*header);
to accurately skip over the size of the structure that header points to?

Even though sizeof(header) and sizeof(*header) may both return 8 in this
case by coincidence.
but that seems unintentional or potentially misleading. Apologies if I
misunderstood that context.

Thanks,
Alok
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3504507477c60..df4ee8c23bcbb 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1086,7 +1086,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	 * to one Basic Unit (i.e. 32 bytes), so the pointer can't go beyond
 	 * the queue memory buffer boundary.
 	 */
-	ptr = wqe_ptr + sizeof(header);
+	ptr = wqe_ptr + sizeof(*header);
 
 	if (wqe_req->inline_oob_data && wqe_req->inline_oob_size > 0) {
 		memcpy(ptr, wqe_req->inline_oob_data, wqe_req->inline_oob_size);
@@ -1096,7 +1096,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 			       client_oob_size - wqe_req->inline_oob_size);
 	}
 
-	return sizeof(header) + client_oob_size;
+	return sizeof(*header) + client_oob_size;
 }
 
 static void mana_gd_write_sgl(struct gdma_queue *wq, u8 *wqe_ptr,
-- 
2.46.0


