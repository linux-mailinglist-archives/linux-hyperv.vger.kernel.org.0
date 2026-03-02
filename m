Return-Path: <linux-hyperv+bounces-9080-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKFMElldpWlc+QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9080-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 10:50:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379C1D5C15
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D35E0300D902
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E438E106;
	Mon,  2 Mar 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OIzRQTqF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQN/QwEc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6F338F254
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445012; cv=none; b=V8Y+QwEOouWZEbr73jmI9HqDYmVStLjHvfPFt4XKQzl6iGBFaEjHJKPofZZgQ49Wf/67+NVHWTThBU1Np5pLDWKtxcf0/UE88ZXJRN3Gx70W8rNXK3oQYcomzYbXMmuVmBLFHftv+kxI8fl8bcHamCJ8fhoFHt6GqRLCocDdKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445012; c=relaxed/simple;
	bh=40qwCnqz+wEjM/IhhB5z6vQ43MV8x6Zl2HZJnHwNqcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcx+iyjnVhXugHrJdxc0Z2ACHXdpue6OO1Xgo37D0C7h2TcSO42GRz9ZUVxa/MA7JuotmjTv1ThJRpKhKxegAKZJV5AQbxvWhxRmprAPlluRlWBUEVlV7QOAqqs7LjvmSG4GqC1E9W4iN919cRBFacJYQyDCnqEWWJUC5a8yCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OIzRQTqF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQN/QwEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285XXF662209
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 09:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QRKxM/P9l/2Z1hR6WxyeRaZQ
	55JcQ9u9VYXCLMJIR1U=; b=OIzRQTqFJipxKuT+C6DHeqrfvDJYYRPlB/CM+r1w
	6T6L55qjSbNMz9tX0sQdtFbked9kH0Q1OSGmoeskImmKnZvdLAhehs50qRTihjwP
	jsUcf9dniYuepWQIeWEc/pdLT94X2mrrOP6TRIg1T6CIzzm3w7EwgW1NELDImI2U
	wlNUc1krHXfqFLMkIZ1hSGwNc+FIHN/2kvvwi/fQ3b7HHN0j8TIr8VIgwWPjr/uN
	BXuT5dnhDVwtD9/5mGcm8E9TbpgfdkQLiTD7nIZlMF5JKxj3qRZw7Xicpz2y1t6l
	vowH+8dS/EKVvpvJ75MdqGY1zJDQCKLfUOZqaiZn38Bi8Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2reyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 09:50:09 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-463a075e177so22010646b6e.2
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 01:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772445009; x=1773049809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRKxM/P9l/2Z1hR6WxyeRaZQ55JcQ9u9VYXCLMJIR1U=;
        b=hQN/QwEcgHXhK1TP1ldOTFUDCEqiK/JS4FN0Nvl2eVVtHLkyjOlK4UAX3LB9s6cNAl
         8jh2phtxRjAbLcapKCtQPTBu5xiNDKTHlGahnKuZ/Hag8ZODhRdw/b6ixSzAf4bnZTce
         EqOCaZ9FeRbiszGOZDAAYqnyuQSB0l7xPd/T6LLSPOqnjxrU6MZYUBhzEVZzVePCKVbR
         B6n31C/nHAFtUaTvBpmsCAlJgRmFioKJQk3EWVmb7J3xXJ++BrFsGxOJFYHnb1qtFrrj
         IKr2yJE+GvnWJLvqzJDb6/42V84bU0cAZ27uShxXgsh6mBzbmiFo2BqZHE/KrzzJCXFn
         AttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445009; x=1773049809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRKxM/P9l/2Z1hR6WxyeRaZQ55JcQ9u9VYXCLMJIR1U=;
        b=pGOphrVYrFM8H9yjJWNPbIvwp1VkdgTljeq2OI5yk0FcnGL1pFLa8KMTuQw9v8JvNV
         shFxGB3UgEbWgTG35nBqvnAtv2trpSS31h7x40m/+9oNaO+UO8ffneITOGRpKV8DDWJc
         b56/GOPcWyoE5sS66OF1yqNTo3UDN5G4ym3kUxB9fco+4xpUBUDEKgHdpVKu8vrY+NbG
         Oe7OJ8vmAExGhKLGeVhDthBpcQH9I1jZ2Y08qAWZzol5VafwplFKMjhB2gAenmq8NBxr
         AQ4AzYl64RT52BVu+7vvOev8j54EFSjhxEgKEBs6eAutiSrQBBDpRdN0ruqwPFFCEM2E
         HVxg==
X-Forwarded-Encrypted: i=1; AJvYcCU1DWSuY65YB/4MIfZJ46UBd0NOpWpXek8JuAmMqh/wbmyG0V2NDq5ZUKCD2TRE+47dJqzjokLzWK3Hukg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+jswa8DswfqZ1ghVnn+ol4RxzdxeQ5OOytGr5mMFUxoyTGAg
	JqDdGJqCs9kHY9XtWrFIakUEwHH4gSAeJomR4ZVF0TGoxDe+Zc2MAxHz2VP2nj+149jHekiXSlt
	fBiuJ4MjP0CIkjdJWHXYh2g1FI+lOuviyhEuBCw+DJFSwdMpFEd+F+Gs2JXn0TlNAeVI=
