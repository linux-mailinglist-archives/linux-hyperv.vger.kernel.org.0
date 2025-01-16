Return-Path: <linux-hyperv+bounces-3694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7DA13962
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32473A55C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0791DE3D8;
	Thu, 16 Jan 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kLIWNy4z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11481DE2C6;
	Thu, 16 Jan 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028133; cv=none; b=Vi2QOeRV0zCjIKvLnm0DFWVv4/ysj1QYKbFzrMK9TiTBDF3DEUZb0rcp51XSckJKsVz7ivoSpXEElE3n22p+YfQvcw2rmFxfBPZiXmg9e8ZA9TZehUFH2SYvp1UY938VOOD1RyucrmC5VcH0XUGPaa4UiTI3nw91q9xlrf1wJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028133; c=relaxed/simple;
	bh=Lw4wjAUigKzBAUDQnvuZb4RB/km3WbYe+PynVWIOnQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeDFC0fkWLsQpNvPsjd1P0EQdZI5u7ZwWyoUSXtE1aOhzv7zGk3cdFQP/9UyT5MGaVcP0KxC0NqC3SRr7Z7FaVwxXfoi/i0QU2sIblYpi9GUaJDLh7Bd1uEaufydzSoepA3w3ZWiSsuZJLvEf3w1hOartIot8oDAeNcqLImu5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kLIWNy4z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G3qjc4005877;
	Thu, 16 Jan 2025 11:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+xgvNP4z2pVkcvpTDSHfoQCpM3nse3
	2c8mpx7FXqAvg=; b=kLIWNy4zL5Y5d6PkjnnOJZWv2DFdqKHWq37n0sIxRIML4n
	q95gw/kzWsc4kTMeY5TfTJqywVtaGJ0WaPQhGUNlKC58mN6lNcqatrjNy+MnVScQ
	BdEJPadtwpEuh6Vj8GLUFj3bvNZYORcYxg8pTwUtDT9dIn6P7i11ad+/G/6VPRXI
	pVqjkd5a/kY1JRBlmdDJMIl9WQJGXYLxCWj3uTIUo7BShXRsvQygLAtMVwg0tBhB
	64w+njncburLeQg3iT/HGhZknNnw4gO2Gz0ZTX3aMYyRzCCm/u8FCRetFTXKqVjH
	Btc8E4dsTEVzsKG1P24cqsHtWlal27/CjpBB+jQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcj2c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:48:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GBia3N022145;
	Thu, 16 Jan 2025 11:48:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcj2bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:48:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GA62Qb007519;
	Thu, 16 Jan 2025 11:48:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yndmvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:48:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GBmRls58196414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:48:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C2120049;
	Thu, 16 Jan 2025 11:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE68F20040;
	Thu, 16 Jan 2025 11:48:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Jan 2025 11:48:26 +0000 (GMT)
Date: Thu, 16 Jan 2025 12:48:25 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Kelley <mhklinux@outlook.com>, Breno Leitao <leitao@debian.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>
Subject: Re: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
Message-ID: <Z4jyCZQOy8JMVu3Q@tuxmaker.boeblingen.de.ibm.com>
References: <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
 <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4XWx5X0doetOJni@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4XWx5X0doetOJni@gondor.apana.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hf-R3-h7RehK4HoSkpmbwde3SAJhOX-A
X-Proofpoint-GUID: Ls7pGjaLPrYOTwLcB5MjMFoEaNuc74Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=686 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160086

On Tue, Jan 14, 2025 at 11:15:19AM +0800, Herbert Xu wrote:

Hi Herbert,

> Thanks for testing! The patch needs one more change though as
> moving the atomic_inc outside of the lock was a bad idea on my
> part.  This could cause atomic_inc/atomic_dec to be reordered
> thus resulting in an underflow.

I want to confirm that this patch fixes massive strangenesses and
few crashes observed on s390 systems, in addition to OOMs reported
by Mikhail Zaslonko earlier.

> Thanks,

Thanks!

