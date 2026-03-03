Return-Path: <linux-hyperv+bounces-9097-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMW+Ef2qpmn9SgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9097-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B371EBEAF
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D8430498DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CF38C409;
	Tue,  3 Mar 2026 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpjBQ3Uu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W81Wbva8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BF38C40A
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530427; cv=none; b=O1gcYl74gKwNbayYjwgq4ymQLM2vjdLuUOg7tulEu6sribP01D/lp2XtGla5+mgXJTkwuhLApKOMX8b11RM4qAcjl2QfE0szBjz0LftMreK24ymWYOeVVXnWbUCcDqxVU0FPOD46LUnEq00kQkjttqM9/fNmFDcVPXqKeKpmMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530427; c=relaxed/simple;
	bh=5k9PqMhpT8YU1XAnXotU8YC/eX2TqWD48lbtPVg+818=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfuxq1Vs/PG+K/qXc1NgJRraIEEQ1Mh1I3JUzS6VcGAI37sMVROP8AiNQGXjQ+FLuMPVHMtAK4BHUYpsOvIMvoUymxelqPIiEbXTNZSKWc1+Vr5XCkfQ2cZsh1HriETqsv1s4LMFYxFHrzoINT+e6qey0L870bBvy83y9saQ0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpjBQ3Uu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W81Wbva8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62352xjI3356312
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1
	mPomm33Q=; b=XpjBQ3Uu12WblyJhgX+AvwyVf7GKvlvTqaofR1Iuo+GTx3nD7pu
	zJFWRN5SbSyG9B0l6aDuGUuG1sIjGgJPz+MZ3CohbG7S1phKSLkM6qImDwGWRFWL
	Q80U9L2dBCyeK1J1xHTKkN9fVfd9sdby+E6j0e9TUHLA1WiBncK6oJNXbUe4mEhp
	DjQ1V1d5LcsrOZu1/JP/If03TazDsvUIomCu7cZwva0F1LgIM4j6lC8wbHzsxOIE
	QQ0MwC13PJsoxjpCuZrKuEVn6logXsxcdwjPEI0A+XgMKblxAKfcWo8+yrDwcWiX
	72P7m+bs8bpIOSkOWdORSfP6Z6YOJam6DWA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cns5frwct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:45 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679a409a175so106178771eaf.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530424; x=1773135224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1mPomm33Q=;
        b=W81Wbva85t69xpbdZDQ5qs0zXzdzI9OJ3HnoiuRsrWietb9EWYc21Uy4Fv7xMcHK9C
         qswOIzxwjhYbXucMTR3lq7MF84YiFsxT9Sigsu5xMVeEM00IlVdsu3TvIIN4SuWooIne
         ZS7pom9/fhYUjPXCit2Ah7pLUYtUkQ0DWWwQdLaLC6DiLeoDHiGIOeEUE9xFx7RVx9Pk
         fTKO6yzv/vUbHkMqpjbEZT9z+6/ZYTXcInbKnUfuA3dY8K/1PtPIkaNeRAgESCr5pWRk
         NTyxpyvM4US25uBPjZqqE081X7oruY5REi1C6vTE1hGgF5RxWAhWLXMM24oBBG77BAfX
         WDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530424; x=1773135224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJLx4++p5N7l++8jI9J/g474bxq1j9GXBe1mPomm33Q=;
        b=wlclY+Dq5hChsxFMTpBBDRyk4b97vPAOJMvtLEdvgRgP0WRtltjBviqH76ZxyvL85F
         XaIctCbhnh5R/fRvLZ84y8Re+CQInnYYDRiFv4ZykJSFx1iVmWE6741vspirIFeXbOy9
         R1x0H5iu55UltPQRMPA7HDKlv+ZsiM3s/O85ttGVkIikQqrSxAt1qoinDH0N2GfYDM8J
         LZhp9osmkftn4jrQ0qpIGR6L9FGTkSiGyBmC0Goomf07g6QruCN1THjfFTSEttqfZ0Gg
         tA3LAspVgytYXPTqRqGWYgE3REUpLIXuSw5qBvAUQOsj9Vl2AiHWvJW9M1LCKn0vRokj
         dokA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1rEmZ2ksNAeDRCKDW+JwlHmGKJEQ/+46JtNRriUQNU2sPodjbx1m/E6kuuklIMEcu0qXz8tE08wAuuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdByksrMbf2yF2nXFQEtmi66HLsEM02uk6gWL4dqUqo3vXg+5M
	3CycYqXV+0SBbWDdwXR9arLT+6z88/f8wtr8SLNiia1aViAp1BYpDYV1O2INJjzK4iIUt8YCQjO
	tUtw02ZCoTR2qcH8pDOhqUWWJv0utwUfwZbeG/lSNg03z6KSUINdtnOZyU3lpQEjWdXQ=
