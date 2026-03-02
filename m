Return-Path: <linux-hyperv+bounces-9084-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIKILUhypWlsBQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9084-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:19:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B31D759E
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595AD305F653
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26492362134;
	Mon,  2 Mar 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLOkFwV/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QczUt3jc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4B36166B
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450288; cv=none; b=It9H7Yuj+DPBThxW84Hx4pftxAIqQn9nt7ENjS9WfkZrwIhWSudazGfDJnpqeEuXMXocjqEXR1VTzqYeNnOqACRdQQtHixVFdQ9oNH12UYLzFPTlWsEpiYI3NRCvsFOxn7MsdcBOuCVRyqrfL+Mv/1ahhsmapAlzYPoP6PTdt+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450288; c=relaxed/simple;
	bh=scaxuEdemD777UDHldqGf5u60vNPBgT/Kjx7liEpxUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PR7BF0FVBVtGQ03fjUnXGxaRbAjRxpDGTwQgA6fpLKUpaLRx9nMV/oJQEip/FFrETvHcfVkfHa/SucmuxQ30dZW7lVkbuWuHjVvL008Czi4wjrgad2Jk6n+tGGdMOHDHCHcUn5plA3jjBPHCSpgh1Xs95E0noXSFrS44jbweJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLOkFwV/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QczUt3jc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62294seH3753600
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 11:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L+0kgesUCMd
	NFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=; b=NLOkFwV/qYS+iMo0DscBtUWTvxW
	uynYI7C9YoIbmqZ5kSpLlMNbm7xLMYD6N1VtE9isV/qfRXK/6B6xPOFIB9+k/itc
	F7HyggLQqqUEkToi4Sq/dFUq2Fs9Au6In8tY6kPeJGw+6G3TfGzeg+J/UUGR3Cmt
	ZmDJiGlruKDuiML5aPWAhwE6E8tuL5cxuIDsOYMaIaGbHNKn5dZIit+N+4U5m8U5
	tNOiT2l7HG4wMLL8QpTY1Q/F4xXayEsyIpZvXflvaUWt1WPh0kT9H1enSC7BH6io
	oCPO+453jF7rhTW0Yxn7GmqOrzmlHGel7jGvUfvI7RVJxwc7cDSVtZVzhIA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7kq8ft4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 11:18:06 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4639f4233beso53745399b6e.3
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450285; x=1773055085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+0kgesUCMdNFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=;
        b=QczUt3jcJoqAjRfEWON3d4+4mCsHa/hzX943//tFt8UFPaPaKDTp5pRcVuWNrNmB/0
         J/yqj8vqZvIEocfy6jJUP6pv0/MuLVkZPDRXarw/+8TbIwMueOhgPsg+h5I11G/fQ775
         iYHi6YsjwQWlJQ2U6HrfUAYdcN5yufmBN0e4fsW3i10yLLUJwv2Wkv7iH4l/nO2aOzvM
         BEja2j0Sjw4L3lCZtH3wuTFyXeTygU5MYqSexe/buFde1CJ3avfNbE+JLAaH+iLGFHhb
         GID4oVX3ktmAluc/WlYLy8SXn5OBGGZ2REfiJVDRIeP3mcIQiwNKCeC7AUvgFJiSMilE
         gtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450285; x=1773055085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L+0kgesUCMdNFr3Yx0NR7alJYMdhJUrTkNwgNL8Q2lE=;
        b=SmvOirD8Q1enNNCkgCsHgNmJ3GJWtQ6klN2U+1xbhkIMBbcoBTUJjsBu3qOsZJtHjH
         0/oWIgQWknjKSx6HqPsArQ6AXA6sOV5ngoobiQExzxbP2EFAA+WSt7LSoiM9+ohlMuvI
         +WpRZq8eSLL+WKUAqlfJGVeq6ZEZxW3rOtk4BaTYloqxKcJCBp+2WnwoyT0d7GETYxtA
         TNOaeIiM5vn+kz8wcyaa4zDCrAksT1iGFszf0YA+HKus663OqPH47ZmNNYDCQMmYlHvA
         dvOJ9ydv7HQO5zBMfF4kAWz3f8cWNAPyKv9n/ABYeBe8JZssSl7fMOV70gIz+m8tV5q4
         8JLg==
