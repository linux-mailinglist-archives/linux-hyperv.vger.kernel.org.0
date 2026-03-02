Return-Path: <linux-hyperv+bounces-9083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPAfIC1ypWlsBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9083-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:19:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D861D7588
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A8C3052612
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B5361DC6;
	Mon,  2 Mar 2026 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXlaX7Ic";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FiFNGHT1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8B36165B
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450286; cv=none; b=k2akIO/INBs3j3JRZlDCsxbLw3z57VmwZcL/AVzkaGOz6hXQmuagwDr3Xh0ixqnGqu4WAu4AEbqKD1T87iB9qwsESONKgoy+CebcXP9YoC77DRrbjnRG2d6V+QTooKZ5iwhGe2lNmCJ9gpiEAyfces5fghrZP9THlzc8S0JwNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450286; c=relaxed/simple;
	bh=i+UV15jJM/3VZfIUJnkNiYYW3j3bD1XenewJK4VmUOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuCguV0VUvbs8EImHK0qTeR/vVpcKhuUIuw9m3HCkm+oRuUZ7rpIDlDNGlunnqqP3M8e3p8JikvrqmYGAJGmZCz88N+sL391HGOneU1SBbPBAO48OcJHP5N5kHJMScm9DLK4KYo9Gy3u2W9ttS+z7HIROwKrOm5/nXLIBRt8FmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OXlaX7Ic; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FiFNGHT1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62288Qe53223966
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 11:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7WgQA1jpoOh
	hihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=; b=OXlaX7IcEv9APHHnKmMYUuQUDFA
	dKWGpNp0EtanOe+OSR4C3EYxt5xmd18VOm82+nzPneU5cVDU5amU7WRIeGnhD0NN
	Taegz79kCOXYDyCctx7BryTRv6sRtHgJRTCYLOzz/h4bRrKvOnyJfqgkIM8wbMOd
	+dWa7+vOWdLCz6MkOzzU11MmysNu/zhf7l5MdwC2aYlmokLQ625+3FbbixSg4HzQ
	EOHmXEpZleHs5GPVyi4CqJkJuH5hb7mz912pccWWZE2ucv2bMeZ4DGzz5N0Xz/Qs
	MQTVV2shZN6pxe+kh5ZVMXF9+PAFNdckKIJo3S5nLxGfaNydYRocuYrzs+g==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn0b1hweg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 11:18:04 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463c4133ccaso52942698b6e.2
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450283; x=1773055083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WgQA1jpoOhhihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=;
        b=FiFNGHT1Y5QvNg5BBNNCJKMCzmwryEr4dULZZ9+rMk80hAYtXQ+V9gCF7pNcPhLhtW
         dxoh2G00xIlzFeCmA07x5EU0eRzv+CosuERDvTpTZETAsdG7AFvmU9fYbSf2wO44Xu8N
         7y6ypRZ1p9uq7CDoQv/2NwJt+By6VEvo7iiKWcLwHb8GeTZ/anxyXNfdVEwvsWu6hCQV
         XrTmz6iY5pArNDFKpQqmjssWBBzwi6/DIyvSPzY5saXAQBRT7co0L9ssHqlK+rx7RBV6
         8p0rrly1L/ugviC+pDz5SvxtH8yidW2Ue1+7ECQydbnGsPX9wjv3EJUGO99laG0CmPoF
         S52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450283; x=1773055083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WgQA1jpoOhhihTrIOScZsZlPh2ELGgaQLSJKmwH+o4=;
        b=Y3DibP5oqOOW+gVT0UHUDP3TrEvWDEKMAhDmVGUxRTUFtKZkPIvgEdmWIuQ/MkQhgD
         4jujWhsFwl4uW92dNsatHFbsLsSt/sIRq3/H4KP5cjzjMaqVwbECJ7W5EkT5hpEHkBHs
         mDzql97ACHKL1IwcShZqYTqdIY8th8oLEo3gKTk+i+MhjE2aImErdZA14bYCWwyiC5aH
         6WEaD4jJt/TdwikHgdo9xH6zKML0NxzwmvClEnDQzMRI3BQfetBAUFGOw6LTa7ZGb859
         kSoGo1mBtZSwZOBZhzalwT4/F5akm/Lua6m5fyYAZCh2v4iiOm1XQxpfYZM2Cg3NosvR
         mU+g==
