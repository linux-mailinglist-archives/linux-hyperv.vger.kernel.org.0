Return-Path: <linux-hyperv+bounces-9101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPheJR2spmn9SgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9101-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:38:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A01EBFC4
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270133130E2D
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0139F38C43F;
	Tue,  3 Mar 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0/7P4l0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iY+XmKZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079138D014
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530435; cv=none; b=nQ4HvxKSYoTDbC8CDY2zG4gTelFa9Li9OEd2rgumcuqtaD4QDKtwt1U8NZZnPhbU1gX7v4cp1xdt9aSJ2R+9p6mVu2qlReom14QP6JuOBNxf0Xeced4zgeA1bmbhBmU3BYCJIQqZo6NMU7bYG9bW9caOmFpsyMjNo+5F/4x2mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530435; c=relaxed/simple;
	bh=g0IFKDbaVyFX/mq83PnPwWEpsddcb7B0V1NVF2xNyoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CACod4Zkjx4LWlFLW316ajfeWouOUvXavjNHb5yz8rgNcDUgE6h5NoDQdzKFgopv2hC19tZZcfwB+2WCR7laFlkgipTDTvj0MWhX2XsegY2pLI9BZpOGHwYGGMYmTI+TFPBUo4W/U/Zrn5WB7+IwPyrJByDIPJ40qWfqX8VT9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0/7P4l0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iY+XmKZT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62364pMt959075
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LfGWmgs2oNU
	vnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=; b=b0/7P4l0FVPZuXBYQuwzeCwqNUZ
	Ep31sNDYK9bgVIfC3Du4RO5X9MSRV+kJCx9SnMnFAzJkYIMyX0Wc9IB6bnHZ6kX8
	5NUG4RhdTcHs+XKFBG4Mg2w7Aofip4E7t30mb7lMFPWIk02WiyARFKPqDwOqfX+w
	6GtipcZg6sF4mE+LPnrcRBT4vjlj75XhjRv07Pmv0nYWqrhvGcIuclYO+5jwAZdT
	TV3llc/AGVS1NgpLvPmwWM4AZx+a6wyCRScDhghd/8EtoT3wa9lP5P93j7IIsKZU
	PPdccLoJhOyhJi7ZdiCwVPGgWPGYHEWDGWk6aG2UwYoKC/s8UYSXJWcPiGw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx5a8ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:52 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679a47a1febso105197562eaf.3
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530432; x=1773135232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfGWmgs2oNUvnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=;
        b=iY+XmKZTnAtYEXwEVKuArti91duAhVQLCgEeBMPjqM59N3tuU2WrL95B7DzKu55XFd
         HPxlnzUuIjAso4uolMKNpiBR3KSIY+DA2s3WOaLqhVdbeh6YT7E2o09T/IrxUhq0r46t
         HhaXyG9f1w+1fqznhdfBsENCGlrp+cVHyhVfnVi/RFf0/gOaMRpYGMVbbX1vydXQCgo0
         53Mkq0Y8XQcpflMy3NMZCii6lv2k51xqX2QwcmUcLNQfGZhctzFj/Rhx0wpVQVkEnC7/
         CDmgODxO2xM4FFu4UNYgH/Qdhd+cYnmKY8yG+/vZElQUMNj+Vq3y67M5lI+9Pasaf4dg
         tI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530432; x=1773135232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfGWmgs2oNUvnsLBvbEHmpATWwPVNjbdSo0LsFWVo1U=;
        b=KooqbvWXblThIricaviSS3siNzm0rphNZOnbcIJvj7jeLHN1PZOuSSCA+KTxtngkcp
         LbBpabkHtsxsYOfoJqSHdy2RoWc3zrro+ZOf6iB52i8gfyjFHNve7/xxZGMRdGNqJhuc
         eIlsOzE62QYlo7f/XlsozExE5f24Gzws1UM516jKYo7VC3OkhNBmUXwIr4roarlgaAg2
         OO8O5B/O06IGPH7Qf3vJAaczR0eQeN5h9k8U938AjOHBV9fzdvasNC0+ofq22EM52s1F
         aOZMv5ESD5/rmZ+koy+l0WFAaqAjsTLmSwNudEPn/+S0ygLm79E0JPZSe8YcU+esm2ND
         Wclg==
