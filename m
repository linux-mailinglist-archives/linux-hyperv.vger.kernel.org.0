Return-Path: <linux-hyperv+bounces-9108-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGqjENbPpmnHWgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9108-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:11:02 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D201EF15C
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED77732CBF97
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75247DD5C;
	Tue,  3 Mar 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YIppyilW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dFd0O3Pg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B547D940
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537442; cv=none; b=oSM2c+NnsPbinlP5Z+NQenP4VrwovMWt5J/sYYt4IGdr/w6VBlgr87fpEuAyr5AROJ893hhxlmY5rtfKZcL8XnUAesOB/oKzD3J6dwAXu05pq6FuZGeR+o1uz1iQX7EBLVfRulwsx8UeTyaPyawXP5Dcg9RwLFV7XjYD4Fnkyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537442; c=relaxed/simple;
	bh=jY6mRvbmqXELWJqG0Bk+K+vTmlEB3asE/vzhP7nfC5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZR2vep3NIKYnLAZuPaBTSM2h7Mwh0vxkFw4TsI/PtWfcDKIFqXkPjYd5ToEINsAxOgt748sb8z5s9jB8K2FMyHFkLd7To6+WC/X4Sfw15pRZlKbSb/bzcz6Lngxv89lg0k1E5wcIfT8MOaXh9JI0bhawW2MyAyjEufw2xwN1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIppyilW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dFd0O3Pg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239nHlK3349616
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D/GrAB9Zzdx
	foJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=; b=YIppyilW/cAq+Nt7dLWikSamMOV
	5hdhDDms0iUPUaYdRSrcMoM762jvV/Z07RAsZqVRz8lV0HpSxBnBIUvXi8rydy4t
	lw3gwOzdTUVj9bJAQjk4I50p6szGyJLKK19C251YwnUDGPHlMrHZdV5eXUuqe3kF
	paUs65cQeIJxtjdMESnqhR0yBF57NN/AR3sytri1ClNFbRD091zeFIe8scYxe+j/
	2uTY2cQQdR6HP9C7h0jBM8xuMbpjmbo8/ZXNmp8Eg/3BT4/PExwt/7EbX2LS68jn
	fu/Bx2Tk2T31VWthrr4d8n4ztkU0s+QrDgV2CPFGEaIaufPr0IKqG1gK5hg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsak1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:37 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d194b631d6so40383309a34.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537437; x=1773142237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/GrAB9ZzdxfoJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=;
        b=dFd0O3PgHi8IwQaSMGLqcgBvXH1GWMircSA6WQHfXsV8o0yk+n+GzLgN95xqfnj7IO
         P5Q+XWEpZR+lr46CovyQjbECvxr0TuXLs6EpxxY+mH8krJZj4vqDwGws6LJNRqyEnei3
         T5fzMHfEnP9LtAYt/mDmUnPYOUzQjO39cnDcG5Ux5Xv9TWHLfL99fH5SY0vzA4dG6QWm
         h6/QYHLz9a9vcqZOw89JUo2fWhAy1NDrc/bu69uNFj8Pi5VtsbMPp0CIVl+//jo0/QZ4
         B0GNo9/GYev2SOrFJXcBJoQJJUctS/eAn15iInW3tWIEL6cieLimwJv5HwQSTMIxn3HH
         QkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537437; x=1773142237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D/GrAB9ZzdxfoJdnHnNk8v/UQou0d1cJUOMk0fx5Asw=;
        b=H5ABbNk/pA/5QGUWb+jSKEqfPCuV7vRsbpqzyo3RmBZNDQtd9oogGx7tT+p+ZEA7EE
         8y2DiHVODDapZYs/vXmyBRmo6YfEaL46r/rcKFaZwGxWYKZ3YgA0nqz6h8BMp21Oqbfn
         vquhBL9N+42/vV6K95d/GFGyIJY4DBVl8fyrw9/lZOrcJ0dkOWFJruy4lEUlPNTLNdJ2
         31IYhMG1JYd1Hx0EqLyRMzBANWabvbe7+wbQzCX0Z/EBi8cc3KtaUCPH+Dnxy5xtkqSJ
         Azfha43mjfs6LhyeL1WVLHQRfYPuusE4Pqt/Kf7bL6BVyMeMG1Gx5dXvypoBIPiuEph3
         DWlg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Dk9nGdq5yJpkK/EDdMUnVS8ZAtFJTfmxSxjTMTeyPiyioQockMjrV84vEx/plGll+ZleprgpQLGozKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zpHOEXfs6jjUZDXPFS8fuKOw92T+d9FU2xxOUJSsNPl2Etbt
	wXqQvX9wtinW+TCMOS54DEsV4hY2FayN21nAAJVqRybjFUPiAePiHQyPxFedmDApgdZDg06deia
	0XwgFvtozv21PmgeM39MMU9OC2AkGdOKxpHj1VbtK9QLO861lpzSr1eFvjR2f06Al3KQ=