X-Gm-Gg: ATEYQzyftbFVeyBB0uav25oYx9Gqg+a6hhR6ZOGGMY+NYn0UV5nbdFROYnQ7QIDKLoY
	HPkq0xiVvNryNCspsI6llJmwcYalquq3ALE1I7G3G/vQSFjzJ33zqk+L/0NcEVa7dchRMADeLfY
	F+4WHCZ0C3emN2KjYxuLcOhbvOmQRFYnULpprJZaCZeG059rWBUCtmMVeBXgr9u57FDVeq9tBaA
	bY3yVmX1cFDQl9Ih2blkGl5KMgvgwU+ITAtmXyL/1W9odAOklNUB0ftHGqr8y9085HxaOz8tgtw
	34+EKYdYa+rYVn/g0PuDdMxvgLvbdbrS3aV36EWr479BhfQM/D2IvPww4WbVzM4eNse7tFrnu36
	Q/SkIk2XYqoYiM6zarhdPswb703HEP68g+MvXoGdy9tfUJFfLdXNqDEIkaElkVU3WeSTJcGqNpC
	1OhOvW
X-Received: by 2002:a05:6808:1705:b0:450:b7a0:41ca with SMTP id 5614622812f47-464beceb57cmr5117096b6e.22.1772445008444;
        Mon, 02 Mar 2026 01:50:08 -0800 (PST)
X-Received: by 2002:a05:6808:1705:b0:450:b7a0:41ca with SMTP id 5614622812f47-464beceb57cmr5117069b6e.22.1772445007942;
        Mon, 02 Mar 2026 01:50:07 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59be78sm7391540b6e.13.2026.03.02.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:50:07 -0800 (PST)
Date: Mon, 2 Mar 2026 01:50:04 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "jackmanb@google.com" <jackmanb@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] page_reporting: change
 PAGE_REPORTING_DEFAULT_ORDER to -1
Message-ID: <aaVdTM3ubiDa2ELR@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
 <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
 <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
 <aaVQXbllLVBLZCwQ@hu-ysakshit-lv.qualcomm.com>
 <571547b0-007a-4cf9-be1d-95a0ef871cf8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571547b0-007a-4cf9-be1d-95a0ef871cf8@kernel.org>
X-Proofpoint-GUID: 0QQRg4ZKALQewJ6NhiEUdB52_LgmOJhM
X-Proofpoint-ORIG-GUID: 0QQRg4ZKALQewJ6NhiEUdB52_LgmOJhM
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a55d51 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=0mXQa5sO9039VI3KVg8A:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4MSBTYWx0ZWRfX4G7F+Uoh3gYR
 Z3q0tbdBNZg/hEbWRD9BzwI8kKsKE6nR9AeRrTJnC7r3jdf/X+ID1zOgyMhH1+NRvEvRZKhfgoR
 5/2qaBUI0A6c6xxgNSvTYMh8UPy31WgaY7WkN4NqFLhLRWvjZInX0NgknJW9E2ZMALOWzR8vTzL
 2KU1IzHhcbucGxEGAhrFlT8l9NagFxLhlxM/1D+ptdZbvt2uMUPf0vdpt4uUAikjUY7suuzYHSB
 qNLveoExcnH+YVX0YAJup8lR3GKnVMadVQ0mg9lmcJNhIR6TXLIlgO+L4i4mRSx8veoQAF8QLD+
 WBJ5FU6kvRnFKY23nRc+NZWq6vqWihg4qxxLYy2wt+3mZ/0j/2COp4cN5rzYZxwed2g68/kKKGI
 GuBLFt/opmyrQdjE9xOgh8z42fxO7NWlfSgFYiPIrhs29bZUHdMb3tV9W79LfUcdAl84ASlCLQn
 eYpsg2cHCEcCV7kiciw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,linux-foundation.org,redhat.com,microsoft.com,kernel.org,linux.alibaba.com,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,nvidia.com,vger.kernel.org,lists.linux.dev,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9080-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,hu-ysakshit-lv.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9379C1D5C15
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 10:18:23AM +0100, David Hildenbrand (Arm) wrote:
> > Great. Much more clearer on page_reporting.c 's end. 
> > 
> > Don't you think on the driver's end:
> > 
> > prdev->order = PAGE_REPORTING_USE_DEFAULT; looks clearer? As compared to:
> > prdev->order = PAGE_REPORTING_ORDER_UNSET; ?
> > 
> > I'm thinking, why would a driver worry about page_reporting_order being set/unset?
> 
> Maybe PAGE_REPORTING_ORDER_UNSPECIFIED ?
> 
> In any case, we should use a single flag for this. Everything else will
> be confusing once drivers could use only one of them.
> 
> -- 
> Cheers,
> 
> David

Sounds good. Thanks for the suggestion.

Thanks,
Yuvraj

