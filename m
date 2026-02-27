Return-Path: <linux-hyperv+bounces-9030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBv2E56poWm1vQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9030-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:26:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4831B8E48
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D9A730A3EC8
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B85423A79;
	Fri, 27 Feb 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhFR2Utr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CcoZDzWU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11F423A65
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201228; cv=none; b=TEqFP6UfkyQp5mrOC0l+wYZMgzTlfy0zZbfAnbCyOcu2g6A5sz26/Wrq5/vTHXtNf6+lRBPwX1R/b2C86qq6YwQpIpZ8mq0zC88MXV5a8Kl2j6nKIPytHaZKTf98V78GxepgI/TUzCXnDZ/k181O+QtRYZzvAM4Ex1gdSrhUjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201228; c=relaxed/simple;
	bh=2gj7W7Ro6qYNuWMaV81IJjR6heSJWBBxVJC4zCRDsF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmrT6Gr/dToBMaoYHEHVQM2rRvHFqM9OM4W6d19yKIrxyZTRtcwvbclMiuL9ZDIHB8oEMTcu5GDWDobjZ+Bl1+wM4rija1Top8JEcU3rupjaKClmDag5L/L7mLMeFmgW8Us4dIYUq0fJ42xmduQEzw87sk+hntglRfEbixrgq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhFR2Utr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CcoZDzWU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9VAtC236992
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AYPpVEPSMuP
	PvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=; b=ZhFR2UtrCkUAz0Gn8NnIYKS1xLj
	lLZwdRkb1ryKwiwJgp+p+CdDigW441Uj0/CgPT8o1TZorNXDfZol8EhkzCI0IbbF
	EK9ciAWiY3oIEMjvCL2javeBjUVMJaQZ3ST3Y5G7v8RjS6pBtWYjFIHS/MH8cpn7
	NC0xtuD79zH6oUeDelnjpB4qaX9gxDRv94RJbEqX29oi23Ulq9xE+sSMEAoqASEU
	85DjBpGWN+7d2d8S7WHI+T9hdOBWn8mZLGqFqe8s/Fz6gmMSBN+MDn9VtjYxJLx3
	3y7jifU9ABBzF8xMpeMuGDhkArYgkuz9Z276NGoTuVs5yat32ItWmtytBHQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xtteq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:06 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c2b7f4caso15876781a34.2
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201226; x=1772806026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYPpVEPSMuPPvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=;
        b=CcoZDzWUzpEpISHkUQ2wwldJ3/mlPnVyq6lGp+nEmP0Y1yRYZqHk4lZuZcNiZPCwMT
         br/AOoceIFyZ8/16LS31aSEOQb8zpQVfZfuca0V8810KjsqodKyu1naMgJnLP2E0fZsz
         UcMzWlACrEyfgMLHllym3JsdKTE/E4viHLWiIhvmo+GgyRgMF37XOMIS+Hk01Vu+cFqy
         siLDHma+d3aoCNmOnPec52+odG44q4y68Ja8/G/g2vrJTiyTqW5/WhioaWGxIX0x3yT6
         vtqnhRh+gGEGWU6xphmCdnt3+qBquEQ2NWve9W02oyOUDz7gA8NC8s/va6UtMqPGcSkF
         mKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201226; x=1772806026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYPpVEPSMuPPvaHEcnQ7Yq4HJ1sGqdK+u6ZDUQS96BU=;
        b=hrsrHmqbnQTiWod3j2OPEc0lrwiefXUF+owDn74ZX6XeaAWL1Af7INSSempicT24Hn
         M046gsvm3ztfWVYADwyCwKzrgZJG2ZjoxI8qzQFpVDF2yP2rlCv6Nvg/k+3tIT2dpSHc
         ujiSMOmCCZpxRMMge2K87RodG1dI33mE8OFs1Co6agZL651qkHrwax9FJjvo2piwWe7Y
         cOEQkqshyavOJqJHn6yiIg2sgSEUfkJcj0qlBY/M3XYBDnE5C/LRbcf6ykIcZEm8sYjN
         gPHn5sgsLP8+XgQtz5/gm7r6thmMVOvJItmRsCT/9jR6EA4cMJiLVqUkDV8tLhMFRLAl
         8pBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfG70sJQeqHiHbi0htXR8VIHRp8WQW24tIj0f8lofqJRcaHEbi52HdWN+zaLkeDwuM9wfMNwyLAgRceW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiardwuJs/Cn5DlpV1J/rXovmafiIR1xmRk7bFfVavdfCAc12a
	Yy7UjCdTCrdQ7vgH3XXkjLBmWGeC/L5K/h5umIi/5lcq6tYtIvPm2cPe6hkLn2RetZru108h+dV
	hsUb3LKpHLqOLztc4Ee8n6V/5/ROA68ACDVzu/YlKKwEHJYOOnZlfYIQpFfh7BM3p8DM=
