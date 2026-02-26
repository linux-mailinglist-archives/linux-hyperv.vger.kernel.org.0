Return-Path: <linux-hyperv+bounces-8998-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOs6FuTvn2kyfAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8998-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:01:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792C1A18CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A206307BB4F
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6138BF96;
	Thu, 26 Feb 2026 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6sMo5Ud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f09LpG5k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9938E100
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089293; cv=none; b=P3FB75G9LUI3hQhTkWmC5g/fyMb1j/3KwtJeKfIUBn5P4Biwgkok5dftf1ZAiw4E2UIrJa0JNewHdc7ew2K3YlQrfambb1zsXCRiYoqxgaI2BrctUIuYh1D1vBmZEOAbnWHOJYmStQE7AIloZH6k8LdwZAPqw+IXk1bCDXZbGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089293; c=relaxed/simple;
	bh=bnoXqYVVBjkyKM5cHX/zYf0/TJ3P+ZNYdxGTg7K1whk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHnOo2nDOn8iTuWLXLy6MLCS6jGI/nLPAQqgD4AuExQR4bum4dxN1z7C8Er8E/hhLYNv128bq4SF+Sd8h+S6iSGvTNXJlgPhP5QqSCCVzEfmG6wpNy+3HeQKyKGg3K6K1uCVmLn+p1rcZ+op01LuyE6oz1lGQRpKc9ti5aY+hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6sMo5Ud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f09LpG5k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V8Ji350119
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yKSAahOYvAC
	BfhspLoB+yDM9PsACZqr7CJChzc1vka0=; b=C6sMo5UdFEY8ev0ii8sDTQWBAp/
	Tp/oPfunqK42/Ax8V/s5ZCt0NzltP7tYJMak0mhb9O0x4k+Db+nvw++MFjlN2koD
	m6jWyTWaG5+FJIG9Xp9bXpbKfv7iJa6JhrwMoghwxJfPqeP0uxIi2H60/FVBH3uF
	x8c5KBVhevXytXExn5k/0NFMagIioZK4pQ2maCwP8ySN/K161qUDbHFUPFZzTNAo
	QypGflLzQKPNKkktw2VYtrKE6qOLg5Cm+HEi42++X1KrXalWePpDO9isiXkGSmOL
	7ywD5n5h62s/QRzgAqyInXRErUS/30BFm4JAYG0Xppl7cC8E6D1f5EvW6sA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa5vp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:31 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-678f3fef828so5161047eaf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Feb 2026 23:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089291; x=1772694091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKSAahOYvACBfhspLoB+yDM9PsACZqr7CJChzc1vka0=;
        b=f09LpG5kEeAb6crdyN3TZpk+uoWhPdJRXuYYn6Crpc1hbo1AbDgvsDf1PZcZZMhUtb
         o4V+6JKDfOXoBan2Bp+g6Um77k4b/ls601oyiuG5p9HSn+HupW9FydFAVPjOUvER3F3C
         DsXwBEQlEX/mI9x7VjSXcHoenvQxouEZo05UTloD6iC3Ou9/5pwKvNvvrR/KTvQrMFIc
         bReh+VSX/+9ydnh0Oly1YeaADm9rr+6rqYQ59cWSSTGVA+2XDKuFSmqCJTMjnMdSz2Y4
         niBkCV8IWYt0VLVAE1EW8z4VsgFkq4HAzDHPK4t1Dk98fmlJl+ENCll922OnTGVC6z9p
         UhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089291; x=1772694091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yKSAahOYvACBfhspLoB+yDM9PsACZqr7CJChzc1vka0=;
        b=nCm4wV5A4hir7/aCd+fph9oleDlVrDwKZBoH3q5xyiW2DDGeQo7Gw36oAO0Egw1pPy
         CCCL5neoPFVOPsog8eTf2wRQRRYB/MKJ0BNfQc8bM3vnpOULMDB1GXn2uUWlzTZBFKS0
         KVZCJlYcnVlwu3DOY08RrYZJH7ls2AYmef8n9aL2UGOLXiINuF2pKN7UvHSM9hLYuUGD
         Zx0h62ZZ5rpyVBQJAZKVHgQtoFyJgcAPx7MdjgvJkQw3xeXc0+7t/1qrZnUXkchuR9zo
         77H1m7f/Vr5aV5V9LaUx1lgj7zPeIbgw8LyUjvMEx+/TflapwAigUBgMCvNI5pnwsMkg
         81dg==
