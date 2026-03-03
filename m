Return-Path: <linux-hyperv+bounces-9117-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDQtAkMep2kUeAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9117-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 18:45:39 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9751F4C5D
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Mar 2026 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A297930FF482
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Mar 2026 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CF3E51F5;
	Tue,  3 Mar 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpkSpK4m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnx6QPUl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10763D75D4
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Mar 2026 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559785; cv=none; b=T7y8Zq6hjzQtakyr2ttHDiQJiuCwBSdIoMJ8+l4bpjuU/6gVpWEWG3dhtnxFMge8o+RCUXKYY9ClZUfydnjbzIN4JJc/NI95I7fQtb8cBMQH7PhSfazaYzDXj1gnWZbIUN5L6eevYpEx6Zr38iMFSf8jD5rauJ73xqeuDqhuAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559785; c=relaxed/simple;
	bh=dZp04g6uiiOvyjSK+U2cIgCRjRltYcNDmLHe1BhbY4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIxfssoZ5USct52f/lkOS1s8Oy3IM65UCmD/9sQn2RC94fywCaaSDpLqlXLn/0CeCyJfGw/NyDTnHrb2QzcgnrZBckCWTzzkW4hr7Kuye6JOUHq82s/tgixu0iIdFQTO1QXrD0RXl5jZFWqFgcwFM/E7188Xq4bzgqhiRo1PcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpkSpK4m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dnx6QPUl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772559781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXyJq2jhL63XCeCGf/kk+0S1SsVNcL/cSZ0UgVWv13U=;
	b=JpkSpK4mdHfqFBllnggbrin5QYz9G2AKNsFVemSuzd/cHM1KdFcANTGQJqc9eFyD7H6pBT
	lZ+ym36yJuE8JMSUL2D4UUN8hWgPFSfB2d0H1LJWv6FxIUtzhWFDEENLhilxnOY8n4ikoV
	wURpnpuNXlFTzopS2SOJUaPBk+MDn2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-6KG2HyrvO_ifnNkL0pONVg-1; Tue, 03 Mar 2026 12:43:00 -0500
X-MC-Unique: 6KG2HyrvO_ifnNkL0pONVg-1
X-Mimecast-MFC-AGG-ID: 6KG2HyrvO_ifnNkL0pONVg_1772559779
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439ba9b08dcso1659105f8f.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Mar 2026 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772559779; x=1773164579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXyJq2jhL63XCeCGf/kk+0S1SsVNcL/cSZ0UgVWv13U=;
        b=Dnx6QPUlYx3J58I+TC28BzNKKoHQJ6D3HGZRUVV8HlVHCj2l9+jBicWRwpTqnbVXDc
         WZN9K5LvpcH8OXIdAz6dbfa7FmhaZT9pgonZf5e0TaCuP2rq3GsI7XFisY1vjpLEx11v
         ooM1xg00QapKXNWG/RBUAEfWZXpcAvnttQf8tPhfvRo3/hvfYV2P4S+sM8wbgAK8HRKn
         Ii+RFsV7h2MRmR5uDUp/hiOWS3QFPA58XDanoN2HQdsiwMK5jC61YVmCSSHwJNs3ay7/
         xlPDKmZysW9iWii1u4dlwzQryXBY+ui8UAw4JuyXkmgO6ceJm+5FdxR2r+Scrv/BbDh+
         Tfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559779; x=1773164579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXyJq2jhL63XCeCGf/kk+0S1SsVNcL/cSZ0UgVWv13U=;
        b=Zr03eWZGK0Ga7mdsmuTvbBy0/C83PqNviiRLm3vHIAHIwiP/lJIlJtLd2JRbYmvcN2
         BOkJG2bypIB2OgyWeD0AsB309+tOzjXFgodS75inky32vxEarTOlqUi8O8rs8vIo3oXd
         RT+QGpfzMKbsLm3nz8Wt610nyvA8bxPdeXaM1GlyxG8OQhKFitK/5Ddldy1NaYg11XsE
         2rHIiV9tPfccvUrjtMcwP6BT/6YEVzAMfCrky0Je9i/Y2ZcZpmVnrGccfhMpGtlOZHLo
         Mg+tfH8RgG5Dss1PhIAH+Ine1Sg/ysT/8D3TXXuA9x2v4qhuGQ3MG4TUm3pjBrz52XAE
         cDjg==
X-Forwarded-Encrypted: i=1; AJvYcCU2rBRpkzngaw7pF9ipr/Le9/iprRrOC3Myp1GqvZdbYAxg2Cv/KljS7Xu3XsFQ/ExJf+VEPx+c5KKVAgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo96xbvl/uaAGf+nIpReyWxAVRr86DiDbd8FqGDiNQcEQaMvB8
	MCBG/OS04lxD03zaqpjU4NfDCc4upOM7MsowH4AxHI75hUhhhvYrNrlE1pkVcCqaBWIPHib4Jxo
	oym0aLJBqlLp/69xdLT3Bn5NYPP/acDUVObYlECiBsGgFGED4DX1RY8UMjLZ77N9wNw==
