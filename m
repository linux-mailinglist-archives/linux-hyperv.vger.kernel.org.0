Return-Path: <linux-hyperv+bounces-9100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJG2GBirpmkySwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9100-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:34:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D43891EBED3
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 10:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D6F13051482
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157C38CFEE;
	Tue,  3 Mar 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhJ6LbCe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QOwB9ow2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19EA38C434
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530435; cv=none; b=fLjlpUzd9jbpl2Er/sW7DqO8z6eXFiogrQ2UHMIJoU8KiKMGQJwH+1DSZPByqW9n/BQxZgucw/UVWRrTV1a/zpV6aId9gifJRpxe0vo17bIRGtgKBWj1MZqjn5hjNgnae43DvN/ABFpmDI0FDBBf74fdp2XzhvJrXlVohHyEdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530435; c=relaxed/simple;
	bh=LbKFNBiZ+VRrB07vX9O8FknKJ9OvEGWcCKyR1m6xhDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jSL/oCOev1dNhzx/YEVx3/r996o5I7T141lL8bsqulU4ryYrARIAetmPLEQru2QnL+4gNJa17Xmqu5roCnUxMYLUaQ1U3kN2pvppNNkocp5kGl288QJbCBjZjfY1FrmWyMMTvsh+e1O/+tfCgj9NP2twhFkRJuL/JDXgkEZDmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhJ6LbCe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QOwB9ow2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239L7wq2554038
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 09:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rSSvKdrdqNt
	Uffp+vZHypJOUj06k8TVBSBVgyR9aCmM=; b=DhJ6LbCePoXnCMouZMBaR1h51DM
	d05A0Z/R4oZD1dZxptQoEebeOA0ejjZSI4mfa7qiC2rxDkdvN5hJaSlOJtuQ1Oaa
	d8ITFjb8FNli8D4tAsPOkCQ2tTWHWT9yYNfaBFgoV6DRAM/JrOuqPmMkptAcWiYG
	3RYJ8FHeIURv8N+K0Vm31stgotT6Smfv2PTQMl9p8VnNRSfQTDsdjjLAs4LW44BA
	UKDPX5lKUsMIbDZY5MVppel4IddQRyvdfXMh/BXEOCUDMvJrUnEiWHDJRHja1YGp
	60jHv0fVQwNJXn/QzTqmm4Uaii384cEfsiZ7+LQxz9ExqNa/gnyGNVYxgMA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxf81mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:33:50 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c69b46c6so49429419eaf.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 01:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772530430; x=1773135230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=QOwB9ow2vYQMweWTUJHBXfIVvJBX3MA3VaZeJNy6uB830Oyjb0KbZYJ+UOWukA8E4b
         JeZJQSPj5U/5QyhQKKyd0UuRFnGK6njx6kRB50s0c2it6AKNWvLKdYPJB+O1Eiy0SpgF
         +DGbapFSzZVAYqE+3rDwZ9DU0mpOmckDVNPqL0ukdzopNBZ/IysbIeJsvhzbG8gkyrSc
         WS1JrDfWu5nrfLecCWnCth/8PjR7h9CBTupnZnALKXtdNrnmspDbgrpJP5Tu9PDORPKA
         hLvXxRV6wHm5IYNXy3RBv36d/Yk/CYhLW5r/Cba1CuAWGH4y8WSNg4s/l6Y/7Bcnv3Ou
         j1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530430; x=1773135230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSSvKdrdqNtUffp+vZHypJOUj06k8TVBSBVgyR9aCmM=;
        b=P1LMCDvhnf4qpJV0ff2EkiVgGtlsX2Eg8lm1k3gIKPve+TZ9rQnnAPNwCSBHig41Th
         CQDRvKxhCoTWOAHQ1fyKVgHhEAWLOXTpQ46pMW1dMbq9nbX2loWJHW6zDIFJoR+PtT5u
         yXCtk1I3Rt/N27wsX8hWuzC84rTGmAzgcE0d33awDnsRV4zKbdXMphpsuD1s4A/sP+rD
         J/p3pBdHwkbus0j7E1PsFEE+c0C0/22rLS9l2V06pP4DxdzN3IYcf0blJGMaJt+TlFcs
         dplrD59YBmgu8mJzUbUZgRcCly6j53JL06QfvRbYrz2R9jzHP5fNhIvfIt1q1L8Q/Mq7
         Ns/w==
