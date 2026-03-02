Return-Path: <linux-hyperv+bounces-9082-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O79ARZypWlXAgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9082-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:18:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D171D7577
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E83304A584
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE52361679;
	Mon,  2 Mar 2026 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa59O0vF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j9Bh4JG/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A4361DA9
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450284; cv=none; b=ofi+ugDC1KFK8dZ0MGrCkFnGwRHOugOCJyvtYErNmwF3zFFGXP/HvkO660SRfN3lJPpp1Rj039risQoE5NoxkVBB94wVWHQJ1EyYbDCwMfq7JZS4pcsiamah7sGDNd2vt7ZW3aOiy/z3KQUoPWVVFGqtv+AokqjQRsZLhXXpaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450284; c=relaxed/simple;
	bh=COLsagByi5TZXo/xLIaTS6XkvVxjncL/ZcCZ03pkC34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/NHrYAmrXG8cw/hmrVkd+u/tCRlWRqGXIjm7bseCjd+HAfO2GyPQgVKdzQkQTJNtO4lrAl0oW8hh6HhTNS9IdOo0CAovqbYlcH3wXTzeHoVKxIR04zpqQ+LX/qAtztIwptMUhqHmYbBDNSzE53ipU0yKEPBlP9hSFJ8/KfOhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa59O0vF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j9Bh4JG/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6228HEV23223927
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 11:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5q/hINUJXjB
	L3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=; b=oa59O0vFv/WQU338Lx4dq+BNaOT
	MiSA/QVro7cxbv7wqwQdKu2XDycslEPuyxrSHBUHCBuAta64YXZlSZTN7vhhlZBn
	EMgQZTr2YwwZGmepL3qezrqfW8oRJzZnOO6qrRB330VhcrzVfkcijALBKqAq13lu
	aGeWEPRIhQ6EjiGk7TFY/eMSR4HmMurUC/vbPDG3NHiKliPSAw9j8bL7uWUtg/xB
	mbuc5H3AgLa93XlgXhOlpU9EK0qifbq9CrmP1d9Er8oT8XIWNZkL6HzUh6GJTE1r
	Xvr2hAKhIg9OSjh4Qv/f95wGxSsEfhdlaThO90k0xwoh0+QaZ+AivjUxrZw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1hwed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 11:18:02 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f2793a34dso51592403b6e.0
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450282; x=1773055082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q/hINUJXjBL3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=;
        b=j9Bh4JG/FjbVxV9IgDuTg+cBSAxAOpVlgBqZon8p8LgjmxOfTk4ybNcdr71NqBYGeV
         qF1h4MUMj3MkT2HOqPx0m5J1SeR0ZWzHwzxrmxOmTcTaVWQtZ4UFHOUDi8myWDQIvZzD
         EiIshvSwuNziKA8OigfDoE6EYWpb/133qxxy8qWLX2kgZCzA6dC2Si9VItsgdpwwwNbp
         D4ZNu+XH5R1Zvl257ET7MAwsdP9+a4SeZKp5pkWKC+rmukfynLUuwlDkr0x/p62VAXen
         b3xKDcvnahB2sQK7pmpqu415arhGrYe6n346lOWK12NqzAJnLhFO3OdqJC1ELVFmv+fL
         82yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450282; x=1773055082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5q/hINUJXjBL3eVDeinCAxrmv1WwAgppapGU7zlyf5Y=;
        b=iPqVUoV4G17GmApPt/6pDlYePflpajXGXOYQ/5vF5lMxaOulnnxLCeOp3wibYp2RVJ
         rYt2iVkbx7LsLUZVOqUbvPXoRWvvgIw/mELFx8ofZaL8MlqKs6K4uqj1ieIeyz5BwyHO
         ZE1NpFBqTHNIN4lOehSuAds1cZFH1QFv4uK8gSzPbSB+D7laZ2OhkJq0YwlxdKDAXBKi
         eR0rF4dyVsdHx3rgIZA0F9SjhzEIkua50Z8Cb0NozxKLaGluPUZ38wvboOmpp1tAHd7I
         97AbPeIKJQ3J7psDOvz8OQ/Kqd6W/z6St6B4nJKNou21zMzwsq2tdKGXhSP8pLCGIVO9
         6Egg==
X-Forwarded-Encrypted: i=1; AJvYcCVbxzPou9P0DX4osXYOID+YDdRSpwa5Gtb1DsJ+LJugp62bMwi7XDEef30y+vxH5OF66+kObHCMmp0xyTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oAOYdPhz58CmjxDbB/0uVYxyyD9udlbRXMh9ZASOePgXiLg1
	6UVYzA0S5iPpy9D/lOoknxZ5eyTwxYsKxNDY99FaLa9NRrCvEtt7xqzI2eTPhGADQj+J5eTHSR/
	NvCbPFMY8JoEXTfsmvMYVS9+HRucNEnGf4kyQrrLZ5m1unFF9OXDnI7BZdgo4H/AKasA=
