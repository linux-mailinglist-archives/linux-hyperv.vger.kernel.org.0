Return-Path: <linux-hyperv+bounces-9000-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO8+Omnwn2kyfAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9000-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:04:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687481A192B
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC51630F214D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA238E11E;
	Thu, 26 Feb 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9ooljO9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AfbAUxdj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0238E11C
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089301; cv=none; b=u9WYUfwhjQLPcMvSIZN7QNVHrWlyRa2KvNSFY2UIGRKbJ1s/UIhm7oqN6ngo9yvSNAd0OorwN4SSxvFnh56Tq8pCuI5mtXXg5sedtZaBVMhnrOk9elmRoFrgmqmHJjcQx6Gtg4N5clduDRzLSAD1jycyEGKQlN+026lRzLCzYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089301; c=relaxed/simple;
	bh=fJVeQnZOXsqmKakYSspmc2Cd684q3NJFEKQQw2rrZCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFvier6dfXg85tk1PmiRVAp809KjDBrZNVekQbyhpe6tRdnsBrdTXWcQeWW3tzeH3hNXObyit1VXQjX0dLn6O9uM8SpVjU9MzPctLe5ZRIMNhg8tD0waCrqaN6XyP3DLYrU8TyDyG4ta00Ji2V+61gPrfkJEJzo/fqaaFInm8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9ooljO9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AfbAUxdj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VAoC350383
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6H0aClJ1xZt
	NoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=; b=T9ooljO9Kk1qnZracN1UJbAAvMq
	VxO74DKciFOW6Sg/H/ULiE5D2SQ0Y3bDZANp42lDFtUq9pYWcIBz8fgDcSidCyuT
	Rgq2k3zjKiPD+4bxX6U+UbuSlfJxXfXbIy7pjhJaMIf9+XW0PJ5+pyAQdch2Dxth
	rZXJkLHOT8cSMXQjD5EaRVm+gpsWv6hshSkdudyuju7DQQntNHNU7FISHbSv8IMX
	T3c1qI9rqzPfNbolx4GtJ47AGeayRFXFhQQPXEjtHYpn8ZFT+GQY0bd+NU4B4vY4
	oEA6l8CO1gwZ/VL4gg5FftQ58yikFq0hCKHqUvKUNAUKVmMiUETTBdaWFTg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa5wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:39 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67999892f00so13652958eaf.3
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Feb 2026 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089298; x=1772694098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H0aClJ1xZtNoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=;
        b=AfbAUxdjEDqtOGFLvvRwVzuHdfObfEbLcfnbCwM78TMXKKw50bvlmkJE1Yoq8X63qi
         FwK+u1Hd+8gTd331rXCk8j3PO5/RbMLOCkty0L1EtR2YrQG2eQmC/ZBaVcL2I6HOncbj
         mQ00AJVxXHcH5D6darqEejfLSVhzyOVIM7j9k8gaP5WZrlC2SEaSYfb2dLrLEPo2IoFs
         FMoLuaOQnjHG9usUQij6ZC6JkV8xD7/XHeWqDuqtDP9ug/n8jB0f2f2mTSDg2GIVotRB
         7JbWs6JigBhz2ciN3oXvk8j22hTlJzvnNFhsIoCTNUyJE8jMho70wykD1aQA7dfkKOph
         qtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089298; x=1772694098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6H0aClJ1xZtNoAwOJV81SP1JJ5tvKzYZ+QjZdAOzHLY=;
        b=ntVRwlRTrirTBvy6FsEEp8ol95q2x8bXe8kcvy4AdesJFMJEKtvbZVPbAxHwcGGBl9
         FCPyq1Gk0WRUB8A/ARlKV9dp8GTHCtpJs9UyxAyYF/SjQrjYaFbxF1A4MEcK05wJHlt8
         ReKgVp1ITWXaYwtnSnN3Em5Fh62otaFxWK1BJilkCVUTriDz17cQAq8WI78bx35QnKpL
         ex5YhylSTHRwlGjca1DWjl8RpWXRXi+iVe7D8/yhXzv7TZnHtN47rLerqplspdSMmZcz
         iznO7hefbOfe1yMkvZOzHn4BjXV9LZIdRL6ZzVD+RB7IseMCNnE6wmUGSMR7qSKxuf/q
         lXAg==