X-Forwarded-Encrypted: i=1; AJvYcCWW6kM/rzMvZosCuWDq5t8YDnRfyUFK1SoWwb6Tqb/f6laQkKwIYOTAIWrSEUVyXCVocbegcjbYmN2bhg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzehQq28pe6Isa7qpnUm1lVu4nUmgOP8DR6+Ft/GGU+xPtuyN9F
	UM4K6u15jDsXlN8TSIVF5HxEaLyGBIeViYpA58HMXV6xX5CPikP5MEfUmJ1E+mC3Z+pNpj2G3ug
	oGVSp6+kzc7DF4BKT0yOZPKgsivYx6ClBE/kMsYgOHGBEtEXdrpofkOrJgIxZ8hz90V8=
X-Gm-Gg: ATEYQzwT137OEaC7/PUgLieJ2CUzOvtBUuuODx83mwuR0Q2crVxU6+LwtnRuGGsnHhD
	+4lwVj15tHHFdcZoJWBRGwPgn1ec1SW1zIugP8zDFVK9S/1NoIiopkpO4eY37VRwXMnj4AgFNFa
	DjafXVEWADPocjXKHuGIKUQkoMWWjr2JURPSZfW9xCeGALYIZfYNXysD0maUK0A5qnIMj+GwjGL
	bvQBm2A/2wyW3OUkAdUrfAr2crxLrM7tWf4zBvymr3s8cy4rF4GIvKqDNZX0nhlyBiriNtNsRnu
	EIPXHLM97imYOEReXQ0bN1IKFgUwHCIp2GaBhlKt6Hb7nbadKpE0JQcdi6p4v9XN78d7e9gp7+S
	PA96dI0jrTrvoqCtDX3QW7OeXPCN8KRniluT74MnSuadSiZOxlx7YDgoAJ5kg7yW4NCMQwsqD56
	IKgmu4
X-Received: by 2002:a05:6820:1ca8:b0:66e:7aaa:be64 with SMTP id 006d021491bc7-679faf45b78mr8277736eaf.55.1772530429698;
        Tue, 03 Mar 2026 01:33:49 -0800 (PST)
X-Received: by 2002:a05:6820:1ca8:b0:66e:7aaa:be64 with SMTP id 006d021491bc7-679faf45b78mr8277725eaf.55.1772530429276;
        Tue, 03 Mar 2026 01:33:49 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a1d603f31sm938666eaf.5.2026.03.03.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:33:48 -0800 (PST)
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
Subject: [PATCH v3 3/5] hv_balloon: set unspecified page reporting order
Date: Tue,  3 Mar 2026 01:33:39 -0800
Message-Id: <20260303093341.2927482-4-yuvraj.sakshith@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
References: <20260303093341.2927482-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3MSBTYWx0ZWRfXwkDua7dncIww
 +PpvfMOG+4kMGbKnjhRyWfusR9QBI1aW5gwJzfHfYhd2jWIm5s/a1ZTdnHZ6ElGHCuiwp/X/kw+
 D3XooFIv5EP0MZfRj/Zo8v2h2ztpqLOP392kAaUZysp68wqsUByoyHCfdn/3VeIk316Fsx45ZS5
 RglsXIVtiVhpXpKG0OtWRKaKx3RhJkADVT65yRu47Z/hoeTCChcq6JOlDmXI7Td5SdTy7954brZ
 BRuvkb1gtQb5oiWfQb3U7CSKNl7I/4TXHrtI7LnpM+rJovMlYKzdBs1960Au1tj1J5is0O+pZC2
 66KDYUKqcx+y48+/Z4CqOR/W3DE1zGC04TP6u4HJ3cvvsH0Ghd39ck/NEzqC1QtuQXveQz0ZLtx
 6kb7sv0A2YxpKwX1vCNPAyu7KxfgDvTpGIRp+lIVUlj2TJL4J4OKHFlZFig0h0u5ZyGkPNsfIwe
 HyhrIGimWQvTk4HDsrw==
X-Proofpoint-ORIG-GUID: KX7UnIJ8E1drO_Fx8nxMjbKVjGKAykAN
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a6aafe cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yAl3Rinrq36N4FMOn3wA:9 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: KX7UnIJ8E1drO_Fx8nxMjbKVjGKAykAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030071
X-Rspamd-Queue-Id: D43891EBED3
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
	TAGGED_FROM(0.00)[bounces-9100-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,pr_dev_info.report:url];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..09da68101 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1663,7 +1663,7 @@ static void enable_page_reporting(void)
 	 * We let the page_reporting_order parameter decide the order
 	 * in the page_reporting code
 	 */
-	dm_device.pr_dev_info.order = 0;
+	dm_device.pr_dev_info.order = PAGE_REPORTING_ORDER_UNSPECIFIED;
 	ret = page_reporting_register(&dm_device.pr_dev_info);
 	if (ret < 0) {
 		dm_device.pr_dev_info.report = NULL;
-- 
2.34.1


