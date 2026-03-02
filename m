Return-Path: <linux-hyperv+bounces-9076-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFtiAGZEpWkg7AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9076-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 09:03:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E381D454C
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Mar 2026 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77974303C50B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2026 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4338756B;
	Mon,  2 Mar 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmmPBCzJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PcktGpJj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F1387351
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Mar 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438420; cv=none; b=IqO5y11p/zjeI3eWusBXvI2ORTjB9qtDSrrvM+R9w1yB1DeWAjr7KU/0MOg5BRN/GzOt+BaddvYKZhLUx21NA3kkCE9W7Ae9b2hPgl+MNsQgztAF7HSZisvYk+f+9/YW2T/iOTSd+dJ2p5y2mEqmmrq+sjDfdlm9eE7/P2RgC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438420; c=relaxed/simple;
	bh=3/LPu8Gts57wbVnF84SMwpPToGqL3wOUTkkMJnDpAvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohQWioqhqoJ6prWv+qQH9NB0YU8T22U4bxeqbwqN6R4Ut2Tog9iVa9+RKFWfAm1WWZpOkuJwRTX6+aFr4nLhEga+mQmGdoFkP/66we7eF9dLAZDA5+Q55N26+/FoKvRjFF1xEDiUIFtHXso3XGGLwcenVQCnlyjVerHXwwGFXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmmPBCzJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PcktGpJj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226h9Rf2504598
	for <linux-hyperv@vger.kernel.org>; Mon, 2 Mar 2026 08:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=; b=DmmPBCzJu3VyO1SN
	wjUcAMCJ102h39ME6280NXmFtyFkJapr95qwwXuADR9wfyaDz5OhyoPZHJypvWgt
	SedxVIeWxfe3QBXShnLQ0yNo6t3hu5oBxC6xUTxSTL/on6b3UOv/zwE3lLcn0uY2
	JrcMNJE0N5TOSmUvZqUJuyPbksZRFz/S1Z44Nb3D7K1wqaa6klBr8n2x8+RRSKcl
	feXxcoKIoyrZM1R55Gw04M7GZ1H1Qj9KhO9Gq/qHaDRt7NrgswXykBkm44JZizRH
	1NIXEjFdB2bHXQQOqQTgKZthVbYR0w8NEctD724F0aov7cmGAdQfzRnMzu+WGKip
	Pp9zWw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5her7b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 08:00:16 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-463a075e0f5so60389020b6e.1
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Mar 2026 00:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772438415; x=1773043215; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=;
        b=PcktGpJjz2AyqaBW3sPup/1zEnjco3mNOpAePO2h2Mc2rB7LM9kBz8uJyveeefg7+8
         XfFXHWWBhg/7S4WEN3zVoJxzTpfCpQZSV48UC1kt5AEAx1E7JK8IOrj/Gp21ZQ5CiYHz
         yYNl2bro/TtkISlISTv7mXj4RhuCPExHWcHpaJrUpgwhgh4gklmwn0AOGaMHlx+sqDvn
         4MX6NDMlJjmUzuKDRhh4ACElpydlTTdCELZHCYEj4n5bpqRQ6UZPrMuDIxMTei6845Ex
         3C7gSKeJ5GrPQzWqhbyOktYBN8Ya6wRoGQD/dZXEjo0+vivB+cd8ckotkncXoKnbaHMQ
         0RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772438415; x=1773043215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm+FCCw8m1OMv5Ns4PujjpGalNlRFRIbaokGeVA3Mu0=;
        b=mUlHVeJgwCJ65I4jLUgpYNc+nHW/hfwAI2wOnHKL3E88dEJ6oRs0k1mdeW8BebS421
         vjdEDeqsfRQCfgzF8VOsa5Cs5O2cSHu41TQ9bgXtqolAii661Yr13IIvIShhC73d0o4M
         8TDfkBG2CB12/fYSFD/sF/rVN/SlG4c7lVgYo/PZd86lYlawO7zebqxZhwUnZ34VazjD
         EKxkWSV3cmz0vuFpiCz6/S98NlPFRZs4jRM2265mKrlToG/majzm9fx+8lfRNgc0thJH
         b+Fj+fgwP9vRJ2Cf9DMdtP/Upy1i6Lf0k2imSUi8peRAnohnX6dKLbKjhR0oFX44Rth+
         UJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBbEXTOja6KxGDHcs2zxtncEozoLA4ArElQL6Lw54dT4I6BHT6H6kF/qOFqyb0GdL9zGI/Mt6aHLfUAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5OkciRsnxqsAEzRfjm/vwdALeQTQaRh6gbkEX+EaENiSHnD7
	Y6eu5ozLBnHi9J/D0T83MVApK9mUh+URTyD7Pr/l4CZ/6Z1WU6PvuldIntu4ALEyuvxxraY7oX/
	vIAIFtibZtmwljzRPI5rNfZdVkyq34fmYI0L/MOPuUhqOX1eDMqnNu3TCwTc3esnGPhE=
