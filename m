Return-Path: <linux-hyperv+bounces-11692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TfG2HGSTPmpeIQkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11692-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 16:57:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E56CE374
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 16:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iDZhI9iC;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11692-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11692-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB22030ABFD6
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F53F7A9F;
	Fri, 26 Jun 2026 14:50:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB030B50F;
	Fri, 26 Jun 2026 14:50:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485456; cv=none; b=hFMzSPaZsA4xciwmSyMjofDwSxJvuAFpOMtH6mK6JGhywZw8p/Yul7isE6quCwRh3m0TpDqFqkf2O20F+a0o9yPp0Ju3G48LfQwJv8b+1yvW05gnxnOP1cwcIC84jh6+bJ2H9QzV8rnNIAj1EUXichMqpl+DgxAXM/M3sedvc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485456; c=relaxed/simple;
	bh=JCLAeQVKI++UFhHCy4DXgU0YkKin5C+cQ3159/WrbEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC4m8m8/GfJ+bRGV34lcKo2DQI5sjaGIN8IQIu0/OBg0u+ERWe2AUjl+YISL1Tvx/XIMo5xYS2xfD+mZCBJ8dd3A+V6yiG551aF1UUdMZrW6Pl2xff4AQagZ2/kERd5FtDs2VcRRFX8lZbf3XHCr0RTfTdsQDCQVt7vmuTWbUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDZhI9iC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B42B1F000E9;
	Fri, 26 Jun 2026 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485454;
	bh=eeYtlt82OtWBDyc4TXqVh3jBy3MFqJIuldO9muaK438=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iDZhI9iCBbeqQkxKvBvis57YrHTKvs+WPaZHMNypJ1Js+vn7DCD5Brk/FbiipFdqK
	 7SefG56wd3bw4RrAuVLdzGnlvdAeAc8VnW6ezs1MYEYVc0LlFBABtO/8Cjx89EfEbU
	 5T2G73ufKK10xkqyZdxVTaSQpmR9O5OmzvhwGKEBYJy2tvTpFmiPxSRvE79IWMUaUT
	 vkKpn0gog6prHrw9BS2SxCAD+wyEZ5E7XdL/0p4WZA3ugAbJ9Qlo/iE46KF+3eSE6j
	 UHYI4A5fG24BkooovUKmWyrqUiA7qxUFeN54SbrG5j4Jpv3lri8mVmLJN0Uli43a7m
	 OupEt1viH6pnw==
Date: Fri, 26 Jun 2026 15:50:48 +0100
From: Simon Horman <horms@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kotaranov@microsoft.com, ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, kees@kernel.org,
	jacob.e.keller@intel.com, ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: mana: Sync page pool RX frags for CPU
Message-ID: <20260626145048.GB1310988@horms.kernel.org>
References: <20260624222605.1794719-1-decui@microsoft.com>
 <20260624222605.1794719-2-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624222605.1794719-2-decui@microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11692-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 177E56CE374

