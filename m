Return-Path: <linux-hyperv+bounces-9081-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDnoHBFypWlsBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9081-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:18:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83E1D7570
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B763048098
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB1362121;
	Mon,  2 Mar 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MHRcXxNn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evF6sMFT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEE336ECC
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450283; cv=none; b=ES9X0oWJKnzkp2qpr4jG8E2wpfVh6ct/duHuERVl0AYuR9ueQmkva9JbHCbQarN7aAP0FU/DpvsGs21Pxy1BnG3VTcOTy+SvzyH2O/iJ8TMbmgCd1Kc5KaNNyX5vBks7MlSPkCV+822ViCbGzTu6alY8kxDTjcmTrAOVH5U6LGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450283; c=relaxed/simple;
	bh=gekinlAEc/Z/E4mHPXrII3Zgs20MXts8dOrdEmKT+vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hrxoz80jWPTnPGmlkAHN4xI6WcUBdNa78rRGav2dj/Rk7/2IwgDBpljxMmFRldhBHbv8yvpo2N6dUUwW7fcMWXby4J9iTIxZOCP6lj2nDRKCHmq3NuXMFwJCKdz+w6USVeOiI4GhM2o0Ca8K1+/Kc4eV6F/F4Y3kQu2sqIqQm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MHRcXxNn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evF6sMFT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6228M5cn3223961
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 11:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU
	5x4L5Mi4=; b=MHRcXxNnbz5GIKwWQYVoaNUziQJIm1paESYHmUwIp8XM8ZrTtZQ
	kcWU5RPnyN+J/lK8HEO4xggNDAX87YEtX+uyGAs+gzkW4c0y660oCog5baGTwhwL
	/+nBuWpu2Sxgv1D99xyf0mQgaJiwF3slKBh2Qu9t/GvSWSUmHrout4pmtuUKjsjt
	/CKjluajet6WGWMAaPMLcnWZrcuEpKzXCek0kna0xqpSKnm5wH16juvw7rMIehIR
	0KJ8oYt3tpIdqqB5yF3QVZNFVTrl2fS3fLFogoOoZz7dDz5baYaTEL8LIN2WvABr
	s0TfoEpl7QRHAEkWKwHTe+IMzQkw/PX/z4Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1hwe7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 11:18:00 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4639a3bf26cso22030595b6e.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450280; x=1773055080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU5x4L5Mi4=;
        b=evF6sMFTSG79gBEo6kX4LXrKgzPAp8FT8S9MB6nxD9PnIuKT55rpNW/K8giTCJ8PU6
         sRzriNMTxjNlv8ATLcuOwuF4EuwMcQIz3sP2jPKu/XDTcyWmRq5hf8TC5qcbnw4V7Hzp
         lSNXhPtzywlby3kIecKV4pHmVS4cJiawQ9K3VCiaMSRez4UoyTmupyNfiIMBW4+9CE7d
         K2TeTREfDScACqMaqN7gDn5Rr/V2asLzzWnxL2zl/Am3Zzh799Rad6PfurkYQmlrmknI
         5hbdyq51tXqp/eq9IEp8SSEyIdyX1nE1mnaQiuqC51YqIDEub4OuxKZ9CcikNlUIBiKE
         ddFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450280; x=1773055080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iFgusvo1aPKir8ugITOqUipqQuZUj6mnHU5x4L5Mi4=;
        b=YnqTfPYSoGZ+GyTolnf1WXh3pHBC0rJjupGCr3Y8m6oqDzgUzN6kI73X3ie3oCZ4YC
         46Kz93mH5F2gvFKpQ+rGNYi7Cq+3MTlUx7frjH9rCboZu5JX0Tit4INb6BXw4HbDzPKf
         JKdBH19Cnpo8w7Ma2jS9gGACHBGiQT51LXf7e5/35qiFlFRO23OuHTH4lRwaeRTHsLaI
         Jl/O18flN9Gbea0lrwDvmifxCsH5BWOFHJ4NVGfm06vKubdw554jSrA/Vf2RoDm51pxf
         HFDsGudkdOPWPkKKPeo9LkacF8s2MmSr9ZyNsxk4ZkliPfvMIqWlKZ8FuEFj7PH94OLb
         mmyA==
X-Forwarded-Encrypted: i=1; AJvYcCVBGooN0rLS7G3vjcXE4Vg0eLVUso2nOL3uOXRPtF8PEA1r++XebnIdYG3dXdj1ksqrfg4zKpb/dJIua+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/bKG1Esc8TMA2KQb+QIcohrQN2fZ9kdZHCcOyHBqTgfLVLKy
	Qog3XtNN2wy598rjupnYm23N8GPa6fqY1X/oIQAYgVfu7467gHKcq3BDRtdeSU33tk/X4mGqdrc
	UhEWGY/zUO1+tqx2/mJhqICQ+tr2Y60gpxtCKKuKS6FFk+/DJ40B00rGkERsDF1ItUBI=
