Return-Path: <linux-hyperv+bounces-9078-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLoxKp1QpWms8gUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9078-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 09:55:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0681D5035
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C1F30053EB
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6538A71C;
	Mon,  2 Mar 2026 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UiXClT8S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eCD6e4gU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C338734C
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441699; cv=none; b=CeZ1AVYXV+XLLqUnB6/C5yumf7uq7YdIbBnNuu5M5dElV/SmtKuUIhMhFTMPPqKFw+m7mXagCCVk5DhQtWGJd7nt2t+OmyTMu9ak32SYQ1SNNIGfUZDKgB0rm5Oc/hHNH+ITGe8eAvlKJsJTQb67MS3aXIAkxkZsJo9ytlRca7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441699; c=relaxed/simple;
	bh=yAVNgr9MNWD3wb1JJDuoyQVT80SX0m0ChtTIobo4WTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR5x5iRXlROhdPvaZWuSPaoA9t3xPtaXlq9P3psdqVilTRQmEqBfQzNs9L26syrZqqJxF+LpaCrpJ34IIm6w54LX9qqrYaUGZM0YwClgvI1A6woa8XVdbcwp47Y7TtY8HgZg1MxJHYoHqOXjEPn9kjTtAgyKF5QKL5GNQE2HUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UiXClT8S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eCD6e4gU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227pmiv2284148
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 08:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=; b=UiXClT8StLpOkcSl
	GGZSemcy/y3pud38KNf984akTJRGXanuWkoBn4K0tBx1GU2xO1Rw76YMi+MCilXZ
	d7iIiFsJxK6WvdkR61nk685Mf6YvuxHIW+Xg1lHEK+7HSvJvwT25Koj0QeNEi4KN
	pHZkQDdU6npQtZadSHXg2Izeon+kxnPAQS6+0u4DuLd67gnMzPE59qRxBkpu+y2D
	4dPyx07m12llki85ccLuuKRIvmVwbarFNUGXVmyt0CcEUNPezkVuqudZfx3+1j3G
	G1rO+zQEay0LFMFPXg11Nud0CFhRvzMU7089CwF4iuO5gJYP4X+2gD6UHeN+zbMY
	fBfEXQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgq4w5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 08:54:57 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463a075e0f5so60575207b6e.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 00:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772441697; x=1773046497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=;
        b=eCD6e4gUpfjq3RyyXKylETOFeTAOX0lOoG6jgRudE1FT0RJY9Q9/BJMVjEsLYp0cSB
         EM3A7kqh3jpYe9X4vPmQohNVeaHU95eM0uiOehz/2YVaxOj798hjTC+hZMUTxMBfpe8y
         iqpnavrVy3kG4iitcgXaqf7X34FD/3GQWOjtawRzT0bP68bNpXcFWTSnjUnB2s3OFwLG
         rr4BJm8qwjb+aTgLW42HVYjJ22ACdbKU+fCjUmvr38y/x+DOQYXB1QFByDpzF3f6VkiQ
         +sZ4Pe0jYXFLTZi925BeJ4gReWvowGFLnPLJ70UUmxCId66DwWK3tsKbZMN/N/0xfRK/
         GAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441697; x=1773046497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDAsilwm29vpqMN7M32WikMZCz3A2rKxXxCHXUW3bm4=;
        b=qAd1iFPl82GY5zVqArql0NBcZTFZ3yGaF/QM0MPqK65ylsLsX880z3lK9eu1qHQnPb
         Ad1Y7mjJ3y8jAftkv+F1dhOQssHJG6Dy2/sSDEtL4cw8BixDwYI4sUpWq64Vzcquc9ZJ
         BdiZ6DDu9PBkw/BIztI3n2Q7mmemNffexat9f0Bi/PG91Ph5TBjPDukYBmfNYQfzaCGl
         1x6LS0HWmG7PV6sVvBeI1xGYfahxH6tNpJzPnr4sMmA59VLHOgDlsEeJEGFJ24LPsfa9
         cA3HDBEbom/6CR3ReSYzDPuAJvDl0XkHdh7F3zAyrURkDmekt4QNV3skCEl0k6wYamfZ
         +nVw==
