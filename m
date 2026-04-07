Return-Path: <linux-hyperv+bounces-10045-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPlkOvAL1WlQzwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10045-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 15:51:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423683AF7B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE91307E04B
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8243AF662;
	Tue,  7 Apr 2026 13:40:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10903391E45;
	Tue,  7 Apr 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569211; cv=none; b=PE5lrXKoPGosqievZZiQIQtGHGE7YKdN5ZHzVctsaxghmaMHrmvx39CEtYBpxrb9zIxJ+XsfMjZI1suS94Roq+boj/dg95epHZiv1GYX1MU2/jd91UlgFILWhQrImCFliZrx/Tdo4n+JejyF++040ivsdIREwtl/ZBD7cYhLdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569211; c=relaxed/simple;
	bh=kO8Uuq9O6IKOaTr577VpJyzMgs5/XyDIgTjNQwkon/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bissRgomXOowQ9HXNupGoKkgMwPWVIGrr7Guo/SmnBw6+6ScY7DpcJvqQK/7mlmfEurkySmDYcB0MCPKCMUniI8LkE6NfAugQyegr4p0OE7oZHfmmgtQZ7LeWj1akXjjlUYbPqr43ZhV7gglHiRyKfzW2aYN2RkX2DIMUk3Jd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fqnGM6lY5zKm4c;
	Tue,  7 Apr 2026 21:33:47 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 594A340572;
	Tue,  7 Apr 2026 21:40:03 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 7 Apr 2026 21:39:53 +0800
Message-ID: <f1fb94fe-c86b-7866-d606-088343a56fab@hisilicon.com>
Date: Tue, 7 Apr 2026 21:39:52 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 06/16] RDMA/hns: Fix xarray race in
 hns_roce_create_srq()
To: Jason Gunthorpe <jgg@nvidia.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bernard
 Metzler <bernard.metzler@linux.dev>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, Cheng Xu
	<chengyou@linux.alibaba.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<gal.pressman@linux.dev>, Kai Shen <kaishen@linux.alibaba.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Long Li <longli@microsoft.com>, Michal Kalderon
	<mkalderon@marvell.com>, Michael Margolin <mrgolin@amazon.com>, Nelson
 Escobar <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, Selvin
 Xavier <selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
CC: Adit Ranadive <aditr@vmware.com>, Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>, Dexuan Cui <decui@microsoft.com>, Doug
 Ledford <dledford@redhat.com>, George Zhang <georgezhang@vmware.com>, Jorgen
 Hansen <jhansen@vmware.com>, Leon Romanovsky <leonro@mellanox.com>, Parav
 Pandit <parav.pandit@emulex.com>, <patches@lists.linux.dev>, Roland Dreier
	<roland@purestorage.com>, Roland Dreier <rolandd@cisco.com>, Ajay Sharma
	<sharmaajay@microsoft.com>, <stable@vger.kernel.org>
References: <6-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <6-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10045-lists,linux-hyperv=lfdr.de];
	NEURAL_HAM(-0.00)[-0.970];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,hisilicon.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 423683AF7B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/7 1:40, Jason Gunthorpe wrote:
> Sashiko points out that once the srq memory is stored into the xarray by
> alloc_srqc() it can immediately be looked up by:
> 
> 	xa_lock(&srq_table->xa);
> 	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
> 	if (srq)
> 		refcount_inc(&srq->refcount);
> 	xa_unlock(&srq_table->xa);
> 
> Which will fail refcount debug because the refcount is 0 and then crash:
> 
> 	srq->event(srq, event_type);
> 
> Because event is NULL.

I don't think this will actually happen because HW won't report an SRQ
event before the SRQ is fully ready and actually used.

From the perspective of coding, I'm fine with this change, but since
there is similar logic for QP event, could you also apply this change
to QP?

Junxian

> 
> Use refcount_inc_not_zero() instead to ensure a partially prepared srq is
> never retrieved from the event handler and fix the ordering of the
> initialization so refcount becomes 1 only after it is fully ready.
> 
> Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=3
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_srq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
> index cb848e8e6bbd76..d6201ddde0292a 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_srq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
> @@ -16,8 +16,8 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
>  
>  	xa_lock(&srq_table->xa);
>  	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
> -	if (srq)
> -		refcount_inc(&srq->refcount);
> +	if (srq && !refcount_inc_not_zero(&srq->refcount))
> +		srq = NULL;
>  	xa_unlock(&srq_table->xa);
>  
>  	if (!srq) {
> @@ -481,8 +481,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
>  	}
>  
>  	srq->event = hns_roce_ib_srq_event;
> -	refcount_set(&srq->refcount, 1);
>  	init_completion(&srq->free);
> +	refcount_set(&srq->refcount, 1);
>  
>  	return 0;
>  

