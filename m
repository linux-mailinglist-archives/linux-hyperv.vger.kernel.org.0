Return-Path: <linux-hyperv+bounces-9031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP0YHXipoWm1vQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9031-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:26:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE091B8E0C
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 15:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6BD31F2A21
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Feb 2026 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6498425CCF;
	Fri, 27 Feb 2026 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="azyUuvz2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KRp6OH6F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729A423A97
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201230; cv=none; b=q+Bb90NjXxkwXDrVyShzffOHNq4Wg+L7m3pxcFlQmqqf1Dh6ufcb3+/X/0x5Si67tYDLWzi7q3XQfPaZ4bTkDkCQ8JOJ94yaccjAZQlJUs0M73/HaMfYp/t3rPCwotCDW2NgQtZPvE/606KYDr/TVGkpi8WRhHaXRao0VtqD4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201230; c=relaxed/simple;
	bh=ROmmXX5VHYzob4RcDQXPVNrZadRdQPHuQymrhi8wrIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7WdWhfm187wn4W1+I6DX2Tlc41THvWVgtrxcd5dRHjVO2O+80accyjLl6YVsGBDHYaRtA/hGkx/OhDodJm/V/oxWWaWVCEgDnLcEUy4S89MbH9z79hsTjeviDVOT2Z7WhdaiqZuL4iYgpwslFWYthK+creQCEC9TS96u1bVPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=azyUuvz2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KRp6OH6F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R7fPMu2307392
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y/M/Mw/VkIM
	mop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=; b=azyUuvz2IKdTpCeERnBMi+mG27W
	GbwNusPYUJBuAMRi7jt23oZKPEppod3GF1AyL726d/GmEuJLXrj4QBq+I7Y+jFAM
	mXJVqJLQ0goLEK8GRPj/8n1YUy4ndj102N1XnE3bthZ1qhH5fNr72BE3wNawuPQ9
	Jiwb9I0BMGS4sTMm3RDmvyvBYEv4M6+tddAfcZ/DwNmDrDlidnH6/jE6YzSaiDNl
	Tc9nN0gJUhuwVW+vbR8lspJHMk7/fpKcwTaNfZDGKYHjoI+lljYERrALXaOZNKKh
	QEKeHYvsRis+SruC9PhXOMFaZmoZQSFwalfp2b9PyqDHrxC+RFeF416hT9A==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q14x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 14:07:08 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c14f388eso11131068a34.2
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Feb 2026 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772201228; x=1772806028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/M/Mw/VkIMmop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=;
        b=KRp6OH6FTbJfe6wr8Kdo/vD93KejRPGrFuBV2lSVMqr8MWlaG686NC9t/Ky5xpCJhL
         7b/LryVPkrCE/54YcN4jEK6fTOB3/AX/mH5Wf2J1M1Yv7eKdL/OADual+7X/M8qm00/+
         SThhg19xS3kFWjBIwJXs4jGkHysw5U4pbIn49VYxYTwODlGggMk/ZllQyHxHqAN3LnqO
         ekSroJXdxMxWn7+lpvTeXBn6Gu89M/ue/zFfrBfBufYWrvMdAFg9B6R6p/WJLPuJQm/U
         YBjryJ36z2ZbJgOJ1zaeuLgNWRQ1zsrEF9ZGeFWEflE7sZQQKXcinJqxfhLUabBQQuDU
         WAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772201228; x=1772806028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/M/Mw/VkIMmop6kOgPd/ElQCMlQNXPvBeXbJGToyfE=;
        b=DnLeKdd/xU1rsGep/BseoHDWzWYpE0WIXZa136VhYFRCD6D5NgQYLByFsvEzinIKVZ
         tWQpuDsf/pmTP8d8+jOQDilDJwJIhQAikbIylqBtgp3F1maISzg57TnYmWMsjF0aQtY2
         ZZaqzzc5qtV02Cv+NN5OVbJVw7b0B/4cA01d85tdHHEvwEvEl8MPw8+EuTXbdEbgPLIo
         R83BF/yU+w06ox8TaRxWhm8iKE8oyT/8X9XpiyAh4r3jngrZEHSt3oUwmVRVLpWLX5WI
         +j/GqJQo0x/8teYtTbUA6m5t1AHFa6XsPA16AqVuVfa7TLwwzavxnEVe1DKrGSx4s1Ft
         jKIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxquZKrjDYb1s+TxlZ9bYfVAJouAIF0fAx9+fVitmrm5J3QSTgDEU+IxWH28QtoRpxOrg3+dtIoA9vWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0KJeUigFNx+Xcu/jiLVm3JVcMyDVyKLgJYDNq6JTKbMt081TC
	jz5RD6mZaymU3fH77aVe6AUjBMaf66zlZZOYsD7ZFbbsSaSmVv4jAjcCU91ajhmG8unBEukvKpU
	207mgwrobVevxOkksxJaAENEotNMi1MyU5dK8H7Ur6+44e7Pd8g0AI9Gi1Q6YGcCZtiU=
