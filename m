Return-Path: <linux-hyperv+bounces-8999-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPMUFzbwn2kyfAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8999-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:03:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFC71A18FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53CA230BF879
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C938E5FE;
	Thu, 26 Feb 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/VVUEmd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdHJtO10"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFF38BF9C
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089296; cv=none; b=mMD0QvQDiDMn+8pKLd1MJmZEQdStYkaA6JUjoRqMHayVyCJr4hHDDd4X312GjDUUBAKOthkfXfXPnG7AmvklVrcLXAdqsdC2rEsXp2ilBJUDBV2H1ayZC1ptyKlLVh7tpHZ+rtr0LiGmctlmMqWQgutRquGFiaDXNa5BD+5IDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089296; c=relaxed/simple;
	bh=lQHqTjYwySZ6Qu+mrO8hLuEcP32RUNFMW65aLqVKwuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCq0fau72QcdEdFINpSC4Bt+ynI25NNT7sLA1Xa6a5mE/yQ5JWwVqYzO4jxkX/uTPqXzWRIYD9UoqbuD/0rpSzyVba/FS10wIguZrEC+ToKwere/zk5UjiLb2Jrl5xC6OaCc0DDcehBCGICsThlsv2hQmzIEL5ZN5DnEfBCvwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/VVUEmd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdHJtO10; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VLAE3721912
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XvgXEmpB1r4
	WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=; b=Z/VVUEmdWf/8o6COLQb8aFCUwQX
	Dzc5c7cuUzkbwZJ/bMJdJAP0hzVO+oLJ3T/lW2HrM7WY/DA3IpQf/jj6phlJAsUF
	e1jW5k8BIpSAR97a7nDM8ZFmcTVCrck0xpuzStPxj8lMIroSxSr5OYgQH4vPUqxJ
	V38nO5fYQaNhqUDTTo69YZuHciN4aH0+7K/zQOpH8HNJQJDS8/NA0Yug1JOpMfJk
	eX1oC7YIfsDMJYFTCYWVpGcoCnCIHgns3VDujldX03WCjXJFxEZ5e6+PnCJocF1O
	7pxdYMJEptVZW0tV5ejFvRoEqNbEIMNsnMCGnJgpegAmY7H1O8FotCDV8ig==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyvf38sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:34 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679caf7ec07so13123327eaf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Feb 2026 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089294; x=1772694094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvgXEmpB1r4WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=;
        b=YdHJtO1026IxtNwqX/QuaY7DlFcjE7ChgQFgzi0YEVxIFon61ez7MprwnfOalDCFGd
         THK330PlA5e1N2nFr0HZhOjKLwla8khxtmBMRgZCMDNezpulceMQrKrSglZJ6URn8WGQ
         cUKg/XorL4C43Z4RuskKsf3C07uKTVb1KiiXmuH7sKoJd5PuVmmDGQqZo38jcSgROsTx
         IwfPx6adC8UNc+lSEqxO4VdT6NO8PkKykqxSq/uiaD1AW/Gy11EekOWELMmOCQjInm5W
         dplc6WGDvhYlR7jZeZwv5UB7YQ8V4D8jIpr0nV6y0huKcFZ+A+BnGPzRz7TO/C4jtn4Y
         53Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089294; x=1772694094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XvgXEmpB1r4WuR4fOfrjdVLui/7pvUcm4fS6DOtgW00=;
        b=tx5e8JNBhEzi7XfiGJRoaZziOLBc/b150P0mXq8zLtwi5RYuhXZk+RPZ7uX8LrHXpA
         ZWC03vx7LXblOtyEIEYcca77yOfX4/4oQMMtg7e1P7bk7pU56Eegc1/CudYI+YeHIbC/
         IJ6dk2v5Knr2/9TgvOoEJJ1wS+5GpSfu+CtIxoWoiYWdCqsc5uPiepEmb6ZT3XkCsko3
         UZcGZbD+wiXue+5PYcJbCtFp7rESLDOApeTLd6ZZbe9grTNkM1fjDbWf0VQABixX3G0t
         KOWi0axJjOq5t1P81ayL5KWpxvHHwYfgs86np1koa0X8KPHdZpoYwCTJ5Ho7pmF6rjlY
         CIAw==
X-Forwarded-Encrypted: i=1; AJvYcCXU+uVoJa9IZSucx5wQVjO59vucfYjKVXC7Hh9XPA6wr3aCFcvoHOYtBSLUvQae44Io4NgQltdDXuRC9uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlH+sSPCSildHUqPOzXU2lPhTekcMQbzRYpslH7vuY4IGG2H4
	x6TtSXyYSgWxXs9JBBhpmF/c/t+aiSz4OKxIM2lkZ8+4nz8IhHYsbT/Nsg4tHO9tE7ti4z0e0J6
	LucAr9/gis+xzs66QrpedLKlWjAleksRfCXp2PIeOy07XAnlFZjjnqScaGstjp0XAsgA=