X-Forwarded-Encrypted: i=1; AJvYcCWM2fnvS5bary0gsO8Kriew/i1fIS6ZttKmWSF8SXMq5umzfxao8Qt/PFDW/5RGafrlxcjcHSk0TvfOgJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lbIdHKwpB2i/Y9ieucaAwRHB4E1dXJZVl6T2HJOXX1shzCzZ
	sEFvgEQTsg738uoLKAt53vdsb9xh4hZL9x6gqXovxGtFBNsGCYuwXHNcsYJk4sNhM8k0Z/vrEhW
	SaRj14xqnGKEF8T8ty5iAreISciq+dMIIFEHwaV8Kd/xBpBPwO+wrPkbpVCTCoHOf8+s=
X-Gm-Gg: ATEYQzw13t2+l2LNksvQuOHsKF7spoc7/PHE2FjYvsC6SgVwwuyoo/Dpiav9aC3qTt0
	9Kcs69tYhKtGoIKz1kP89niVKLbWzeXUL4yXHMWYWiMphghHOVlrc5n2XtHOYDjKCPm7xh1CxHn
	XuDU2AlKLVbqwtrxaQ31pcPgUl+rVlGRL6UxBq9rz8wyHr7Ofdl+DxNz8RZHl1WO9Xe3uph7YO7
	0+7JXZ5qFHZk2EfU5iYWtIeWEUNnnRMCbc4+lrSoP6MBCrF87FYExc6eMR+Y7TJ0kUABIDfQZlc
	AAxmjj/ZR2bhRoMujfcEY7uJl7dIsAG1m7JJYy3P27475oO9Qx7nAzgE9SiuVDppdV8Ieaurwwb
	YuVY3yz5aBtz6Bn+MhfQSJOs+dEjP8zef1USZdhfzKe0+5SBqvpimnPJpsCci6B6KHbSXy50twg
	imZ0xX
X-Received: by 2002:a05:6820:6ac1:b0:679:f37c:f995 with SMTP id 006d021491bc7-679f3d79437mr569656eaf.37.1772089290249;
        Wed, 25 Feb 2026 23:01:30 -0800 (PST)
X-Received: by 2002:a05:6820:6ac1:b0:679:f37c:f995 with SMTP id 006d021491bc7-679f3d79437mr569358eaf.37.1772089289794;
        Wed, 25 Feb 2026 23:01:29 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:29 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/page_reporting: Allow zero page_reporting_order
Date: Wed, 25 Feb 2026 23:01:23 -0800
Message-Id: <20260226070125.3732265-2-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfXxMAsgavs9qDn
 qY+khIPE8mokXgT+5qRNm9ixw5k68UH/RF/DT5p5bSIJSEa0DSEFoebleHFWVJ81glwPT69on7A
 3vyz1aMgMlaxO0va65SkbJcwxS732lACYR4Nmkw17v9/nDkp0869lpPn3qIlO2ScaOy6dtPs6j3
 E2BaqMB9BtyU9H5KZcsrrKvX1UHIjlglvC0x2a1WNE2YEOtAEsIHyQeM+voyP1A+0XgRJPTaES7
 qIZa78732qy3VJvKpBCWsuawRLZReQjrfF2RCFktN2arHmNFihth/zqYz+UCw6xSOIrsYCxW0iC
 rdK15HgiqqVJlaEXV1n39423QC9QOIUvevykP/UYablW1DC532CgK5UOzWEzpPwdHxe63ZwnFA2
 w6pGRLJJtTsZOAscFzkxC4qV0Y0fZLXRB6oiKiEQp3/rG/POEwiU0yPOFJZOt16f47wb2Ct4y1Z
 i45fyd8uBxOOWQFXpLQ==
X-Proofpoint-GUID: dvwIctH7OclOl5AQH27Vy_vVIWn7jARX
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fefcb cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=oYu5RVeIbCLf98ibfWoA:9 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: dvwIctH7OclOl5AQH27Vy_vVIWn7jARX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-8998-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1792C1A18CB
X-Rspamd-Action: no action

Some drivers might require page sized chunks to be
reported. This patch allows registering a driver with
order as  zero.

Example use case: virtio-balloon driver running on a
guest with very small memory. After some time has passed,
the guest might not be able to find a chunk of 8KB.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..fd7c5f0de 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order >= 0 && prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


