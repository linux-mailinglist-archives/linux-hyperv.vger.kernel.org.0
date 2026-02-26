Return-Path: <linux-hyperv+bounces-8997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHILKd/vn2kyfAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8997-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:01:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0851A18C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 08:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 040DB3065ACC
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C438B7DC;
	Thu, 26 Feb 2026 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ya4sAlE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRQLPfu6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC892D7DD5
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089292; cv=none; b=MWST7UCjd8UW2N/FkwDLnNuFPsBJAPon4+v/3ioceMADF0Vit3GkGiFFfCetFUJlAJn9+0nGxGvnjt/4+/7O7773hojLzECXhOlSytcaUlwMBjXXYqimkAIPeF1yPq+M+6HE1J0aeZAi+1gdusO5ZwhtAMVK//9S7Q/6207QOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089292; c=relaxed/simple;
	bh=CsqiwpOdkll6suZ+hlMAdpw4JeyYyHfQkHGgLakRBJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rkDxL30nIEOSND7zbtwd4pnHfEqMyA6Ozr/ZS9eIJO+rk5VozjLFcgdnkJFyT4KC+otwcEwoFvXItC9jVR5/j2/UtR1KbO1ntqilldMzdhaoJC54Uz9O9zj6C57YE1oEIaJ+t1uNS8KeVuAIx/7jE3DSx8BRqg/2YRLwIzNnql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ya4sAlE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRQLPfu6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VAvK350356
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY
	82DlywCg=; b=Ya4sAlE6cZED1TsJp0N/e8giADq3gJ+NF1qRP09P9719UhGwGO9
	L/FZZLty7P/3tvJsO6JPhbvUjfSPhrK49H5H3hSi5PzuTOOv20cNo3deZs1ynat1
	Bb4kvV3nAXlM3MGc61VVkSVnkHEwsKpj8M+tXGcL+nHght3c0R0XrMEwuP8qzSd0
	P1ujIQ7dmFdZS3s8ZiCVACXG4yE5bFs+NePLz8hvM3FEpa5va46xsFc60xKMVxHk
	zgW79jaDFMMA63voIpANTd1grL77YxS9Vv0qNsQUE89CPbN8skk1i2ku6ls13w/1
	FzxR5AlP66uTH9ZYAq9O0QzniBwQeh/X9sg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54pa5vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Feb 2026 07:01:29 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6798921eff4so10205174eaf.1
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Feb 2026 23:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772089288; x=1772694088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY82DlywCg=;
        b=IRQLPfu6sH1c7XlgdaiQxjtSOsB9PbENnEE8pTovPEcIgtvL9sFNrYpS4uT21WoXDR
         HXyiqqa36g0EKyqz+uEH+BalafP4rkybapraEmxDrHotKbyq7DB1C3hihP6xa/c11Kjo
         xGeSXnXxfAUVtK2zcqdyl1sRZutFFtf3KralnfTA7SJykW9wVplJU6+Jp1helu9G9LDV
         lSqRV7EYMPAwLpHT6tvwhGjhVVfHABYcE2/Nzc8fnOqjLOJoXt7MBNocKKlpJZTDtwYc
         /hSjvtqzuwczQjEDIVQgjsGnQjmorKLGEMNqOGnoNKhB5f5eWDg+g3fQCSDZ+G8o3Ww8
         Y7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089288; x=1772694088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd9GytnbLfNGAuFQVvbct7LRRRfzUwf7RxY82DlywCg=;
        b=Dbq6i2YLtf1YUkb019Pj2UGljyEWvHS7mAW7hVZghAtcO7Tdr0ZTMYJoW85w28CKc5
         8NcwMpLqtf7Y9Iq6O+MyVp09Kjuc95s03BLV9w/wCWoM6GYpqN+0b5poaCKF8wYKg4b8
         AVp+JvRfNFocF6Co0kBGPbw2I7ivhqMCmAIBfhd+DrmE9sawAj++clJ7u2tAX5LTUeJm
         KM+RLWR+FWhr/gRypZU82WX0zDuH/oGZK3ur3iWcICXYgw8bAGT2plVjmBlaA5eZIJWP
         xaolvKtx7qctDkyZvmB2/PMwW6wK5TynLq/1/vE9uoddc8ew/Ix9VCOZMX9dxiDOXpBo
         eG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRvonsrC+KSaNxdcvu4IIjUQzFWW4gGgum2LUVfj4axnUt5VZJ5GjkYX2l1uZYwZBSL+B5s1vqwuKKZZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0qF2ws1NAkX0FoJt2z5AyHZqNW7AKNkwswMnFXHEjNXR7l2C
	1g6+orAi6EWZBoWVJn0n8qjvf8R+/K+YpIy9VZRh44J3H7ntKjWb+Yf8Ha6MXZM6WiAN/KaMS4v
	WRlKBADwo4nGiBLtJcCpCP0wgH/1bExGRvXGiAGGHbrNW4BzFQdM7IbO8FL+ldSQI/ss=