X-Gm-Gg: ATEYQzxwl9EyikUPhmv3ggqn9Q4Has3EEXmqxpgrD3ik7nq3MO54lDoUlmhpu4gF+UI
	8/8tYELsORtvGs2nXH2afYRuq3ODttASw7Q5XQD00HmD1zKi71LE52ZmHq5RMj3+xschTY1Mrhv
	McEt7bqUgS+UrBR2/NGBEKq05BrMB8MkjbjyAY/+k9Qjgk+sjPVMfgU9pRM1R8iGokMCv1NSVgl
	bgybTKgnmyVzOjmNDKFSEYJipHId3vGiNPAHD4u0mbnoh0xAHVrkVsGmGOjUdi7/w4TfA8qMcMn
	I5DcN9tgYmc9atV7RLOL1wSEtd4WqYGEhzXPkds5uA8kqiHH4SaDHKZBYRddLWhvn1kzf8OHTLq
	hOlqqCaVDmuoY1nLLw/hPUnApiBxn1Aqj7sM7i3w2AF+Cha+5Sg5ZaMZuii9HA82VtYbkwKIUnl
	oMrqae
X-Received: by 2002:a05:6808:6c2:b0:462:d097:2467 with SMTP id 5614622812f47-464be972a89mr4750519b6e.7.1772450279932;
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
X-Received: by 2002:a05:6808:6c2:b0:462:d097:2467 with SMTP id 5614622812f47-464be972a89mr4750514b6e.7.1772450279537;
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:17:59 -0800 (PST)
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
Subject: [PATCH v2 0/4] Allow order zero pages in page reporting
Date: Mon,  2 Mar 2026 03:17:53 -0800
Message-Id: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iIokHqp-cQFeezZHRI-TiFhIpXdc4BRf
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a571e8 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=9ecvtSpfVrh-a2M179QA:9
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-ORIG-GUID: iIokHqp-cQFeezZHRI-TiFhIpXdc4BRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX/OJV8W/jT3qT
 KIoD5HmY1EdwP9aJdzBmtcrDPZ3e6040wo7vNWpSynwv70i+/UjYJL8E22+2mlU4vJpZKokk8oE
 Aloq7IXZRNMto2hPGD0RXb0L2yvPiIcbsKLpRdxSOVN6vjMo6WBZX+uXyRYtqtINYvFRPbsqsiU
 53Me9ldsiuqMh8ZBiBNLSt60LjH1su/8on64y3H9wiVoZPW3a4as1YH9feB6uo4UDNevfk+wF+u
 M2mCKouAmP+hP2jBBJLxgjoUykFxQgco7PGEYXNrMH9lemwwmTeJKMhaG7ArIGYApza1ucQqE2i
 zgf+xvMyUEcdmUTBsPSe5mWE2bjZxDIqDn6LMULq0MclVGz5MXC9bACX1ZeYETi8BJm1HS5Oost
 ws98uzfNlIECbCCo22PXDnuwA7p24OjvCbF9lPFBP1uHN8ZUuE3kKNcm0jcJ/J1yanaErjfVYby
 JrWr4ffSZoPpfosPS8g==
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
	TAGGED_FROM(0.00)[bounces-9081-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD83E1D7570
X-Rspamd-Action: no action

Today, page reporting sets page_reporting_order in two ways:

(1) page_reporting.page_reporting_order cmdline parameter
(2) Driver can pass order while registering itself.

In both cases, order zero is ignored by free page reporting
because it is used to set page_reporting_order to a default
value, like MAX_PAGE_ORDER.

In some cases we might want page_reporting_order to be zero.

For instance, when virtio-balloon runs inside a guest with
tiny memory (say, 16MB), it might not be able to find a order 1 page
(or in the worst case order MAX_PAGE_ORDER page) after some uptime.
Page reporting should be able to return order zero pages back for
optimal memory relinquishment.

This patch changes the default fallback value from '0' to '-1' in
all possible clients of free page reporting (hv_balloon and
virtio-balloon) together with allowing '0' as a valid order in
page_reporting_register().

Changes in v1:
- Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
- Make use of new macro in drivers (hv_balloon and virtio-balloon)
	working with page reporting.
- Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
	page order that can be requested.

Changes in v2:
- Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
	PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
	the situation where page reporting order is not specified
	in the commandline.
- Minor commit message changes.

Yuvraj Sakshith (4):
  mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
  virtio_balloon: set unspecified page reporting order
  hv_balloon: set unspecified page reporting order
  mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1

 drivers/hv/hv_balloon.c         | 2 +-
 drivers/virtio/virtio_balloon.c | 2 ++
 include/linux/page_reporting.h  | 1 +
 mm/page_reporting.c             | 7 ++++---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1