X-Gm-Gg: ATEYQzwYPGbyOJDwfvtExtKRfVHyfF6+KyuBgZ57VPHfRgL3n/ZvKJLwgc5EF8Yeol8
	oroA1Ah7uuIBXNn/pbcyre8xB3kZPXDOsK8vWqr+QM7gQwfRtA03qEiGn66p5gENEepOFYo9ADk
	+yP5E6j2Z3/7OU6Nphva7vH2EIZEOKnIp4BjDDAjJ8b/Rd9lTj5nuyUkTtttM5mtGPyPQ3f3aDC
	nedVzVIKtMXr+meJyTrmFEoQsOnhMoZ/gP+EnxrhYb/nhk7AZvDNVmGAfwtU+VV2En33RTt4cmk
	1E+NlYzT0IZrM1oW5ffYNjv8jcaCIZKwGh48rFiUOGJYi+90UBDAi5l60Ja0ATj2Q+VvW3RGMZy
	Pc/9/KxSsPVYPj0o+SZcaxmD7zRsGkAy0leX/Lx2vB5wnVsSdZe0tZg8Mj5kIlOh1yxLbS4C4IO
	W111mA
X-Received: by 2002:a05:6808:e82:b0:455:eba2:9efa with SMTP id 5614622812f47-464becb5a7dmr5673088b6e.4.1772438415467;
        Mon, 02 Mar 2026 00:00:15 -0800 (PST)
X-Received: by 2002:a05:6808:e82:b0:455:eba2:9efa with SMTP id 5614622812f47-464becb5a7dmr5673064b6e.4.1772438414974;
        Mon, 02 Mar 2026 00:00:14 -0800 (PST)
Received: from hu-ysakshit-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59ae6csm7159701b6e.11.2026.03.02.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:00:14 -0800 (PST)
Date: Mon, 2 Mar 2026 00:00:11 -0800
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
Message-ID: <aaVDiwEPl5t2UPX4@hu-ysakshit-lv.qualcomm.com>
References: <20260227140655.360696-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260227140655.360696-5-yuvraj.sakshith@oss.qualcomm.com>
 <c618e7a4-42c1-4438-9bc2-9c41450a81a2@kernel.org>
 <aaUE7M9QkfnYh12e@hu-ysakshit-lv.qualcomm.com>
 <SN6PR02MB4157D37B3D254251F0135B04D47EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1390b24-eaef-40e0-a16b-77c27decb77e@kernel.org>
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a54390 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=evlnEj6GgMtUoz0GkIkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: BXRlbM4230bgbFEYUQa2-eniRs4I4oIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA2OSBTYWx0ZWRfXyzHAqwdxmYWM
 0JCd4xwvf3VRN9EVvjEdcKvRD2cQ9SOJQUBwdp2neOtHrkvmGLW1jLT+3fp9osXjL1N9H2NxmtJ
 6SJAWPHSGQjDlU1SdaTtrV3Fs7E/ZKMQh/EsJVTiz0p9q/ztQjPwlJlI1GQMo+r5GM/zgKd6OKa
 RZ/D2kAVFNJFhefW1NJb6cdyZfyLCqkZt7xsbfEux/F/BoB/E0fZBtD50SBXW+T05UW7JQRujSv
 LpzC4NNjMaQ1auZANAD8DvdJmlORrEFxuurQ8gehzCfrASRIpdMziTtK4BZWQHaJv+5QuEPdEvK
 BBKM/+hX941bAc6rPh0GRADakfN7DBsBz0DODlkdLRDLB/6vAutXKycAnELB5uBTaHlv08Q/WMD
 wvKUxUH7pRIYLn9eTrpSlEAEpD/5+BHKpF1nWVEyoVPf0me9syuUuwhivWhx7010JSvEEx4O694
 YbrnHafmwBfK/leYf9w==
