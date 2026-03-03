Return-Path: <linux-hyperv+bounces-9107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BKRJz/Kpmk0TwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9107-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:47:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE111EE79B
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117D232C99AC
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3C47D948;
	Tue,  3 Mar 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ya2HduJ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BdV63wKz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122F426D26
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537440; cv=none; b=joi3M3dC9vqcywIoED/rUnK48BSKtqIva1w6klETwfwGBzPAthwbD9BUgiey8DDK3jrf++YfVAXtz10Pe3cvQSWmiwoDxY5HyMp0Or8kluJi2/iQ5KEmiSq3lfKcnmu8ImEIqABcx1WoNMdro7z7Bo/oemwxjGnOis0E1/iR8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537440; c=relaxed/simple;
	bh=4D/io3APDupQGYCj9CFWT+uOecdkhDM/9ideWpjC7z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ci4yZWO4RxnM+c0K0EaX0MVRcH/jkDV07KV/V1fVapIZD/Je8q9AlliJhT+MoicDwYMEKL1JfoLOh/7enQpnZYLXaZKiGUAtS3ni1p4WsGQLlAbETnfNGXw8D/2MoaTmz7GttWGdWIQjMZKqvRYh2R/aC6n/kjWRNQ9w4+mXWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ya2HduJ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BdV63wKz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239mdNk2307382
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 11:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+L
	NtRMjpwI=; b=Ya2HduJ196mEDx2M2W52dArVnBH9Llb1RLVi1QopdD9NKEKc02r
	dePOX4zFt3VO4YNGCZTkUH0ZtfyH8eQa1+YaoQ26BmFgHZmRqz0Il1BKoRwNPoVe
	G9sTv/gB+Bvejl+JXB7K+rqzWPb2ObULyTGyr4wLDAAhIzlJ63e2ikhoFbFs6WxM
	z4iiNVroxrU58YliLMLbttjy+YU+6IKiLLiQ5aVI87Efy1sz1HFKNuEoHrxZAkCE
	eNK7sUAey7UP0rojdxuF/ETuISVLyz56JBs23+s4UkK5wOpgRdl9ebBQPoEDF5fZ
	PCl+nwdoeVGIuhVhrHAKjGlB9nw3wH+yDbA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvtu8dw9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 11:30:35 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4d6edec7eso39366831a34.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772537435; x=1773142235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+LNtRMjpwI=;
        b=BdV63wKzDJDyKBcMawTPvCpa49hkxctAXDkS+zrKnR8EAJ2XmtnF9B23BFiy6hbb7o
         era8gRCsry8JJ2A3L5Qh3gmTA4u+v7mQrozn9xZmw6WR/JUy0ze/SJZQXOsUgOJjAiYB
         fzQ7qypBJRUJf0rSqFVNd8cCxHKRHv2MByA80wboP99qTKwrGDiaQ8h/8a/Zvb9IX4T3
         +m5Nrzfd2DgTUnR/CU2/EdcQMGLnG2CuG7QOKRUZPJvMlZ+0nLiRZGXmeWYQvZdi+D2C
         mS5e7DmiQggwkXP9348IJo78eQbUYjQXTPnw5OvUTgWmdCOhJmR/V11jkXIWb2UH0Bpq
         5yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537435; x=1773142235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jhEbYgGPpM9YgBi8KcAq9k2DT/kIdh5p+LNtRMjpwI=;
        b=s3t22Qr/E5NTvmHHvRKxkAv+LNtI4eivj2O90Ihv/iT/8gOwUQhlLxRRvrIHpPjLC6
         lBLWMeuKTHarqCzTg+1KAuiNJnQc8M/MU+GUdbt5q63gKotY1JuyZ0GeEzajOEAzrWxq
         h+WMIh316L3IjoVVf5vbUmQEV8jlyIkaMnrObdod1w0na34ErOX5+2oeQpjeUMKD7LIg
         OunyARsr36D29hD7jOJW35DrTJS+qvXglVZWaM5xO8ZYVcybvGz/UbUrOA72eZo2tDbg
         HSt4y5YFBvVN8NXOq3KI3izpo1ZOlUDfHMd3Dceky45IL5zWstwHo2Z7tN8B2Sqo/VfH
         U/xw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7NX61SIxVo/I7ti5k91VAGOlc6gIaoaLFntkXwMZ6GQtkwQc5WI/fd6AP3Du/gqntQ6/JGGzEotI02w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFqSDcHHklz/WASZ3lQBeRFlaPhrPNP6v1B+Zm2F8gsr0pME9
	fBymSgNUcZHH4ww9jDaFPhLJqLEiE5jO/N7Gzd0VtiLWwam+7u0ipsp13yMwXRn/Mwb6WZkCnPF
	T7mSeqH8wIL/pI4eOzBz2CV2Ujj/2Cwzfeco2of5SpOVeTbgpVkU2b1bbs3DpG7aZlj8=
