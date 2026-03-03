Return-Path: <linux-hyperv+bounces-9096-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN55AWSipmmvSAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9096-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 09:57:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF841EB560
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912BC300F128
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D8386C04;
	Tue,  3 Mar 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8LCE5/G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eyGlLgtG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819930DD11
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527966; cv=none; b=C3iVpLNMKWHVSWfcAjn8j5f0KziZ2tnJP2HEwGQYHYTSDv2MRK1Efly2mvzqbYpGLo+wDrzfUAHypVk8QjjGjRyrDjvANde5i8QiEMb2em3YViV9ALVqBqCsFr41DCBzNcGg4UXXvl9lq0T5XQxKSF15oXFfk4Lc4O5IVWgckpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527966; c=relaxed/simple;
	bh=NHydjAt4Cze7NsxZrmEKQXTvB1FSPhoQ8O+U5sJeXiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfcL6riTfTTMAocweMhV5zqT7OLTyybbpyh+KfKsEM9if0AGsYmxY8MyNT5oBBMOriY/Y9tY7HNj6k4TZqKA9iVRqv5NLTMePfaQa+IIaCYMMhxEbrSKLAVAnvXa7EmsYIAij4KVxzA8LaQqJ8HPQKlE2fNDPD3K5tzCp32+a7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8LCE5/G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eyGlLgtG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236uWRa2048909
	for <linux-hyperv@vger.kernel.org>; Tue, 3 Mar 2026 08:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YNCoDF0Cx477EaFoLRXf9AP4
	5l0gNVgmAcjZgp84zKw=; b=m8LCE5/GG26H7daYOSgbqY8Xg4ZNKzApJqvYus6K
	SdQMGPTDn5gNm/wBRQKC3x9wD9ZrYTDIDJFWA9iK1r5vHasFbIS9dYc9+LqN7Nx1
	kUHGHzp3AaFc+C3DQJuxvftRVKKz7+8UnR3sJlRyXv/510mKsSihs/k3RzbQG9ER
	Bo/rTLuUWmKs3i2rjIHmPmw8CbT6iiyqlVXMq3fXTkNd4KcA2YDYqIAN9PS8VQ7q
	NCJT7OQT7lIuMPOWHe9bkJ1raNCq8FSxRq91AWiA7t17uDOcmYqRVFgNg4i7mkQq
	Mb1OwaTxGfvhD0zBjEegsk/B02RZO05M1dwqQhOEIir8Bg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cncmfuc4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 08:52:44 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4639e1fedcbso61244862b6e.3
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772527964; x=1773132764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNCoDF0Cx477EaFoLRXf9AP45l0gNVgmAcjZgp84zKw=;
        b=eyGlLgtGHntS1JX8qoi3tqpJDSEIloP87UItpu7TyUHET23VOP60E+MJJWyO+NK6c5
         zanqVP0fB3TrAEgsS7xsYb/4RWfw/6MtuLLW3s2EbE7PYTiZ8qajAU1x/oUHR4bvWSOI
         0MYn8rUAr6J5gVxZ/5JpJA0dQVd2bKnNZYIg36ngFZfjO/Ubu5TiGHG4et4TXQs7DlVx
         6uXthykXZsvHYbSj/yknwL8oQvcklugWjnQrU0Sd3edY1Wtx/h7Uxy7o+912qy0muuBS
         Y0YLGsgrPW7/8I5WUEA2i+u2CI5liHvrLv4JotlR2zKve5TDfePN3YW8jCkh78GaJ7rO
         BrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772527964; x=1773132764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNCoDF0Cx477EaFoLRXf9AP45l0gNVgmAcjZgp84zKw=;
        b=fxQQnvNc7ZKonDf2JblM1zSGt6z4WTKy2RZ3lCGYWqTXcIcEG13wN6iDCZl7RzSlPo
         n1L5ntvUgvfoACRAckL9ZTqtU9rUKTaPh6a/AEFk+pm75KHth/W98ATnUXosfJO9grp4
         oQL+/yIPlyeFG6orDH9LhF43Ntac+1dBALDkClharU+CkYuAqkLK8VQ80OEihLo8pZeK
         5CypprIxLiPwp/O/EOQFc9E4wxS7/mBgxrYM275DKB520C8A2udlSvaQsrd3z8yo2ybx
         rwncmgxP+u8izfWMdkdbMgEtl2mobctjzFe+fcNHaPv5/7HN87JyfGaaq7MaWPlVfLkj
         R7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXFCYoIqlw9fTxmZWQMyjvRpnyzLxFrd7TIWhXT6enNoXBPeKrM38S+ha10UGpIwza77L55I7v6O+UfIKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVzVzduvyf0EMf43uRZKgvOybFFyZvMhRey+yiDiReOAy/uE+
	v5K1mPuCQ9c8V3Hn3Yi8BDhqge2gZb8ke6dhsxrM7/Mtv7FF5Pk/9Sbbb1MSDa9jFaHipRk0c3V
	7TNy7PX9XuqdayISpQQx6hWloMtAaRznlr+UZH0wgfmEd/yM1Dz65IddLHgVJLuxQips=
