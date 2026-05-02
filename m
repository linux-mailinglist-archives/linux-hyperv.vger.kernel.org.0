Return-Path: <linux-hyperv+bounces-10577-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JzHpAm4T9mnMSAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10577-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:08:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F74B290C
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C64F7300CE7A
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564FE30B508;
	Sat,  2 May 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN4Qj2CV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1524E4A1;
	Sat,  2 May 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777734507; cv=none; b=tqg7zTmE/rFI2L/Q0Vobfidh7Gn5w32aacDp/qjbK/Jwh0syyzN9pB5nd1SYQi5DmKKLB2ljY/8o8tZt2F7EKoxrJAMh9KoAFUalcoAGxTAqxXTmiA3ZiMMQcSakA2/aXWcVRqzmlIaSZAXiHxgtKrvm8mdyvucCG4D7m6tfHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777734507; c=relaxed/simple;
	bh=3oSRAgR0djIWxvB1OYxe49Q01GZ1ncBAJxoU7/IszgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxXBtoRkdaE+JFRt4vlAmezvYHtGPIF3Yq7MQ0wm9tJLT0WZiIhAS8Vf9a16oBkpN7xhVaIW3H8zlZwU8WD5TT9fzP47RqFTyqDnm5O9kwaEGldn/+AQGouwCgZjMl9sg/0wsMUOJs6qmsqT4MmAskNNJXRNr6/DJ72mmd/x9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN4Qj2CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D0C19425;
	Sat,  2 May 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777734506;
	bh=3oSRAgR0djIWxvB1OYxe49Q01GZ1ncBAJxoU7/IszgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lN4Qj2CVYR8aeq7ziietEj2m0Z0rPaOgsRgdxYfrwAuGyRYrPkkg7ENSXG2+BSl7j
	 cZIpbRLALbCHuGLxZ6xyAu+JlIHF+24cu8b5u5jnsReHXbtdg6w0sVyTUBULAfD1QC
	 6BE8D8xJGV/G/OBPns3nJS27n7gUOP4xWorU2YiITE+YdZ67aUUq8It7f9T9lhkgdZ
	 XeK2hLCAfjGokcx+ftAzRVwHjP7O+J3Z4EAkuzu3zqm78z6mQG3PAac8mOMUWqsNf/
	 UtgkIiVW9MmgMsPhe2xEO6bvH3pHXTq/hIMdOtzh/JbSJ8itAS/wXKMj2StIdqAOZb
	 5dXiFXVqiaRLw==
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: 'Simon Horman' <horms@kernel.org>,
	kotaranov@microsoft.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/6] net: mana: Create separate EQs for each vPort
Date: Sat,  2 May 2026 16:07:16 +0100
Message-ID: <20260502150717.281387-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429221625.1841150-2-longli@microsoft.com>
References: <20260429221625.1841150-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B1F74B290C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10577-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: mana: Create separate EQs for each vPort

This commit modifies the mana driver to prepare for assigning vPorts to
dedicated MSI-X vectors by removing EQ sharing among vPorts. It moves the EQ
definition from the mana_context to the mana_port_context and exports EQ
lifecycle functions for use by the MANA RDMA driver.

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> index 645581359cee..6f1043383e8c 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -168,7 +168,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>  		cq_spec.gdma_region = cq->queue.gdma_region;
>  		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
>  		cq_spec.modr_ctx_id = 0;
> -		eq = &mpc->ac->eqs[cq->comp_vector];
> +		/* EQs are created when a raw QP configures the vport.
> +		 * A raw QP must be created before creating rwq_ind_tbl.
> +		 */
> +		if (!mpc->eqs) {
> +			ret = -EINVAL;
> +			i--;
> +			goto fail;
> +		}
> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];

Is it possible for the EQs to be destroyed while this RSS QP is still actively
using them?

If the EQs are created by the Ethernet interface being brought up, or by
a RAW QP configuring the vport, this RSS QP will attach to them without
incrementing pd->vport_use_count or taking any vport reference count.

If the Ethernet interface is subsequently brought down, or the RAW QP is
destroyed, mana_destroy_eq() will be called, freeing the mpc->eqs array and
destroying the underlying DMA regions while this RSS QP remains active. This
regression could allow the hardware to DMA completion events into freed
EQ memory.

Additionally, since mpc->eqs is accessed here without holding pd->vport_mutex,
could a concurrent teardown of the EQs lead to a use-after-free when reading
eq->eq->id?

>  		cq_spec.attached_eq = eq->eq->id;
>  
>  		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,

