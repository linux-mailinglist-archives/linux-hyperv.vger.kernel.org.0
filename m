Return-Path: <linux-hyperv+bounces-9029-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG2rK5mpoWm1vQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9029-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:26:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E981B8E39
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B5A230A3EC1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238AF423A76;
	Fri, 27 Feb 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KuK84Pbd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uf6F/NBW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81442315D
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201228; cv=none; b=d9gL6z6B+o+G/4xdE39zIl9tW4oQRm27ieqm0Ab5rfn4LIX96hVP4mBlN8/+j7m9GHcgfBCxaQzVxkD1TEQaWscAAhH965xlk5XvAOAhkF6xQj09Jh+QlhI+yl4OJGO5HXhXK62B5yxtiYXatKsmTScYN4k+xGL05iEP8zbcP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201228; c=relaxed/simple;
	bh=EjuOsbxuEHdSCAhIUVJeqLCmyZU507OmNwvaUDm0HSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpxsNxbKBDOsgXyF0ynXrROGLYYA+7bhh6AKkHVEMzps+vj1hpDtJpP1G6n00zx4Rkv9vAiifojU/cGtEqbyardCKuluPWAy4+fwFjfH19S+l2YknUtxI6SoTMY8MMueWmBBOFL719VDlhFY3eAxDX2yqExMcidCQoEiu/jHCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KuK84Pbd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uf6F/NBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9qdoc2438565
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QrnGUwS2K/U
	9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=; b=KuK84PbdNBHtRHb/qaLqIxiTLHx
	/RiqNNPVF7n1ODEWqmJiYFWzIW87kBXHIzlPawr3HanrWWLQWM5MgeGhDIcZg2O3
	tkyWgjZj4s/jYSty/wAk817lcnmtV6BdqwoVvz6GmXSLszti+rhU8oubYjVNDqhx
	ZYz7Fl1qkceW4XUExOfvxUM9deOn8Ns3jem5qHC5/2SkB70QI8LitNZVIZLszVPO
	OvkhNYpNEjD19yhZcP8frXsPJicvdJatCSwwUkT5e1dPr6bj5YaWq+qYJFvX+DP3
	paAWh7CElljrmZdYp0OyL+pHc30KgAtvIUnpwK0Pil/kU+uLXlEj3K08JkQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r3ma1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:04 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4cf783c73so28715192a34.3
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201224; x=1772806024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrnGUwS2K/U9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=;
        b=Uf6F/NBW2qrbJU73g6W7cI9yHnsJEYqZ1xcNsnibhRXszz9jzMbFWAnVC9LmNUm+7/
         FSaf06uPvO3Z5dVFWfppihXEoWqI8Qs+gWUqdL6ux4UPCMIxDQ0jRK+hzuU8RjYhDYDv
         y/pQnh/Yy0qJgzwbSwfYAOFh51XcS5wg6xHz4VVN4rhr9z4PqqX+42zrKx8sopahwta6
         64GEeuzTxX7gsImJLrUD7CB+nlHN0aqguC8L1LKtK5M5mfX9f5KyQUoMmA6X8eaJ6YrW
         kxNIvcJBlNk9ptO4Y4sYDcxEQtzzwyXJtT7/vK/6XRex6OAlpmtW/c3zQX6LMmq0N7tM
         VWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201224; x=1772806024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrnGUwS2K/U9l3e6Z5G/7MAq15xmGxokEEu8o3CQqSg=;
        b=WYv6l2Fe5jmGv2GDY/V+zHiyjrVatPl1vEXsB+a7D5NcXUDdRLjAxOXYIocBlOVAq8
         r5KgkYyiwOGnCbkPCA4DWlsFOwJVhQ67s01eBZolIOTzvvsIMmCrji+NhmobD6dYh6MM
         sQzsjglyE3ph8/baDCmKcija10ZVt4qsl69Xk/riH/sloZpKUsRq8eebEC7gVfPfTSXx
         yNpswe6cSBEcMmLz0Uni1u+HeEjgfaZIEXA5PaSPYsGLSB6IBJoIZaOjO4M4cbsRizX5
         uzAbM0gfWU/6jamt2CIA1MNRuTmDbdJTN8p1a6pj8FMot2DRph4f5Nn8R28tsPv9AO63
         scwA==
