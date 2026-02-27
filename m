Return-Path: <linux-hyperv+bounces-9027-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNnbMzWnoWmivQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9027-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:16:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 488051B89C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD9E2311F3B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80E421A0C;
	Fri, 27 Feb 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq1etGyh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U70oG4da"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE11F2B88
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201223; cv=none; b=Is3tRyRGN0kTDNkDhPMMKaXpWElHGIH26ImhEdHZFLwmRD8F8V3bLFRjZnOYNqCqTersDbBJz2NftMM4vsxjhmpLoDKPygjYgY5kmJMVp3oHuBQ02BoljRQzicwxwNleAbHnI2lpxvC/+ZXnPv+aUWirnNnc3+RymDtBrT7QjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201223; c=relaxed/simple;
	bh=naazySnsgbjNdTcLsULUz0vZIulmBOcrahnhbXYjagM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A03xWoOO15OGzod4HD+jzbJMPohNZKshKZFUYpjpp6WNcI7ITODkBWrUhAugM1Fy5EUu7u3bSvVMBIgLX3JhTlDoriOIfSfoUmyLejI/wXKk4ryDWrtvb2wtx2vnKAjdI/i2yFzJ07YEXeVHiPmN5BH7osNEE0koH+v/1OWieUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kq1etGyh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U70oG4da; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9m3FW2403019
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9Pd
	TKktztCg=; b=kq1etGyhNt4m2E6u7HdG4M0LhfYmMYMjrKzNb/KwO0Gociue2Wi
	RJrAsblaFp6itjPUqm9dpIIFIKLwzPyMjVjaHsH/31s8gLCWQTgS3EPduYHxYTb2
	SSlsj+WdzQnjyM90Z9TDfzWm6ZSSmS9VlKn6K2U8vp6EqGDy+SrlXKU6MeItboHf
	6e47c6r+Lp3f9Cgvv9WNg0yEI2AIhIDCPWG6pR7VhrctHW1viqhHTtCUJI0ZCeLK
	go4IA6l5X7uYe1IhTPqlKKJqOXED5P+S4m8FZYF9bjBgJwa2yFgJ82/iUSdPt6D8
	J79wJiETN+6/etseKP0irCCgrfGScEFjECg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjw23b16v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:01 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c27c728eso29107935a34.1
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 06:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201220; x=1772806020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9PdTKktztCg=;
        b=U70oG4dazvfdyALi7BxgtSXlsVEwCDM9LJBkoMEylDn8/CDUyyJXkrXdV+2XvEP7PH
         P/WphxQcirViB/0Rls3K4Mi2QtKYmNVKLOe2C3WeS+6cb/HMzcFK8bQyUaX3dY8v+DuQ
         oDXur4dh1YBi3qCaXQ2Sscpjk6FUihzN/08QKm/s2/Y7bs1HUGf3gikLyen4bYW88Srj
         eiFfDsbEIKWg7BSGigibkiIUEMdy+LojgmzkjQsG6qSB4I6So8alb5xmQ1N97QetzepW
         LyxlWj+V8a7jBJbO+jTk0BUsE2aioy2byRQ6wgH8IWgiBUP5oF12BPs9xEJTG/Y6ObHu
         mcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201220; x=1772806020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQCIY6cePxSMxdE+svAoeyeItLv1W/bH9PdTKktztCg=;
        b=NdLYvNctmb9/Gn1ZXBbZ7IeHnMTn3IfNLapJ6ZKkEv4ftmc03hS8lgLoHFp2bm7e8h
         VZyh5TEaKV2p+c6u+N6aRIipJe1/BpHeI0a+iMmtVs4+9BH2spCxpxW5dOf2nfvojrc8
         PIB/pKU3tAl2byVn9jvRV9h4JsNP0QWR/W7dj3xkZv20TlvofK//mLsAwwUFk4I8jMgM
         B6f6KcTp3W74DSSfAO4fKoYsNVgq3IrB7KhsEidpcAsInGcj9ocyMw92XTxlL9tFwOch
         DNan/SZVP+Y6Iq7eG5pL/AmDCwIDmJC62DivqmCMpqkNYY7g2Z/juflmHjfmlEgrFks+
         rDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiAw5Azy5PYLktto/LCZ+H3z2tJQYbzk24GtdAD3k0gZijp1loqjpKPpTr02reojQcueHVpTTFe5qbrcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckVj4J2o7wC+j6eNtcCp4b8qmDXDzIhUB6fAAlAss9pkm4E//
	5C0WhF9P66wH/0Tx+LoqIRsTI1iwbwEo3ZnmlqvtRDjYLaLsFiCfpDIpM+F+6UtSBUXDQypUn6M
	P5/rnOT5dvcrdpJoaRyySpUL2RQdxkF5bbhmEJQLbF77YtT6bKnbbS+vB0yMdi95AFyo=
