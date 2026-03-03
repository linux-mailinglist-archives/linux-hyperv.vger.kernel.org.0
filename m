Return-Path: <linux-hyperv+bounces-9110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uON1JVTKpmk0TwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9110-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:47:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D461EE7BA
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169DC32D1DFB
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238947D95B;
	Tue,  3 Mar 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RFbjZohE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UnRJgx6q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83A47DD49
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537445; cv=none; b=PaYOmOLDb1fJu2veFXwwgnTZcyZnBMyOwV4B+O6zwzuvBqsLn3NvuJWDvTF/HzXMjDlsBvVXaYfdwxueYzHYFpGqBg4DK9Pbeqb3fOA3A1FhURZqv95uOBvgIm2/0Y0HswpgAxgdjuiLIVusxsRqiNxs9Dm+MeCI8Z7nNQY//68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537445; c=relaxed/simple;
	bh=LbKFNBiZ+VRrB07vX9O8FknKJ9OvEGWcCKyR1m6xhDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJ1WOnLE8qnu3DM9CA8WPYUxeuPGaisbyaOeWy4KT+17RZMm1HOtKToHoSTUOpcRabssnr/J18l7JBhsmbeEwH9cvZrzjQ7w3rvr4zWuTBIpDlRzIQtMd/sfTu/j35lbs/6t0oXb56JX9vq6cEXSsx49A2JGvo2m7+p7QKxWjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RFbjZohE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UnRJgx6q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239mrmJ3099626
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rSSvKdrdqNt
	Uffp+vZHypJOUj06k8TVBSBVgyR9aCmM=; b=RFbjZohEdYhFNtNFyhW4v07d1Xy
	t7Atad8LzCi6bRyYwCMaTj0Njuntt7rDanIojjQjtoPBxUWmKBFMmGb8NlDjrwxl
	LLGgSA8EdVb0zSP0nhFaWQiC+H6I3Ddf+VaFGvorGD/WHg3Wg4mdikgYxTtwuIp6
	XIvFpZGhRpAIH8/iUObyhlnJU8WLvBN0eAR1Gtl8fj+qlGDtreSm9SecY8HyVUee
	TA9/+pCZLavcYwyWdxRbvhfND4qU09bQvVhy4i+v5SqRSWibrWaFd0b1HQgGv35D
	2KNtCAObhJ7eU5FYHma1tNFzrUoh3OwNjSEtt43fwHtPPRd5iyNOMHAbSbg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnuqu0pwg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:40 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so66778832a34.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537440; x=1773142240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=UnRJgx6qNZGQoF1LKAnF/AscqipHo2OD1SnVAQIty+I9Pe/xD12QAyMTdbU9htezyC
         iQpY1GQHdqbQq6Y55pCfv1XD8tWXleZg24axxGuozTQ8FI6+tGoAEd4Wd1Bd58VX0R6D
         GeHeZa7AHhNrlQS8g9F5mQW9vNamsVFxMPBy+7gMRMN/mQhfxn+L6j1ZXlD+KJkLZQgT
         W7pjjKVaWIoCdAC/9lp0XlDGglF+95n9a9I/fPvFKLlP4A8Pgzn93M3GmYRr0ggcCP/0
         1xTVyPxAPfLjhv4V0d8wWTlb5baSwcqrdSvBQ8W9RkY0JNFcvzWwlgoMJ7TD5nuIBUsB
         vqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537440; x=1773142240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=t6FqfGUKdDNll4bhCjHqHpfmas0iq4O4s/PBcbhED5FYoI52qr24XzlqyQQDlwR9hU
         ydgemVcHV9NkCXkqkxKkwCejxXTeCpqRaOYJvKyg+CJSRTlWk0IZJopQOav9fc9P9mzQ
         XjDHg6KWcVzgr52y0CaGf+n1Wxs6BjJlKvA+XqdW1i1rXE3/fFQA20k96tWH554LaZHN
         Ec54Si1Ju0t8JZwMqXmTD/2ndmHeP5pbqe+T2yM299+uLTa9Z2YEYvW74IVyclSpNcu4
         IPqD6hrniVy3OvSkGwWCUbgNWAmnuH20KLglgtRJxN1KaiQKuD8P9MT0NJEVMPKxDc6c
         152g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Fincvl3Btfm6O4lQSlY9YZKOMv9nIGGMoNxy/ZeEQSc7nI7L+jwYvGHuEJVqLW7XhEq/4yfPPMh3W9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgseOk6uFiMBrh7EqadBohI6MOpZnd0kr4gKwQIag+wbvb2shZ
	LJgtuzGS7cxggv1+KGh5qWcvsma5j4dj81x+mMW/UgthtZZbZCkMhL4xYk1dodIVStdm5N87i5O
	05dWQaCZREvlqUET2LPN8uK4PscNF88nud1epzdAJd0aZTjiFuWEOvagJfKNnCzt7w1c=