X-Forwarded-Encrypted: i=1; AJvYcCUDzO9VzhiM1xkttS2wwCxpTlPwsCpWrofXbo1AK+cpMI1U910jxumHGDMjhP/6A9ZRAGtphBBwQdUAH5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUg9852QvqqigsmeBssJbZPdjcZpkr0COxYOUG8PZAWXGlNGLX
	Nzsp1BD8Wf78+bAZQJdaKYl1eH+RaOIl30p9CrCD538v9aEetf+FB+QAWEhfFpdD8CwhzW4fakF
	GVRSqlEWFMWtDbMCPxx2w5Mi4bD2o4p/hMxnEX1LXSysPoWuaF5dIu4/1NjWDNpvD9D0=
X-Gm-Gg: ATEYQzx2HiNALr1+sqNmY8tQ3Ryr72RT2eZhJ8DYsyM1MQqCT1TPThPGeLfo+K2BAXR
	E957nqitJ5yeS7boYr4+II88s/CeSGt28HpnnXJ1IWO/SjlKhOGoxs9bt9zUURj4pa8S8fMbVEw
	/pJXXuVfqgvppeYrW+OHoQ2vf2qsBsYk5qK1yeaA4woRaGaJm5qVFCFC+jWFYLW8o9WKbBGYbjW
	YDpFPxkgri+R1QpZuxsD43/qeLAeQJf38H7fXxDqsN/q/ESUf0t9GaIsmyEOpNA78SI7sWEruMb
	Jv3YdY1elAFQMb4tJPb0Bk4P/10mTdXwCKnGpaQrlX4bRLwHPARnx8ekggbBirPRtuEo9aTn0n1
	eUMeSPv12SuDA4MKYUTNCG3vLmHe6cr4qIEcizqA5JzBPUb5glQBfXSq3UIQC6U14tJWD+OCkRY
	ITfxs8
X-Received: by 2002:a05:6808:1999:b0:463:4196:3d3f with SMTP id 5614622812f47-464be922ec0mr6157818b6e.7.1772450285338;
        Mon, 02 Mar 2026 03:18:05 -0800 (PST)
X-Received: by 2002:a05:6808:1999:b0:463:4196:3d3f with SMTP id 5614622812f47-464be922ec0mr6157807b6e.7.1772450284836;
        Mon, 02 Mar 2026 03:18:04 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm7354528b6e.10.2026.03.02.03.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:18:04 -0800 (PST)
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
Subject: [PATCH v2 3/4] hv_balloon: set unspecified page reporting order
Date: Mon,  2 Mar 2026 03:17:56 -0800
Message-Id: <20260302111757.2191056-4-yuvraj.sakshith@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: yLg-2iAnMTM2DTc6rdKNQpsVC39PnHbu
X-Proofpoint-GUID: yLg-2iAnMTM2DTc6rdKNQpsVC39PnHbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MyBTYWx0ZWRfX3AE1dfUMn6lP
 IZJNMHRypvmSraj/BPI0IuaLzjOBt4DLTWQJGQ3aVuYcd5haSqmZqBZBU5O/Oc57th73OsaDBjc
 La8jO0Q7TiS8CC1AsUt9fDtHgzIyaY+2VWRcWNhsZOonz+9Mr27PnwzIAhOqF/rNPvGK8eyAG+o
 Xyic36oUNroETrYxWHYE2Z9DL7nsWhwbLWqWd89W28DVTVhUcNA93IxxK4w/e+Jx2KD/O08iOfF
 qRsU/QB4MFty4fvFrG4Qj/sy5eti/yry2/GDlJQ1JAiT1juqvhXslkbpBFUZN0PwwSrYnrSJVW2
 zayUPcPHMjpxNw4tAPrxkb2BR5tdIUk9J8HcmNP4v/t+/0b7/LkC61z0vnlTD4LZtFo3X1mBbc3
 azrnIGeOlFvQXCzAAAKykO5Iinp68KHcaEMuDizhpSwU5Vlxcdyh8mCQa9XxU9NSk6jlgNgsGUO
 JKshIjeBjQM9K65llRA==
X-Authority-Analysis: v=2.4 cv=GLkF0+NK c=1 sm=1 tr=0 ts=69a571ee cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yAl3Rinrq36N4FMOn3wA:9 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
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
	TAGGED_FROM(0.00)[bounces-9084-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pr_dev_info.report:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1F9B31D759E
X-Rspamd-Action: no action

Explicitly mention page reporting order to be set to
default value using PAGE_REPORTING_ORDER_UNSPECIFIED fallback
value.

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


