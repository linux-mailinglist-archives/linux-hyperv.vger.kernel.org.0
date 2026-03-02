Return-Path: <linux-hyperv+bounces-9085-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNQCB3FypWlsBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9085-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:20:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70D1D75AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A4D306DF24
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2E336ECC;
	Mon,  2 Mar 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7dupRXg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3pxzszh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA23362149
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450292; cv=none; b=ML3diWz449MsQefzGPJsuSMgPwZKOZp0/PQ0htMsRhngZmVFjhf6livU/68Zb2XdZnV4EcMSBFL0fffO4BpQfzkdW8z6TNa+kTZgXN0ptpxFdM91tlgBs3IxFHcQWM7yHh90x/6pfLBdyGEQ6TaYwb9i4jocBkPme/47xZlaGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450292; c=relaxed/simple;
	bh=HLXtTAzPnUYaOa2u23iqxrz4snTgAGJKoQDn5bKXMek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdKzpu1Mtyej0ZnbT1rk4k5IOwSlbzKCcr4PH2O6Wv/gvvZDF95bVRwHbnO2Qta5tmcX7xcKTAwo3t9jA2vHnUhjOIy8sibHKgfg5hjFJ/pseSNPcZ8BAC1XylGbGBohWP6GuHIL7cY4FJeK9MbaiqJVn4SzS0ucFXqu+GgNtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7dupRXg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3pxzszh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227thx2057664
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 11:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9SaV6NeFszm
	MR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=; b=e7dupRXgFjWwN5RgK14fr25qfiE
	ViK+0pp8NQ9Biv6jQfqP03nbbdCBZ23zvXjZZhkSR4P9uuO48s6zwScjChTDoVqN
	cMvhLgEAXeZJE1335THfZvZr9Ic2qSLVrn0RUtuY6CJPhzf1kXzypUmxtVWZy7s6
	Z3Wf1Bxn/rmgK5d08iU//gLwYHSspodfSQeNQv4NC6ruBmIWeKicTQhXMWzNfWoz
	DhfL87Qiiha++Ya4rGDPV3tJW4E+7HrBDSWa6jdr+Yz/fhAg9hjonXDjpkXXZeXc
	esfCSegwQCW3rwELNNkw1Hz04rl1NXOBZ1UqDgpRG+Rh6hbG6A/BguFy7Qg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw64a4da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 11:18:07 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-463a7f204a7so54140507b6e.0
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450287; x=1773055087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SaV6NeFszmMR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=;
        b=C3pxzszhV7oSAqZUx4oU9jlEIO07+FvwZkCNiXSON7naYnYSZ8g0ZCAVpDFEell0L/
         c0QWim/enqnW6KAXGiheZnqxtVnvZ9Wn3x9RxFSsO65bR4IcSOq5omn5XkQnZOIX+P2+
         WmQxzJbzykiAZuoAPrDq91aYgYhiXjd/GJmSoorqZM0UTUGxnF2ybRDUKoxMF7o0HieJ
         7j8p1/xEsZV524Ks8fupQDWCLCQZCsna05tNFVTB82LWmtPohZDiC9tyFMMq7SHLeQCP
         P8ar9XaK+MJpEif3HHTWqIA6sDb1BeHVsteiVxfcxXuRJn6gqjyu5K9dzOs5VHV1QSNb
         XVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450287; x=1773055087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SaV6NeFszmMR6mTHDZ6hjb5x1BYzXavRsIhe+Tko7A=;
        b=ibprrKnFT+FlPlrhtnwjEhltUOexCnkq/wKtbsSAfF2RrFhNiHsvAVohP1/QpgR61b
         FAeHDH+pPlfufz05COPgYzB3CHv7VUOkKVLtLp/4TEdAKO5YIuyRQEpe7OXFejSyRN/5
         ojsoKBWrJHJMKysjeRpduu1Q3WrCNvz7Ub22YKag9ef+4HjuvyWRX9KkMWc2JVHNX9oz
         MGIalcj46juSxoBvyJtWiRF5JrwiKAK2NJpBZbbaI33qnrWf0IjlBSiE7uSWkFmYbSAi
         /LLWRVCiuYmyFBWp373tyyJTn5pXsXM+tv9wrtOEh8LBij3RFoMyOzShZpu5Gp072T4P
         bTkA==
