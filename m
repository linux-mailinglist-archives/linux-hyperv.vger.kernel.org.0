Return-Path: <linux-hyperv+bounces-11646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivjeCZSbNWrq1AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11646-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 21:42:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 864536A790B
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 21:42:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=aWJDu0oh;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11646-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11646-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2EE3030F7F
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4938D68F;
	Fri, 19 Jun 2026 19:41:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B53B9DAD;
	Fri, 19 Jun 2026 19:41:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898103; cv=none; b=J0YAk/Dct9S7MKP/CZHhvjuVYLMKkFDpXfcLJcfcNYMRpHoz1ZV9etAIjaLqklJ+yL7J/2S6fKZIeTEOUK0m/3ZOXzNbF4QENPMmK++I3mdHxvok5gwJWzXBz9PJNddP2P7FLQYL3SA4uPuxEalc3s+fsUbgp9y9NvRbhHCQXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898103; c=relaxed/simple;
	bh=aQaqEP2oOYF3BYd3WsTEnGHeidJGKAI5xZP4jpb2RmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpWYB+ujt+eay4wFjglY94JeBciYYfNTms5zVGVc44tVNbaE1E2ZZKANLIpZoaanP8wjnu5hZe0wY2WkcP/smlhvkW9/+XvsXtpFtTRx/f12CwNAVuSAq/Kzx0KN2DoEoF9pmLFq4hQlefrbvZKjRh5x0KbJII21BWqLtXduuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aWJDu0oh; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C02DB20B7168; Fri, 19 Jun 2026 12:41:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C02DB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781898099;
	bh=gcWclnNH9OFtBIA6dfuYJBVCYP1vi/zTWtgJAjC6ylY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWJDu0ohNkUA/izOjHPn4oJYUsltyAPYbADPV0lx2c3+NwX+JG+5I8R1YPcwqSzaI
	 54cIdE59F7DTgmGtV0H2Ll+oGls9qrHLhvkr4035X84TyyBMljzOXYffSeC3DwaAb8
	 hADfBs5haxlvfVFkcswdQ/V/7I/R4+vcLmw7OfQU=
Date: Fri, 19 Jun 2026 12:41:39 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: longli@microsoft.com, kotaranov@microsoft.com,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3] RDMA/mana_ib: Clamp adapter capabilities at
 the ib_device_attr boundary
Message-ID: <ajWbc1HNcMOy8xkE@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260525190101.1264185-1-ernis@linux.microsoft.com>
 <20260611111745.GM327369@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611111745.GM327369@unreal>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11646-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim,linux.microsoft.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 864536A790B

On Thu, Jun 11, 2026 at 02:17:45PM +0300, Leon Romanovsky wrote:
> On Mon, May 25, 2026 at 12:01:01PM -0700, Erni Sri Satya Vennela wrote:
> > mana_ib stores its adapter capabilities internally as u32 in
> > struct mana_ib_adapter_caps. The IB core, however, exposes the
> > corresponding device attributes through struct ib_device_attr, where
> > fields such as max_qp, max_qp_wr, max_send_sge, max_recv_sge,
> > max_sge_rd, max_cq, max_cqe, max_mr, max_pd, max_qp_rd_atom,
> > max_res_rd_atom and max_qp_init_rd_atom are signed int.
> > 
> > mana_ib_query_device() is the only place that copies the cached u32
> > caps into these int fields. If a cap exceeds INT_MAX, the implicit
> > u32-to-int narrowing yields a negative value. Clamp each cap to
> > INT_MAX at this boundary so the values handed to the IB core are always
> > non-negative.
> > 
> > While here, fix a related overflow in the computation of
> > max_res_rd_atom. It is derived as max_qp_rd_atom * max_qp, both of
> > which are int after the assignment above; the multiplication can
> > overflow an int even with the new clamps in place. Widen to s64
> > before multiplying and clamp the result to INT_MAX.
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > ---
> > Changes in v3:
> > * Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
> >   caps cache does not need to be clamped.
> > * Move all clamping exclusively to mana_ib_query_device(), which is the
> >   only place the cached u32 values are narrowed into the signed int
> >   fields of struct ib_device_attr.
> > * Reframe commit message: this is a u32-to-int type boundary fix, not a
> >   CVM/untrusted-hardware hardening patch.
> 
> You should align all types to u32 and avoid hiding the issue behind  
> min_t().
> 
> Thanks
Yes Leon, I'm currently at v7 version of this patch.
I'm planning to completely avoid using min_t in the next version.

- Vennela