X-Gm-Gg: ATEYQzwh1exN3/DmVgXMVL7xyfHfFjM1hAO5RVMz9+dpfmVdKIq2Ds1lHk6f8T6tJYi
	b8BBWzt8cMQULZ30zdoWkF703S4u/EedYBvPmnvQCU9omcGDQauWfME6nt9yQ5uXuOilVTjNUY+
	wmzPcAh01tm7tA/h8YaoZJQ/qOmngq1dNOvM2/nDBHxvNvqU3inRfsasGblFfqINTPGbx/O7z1e
	iGGSQL4inCr7a+Lf5bo8yd9FxK6njm81LY2vXs/N95MkgbLJIB4DTA6M63iHGAuRAb2zkhL78jt
	z/1Y4YvgGSzlQiUWuCeX5SYFEspBlG6vFwTjblpK20fSdu2SI0SmqcHBEjd1qF9smn+rqRLk3kV
	TMtIF9P+KKvo23dtpHHqxA4YGjfhOF7O1SFCypzrYIlJ9UM52508LJMkFteXjwGkwylN/+PRNE6
	NpeJv+
X-Received: by 2002:a05:6830:630e:b0:7d4:49a6:d9fc with SMTP id 46e09a7af769-7d591b03f93mr1986597a34.6.1772201227689;
        Fri, 27 Feb 2026 06:07:07 -0800 (PST)
X-Received: by 2002:a05:6830:630e:b0:7d4:49a6:d9fc with SMTP id 46e09a7af769-7d591b03f93mr1986566a34.6.1772201227199;
        Fri, 27 Feb 2026 06:07:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866269a8sm4324502a34.13.2026.02.27.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:07:06 -0800 (PST)
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
Subject: [PATCH v1 4/4] page_reporting: change PAGE_REPORTING_DEFAULT_ORDER to -1
Date: Fri, 27 Feb 2026 06:06:55 -0800
Message-Id: <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNSBTYWx0ZWRfX7wYiZLC6mY8d
 XvSXk4cxwx4RCbXBE5MLrhWs7Auq4BAkil6kqlhIjXeyMR7YDztLiKop/NfW1x/f6yhYoxW/rzn
 /NNM+zdOvGyXsjI1CuiKIlsvGkYdl+PuH9j79o95sGv/lv8Qwf5BfoWV+4ce3BdZ2lmtGwCewHM
 2ifAEWvfSgOwbGyGpHJohJ0G9o/ogZvQqKvkNGl+VzJtp6TvlBbfEB5l/nm6ZzBhpFQk4O99w2V
 p67LxKPjzQ/k+t7NNVjDMCOoifymc67tcCMhIiWzWA17m3W45B5YnH/9Wf/RkaBCL8pNC2gVVTA
 TwYYhnubZq73t9sUZO4Ogo97Q+HikQ+ZWbR/r0I+3JHt5BZIt+rtgKb+qnB73LINVhZ3CAmd+oy
 Odp7cU5uOqw87qy17a8cwXMJZqkSN3byNyldNPXt+b4pWiK+XR+ajJ9SWVWH/nYI5qgRvL8Zukh
 gjQAVxF9i5u1s5cnQ/w==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a1a50c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=6q7Fjfde3VlTRWJJNBIA:9 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: h411FFFWOdTsl0RwSotIsxsPy317IEDc
X-Proofpoint-GUID: h411FFFWOdTsl0RwSotIsxsPy317IEDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270125
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
	TAGGED_FROM(0.00)[bounces-9031-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CFE091B8E0C
X-Rspamd-Action: no action

PAGE_REPORTING_DEFAULT_ORDER is now set to zero. This means,
pages of order zero cannot be reported to a client/driver -- as zero
is used to signal a fallback to MAX_PAGE_ORDER.

Change PAGE_REPORTING_DEFAULT_ORDER to (-1),
so that zero can be used as a valid order with which pages can
be reported.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 include/linux/page_reporting.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index a7e3e30f2..3eb3e26d8 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -7,7 +7,7 @@
 
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY		32
-#define PAGE_REPORTING_DEFAULT_ORDER	0
+#define PAGE_REPORTING_DEFAULT_ORDER	(-1)
 
 struct page_reporting_dev_info {
 	/* function that alters pages to make them "reported" */
-- 
2.34.1