X-Gm-Gg: ATEYQzx5u3xcECWmRRYU7HTEzefsOhiBsGFslGuyHu455Jp4OKMCFQl+OeP/OR4tVqt
	NM8zhsHqKPSjUSgdPf4jaiJMrFHaYXtb/kEYPdDRYtWAKPEdvS8hRE0Dq6WxZrs85uF2r5Q2Z5y
	/kD0P2PjxhMgDHJKbSJQOnHEYhuboRp/Q9Xq2x7DQSgotUEneIq6izB6PIQ+kfMZ+Y/mF/1tMGh
	PDzp3AEgu2y9i6ZlVReEpdVZz4aVIBzIAApxVVEJutTxUQu94Zljfww8yCk7kSV6i4cUj8ITqxU
	qgkbmTv2yeqHuJ8WihgHfGauoQpcwe9dkXUYDHy600l+ArIYp1lXlRVHvkC8rjZuzQ+pwNTpZMF
	KWvPL4/3CDLxaCREv545VRLsNohFhUOVM3OXHWOjky/fQOvtbpBsq93HhZ+ifYuUFq2NItSQXmD
	+wALb4
X-Received: by 2002:a05:6808:c412:b0:45e:e174:d07e with SMTP id 5614622812f47-464bec22949mr7968581b6e.3.1772527963990;
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
X-Received: by 2002:a05:6808:c412:b0:45e:e174:d07e with SMTP id 5614622812f47-464bec22949mr7968567b6e.3.1772527963596;
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59be78sm9432983b6e.13.2026.03.03.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:52:43 -0800 (PST)
Date: Tue, 3 Mar 2026 00:52:40 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, mst@redhat.com, jasowang@redhat.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-mm@kvack.org,
        virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [PATCH v2 1/4] mm/page_reporting: add
 PAGE_REPORTING_ORDER_UNSPECIFIED
Message-ID: <aaahWAWkXTS1lae+@hu-ysakshit-lv.qualcomm.com>
References: <20260302111757.2191056-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260302111757.2191056-2-yuvraj.sakshith@oss.qualcomm.com>
 <2f14572e-e02b-4bc5-abd2-7814c24f7905@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f14572e-e02b-4bc5-abd2-7814c24f7905@kernel.org>
X-Authority-Analysis: v=2.4 cv=Br+QAIX5 c=1 sm=1 tr=0 ts=69a6a15c cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=oZke_92Gw2P4qifsOy8A:9 a=CjuIK1q_8ugA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: jI1w1f9ReVrqZMU7JYfcvg7S0T9iTrG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NSBTYWx0ZWRfX75L3HJwbNd8N
 TM9y+8XFN75tSI+mHs2sgoPenGpcvJs21cxGb7Q2nbOIZ8CcNP4t5NJFaNIuYVIjsQbKQZFLRAp
 /dd2hFOo+pDdwTszLaOSSf/582emC6dLdqJv2zdRxWkchStzb8zzsQNcADfkk+GkgbWg0jlMy4d
 z9dm0OqKvp4wzF5yQX9VPE6ykxgqiWczEgBF8KTy2CnCdxFRmdycXNsqk0OtOZtJggvJvuy4Ve+
 ruvezPpPjCIU2KdziPMESVN4fzt5RBVNmutkYHrO8uWyKlQ8AfEFg0czcap7Zoo0h37fy6ZzsEf
 +sf8Aq5ksmqqLGHT9xIq49z/m1PJiF9IVFEscmlXs6m0rmXa6TYI/R+OZdHjiLia8hstGsohwSP
 Zi7qQiPT4euax3BUOKKIMcy64YBM9l6OnOLexfs2Q/99r882J/WKLlKIHKs6y0pypDW23lMQLyH
 yeG+0gbT21PtAOK4L+Q==
X-Proofpoint-GUID: jI1w1f9ReVrqZMU7JYfcvg7S0T9iTrG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030065
X-Rspamd-Queue-Id: 5AF841EB560
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9096-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,hu-ysakshit-lv.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:57:50PM +0100, David Hildenbrand (Arm) wrote:
> >  /* Initialize to an unsupported value */
> > -unsigned int page_reporting_order = -1;
> > +unsigned int page_reporting_order = PAGE_REPORTING_ORDER_UNSPECIFIED;
> >  
> >  static int page_order_update_notify(const char *val, const struct kernel_param *kp)
> >  {
> > @@ -25,12 +25,7 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
> >  
> >  static const struct kernel_param_ops page_reporting_param_ops = {
> >  	.set = &page_order_update_notify,
> > -	/*
> > -	 * For the get op, use param_get_int instead of param_get_uint.
> > -	 * This is to make sure that when unset the initialized value of
> > -	 * -1 is shown correctly
> > -	 */
> > -	.get = &param_get_int,
> > +	.get = &param_get_uint,
> >  };
> 
> I think the change to page_reporting_order (and param_get_int) should
> come after patch #4.
> 
> Otherwise, you temporarily change the semantics of
> page_reporting_param_ops() etc.
> 
> So you should perform the page_reporting_order changes either in patch
> #4 or in a new patch #5.
> 
> Apart from that LGTM.
> 
> -- 
> Cheers,
> 
> David

Sounds good. Ill add a #5.

Thanks,
Yuvraj

