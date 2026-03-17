Return-Path: <linux-hyperv+bounces-9488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMMZB0EkuWm1sQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9488-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 10:52:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD322A7445
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECE8316894A
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9893793CE;
	Tue, 17 Mar 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFsrrK46"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7213377018;
	Tue, 17 Mar 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740654; cv=none; b=DgY1EByxt35aBfKpqM4526bSSeC9gk9T5GjBnnEcB5kF6MaizvmeLabpTDvjxuhlphPzIg1FSvjfhhFF05i6QsdIjKT/iHXVU/rkezf5j2xmQSMs1Z9Ng3NGWK20+JS70MEXnauYv+A/rjuypwYeavQd1y+9I18Rw0z/jnjjQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740654; c=relaxed/simple;
	bh=DoUrnSKK60JGnRQpOdFQ2pdKSwEqK9naRaMWFQdjX9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6bJUmINy7oXfvHS9m9SWlYDu0nfdeTEu2hLvsVgbQ15tU+keyTrD7ay1bhUyjdJZeAF2IiJoiCDOuuBwJZU1gzFQkNoEUnKhnAF4GPVa8gInXAzDCeSB1O1Qh5tgWLVVrHGtpts2DGt3zuGLUwOmLBol15OZt99gVYLK5Zeaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFsrrK46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83FC4CEF7;
	Tue, 17 Mar 2026 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740654;
	bh=DoUrnSKK60JGnRQpOdFQ2pdKSwEqK9naRaMWFQdjX9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFsrrK46N0yQMKmGzxgPqupwLUxwcwWupv7otLOP7weascwHMNRnf8livg85qC5De
	 PvWJ88I3YqAEZynzxaPIspjdHCDgGidXy4nidWhwp8jJcWaR6vEYqifjG7KKkxQWrU
	 Tam0EBtwrBqYTwgW7ZKpxbs7USjkaJtnKqbPakGhL70qfF5UnKydpUnyKdkvixnlds
	 JlmfHslWAg7xOtB+A7I2VnxYAwyoyWf+PzW1hSaGOiybGGYPzsMEpnsE3rAamcEIvo
	 UF3ppjkZ45cUABKEcPNwJYwZYfPNcoJsimAMiVU2EngevYgpeIBgBYPGNqzJOx+OL+
	 RW8rOvXxAMAzg==
Date: Tue, 17 Mar 2026 11:44:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260317094408.GR61385@unreal>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9488-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CD322A7445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:50:39PM +0000, Long Li wrote:
> > On Thu, Mar 12, 2026 at 11:16:41AM -0700, Erni Sri Satya Vennela wrote:
> > > As part of MANA hardening for CVM, clamp hardware-reported adapter
> > > capability values from the MANA_IB_GET_ADAPTER_CAP response before
> > > they are used by the IB subsystem.
> > >
> > > The response fields (max_qp_count, max_cq_count, max_mr_count,
> > > max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
> > > max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
> > > assigned to signed int members in struct ib_device_attr. If hardware
> > > returns a value exceeding INT_MAX, the implicit u32-to-int conversion
> > > produces a negative value, which can cause incorrect behavior in the
> > > IB core and userspace applications.
> > 
> > This sentence does not make sense in the context of the Linux kernel.
> > The fundamental assumption is that the underlying hardware behaves correctly,
> > and driver code should not attempt to guard against purely hypothetical
> > failures. The kernel only implements such self‑protection when there is a
> > documented hardware issue accompanied by official errata.
> > 
> > Thanks
> 
> The idea is that a malicious hardware can't corrupt and steal other data from the kernel.
> 
> The assumption is that in a public cloud environment, you can't trust the hardware 100%.

You cannot separate functionality and claim that one line of code is trusted
while another is not.

Thanks

