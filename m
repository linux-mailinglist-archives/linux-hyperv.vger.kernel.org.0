Return-Path: <linux-hyperv+bounces-9102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBg9JVqspmn9SgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9102-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:39:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 045421EBFE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6D23034DF1
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8975264A65;
	Tue,  3 Mar 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N012rIsr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i3jIdf2P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2F38CFFA
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530444; cv=none; b=ZrLu/35Li6DqfxtLtq+LllLnuXUeYpiXP57b7ohaLgrgRB/lGufNdBgZiRWYaOV9CaNRLALpRvUvapSYud+B2dSLcQlelboOZk2CiYpeW1qOBRxxMnf3rkYOEZUHgg9apRImhhgK+t1YFu8g/Xd2rzYyewXj8t2FeXSYuO6dAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530444; c=relaxed/simple;
	bh=v0AIhcPYO4cND9UJsnnpgcg88iAdJ7oWx8LFxqs5UPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UadjQTxBhM4fI0iRXhUlNDMBc+50OHZxRB3ARL9t0uGoSme0WcR51sVR+ROJ2iFQf65ILdB20w3Fa1oml6FhyqVxy2hHyPfHmrp6uu9tyN8W9Z17sSk676C4/MMzSMatGSJxLP6RSnh5VaKDU/3VGdTPFYxuVjjI4i/NDOplDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N012rIsr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i3jIdf2P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235s6dZ2207878
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GErfW5OKwnR
	yFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=; b=N012rIsrwpXUlBt5lmhbGwMdKNS
	HYdreAEP/Mtf/kznRAcoBV7eRxs+pZwKcWXeKd/Le3LkbCFccCECNy4hFpEoicA7
	AxCf0vxaWYougI/3vuKvORxphPWjP2k7INhJKad/VQryitOhUracUxaoUxyvP/+G
	FdVWfd/4rdKOYrHZLWAA59TVtnXS0abcW2r9ALjIb8dYl8YC/Q0sir1rrBAUMACH
	jPdo/BAAXB22BJ5xd0gmn0yLfVX+4ClghL5CkQq6FWaMie55AdzDnyM/Flth0iQ+
	VlRK9bLpQ3LbFBiI+YaiispsgStnG9ArOx+AFAJ5CQifRSr7eMLAvNsUK7w==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnswe0qu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:54 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67a04fcd7c9so23502200eaf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530434; x=1773135234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GErfW5OKwnRyFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=;
        b=i3jIdf2PP8um36XRQkTC7L04YL0EPoIjdUlnivelPci6WDTGAqh/upMmMr9741k5UA
         QBX4EM2drkdW8i8Gxcmbh0guBjv+sf1lKf5drZR6r+lLclPa9pIwFZVHeMM2eezstViA
         C3sOYRW4jrXnIYTnEtmhHO2ci0IItslL/oVrMmarlJR3JdsQDEzkcrVoVyLXeP0BOzRa
         EzVYmRvnWAHR9q45kRxfhHSATSF5mlggD6a8B8+sMHTcLVuzCxzdrdYDyZ+ar9hMw+7g
         /FeJcmGsGFjRaEchm1DrmX+yo62UdP0WrJWVkf1h/PIEiHpEMk4RtAV1E0lYMWF5ivh0
         pG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530434; x=1773135234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GErfW5OKwnRyFXwMQYfYehZgqClYIHh3iyYeF5iCEjQ=;
        b=ISfTbMQ506P8BDhmw0HBmJxS9yD/UH/MgEDe/GrF2PHgY9oZ7M9kztK+OYdpMHK7z+
         oocwaFfTDiHY5x81/xLqsspcIw5iGYrBeURZD0Ss7EkKC1mIaFUjyHHKmDthdT419U5C
         KByy0+xlsuOMeKVXn01HUwm4nmmzGCWG9tzarSl9lVkYTiMh6Qz7YdCWTcDUo3BsF54L
         ARr3mEVIJ74/3EKGBBEPxEzixv5jjC8ekJKw0HucRPKLGDnuo8puVDrGMlKbhwDAxITA
         rWoDKe/M2R4GYu77+HMG7nJCPU7fNFeCbpqDyFGKHD7UFMnijpUk0ZsH3Px8io4v734q
         CNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVISlk+cOgHPry8dXGVlTLX9SaWfA6M+H0dLmYMIx04532bO+dpyHXnGKJOGUEVJFG8ZNC2dXfUBtC412Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkzw1CJD3Y2jOjmsTVUpIqOowOmiRiYhXKsaxhSfk89EclA5OR
	6+bFuLvoj02XDC7PYfEFfih7dFBmiHFcLIo87509RFsAYKYs+sfonu3tt9Lu11MtT8dBlv7FGNm
	GmwiVL0+wt7YP9YwYQPGfGpGMIF/JpI8InDRVKI+Wb6JqZ4sF8/OUZZcY1anFnBcovxE=