X-Proofpoint-ORIG-GUID: BXRlbM4230bgbFEYUQa2-eniRs4I4oIh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,linux-foundation.org,redhat.com,microsoft.com,kernel.org,linux.alibaba.com,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,nvidia.com,vger.kernel.org,lists.linux.dev,kvack.org];
	TAGGED_FROM(0.00)[bounces-9076-lists,linux-hyperv=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-ysakshit-lv.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 70E381D454C
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:42:57AM +0100, David Hildenbrand (Arm) wrote:
> On 3/2/26 06:25, Michael Kelley wrote:
> > From: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com> Sent: Sunday, March 1, 2026 7:33 PM
> >>
> >> On Fri, Feb 27, 2026 at 09:50:15PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> No need for the ().
> >>>
> >>> Wondering whether we now also want to do in this patch:
> >>>
> >>>
> >>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> >>> index f0042d5743af..d432aadf9d07 100644
> >>> --- a/mm/page_reporting.c
> >>> +++ b/mm/page_reporting.c
> >>> @@ -11,8 +11,7 @@
> >>>  #include "page_reporting.h"
> >>>  #include "internal.h"
> >>>
> >>> -/* Initialize to an unsupported value */
> >>> -unsigned int page_reporting_order = -1;
> >>> +unsigned int page_reporting_order = PAGE_REPORTING_DEFAULT_ORDER;
> >>>
> >>>  static int page_order_update_notify(const char *val, const struct
> >>> kernel_param *kp)
> >>>  {
> >>> @@ -369,7 +368,7 @@ int page_reporting_register(struct
> >>> page_reporting_dev_info *prdev)
> >>>          * pageblock_order.
> >>>          */
> >>>
> >>> -       if (page_reporting_order == -1) {
> >>> +       if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
> >>>
> >>>
> >>
> >> Sure. Now that I think of it, don’t you think the first nested if() will
> >> always be false? and can be compressed down to just one if()?
> > 
> > I don't think what you propose is correct. The purpose of testing
> > page_reporting_order for -1 is to see if a page reporting order has
> > been specified on the kernel boot line. If it has been specified, then
> > the page reporting order specified in the call to page_reporting_register()
> > [either a specific value or the default] is ignored and the kernel boot
> > line value prevails. But if page_reporting_order is -1 here, then
> > no kernel boot line value was specified, and the value passed to
> > page_reporting_register() should prevail.
> > 
> > With this in mind, substituting PAGE_REPORTING_DEFAULT_ORDER
> > for the -1 in the test doesn’t exactly make sense to me. The -1 in the
> > test doesn't have quite the same meaning as the -1 for
> > PAGE_REPORTING_DEFAULT_ORDER. You could even use -2 for
> > the initial value of page_reporting_order, and here in the test, in
> > order to make that distinction obvious. Or use a separate symbolic
> > name like PAGE_REPORTING_ORDER_NOT_SET.
> 
Option 1:

if (page_reporting_order == PAGE_REPORTING_DEFAULT_ORDER) {
        if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
                && prdev->order <= MAX_PAGE_ORDER) {
                page_reporting_order = prdev->order;
        } else {
                page_reporting_order = pageblock_order;
        }
}

Option 2:

if (page_reporting_order == PAGE_REPORTING_ORDER_NOT_SET) {
        if (page_reporting_order != PAGE_REPORTING_DEFAULT_ORDER
                && prdev->order <= MAX_PAGE_ORDER) {
                page_reporting_order = prdev->order;
        } else {
                page_reporting_order = pageblock_order;
        }
}


> I don't really see a difference between "PAGE_REPORTING_DEFAULT_ORDER"
> and "PAGE_REPORTING_ORDER_NOT_SET" that would warrant a split and adding
> confusion for the page-reporting drivers.
> 
> In both cases, we want "no special requirement, just use the default".
> Maybe we can use a better name to express that.

Agreed.

If we were to read this code without context, wouldn't it be confusing as to
why PAGE_REPORTING_DEFAULT_ORDER is being checked in the first place?

Option 1 checks if page_reporting_order is equal to PAGE_REPORTING_DEFAULT_ORDER
and then immediately checks if its not equal to it. Which is a bit confusing..

And moreover, page_reporting_order can be set by two people. The commandline and
the driver itself. So PAGE_REPORTING_ORDER_NOT_SET can indicate if its set by cmdline
and PAGE_REPORTING_DEFAULT_ORDER can be used by drivers exclusively to "tell" page-reporting
to select the default value for us.

I think what Michael is pointing out is the prevalence of cmdline option over the driver's
request. 

This is not obvious to the reader if we choose to only have one flag IMO :)

Thanks,
Yuvraj
 
> -- 
> Cheers,
> 
> David