X-Gm-Gg: ATEYQzxlHxT+3KbISsYpqlMw301eLkxZC1Noo6+wB60of0x6tw0HEyPXbB57Xm9D0Yt
	oPkLhhKqyPV21OQGPBmiWHskUMEhHUH0z97jN+uaDXzeuy4faq4mm2M4y48EWZIBdvRtt57GvdZ
	tHMg1qMEkif5NHaI4XMSGAcAUa37lOgKckTcI1ZkoseHif6sV9Ttv+SifDqcQv5+IIayQRI9kKL
	E9S2STtVIPEf+/Bfuup2G4GwrgHwA7x5kaRDJOf3dJqG5sfbpbD2d5sjC3gYrIoiY8Q24GIl8pL
	SrNwIACSATOd0LITE1QZSfDyGpFWMz0+W+xOkRBR0PzLKvaVPRbn1vpQJgMNcIZDVBJ6woRQGCx
	wtpkvtDUI5OGwrBdokgigGDOWeujvPGC3ZwkvfgPEPqFCVA==
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-439b2656dd5mr17085011f8f.12.1772559779109;
        Tue, 03 Mar 2026 09:42:59 -0800 (PST)
X-Received: by 2002:a05:6000:2902:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-439b2656dd5mr17084962f8f.12.1772559778587;
        Tue, 03 Mar 2026 09:42:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm13000276f8f.33.2026.03.03.09.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:42:58 -0800 (PST)
Date: Tue, 3 Mar 2026 12:42:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
Cc: david@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] Allow order zero pages in page reporting
Message-ID: <20260303124236-mutt-send-email-mst@kernel.org>
References: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303113032.3008371-1-yuvraj.sakshith@oss.qualcomm.com>
X-Rspamd-Queue-Id: 8F9751F4C5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9117-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:30:27AM -0800, Yuvraj Sakshith wrote:
> Today, page reporting sets page_reporting_order in two ways:
> 
> (1) page_reporting.page_reporting_order cmdline parameter
> (2) Driver can pass order while registering itself.
> 
> In both cases, order zero is ignored by free page reporting
> because it is used to set page_reporting_order to a default
> value, like MAX_PAGE_ORDER.
> 
> In some cases we might want page_reporting_order to be zero.
> 
> For instance, when virtio-balloon runs inside a guest with
> tiny memory (say, 16MB), it might not be able to find a order 1 page
> (or in the worst case order MAX_PAGE_ORDER page) after some uptime.
> Page reporting should be able to return order zero pages back for
> optimal memory relinquishment.
> 
> This patch changes the default fallback value from '0' to '-1' in
> all possible clients of free page reporting (hv_balloon and
> virtio-balloon) together with allowing '0' as a valid order in
> page_reporting_register().

virtio change is a technicality, so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Changes in v1:
> - Introduce PAGE_REPORTING_DEFAULT_ORDER macro (initially set to 0).
> - Make use of new macro in drivers (hv_balloon and virtio-balloon)
>         working with page reporting.
> - Change PAGE_REPORTING_DEFAULT_ORDER to -1 as zero is a valid
>         page order that can be requested.
> 
> Changes in v2:
> - Better naming. Replace PAGE_REPORTING_DEFAULT_ORDER with
>         PAGE_REPORTING_ORDER_UNSPECIFIED. This takes care of
>         the situation where page reporting order is not specified
>         in the commandline.
> - Minor commit message changes.
> 
> Changes in v3:
> - Setting page_reporting_order's initial value to
> 	PAGE_REPORTING_ORDER_UNSPECIFIED moved to
> 	PATCH #5.
> 
> Changes in v4:
> - Move PAGE_REPORTING_ORDER_UNSPECIFIED's usage with
> 	page_reporting_order to patch #5.
> 
> Yuvraj Sakshith (5):
>   mm/page_reporting: add PAGE_REPORTING_ORDER_UNSPECIFIED
>   virtio_balloon: set unspecified page reporting order
>   hv_balloon: set unspecified page reporting order
>   mm/page_reporting: change PAGE_REPORTING_ORDER_UNSPECIFIED to -1
>   mm/page_reporting: change page_reporting_order to
>     PAGE_REPORTING_ORDER_UNSPECIFIED
> 
>  drivers/hv/hv_balloon.c         | 2 +-
>  drivers/virtio/virtio_balloon.c | 2 ++
>  include/linux/page_reporting.h  | 1 +
>  mm/page_reporting.c             | 7 ++++---
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.34.1