X-Gm-Gg: ATEYQzzdFQuLARNijERVqYinFA2xJWq0YfxHwsB/gbZMaxm4PfHbxDbL6URzsSEcLYA
	4j6QDGpUDLw6C3orCkeApydY5leNI/GuGvsyrVYYUYrXa+1up/Ck34q0jKVavsaH9kNYIWEUKo6
	MMbeU5usOdL5FwP1j3Kh0vOMq0yxVePfrBJ30ewfzuTDUGZ23FkjRBhxW1MLDJ3PTz3X/V1xkw2
	ttrl4Su/zgsiMFqFRM7oNJ3PjGF9GUNhTAmocUcbtawCgr8W901zEZBQOr3ovMhzm+Y++ehg36c
	2C806P/nZKkQU8iigF6MmviMpUho8WDjdOSRqhgYMGjwqoTz4bgEzog9PlIh9Kau0RT3vDYW0Q+
	IRNeBCR9MLAoaoE8MyfC7ognxbyAzCG5ylPCOC25iESw1yzi5gvE7r7sVRd9oFyDPje1De0BVdP
	CHFnIz
X-Received: by 2002:a05:6820:4b85:b0:679:e633:6f53 with SMTP id 006d021491bc7-679faf9d7d8mr7935885eaf.68.1772530433734;
        Tue, 03 Mar 2026 01:33:53 -0800 (PST)
X-Received: by 2002:a05:6820:4b85:b0:679:e633:6f53 with SMTP id 006d021491bc7-679faf9d7d8mr7935866eaf.68.1772530433239;
        Tue, 03 Mar 2026 01:33:53 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:52 -0800 (PST)
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
Subject: [PATCH v3 5/5] mm/page_reporting: change page_reporting_order to PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 01:33:41 -0800
Message-Id: <20260303093341.2927482-6-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: E6NJSRYP0sNr2vHNVZkFbAH4ssOKqNM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX345JmXkadjtL
 sUNiEPIYO/E6Srnv5q/30ev4Cgwclqn8iKvwsU4v8LyMXsm+PXImgPSFj0J7koVbNeaoQypabKC
 kR13xfU2eWZSq/IaNWtCBvYGNqP67fCw5NAFg+0DJgDS4w0KYF1yRnxR5YyJpSKCOBYkDdYUADs
 q22Z7/wWGgNI+EhS25HO2HIy1gDktM4E4heGDkkBYJVI+T85I4kHPfYrMj8FiOghDluIOoWlxI9
 TNcGz7uBR8rXBVCKK2OYXVeMPo2bbCJXe10g9z1Ka9FcRl2/U9D1W7GPHFWgGKdVhR8JBqfTT6r
 PQtl5KDUhS3EUAjDT3PDAGYxAT82/zlSr8DHQO94qLRAxKiAR4+ifXxo+W+s5aykuQJrp8Qq5PI
 oO5oTX3f0QVkYxBQT0F86+JhmLn13KgAX84OwcKNK/FQz52pizQYS94IHeO3UTQujpinCNYish8
 KY0aeFPNbGiGRp73H8w==
X-Authority-Analysis: v=2.4 cv=TtHrRTXh c=1 sm=1 tr=0 ts=69a6ab02 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=snxPPiGZoRN-_fWW4r8A:9 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: E6NJSRYP0sNr2vHNVZkFbAH4ssOKqNM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071
X-Rspamd-Queue-Id: 045421EBFE1
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
	TAGGED_FROM(0.00)[bounces-9102-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

page_reporting_order when uninitialised, holds a magic number -1.

Since we now maintain PAGE_REPORTING_ORDER_UNSPECIFIED as -1, which
is also a flag, set page_reporting_order to this flag.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 40a756b60..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
-- 
2.34.1


