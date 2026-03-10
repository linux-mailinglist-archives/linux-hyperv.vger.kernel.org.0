Return-Path: <linux-hyperv+bounces-9289-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LaaGoxqsGmNjAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9289-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 20:01:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E79256C8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 20:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 097BD3067850
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DD3A900B;
	Tue, 10 Mar 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F2twIcPf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12933E347;
	Tue, 10 Mar 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169242; cv=none; b=ja2nogVxaMdw91UUoGD7OxfuEvq9hGGO7P8Zn1foEukCbknKzj4Eh1WVrkYCzNvGvzYNt7rL3eNtYDQeSOSmBeuzgSCmZf0NOSb5pHQM2cgLWV2/+0nKjbRVibrqRoYJTZBTFX4+Bk+3hd4/3AY99Wn5SLxNE2LVXz/CUxtDuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169242; c=relaxed/simple;
	bh=SBUPDKhfoe92AV8XhVL64XB+MzmOh5ipIZ8UftiHfOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axJ7vM3G9GIMLakg+/wOVjKIrojRBLafdBdXZjSyjDOzhpJTyWUTeZpDoQSYM4+W2MkZXQdFLNeTGKtD1cUG3LtikHyddQhJzFx4oteXC9PqWWxv3auZSjFSIsV6HTIpLQTLJxZ6gsv0pvGrMtoTJyx4te9pCfda8ib+kE6MKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F2twIcPf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 6CC2320B710C; Tue, 10 Mar 2026 12:00:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CC2320B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773169235;
	bh=42q/Uk9o1ey7lZIUSzXosx8JjeQbx/EquCtqcvvex7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2twIcPf1UvS8pAo6PsSoN5H1K69rL6NIBwSwGV+xBZ68bhs+S3idntAfj9FmNEjU
	 faUYgald+VR9BTzb0zplXEyVh42HCByFYKtXtaB72hQWoFleBofqMiqCaUMft0eybK
	 MpGMQ3ZrWC8Gqm7m/B5oxT39LTNOmBMIMppy7Pdw=
Date: Tue, 10 Mar 2026 12:00:35 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: ernis@linux.microsoft.com, decui@microsoft.com,
	shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
	kys@microsoft.com, kuba@kernel.org, longli@microsoft.com,
	kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, edumazet@google.com,
	wei.liu@kernel.org, horms@kernel.org, davem@davemloft.net,
	linux-rdma@vger.kernel.org, ssengar@linux.microsoft.com,
	leon@kernel.org, haiyangz@microsoft.com,
	linux-kernel@vger.kernel.org, dipayanroy@microsoft.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2] net: mana: Force full-page RX buffers for 4K page
 size on specific systems.
