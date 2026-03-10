Return-Path: <linux-hyperv+bounces-9267-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MjxGa4isGkkgQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9267-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 14:54:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6549B250FE1
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 150F330FEE66
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Mar 2026 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A883BD244;
	Tue, 10 Mar 2026 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy51/10i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C73C0629
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Mar 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145306; cv=none; b=jxrpSaulhB1Hv1QcxNT540UZqaK9iUDpqH6XTO37B0JHbIfMtH+Rolnsnc5Qm0rfFGDcksyTAkVjvLhoVowSAA0BJMffmj/MWsLq/tBQBwpLUGcURfmBW919eqvfRkYR3ljcr40H0fkJIFmGmwwnDg9WLpOv70ux9MKVKKaSGCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145306; c=relaxed/simple;
	bh=an9adZHQvM7cqpkUyWxiNhIKJh3mohUEa/nINU0P6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBpsnszsyttkbnNHAcJ+CoHeqHzWnBbDvNR0H3LJ0vJl572jQumhRT1kffr+PPVe9npM2i86Hed2C4VXboOhqRcUCzz+hpLIbkTO8QP9kJUtT3GlO/n6wDzwehYLtu3gFLCPdZ+DFdjZH/m8HGzrP/JYcgA1we54sD7ClzoUUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oy51/10i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773145303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDfq77R22sq1ejgAyTb445PzrQTFDDUJmCUs/6D4c1E=;
	b=Oy51/10ipXKNmJTBmO6jS9MuLUIgpJ6RUxJ0z/SjSngAtuVHNSNV/oFQWha5kPukRiHyiX
	8fwtEdYmPghx21nF+wqBm0gd+yy/aOsC3lnSAINlUWigO0HTbSPxdI2c8jP1BetlLmfkmF
	lc7bjdUz4II7vBB9w5HG5rhDVMlypbc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-ebwdEchyMvCNphjQnpk2TQ-1; Tue,
 10 Mar 2026 08:21:40 -0400
X-MC-Unique: ebwdEchyMvCNphjQnpk2TQ-1
X-Mimecast-MFC-AGG-ID: ebwdEchyMvCNphjQnpk2TQ_1773145297
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A89218002E3;
	Tue, 10 Mar 2026 12:21:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90784180035F;
	Tue, 10 Mar 2026 12:21:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: dipayanroy@linux.microsoft.com
Cc: ernis@linux.microsoft.com,
	decui@microsoft.com,
	shradhagupta@linux.microsoft.com,
	andrew+netdev@lunn.ch,
	kys@microsoft.com,
	kuba@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	edumazet@google.com,
	wei.liu@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	linux-rdma@vger.kernel.org,
	ssengar@linux.microsoft.com,
	pabeni@redhat.com,
	leon@kernel.org,
	haiyangz@microsoft.com,
	linux-kernel@vger.kernel.org,
	dipayanroy@microsoft.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v2] net: mana: Force full-page RX buffers for 4K page size on specific systems.
Date: Tue, 10 Mar 2026 13:21:27 +0100
Message-ID: <20260310122127.200675-1-pabeni@redhat.com>
In-Reply-To: <aarXjJ+n2EoX2JvB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aarXjJ+n2EoX2JvB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 6549B250FE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9267-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Force full-page RX buffers for 4K page size on specific systems.

This commit adds processor-specific optimization for ARM64 systems with
4K pages where page_pool fragments cause throughput regression. It
detects affected processors via SMBIOS and forces one RX buffer per page.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index aef8612b73cb..05fecc00a90c 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c

[ ... ]

> @@ -1959,6 +1960,128 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>
> +/*
> + * Table for Processor Version strings found from SMBIOS Type 4 information,
> + * for processors that needs to force single RX buffer per page quirk for
> + * meeting line rate performance with ARM64 + 4K pages.
> + * Note: These strings are exactly matched with version fetched from SMBIOS.
> + */
> +static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
> +	"Cobalt 200",
> +};
> +
> +/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> + * trigger a throughput regression. Hence identify those processors
> + * from the extracted SMBIOS table and apply the quirk to forces one
> + * RX buffer per page to avoid the fragment allocation/refcounting
> + * overhead in the RX refill path for those processors only.
> + */
> +static bool mana_needs_single_rxbuf_per_page(struct gdma_context *gc)
> +{
> +	int i = 0;
> +	const char *ver = gc->processor_version;
> +
> +	if (!ver)
> +		return false;
> +
> +	if (PAGE_SIZE != SZ_4K)
> +		return false;
> +
> +	while (i < ARRAY_SIZE(mana_single_rxbuf_per_page_quirk_tbl)) {
> +		if (!strcmp(ver, mana_single_rxbuf_per_page_quirk_tbl[i]))
> +			return true;
> +		i++;
> +	}
> +
> +	return false;
> +}
> +
> +static void mana_get_proc_ver_strno(const struct dmi_header *hdr, void *data)
> +{
> +	struct gdma_context *gc = data;
> +	const u8 *d = (const u8 *)hdr;
> +
> +	/* We are only looking for Type 4: Processor Information */
> +	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
> +		return;
> +
> +	/* Ensure the record is long enough to contain the Processor Version
> +	 * field
> +	 */
> +	if (hdr->length <= SMBIOS_TYPE4_PROC_VERSION_OFFSET)
> +		return;
> +
> +	/* The 'Processor Version' string is located at index pointed by
> +	 * SMBIOS_TYPE4_PROC_VERSION_OFFSET.  Make a copy of the index.
> +	 * There could be multiple Type 4 tables so read and store the
> +	 * processor version index found the first time.
> +	 */
> +	if (gc->proc_ver_strno)
> +		return;
> +
> +	gc->proc_ver_strno = d[SMBIOS_TYPE4_PROC_VERSION_OFFSET];
> +}
> +
> +static const char *mana_dmi_string_nosave(const struct dmi_header *hdr, u8 s)
> +{
> +	const char *bp = (const char *)hdr + hdr->length;
> +
> +	if (!s)
> +		return NULL;
> +
> +	/* String numbers start at 1 */
> +	while (--s > 0 && *bp)
> +		bp += strlen(bp) + 1;
> +
> +	if (!*bp)
> +		return NULL;
> +
> +	return bp;
> +}
> +
> +static void mana_fetch_proc_ver_string(const struct dmi_header *hdr,
> +				       void *data)
> +{
> +	struct gdma_context *gc = data;
> +	const char *ver;
> +
> +	/* We are only looking for Type 4: Processor Information */
> +	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
> +		return;
> +
> +	/* Extract proc version found the first time only */
> +	if (!gc->proc_ver_strno || gc->processor_version)
> +		return;
> +
> +	ver = mana_dmi_string_nosave(hdr, gc->proc_ver_strno);
> +	if (ver)
> +		gc->processor_version = kstrdup(ver, GFP_KERNEL);
> +}
> +
> +/* Check and initialize all processor optimizations/quirks here */
> +static bool mana_init_processor_optimization(struct gdma_context *gc)
> +{
> +	bool opt_initialized = false;
> +
> +	gc->proc_ver_strno = 0;
> +	gc->processor_version = NULL;
> +
> +	dmi_walk(mana_get_proc_ver_strno, gc);
> +	if (!gc->proc_ver_strno)
> +		return false;
> +
> +	dmi_walk(mana_fetch_proc_ver_string, gc);
> +	if (!gc->processor_version)
> +		return false;
> +
> +	if (mana_needs_single_rxbuf_per_page(gc)) {
> +		gc->force_full_page_rx_buffer = true;
> +		opt_initialized = true;
> +	}
> +
> +	return opt_initialized;
> +}
> +
>  static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	struct gdma_context *gc;

