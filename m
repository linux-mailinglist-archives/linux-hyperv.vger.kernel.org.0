Return-Path: <linux-hyperv+bounces-9111-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEwICurPpmnHWgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9111-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:11:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9D1EF178
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 13:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E9832D5FE1
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA547CC92;
	Tue,  3 Mar 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIFxFnmb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VLBWXVCA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763C48124C
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537447; cv=none; b=eK2a7zFQhTo4Fc4rv3fISdouIB5awbAQpajvb/MPY6+2O39qBZWnrg6KV85xe7VEQWY+FOLX7x47Ye4T2Lb6gA/whvO+oLOCyJsGAKDfwF8ZwTf+IpvongGD2LJXe6WlCNU6pHTXOsMsM6sedz0eBSXzKVI6IvQzWIDoSJQPqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537447; c=relaxed/simple;
	bh=8F7Y6BaHZbh43Wk3k20V9g5wbvrky1vi4UPv8tA+Qoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbSIc8Tj1Am7vqd2nEnIQXQRjd6A2+ULfgKxlf/Juth/Dv1441a9T2ZdI3BAZAxAnj6QvJjNI8yZs5aEwomNMlpuUPBE3ehMhZ34H37SrTCGK+cC9AxruDjkVAzk7wCR3lrAJythRAOOU2FmLea7dqonSe9ZZlPwdmJzSER2W3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QIFxFnmb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VLBWXVCA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239nJSs323943
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zrUsPz7mski
	9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=; b=QIFxFnmbXG6Yb7INz7t4sLwL7mN
	ZVGVg3uC6kBrgYgBPgIyevgE640WHF2F2g6Ee/N8dUy1fhW5T7ENVQf2IzX52DXq
	wGwk+eOQ7HYbv7bK1rTo1NLv3Ob6QwRIJLQ3qZN4qJRQEYNyFvGWtC7ofbJUlk7r
	SFhuOAIAR3sJ8WPaQwrSowQGpmt3NVKshjAAE3SSBORhXHAwZpR3usEvQUkxTt1x
	oCy0DYmoL+NSt4qjUvBMdb9JKiemCouKNA5vW06xuO09/mVHokr6zmrIRsapb0Ur
	PRXp09N3P1i6jXoo1PCoW3eZNeXIobnFjPjeZbDqgzSFMNrU62HoZL+3qaA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmfuw7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:42 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-462a9191720so57525390b6e.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537442; x=1773142242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrUsPz7mski9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=;
        b=VLBWXVCAavQqNYBSiarcekWhWvWHPBaTZPQ3sD4XYEslZgBL02yv8AoUzluEPkNT4e
         dz5z499A9bgTCwIrjcuVvpy89v01emGNV4iOnRjklZiB7zNAnWsGxuJo11nlFll9xttv
         +wemul/Kt9RlmMysA0o54op26WmBLbCSc4ogtaKtTFw2rksbybKm8SDbrlqsvvKM4soS
         JNEfC+m5p9KVYu1sqY+audubW4c90E2JmBp2SFnyOa+ttZzBVTNJ72ugwdzGkz1ysngT
         gO/fLYYrGYE/rpUUtlffpLoTvadGOILYjOHAoZi/reBPrEL9qn5o/UhsrKef9WWzwgIH
         hGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537442; x=1773142242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrUsPz7mski9Qb/OvkgQW1KGt3Ejhzi6jRFHoRkisBI=;
        b=C6rO8N/9yviA7XMPjmjXF/xA+eFesqBd0i3eNulKlPLWLsxOO/km1z5kP6lZYGdMXE
         UXV89YP0mmyiR8LDkW35DaGPV804WVuABzd4NWd0zjRU8QXtwFNHtypuOeTLKidqU1+U
         +F/uJkt3l9rHyBcUbKwT2Ewlzen7/NPH98+rzsXlXa42gviZMczcwAgDz7umUMCyGuPE
         Vf3hrNzVEj0ZyBfaZNJlOKbhydvvPqYZqd7ShMEJmnbup6mFiT/xdSSiC6qciHs381yk
         wL2QYICtjp9GXz2kkLigUEQJJm1mtCjL7QBI83EitXymLtbxPJtg4Iwe6qdDg4cFaP7t
         +H0g==
