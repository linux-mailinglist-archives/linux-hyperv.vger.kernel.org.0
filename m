Return-Path: <linux-hyperv+bounces-9073-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id urfvEfcEpWnwywUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9073-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 04:33:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A862E1D2B0A
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 04:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02DFA300D602
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A021B7F4;
	Mon,  2 Mar 2026 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1jvc/02";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IY7qKGm0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C7B672
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772422387; cv=none; b=AcsGlDCeA82p0XX59E8UltZlSB1k8eZpvxG+84TjwyP8wKpqWTG3toc0zUbjdP9LFtzK53A/WxrRlmOA7hMAvMOPudFgBmcwMFNTBrHrujwhyDx0FqCN1ShLiQQgL17c033I/OYjMBvth0/Lx/Pc30PUxAk7f59E4lw4SiiVEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772422387; c=relaxed/simple;
	bh=ZD54bpaedeQlQDnPkWoaBA11dzBkKlX+EIkM9p3PkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpho+/kzlD4vYwrakKuPSuKO+QUMmrpIAss6ZmSEJLGd6oD/GyBCWFbhNvcaVPm0DlcWjHvXXaDM6Pj3H6eU+MTKotnIfgsUlKIBfi/7/6g+PMqG03cBONcNtGWdujeImV5btqpfgLs604G5By/qlcURF/3a0BctBYGdglyRAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1jvc/02; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IY7qKGm0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621MF1dU1446280
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 03:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=; b=p1jvc/02W+FH5Xdq
	6BXKsYmuduBiGT62XYdrCYV5pr3T7r0I4bnRwxuhoS8gyVGBBJU57j82RtPEaHg5
	KsQUlmEJIGtcq+aYtAlCoccZ+fJCeQmHLybFqGMLG4mdnF/xlWmLcfwI5+R5QCrf
	pERzMyIgZrwqkVrAGpLfLWBDtF9Vlb6zUAKYb+NoBdKNTDcJlHB4r841HLJbVr5i
	XyjAxSwzCCn2jwdUF0k08vXG/jdFUPpZdQ32uBYKA3qJBWrFi2rtHHYDJcwxApwB
	jBmjGTu/3u04iGQugyTTRJES4X0WeRyfLUvftB9IxYjAJx18hdyh1zzxL8GdN0Fr
	Vqp5HA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksn43vkd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 03:33:05 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463a075e177so21548282b6e.2
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Mar 2026 19:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772422384; x=1773027184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=;
        b=IY7qKGm0PB4WNOTJ3zMnKdEVP86d3EOSju/TdnLYdtEwaUPET4H7Oz/Yu98XeH0TGK
         YZZHVNMmsorqzYq35CFvNGrZ5SZfKKAkgkZszJ4TCiZy+ErJ3Wp7tVBRzgNRz2Eq/QQ2
         bOBuYuJcOF+vMQuQHle9aJAxSnA3Tv5UpHRmWHs1+LDpMrtLZM/gwP4aFqxrZtLe0ceh
         FZSVbQ4qF17DtBn2NIVYOv2lJ1JEyyhBVM5IEo/WjaJSL3M+v0ARciVXB0J2xctU/dMo
         zIJesWR52KziAUx43nJDT0jv0oUJKn0gSV8SXCQ6NGhRGXl9BznLSCTFIgf2t6Z/eMZ9
         a2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772422384; x=1773027184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2OsP/70Er+mWuJ/nMEuOkdDfzSNUXpTeUeLCE0ADeA=;
        b=HhKF764ZoiNzED/y5jByWL3wj8llpF+W8LLFukRsoV8gzTi4BLVgQMh8nq9K4GM/vR
         um/I9tWqyEYq2e2IjDsDUjYOXzXJore3Kqnx/ZaiOoroYkB1EvOMfFfBv3URxhN25OPb
         Nq6fXG7q01o33antnLLSJ0hSTLjlRz/zgILO8PnyOO0HICEFX22G3od61GysAbo+Ge9i
         MpCygZIAJtv7BPtOcC0ocWGXXlelWqNgfr6GhOnsMCsSL23Sh8PchmaEUGLeW0xkoB30
         ECtF9Mi4llNAsmK9emDR+wirD3+nPH4dc4LbvUcpFxJM90rAt/9anx89wTXtuuCxemzz
         ilhA==
X-Forwarded-Encrypted: i=1; AJvYcCUtFQ07G42jvqqKN5Renj0Bu9RBNLuaFdp1svzkUKZrZv+nZz90RkdAuy0kUkkZWBb69tl9fEnvmFJ4VM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BRGFuYedtefwK4Fpq4dOxtwb1tiqPEXyc31jlEjABQDL5o5a
	k04mAlI2JqrN9qaEoEqyQNQCWWkL6Rg9pzJoFa4PC0FmCuDoe3pI6aA0xMV9JexxDvgVfydHzgY
	frmZ0Jh4rk9Vi6wOx6vwwy4yB2ee86U4NXqhMWVtP4AY8BEtAFmMebQtIrbVCuLsQiXc=