X-Gm-Gg: ATEYQzzgbumX7C2W/zRmasyAu2p3bUaBzDOUzC5Rnjz/K+kWdIIZd3wyy63SNyM8OH2
	CBr09aJ7u3U9gHrfzCWfO+NXi+HIyVnIE8epqpeIXAHdQGq4vU9YResXvNLRfM7/30QPZsvjL2T
	RslDsu3BHSSEcuadhjGObi8MuJxv10/ow6kGm70ltuS0oAY/W7vt9pY4sfUkts5mm3hpZTrx/KI
	LSjToF3fB/iFOaG81HVoqZ8h/AfNVlMz83u45V1BFpjwO4vR1waWqa/VmTtLuXm8Z1N2Ldju1gA
	3x0DId7kZA4zobzkBBP2354DEK8qGwHlRwI/Fmg3FQoYQZ82FgK8XMlrGAoEldafcN0GxV/6w7f
	O4qBPxz5HsXhKmQwhC/sbbJEM0Iyx1CyML9GBrRqpjadbLxf4FJLCBo/ntXIIit4quy19JbeXM5
	1LcGmX
X-Received: by 2002:a05:6830:6186:b0:7c7:5770:d2bd with SMTP id 46e09a7af769-7d591b3881emr11120263a34.12.1772537435247;
        Tue, 03 Mar 2026 03:30:35 -0800 (PST)
X-Received: by 2002:a05:6830:6186:b0:7c7:5770:d2bd with SMTP id 46e09a7af769-7d591b3881emr11120249a34.12.1772537434819;
        Tue, 03 Mar 2026 03:30:34 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d59785d8d5sm9311790a34.17.2026.03.03.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:30:34 -0800 (PST)
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
Subject: [PATCH v4 0/5] Allow order zero pages in page reporting
Date: Tue,  3 Mar 2026 03:30:27 -0800
Message-Id: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lx0uNvEIBJKxjhREMFrPi2LAL9KKmtE_
X-Proofpoint-ORIG-GUID: lx0uNvEIBJKxjhREMFrPi2LAL9KKmtE_
X-Authority-Analysis: v=2.4 cv=A75h/qWG c=1 sm=1 tr=0 ts=69a6c65b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=HYTG7BDJ-qdBC1FqdxkA:9
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4OSBTYWx0ZWRfX/gdORXiQ3JFB
 vIuRYTRXi9gzXjbXmEY2Cp8TjaVMQnTHOlbU7V2wxUHB3s2KeO7NiVzkSelmwwvhzqX8MXwo+Vs
 io0rXeV7t2GgHVXjbyu9AX5SnMkgg202H198G1a2yXR9ApP6BsYhmzI8wbYcckjhlNf8D1d03cS
 dYxgLtM0YL5KVRDtbO4mjk3IeSUBr3PD/eW7J6sziHVv90R1S07gMTZv8ea13dSLbHY25aVHDn2
 suITFw7i2HJqyaF+kajnV7BhiScs+bdcp/TLYOr4AgCZu6QD9gPghInDEhzTsZ2Be8MUiz6qhns
 yLCTZMt1jtVvonltO1RJM+8zM41ItDftHyEf4sFU25QNpqGahedfK3U+0ScjHMftZaEZib/OFip
 YL2o8/sswbaPorAijQclXgCedBn2i7k12Z3NkPqwWCsPnn3ayKU4JJ0M/Zf68u/zZhcJAtvrrin
 Iq5NJr7EMSv+jnAkrTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030089
X-Rspamd-Queue-Id: ECE111EE79B
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
	TAGGED_FROM(0.00)[bounces-9107-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
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

Changes in v3:
- Setting page_reporting_order's initial value to
	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
	PATCH #5.

Changes in v4:
- Move PAGE_REPORTING_ORDER_UNSPECIFIED's usage with
	page_reporting_order to patch #5.

Yuvraj Sakshith (5):
  mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
  virtio_balloon: set unspecified page reporting order
  hv_balloon: set unspecified page reporting order
  mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
  mm/page_reporting: change page_reporting_order to
    PAGE_REPORTING_ORDER_UNSPECIFIED

 drivers/hv/hv_balloon.c         | 2 +-
 drivers/virtio/virtio_balloon.c | 2 ++
 include/linux/page_reporting.h  | 1 +
 mm/page_reporting.c             | 7 ++++---
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1


