Return-Path: <linux-hyperv+bounces-9112-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH1ID/3JpmlOUAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9112-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:46:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C981EE6E9
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2658B30AD918
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E59439019;
	Tue,  3 Mar 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="id+ozkJT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irpSKSUB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890847D936
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537448; cv=none; b=YbnPQYP3Wf7FlKNG3obLaX3sTOo9uHrzkt4oWEyHhKr6TsCP7ixEipzRwu/yr6atMNflVIPJ8aKLMiexex+xcoFxV4hsaikQtTMKMy8wvM4qseM7jNLCayQVSDl+T+465cZ6D00pkNkDnxKRf58PHSuSLugTI1mDwqW4lVL5pyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537448; c=relaxed/simple;
	bh=oBpfbKj10n5yNd8WtYy9cLMMHVSFy+UXcU3wOihiOQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mi5Qxr4gMEDpmdmUj8edXLXTTl+vwdoFvER8KRhZayoyO3w5G5gaW2IjTZS78iSRysheFr2NXN6mSsJNr7CpNXoKuAWW4f1V7xn2kUXLipzQGy6AeJyblIpQAvZw5a6gyPcd9qx2vwVjC9Ix/F3idoWz0Mg+x0jT74IKeYhC9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=id+ozkJT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=irpSKSUB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239moHw2307603
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gb6qHftYG9h
	3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=; b=id+ozkJTpWHaKiJG2P5abPU1gIt
	EhpdCcOmUibdXNwCJ0AtMxlgc7G5ySfRo293tPyEecOjmB8i2a4wSmcp0zduPcM1
	tr6H1BgQbeagyVmjyo5+RylXDUCWfNGKgqUpS8twb4RDp6WJ5JtD72h5JhZr2KAd
	NgbjmyCWTZqPE1ScEIullfIdfyBI8QbiZfY75aCjz0j2Sjl6Ohduyto0jWFfwJr9
	gLx1jt9TW3ae4voVVZ+izlnW3Qj392AtcJQ0E9yPKuFdYGKzGAryNStJ1RfxhOw6
	TTlpj28Z7IxQ25l3WMIYYBSlB9onRdEcA7dC0w+hcxvr60uIg+oKORdiMKg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtu8dwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:44 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c14c60faso58645870a34.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537443; x=1773142243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb6qHftYG9h3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=;
        b=irpSKSUBE0USAwCuZnD5Li3nv8IclEqxPE3c3XViO1pfiHxZEByRQ/mj1tmkt3z4XS
         yNcJRNxrqa6XP9YbXLhVPfZ3cio8RsFfjbWNOsXUles6bM14wPOtbXBw5xEpObhUT5AV
         GOlhvYYBqG3kCVBLDfQ+TGs5Yl2qROTanm9pwthLCXg0MGFjtZ+xbmRVvCDHVTeVxHT2
         rgHZfsqmVqFw7HP24pN05KXJciIGtCvvwZ+h1N5ORNO+/GUyN7VpfueMNVBuVlyuQyul
         GAb5vCQWB4F+NqlHHiy64eM7yPDQVJomHlv6Z1pAk6DO3GSFgBBwt1xXKQTpdTExKpqY
         0x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537443; x=1773142243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gb6qHftYG9h3/gCtPEjrgXaiMu36521aS4BQT1QUR/o=;
        b=dv9ipDgaJZECzGe+yYZt5sFrtfEyXoBrnIi6prBy7O2Ck6JYUtkbsIhrTw+/tOLHEy
         ifBzFXCL51IeJnSQniHDtkCVg6RSUNVMp6PgIw0gN8SGwI0bLFY8rZ/lPwsITW7lWunP
         SvyfzmiUUuzKm75lD1fBhE0tnsL/wMJZbE8wp0YpKCTTKdwI1u6CLaE51qH6eHlD/Iu3
         GErfeXhcP5qLyt8VWqBIJQJLkFGYfJK99kdyTuflUvKumEMECXnuLiAniECgIC/Kd2uR
         uHT4gr4Ner6zu4koW0Pb0uVmw5esvuMYoxbLsUjRvTEnn1D/I6T4OcfPZ2sIWDmmXsui
         GYtw==