X-Gm-Gg: ATEYQzxzJHhIHM6ci6YXyiETUv84U95ZYbY5yYChjCIBfr2COSqPVPGTxLq1G11j6WX
	2hsiNkBRs1D8UUNfeORQgrUkJ5nKHth/hyBlwFix5Np5PmGP62Zhugf5v1MCD2oGLG8Tbs/C5y2
	RpvxZpf4V2dSy7uVa02OSypALTcOgbbX1TufFX8eCJAd3FeI06lFb+3qRQ7kiIQzrt83A4Lcd7d
	ShuNbq49xUo7eFTjQEW3HdP3+6PIamMUbmGRpvZTTBk9WIgQ5Ezy0K+eg+zKwWZ/zC0KdjWjlRZ
	PVGjl+XXcw1uWQepUZBCvKgA/Z8vE4AQzWEz6CCTF+uoD3jogfY2sAW2aJGyCnJZmZI/VnbhAGx
	2LG4j7fsHRxAnVIioG1oie5L3leybfQkBWSWaZBKMOvNzjsSm3JLrEoQrvN+9YrX+pKaWAQVeKY
	iYdqSh
X-Received: by 2002:a05:6808:5183:b0:45c:9927:3f33 with SMTP id 5614622812f47-464becb4a3amr4969465b6e.19.1772422384243;
        Sun, 01 Mar 2026 19:33:04 -0800 (PST)
X-Received: by 2002:a05:6808:5183:b0:45c:9927:3f33 with SMTP id 5614622812f47-464becb4a3amr4969443b6e.19.1772422383785;
        Sun, 01 Mar 2026 19:33:03 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf9b240sm10950856fac.8.2026.03.01.19.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 19:33:03 -0800 (PST)
Date: Sun, 1 Mar 2026 19:33:00 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, mst@redhat.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Message-ID: <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
X-Authority-Analysis: v=2.4 cv=Tq3rRTXh c=1 sm=1 tr=0 ts=69a504f1 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JqjX9IW5vOmFWWUa66MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: ihPLji1gOt-DA3kNl8cgdFHS1ym4YvkZ
X-Proofpoint-GUID: ihPLji1gOt-DA3kNl8cgdFHS1ym4YvkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOSBTYWx0ZWRfXy66OPHqHucJ3
 4yrkuK0gC2nQUWp5z1JRAm+KoUthXDfifdekZm0czPa9S0Up9/wtN6q+NJ2xRuDyUxDkiUipuAd
 Kk6wTdw5ThmO9rC5l9lITuJv1EO6db67Hxkn7OsfA6IS05HaBFnuHzj4/rSSM8nIfGOEhWSjD7W
 Nh/0HWphI0bUaHjyFE2HVOo9mL1UDmLkPI1kY/pYwItG27AWlpSBUGSdUBHqdk32FIUGIXUKB2j
 /1TzaIGvd9t8VKrXmQTDwkinbxPgvXhE1BKqMJG1XOCLs45mlZoFW6oYO2hqMHgk+dTrjNG4RsZ
 3IL520pGsE6rdzZYCCY2fLLLM/Jy/prncvMcjE/di4eZx837qvRxKcz77VGqupADQmAFa9kkCGF
 YJ8aKV4Xzhe+7A68JIbYIDZBSUHmoUWqGUBiThUgQ6JU4rxXN+bYHAlAabqwy8p2qHxwH1ZGgWo
 PJWG+ACttOyOh0mWk8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9073-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A862E1D2B0A
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:50:15PM +0100, David Hildenbrand (Arm) wrote:
> On 2/27/26 15:06, Yuvraj Sakshith wrote:
> > PAGE_REPORTING_DEFAULT_ORDER is now set to zero. This means,
> > pages of order zero cannot be reported to a client/driver -- as zero
> > is used to signal a fallback to MAX_PAGE_ORDER.
> > 
> > Change PAGE_REPORTING_DEFAULT_ORDER to (-1),
> > so that zero can be used as a valid order with which pages can
> > be reported.
> > 
> > Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
> > ---
> >  include/linux/page_reporting.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> > index a7e3e30f2..3eb3e26d8 100644
> > --- a/include/linux/page_reporting.h
> > +++ b/include/linux/page_reporting.h
> > @@ -7,7 +7,7 @@
> >  
> >  /* This value should always be a power of 2, see page_reporting_cycle() */
> >  #define PAGE_REPORTING_CAPACITY		32
> > -#define PAGE_REPORTING_DEFAULT_ORDER	0
> > +#define PAGE_REPORTING_DEFAULT_ORDER	(-1)
> 
> No need for the ().
> 
> Wondering whether we now also want to do in this patch:
> 
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index f0042d5743af..d432aadf9d07 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -11,8 +11,7 @@
>  #include "page_reporting.h"
>  #include "internal.h"
> 
> -/* Initialize to an unsupported value */
> -unsigned int page_reporting_order = -1;
> +unsigned int page_reporting_order = PAGE_REPORTING_DEFAULT_ORDER;
> 
>  static int page_order_update_notify(const char *val, const struct
> kernel_param *kp)
>  {
> @@ -369,7 +368,7 @@ int page_reporting_register(struct
> page_reporting_dev_info *prdev)
>          * pageblock_order.
>          */
> 
> -       if (page_reporting_order == -1) {
> +       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> 
> 

Sure. Now that I think of it, don’t you think the first nested if() will
always be false? and can be compressed down to just one if()?

-       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
-               if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
-                       prdev->order <= MAX_PAGE_ORDER)
-                       page_reporting_order = prdev->order;
-               else
-                       page_reporting_order = pageblock_order;
-       }
+       page_reporting_order = pageblock_order;
+
+       if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
+               prdev->order <= MAX_PAGE_ORDER)
+               page_reporting_order = prdev->order;

Thanks,
Yuvraj

> 
> (and wondering whether we should have called it
> PAGE_REPORTING_USE_DEFAULT_ORDER to make it clearer that it is not an
> actual order. Leaving that up to you :) )
> 
> -- 
> Cheers,
> 
> David

