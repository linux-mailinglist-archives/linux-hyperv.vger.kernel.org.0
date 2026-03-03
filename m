Return-Path: <linux-hyperv+bounces-9109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHmGHOTJpmk0TwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9109-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:45:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 182321EE6DA
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB590308E86C
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79D48125C;
	Tue,  3 Mar 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbOV+ITG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QkEZXHZH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EFD47D94F
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537443; cv=none; b=SZS3fhX+EAm+V8c0wMdYu+pTXOlnjyuuN1bHbBwBNX1OB0MiRM6G7EMh4yI5/cOtR3MEsEPaJITaxkirMYZq6+e2alIaWJ0wmjULhb+7bIZ3eJNiv+z9r8bthBn3e7BRGe2Xea558HkhCMdBTJr2c1YNCSOzxcjo65P7E1eIayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537443; c=relaxed/simple;
	bh=YIfiGg54wHsEWICe5AuZdm92KWtiix1jjDHpjH1udtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DnDvBm8VpZ7/FNx3RvpiVUfXZJAii5MgMssWm4Owfu85bUaDSYt2TQs8U9PeHRyfCy8PEh3Sog+hDczDI1IlQLlvpGQ+pGe7NeOYpQKg+yq8sdR+cUIALAMdxpvuQTGiOAG+eueYC4k6Y6za8REtKWxaxehvLBCTlptYkmTm+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbOV+ITG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QkEZXHZH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239ms6b3099704
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7rYseVkxS5+
	KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=; b=KbOV+ITGzgxWA7RFsNR5bM1JHaM
	4/f/favWm2i73bz0g03m+FpAdqs0yTsVtyCMRuqkOqHyS/3vaNWJ9+FBVUpGUkZn
	mk9smX2Iuwo/49nl41OzGdv9EYfYF4cyVguSF0vYkGP3r/vf65p/2Yp6uAOKlo0J
	zhwb6KGAPslXzD0W442CX0I9vCNRPkxgDF6lOyrm+n1tuiGDbIxpp6ubGpyaIqEE
	bIyc39j6xESkjgt6/GSXgtVPgnGNtHSA/CgJT6N+FEnsvn6dXZnRY2FCogg05Rwa
	11RxwRHPdOEpOcK9SQZLn3N3jqQRFajN7SN25b/TUGuTOPQIC1sua16Eyzw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnuqu0pwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-46335278e7bso110781663b6e.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537439; x=1773142239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=QkEZXHZHjgkl9fmmHe1+CQH0i5Quc4GIksqPC04FTMEwLwG4Iyasl27/sYQlK+yaAF
         3R5PEWAiLJZhmO6vrylo6jp7b/ZdF+We9lHIBQeYaJqcK6FiHhQC7jVCt8eIH+taHPcR
         UZU7TjuUCNv8nCyU1m6VfxOEoElYhkzkp1+e3Ow8O/VnrszOyGTa6/z9Z6UuO/jDhwSR
         IAz8nvHZWq+gzdmcVOYrXVaRSzvzFo1NMtIEmgTz/5aD/6ac0PWygNAZNdyASq/1wMfx
         7huPopC3jjIVLRuy6iXAxIYWDTb5BnbwpIc9i4/J3ynhLzgpt2+758aiZCMai31S1d0j
         ASNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537439; x=1773142239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7rYseVkxS5+KfcyGe26QQjJgka7f1dcyKVc/ATKtdbs=;
        b=XX03nR8XQSGuHVHJ8TyrYKCxVUZL7dC6oKJxBkdpK8W/CLDq7Ypmfnhr/D1ByRmmGk
         EVH/Tr9/Nsd1MZ2QPQet3pteRe2LVGGaekaAzToa+sK45S7ZZcYLCGLRjMFUU5JBN8r6
         Fa/+ySeqm2rSYAVVFyCs91b7hj0jhRvjuwLTiyQMecNZGDLi3ZadRwW8vmYmTHvNXPf6
         EpixB5qKxHXKNuAwy1+h4JNQTS9Tc1IojkVb2F9kHJNfhjyDG7A/ld3DYR6IU5djqleh
         g9mMNkuF+fJd8+y6zSQq1BSwNefIJUoJV8H6kM2TCmGPBswtbLyMvgpLDdpp00yFtsbT
         J7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXeGaj8vzHHFSrzo2VW12aFpJL29/t9mRm8R5MwqEiW4QxfIhTgm1n8CzXCOsJL/A7jbsxvtUqWKuCN528=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8Rx963O5S9P6tgrHdFZrsYY991x+/ZUQsz0OtTHJL/2jpkTj
	jRzcd9tl3LK3CUPZC348uNm2tXNugSKhtFOxHS3wbdWL0AkIrEJ644zDeijCaZpX06rpRwZPsu+
	DpI2Eqeg8Tr+9BXN9A6apo13Hrc8wwOeDq58H/FRc4+xfSMlvAypnMffAxphR9vl6s7M=