X-Forwarded-Encrypted: i=1; AJvYcCVRBiHYtTcCkohmp10V3aXRT81TvFz54Brhco++S3KyhXd9YJ0h8IIV3mY1aB4Ove1qDkd4Cpa11otxvE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOA81J/BNVlt7ZUDzEZ/hQWAKaUKpMVMvPxY16+iLXi+IRdAc
	mkGXmMz6cB/kBucC9RBeY+ofDZiCJ5pH2Nv0xqxllEj3n1m3V94iLHJTYMhTgKVFfzGDZTF2qpP
	mHEtkOb0jkzgevZFTBkD9FmXfuIFxchFQ37l/kWOEp6CWgb0YZcnmSnvdwrXUoZf5JCo=
X-Gm-Gg: ATEYQzykMgqIGYcxJmVs4s16Ny8qr1WSEqS3mSddUar1a+NDKBY6LtWPnIjY9faXgWI
	BGykfhIEn7gflPVfMyXMVtN2K+IhaAgDkOE+/q8H6+9hCdcdWNT+x4aFHis27pBnV99cqGsXl6V
	Qy0q+Fuky1cke7FkU4sjE2ghzgUR64OloFgJqmDALQgbrr+ncd29KALSEMf+958oq04OblkoB2z
	fRyYE2IWQKdRG0zBX0YN3F7HbpzMOjDqYNGOlA7+GJzuIzT0c/C5Lb7jd23N7x/sv+ZTKBhczRM
	ZZVS8xnAneF20KTsHhf6WmG+bZw19Ejm3rr/Cefgzcc5uGph6D8C9yX4+yC6RWT+/VUa/AQ6Ujf
	W6SQUSM/mCcvepIwGosp1Xbi5znkLigBZZ14FsVXTBf3sLidAQhnun0ANAAhuPNpZFhoUWoMqUJ
	5aTnkr
X-Received: by 2002:a05:6808:1a29:b0:463:a32f:ed4b with SMTP id 5614622812f47-464be9c74e5mr5728071b6e.22.1772450287129;
        Mon, 02 Mar 2026 03:18:07 -0800 (PST)
X-Received: by 2002:a05:6808:1a29:b0:463:a32f:ed4b with SMTP id 5614622812f47-464be9c74e5mr5728038b6e.22.1772450286733;
        Mon, 02 Mar 2026 03:18:06 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:06 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org,
        jasowang@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
Subject: [PATCH v2 4/4] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Mon,  2 Mar 2026 03:17:57 -0800
Message-Id: <20260302111757.2191056-5-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: --Dgy0HiMnCuOsAH914ZCQiYnDh6oIEN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX++qKURNktHCi
 6BWK0h9X1c2VE0RqNh9sCfCP40AqyEQ2Dp0QkZZawG1DtTP0Gv95r/KKH6+e2eH6cC9l5U6c7iH
 3BnkS1qXaA9hY7wCESxdDk10aW8rNQh3/rEy/sqobdPPeLRVrTkVkWrljzBps7sPzKRH2W0Fxl5
 /VFrYEH/UxQYcXsE75rX3PU980N+Q51bPKBmUaEYksm+hjgMRPn44tULfGggQmGL1+7EBLUfTDM
 fP1+qIinfEen9TkU47Tg0o8HCN4VfD4msKJfnxf5W8Cbz3vzo/cRzDOOrtI3xxhMKx10Apq33Op
 vPaTvZlGh61znfK+LatwMKxYa+hRpmnZ+4h2OYbQ8qs/eNU9Ek3wXk9BtWm+bWLTDgZ4z00QsKk
 /yn26hHBunFwgJuhhI/UhlBQ7/i4HC80HyJMGGy6zkXi0oc+LTivWct+X36WMcCki5RC/XcdUDY
 aI0xY5lduBFDRM0Sl/g==
X-Proofpoint-ORIG-GUID: --Dgy0HiMnCuOsAH914ZCQiYnDh6oIEN
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a571ef cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=c6WgzpUFESAvjm-ZtrYA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020093
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
	TAGGED_FROM(0.00)[bounces-9085-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D70D1D75AD
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
 mm/page_reporting.c            | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 51cd88faf..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -25,7 +25,12 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
 
 static const struct kernel_param_ops page_reporting_param_ops = {
 	.set = &page_order_update_notify,
-	.get = &param_get_uint,
+	/*
+	 * For the get op, use param_get_int instead of param_get_uint.
+	 * This is to make sure that when unset the initialized value of
+	 * -1 is shown correctly
+	 */
+	.get = &param_get_int,
 };
 
 module_param_cb(page_reporting_order, &page_reporting_param_ops,
-- 
2.34.1


