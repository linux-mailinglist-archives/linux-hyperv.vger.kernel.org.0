Return-Path: <linux-hyperv+bounces-3594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF86A040D4
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 14:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C99163108
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2025 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3005C1F03C5;
	Tue,  7 Jan 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OBlsnYR/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D71F03D5;
	Tue,  7 Jan 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256577; cv=none; b=mOKw6PVqA+iieNrsddlh39Tkp9FbCt9EFkGufStTqcs6jsm+tVav4+NLP5bmwzARxQ3vBQWq0FxK1bneBIK9KGpNUHlE0NYI/7ciVws5pUHUQwc5XXxA12IHA0dbr1E7DB2wn2ZH5AEd4onKJzJe9nUaub29r2U4Aq8/vWi6tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256577; c=relaxed/simple;
	bh=L+MkuHhCLgD8kGQfSxdeNfO2pfO1WF0R1klzgWW+KGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0JQTSQDKstP20BejQWE2KGlVc+6EWg5Bz9nBw8wE1wbKHgF6uULWjTLAgB6lwJIzYvHMuL0JqbL9E8U8JlNvFbyBnTIFjJY3EAq29e9eQfMJdSNofDk01BWIDMJMJYF0xbNekIXR7xTorHpJRkazd/VfKKoKPswDBf3oetblIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OBlsnYR/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507BWGNg009731;
	Tue, 7 Jan 2025 13:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mLgDzv/pVpbzGVF/OSbbOoTsrwb8sA
	5JJIlfnBc5IRk=; b=OBlsnYR/bBezL2GRdAOvCDpfjTzgBC1YAjcDWKh3genAFF
	7VmFYGzCQqntDisGxSNct7Weq0zBh7U5qGIkA5VFcOJnoftvLaehKEFWCQfbiAfR
	Hl5eFKoY3fwyy2nUB/xz6agS+ZhpnxTY7T/PX+63Xv2yU1Kk0y9tcnz2IFIcrbYV
	NzQeY+t+o8ZjwiyLasSJ3MUgeMRk8A4h2B7dp/wPkINyHfgIfyQ633G927/t2rHM
	KAh2R9OaibMnsh2VLHw9gByqghhedxAONPnPg+tuNpdgnb/8oi6iqo8T34dO6hVT
	kuVJh4zs/jK+zKcJflBj0i12SBFp1JxjCTVCM/Nw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440s0aaygh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:28:40 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507DSdcj025835;
	Tue, 7 Jan 2025 13:28:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440s0aaygc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:28:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5079nnbp027946;
	Tue, 7 Jan 2025 13:28:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk2dgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:28:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507DSY0s27591038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 13:28:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D9D820040;
	Tue,  7 Jan 2025 13:28:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3C020043;
	Tue,  7 Jan 2025 13:28:33 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jan 2025 13:28:33 +0000 (GMT)
Date: Tue, 7 Jan 2025 14:28:31 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matt Wu <wuqiang.matt@bytedance.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, Greg Kurz <groug@kaod.org>,
        Peter Xu <peterx@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-7-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-7-yury.norov@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CvBcdJZ3Px_Fxar3yVlr0JKsNe7bUdCi
X-Proofpoint-ORIG-GUID: MYFcjTtUWdbqcyxPXpK7_i-p0KcJF5T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070109

On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:

Hi Yury,

> cpumask_next_wrap_old() has two additional parameters, comparing to it's
> analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> historical.
> 
> Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
> iterator. Now that the iterator is an alias to generic
> for_each_set_bit_wrap(), the additional parameters aren't used and may
> confuse readers.
> 
> All existing users call cpumask_next_wrap() in a way that makes it
> possible to turn it to straight and simple alias to find_next_bit_wrap().
> 
> In a couple places kernel users opencode missing cpumask_next_and_wrap().
> Add it as well.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index b267a4f6a917..18c9908d50c4 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  		small_cpumask_bits, n + 1);
>  }
>  
> +/**
> + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> + *			   @n and wrapping around, if needed
> + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> + * @src1p: the first cpumask pointer
> + * @src2p: the second cpumask pointer
> + *
> + * Return: >= nr_cpu_ids if no further cpus set in both.
> + */
> +static __always_inline
> +unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
> +			      const struct cpumask *src2p)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
> +		small_cpumask_bits, n + 1);
> +}
> +
> +/*
> + * cpumask_next_wrap - get the next cpu in *src, starting from
> + *			   @n and wrapping around, if needed

Does it mean the search wraps a cpumask and starts from the beginning
if the bit is not found and returns >= nr_cpu_ids if @n crosses itself?

> + * @n: the cpu prior to the place to search
> + * @src: cpumask pointer
> + *
> + * Return: >= nr_cpu_ids if no further cpus set in both.

It looks like Return is a cpumask_next_and_wrap() comment leftover.

> + */
> +static __always_inline
> +unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
> +{
> +	/* -1 is a legal arg here. */
> +	if (n != -1)
> +		cpumask_check(n);
> +	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
> +}
> +
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
>   * @cpu: the (optionally unsigned) integer iterator

Thanks!

