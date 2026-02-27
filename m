Return-Path: <linux-hyperv+bounces-9028-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDcYJQepoWm1vQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9028-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:24:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DB1B8D4F
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED893089561
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B449421F06;
	Fri, 27 Feb 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZCZ67n2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cQzJubdH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDE421A0F
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201225; cv=none; b=l66r5qn7v1f02jI0Ts9dn+MrwOmZ+iOyMIcml9GHQQPt6TQqDI96XxWUbzHo0vIGSuFFxiX8N/q7t3e4BmYhxniJt8t8PsmStNwiHiF2ydl3nJf9qm6XP4FwCgQl0Ay5QuvQF3t1v40GixWQqrCqlPONTFUdBdhoClxnF9aNJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201225; c=relaxed/simple;
	bh=Zfj3mi4T99ulY3bjPSNEIIABpDCYHarnUQWquz3SJ0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfvU6CRj2vSo5bx2rC4i20ziUDk48UqVgdwTmfULAZfkz+HGjw9NtlHOcpO2MUQbgNk5VJNMQLoc2XiAPlTy5J3vUSIcRJ6r+RhRrk7m19lSldW2G8NMaQedjlyu5rJ8GFvFLQ9l9NrQQRY04MLh1rPsJDGm0jU6Kh5pJpiJ6fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HZCZ67n2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cQzJubdH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RBi9n32663269
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hiLJ34i16BM
	9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=; b=HZCZ67n2dWR6CiBijqDWsFZ6epp
	ohL6zAH3hzMzniM+XkdlZ8UlI5X+9odr5MoggeyoFawVDDR1YIMdLJVIvC7CeUGe
	Krsr9CeYzl0Xt5aaLBy/Unonpg2wxVGOr+o9LGUusE29TYnj3fDvmsnk3ovZqTrw
	wVFjggRmMNz4OpL3mauQ4k0YrhZq0xRlfs37XyvaQc7ntGklcqQYAtLvtG9wtmt2
	jjP0J5vPo1f9imAms0kuRTe6uoOsYYWYljO1WfMrt8Ce7HQeKvhybQLGIVu0q6bp
	Jf04CfFCa6lp8EdY/KQZ4mYsgbO0xAisST7ADe52ukKRHpstzBwox6bIivw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck43r9sfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:03 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d498212845so11032697a34.3
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 06:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201222; x=1772806022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiLJ34i16BM9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=;
        b=cQzJubdHB4u64K1KbAe5pEBmoYObF1RswWRLMA9VYjAVpF/C1Rk6USgoeuzocB1jlg
         yyeJ1v+s6rsEiwmad0lH7eLuDmHski8aVNsRn+524xWlA5n6RWaIMBdVmc01J4Am5rxj
         4SLVaXqd9tEpJ1Gt9wfCDs2vbAeXXyy2ZH2qlfLtP1UcS42nyokoHryemC8A19PHmt3Y
         F2M/ltNXQX+Xb+W5CUBPXm1NQJUz4eZ/RBBgOD6qupktgjvRX0/k1XLVUofDM4oQm0Km
         pG0ALupw/8hIPMzGDf2qqXihlrbPa757CnTCV6oTmoXbD+zsldDLzHtIjRkNf9xj5Tvk
         70og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201222; x=1772806022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hiLJ34i16BM9bLJjsXt2y8E6JkcgWXHQvTr9UwVPbUs=;
        b=cCwEMCNgUzxOq6B8L4C+mIXsHUKqxeRsl3iSq43WnKJsu6J0fGmipTgQmEIQgVlBIG
         dYxuMzol2XDy+4VGnm2Y4zzhOjp+0EXKTTQWpT0u3dov8kIrTGzYjzdIZiIcqaRVkLmi
         BWm3lVYtbOoi65VTebtYqRtcoxf+6hqreRKRr+Bb70oYbK3jOAPtRvqsSZRD4iSas4ST
         hbSy7KNWQc5Yw8tQBUvlh8Bjl7YHD7aSCiIr/fZFnuwsvrc4c45tYf+X2o1yE0XTAjcH
         lx1OZaOq1Nd5yGa/doqGycS8OF9Q5vsb2TbkL/wlHrcHy5WIYm5JY/piCUnGOFiPXASG
         ISbA==