X-Gm-Gg: ATEYQzxwxLT4Y6rF3v9QwbjYF7/twBLQJKwM8yzU0HERaGdaDtXHLENDZB8iWBDFH75
	nLMihi9CvzOVC0etiRNCO3GQx+A9scp4OyIhBKH5nK4tQYfTeaWIw8ghr8BahfJrGP1PxcW22Nl
	eezMron9MK/5eLM3ZtRUQBuUdr8c7ereH6SIsUGjN5ccZc/y04yAaIgafsaGw9PDzqCi/Lg+eCC
	1Xp92WzdmimoOATh1c0KKXsZJ6FKhc8cDQGdNn9ML7voWiMi6ox4BDCWze/TKPs9D+jOduslv55
	9tJEjCXTeHSra6m6oxqGUpPLoyglNtzwtlF1tdvOToRD+fDF2AuyasRtwKityX4J6le/vg7BR/0
	rygrMIZYgGfKIeraJx7LUnU+g6W7SgZaiCr9xCRrBSsMQO9cJLH/ZzoCElDNJIRYyhU2DpX8XH7
	UGsz2D
X-Received: by 2002:a4a:edcb:0:b0:678:a4f1:c396 with SMTP id 006d021491bc7-679c449b538mr9081254eaf.30.1772089293980;
        Wed, 25 Feb 2026 23:01:33 -0800 (PST)
X-Received: by 2002:a4a:edcb:0:b0:678:a4f1:c396 with SMTP id 006d021491bc7-679c449b538mr9081248eaf.30.1772089293586;
        Wed, 25 Feb 2026 23:01:33 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:32 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] virtio_balloon: Set pr_dev.order to new default
Date: Wed, 25 Feb 2026 23:01:25 -0800
Message-Id: <20260226070125.3732265-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: QZ9USUbWloAuqbcyRXEf32R9g5zLN0tR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX4KPFJ5M/QPhB
 n6/wgH3I85214DNny4JC4fY9z22A9P/i+nkn7jvFvgZgNHj3tnJbc8wWoEfGhNrp5JS2zaRRHBi
 FkztO2GbXoJsULmjrtX/cWoNqcGzdosHewHXrUyJHMlE0mCtePTRfR+CnQ5Rh4IvlN8865sKnKh
 MZAa8mMITdXaYu3n1ZrcyHCZ2KEYiit/LWhFXGGxMJ0UEOFVpatOlh4RygOpCi3nQhKboaR5APV
 CXmS72NE+DikZH7BlAsCnbvebzPKEvl/J2OzEI8iNE72rk0qAUGBIlTAWLTuMcjj0ef0dweS49r
 mxZPn19igZ/yIsJBWMmdWSr5eUTG9mRNiOEtyBPKRIC13clhnH/oomkT5fWZOFMaqIGAyWxbrzm
 NOjeI5a676FgifjWXscSAAn4nFqT92yDRuBk+XMOZZAiDYPkYZWtSe34tBLdoJyi3xjFFINadPB
 Umrel6tGcJsinjELSyA==
X-Proofpoint-GUID: QZ9USUbWloAuqbcyRXEf32R9g5zLN0tR
X-Authority-Analysis: v=2.4 cv=dZWNHHXe c=1 sm=1 tr=0 ts=699fefce cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ORiy2k6iMmxUqhiy1H0A:9 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260061
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
	TAGGED_FROM(0.00)[bounces-8999-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CAFC71A18FE
X-Rspamd-Action: no action

Drivers registering with page reporting used zero
as a way to signal page_reporting_order to be set
as a default value (either passed as a param or
MAX_PAGE_ORDER).

Since page_reporting_order can now have zero as
valid order, default fallback value send by drivers
to page reporting is now -1.

Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a..3cc3dc28a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1044,6 +1044,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		/*
+		 * page_reporting_register() takes the order either
+		 * from the driver or the commandline. If neither
+		 * are provided, it falls back to MAX_PAGE_ORDER.
+		 *
+		 * Order given by the driver is required to be in the
+		 * range [0, MAX_PAGE_ORDER].
+		 *
+		 * One way for the driver to not provide any order
+		 * is by setting it to -1.
+		 */
+
+		vb->pr_dev_info.order = -1;
+
 		/*
 		 * The default page reporting order is @pageblock_order, which
 		 * corresponds to 512MB in size on ARM64 when 64KB base page
-- 
2.34.1