X-Gm-Gg: ATEYQzxYlDZ/1kPItx9r5MHjmAShR+HKTxIPkVzQ8vPSXdjiyqMsVf0IXZJttomvFlb
	nyFHEQGSc03UooTCD3ZLmLvoYx+mdsQ6SceyjOMjq9/kr2x+RL/v+5EplHlDbpePa8Oe1+oIZDC
	pnQpOZow9KaJjKAPgxkUnt1LimJJG4qDnKmKNeV4a3cULFL3TA0MPhDBSIhKqMzlA3bDp16MhLm
	QdlLqbAPJyvLrvSnKJIaPV21txPiWz5QznL6hJ4lbCyjPxoTry09B3LFl4jTuYHZj2mi2feVvT0
	Wz7SS0bBmYt0J+VPcibhCw4VvbnWaWb10h/50LRNL6qGLKB230Zhd8IKOQ1oMK3TZU9yYczqKgQ
	sC3gwSCPRU0YsH4cd/XbX7+kUPStFgtTFLIk2KgZTiQ9sCVwgY20vXb9DqhO7uXyvqL4e7YifSm
	D0Qb94
X-Received: by 2002:a05:6830:67fb:b0:7c7:69c8:2ce with SMTP id 46e09a7af769-7d591be2615mr1920085a34.27.1772201225851;
        Fri, 27 Feb 2026 06:07:05 -0800 (PST)
X-Received: by 2002:a05:6830:67fb:b0:7c7:69c8:2ce with SMTP id 46e09a7af769-7d591be2615mr1920072a34.27.1772201225419;
        Fri, 27 Feb 2026 06:07:05 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:04 -0800 (PST)
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
Subject: [PATCH v1 3/4] hv_balloon: set default page reporting order
Date: Fri, 27 Feb 2026 06:06:54 -0800
Message-Id: <20260227140655.360696-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qdGoIRN5V8JlWt2yFpeKkgbF0jQ6lDyF
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a1a50a cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX+P4FkbySMiLa
 ZQfCr9pLTa0je4hX8A2ZHkSGuHXyP35n2/V4sbD6zJ75p5KCeRoYCeS+NSBwJKRHn1Lwg9l35ng
 mLa1wTcSsfWC4NX9sPilrflb7MRmppJ0GwXFeFFlnE0GHPohK+GPbiar6gSF68nEpk2hfpXK4gH
 4kkbkbXjk4XiMgEzjX3CkdBTKjRue1ZglloYPctx/6VvXIKCtKXHRCdSxAKjmhU15R+AgJcPCOd
 /6QurozWJx008xKtq/XDB6BRuAeICqSwCP3KCM9OEaIaLpHBXjphlYZOToQUFMJvgHFgUFUVLzB
 8+AeM0MZ53Xewz1riVXNMp2KiMlYEh5T7j2kD+3LLwifgFsElzsBYu5DzzLiD0/ol2y0BfXAFql
 KY95VrdA7ytsxqOgkUZvURkkVoBy+vedkcag6cVzsONdSfc5XM3dsNqfssiiiEckpmU/v6ZnXnu
 RyTeLllow4WXFklYW4Q==
X-Proofpoint-GUID: qdGoIRN5V8JlWt2yFpeKkgbF0jQ6lDyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9030-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pr_dev_info.report:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7A4831B8E48
X-Rspamd-Action: no action

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_DEFAULT_ORDER fallback
value.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..3d6bd9936 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_DEFAULT_ORDER;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


