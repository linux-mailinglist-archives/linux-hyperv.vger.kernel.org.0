Return-Path: <linux-hyperv+bounces-9163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGrFAajSqmn3XQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9163-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:12:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6083F2216D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9273010257
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6B3939CF;
	Fri,  6 Mar 2026 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LmGmLHhN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A2D3939D0;
	Fri,  6 Mar 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802723; cv=none; b=MMXatmqhDucpL71Z6o/XukdAnqX9f9AQ8TAIveaHyaYUObOhiVnDKWDA09XmX8J+W8rTyiyntzx0ShZkniPA5dDKRlfKukdT3XkKIacpLCPSsap5ocXuhrjR3B8VUkb+6Qsd+9kdp/U5eu5iNJXP2xXg0vUVYwk1t7iuTkCOyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802723; c=relaxed/simple;
	bh=P3lE/2OlecH3irHBREw1hWYOkczvI22MXDpkplGGvcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjgDswXP2EqoS6s46YFlidly2g7pbc8P6PVf8gi8/otMo1+d6Eo1F1EEOoRrXPXqkL9FNvxpDe7zLAx3eukg7tEZTfEiYgOecrpX/HNIdRp5MHiFesZGH4AzuBSkJjK1N9BMXBgqj3RFT3LVU2Ujkgn0hQOr6hmVw9vYDlewgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LmGmLHhN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 476E920B6F02; Fri,  6 Mar 2026 05:12:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 476E920B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772802722;
	bh=GbYh9l8+kvPKPBBoRi48pyqIu+o225YJk6COfpopOwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmGmLHhNfWBEF6fhIWObXTKemxNhjRO1OqLaYPJdzIo9YF0VXeiMF7x+z2gEbUN1g
	 Apij/fxkqBhROMwKLuIr09YRAuFigX/0ms0lzEFDQoW/ZOe3iAd/yfa8W7Lg38CGmV
	 LLOCqeuhWlS6K4arMzGDOZwgR1xkeivAa7PomYqE=
Date: Fri, 6 Mar 2026 05:12:02 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Message-ID: <aarSotB+gh+fnzZ6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <81b7e296-0cfe-4c24-ac97-7f6c712aa0e9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b7e296-0cfe-4c24-ac97-7f6c712aa0e9@redhat.com>
X-Rspamd-Queue-Id: 6083F2216D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9163-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:56:29AM +0100, Paolo Abeni wrote:
> On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> > On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> > fragments for RX buffers results in a significant throughput regression.
> > Profiling reveals that this regression correlates with high overhead in the
> > fragment allocation and reference counting paths on these specific
> > platforms, rendering the multi-buffer-per-page strategy counterproductive.
> > 
> > To mitigate this, bypass the page_pool fragment path and force a single RX
> > packet per page allocation when all the following conditions are met:
> >   1. The system is configured with a 4K PAGE_SIZE.
> >   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> > 
> > This approach restores expected line-rate performance by ensuring
> > predictable RX refill behavior on affected hardware.
> > 
> > There is no behavioral change for systems using larger page sizes
> > (16K/64K), or platforms where this processor-specific quirk do not
> > apply.
> > 
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 120 ++++++++++++++++++
> >  drivers/net/ethernet/microsoft/mana/mana_en.c |  23 +++-
> >  include/net/mana/gdma.h                       |  10 ++
> >  3 files changed, 151 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 0055c231acf6..26bbe736a770 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/msi.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/export.h>
> > +#include <linux/dmi.h>
> >  
> >  #include <net/mana/mana.h>
> >  #include <net/mana/hw_channel.h>
> > @@ -1955,6 +1956,115 @@ static bool mana_is_pf(unsigned short dev_id)
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
> > +static const char *smbios_get_string(const struct dmi_header *hdr, u8 idx)
> > +{
> > +	const u8 *start, *end;
> > +	u8 i;
> > +
> > +	/* Indexing starts from 1. */
> > +	if (!idx)
> > +		return NULL;
> > +
> > +	start   = (const u8 *)hdr + hdr->length;
> > +	end = start + SMBIOS_STR_AREA_MAX;
> > +
> > +	for (i = 1; i < idx; i++) {
> > +		while (start < end && *start)
> > +			start++;
> > +		if (start < end)
> > +			start++;
> > +		if (start + 1 < end && start[0] == 0 && start[1] == 0)
> > +			return NULL;
> > +	}
> > +
> > +	if (start >= end || *start == 0)
> > +		return NULL;
> > +
> > +	return (const char *)start;
> 
> If I read correctly, the above sort of duplicate dmi_decode_table().
>
Yes, its not exported.
 
> I think you are better of:
> - use the mana_get_proc_ver_from_smbios() decoder to store the
> SMBIOS_TYPE4_PROC_VERSION_OFFSET index into gd
> - do a 2nd walk with a different decoder to fetch the string at the
> specified index.
Sure, will implement the 2nd walk for fetching string in v2.

> 
> /P

Thank you Paolo, for the comments, and apologies in my delay in response as this week I am on-call.
I will send out v2 with the changes suggested.

Regards

