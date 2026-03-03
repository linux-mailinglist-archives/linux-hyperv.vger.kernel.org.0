Return-Path: <linux-hyperv+bounces-9098-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B8TEQKrpmn9SgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9098-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B171EBEBD
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E6E0304F206
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0C38C436;
	Tue,  3 Mar 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJ0tq9jf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4YWp2Vn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1438CFE1
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530429; cv=none; b=uTeoONvPE2KTAmVTVUwvxr6UWawsoRdzXpzi1UtchGOdCgRSeqj0FegGcoHqN0XyJOnMTqBSXDxbAz2gT90BUByrx3Ns8BWyTrQ+hIVHINvZ/e78yly3dw7mW/cKX36jdp7bu/dwJArOqF0yszMqV/R3vOBlRZ11uqmRJUiCzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530429; c=relaxed/simple;
	bh=wOBwbbCEwwaqId+Xz/bRQyO4PmCTMWcuZ1ouSKxi3+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/3/mBO3RFije9jvI0ywNrqQR+eO44j9es6rz1rF3KTeXl1uDAG+CufVzn7GzHbmS7Sz551dm/xrkaA+m1OD3CueQG6V4FpHVWxa4GMw0+bYqtqFRwtPXmy0Sv+QaYaEF5YwcgGpBXFelOufT+Xg98DeCP1vgzLzHsCXoihk138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJ0tq9jf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4YWp2Vn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62361I5p1675510
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CezckF6fL+Y
	K+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=; b=JJ0tq9jfMstclY10VCwTW9P1ptQ
	f9m+RBSQy1XsnT3+jgUuRjk2wkFP9XnBu7C1iHr/sbRyOAZz6yjdYetGKX/YuEUi
	ShjsiFYNUxlJLhf7Ht2NtdkYKjKe56SO6aupKdf/dlR5ryC9LixuE50wc8Aq5b44
	EXSgYTgnXGWoZyZgstaIIVGg01CAk+T+pDhaVQdzGE/YY4o/0BHeDbXg6+PJCOpx
	OcL7jTooBMz9xbTAQMebBevY1OIsax2Da9oY9QW321ysoOFBSlxaW+/zlPgctwCf
	oLD4vZfoDqzEDhJaDIeOuBIcJ6iLKh9FiEOSeeoNUTiTXXA/9LUEjqpKTPA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsa7eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:47 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67a04fcd7c9so23502107eaf.2
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530426; x=1773135226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CezckF6fL+YK+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=;
        b=B4YWp2Vn3DCNtHvOdFLU4iZzUJ85W44PudJC6DSy6Hm+AFyvmGueh0FbJXIsjTlDXb
         x9OyUKqfdcuPraG3GiMnn6RwlyENeSFPRkhNlW+xNxItAvwpG+gPmq3l60e6P3dbxo3d
         LmOmwuM9cZ/nyKX5NeOwDfoha4gcdHwgxcJdiDrBicgUhYsi8I7d6aqgkGOq4qyhdmmI
         mKkZe99WTTZD8k+4ld2G/AVKnKdRh4lEtjZW9+UtqtQzaMwS6pZeZyF2Q2XN6DSkrOF4
         p6dds7+N28aEpVDMVGEcpClSMoBgjKvRdJKNmCYBLgbrY0fvzc1ag1tbLuJ6ATLbqHDM
         DUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530426; x=1773135226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CezckF6fL+YK+N5ZT55E1n8JW8aI4FRVkbKEmz0I/2A=;
        b=GirNrFW9y453M5JxutiO4mMlTRcbxipElhjj4Lphql1WpMTQFQ/m9W4sJ45ODyfYjt
         f1oKxHmloraG2IJM1KVj9FIu0WeU+GtXuWCIUeXdFPuov9WcHjNRZxgzvFUogx4Qn1pD
         jdhQKT30QUBHA41GFbwjFuSSbNEc1b6qoZDN7GWYNFxS5fd//raRcmaEFh7xr8RZQIkI
         8pnaBCB7IPqS5yW+njij55k9KUDNDdPQiIjqoURzAo+5Ybcnac03P8URZPCv56Zd1Hvq
         oRsnh9INQ1ndfvajnpYVG7gMRM/KAL/PLM6r3kpTSyWU64pUU1wnCiEcV/5A1Buf3Oy9
         66ew==
