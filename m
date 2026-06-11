Return-Path: <linux-hyperv+bounces-11608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r4kJI9KZKmpotQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11608-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 13:19:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662B67140C
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 13:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YlteVp30;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11608-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11608-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 278AA3093614
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jun 2026 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6F3E0233;
	Thu, 11 Jun 2026 11:17:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662E3BADA3;
	Thu, 11 Jun 2026 11:17:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176672; cv=none; b=o5FPco1k7A/q8aEEmI8V/YL7n/P7Ahbyuk83hAXQWG50HWs8CN1V5QdAh6g7Dz/4fU3NRk74wD96G4fAWPmdlnLNL4G59BvsEubVz43Y2uq1ZHJgPiDWSkZO4WhysyEza/Vx6DEt66/ANLdNiQZvKsuwg0TkNW2q8fLLXx0N39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176672; c=relaxed/simple;
	bh=LEK1uQ6gepWyXxIbWGCa9TpOLfVAzh+4u1xi7dpJ3Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALBOoQ+wRu0Nr+1Lhoa/keMMpvXQrtZDhyUSi0UuautZbgXgduw+KBr7lJ/HjHRJpCWw7cOg7emAFMvfUoSjX3ty7rUkCVRH1uaqwWx2CT6POGGgW7SfzQuK6O8EwvhM2vp5dEGxWo+zv3rZ+N6+FuhRlUwovW8rgVa3S73CzEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlteVp30; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15031F00898;
	Thu, 11 Jun 2026 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176670;
	bh=gY5+0gSQ05qfi/VBH8DsJ32bBdDvXncnKhTCvsRDcpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YlteVp30zb+OYldlUwOIb2NTEdk6j/HzjFx/XMl7znJRXCdq35Us43/MvnI48nmdv
	 nFu+J/qDYZ/UMdqjuRJANzmdfSDAaLoTIMWqHKjT6ngsnEbGI9jKSE7veLklSJe4ox
	 ZSmtJAJVVOP8RfY9zqrulJRPakyJdLxmUGWBSJoW64pF+E732b53xEp1h3WSD6jST0
	 y0J5O2XNJRC3dSVClXq0DTMkvqmWgsHBC350fkRvQk8kRMooKBbW3CvNzZl1IZp4bq
	 RbTFc38gD8ZIVdOetfifudL8FEeUbruhdkBdrS0z7KQak3gj32Ua2W9HFhUHzyewUa
	 qLDSiXgoGcJ8A==
Date: Thu, 11 Jun 2026 14:17:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: longli@microsoft.com, kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3] RDMA/mana_ib: Clamp adapter capabilities at
 the ib_device_attr boundary
Message-ID: <20260611111745.GM327369@unreal>
References: <20260525190101.1264185-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525190101.1264185-1-ernis@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11608-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1662B67140C

On Mon, May 25, 2026 at 12:01:01PM -0700, Erni Sri Satya Vennela wrote:
> mana_ib stores its adapter capabilities internally as u32 in
> struct mana_ib_adapter_caps. The IB core, however, exposes the
> corresponding device attributes through struct ib_device_attr, where
> fields such as max_qp, max_qp_wr, max_send_sge, max_recv_sge,
> max_sge_rd, max_cq, max_cqe, max_mr, max_pd, max_qp_rd_atom,
> max_res_rd_atom and max_qp_init_rd_atom are signed int.
> 
> mana_ib_query_device() is the only place that copies the cached u32
> caps into these int fields. If a cap exceeds INT_MAX, the implicit
> u32-to-int narrowing yields a negative value. Clamp each cap to
> INT_MAX at this boundary so the values handed to the IB core are always
> non-negative.
> 
> While here, fix a related overflow in the computation of
> max_res_rd_atom. It is derived as max_qp_rd_atom * max_qp, both of
> which are int after the assignment above; the multiplication can
> overflow an int even with the new clamps in place. Widen to s64
> before multiplying and clamp the result to INT_MAX.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v3:
> * Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
>   caps cache does not need to be clamped.
> * Move all clamping exclusively to mana_ib_query_device(), which is the
>   only place the cached u32 values are narrowed into the signed int
>   fields of struct ib_device_attr.
> * Reframe commit message: this is a u32-to-int type boundary fix, not a
>   CVM/untrusted-hardware hardening patch.

You should align all types to u32 and avoid hiding the issue behind  
min_t().

Thanks