X-Forwarded-Encrypted: i=1; AJvYcCV2B4whPDorH5jo6QKlFzBNl0pt1KRxguYvK68B6nFVZIJIKgtz85BQKRLTXLn5KBFNRnAjH/8Y5dgXpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PKRSQkpUdJeZaJYx9TrEV4Btj0UeTjXMpgJRYvLeM3itjiBt
	3MHmsycZsl6aOtG2ZmUOlesIH5tRLbomkQtJrVBlAB3VzaIfbH7KNSLF1qt0+YSCEEUmANW7W/z
	V5iz+/VfbGFVFme0hgImnAf5YRIthZv6cyT8DuBcLdl8XZph1zA+WTDDAp3jyFuCdo4I=
X-Gm-Gg: ATEYQzzm4EYvFxY7caHvgtLM5CuXzA81rWLjK6/OXiyhoRzh56UbWEfEK6RHMM9Zett
	2f9QAzLr4ursaFTV7v1+QTIhFUz0JvYXLe4CSGejmujXQPhQVqcHiN+uw29jg01Fzq6iLhx68ps
	RPuQhHUcXGatP1NoLVMq7ZDuTdda6wIcumexyPPfa4JzofgibWOYxynjupvhw16eYa9Y9aRxMLH
	YOfongw36IoH2gypbV00FHuBMQsFD/MMCYR+WqZyRE1W0NPonkMgyqJjGRtKeHbT2FkhB1SMZ7M
	Rae6H9MEgrCHmMUfc3M/glYa7iLDuzPysovt7WbE7sseD3hr9+UWot9SVxrxo7d2sUTeBXvpKWi
	W6DD7ZMhnjUq7npn/88QsMp4PHmjc0ZnqjEULkshwkhpyyIYT2EPY0JPWDh9w4KY0Qls+8mDOXQ
	CJciT9
X-Received: by 2002:a05:6830:25d5:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d591b2656amr2098286a34.13.1772201223975;
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
X-Received: by 2002:a05:6830:25d5:b0:7c7:6043:dd93 with SMTP id 46e09a7af769-7d591b2656amr2098262a34.13.1772201223559;
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:03 -0800 (PST)
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
Subject: [PATCH v1 2/4] virtio_balloon: set default page reporting order
Date: Fri, 27 Feb 2026 06:06:53 -0800
Message-Id: <20260227140655.360696-3-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfXyDVeFoM876X/
 +Td7/+INOfILKRb346Pbg+qwy3+LT6FP7xvGwiP9yYpyVMM3wRkKUXzsgSX6w7DQs9HjUA0mF+1
 lMsEdNqHL+6gcql121yf3GQFQ5tUz538tiwYKRW8ARAMAw42dr8V0DhC5yWlYYf4LL2ZDFVgwqK
 0wwuyswCal7I1HLSxV3DHcdK3xcZPBsCdb1eNQn4se94nuRhocLYl/BpCjcfCCEZUZmsVnboNi/
 j90STkEfYoerLmt09cOW1qvchkCaeZs3TXr0fmutcWSpA6QvHPu+9XQ4BZjpG+MfEC81n8N2BiS
 aOOz5ApIxUFpertC51alevbsTl9ryeMFzc3lW9QAuwb5iIGPevc/Zg9fKPjQFZW2HQhrJcsl1yj
 jOn8UHoWf+vNRTOzvgJkquPSOJsHGiyU5WKXVP8EwVz4lRYYWEXbF748RGhoVyFMqlBOchfAKAN
 VejxoOPZL0f4ARt2sMw==
X-Proofpoint-GUID: 0VNlJW101EQj88Cri8KutEP2wGLsrX8c
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a1a508 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 0VNlJW101EQj88Cri8KutEP2wGLsrX8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270125
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
	TAGGED_FROM(0.00)[bounces-9029-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C6E981B8E39
X-Rspamd-Action: no action

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_DEFAULT ORDER fallback value.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..0616c03b2 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		vb->pr_dev_info.order = PAGE_REPORTING_DEFAULT_ORDER;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1