X-Gm-Gg: ATEYQzwnmVu1OQDEf2Q1MHSAaI0tG+ftcup9Ylwv5cotUzKs1/j27uI6NRO2k0qicR2
	ChzeEvQA8LIwgbBQmjN312ndAx4a5b6GsOLy1OcKx1WIInWG9N3FdcbZHIHA1SOXKzbsJDJZ3JV
	GwIDAYTrIbv62vGaO8NlB9FERcelI/nv2cg7LObhlVuB7U6xRbMxrGvgrvIBLobDB/S5wqwcN4m
	W7+IzZtBlbTk1x1IHwb3cMIo6kVqOW65bcpaDkLyC2PTv8cgZtNRlrKtRhlZh39jzlxax8BqVEC
	ZXuSPyOd8qXULxHIiKPPR157VKdvIIQLC4pn6Jkb0FkyFtIU0lzUXsvn0O0cQNjL1EXVzX+T3JV
	r3/mIyXtBOIdTJCWbIrNE16zGgZbog17Xv3hnYjQ1rX8MkFQ/5iECgW5RKO8Cp/itpVxuvu6sLx
	Vh6XW7
X-Received: by 2002:a05:6820:1f05:b0:679:88ee:e3db with SMTP id 006d021491bc7-679ef9aa12amr1654184eaf.70.1772089288473;
        Wed, 25 Feb 2026 23:01:28 -0800 (PST)
X-Received: by 2002:a05:6820:1f05:b0:679:88ee:e3db with SMTP id 006d021491bc7-679ef9aa12amr1654157eaf.70.1772089288041;
        Wed, 25 Feb 2026 23:01:28 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm1013246eaf.7.2026.02.25.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:01:27 -0800 (PST)
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: akpm@linux-foundation.org, mst@redhat.com, david@kernel.org
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Allow order zero pages in page reporting
Date: Wed, 25 Feb 2026 23:01:22 -0800
Message-Id: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX7ysFvp5LEjti
 OGWgzwbKgpTYAnrswTQn+Bk7Tl9allphqpQHu+WwS3EaqWScFK/UW6c1oHzfLPx+jl5JZOpEDI8
 P2EN0220tMXFNykRyuMadgOKEkxwwOP5WLGw8qfmiwc1Fd0+diUctLufmuY4VO6GmNMmOnipbCG
 4Y9xRDpYIJkcLyajxOyZL0MauUwBrJsAB/UGwmdRqXxMD+cGYatI379n0IEhB8zIVPZ9vckvWoY
 CRwgun5AjKjy0OKExqQCm1Kd/RMYeIlARmh6IuEr6Hdy0afLRZQrJu3u9ezaZPMYjbITSPack7n
 uxR1k9OWz0NxdQsjNghepdvikBMt67lKHtqa9auuNMXT1gi/pyU6FI/NDK8LIRAlpEFvd6VvBOz
 RMtHjl6rRaStZwc5rgi8K9Oc7/6d0/Mxqd4nLMEUIy8jYRL0dp4F32hCcdNVOcQSfhJHvXQ5q5G
 FpCJ5yxhTql3V4M05MA==
X-Proofpoint-GUID: Fj6nMEpuwcZ9YQUFSj-GL6pk85P9rW47
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fefc9 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=9ecvtSpfVrh-a2M179QA:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: Fj6nMEpuwcZ9YQUFSj-GL6pk85P9rW47
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-8997-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F0851A18C4
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


