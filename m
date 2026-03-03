Return-Path: <linux-hyperv+bounces-9099-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON0lMgKrpmkySwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9099-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFA31EBEBF
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92995302E117
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0138C436;
	Tue,  3 Mar 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2qQARhJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgpID8fD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0838CFF9
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530431; cv=none; b=lbdmMGwLbmbz0WdanY8eXRdQLj4z0UH9lL6pJfCBRFK0XqJ9D5OR9/qEptGw+Ksol67mGXXbEXkFksnQeg4e6wQDWljD34hf3IeXIlfG+NuJjwD9Yp9+VsBYuqE404HEy8uxgX3/acyDfkBqJX0EUhNtNy+bdxEhlw8q817pA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530431; c=relaxed/simple;
	bh=YIfiGg54wHsEWICe5AuZdm92KWtiix1jjDHpjH1udtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkYtx3JkJPbvj4nvllHMEINtOTK5Wx3RV44P4k9l36wAf6u7jYKmTd64UsIWuXnVHtYFbswJS3UsKQw2P0pQwCI/BorFyBcErGN28Rh9WxAQ7nhecAWthdj6PldIzJ3G39igZXjEWESPEsKaXn/+FFTqFd89cRNpBikGxEJm6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2qQARhJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgpID8fD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235XHbK2996379
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7rYseVkxS5+
	KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=; b=A2qQARhJi84mnrPGEg8Holq+5M3
	UzdSd1/wYzgXrlZjAnKeXuqHWXGzGIKhgoqB3qYc+PeD+5xwBu1l6QhUC3e3ZfmF
	tmeuo2+drJLiXFCOPcrC3N1KRXSY6WIPzvmnzRBzyPRYpw5DoRWg2YuvwCxh2KVd
	Ybh6FxxDGLv9nHsz40PGyR3tWMYaEG+HCFTCfWzmBYv0tEBbB1uqDeGed7jRKlzU
	MZSHxsEXlDp0kHcU01D6L6tw9x8HTxBiPxa7m3SMSyn5B35Z03C9+gXNy561jGe0
	2E9pEa2aWkHYGziqnFGPKk+mjw8tUWByY+9X8ERby+BXiTJx+meSMJxf5wg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnh6uad2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:48 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463a075e177so27979821b6e.2
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530428; x=1773135228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=AgpID8fDH+vtbin6XQi6GhWkx7j0xVE+VDs7qVcxsWm6d95dd50E+mvx0+bwUDPaCE
         jhQ95m+sTbngG1R26UOG7VO48aa5RkqAkMotJKJNoCLeJWtEsNfoo8G9nJ1TjvHT9bc7
         EjaUwxF2HFYfNKPDR4S9Hd5GVGX+1zH9x4tzBoZ+z8RdOjQs/L7ubtpGBJWArDx0xbCE
         P1PznCXcGrjXtFK1NGq1Nq1uCNDRLhNnlKURf3ExA7yRTURfQXQF9z80FIQit002chzE
         NHSs+4UjYNEKz/AO+qkmnEfuiv+m2mJFHxhwZDu/8l0QOXLNo6fJbm09fjtLTNyqCCmW
         ZVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530428; x=1773135228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=NPCI8dCud4Dj12ELJTJQK3bxbV7jW2SpCnFKtRkwD7whJ/4F6bhTNzuOyEtx2SeBZi
         yu26WdSvv/z/8055uDx9jao8LsbfUdro8PUPwXWc2ERbnF7bsuC3DCtZdTIjHbYW7MbI
         pCJRd3lPIv6+TDnXYjBWJfwgRS6+0SPZdukj1R2kM60RvdKX6cEqVKOA5KrLn0S+UrPB
         p8iQG1Lc9mu3lW8rLTvemrE0v0R26LirRmdWw/jE1GdhrXo4JBGziERox0EV4rThp1D5
         F2kCAfNs1REt6BIC4okZXr2Ejfd+MLOThYgA0jnJtVI7MkVEWNGT5iM6EHl8jZ1g4bUK
         RfYg==