X-Gm-Gg: ATEYQzwv2yjsL9pFDff7qxP79k0LoyXEx6533kFKekeJDPStOtVBpe9MFRNjn6Tot/N
	Rbud0DFSpUQXaPlJLoNyLVKntJs4I75ihaE5FD3dbAs4yTqziY1C67+A4XEspaJ4s4ci01zYYdb
	D9DTGnx9tPC6n56MlFRzYksdfzhAyMN6RefxgyS1mbpgbnvghK0ZmKmP8EpDCwM7iphPi0BQkPH
	0aWkFsN3C8mkc5rqVPluIcdcCoVIi/wF/4mZ9ZA0/8C3VfU0crnYBjlJ4H+nppiyb+UzeRhwnfu
	n/8QJlBwjMQU8cQDDaG1n6jXavprBtfngvC50Lqik8Vr/DJ2RbN5E6NUQAVM8l4Qyd7A9S0jubB
	kW4urE21qWMeeZelMYtn/eZcFvEdIWM0Vgl3jND72IQYAd0ywO2gFybZQnUGk+1z155ouEzkVGH
	TzFuvD
X-Received: by 2002:a05:6830:621a:b0:7d1:90ae:bc16 with SMTP id 46e09a7af769-7d591b6cb55mr10355754a34.8.1772537436996;
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
X-Received: by 2002:a05:6830:621a:b0:7d1:90ae:bc16 with SMTP id 46e09a7af769-7d591b6cb55mr10355739a34.8.1772537436545;
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:36 -0800 (PST)
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
Subject: [PATCH v4 1/5] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 03:30:28 -0800
Message-Id: <20260303113032.3008371-2-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: SAYQ1pmLKNhV0Dk5lZNP-onfudPyb3nd
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a6c65d cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=agIWOxjPXKrzBStnBTYA:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: SAYQ1pmLKNhV0Dk5lZNP-onfudPyb3nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX1oS7iWEdVyDo
 tzCDEcD1YcRpGB5NkSYERDMEBs82ljXJuP39lGq1KIeGiaKMa2rRC3i/RnXKT5G1VsR9jIzgMbg
 zaYH8swI3JO6sBWIySK/+3fEt9qNmDUqzhkH/nVLuMvUzEm4f692yzLd4fEvggDIFLJeQLLBvAP
 QFZGhgxjz1A2Bx6N21EhX8B7vRXp5B47dd+8e6sCnWBwJf7Yri4VTdfqYwj09ewBMqGZEEiUAIv
 3j4ZBtMaZqSXjLhls4Bh9R8sWro9HdechrBfa9HyScgQ2YablSijQB/lZbF7NNoJr2AjP6apgju
 8m7j+GrT16v6EF+/3IBuMeNOly/4y0p6SmlP91K9EymgRh4oDNpJ7JzXvSqLh+nsYIsXA68mSIc
 0wNYAsnN8I+fmmOcGW0ok8u4+gMqC1XFMa+6N/HzPcKnqwFaAmyBn/qx/r435YeMxloXGpV76Pd
 YE8XzvOHgmu3dC8c6wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089
X-Rspamd-Queue-Id: A7D201EF15C
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
	TAGGED_FROM(0.00)[bounces-9108-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_ORDER_UNSPECIFIED and
check for it when the driver is being registered.

This macro will be used in relevant drivers next.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 1 +
 mm/page_reporting.c            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3..d1886c657 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define PAGE_REPORTING_ORDER_UNSPECIFIED	0
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..a97ee07cb 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


