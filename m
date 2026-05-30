Return-Path: <linux-hyperv+bounces-11388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPC4IDI0Gmp+2AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11388-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD4860A681
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 02:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D6793007AE8
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625323C50A;
	Sat, 30 May 2026 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2x7HiMu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B62652A2
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101870; cv=none; b=sMGiMgAXJrN/CQMyMYP20qpaHJymJfF8fSL4+MKZItUWjCGBf6bskppVed80WKZmqDD7ADfMNPpjUrl8u0UVo+38YKoAaWWxFMk9VJy8NiHsN6Lml57pa78VUc5E0g7FLHKcd0YaS0KbaM6IOlltXTJZFmEgBEH7F6Sb8yLdcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101870; c=relaxed/simple;
	bh=K1O2ppjBayizjgxsI743ob7fQnUyoh2PnvWlMWPVl6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDI41EX5zPpStVEpWtZkCI0sUXeHrF0ukHD1VQnXBU7RxVXwWnlxV6MIi0AsMheJDdU8QTB7j3hP5FyrGw/MWpm4eiFIElRCwkZrfcrBcSDx+jL3N6vShDCbFecJ3w8L+lSxlpIU3eLAD0JmInj5rFc9CLrF+3x1jE6JfT+pyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2x7HiMu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0ECB1F00893;
	Sat, 30 May 2026 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101868;
	bh=1uC2JHvW+u1lafIUY9BIx0S0Prvwb7A//0yawjVDYXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2x7HiMuz6tYauN9pwi8v/5aY917QkMLi4bTewsQcqOcFQtXobWIOE+45yx+CjDiZ
	 56vuGztPGB7Pa54Tp3tCi+lomNziDX2An9WsVrSqCHzPnAWkJ2Q5B8aeAKVlM/FyGC
	 oqBSYKyH7KeZ3aQH7/4DOo4eXk2QPOZaZ907r2+9b9tT0t0yiaXZw3laNhNOnilWLY
	 K2m1YCE9fZd4DAp3/rIom+zRxa5TT6+uxIBYgGM8m5q9uApcOCLxWGWcEVFfD2MLNe
	 DdT1cURITclLV/1785QCcStjhF7M3/0s0duARZ3ykq2l06pfC1bnpIUQ1IiYnivKO6
	 TVAl3zosx44fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: validate rx_req_idx to prevent
 out-of-bounds array access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
References: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:28 +0000
Message-Id: <20260530004428.A0ECB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11388-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: EFD4860A681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Missing `READ_ONCE()` for `sge->address` risks Time-of-Check to Ti=
me-of-Use (TOCTOU) bypass of the newly added bounds check.

Pre-existing issues:
- [High] Missing bounds check on `dma_oob->inline_oob_size_div4` allows an =
out-of-bounds memory read past the DMA WQE ring buffer.
- [High] Returning early without reposting the RX WQE buffer leads to RX qu=
eue starvation.
--

commit 4f8436d78a8ca78fb96f7252f756af92fc42ccaa
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: validate rx_req_idx to prevent out-of-bounds array access

This commit adds a bounds check on rx_req_idx in mana_hwc_rx_event_handler()
to prevent an out-of-bounds access into the reqs[] array. The index is
derived from unencrypted DMA-coherent memory which can be modified by the
hardware at any time in Confidential VMs.

> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/n=
et/ethernet/microsoft/mana/hw_channel.c
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -258,11 +258,17 @@ static void mana_hwc_rx_event_handler(void *ctx, u3=
2 gdma_rxq_id,
>  	wqe =3D mana_gd_get_wqe_ptr(rq, rx_oob->wqe_offset / GDMA_WQE_BU_SIZE);
>  	dma_oob =3D (struct gdma_wqe *)wqe;
> =20
>  	sge =3D (struct gdma_sge *)(wqe + 8 + dma_oob->inline_oob_size_div4 * 4=
);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing bounds
check on dma_oob->inline_oob_size_div4?

Since dma_oob->inline_oob_size_div4 is read directly from unencrypted, shar=
ed
DMA memory, a potentially malicious host could manipulate it. It is a 3-bit
field, so an attacker could set it to 7.

Could this cause the sge pointer calculation to point 36 bytes into the
32-byte WQE buffer, resulting in an out-of-bounds read of up to 12 bytes
when reading sge->address?

If the WQE is at the end of the page-aligned queue memory buffer, could this
read past the allocated DMA region and trigger a fatal page fault?

> =20
>  	/* Select the RX work request for virtual address and for reposting. */
>  	rq_base_addr =3D hwc_rxq->msg_buf->mem_info.dma_handle;
>  	rx_req_idx =3D (sge->address - rq_base_addr) / hwc->max_req_msg_size;

[Severity: High]
Does sge->address need to be read using READ_ONCE()?

Since sge->address resides in unencrypted, shared DMA memory, the compiler
might fetch its value multiple times. If the division by hwc->max_req_msg_s=
ize
is optimized into a bitwise shift, the compiler might re-read sge->address
from DMA memory after the bounds check has passed when indexing the array.

Could a malicious host concurrently modify the memory to bypass the new bou=
nds
check completely?

> =20
> +	if (rx_req_idx >=3D hwc_rxq->msg_buf->num_reqs) {
> +		dev_err(hwc->dev, "HWC RX: wrong rx_req_idx=3D%llu, num_reqs=3D%u\n",
> +			rx_req_idx, hwc_rxq->msg_buf->num_reqs);
> +		return;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does returning early here (and further
below for invalid msg_id) drop the request without reposting the RX WQE
buffer?

If a malicious host repeatedly sends valid CQEs with an invalid msg_id or
an out-of-bounds rx_req_idx, it seems the function drops the response witho=
ut
replenishing the queue via mana_hwc_post_rx_wqe().

Could this permanently leak the RX WQE buffers and starve the queue, causing
a denial of service for the hardware channel?

>  	rx_req =3D &hwc_rxq->msg_buf->reqs[rx_req_idx];
>  	resp =3D (struct gdma_resp_hdr *)rx_req->buf_va;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520051553.8571=
20-1-gargaditya@linux.microsoft.com?part=3D1

