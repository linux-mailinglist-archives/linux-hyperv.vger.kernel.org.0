Return-Path: <linux-hyperv+bounces-10458-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNolGDO68Wl1kAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10458-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:58:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4331490DA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9643015715
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43321395259;
	Wed, 29 Apr 2026 07:56:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8E32D0FC;
	Wed, 29 Apr 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449369; cv=none; b=I8myRsMzo4QfYXedYpBEiTRzcwUoLZIOJ356XVxeReJ8pm7JLRTZ72MZubtnzQ53MPPb0y9r0+ibylbys4Kuv8GMzu64c/WhoKoEb2DxnTHNKXD4lCg9dD0I/uKMEwdYMC1mrz8GUknovaA3+dZqFzXiN5N7REzDky3o0JhFns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449369; c=relaxed/simple;
	bh=Kkv97VMnztmelRWbOIZlO1gcT+e2sRBJ+LEZugPERUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uizi9+mDmTs8RRrTL0BjTHPW/pmoa+Wu6ZUtTzZA8X9/K+FXMoGC/bk7Pzc78Hc/nLw0c6z01zYUzDY/TSaG8PfETNF0WSGCiUn4wOnjYsO/chqGFa+aqwEvvIOO+6Qiq4AsTdaf+b+wWhf/vbAaHTgP1hLPu5o02ZoohxnZc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g58b35J6Rz1T4G8;
	Wed, 29 Apr 2026 15:49:35 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 091A320226;
	Wed, 29 Apr 2026 15:55:56 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Apr 2026 15:55:47 +0800
Message-ID: <ff248023-a367-3561-1c04-77da1b1f3794@hisilicon.com>
Date: Wed, 29 Apr 2026 15:55:45 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rc 00/15] Various bug fixes for RDMA drivers in the uapi
 functions
To: Jason Gunthorpe <jgg@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>, Eric Dumazet <edumazet@google.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, Jakub Kicinski
	<kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Chengchang Tang <tangchengchang@huawei.com>,
	Tariq Toukan <tariqt@nvidia.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
CC: Abhijit Gangurde <abhijit.gangurde@amd.com>, Adit Ranadive
	<aditr@vmware.com>, Allen Hubbe <allen.hubbe@amd.com>, Andrew Boyer
	<andrew.boyer@amd.com>, Aditya Sarwade <asarwade@vmware.com>, Brad Spengler
	<brad.spengler@opensrcsec.com>, Bryan Tan <bryantan@vmware.com>, "David S.
 Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Doug Ledford
	<dledford@redhat.com>, George Zhang <georgezhang@vmware.com>, Jorgen Hansen
	<jhansen@vmware.com>, Jianbo Liu <jianbol@nvidia.com>, Kai Aizen
	<kai.aizen.dev@gmail.com>, Leon Romanovsky <leonro@mellanox.com>, Leon
 Romanovsky <leonro@nvidia.com>, Yixian Liu <liuyixian@huawei.com>, Long Li
	<longli@microsoft.com>, Lijun Ou <oulijun@huawei.com>, Parav Pandit
	<parav.pandit@emulex.com>, <patches@lists.linux.dev>, Roland Dreier
	<roland@purestorage.com>, Roland Dreier <rolandd@cisco.com>, Sagi Grimberg
	<sagi@grimberg.me>, Ajay Sharma <sharmaajay@microsoft.com>,
	<stable@vger.kernel.org>, Tariq Toukan <tariqt@mellanox.com>, "Wei Hu
 (Xavier)" <xavier.huwei@huawei.com>, Shaobo Xu <xushaobo2@huawei.com>,
	Nenglong Zhao <zhaonenglong@hisilicon.com>
References: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Content-Language: en-US
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <0-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100018.china.huawei.com (7.202.181.17)
X-Rspamd-Queue-Id: D4331490DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[hisilicon.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,vmware.com,opensrcsec.com,davemloft.net,microsoft.com,redhat.com,nvidia.com,gmail.com,mellanox.com,huawei.com,emulex.com,lists.linux.dev,purestorage.com,cisco.com,grimberg.me,vger.kernel.org,hisilicon.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10458-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huangjunxian6@hisilicon.com,linux-hyperv@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.194];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hisilicon.com:mid,hisilicon.com:email]



On 2026/4/29 0:17, Jason Gunthorpe wrote:
> All were found by Sashiko or Claude AI tools. They vary in severity, but
> are all things that shouldn't be present.
> 
> Jason Gunthorpe (15):
>   RDMA/hns: Fix xarray race in hns_roce_create_srq()
>   RDMA/hns: Fix xarray race in hns_roce_create_qp_common()
>   RDMA/hns: Fix unlocked call to hns_roce_qp_remove()

For hns patches:
Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>

Thanks,
Junxian