X-Forwarded-Encrypted: i=1; AJvYcCXysvm1cNzxh1+T565rg+BFegnf2U216aDtngfAJlJUqH+dGzcyp+ZRIMMhe3+RB14FDw5SvPIG84wGcHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnHlCzCsO/4cSeV1W5oYrn8g5145BW78VPvkU/mcxIfnFxncn
	LtWPDTpD6+JiB2InDk0tepUGpg5qA5rl+wEvpmhvjhm7E9WjIM4JelfP8RqP7Dmr+ZCETu1Svsy
	gZkLJV7yQKSme0+ZNbI5B17SBrU41+Bpm+kk0F20ueFfBORMnzmjkkmGzZfbD8mkioRw=
X-Gm-Gg: ATEYQzzQ/ejy/qVi0AFa+E37h38+/kYUyde/pR8SbpjQdSKRy9ban6wtroXw1Gq2DnN
	D3ukpglDmG+rcgKdLTTykL8iZTnebJ+cxEWelsNJ2/3Dv+BJW86Izj1LAcgbT8zssx+zsCkNO4K
	x7b/tb/oGq7Hc0/t2o72SQZQkVy+M6pkSvXpoqyKqIY/MeeeFF4l7sdFGNB9u+uAcz5zn5qhifF
	3GpnNblFbAZTsEbqIppjhn2BKvjEXfDJPPNttuIwtaJ6QlJbTs/xJ5Pq6xZo6NJGexdaTGY/tcX
	Cll63Ubz+sIr8/TsVsF4sdgt7OZNNx7tLJCrIURGphRBGsb88iOK85Pfv2FI17czvn+ORBXjlQE
	IJKEXJigNrrdw3FOnOFH8f8Bb321AKKn7on70d7O3TPD5PRNcSb5BBKnPh3e4i/aw69fcvIC5gj
	VG6GcR
X-Received: by 2002:a05:6808:318e:b0:45e:ed45:15f4 with SMTP id 5614622812f47-464beeffd1bmr9623210b6e.35.1772537442037;
        Tue, 03 Mar 2026 03:30:42 -0800 (PST)
X-Received: by 2002:a05:6808:318e:b0:45e:ed45:15f4 with SMTP id 5614622812f47-464beeffd1bmr9623187b6e.35.1772537441604;
        Tue, 03 Mar 2026 03:30:41 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:41 -0800 (PST)
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
Subject: [PATCH v4 4/5] mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
Date: Tue,  3 Mar 2026 03:30:31 -0800
Message-Id: <20260303113032.3008371-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a6c662 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c6WgzpUFESAvjm-ZtrYA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: Tk28Nvgh57Ner0zawwriphXkXtH8-74l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfXw5s3esYAzWPX
 fhCvyQKzVvg/Mary4HXBl3Kq17TCL/p4gh+JiVlu3684BSJEulE+6K4K1szi5rsf3JMMsq99bP1
 XzZO1I0nAL6+Si7c+1oJZU/W0mDxqPmPZOw7ODgLB8C1oZzj1rpEjACvIOIfH7MLXvgFIZbNj1i
 AceYNLQdWhrGFJ1eRYetITwEYJIdiOkGFSqL3UUzJKQTS+EHxbdjnAWqIsiAvf1byqRia9D33rG
 j70EG9c2IHFJefkmhIYFyUjKxM9Z8FHWR5U+a9/vgMYB5PwggaUybC5TW5N07cHM1R8f06Yy6AA
 kD+PjbCEwDXOM38ma6x7IxMKsgj14LgTa3QxFByepju7FV8H5GcO8ZG3jIqJGYqg0lvIeDVXnQJ
 nF62uk6xgXOtMcmrmDcQ3Ev/VK8nt0r0Jb954+wVcbxmqKv3qhk0Y3ajnS5WwgK9kmDZOiZt6V+
 qmQMwohOMKtesNl0lDA==
X-Proofpoint-GUID: Tk28Nvgh57Ner0zawwriphXkXtH8-74l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030089
X-Rspamd-Queue-Id: 7CC9D1EF178
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
	TAGGED_FROM(0.00)[bounces-9111-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PAGE_REPORTING_ORDER_UNSPECIFIED is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_ORDER_UNSPECIFIED to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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


