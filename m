Return-Path: <linux-hyperv+bounces-10966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAumHOZ3B2pL4QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10966-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:45:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A61557127
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A17301A938
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE12D0C79;
	Fri, 15 May 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwvWrfSm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53A355055
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874267; cv=none; b=MO46euPw74u8dNbM3pbeLvWMWzywMUEcVPVbJq2d6TxS9JaS1lb5l7SGMgWo/raK50PLji/+MoSR9od602o9T+6WGwGv1GsgyUY0jNFv4ay6OWecqThPhUsi/gRy3Bhd33XvGm71znJoJEKyFhdCdi8eP+P/n18BAhMgfr5N1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874267; c=relaxed/simple;
	bh=HJja8goAA60XEE6Z6I3gJ8EyzwqQwVBmF1aRGmPXtyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ihZd8cR9reeNUtdfxnhQsIZ/zJVhpy/W/J0cnLa4pNgvwbW0EUKJT8VaPd6K3y34BDNy774picuWOhPO+y695/DoTjuDdiWJgKQN7Zf47CBHxdqIa5RIgS9/fppK09yACwWx2PBPrHM86BPHdht8k5jeCrh3f3CnDk6DAjmXKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwvWrfSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CACC2BCB0;
	Fri, 15 May 2026 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874267;
	bh=HJja8goAA60XEE6Z6I3gJ8EyzwqQwVBmF1aRGmPXtyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MwvWrfSm+RegqfVaZMeNm5vUNhnP/SyJ0MBfnU1AbuzParAMQiiZKDmKsMCFIsW0w
	 T7Ur5nYlCf51vRS6UXY3cPsu0zTlodPxvcPJezSvS3rVxR9Pk+iedBkGq2djlXrWkB
	 4q4avciMQYjOuEUb0wesQx9LdhIaPnPBzju9V4is767P1m030iEydBVp477VfzX+GN
	 VLLodyou5KUWfSkl/Xb4+c1Q919tz7WpvRZyKo4AgIlLv91/GF5jMK7UUy9bqeOL1u
	 2Nopnj3gPTNXrbm210EcCG9nmhtpO4kLc3tS4f3Na251Lgvu0WJxEyf78Wr2wgeH/K
	 hNemQPeXtTYEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id
 from DMA buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Erni Sri Satya Vennela" <ernis@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260514194156.466823-1-ernis@linux.microsoft.com>
References: <20260514194156.466823-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:44:26 +0000
Message-Id: <20260515194427.52CACC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C1A61557127
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10966-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unvalidated array index `rx_req_idx` derived from untrusted DM=
A memory allows arbitrary out-of-bounds memory access.
--

commit b79489b09c3449da038fde04cce5dc4d6a1fe538
Author: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

This commit fixes a TOCTOU vulnerability in mana_hwc_rx_event_handler() whe=
re
the hwc_msg_id is read twice from DMA-coherent memory. It reads the msg_id =
once
using READ_ONCE() and passes it to mana_hwc_handle_resp() to prevent a mali=
cious
host in a Confidential VM from bypassing bounds checks.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> index dbbde0fa57e71..fd8b324d7fb68 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c

[ ... ]

> @@ -269,13 +268,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
>  	rx_req =3D &hwc_rxq->msg_buf->reqs[rx_req_idx];

Since this patch addresses host-controlled DMA memory vulnerabilities in
Confidential VMs, could there be another out-of-bounds access just before
the msg_id check?

Looking at how rx_req_idx is calculated earlier in this function:

	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4);
	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;

Because sge->address is read directly from the untrusted DMA queue, a malic=
ious
host could provide an arbitrary value, resulting in an out-of-bounds
rx_req_idx.

Using this unvalidated index to access hwc_rxq->msg_buf->reqs[rx_req_idx]
yields an attacker-controlled rx_req pointer. When this corrupted rx_req is
subsequently passed to mana_hwc_post_rx_wqe(), the driver writes to req->sge
and req->wqe_req, which could allow arbitrary writes to guest kernel memory.

Should rx_req_idx be bounds-checked against the size of the reqs array
before it is used to index the array?

>  	resp =3D (struct gdma_resp_hdr *)rx_req->buf_va;
> =20
> -	if (resp->response.hwc_msg_id >=3D hwc->num_inflight_msg) {
> -		dev_err(hwc->dev, "HWC RX: wrong msg_id=3D%u\n",
> -			resp->response.hwc_msg_id);
> +	/* Read msg_id once from DMA buffer to prevent TOCTOU:
> +	 * DMA memory is shared/unencrypted in CVMs - host can
> +	 * modify it between reads.
> +	 */
> +	msg_id =3D READ_ONCE(resp->response.hwc_msg_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514194156.4668=
23-1-ernis@linux.microsoft.com?part=3D1