X-Forwarded-Encrypted: i=1; AJvYcCUnSnRb00ep45eyZOIsMkvX9wOhrPn1OcYWMGbvcNKglUZ2WLA+2HGZvKSoag77IGrDaRdev4FuswC+/Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftV3gO4AZqu+oE9zfgCqj6eB7bLP+dADSWSs+9h/Ke+ksBvx5
	heQydqvJwopdYv3HKR5qiDLVZQEmzuSmwxs+F1MLIZOI361sfwIRb4WkGlASQEMiuDM2/5oAsCU
	Eanz/WAEo+wDCHDg/kB0CV7/0mYnD3hPfumEDuUEt4ztbDI6HQ1zeFw6A/i1OPdseg8M=
X-Gm-Gg: ATEYQzxqVQEO9loARiHE9i1fJ5C4rvbLXT4ZcQN5xn7OqK8XKV9mbjMYIQ7VkmkbvoJ
	AkS/c+YpziOr1wzsdbQECiiVy8BQdl729VTr2WBVAjj7aJxMzajuMHNrlz0MV9h0vhAa00BavQ3
	hkpBlFdlFEoREeNv97QkpQVShzCrfZ2zpeXjEAIsinHTzPj8TlkAEZJQSbCoEL0saxgKCi3ltFm
	PcaojiTiCYmiFsdisV3rEYdfWcccFpaiw885I7sFEVNEVtzyDufQ1pAzohS7e+E7j8FKLbFBPqv
	hcUeqIU45g1M678Y5dcKHZIA+WUwI2P5cK0d377wQ21S1Jl93GC1DlOFb+g2vpfB7VUYkYnxBvW
	/CEMJgLiCQ13nGT+SpLtoAvnmed2Y6iGPOaBCI05jsxl5+ptE7RbnshaPKMGDwoAxxPac8Qrjw5
	K5MF6K
X-Received: by 2002:a05:6820:818d:b0:679:8a47:ab95 with SMTP id 006d021491bc7-679faf9f2ecmr8558573eaf.71.1772530426318;
        Tue, 03 Mar 2026 01:33:46 -0800 (PST)
X-Received: by 2002:a05:6820:818d:b0:679:8a47:ab95 with SMTP id 006d021491bc7-679faf9f2ecmr8558564eaf.71.1772530425942;
        Tue, 03 Mar 2026 01:33:45 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:45 -0800 (PST)
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
Subject: [PATCH v3 1/5] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 01:33:37 -0800
Message-Id: <20260303093341.2927482-2-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 2H9oESNOnnYyW1TFpitJ3lsww4hkBdDj
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a6aafb cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ohdZF0R09fBrv2_F_REA:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: 2H9oESNOnnYyW1TFpitJ3lsww4hkBdDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX2PSq+CpQKxC1
 Y0VvMu8KSL7DI/yZYAEC3KbGJnvvTBEWmIt2bhL24L0kgcEggB+e82xHBT+ZzfG0S84roN09/CO
 dN7sRjVklFVjsziPHN4I7kOGVka5cXqV01QkC33rV72xfEbMZCXZ3q/1NnPvNEKeKRaOaS+IitX
 iC0IswrXYQENjoVeduFGGKI6euH2yaUgOyvC2nCNF5nbjfBVK0SSXOgdvpAwdEmzIyuQRzURdxm
 xVwfbvyg7kT8+/AGEgWFQxmjC82SgBXz/x1tN2wR5BILNM78CSni5N8elvOa11F7zmz2ilN8+ox
 qPo4CEabsAGuEXShpEATX6cdWyWdthvYR6U7EWnFwjnm11jTPbCdYy6AT2Htmw6cR20+e6cAZOs
 tMA6fpGMRDItq5WyqziD2zLnF9lKKkHWvDw4tKdPl0LfeyBMpHyvZmigC7zUiiOnm/PD0cZNvu4
 uCORHsyjKu+++bKyfTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071
X-Rspamd-Queue-Id: 08B171EBEBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9098-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
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
 mm/page_reporting.c            | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index e4c428e61..40a756b60 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -369,8 +369,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 * pageblock_order.
 	 */
 
-	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+	if (page_reporting_order == PAGE_REPORTING_ORDER_UNSPECIFIED) {
+		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
+			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.34.1