X-Forwarded-Encrypted: i=1; AJvYcCWi0dZ1GY19WZ4SnG33q9x2YwdNCY/ympnXKrzDpEdXCn/VMPmfwbxBGWg7/JB+4Ng7Im7tuVX0LyPFBJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bul9Nz03dPxmzoXxPi516+9ralD+Ywtxxl8iEd7+Ec2+eneU
	Ka2fN/yruFoKD3bsuTvIoX6hjyPttS5RD8oETU5/WaWaDqIQUhuouee/3EJSY6SoSJAo9VsiWXq
	vP+DP99d7rNb14NKOU+PmelSrQHVb6vyk5KX5oxRSkDr62/iz0V1P14Y+uIgyeAfdtNW2WNfjMe
	M=
X-Gm-Gg: ATEYQzxYeh6wNLutdYGj27IywbL7+QybS60G6T4ZJbfxsV6j9VJOIU8g9lSIDn4H6A1
	ibK/wvW/CrNzf0tJNbvARN0vmC2voiWuKEiLjT9HU531iCv6Hfw9ZY/d0FOJfktClvD0ZEEAye9
	gdHbFwFpV41flkgbbK6VVl8RyuF0hhspYv4TBR0APyxgJQuuh4ZfOY04Gc6OG31PLdLMyLhBcvA
	K9l5bX/hKp7Yei7D6OmAhEM5cFAFfos/MzxMDex+y9P68OplHXux9ydOvkXhqKGkS9QKQyx9Pol
	JezP7GOvyGPE5cYle976uNgcuiqWcImXmk9r2vhwFphBymoUxPyEMqvPs8+qeK9eCisnY3ZMMcj
	W62Vpdnr7qNd7Xiw+GLdjCaqdEt9EuvXQxEovLTlAJEzgriqC44sCM+qOyQ+/fhhkn/2tJSCcdz
	WygSaU
X-Received: by 2002:a05:6820:2913:b0:67a:1d5c:b249 with SMTP id 006d021491bc7-67a1d5cba23mr1025576eaf.74.1772530427976;
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
X-Received: by 2002:a05:6820:2913:b0:67a:1d5c:b249 with SMTP id 006d021491bc7-67a1d5cba23mr1025558eaf.74.1772530427553;
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:47 -0800 (PST)
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
Subject: [PATCH v3 2/5] virtio_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 01:33:38 -0800
Message-Id: <20260303093341.2927482-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfXx+n1kM4cHVgz
 2oYzVtY77Swy+V1eKc4vBdxEb+AcMdrpp6evL5E2YSe+wDTRFx7ive8PbWTH+fny5Hs1z7SvMcI
 4LCI9VHZssHvNoAGZ83gjXGvpyuA1mRxqkFZNXp2W1ojTy7Ihk6eH3+WkmYWNHSLWORiWjHef+G
 f95Yqf+NuE5FCxZx8oXIenif2FAp4MWEhW1Azb+nsjqe9T8oRnAtfy3apkjVybJzg6UvNHp+dwK
 0rfhfVUbyys+tIaEWhwq2wSMglN8cxU6NgCdeS1AlIm+UfrdIqv51K+zAjn/oy5igUScrFyW8Ho
 R9zNzaSLdX/EwUVO2THkpdxTP25TGW0art2LxIjhVjgEjhmy+zbf4mWJ9s3/P1ba2J8SHHkDCTG
 3Gp7SyGMxIoXHscggEAKpcjvQqAfppEClBa6kQJXcVduldObuA6e0f8ixGUBtyVgqJwG2245zHG
 LUW+dOGst5TxamVSqYA==
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69a6aafc cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: jmloC2AyK1se8l6IBPuuFxsqqOrYtdbB
X-Proofpoint-GUID: jmloC2AyK1se8l6IBPuuFxsqqOrYtdbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071
X-Rspamd-Queue-Id: 6FFA31EBEBF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9099-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_ORDER_UNSPECIFIED fallback value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..2dfe2bcd8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1


