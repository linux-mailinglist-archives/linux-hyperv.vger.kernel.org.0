Return-Path: <linux-hyperv+bounces-3709-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100CBA15064
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E747A1935
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749601FF1C3;
	Fri, 17 Jan 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nzhgJhl8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA21FC0FE;
	Fri, 17 Jan 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120069; cv=none; b=GLckw81SwUh9hdG4yke6sD8+yW+0cTgBkw5QE7foHhD7c9PdEKUl5hULqCmcBjzUXpoHrSVut6FUmGWM1n34KzpV7aLN3l6NLLth62Bh/s0PxJjUb4WDxnqcPdKFzM9+Gr5GLXQCDFLNiPtR+uxIyvY5TSAsKlWFoKaK1XersPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120069; c=relaxed/simple;
	bh=aiaLO7JOS/tiFH4bjxy1BXejLm8z/5d2sO9cWPTeqBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHrofFzSaZ6+opq3UuxE5VaZuzAPzqxMjdevH8s2oH6BaDYuvFskKfvpfh8T8Xg0vQeYsZ7EWc59QehHMJtxwmxB2QLcLgx1AErTmdOMg/xHdcmRsSiGB5Rnl526ZxS69uU120bo0yNAU4BaqIyguxUShIUhLlALDRmlJ93sDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nzhgJhl8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H3rR79014843;
	Fri, 17 Jan 2025 13:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pbus+S
	7a/ttKEhJxvSdfKJlC6GWLE/WfDPSwSWIOm6A=; b=nzhgJhl8rBJynIUzc86dnP
	KEMI+6PJ/6WlrxMduKu5lw9OTP8ewZCRq5ZrINyv2iIELDledWo/qWY7XGjhzazZ
	s2wfQMPqOqdBM4SdeFRpqTzreo3MGu9OjS98uBzeDCOuH6I/iWllgBUlL6/mBH9b
	E1RtQZN3RzqmOyeuyT/d6Gd3TqY787mq/nUbo+te9rnqyjneeW8gW5ivG4C2Jxq0
	10k6rMn77E/w2KjF46avpxIMkeLkTQBHyb2M1wU/nG9h0u4npF650xYY3/BP9yPf
	32L+9WIyWUBNs50Uc3KPRWDZLwWeE1t9VvfpvEFTNasQSrbNYZdBLNUeWfSMd6xA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpuaba7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:20:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HDKq5d013294;
	Fri, 17 Jan 2025 13:20:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447fpuaba3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:20:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9h0PA002700;
	Fri, 17 Jan 2025 13:20:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byk5nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 13:20:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HDKokL30736906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 13:20:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7063558059;
	Fri, 17 Jan 2025 13:20:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4F0058058;
	Fri, 17 Jan 2025 13:20:47 +0000 (GMT)
Received: from [9.171.10.145] (unknown [9.171.10.145])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jan 2025 13:20:47 +0000 (GMT)
Message-ID: <0749cd68-c5ab-4ab6-9c48-6e445263333b@linux.ibm.com>
Date: Fri, 17 Jan 2025 14:20:46 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] rhashtable: Fix rhashtable_try_insert test
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Kelley <mhklinux@outlook.com>
Cc: Breno Leitao <leitao@debian.org>, "saeedm@nvidia.com"
 <saeedm@nvidia.com>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au> <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
 <20250102-daffy-vanilla-boar-6e1a61@leitao>
 <SN6PR02MB41572415707F0FA6D9A61247D4132@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250109-marigold-bandicoot-of-exercise-8ebede@leitao>
 <Z4DoFYQ3ytB-wS3-@gondor.apana.org.au>
 <SN6PR02MB41577C2C4EB260F3D2D4F85FD41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4FXs8vAtitHIJyl@gondor.apana.org.au>
 <SN6PR02MB41570F1F5F4F579B4E8F0CD3D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z4XWx5X0doetOJni@gondor.apana.org.au>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <Z4XWx5X0doetOJni@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SfzBTF39apMgRV92JDaLcMDIDNyBIFLg
X-Proofpoint-ORIG-GUID: rL4d-Rmr_WWKK3HQ6hGm2fGBG1kY_hF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170105

Hello,

On 14.01.2025 04:15, Herbert Xu wrote:
> On Fri, Jan 10, 2025 at 06:22:40PM +0000, Michael Kelley wrote:
> 
> Thanks for testing! The patch needs one more change though as
> moving the atomic_inc outside of the lock was a bad idea on my
> part.  This could cause atomic_inc/atomic_dec to be reordered
> thus resulting in an underflow.
> 
> Thanks,

I've tested v3 patch on s390 for the boot OOM problem with 'mem=1G'
kernel parameter we experience on current linux-next kernel and confirm
that the issue is no longer present.

Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

> 
> ---8<---
> The test on whether rhashtable_insert_one did an insertion relies
> on the value returned by rhashtable_lookup_one.  Unfortunately that
> value is overwritten after rhashtable_insert_one returns.  Fix this
> by moving the test before data gets overwritten.
> 
> Simplify the test as only data == NULL matters.
> 
> Finally move atomic_inc back within the lock as otherwise it may
> be reordered with the atomic_dec on the removal side, potentially
> leading to an underflow.
> 
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: e1d3422c95f0 ("rhashtable: Fix potential deadlock by moving schedule_work outside lock")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index bf956b85455a..0e9a1d4cf89b 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -611,21 +611,23 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
>  			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
>  			data = ERR_PTR(-EAGAIN);
>  		} else {
> +			bool inserted;
> +
>  			flags = rht_lock(tbl, bkt);
>  			data = rhashtable_lookup_one(ht, bkt, tbl,
>  						     hash, key, obj);
>  			new_tbl = rhashtable_insert_one(ht, bkt, tbl,
>  							hash, obj, data);
> +			inserted = data && !new_tbl;
> +			if (inserted)
> +				atomic_inc(&ht->nelems);
>  			if (PTR_ERR(new_tbl) != -EEXIST)
>  				data = ERR_CAST(new_tbl);
>  
>  			rht_unlock(tbl, bkt, flags);
>  
> -			if (PTR_ERR(data) == -ENOENT && !new_tbl) {
> -				atomic_inc(&ht->nelems);
> -				if (rht_grow_above_75(ht, tbl))
> -					schedule_work(&ht->run_work);
> -			}
> +			if (inserted && rht_grow_above_75(ht, tbl))
> +				schedule_work(&ht->run_work);
>  		}
>  	} while (!IS_ERR_OR_NULL(new_tbl));
>  

Thanks!