X-Forwarded-Encrypted: i=1; AJvYcCWxYWTdfSmFvSppCit8F8yfnaqilVdCrEjK5qPzR3dcst4wLgw/vD8LvjB/6EUULzD8WXRBMVCC9GI6SQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFBKmjtzmcWGpwRdGGl/6cUT+gCQ4IZagB8/VeGyZZyMYCRtue
	ckjczQCpCDE0dKkYTK0aGZXouEx58ygcTO8AOpMN2xCIsRn9G7kFACW7RpO6UmrQrqna1qtATcc
	9A219LedmRbuDsurG+aB/KBZpn8kvB8QjZmfoE9FGANZru823PHRspe1e6G8ijBVXHAI=
X-Gm-Gg: ATEYQzzdhrmuOqTzigMacU/9LLITWHVvPXaQIXCkacH3gK2jCq3HY33Lwhfr3LsiGFS
	HXZVZ0wPNQbCPWlnllrfgKi7NaAvcdLJGUBeXP/paoBBGiiRDJ7R9IkqKtvMYrz7ZBG4HK9D/eV
	RPDRl7yf0DazoRTIx1Rz9AUeZmegLhVVKDllXBfxb2C3Xlnn2R8AD1arcUOCkbieW3snVfT6Y5L
	icEt2SqDEkF5bqqrsdUTLcQ3AYchVgBoaVSWrbLr++zP3DrQ222FLR8EpjWWNiFjy5FrpsAXukA
	15bMi9x8lemcQDTbZhxWNAsp+7lPDmWVr0sE/q372npqKl2Fy/6bKrmWQvML5zCzx0680aBxqA7
	WL4Fd1ghKKPmtmkubLZwpdev0rkpMLMes5RzVX4NUjqjA+QOLDb3AfuRLDv1K2ura7A6tGp2vnX
	BWUcdD
X-Received: by 2002:a05:6808:17a2:b0:43f:28bb:2f85 with SMTP id 5614622812f47-464bed089e3mr6071929b6e.8.1772441696802;
        Mon, 02 Mar 2026 00:54:56 -0800 (PST)
X-Received: by 2002:a05:6808:17a2:b0:43f:28bb:2f85 with SMTP id 5614622812f47-464bed089e3mr6071919b6e.8.1772441696393;
        Mon, 02 Mar 2026 00:54:56 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm6981075b6e.8.2026.03.02.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:54:55 -0800 (PST)
Date: Mon, 2 Mar 2026 00:54:53 -0800
From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Michael Kelley <mhklinux@outlook.com>
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
Message-ID: <aaVQXbllLVBLZCwQ@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
 <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
 <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0133403-8ce3-45a4-987f-96fb7421f920@kernel.org>
X-Proofpoint-GUID: GHKaSy6jBXiGmxdPFMGNPye7NNvfUHzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NyBTYWx0ZWRfX5ZwTo4i+Nns6
 Iux07ENaZPbnGD35SgICCVlnI7ShwrmMOASLOoh4uQYrSFbabuCSG2Pyh/GpD40tTFvD6vzsTwZ
 AaMn/nzQT1S4lHn0nabsDOQx22bROg6Zj2ZgbGHyy1LHWFYUqKjeSWsSXPdYOWUITFeSuD6DI5v
 wcdSBF7svrJrrdbfhnHwX6eXlSUT7dJ4donilR5Q7BG5/RGiqUKpIJ/Xt3PKiSamem2HHgQ5zfp
 VUoKPnZuhNMl0ZpGA1L6TOTFZ2nnSRKvOQ0M2TbrkxvggM9tq2XfGwdhtBeFVei9vYZDERVLQ12
 /3c9gQqbHxr/kGl4ZTyvOEZBCpI0/Aoruq4YC2fngfYwWioKcr92hOEvi0v9hyHIMdmr+7vWkSy
 NvPb3KhA9ZzF9eLjo5JlfTPPsPzT1a8wQw3rJGYnDN/N6SdmbcgMEMGD1iOjffuUnVWVKeERHwQ
 l+OfAZGfoG/Uj3dyO1Q==