X-Forwarded-Encrypted: i=1; AJvYcCWRfuUDU76i8/SHxWFEJ2XAfMjx2SdOmxhFqVkyv++vqbDN+6/ox5rQFsniOLhuGjLtkyorhrqqz9tSNZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmuzIoBuytB0Pa1Au1zXXmwzqqVhWYUp2CjrCjX5Htyr8Eqs1
	5SLx7+5WesRNP1jfbuRWL90lMoEoIMjT6evx0ZaeH4d9l33ccpoNwzBUgddN1qhj5bpWW4hTfXV
	nPTGv0Xizs2+GO02puPw+zdFXrguIEir8xgZ37VLs7dnQC2zbh7LkepnN6PKfcUO/9Z4=
X-Gm-Gg: ATEYQzw/AamzZOt+jv8dhQfAhnrHEHRQjDLliYSUpPQpX9ET94OlWNuWicXFbE34rAy
	yOyzFvlMqYdVn+gnnV4BPfPprqWfCNuRgTiMn+1MEbm+7Xh3AQr2HMflZp5K3rE1eulEgfvu6jz
	AxVd8f9wJyUze1m5yueAXb95u5ly5NJfM1FXbpo0ArYS+WY8inAqfNirMJT8H0HoTtWf64t2HQF
	iO7dS2r5h99rEus8sRnYBeYhju+Q6QvKWTNqwaTy6ar3C1b4xu8N9qZZdXspQVx8pnyBfGTzz5H
	giEUD11oNUTWH65g8BpoBZgPFJdkOIsNEQDJro9MeyYvCICSVgLaRLAXxmBZyZoJ91c2yLGUjcC
	WRknhHj/qsAi7hDuRfeff3dybs5a0E0/LqNfMrjxPDytrn6uJzXdQ13L1f9ejGmOCzvdsWvKwrB
	kJNiL5
X-Received: by 2002:a05:6830:83a4:b0:7c5:3c7d:7e67 with SMTP id 46e09a7af769-7d591be6fe4mr6865277a34.29.1772537443632;
        Tue, 03 Mar 2026 03:30:43 -0800 (PST)
X-Received: by 2002:a05:6830:83a4:b0:7c5:3c7d:7e67 with SMTP id 46e09a7af769-7d591be6fe4mr6865268a34.29.1772537443240;
        Tue, 03 Mar 2026 03:30:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:42 -0800 (PST)
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
Subject: [PATCH v4 5/5] mm/page_reporting: change page_reporting_order to PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Tue,  3 Mar 2026 03:30:32 -0800
Message-Id: <20260303113032.3008371-6-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-GUID: VskmMJ_V7QLIQFMXvdaUHYGulwfsOlGX
X-Proofpoint-ORIG-GUID: VskmMJ_V7QLIQFMXvdaUHYGulwfsOlGX
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a6c664 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xOnWzZm5OySgNDGUUPUA:9 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX/3OhRd2muDwO
 zWjc5fUVa9fkDrIx1bFRtxkpfDoutxHEoE6WihM1oqa3rsrxPzJwKHoQpMaGm90PnlTqQ6fxiGr
 S6aFYk+SShIr+SXp+h4Hl+IepJ9rOVrBAAi5pMXHMc0OXMSeYamkZqETnL8u/pH8JANEaJobxTk
 /D/VFVHvXIT+XA4cm+HDJqUnykVByzfNs7GqG9IGVZqbq0L3vnXoLNRSmoS7p/YryKkLu6Q8syn
 F/j0FEGqz8FjwyhNTkxkt7mhfdnPJVZ7IzWr0W6ShOyz9hhEITzrLTz/obK/tbB7Yikv7SdicuH
 nuRJHdcT4PCzG1aeByzqPGFriq3/6EeLe43mGa4Kon1Xt+JCd7GWg/fnPeZ4ZlPZGswzk/OYVZ8
 clR+eBIWO5MXTqZBX2cxY3aDU+mnJ9LXsRx3rWckN8KXAB9F7UGdsLfxFx9cALKSWqYK8kgDGIF
 Agp3ANIGNJEqINa7lEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089
X-Rspamd-Queue-Id: A1C981EE6E9
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
	TAGGED_FROM(0.00)[bounces-9112-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

page_reporting_order when uninitialised, holds a magic number -1.

Since we now maintain PAGE_REPORTING_ORDER_UNSPECIFIED as -1, which
is also a flag, set page_reporting_order to this flag.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 mm/page_reporting.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index a97ee07cb..21c11b75e 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
@@ -369,7 +369,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 * pageblock_order.
 	 */
 
-	if (page_reporting_order == -1) {
+	if (page_reporting_order == PAGE_REPORTING_ORDER_UNSPECIFIED) {
 		if (prdev->order != PAGE_REPORTING_ORDER_UNSPECIFIED &&
 			prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
-- 
2.34.1


