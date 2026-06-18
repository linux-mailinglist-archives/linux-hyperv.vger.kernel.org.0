Return-Path: <linux-hyperv+bounces-11635-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lBqiDlV0M2rUBwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11635-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:30:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BC069D7F0
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:30:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QHenq/SK";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11635-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11635-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4735E300462D
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E42D94AB;
	Thu, 18 Jun 2026 04:30:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8F25B0A5
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Jun 2026 04:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757010; cv=none; b=SnFILdOSKqabu+fEsYAlu/hmut/DU8gmp6uVaBffX+CCNfEYFGNr0l7URz6EI/eoD4A86sz1nBOCLT36gypGdbh4y4UKkvwbc+FK3AOCCPxWfC1Bpp10EACTXBERaLP5oVLLWWhNhkXzzuYAw0F0ho8PsiNluaSzldqDUw7UuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757010; c=relaxed/simple;
	bh=6lBJqzvuRANyz4757XRC+oYUrxqZEZBliI6EFAgcH1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HkskAO2zy859QTHLBNR2TqhPJDU8krW9d+eNE+q+UPwdk3D/WIEL1c//NqNZzY7HLYAmvX+CRF8e+iX26qaZxIYZChL8AxDBNkN8g7JL92+Zvn636ge/BMbJxqpcrLdU4vWTxcq9Esa2P/dIA+6zuw9jrAXjNGYpyZ8Y2GJN+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHenq/SK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05631F000E9;
	Thu, 18 Jun 2026 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781757007;
	bh=mRJRjGuzS6kvLyoWLcdvFdOH94t17SeKS3QxbgdV8Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHenq/SK94tjj2cTfKF3g2lV6MOdVQaZ/chwVVdvAZF5wrTdHggM8hoB5RAgUwGa4
	 ME3cCAQFWfS+scBC7QrkOfJlOGnbeXVqcLYKiPZkgyovpLA5x9LXAD/VeEBhyz23Af
	 Bevf5bEQoBTCGF2sZrhas+opv+mr8Fn39t89k6WIaeV5vyDormwBjy5aLQMEPnuGgw
	 VNsdyIw7SxgtZMkgOvQqNelqRI6QTYWjsllpof7h6rZa06FvJ/0VgPuQNi6PGvWzYl
	 cTfOZw05ukInvu1xHPhOotKJF+PeK8ZdS653LxjmQ3t8UHLrYQpXLxueU27niH5xcK
	 ULecmsRvadpCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] RDMA/erdma: initialize ret for empty receive WR
 lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260618041752.481193-1-ruoyuw560@gmail.com>
References: <20260618041752.481193-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 04:30:07 +0000
Message-Id: <20260618043007.C05631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11635-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80BC069D7F0

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The receive work request queue (RQ) can silently overflow because =
`erdma_post_recv` and `erdma_post_recv_one` lack a bounds check against the=
 queue capacity, and `rq_ci` is not properly tracked during completion poll=
ing.
- [High] In `erdma_post_send`, when the send queue is full, `*bad_send_wr` =
is incorrectly assigned the head of the list (`send_wr`) instead of the fai=
ling work request (`wr`).
- [High] Missing `dma_wmb()` before updating the doorbell records (`sq_dbre=
c` and `rq_dbrec`) in host memory.
--

commit 7fd711bd13dff4553304f89e7b55436f427b3b9d
Author: Ruoyu Wang <ruoyuw560@gmail.com>

RDMA/erdma: initialize ret for empty receive WR lists

erdma_post_recv() returns ret after walking the receive work request list.
If the caller passes an empty list, the loop is skipped and ret is not
assigned. Initialize ret to 0 so an empty receive work request list returns
success instead of stack data.

> diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/=
hw/erdma/erdma_qp.c
> index 25f6c49aec779..e002343832f74 100644
> --- a/drivers/infiniband/hw/erdma/erdma_qp.c
> +++ b/drivers/infiniband/hw/erdma/erdma_qp.c
> @@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct =
ib_recv_wr *recv_wr,
>  	const struct ib_recv_wr *wr =3D recv_wr;
>  	struct erdma_qp *qp =3D to_eqp(ibqp);
>  	unsigned long flags;
> -	int ret;
> +	int ret =3D 0;
> =20
>  	spin_lock_irqsave(&qp->lock, flags);
> =20

[Severity: High]
This is a pre-existing issue, but does the receive work request queue (RQ)
have a risk of silent overflow?

While erdma_post_send() tracks send queue capacity, erdma_post_recv()
unconditionally posts receive work requests and advances rq_pi without a
bounds check against the queue capacity:

drivers/infiniband/hw/erdma/erdma_qp.c:erdma_post_recv() {
    ...
	while (wr) {
		ret =3D erdma_post_recv_one(qp, wr);
    ...
}

drivers/infiniband/hw/erdma/erdma_qp.c:erdma_post_recv_one() {
    ...
	qp->kern_qp.rq_pi++;
    ...
}

Additionally, receive queue completions don't seem to update kern_qp->rq_ci:

drivers/infiniband/hw/erdma/erdma_cq.c:erdma_poll_one_cqe() {
    ...
	} else {
		id_table =3D kern_qp->rwr_tbl;
		depth =3D qp->attrs.rq_size;
	}
    ...
}

If a kernel consumer posts more receives than the queue capacity, could the
ring buffer wrap around and overwrite active, unpolled work requests, leadi=
ng
to data corruption and invalid WR IDs during polling?

[Severity: High]
This is a pre-existing issue, but is the failing work request assigned
correctly when the send queue is full?

In erdma_post_send(), if the queue becomes full after some work requests ha=
ve
already been successfully posted, *bad_send_wr is assigned the head of the
list instead of the failing request:

drivers/infiniband/hw/erdma/erdma_qp.c:erdma_post_send() {
    ...
		if ((u16)(sq_pi - qp->kern_qp.sq_ci) >=3D qp->attrs.sq_size) {
			ret =3D -ENOMEM;
			*bad_send_wr =3D send_wr;
			break;
		}
    ...
}

Does this signal to the caller that the entire batch failed from the start,
prompting a retry of the entire list and potentially leading to duplicate
execution?

[Severity: High]
This is a pre-existing issue, but should there be a memory barrier before
updating the doorbell records in host memory?

The driver updates doorbell records after constructing work queue elements
(WQEs/RQEs):

drivers/infiniband/hw/erdma/erdma_qp.c:erdma_post_recv_one() {
    ...
	*(u64 *)qp->kern_qp.rq_dbrec =3D *(u64 *)rqe;
    ...
}

drivers/infiniband/hw/erdma/erdma_qp.c:kick_sq_db() {
    ...
	*(u64 *)qp->kern_qp.sq_dbrec =3D db_data;
    ...
}

While the subsequent hardware doorbell ring via writeq() includes a barrier
before the MMIO operation, could the CPU reorder the memory stores of the W=
QE
with the memory store of the dbrec?

If the device polls the updated dbrec before the WQE stores are visible,
might it fetch a stale or partially written WQE via DMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618041752.4811=
93-1-ruoyuw560@gmail.com?part=3D1