X-Forwarded-Encrypted: i=1; AJvYcCXbbp26dinvUTd4fvOP+V41gBR1pulof0qbaEbefZpZGcle27cfk/hZ5n1osi7yBgCMCbbEaZRAk0nz9vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbav9Q6OiETwknUaH5BFyPR8zdtKThr2PQ1qRLJcPIraqcUFh6
	zs9ALpx7cSrDdjRZGK9y3xIzmKwZjQCKR1FkxX5OGJI+kNnVn3HvwDo0o6gnRBGIjsABek1EqfF
	Cfk3FdW7EuPYvN8AP4v+7uC66FrCfxCtDAjbTrdvaDcomk91dZUs8IbRkOssqd84KLvQ=
X-Gm-Gg: ATEYQzxhjLRm89cpUijNtVa66pXIKcKq2BRi1itpFQgC4ngbfaL75pjhvomYeTNVcqs
	pt4XWKpPM8vXaCfeQSy1LY0uLVir0v++HYLROAQuEPMKTLnOD9GBDO18Wg2YSglD7d/mvUwjkXH
	+NmS3BrYZGjLc4YH4CcJmO4uGOJoXV5iN4D3Qziv2dlgnDTD92fG5i+PLXi7B7hcYVxTT+RiVfn
	+1ZnAMxcIGwilSsvz5SUvUIcH8JRfqHQol4i0qFR0v44ONzLYpanOkKAmNg5OEc5VaijwfvZAQp
	EDdMplmvlsvwQ5PWJtAIqumloW5ELk+G6NaXWlX/WAKLlI8SvhIjdBU+IHZ78K9TyrcZDlOqvPT
	J2TpHbNKQX7B8v4Y7AOZU9BowtaLuP8JMRTxkbbScTqbKJUpLXva65XvnrsIVkp2+FsPKR0Elns
	TvlD8n
X-Received: by 2002:a05:6830:718b:b0:7d1:94d0:e8f1 with SMTP id 46e09a7af769-7d591b2ce8fmr1792329a34.15.1772201222414;
        Fri, 27 Feb 2026 06:07:02 -0800 (PST)
X-Received: by 2002:a05:6830:718b:b0:7d1:94d0:e8f1 with SMTP id 46e09a7af769-7d591b2ce8fmr1792295a34.15.1772201221840;
        Fri, 27 Feb 2026 06:07:01 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:01 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org
Cc: mst@redhat.com, david@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] page_reporting: add PAGE_REPORTING_DEFAULT_ORDER
Date: Fri, 27 Feb 2026 06:06:52 -0800
Message-Id: <20260227140655.360696-2-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2dld4P2b7svKuC8fDeajZ9bheH7_2cgI
X-Proofpoint-GUID: 2dld4P2b7svKuC8fDeajZ9bheH7_2cgI
X-Authority-Analysis: v=2.4 cv=DOqCIiNb c=1 sm=1 tr=0 ts=69a1a507 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=agIWOxjPXKrzBStnBTYA:9 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX7Ql5SA5cVtQe
 fGC60CcMh+JcYQR09UFqXLdoXGAnnsxUKPpkY6EGNR1c4SH2u/bESk5SOD3agRQInS/YE+BbZ5z
 FAaydNymzPuCyG8AzQvflfxgI8tGb3ysNwk2b5hJuuGED5FrCX5oLOU9uTrHcbaDGRGAdA5yaN9
 BihcxFVIa6fOkwtfm1W9xb8fxjHBKocKbQBjJtBmKzwyO+2lnTYWBsSRhd38N1Kss1p3Rs9qjAG
 FgUEobN14sG9sh3Q0m1ruSq0v0SyPaMV+MBbE1Rtqsv8VHRXcqjCj1dEmwLn4uxluDs0wwQLpOf
 PLysrIWql/6UsvWD+RSggbt9oHXcRnkIUM6ACuJ4ea7dkSu+khc5YmXH+qvs7dRT3lshXwdTQqK
 ENyvaRgEO6Si6Ykag/vMbwMss/bzld7Y1OfgScR5uwXkPSzsYX0QHMZ+UBYI+IKk4iZvnakKBwB
 BISLqlOpEfvZEL0z5Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125
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
	TAGGED_FROM(0.00)[bounces-9028-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C0DB1B8D4F
X-Rspamd-Action: no action

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_DEFAULT_ORDER and
check for it when the driver is being registered.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 1 +
 mm/page_reporting.c            | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3..a7e3e30f2 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,6 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
+#define PAGE_REPORTING_DEFAULT_ORDER	0
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e61..9ad4fc3f8 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+		if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