X-Gm-Gg: ATEYQzwZkfxgyRLefktf9z8n2tFbzUfrOkfp53+vxiljulawoQqmxktSyKitsvly/iD
	oj1/v9CEuKGY0NYd7TDQRUZegsUa8Dmsir+KUx2p4egeqz2zcaAjmNYHDvzWU/SNJHVmnZ0ze2z
	Pv83ZkvqJ+3IoncZ9m9AGrdlknxZNYPTDXmTy3x22eTAvIbfGrmxfmcOug0Zu3BcBE6BRVZaOZU
	GVfLkb3wFNHMlQ70jsSWaDD3/VnWXdSMXz+jJK7uPQHuVm7DRT+Wy3FQXrlNbZyRapxvyDDPRh/
	nAtQMthVHLFECtb5+tzCZRYWaGS0DhHcqtP/m1f1OH0mFnR9HO/pXKsPVwMrH7pFIrtmb0gdKEX
	oMHFv3S8pzmuckODEx7QezEIbjrMEbvDsptzAXD4u77ysD2GMzSwr1nkciHTnIOg/T/1N6MXxtL
	j/SPwQ
X-Received: by 2002:a05:6830:6a97:b0:7d4:5057:5ad1 with SMTP id 46e09a7af769-7d591b27bd8mr10409237a34.13.1772537440282;
        Tue, 03 Mar 2026 03:30:40 -0800 (PST)
X-Received: by 2002:a05:6830:6a97:b0:7d4:5057:5ad1 with SMTP id 46e09a7af769-7d591b27bd8mr10409206a34.13.1772537439862;
        Tue, 03 Mar 2026 03:30:39 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:39 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: mst@redhat.com, david@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH v4 3/5] hv_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 03:30:30 -0800
Message-Id: <20260303113032.3008371-4-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69a6c661 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: BlBaNyeRkXGgjjC5oksvLshtOPXJ3WFt
X-Proofpoint-ORIG-GUID: BlBaNyeRkXGgjjC5oksvLshtOPXJ3WFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX8Yt7UvhKGt7e
 8uKZrPvUf6b+BeLRxDXEDJQ9tQytyECI6RdcsjZ4HUdllcegJLxcgmYQHHF7/MOvAzrDFtElOpL
 zbDsxrUkwlqagfngnPDuUJDLr0bICXt4Ct9gc9AJRL97LnuRvxmoAH/juAEcVxydH5fiivb4oM+
 JvYF2KRnjqVP6z3j2HQdA0xjEL8NdFAMCCMKpoxII/0QD3ngTgIDbJdbpLevi814t7X0HZAE6dS
 AxO3MnXXSazgojFTsQG8KGYincjYF+M2wP1P7K14p5KejzA7I2cs+v6ocYzcRfpjdvouqqdWySn
 nzxqIvhLQDIkTbm9f4j/8bgMta1roIiispHrHeqF5d8RzLeETrDtB8jyDYUp/gH/hOg8eG8Nw//
 qHuophQqTMSDsbqUGr/be39/V/h6UYQnRBPQF3kUKj5kkkqR0YOh6/+SXBkDup0H82nimn0OoiK
 xu/r1K7l934bX3jW+zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030089
X-Rspamd-Queue-Id: E5D461EE7BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9110-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..09da68101 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


