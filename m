Return-Path: <linux-hyperv+bounces-9351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFaFMa6dsmndOAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9351-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:04:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDF27091E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C053C3016EC5
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC044397E9F;
	Thu, 12 Mar 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DcLRGgzN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101E397E95
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Mar 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313452; cv=none; b=eZ2c5Od9pfw8oD9MZsc+o34bB1Vmzs5sETs2IdKhHEhRN8rnVlIJ/ag1yHSCmRTjz5DPl3aeY3JU1/0EoLKKaKwBPhZ6kzLVznIdygF3HjE4nP9mM8xjSZTQ1HGdBDrfauV37K7k3jgBLYiLu9C8NLD8snzWpJVddDAYSoADwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313452; c=relaxed/simple;
	bh=AGpfmJFxK5PxlACbbcHQUKhEk/a6Nj1sbdWpe5HegsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MT/XBH6M5ispO0dXnfiIHHn/JrIxlildQZUfSpT+FydMSJVf303gyGZn0lhrrpYsEq1L0jMbjSSGRlUmUDO/XOvgEkGKNo/cmqVkomKgveqqpDj/+EQVDchBWv129D3tDY2wdZxECBFzrA6YkpKgsFv8jnXTTOwKXANAr+QgNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DcLRGgzN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf3bbf89-0bb1-4c58-b78f-37afdb2ff99c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773313449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGpfmJFxK5PxlACbbcHQUKhEk/a6Nj1sbdWpe5HegsM=;
	b=DcLRGgzNCwq/u8nCkjTe9/TbSD9C145ONZ/euOj4YooX8kbgBJjia/2E3IhRQxP8cPBUzL
	Yz8j4c+BWsRScRHndRPNsE40Blft8si2yV7of93yQWmFCOh7EF4nGIr24lp6yG9zcVEugc
	tN9aVrxvQSY4Pvqm+HbZhqWeGe2HdMk=
Date: Thu, 12 Mar 2026 13:03:59 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 10/16] RDMA/efa: Use ib_copy_validate_udata_in_cm()
To: Jason Gunthorpe <jgg@nvidia.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Bernard Metzler <bernard.metzler@linux.dev>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Cheng Xu
 <chengyou@linux.alibaba.com>, Junxian Huang <huangjunxian6@hisilicon.com>,
 Kai Shen <kaishen@linux.alibaba.com>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
 Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>,
 Satish Kharat <satishkh@cisco.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Yossi Leybovich <sleybo@amazon.com>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: patches@lists.linux.dev
References: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[nvidia.com,amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9351-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal.pressman@linux.dev,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62BDF27091E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 2:24, Jason Gunthorpe wrote:
> Add the missed check for unsupported comp_mask bits.

Is it really missed? IIRC, it's intended.

See the comment above your hunk, and efa_user_comp_handshake()?