X-Forwarded-Encrypted: i=1; AJvYcCUQpHAW3cUppmghdm/i0YYe7GRqBFAYMAWuspkEioaNWdRKBBe5c/ctOMtaFbxN9b6ynnygO3yiGqnKvaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5PBeWCELcNW4zRFFtnGp8ZbRpKWiWlbYxtipppCvLMjCt2UHS
	ewhvztcGdSO/MeObdCivdxjJjekjE0LSJvpfU0Aru0Hsv3o3FHtTd/HsMIP0EycJSfWiNaTCvtm
	qUVWyoUd7hiBsYm35XRSal8BulDl9HJzzZ1hCEHx5JE7gEwIMdPyb5nNyzXi/Ca1VXFo=
X-Gm-Gg: ATEYQzxBt7ZpZFhCFjGGdR7PvIi98te8EfWHlJLlzYUHm7x8YQF3wX94FZItzZ5lMSb
	grpmigviOVEzTtIhnSL5PBZdqJMeL3qE1p9d8hRqYfEn+EpmHecnIVkhiSZe9xqZ45FGTq08qtd
	U8d7OCD0+/JCS4UfEMoxmfV2JdDp+HrDZ93r9r+pSW/bm4J8PsS9dGOZIGETsPSiFh9NCIDFh4z
	Y8TQD2An15mqH3SxbJ0jZz299pLjlYtcDfOLPJ20qcdc3+OVzgEFazOnmsrcpo6Up+g1ervUdJ5
	c64eugSrXwMOS8qfVFCCZ0TL4s6Y7pX7qAAwEQuT+ahaGoqJ29EmqqaeA1cdiaNDCQehquN867o
	25WMlZBL9i8BQQqEcGT7ieWfdRybFH8TIGAkIhVmWmyyeWGRs6ZIFcJHCzxutsjYdxay9UbitMG
	I7ZX6P
X-Received: by 2002:a05:6820:4b91:b0:672:f683:7c54 with SMTP id 006d021491bc7-679faf9a246mr9755940eaf.69.1772530431833;
        Tue, 03 Mar 2026 01:33:51 -0800 (PST)
X-Received: by 2002:a05:6820:4b91:b0:672:f683:7c54 with SMTP id 006d021491bc7-679faf9a246mr9755930eaf.69.1772530431435;
        Tue, 03 Mar 2026 01:33:51 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:50 -0800 (PST)
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
Subject: [PATCH v3 4/5] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Tue,  3 Mar 2026 01:33:40 -0800
Message-Id: <20260303093341.2927482-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX6/QluR0sCQDD
 2XVMnsDL43OTpfSN5kqCbfzp3NeklqjhTcWyc7fMHnIC7hXrJQ9ze3W8/ouz3T9UQ+SRNIDjuD+
 9rqeSitGiAbuKfYJFu6U+FdSNsOX0tLdcIWHKARl/sipu7Lg01FCkgOh+gSTj84qrDN9GR0ONn4
 9PEyFdWKIGkHvqOU+pFt1VR/9ZzYf6da1lV2RuH7OtvGYZkVm9bGaTcgh3fZQbS+1b+qKKizigg
 +i5Y/DlRgkNYMnd9ti7aRNvV9zEneDzfq674+HY7BbltWlqT+S46tlOYcXAVVWwWsYncRIy5H+j
 4omDmmU35UkuO/p4OFQ3gG9ZVHg3Etvoelfe1ZCcTYDmnmG3y4u5MjRy6sd9+lXYDxaxO7ftzko
 E3W2gQCwvwqGvI4kNECI9njHVE97nWl8smHpKh+CnWlts/Q3jwwS2oVkQ91AP/RwvFRYQPLTYAt
 gc2RqXhVN8ft9tZgdvw==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a6ab00 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=6q7Fjfde3VlTRWJJNBIA:9 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: ljcW1x-UnveNUQIicoGd35WjOWkJZGSS
X-Proofpoint-ORIG-GUID: ljcW1x-UnveNUQIicoGd35WjOWkJZGSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030071
X-Rspamd-Queue-Id: EC5A01EBFC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9101-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PAGE_REPORTING_ORDER_UNSPECIFIED is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_ORDER_UNSPECIFIED to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index d1886c657..9d4ca5c21 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,7 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
-#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	-1
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
-- 
2.34.1