X-Gm-Gg: ATEYQzzenRcqMlWN7QBUaStbHL+e7hyfh01R+7V88UVHEgcq21WeEnXdQ9ixtKcR8P9
	GkMOBv+idrxRqkOnEKYDMf9dCwKQOnyn9hdAinawCmKaTr4IwBA43AN3A2lh7GSXAQQmlSxFXmc
	AVX6T5Hj2IS4Ombd6daY2BOaoOcATBFQQuELyVoZsfUmHsOoCTj13Rt4Jk7l21QqfQT0cs9ez0t
	/kKS10SObz7bcsgxrvK4kIS776J4RhaOCKK4ZaJ5yY2XT/4YIR4DRjYwNxOiNo3coCPd8e0hDbe
	+PP40g32jMnz3tdZZm8jlPXEaLr4T24LE9TAhf0LgQ+hikIFcCndhFUVhhTN5i4ckfgvzg1LxWs
	L4q2p8s4in2+1Kyh6jmaomF5dZsQaa1p9XoGYe9hO0bA+Yx+iHBX7fIjXwNScyqdQV2Ay6wLTN8
	rqxx6c
X-Received: by 2002:a05:6830:3146:b0:7cf:d7ab:bc5d with SMTP id 46e09a7af769-7d591ec617emr1870646a34.15.1772201220524;
        Fri, 27 Feb 2026 06:07:00 -0800 (PST)
X-Received: by 2002:a05:6830:3146:b0:7cf:d7ab:bc5d with SMTP id 46e09a7af769-7d591ec617emr1870621a34.15.1772201220051;
        Fri, 27 Feb 2026 06:07:00 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:06:57 -0800 (PST)
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
Subject: [PATCH v1 0/4] Allow order zero pages in page reporting
Date: Fri, 27 Feb 2026 06:06:51 -0800
Message-Id: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JObHvAs5nNJiOKkWu7wpoGcxe-dvBszf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfXxjxocSomAl3s
 o1ClGZzUl3q0FoTCcvecYWqzaEbBMOCBZzkhuBJw78GCagIYjvCbySicuuxkads5OR7Dqq0kutI
 6DXgN4NIxrausW5OYmE29X9ljx63RTx1dStYezq/6iw1mEWu3Op3jW/2Bd/OdyWDSmKZl7nIw4t
 ah9jpxnN+ROyAF3k2zGi2pJEuyGbRAiJ+ScqjX0eeEErOpf+AVcvTg4duOVcjq+VeGJuDMP9spd
 IrhY+9APGEzPmH5mY5u9L3UQTDj4baL5iT7D5XVtkrFoReLFlbykGN0sU1Dr/zFgMrULTyXNjXe
 70Yfxbkh+iQGThZkFyd8TxsdJLU1+Ig3IfkPGYpxMmnBSe/CQr+eSAJUNJAm/K52NjLHepNqoN/
 pN6TyVdNqVaUVjk4AplovsZYV9x40IwariQMomAJEvUrfHYKgm8IefhZdte2oEIYkvGycYiPK+W
 XfR2IQaII+/6TBZJuPw==
X-Authority-Analysis: v=2.4 cv=cJHtc1eN c=1 sm=1 tr=0 ts=69a1a505 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=9ecvtSpfVrh-a2M179QA:9
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: JObHvAs5nNJiOKkWu7wpoGcxe-dvBszf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125
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
	TAGGED_FROM(0.00)[bounces-9027-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 488051B89C0
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

Yuvraj Sakshith (3):
  mm/page_reporting: Allow zero page_reporting_order
  hv_balloon: Change default page reporting order
  virtio_balloon: Set pr_dev.order to new default

 drivers/hv/hv_balloon.c         |  2 +-
 drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
 mm/page_reporting.c             |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1