On Wed, Jun 24, 2026 at 03:26:04PM -0700, Dexuan Cui wrote:
> MANA allocates RX buffers from page pool fragments when frag_count is
> greater than 1. In that case the buffers remain DMA mapped by page pool
> and the RX completion path does not call dma_unmap_single(). As a result,
> the implicit sync-for-CPU normally performed by dma_unmap_single() is
> missing before the packet data is passed to the networking stack.
> 
> This breaks RX on configurations which require explicit DMA syncing, for
> example when booted with swiotlb=force.
> 
> Fix this by recording the page pool page and DMA sync offset when the RX
> buffer is allocated, and syncing the received packet range for CPU access
> before handing the RX buffer to the stack.
> 
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes since v1:
>     v1 is split into two patches in the v2.
>     Add Haiyang's Reviewed-by.
> 
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 39 +++++++++++++++----
>  include/net/mana/mana.h                       |  8 ++++
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index c9b1df1ed109..1875bffd82b7 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2044,12 +2044,16 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
>  }
>  
>  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool *from_pool)
> +			     dma_addr_t *da, bool *from_pool,
> +			     struct page **pp_page, u32 *dma_sync_offset)
>  {
>  	struct page *page;
>  	u32 offset;
>  	void *va;
> +
>  	*from_pool = false;
> +	*pp_page = NULL;
> +	*dma_sync_offset = 0;
>  
>  	/* Don't use fragments for jumbo frames or XDP where it's 1 fragment
>  	 * per page.
> @@ -2087,31 +2091,47 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>  	va  = page_to_virt(page) + offset;
>  	*da = page_pool_get_dma_addr(page) + offset + rxq->headroom;
>  	*from_pool = true;
> +	*pp_page = page;
> +	*dma_sync_offset = offset + rxq->headroom;
>  
>  	return va;
>  }
>  
>  /* Allocate frag for rx buffer, and save the old buf */
>  static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
> -			       struct mana_recv_buf_oob *rxoob, void **old_buf,
> -			       bool *old_fp)
> +			       struct mana_recv_buf_oob *rxoob, u32 pktlen,
> +			       void **old_buf, bool *old_fp)
>  {
> +	struct page *pp_page;
> +	u32 dma_sync_offset;
>  	bool from_pool;
>  	dma_addr_t da;
>  	void *va;
>  
> -	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
> +	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, &pp_page,
> +			     &dma_sync_offset);
>  	if (!va)
>  		return;
> -	if (!rxoob->from_pool || rxq->frag_count == 1)
> +	if (!rxoob->from_pool || rxq->frag_count == 1) {
>  		dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
>  				 DMA_FROM_DEVICE);
> +	} else {
> +		/* The page pool maps the whole page and only syncs for device
> +		 * automatically (PP_FLAG_DMA_SYNC_DEV). Sync the received bytes
> +		 * for the CPU before they are read: this is required if DMA
> +		 * is incoherent or bounce buffers are used.
> +		 */
> +		page_pool_dma_sync_for_cpu(rxq->page_pool, rxoob->pp_page,
> +					   rxoob->dma_sync_offset, pktlen);
> +	}

Hi,

I'm sorry to be bothersome but I think that the order of the two patches
that comprise this series should be reversed. Or if that is not possible,
go back to a single patch.

Because, as flagged by https://netdev-ai.bots.linux.dev/sashiko/

  Is pktlen here bounded before it reaches page_pool_dma_sync_for_cpu()?
  The value originates from oob->ppi[i].pkt_len in mana_process_rx_cqe()
  and is forwarded straight into this call with no comparison against
  rxq->datasize or (rxq->alloc_size - rxoob->dma_sync_offset).

  When SWIOTLB is in use (the swiotlb=force case explicitly called out in
  the commit message), page_pool_dma_sync_for_cpu() reaches
  dma_sync_single_range_for_cpu() and copies dma_sync_size bytes from the
  bounce buffer back into the original page.

  Since alloc_size can be smaller than PAGE_SIZE and multiple fragments
  share a single page_pool page, can a pktlen larger than the fragment
  extent here cause the copy-back to spill past this fragment into
  neighbouring fragments that belong to other rxoobs still in flight?

  If so, those neighbours may already have been or may shortly be passed
  up via napi_gro_receive() in mana_rx_skb(), so the over-sync would
  silently overwrite their payloads before the eventual skb_put() in
  mana_build_skb() trips skb_over_panic() on this oversized packet.

  Would it make sense to validate pktlen against rxq->datasize before
  calling mana_refill_rx_oob()?  The follow-up patch in this series,
  "net: mana: Validate the packet length reported by the NIC" (commit
  6c707fe658d6), adds exactly that check:
      if (unlikely(pktlen > rxq->datasize))
          ...
  Could that validation be folded into this patch so that the sync-for-CPU
  introduced here cannot be steered with an attacker-controlled length,
  particularly given that the motivating scenario (swiotlb=force) is the
  Confidential VM case where the hypervisor-supplied CQE is untrusted?