Message-ID: <abBqUzO79pYQ3k2Z@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aarXjJ+n2EoX2JvB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260310122127.200675-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310122127.200675-1-pabeni@redhat.com>
X-Rspamd-Queue-Id: D9E79256C8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9289-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 01:21:27PM +0100, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: mana: Force full-page RX buffers for 4K page size on specific systems.
> 
> This commit adds processor-specific optimization for ARM64 systems with
> 4K pages where page_pool fragments cause throughput regression. It
> detects affected processors via SMBIOS and forces one RX buffer per page.
>
yes, I assume no action needed here. 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index aef8612b73cb..05fecc00a90c 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> 
> [ ... ]
> 
> > @@ -1959,6 +1960,128 @@ static bool mana_is_pf(unsigned short dev_id)
> >  	return dev_id == MANA_PF_DEVICE_ID;
> >  }
> >
> > +/*
> > + * Table for Processor Version strings found from SMBIOS Type 4 information,
> > + * for processors that needs to force single RX buffer per page quirk for
> > + * meeting line rate performance with ARM64 + 4K pages.
> > + * Note: These strings are exactly matched with version fetched from SMBIOS.
> > + */
> > +static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
> > +	"Cobalt 200",
> > +};
> > +
> > +/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> > + * trigger a throughput regression. Hence identify those processors
> > + * from the extracted SMBIOS table and apply the quirk to forces one
> > + * RX buffer per page to avoid the fragment allocation/refcounting
> > + * overhead in the RX refill path for those processors only.
> > + */
> > +static bool mana_needs_single_rxbuf_per_page(struct gdma_context *gc)
> > +{
> > +	int i = 0;
> > +	const char *ver = gc->processor_version;
> > +
> > +	if (!ver)
> > +		return false;
> > +
> > +	if (PAGE_SIZE != SZ_4K)
> > +		return false;
> > +
> > +	while (i < ARRAY_SIZE(mana_single_rxbuf_per_page_quirk_tbl)) {
> > +		if (!strcmp(ver, mana_single_rxbuf_per_page_quirk_tbl[i]))
> > +			return true;
> > +		i++;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static void mana_get_proc_ver_strno(const struct dmi_header *hdr, void *data)
> > +{
> > +	struct gdma_context *gc = data;
> > +	const u8 *d = (const u8 *)hdr;
> > +
> > +	/* We are only looking for Type 4: Processor Information */
> > +	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
> > +		return;
> > +
> > +	/* Ensure the record is long enough to contain the Processor Version
> > +	 * field
> > +	 */
> > +	if (hdr->length <= SMBIOS_TYPE4_PROC_VERSION_OFFSET)
> > +		return;
> > +
> > +	/* The 'Processor Version' string is located at index pointed by
> > +	 * SMBIOS_TYPE4_PROC_VERSION_OFFSET.  Make a copy of the index.
> > +	 * There could be multiple Type 4 tables so read and store the
> > +	 * processor version index found the first time.
> > +	 */
> > +	if (gc->proc_ver_strno)
> > +		return;
> > +
> > +	gc->proc_ver_strno = d[SMBIOS_TYPE4_PROC_VERSION_OFFSET];
> > +}
> > +
> > +static const char *mana_dmi_string_nosave(const struct dmi_header *hdr, u8 s)
> > +{
> > +	const char *bp = (const char *)hdr + hdr->length;
> > +
> > +	if (!s)
> > +		return NULL;
> > +
> > +	/* String numbers start at 1 */
> > +	while (--s > 0 && *bp)
> > +		bp += strlen(bp) + 1;
> > +
> > +	if (!*bp)
> > +		return NULL;
> > +
> > +	return bp;
> > +}
> > +
> > +static void mana_fetch_proc_ver_string(const struct dmi_header *hdr,
> > +				       void *data)
> > +{
> > +	struct gdma_context *gc = data;
> > +	const char *ver;
> > +
> > +	/* We are only looking for Type 4: Processor Information */
> > +	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
> > +		return;
> > +
> > +	/* Extract proc version found the first time only */
> > +	if (!gc->proc_ver_strno || gc->processor_version)
> > +		return;
> > +
> > +	ver = mana_dmi_string_nosave(hdr, gc->proc_ver_strno);
> > +	if (ver)
> > +		gc->processor_version = kstrdup(ver, GFP_KERNEL);
> > +}
> > +
> > +/* Check and initialize all processor optimizations/quirks here */
> > +static bool mana_init_processor_optimization(struct gdma_context *gc)
> > +{
> > +	bool opt_initialized = false;
> > +
> > +	gc->proc_ver_strno = 0;
> > +	gc->processor_version = NULL;
> > +
> > +	dmi_walk(mana_get_proc_ver_strno, gc);
> > +	if (!gc->proc_ver_strno)
> > +		return false;
> > +
> > +	dmi_walk(mana_fetch_proc_ver_string, gc);
> > +	if (!gc->processor_version)
> > +		return false;
> > +
> > +	if (mana_needs_single_rxbuf_per_page(gc)) {
> > +		gc->force_full_page_rx_buffer = true;
> > +		opt_initialized = true;
> > +	}
> > +
> > +	return opt_initialized;
> > +}
> > +
> >  static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  {
> >  	struct gdma_context *gc;
> 
> [ ... ]
> 
> > @@ -2013,6 +2136,11 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> >  							  mana_debugfs_root);
> >
> > +	if (mana_init_processor_optimization(gc))
> > +		dev_info(&pdev->dev,
> > +			 "Processor specific optimization initialized on: %s\n",
> > +			gc->processor_version);
> > +
> >  	err = mana_gd_setup(pdev);
> >  	if (err)
> >  		goto unmap_bar;
> 
> [ ... ]
> 
> > @@ -2055,6 +2183,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  	pci_iounmap(pdev, bar0_va);
> >  free_gc:
> >  	pci_set_drvdata(pdev, NULL);
> > +	kfree(gc->processor_version);
> > +	gc->processor_version = NULL;
> >  	vfree(gc);
> >  release_region:
> >  	pci_release_regions(pdev);
> 
> [ ... ]
> 
> > @@ -2110,6 +2240,9 @@ static void mana_gd_remove(struct pci_dev *pdev)
> >
> >  	pci_iounmap(pdev, gc->bar0_va);
> >
> > +	kfree(gc->processor_version);
> > +	gc->processor_version = NULL;
> > +
> >  	vfree(gc);
> >
> >  	pci_release_regions(pdev);
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index ea71de39f996..f17cc2cc7dd9 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> [ ... ]
> 
> > @@ -744,6 +744,26 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
> >  	return va;
> >  }
> >
> > +static bool
> > +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> > +{
> > +	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> > +
> > +	/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> > +	 * trigger a throughput regression. Hence forces one RX buffer per page
> > +	 * to avoid the fragment allocation/refcounting overhead in the RX
> > +	 * refill path for those processors only.
> > +	 */
> > +	if (gc->force_full_page_rx_buffer)
> > +		return true;
> > +
> > +	/* For xdp and jumbo frames make sure only one packet fits per page. */
> > +	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
> >  static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
> >  			       int mtu, u32 *datasize, u32 *alloc_size,
> 
> [ ... ]
> 
> > @@ -754,8 +774,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
> >  	/* Calculate datasize first (consistent across all cases) */
> >  	*datasize = mtu + ETH_HLEN;
> >
> > -	/* For xdp and jumbo frames make sure only one packet fits per page */
> > -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
> > +	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
> >  		if (mana_xdp_get(apc)) {
> >  			*headroom = XDP_PACKET_HEADROOM;
> >  			*alloc_size = PAGE_SIZE;
> 
> [ ... ]
> 
> > diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> > index ec17004b10c0..be56b347f3f6 100644
> > --- a/include/net/mana/gdma.h
> > +++ b/include/net/mana/gdma.h
> 
> [ ... ]
> 
> > @@ -9,6 +9,12 @@
> >
> >  #include "shm_channel.h"
> >
> > +/* SMBIOS Type 4: Processor Information table */
> > +#define SMBIOS_TYPE_4_PROCESSOR_INFO 4
> > +
> > +/* Byte offset containing the Processor Version string number.*/
> > +#define SMBIOS_TYPE4_PROC_VERSION_OFFSET 0x10
> > +
> >  #define GDMA_STATUS_MORE_ENTRIES	0x00000105
> >  #define GDMA_STATUS_CMD_UNSUPPORTED	0xffffffff
> >
> 
> [ ... ]
> 
> > @@ -444,6 +450,9 @@ struct gdma_context {
> >  	struct workqueue_struct *service_wq;
> >
> >  	unsigned long		flags;
> > +	u8			*processor_version;
> > +	u8			proc_ver_strno;
> > +	bool			force_full_page_rx_buffer;
> >  };
> >
> >  static inline bool mana_gd_is_mana(struct gdma_dev *gd)
> 
> Should processor_version be declared as char * instead of u8 *?
> 
> The field is used as a string throughout the code: it's assigned from
> kstrdup() in mana_fetch_proc_ver_string(), read as const char *ver
> in mana_needs_single_rxbuf_per_page(), passed to strcmp(), and printed
> with %s format in dev_info().
> 
> Using u8 * for string data can trigger compiler warnings with
> -Wpointer-sign, since string functions expect char * types.
> 
Ack, I will send a v3 addressing this.


Thanks Paolo,
For the review comments I will address this warning in a v3.

Regards
Dipayaan Roy