X-Forwarded-Encrypted: i=1; AJvYcCVOUcBpsWLDb6zvfwqxM9BG0jMcaXtJKsobqUqJP6YsfQaRM6np+IJy4aCSEWV6dglCglMv823PIFrqblY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxS9rQUKtPMtMBBpE58yVu5q88bapsNzBMIAU9vVlymUg9As5
	a3DV0HmPv3Yrw4GJBPZsErOfHJXZEdSrjKpLaoLFvpVSFyCEubYJ0Fo55dg2f974CflKhpUtfO9
	SEd2Nz8bLNNJZPOO+ZLJr/vkHGlRKzOCaRTNdE5imVSZcJEYjF/2txmLdOqQ9UcDuh3U=
X-Gm-Gg: ATEYQzyj958zCUcl82gmSe9DhLxqApTbuPDZraG+oY/wTKfBpe+SriD0U6fuF9DP1gK
	sr5WFwkQy5wEEL8viPiJy4v7P4g6dmLto3c7oVHHe1ycvetxxmbyQ98uVnYHeXYZyjPLEsF1OiP
	SULrDzxVj+1X3qalpXotxaxP2dZmkNXjvmReG5HAtGuRW2JqNRby7Rr9Kg+byhM8dxe7bG9KmV7
	M/PCE1ZJtn+/7L0qoCx73Te9nMsHaXIfNhwXArDaIbqUedOq+lotOu12kei8cOcf8jCmWopFuKQ
	nXX4h7NP9sHjb+hKR3XD2rR489+LAL6jD+/tq8Y7TKdQ4Vucc4WySHPEVFdIKp+zX+fzXDBPEIC
	v0MtdxkxUfGD4WVYPI6jv7VqMVGYSj+Cw7I7/P82v2helrAzeNXyWy1EFqeMGSrQ0Q/iH2NHipo
	CYdWF7
X-Received: by 2002:a05:6808:1396:b0:463:f9ad:a4cf with SMTP id 5614622812f47-464be9de029mr6940033b6e.23.1772450283475;
        Mon, 02 Mar 2026 03:18:03 -0800 (PST)
X-Received: by 2002:a05:6808:1396:b0:463:f9ad:a4cf with SMTP id 5614622812f47-464be9de029mr6940018b6e.23.1772450282960;
        Mon, 02 Mar 2026 03:18:02 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:02 -0800 (PST)
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
Subject: [PATCH v2 2/4] virtio_balloon: set unspecified page reporting order
Date: Mon,  2 Mar 2026 03:17:55 -0800
Message-Id: <20260302111757.2191056-3-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-GUID: i58sqbfcDZ_xQNaAf763aFlfuKONw9e6
X-Authority-Analysis: v=2.4 cv=Hol72kTS c=1 sm=1 tr=0 ts=69a571ec cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Jvdq4yWlxvBRgq3Xg-wA:9 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-ORIG-GUID: i58sqbfcDZ_xQNaAf763aFlfuKONw9e6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfXxX69ZpG9IlO2
 e9m6XoL99XioGXQ1tFkcqCvRJFaBwWAmJN9XXX7a+BHhHcQLpH6mNa8ng4r27nt6TTrakGyLti6
 o3PC7kdUIwsA+r6ukpgwkKr6wRxs7kM4HSHMHsiyWphIoTB9x36IcIrwGcNJNj0TckMbf4AGyHF
 +uhUNgtjNihBtlqgyclTaulSaFHeaFE69bXxuihuzfSQ8kcpUnlvy7ADpdKrYSiBLE08MCMLqKg
 SELF3WHp1fpQ6PM1/jW3n37NUGhbkBfZKVGZQl8e29eThRuUxKkNqeRvriO396/gzixmfltjo/v
 +p7i/lFzBYCkl/FizlZw8dQVF9DdVmp8YyVucontP2XIqSU7ivDDAHjABoU5hksKpzCH6Ks6AnW
 /G1Rh6JF3zf3WAyhkNrXaUA+jyWL89BdiTUDtDKblNqPURhBJ0fziU9Y8kMpNnYdmQ5aU9MbyyQ
 ZVZsJvEdwf/7+uXR35Q==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9083-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9D861D7588
X-Rspamd-Action: no action

virtio_balloon page reporting order is set to MAX_PAGE_ORDER implicitly
as vb->prdev.order is never initialised and is auto-set to zero.

Explicitly mention usage of default page order by making use of
PAGE_REPORTING_ORDER_UNSPECIFIED fallback value.

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


