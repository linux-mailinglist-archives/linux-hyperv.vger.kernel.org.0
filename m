Return-Path: <linux-hyperv+bounces-9133-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEq0AvLxp2mGmgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9133-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 09:48:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5E11FCDE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CE1307E84D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E4339099F;
	Wed,  4 Mar 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UomrPyVX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QVCeJ5uQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498839182D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Mar 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613850; cv=none; b=RndS4in8a4IDyYFURK9MnXc58JPN/jGeuKMT0IyaK1S4qukQWTTAuAKVa+V6ojS/DFBE2NZvhsAKR7h3/tDvWJlW8LXxcRlIt5kaiUFVJwLm5jKM04m3on+52xvqftXB0xmRfcC+S6c2i9a/2Jz0B3T42BgjuOLDK7Sv7kThac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613850; c=relaxed/simple;
	bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I88N41/RH9i5ygN98tbtyGFTYaZGU2epiHYuiq2uUlRDygzxE5DrOXv3yxBPmMur7Weg1ag9YBNj/yOoAV03MvXb3TuSDVYSMDdmr84lkmpAWsmijihiNkaW9rHE+XbCXYA6fhmPnPLO0mOW2R0cVLkVzXAJgyaYeIjl6sZ5l2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UomrPyVX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QVCeJ5uQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SXj02861222
	for <linux-hyperv@vger.kernel.org>; Wed, 4 Mar 2026 08:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A4hVQa4Ck15Gxh0A8DRKmYnt
	2BE+A/oq+1oyfVx6EaY=; b=UomrPyVX6Vj4jQd4L8JKq8WdlHJbzwgN5kLFyUyb
	O4aj8QK9JigxGnLhJKpV5nX0udO4u9YnLWT/9MXQQg1eAcDIicjDy1vKuZLien/d
	qbjKCndKoTGoqxEQLvfulbwLf6fASgpdXcJZ3krVrgtabQg2doE/qnKFwcVWJugo
	53PeEKsxBlLzI4cOdg5zRziUUULuG1rozQfVfF1WBD5HEOIzU3TkbSCGYnrGRVyX
	xOOGgCZNE94hfQxkEyBf0a3PIxZCJF7Dhv57Qt/sIPjLshN1RjVOyAspJcSa+Tl+
	D5GlBO0U7GgzrROeN5jS51sEeGbAiWtYDd+uMPxuzLkAUA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp2c9k6jq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Wed, 04 Mar 2026 08:44:08 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4c393cc9aso34962381a34.0
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Mar 2026 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772613848; x=1773218648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
        b=QVCeJ5uQx+jRY2+wOPbBjxA4iTl7r0TCwU7hUloeFNY0TfGZk5FW8+dJRRa4BPUWKQ
         S2ywRFH9YSNnvy8LdQxz0BVxr7pLx2cirpST/Zph3YzcHw1u1kR7aX4U/TnWOnPVcFqm
         ffhgWLO6Xp8JT4DRyOVZc1pL02dbabXjPa2pgHyVQDzAlTi1ce7HrIikt+SK/7O6m8a2
         9OZB/rbxHcqQ4KfkXAtJCbfuXvfktboK0PsOoVo6fdkowljRy2YtO6AZkJhbd8jJiFcW
         +PiU4pFc1zq1YGWlA9GrIhX70ffkvc6Za4kOFnd218pFwZ+QzYTSwtlXt9Nm1hLXY7mD
         qxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613848; x=1773218648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4hVQa4Ck15Gxh0A8DRKmYnt2BE+A/oq+1oyfVx6EaY=;
        b=JPtpCKSG68MlYMMe1FTImK3LJL1mvs6/tz4t/nvUgBfwKm9rKjjNKagfNPWdT2macj
         Llr6cnTq5eUjwLPqrow8zwgyRDAGYLerpV6510VEylieTzDSIBB66a/YS33qp/e7DVJK
         Si5IV1Le+uFuZ2eeM8vfKOi/sSuw0z7eSfr8CtF/h7sXrb1DD/Vueo8fIxmv3SvDyvSm
         t88s3U30HnrqPSVek55vFoQmCv7/XzQCejAfYo2UtAbBJHDv2abDisf0vpRs7V/8s1GG
         0Bfts1Zz93AMyFsnE1dYgR0oyrzoJWf64eaWL6OZ3vIFp/jtzZVEf5SYNniU7P+cvjZO
         aM4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2inCWPSilYHC9jUagbImnr6gnaDjrY5OkyT6PLfEs+Fav2FObxd2k5VLkzph24GXvHQaf6D2N6ubrFhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjM0vxHAKHznPGHaF3TGG4AP3qHPguxgJoPhgpW6VMC4uTxKQ
	DmbvJ4ES1IwDM52x2EEo10CasKZHSbPhHy/uARnyQlE5EbwxhaqHynY2BuzpifTQWombQHB4H7Q
	yl7XSHnRYSqTaumwfD1UCl9fzcr0S1uAElbv5DeL72d9GWts3fHT3b1AUcUkWbuouFxc=
