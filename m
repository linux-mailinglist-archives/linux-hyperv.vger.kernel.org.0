Return-Path: <linux-hyperv+bounces-3658-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F2A09441
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB85188DD21
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27082116E7;
	Fri, 10 Jan 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PLTC+5mR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A52116E6;
	Fri, 10 Jan 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736520442; cv=none; b=oMZhVj7ivGM6y6Ya3TK2d7lFESp4JdoIHgmp3KL9AnmI6wUILG8oSmWGpZU+SYUlhZWm5jtbQtaeGgPY/DnAQyF2XPjgX14fnb5I58xo3QgIPeOxmyReFC65vJC/GD5+lkoJmrwK0kiwoKKet18P2qNOh4BwS/WVfsvR4lvEF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736520442; c=relaxed/simple;
	bh=Nwi9x0KRVUX+HhVnzQQfUW3EJ1pjbVFPSiqj41R7hP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjg+Ka0jcbfUoubFr8CHtXJ+Kf56mMLQnMIxiE8ptpsTw8WYBzNV34Jx4Y1eXIawxPEWa45HudDY8/WOufiTRPiR2diQFgcemPpdlDr6oN9B1McuhsjYHH4sfarJN8ISYVWoOoXGjnIg4k77Ncr/CHX6I80/DzVS8t2OmGzBnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PLTC+5mR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AEIQus015062;
	Fri, 10 Jan 2025 14:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZYbwep
	TLCOiqF08Tk1K3/9sm1ogW5I4vbVOfFlCfgEM=; b=PLTC+5mR8TgHXUM5beLlTc
	MI3pCmMBveC/9qyZBMi1TP/1TkmEQ9E6RsddpbLPjL/2R1vLEQ3V5xMj1M4SRiin
	GADEeS8p2xdHcqGlzGSzb06zzT6/BFVw8iVZvNSCZUGuTs2h/8VU7kc46pXmLDiF
	qY5yo6950fzySAgGiivynWaoniwZAa8+yf6Bk5cP5Kmw7mYPsjJnzga1yQdVCSsQ
	87ueJbwqZn6ZIS2xDpeCKuC4mWRSl2mrE3PBmGsyExlNprtKOvLMrM7MsoTcuFh6
	7LQOwLzPJkg/51zKKvdVdH2aQ+wmTUgnWpLBFujjMVxheC1ytFzvyOkIG3oH2kXQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1bthgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:47:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50AEl0Qn009482;
	Fri, 10 Jan 2025 14:47:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442v1bthgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:47:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ADgCSV013571;
	Fri, 10 Jan 2025 14:46:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygapanrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 14:46:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50AEkwSv30868148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 14:46:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DF785805A;
	Fri, 10 Jan 2025 14:46:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE8758051;
	Fri, 10 Jan 2025 14:46:55 +0000 (GMT)
Received: from [9.171.42.47] (unknown [9.171.42.47])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 14:46:55 +0000 (GMT)
Message-ID: <afb5abb3-8060-42ed-bb8f-48fb13d99d0c@linux.ibm.com>
Date: Fri, 10 Jan 2025 15:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
To: Herbert Xu <herbert@gondor.apana.org.au>, Breno Leitao <leitao@debian.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kham6myY7StHcU36gligKTUdQpQnBn5d
X-Proofpoint-GUID: 1vmhUAfWMifC2MPi-Y80M2IerHttMSQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100114

Herbert and Breno,

On 10.01.2025 10:27, Herbert Xu wrote:
> On Thu, Jan 09, 2025 at 02:15:17AM -0800, Breno Leitao wrote:
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..e196b6f0e35a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -621,7 +621,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  
>  			rht_unlock(tbl, bkt, flags);
>  
> -			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
> +			if (!new_tbl) {
>  				atomic_inc(&ht->nelems);
>  				if (rht_grow_above_75(ht, tbl))
>  					schedule_work(&ht->run_work);

I'd like to let you know that I was getting OOM failure on s390 when booting
the kernel (linux-next20250109) with limited memory (mem=1G kernel parameter).
Problem took place in both zVM and LPAR environments. Bisecting also revealed
the commit e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving
schedule_work outside lock").
Afterwards, I tried the fix from Herbert above and the error does not appear
any more. So it seems to resolve the issue.

Thanks,
Mikhail