X-Gm-Gg: ATEYQzwzmLeTunymlygqGetTYUX6QY5dCzBdgr0F7asaGUEtQmh2BzD3lpq4jCPSGEw
	/brMdo7zSQ32IYKKvLv0OEcB4sodLAUvDGkDgXIwu041odKFZLl6yC2VesWC6FYwntkzS9OdOYy
	ckwVD//8BzUSmM2dE6YO5N4wypTHYQ5v46Qvte54fpohxlbQNaMpDepygzuooQ62KcIojztVOM3
	4M0NmJB9f7OIUCMtrihXGFz+1AEwu81V45WfTvTHSth4tSAKTxGPOpu7Im9vb7HnnmqfHWUNgST
	F6wOoOWrRLHVQ3/2Bgb0pgkVQqZ+3YytCq/GypdRl8qZhVLO70wh3VcqzxA3LIjUQsgsSRyc4ee
	V0qUpkPz69RaoZoh2oajr8OH469CCf1Wuyf0uBXh0JZCL/x+TBOzwVJosMJSyzkBXdyecIhNqkz
	zxqN6H
X-Received: by 2002:a05:6808:1206:b0:45a:58af:fed6 with SMTP id 5614622812f47-4650c7a1614mr811602b6e.17.1772537438680;
        Tue, 03 Mar 2026 03:30:38 -0800 (PST)
X-Received: by 2002:a05:6808:1206:b0:45a:58af:fed6 with SMTP id 5614622812f47-4650c7a1614mr811578b6e.17.1772537438134;
        Tue, 03 Mar 2026 03:30:38 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:37 -0800 (PST)
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
Subject: [PATCH v4 2/5] virtio_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 03:30:29 -0800
Message-Id: <20260303113032.3008371-3-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=M85A6iws c=1 sm=1 tr=0 ts=69a6c65f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: 4plrVxUL1omslnOJg9Xh1_m6_fRZqaCU
X-Proofpoint-ORIG-GUID: 4plrVxUL1omslnOJg9Xh1_m6_fRZqaCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfXwZXA66GMoj+5
 1lKwFgGUnHjZyM496NFsfGU/A3rw8vVzkDwZTEChnBUovQJTBBO1EFNm0qt5/GHyWDNwluOG/Hi
 5YgnQ6J1fRBPzlmZA+zHJubcfElefJR2MeCapPIL1DZJ3lEeq86vsYIhepx0PqCJyc3I0OKdf5v
 REMnuzzsWLVR7jst6EyjDSzf19Hf0xvHvHI0M68EsBB03SvjO5EkNUyhjAhJ9VUFqkGP4e+7HHi
 Ru2yeklRJr/rIuPaFwO0QAV9tHUeGnGAEf9nrpoNUsw1kE0RYZ7v1p/lmy4Z4NgpijMIDQE2GjN
 1hxwaU4L9CukNTWKxfePdBQTsl4UtfOQyUZhw7BI8CBP+T7lkEoEfz0HfQBzUB5wIwwW54cjtAt
 rdF21QATRR+5Dhfesautq+1mUpPHU15eoF/Xbev0V7yY8WXXnf4pDOqDGeSg77tTo8T5RW+QjRE
 7c9raZOOOB8kTCk5qnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030089
X-Rspamd-Queue-Id: 182321EE6DA
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
	TAGGED_FROM(0.00)[bounces-9109-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
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


