Return-Path: <linux-hyperv+bounces-9167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDtLFUP9qmkIZQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9167-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 17:13:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9309224A09
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 17:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18E8D3022051
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4653E8C6C;
	Fri,  6 Mar 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2C9zwea"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813936C0B2;
	Fri,  6 Mar 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813319; cv=none; b=TX8j1uuzedwBCZSClqFhG7aZegA7msYTct2Fa58awsuMB1BmdZszJMILfgFHunRDIAitUk1f9x4MPwq7RgDvSGX3XE8GFSJqxE2A6IZgJcDFjemgeSi8aOwDpYWpptYsjl1fO1ARpP/fZav7RIjRp0up9mMgbgk9tgb4/K3C8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813319; c=relaxed/simple;
	bh=+sjkWFv/7ZW6Z3LHH2S7c+ePzZw61xuomCUGyBIfLLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA7XBiEImo8j33i68hY35cpfYaGGT65FOxtznxDpAO/rY1AyTFBxPCA2oOUTcSpQK/BRAySwD7i9yrigquIHfx7laGai3Z2QLmR9GHywrpMurAVxyg+UoM0wADoo9VWzeyQxempPIG1bzuY7auefNwNmkOWzKVL9fZ1vReE6WlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2C9zwea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAC9C4CEF7;
	Fri,  6 Mar 2026 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772813319;
	bh=+sjkWFv/7ZW6Z3LHH2S7c+ePzZw61xuomCUGyBIfLLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2C9zweavdafykxSZ2UFUKNQzatfkiZ9RBWyXoISDIu43sPdK/Bu105r0ZFSw2O8p
	 lg8NDHt239fmFlB3N6XmR26ihibWD7GrzXZQqItVgtCvCXyG0e4VRbiZJpJiZxrG64
	 wCb2PjnTZrqnU5fhdcJ26/k1LltnWEk6kWRiq2h0bdPAd41BS9eGgPRRB7ODTScGH+
	 59Ziv9aVBvZFAhv0VU6ps0qcDS0FYljmctSaZAE1S6M11ZgxmSdLVHlYdnz5IJS8Uy
	 /6ZwE168X6+6RwICoagnlzPE+lA/YqNlcYh7dPltw3Ovl08dp/r08+ukOcIJim6hHg
	 adpvWW+oB8cNQ==
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	haiyangz@microsoft.com,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kuba@kernel.org,
	wei.liu@kernel.org,
	shradhagupta@linux.microsoft.com,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	schakrabarti@linux.microsoft.com,
	erick.archer@outlook.com,
	linux-kernel@vger.kernel.org,
	kys@microsoft.com,
	decui@microsoft.com,
	netdev@vger.kernel.org
Subject: Re: [v2,net-next,1/6] net: mana: Create separate EQs for each vPort
Date: Fri,  6 Mar 2026 16:08:20 +0000
Message-ID: <20260306160820.525640-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304000017.333312-2-longli@microsoft.com>
References: <20260304000017.333312-2-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9309224A09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,microsoft.com,vger.kernel.org,linux.microsoft.com,redhat.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9167-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Create separate EQs for each vPort

To prepare for assigning vPorts to dedicated MSI-X vectors, this commit
removes EQ sharing among vPorts and creates dedicated EQs for each vPort.
The EQ definition is moved from struct mana_context to struct
mana_port_context and related support functions are updated.

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h

[ ... ]

> @@ -499,6 +497,9 @@ struct mana_port_context {
>
>  	u8 mac_addr[ETH_ALEN];
>
> +	struct mana_eq *eqs;
> +	struct dentry *mana_eqs_debugfs;
> +
>  	enum TRI_STATE rss_state;
>
>  	mana_handle_t default_rxobj;

[ ... ]

> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -188,7 +188,7 @@ struct mana_obj_spec cq_spec = {};
>  		cq_spec.gdma_region = cq->queue.gdma_region;
>  		cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
>  		cq_spec.modr_ctx_id = 0;
> -		eq = &mpc->ac->eqs[cq->comp_vector];
> +		eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
                           ^^^^^^^
>  		cq_spec.attached_eq = eq->eq->id;

Can mpc->eqs be NULL here? Looking at the initialization paths:

Before this patch, mpc->ac->eqs was allocated during mana_probe() and was
always non-NULL after driver initialization.

After this patch, mpc->eqs is only allocated in two places:
1. mana_alloc_queues() - called when the Ethernet interface is brought up
2. mana_ib_cfg_vport() - called when RDMA RAW QPs configure the vport

However, mana_ib_create_qp_rss() doesn't call mana_ib_cfg_vport(). If an
RSS QP is created via RDMA verbs before the Ethernet port is brought up
and before any RAW QP has configured the vport, mpc->eqs would still be
NULL.

Computing &mpc->eqs[cq->comp_vector % mpc->num_queues] from a NULL pointer
produces an invalid address, and the subsequent dereference eq->eq->id
would crash the kernel.

Should there be a NULL check here, or should mana_ib_create_qp_rss()
ensure EQs are created before reaching this point?

>
>  		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,

[ ... ]