X-Gm-Gg: ATEYQzx0eU5g6bjddEV5m8UyyDWY8jCSuuHK4zcQcxFDD6bS/gmO6NhDx4oBtZlAMXP
	4MPES2BvQhSt00kTlQddng6oUdbyirTF8yyIs5PaVmuXjaX0I481gPe1mpqdmGU1+LLMJe/CIVr
	gao63GE5oJVKI4F081lUMlhw6oAn2hZpVv7nqwG9XYoHkj6lAFvVIvA6jpFEEuQ1ydxx4MEMuPK
	JPaxcWrKdaFi68/5N8TRnHplVXImbJi41ZXZ29R+eXgUtFhmD4WaWkHomkiqOOOjUjKgMXJcy+G
	B2CYX+ISaKnGgxm8vA1WD5/Z1EaF4gPXAR0Pnl3BX9ZaS9J8U42podGNh/dWUSQ6urWotca8he7
	dYHMVAFdBbs5nsCYQ5xrDW9ekpYyO7VMr/gVQO8aR2EOJOtHcRiXeWPRU4/VpzCe2Kng1Z9QKp9
	ZIPbpL
X-Received: by 2002:a05:6830:3901:b0:7d4:96c3:3f8b with SMTP id 46e09a7af769-7d6c7f5d9c6mr844958a34.8.1772613848088;
        Wed, 04 Mar 2026 00:44:08 -0800 (PST)
X-Received: by 2002:a05:6830:3901:b0:7d4:96c3:3f8b with SMTP id 46e09a7af769-7d6c7f5d9c6mr844945a34.8.1772613847716;
        Wed, 04 Mar 2026 00:44:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm14945895a34.16.2026.03.04.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:44:07 -0800 (PST)
Date: Wed, 4 Mar 2026 00:44:04 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: mst@redhat.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 5/5] mm/page_reporting: change page_reporting_order to
 PAGE_REPORTING_ORDER_UNSPECIFIED
Message-ID: <aafw1FO6pFe8p5mm@hu-ysakshit-lv.qualcomm.com>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260303113032.3008371-6-yuvraj.sakshith@oss.qualcomm.com>
 <849233d2-9d40-4d67-965d-262153d15d07@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849233d2-9d40-4d67-965d-262153d15d07@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NiBTYWx0ZWRfX9QW0nd/WErR3
 jz//yk02mp2cukMOaoMnyxvyl656DKhet2Ys4+WY/a9G/4qoiJOHbIt1Keuq/wdYQbFMRctD1S3
 zELc4OF83YjBb+hKLSGn03iixlhor/pezJP0kyfXW5IXEKxvyWmD5bWT5C4ckzF7h47x766IlI8
 r5rr0gumWM7eOxk5IeWCK1HDBE4uyofRhhY+RgiyMeEeSlZUUBARrzz/y+PaST0Txl5tdTHiFk2
 vsKqe+zxMExxMAMUfAMFk4Qv+HnKvRq6Dtx3ldcz3R+zklWoLwrfOQ52OgyCyouyZEELuyhpxIA
 XdCSjHOtVSxw78ID3nChwEuIt2JFuLXm0Dc9DZ2nYHlN1hn5KJS3kaeBjHaHZP/g7VuewGwucFu
 SrzWv6Jilohj8yYtb5Wz0UfxiXWSsOXvUT6UfDOcFtwg+Z4DdWqp8XeoN7KxnpXSd2ox3iFkJwu
 OdLRbj9gSNp+0XISxjQ==
X-Proofpoint-ORIG-GUID: 5NEKjH-rvWG1DvA-mkRXOhf9iKqkBTJS
X-Proofpoint-GUID: 5NEKjH-rvWG1DvA-mkRXOhf9iKqkBTJS
X-Authority-Analysis: v=2.4 cv=EefFgfmC c=1 sm=1 tr=0 ts=69a7f0d8 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ciUuy_i2Sbo4mXWE2mcA:9 a=CjuIK1q_8ugA:10
 a=PG_jTqMH23MA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040066
X-Rspamd-Queue-Id: 5E5E11FCDE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9133-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email,hu-ysakshit-lv.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:59:10PM +0100, David Hildenbrand (Arm) wrote:
> On 3/3/26 12:30, Yuvraj Sakshith wrote:
> > Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Sweet. Thanks for the review, David.

Yuvraj