X-Gm-Gg: ATEYQzyus0mdyJWx1X13nhfDsJGC335kPpGm/4SzhaESTNtcdp3a9UdubJxsbz0dH8I
	zWLQh7XdxS5YBzQoJmevKzR7fN6C63eWSy+zPhRkYtE9NKFvjEfdzax6HF8aOitX4/yVpsGY4eB
	OxQMJXNzHznuUv2noeAAi0MNGzicVCr5OBU28fec47YuPLqLfg+uJAQkZMvzrqMkkRot7Xgi1J+
	Ysm21Bgk88+66kSXiW29K5OZycJ/Oa+YelGu2y/YGb7+OOaBr654+Ie+ozF6VBNtDaomsMrlRgP
	853vBhTy6hOK3E7CZvoP7eOLUBkUiyZwewqidjEWqLQ7TzUJzkqhfxsnhp3ZD3bbWwd4i8qYOfb
	0CZPe8tM0Xv3epqBfHGat7aFLtebfeVQ+VqDpDr2R64df3wM0Wy8NtRd6MrjKNF7PU+N3n4YP+a
	rEQVqd
X-Received: by 2002:a05:6820:4de5:b0:673:3cef:fc1f with SMTP id 006d021491bc7-679faef8a08mr8486870eaf.38.1772530424282;
        Tue, 03 Mar 2026 01:33:44 -0800 (PST)
X-Received: by 2002:a05:6820:4de5:b0:673:3cef:fc1f with SMTP id 006d021491bc7-679faef8a08mr8486861eaf.38.1772530423888;
        Tue, 03 Mar 2026 01:33:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:43 -0800 (PST)
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
Subject: [PATCH v3 0/5] Allow order zero pages in page reporting
Date: Tue,  3 Mar 2026 01:33:36 -0800
Message-Id: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=69a6aaf9 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=HYTG7BDJ-qdBC1FqdxkA:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: hEo6Ly4JEekOP8UIDJvF2Ry7TCfoadMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfX7vAwlGDndbra
 BlQtVUuyEspAYEBQJ/EVX77cBlbo/jIpbH6Y9bhBD3b0Qg7snz68jCDkOgws6Afgwtkagsuxxt6
 2WlEeTTpveSGL9f+21/fwPCwkwa7gQIXAbp8D+yTc7hQyLYRhZtuMRG7HrscCxN99zy92kfqACn
 CrgO8ctTgw6UWddFmsFyCjw0BVgqMs1gErXuckwtQVKWJuCMgynCbDnuey4zcIkftBeyke9Ft6V
 03rmcRy2Kg6EAN3JvNx83hWaHgirek7tsai0uMzMm79Zh+Urd300qWZOcQul51+r98B+3wsjDDw
 w06peICwd8boLZevRQVHFQsVxNZpefOr6xwXflVcOLtU+IeWaxTG8gJxyyWEskLbvNFFjdCbKBI
 7KWd/ars84ekn2nPspLLunioJYEMaVENm/eMKdr2Lh8k2zUTplXmRpRn6/+Q1MtQt6Hr8E4a7MF
 5kHPP5fQGIPtrNnmxkQ==
X-Proofpoint-GUID: hEo6Ly4JEekOP8UIDJvF2Ry7TCfoadMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071
X-Rspamd-Queue-Id: B4B371EBEAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9097-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
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