X-Forwarded-Encrypted: i=1; AJvYcCWDCb2yZg9stCgTydxxq0lHSy+q5FSkgu232I/OLtppJ1XbL9FE+etzlBkHAiSreIFxU7uyacHXgl2egZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDHn0pSuuCtVsEqEUYN1c8OpliACDJxc4iA7hOHCY37tmysJZ
	jRhQz1LVIYMcuvmqCUSTmPjjXRVARIcfN5QyZjQ2jPWv7pAG2UBxKnD7ZG9/vhXrakRXoWmIym8
	HjKHeObUXf9fz1Ko5fPXYlYD4Ru59Krw/EBRrnMI/5HomfQ+MMUahpqwbysZcIKTIfAI=
X-Gm-Gg: ATEYQzxZ4mFQ6dSJug8HdzzHtKxNEcoLg7/VBR4du1PKJFKieuQaq8pB+7Isq23FedO
	C/yPKRa62BFkg2g+zvQ+c/wPuSvF88ldsBYql0pVyhhyVg3Nawy34SpubabAqxTLoVgGbHZqpvr
	dWAyksN5CrWP8vTssSJ5k2XYWdG7J5SRw+bo+cQYyN2zYL/9Bo/+NUjZwfih018yx0yvDQFGlDs
	xG2z36YPNpgCj8qepFMsPn7O1eIVd8yWiYzw6VwRgG/eD2obutwWZkXDUN85DYMdVtztbLV34hi
	TErrIiwBqmi2XorIDIiXe2IBkfJnDmGAiGbFsey5720b6K3DWO6lIhCLGtCSKtCcXCSGre0zD1O
	5tbTLgH7cdY8NLiO3GFO3Dk8Cy5Ri8tfQ4EYM98Vm3yYVunTpdbbO512BHUbwPm5FuTIkrYpyBJ
	suz1Ln
X-Received: by 2002:a4a:e842:0:b0:679:7d2b:4362 with SMTP id 006d021491bc7-679ef9653d4mr1803394eaf.48.1772089298472;
        Wed, 25 Feb 2026 23:01:38 -0800 (PST)
X-Received: by 2002:a4a:e842:0:b0:679:7d2b:4362 with SMTP id 006d021491bc7-679ef9653d4mr1803232eaf.48.1772089291548;
        Wed, 25 Feb 2026 23:01:31 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:31 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hv_balloon: Change default page reporting order
Date: Wed, 25 Feb 2026 23:01:24 -0800
Message-Id: <20260226070125.3732265-3-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfXy6RrVhKTCwhy
 aE1CvzFWGdKn8I9jv0HSrTK8duiZhX5Ec+1xhR3sAn59u+TxhZKHyf63BpjHTpo3lqmt98WgQpq
 sFnf0UabcmS7B9tTqICHru5ppHiSMjtvm2fqbZxX7VPX0BH+kNe2H3yRmUi8UTrfNWx5LR2has4
 N/RlGHJ8+GI6PmBGn5wmLv6BN9NINM3EXxp04XARkz2OP1N9+obxR6r+lQYNmbJNU2DYwyMomyr
 +4yUD1fghqdkeUyZP3KWYl/fw6gvxW/MoWqQPjxcbknCQz2TbPsdualbMXoKLvKVwzKd4SM3Q3H
 57c6W3clxFrt43nkJjIhlRbWbKF0eDbEDJzf/qo69GNMVDLq1wZKrlPWSvJ23qztg8U8moas5NV
 DNZOtF14qdKyhqlSQo2k/eGA/ctbcgIOLXywwzLKdQokUDXuWtaH2cJejsu7/0WVyErES6PNiJ/
 RvF5CoixnEdQk6OqWWw==
X-Proofpoint-GUID: GI7yFWSqMclvAnUd6SUyoiRBEb4BOSMR
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fefd3 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=IMYoWy77fT7TwZj6-SAA:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: GI7yFWSqMclvAnUd6SUyoiRBEb4BOSMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260061
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
	TAGGED_FROM(0.00)[bounces-9000-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pr_dev_info.report:url];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 687481A192B
X-Rspamd-Action: no action

page_reporting_order used to fall back to default
value (passed as parameter or MAX_PAGE_ORDER) if
the driver wishes to not provide it.

The way the driver used to do this was by passing
the order as zero.

Now that zero is a valid order that can be passed by
a driver to page reporting, we use -1 to signal
default value to be used.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..e33d6e3b2 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = -1;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