X-Gm-Gg: ATEYQzwLZpsp8S3+WG5rZZAl6TVrtwJFUlUU9FhF3bts4y1M0t/BWLvU/PNHghY2Ay6
	N25nvbypT8JovmITzjEbE+nfblXCcsKA2acBO5aDsJA4rpUArVFMlsNC+4Zg5+QQsW95IZAN1Av
	ygj/WXf3lkigpSv2wzz1Y9lsU+DFmdj60eZmmEZjXCo32IwRqOaz2/c2Ce9UZWEXcsiqpeTnPap
	j1txPvjajv8sy+k2rQbSFZOuTZqz1e0WkJKsIV5TVHV0BtoObpnepRrpOzbySi4hsydstAJ15AH
	GYrwD4FlpCXseSJB3/R6tZyzPp0bsXnM5qNeFkhqZoqkfceqqkMT7D1GcHJ3XdH2Yc0aNvjSQO8
	nAYPSUcFr6+E+eNSLH51yQs8VChumrvfwncyPYFTClNTvjisCPD7AXpCsQTG/SToIzusHyfbCsv
	JLXJ3I
X-Received: by 2002:a05:6808:1b0a:b0:459:9630:3742 with SMTP id 5614622812f47-464be9b7765mr5628535b6e.22.1772450281752;
        Mon, 02 Mar 2026 03:18:01 -0800 (PST)
X-Received: by 2002:a05:6808:1b0a:b0:459:9630:3742 with SMTP id 5614622812f47-464be9b7765mr5628511b6e.22.1772450281324;
        Mon, 02 Mar 2026 03:18:01 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:00 -0800 (PST)
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
Subject: [PATCH v2 1/4] mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
Date: Mon,  2 Mar 2026 03:17:54 -0800
Message-Id: <20260302111757.2191056-2-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-GUID: jZHsWdCPa5oIy9Vyt1o_CPBo1BYgnbmC
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a571ea cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=DkB-CqvKoiMeaEFB2csA:9 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: jZHsWdCPa5oIy9Vyt1o_CPBo1BYgnbmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX4NgbIbyVHZIV
 P4Q+qKOFovK9bjbMdB71WIbq1P9RwWgOf9/hLIGuoBLCPeKUGQpM5Tw5rSrwlM/WHqVknAgKBDk
 sunhrT8x9JOj4V5CG6itZTrUoEZmZ8ZcvOgitg5o9QubFvTHmo2bve34ZnP+ejCpeCpMSR17MTp
 n6e4f7SaDUdrMWT1fNBMgOdmGkuBGzvcacNOswxO8xsh0pJQr8++uEkKddOx0EDLiZkxlhM+MYV
 t9LbVjS0T3WQ37/14hpnGpx6D9esRG6MyRPbuc9oEjbVDhXEhxz16rsEh2Tmt0hYuPcgiDUBO1e
 ucoZFkZJPyo4hztpZIc4saBVo/slkR3GbSBg9zZSCcK4aCHhe7f/02wFDeKuICRfEK13UAkI4KH
 WcUGR1P7+l9GaMdWxiPTMUaZlAnivquBY3AZ5UzZbj9brUSc6eQjhxCh7Oaen+cJuEHWQrGQd7l
 u2al/b4ZVn79mMHAu/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020093
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
	TAGGED_FROM(0.00)[bounces-9082-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: A2D171D7577
X-Rspamd-Action: no action

Drivers can pass order of pages to be reported while
registering itself. Today, this is a magic number, 0.

Label this with PAGE_REPORTING_ORDER_UNSPECIFIED and
check for it when the driver is being registered.

This macro will be used in relevant drivers next.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h |  1 +
 mm/page_reporting.c            | 14 +++++---------
 2 files changed, 6 insertions(+), 9 deletions(-)

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
index e4c428e61..51cd88faf 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 /* Initialize to an unsupported value */
-unsigned int page_reporting_order = -1;
+unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 
 static int page_order_update_notify(const char *val, const struct kernel_param *kp)
 {
@@ -25,12 +25,7 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
 
 static const struct kernel_param_ops page_reporting_param_ops = {
 	.set = &page_order_update_notify,
-	/*
-	 * For the get op, use param_get_int instead of param_get_uint.
-	 * This is to make sure that when unset the initialized value of
-	 * -1 is shown correctly
-	 */
-	.get = &param_get_int,
+	.get = &param_get_uint,
 };
 
 module_param_cb(page_reporting_order, &page_reporting_param_ops,
@@ -369,8 +364,9 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
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