X-Authority-Analysis: v=2.4 cv=bdRmkePB c=1 sm=1 tr=0 ts=69a55061 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GS-8L0ZNGZhbl8INtmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: GHKaSy6jBXiGmxdPFMGNPye7NNvfUHzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,linux-foundation.org,redhat.com,microsoft.com,kernel.org,linux.alibaba.com,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,nvidia.com,vger.kernel.org,lists.linux.dev,kvack.org];
	TAGGED_FROM(0.00)[bounces-9078-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuvraj.sakshith@oss.qualcomm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F0681D5035
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 09:09:13AM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 09:00, Yuvraj Sakshith wrote:
> > On Mon, Mar 02, 2026 at 08:42:57AM +0100, David Hildenbrand (Arm) wrote:
> >> On 3/2/26 06:25, Michael Kelley wrote:
> >>> From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com> Sent: Sunday, March 1, 2026 7:33 PM
> >>>
> >>> I don't think what you propose is correct. The purpose of testing
> >>> page_reporting_order for -1 is to see if a page reporting order has
> >>> been specified on the kernel boot line. If it has been specified, then
> >>> the page reporting order specified in the call to page_reporting_register()
> >>> [either a specific value or the default] is ignored and the kernel boot
> >>> line value prevails. But if page_reporting_order is -1 here, then
> >>> no kernel boot line value was specified, and the value passed to
> >>> page_reporting_register() should prevail.
> >>>
> >>> With this in mind, substituting PAGE_REPORTING_DEFAULT_ORDER
> >>> for the -1 in the test doesn’t exactly make sense to me. The -1 in the
> >>> test doesn't have quite the same meaning as the -1 for
> >>> PAGE_REPORTING_DEFAULT_ORDER. You could even use -2 for
> >>> the initial value of page_reporting_order, and here in the test, in
> >>> order to make that distinction obvious. Or use a separate symbolic
> >>> name like PAGE_REPORTING_ORDER_NOT_SET.
> >>
> > Option 1:
> > 
> > if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> >         if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
> >                 && prdev->order <= MAX_PAGE_ORDER) {
> >                 page_reporting_order = prdev->order;
> >         } else {
> >                 page_reporting_order = pageblock_order;
> >         }
> > }
> > 
> > Option 2:
> > 
> > if (page_reporting_order == PAGE_REPORTING_ORDER_NOT_SET) {
> >         if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
> >                 && prdev->order <= MAX_PAGE_ORDER) {
> >                 page_reporting_order = prdev->order;
> >         } else {
> >                 page_reporting_order = pageblock_order;
> >         }
> > }
> > 
> > 
> >> I don't really see a difference between "PAGE_REPORTING_DEFAULT_ORDER"
> >> and "PAGE_REPORTING_ORDER_NOT_SET" that would warrant a split and adding
> >> confusion for the page-reporting drivers.
> >>
> >> In both cases, we want "no special requirement, just use the default".
> >> Maybe we can use a better name to express that.
> > 
> > Agreed.
> > 
> > If we were to read this code without context, wouldn't it be confusing as to
> > why PAGE_REPORTING_DEFAULT_ORDER is being checked in the first place?
> 
> I proposed in one of the last mail that
> "PAGE_REPORTING_USE_DEFAULT_ORDER" could be clearer, stating that it's
> not really an order just yet. Maybe just using
> PAGE_REPORTING_ORDER_UNSET might be clearer.
> 
Ok
> > 
> > Option 1 checks if page_reporting_order is equal to PAGE_REPORTING_DEFAULT_ORDER
> > and then immediately checks if its not equal to it. Which is a bit confusing..
> 
> 
> Because it's wrong? :) We're not supposed to check page_reporting_order
> a second time. Assume we
> s/PAGE_REPORTING_ORDER/PAGE_REPORTING_ORDER_UNSET/ and actually check
> prdev->order:
Oops, typo :) I meant prdev->order.
> 
> if (page_reporting_order == PAGE_REPORTING_ORDER_UNSET) {
> 	if (prdev->order != PAGE_REPORTING_ORDER_UNSET &&
> 	    prdev->order <= MAX_PAGE_ORDER) {
> 		page_reporting_order = prdev->order;
> 	} else {
> 		page_reporting_order = pageblock_order;
> 	}
> }
> 
Great. Much more clearer on page_reporting.c 's end. 

Don't you think on the driver's end:

prdev->order = PAGE_REPORTING_USE_DEFAULT; looks clearer? As compared to:
prdev->order = PAGE_REPORTING_ORDER_UNSET; ?

I'm thinking, why would a driver worry about page_reporting_order being set/unset?

But yes, too many flags...  


Thanks,
Yuvraj