[ ... ]

> @@ -2013,6 +2136,11 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
>  							  mana_debugfs_root);
>
> +	if (mana_init_processor_optimization(gc))
> +		dev_info(&pdev->dev,
> +			 "Processor specific optimization initialized on: %s\n",
> +			gc->processor_version);
> +
>  	err = mana_gd_setup(pdev);
>  	if (err)
>  		goto unmap_bar;

[ ... ]

> @@ -2055,6 +2183,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	pci_iounmap(pdev, bar0_va);
>  free_gc:
>  	pci_set_drvdata(pdev, NULL);
> +	kfree(gc->processor_version);
> +	gc->processor_version = NULL;
>  	vfree(gc);
>  release_region:
>  	pci_release_regions(pdev);

[ ... ]

> @@ -2110,6 +2240,9 @@ static void mana_gd_remove(struct pci_dev *pdev)
>
>  	pci_iounmap(pdev, gc->bar0_va);
>
> +	kfree(gc->processor_version);
> +	gc->processor_version = NULL;
> +
>  	vfree(gc);
>
>  	pci_release_regions(pdev);

[ ... ]

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ea71de39f996..f17cc2cc7dd9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c

[ ... ]

> @@ -744,6 +744,26 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
>  	return va;
>  }
>
> +static bool
> +mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
> +{
> +	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> +
> +	/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
> +	 * trigger a throughput regression. Hence forces one RX buffer per page
> +	 * to avoid the fragment allocation/refcounting overhead in the RX
> +	 * refill path for those processors only.
> +	 */
> +	if (gc->force_full_page_rx_buffer)
> +		return true;
> +
> +	/* For xdp and jumbo frames make sure only one packet fits per page. */
> +	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
> +		return true;
> +
> +	return false;
> +}
> +
>  /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
>  static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
>  			       int mtu, u32 *datasize, u32 *alloc_size,

[ ... ]

> @@ -754,8 +774,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
>  	/* Calculate datasize first (consistent across all cases) */
>  	*datasize = mtu + ETH_HLEN;
>
> -	/* For xdp and jumbo frames make sure only one packet fits per page */
> -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
> +	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
>  		if (mana_xdp_get(apc)) {
>  			*headroom = XDP_PACKET_HEADROOM;
>  			*alloc_size = PAGE_SIZE;

[ ... ]

> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
> index ec17004b10c0..be56b347f3f6 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h

[ ... ]

> @@ -9,6 +9,12 @@
>
>  #include "shm_channel.h"
>
> +/* SMBIOS Type 4: Processor Information table */
> +#define SMBIOS_TYPE_4_PROCESSOR_INFO 4
> +
> +/* Byte offset containing the Processor Version string number.*/
> +#define SMBIOS_TYPE4_PROC_VERSION_OFFSET 0x10
> +
>  #define GDMA_STATUS_MORE_ENTRIES	0x00000105
>  #define GDMA_STATUS_CMD_UNSUPPORTED	0xffffffff
>

[ ... ]

> @@ -444,6 +450,9 @@ struct gdma_context {
>  	struct workqueue_struct *service_wq;
>
>  	unsigned long		flags;
> +	u8			*processor_version;
> +	u8			proc_ver_strno;
> +	bool			force_full_page_rx_buffer;
>  };
>
>  static inline bool mana_gd_is_mana(struct gdma_dev *gd)

Should processor_version be declared as char * instead of u8 *?

The field is used as a string throughout the code: it's assigned from
kstrdup() in mana_fetch_proc_ver_string(), read as const char *ver
in mana_needs_single_rxbuf_per_page(), passed to strcmp(), and printed
with %s format in dev_info().

Using u8 * for string data can trigger compiler warnings with
-Wpointer-sign, since string functions expect char * types.


