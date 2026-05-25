Return-Path: <linux-hyperv+bounces-11190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NInE9mbFGo0OwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11190-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 20:58:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33785CDDD0
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C96300CE46
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF4385D66;
	Mon, 25 May 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s9KlT18z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670837FF6D;
	Mon, 25 May 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735509; cv=none; b=lnkRXdb0e41t2WDsDpViCtK/cH4pUtIDZRKVDW4ITll/XURw3Auai5JSNvJKaaRgN6yBA0ZypTzD20tdH1olOtd2jAqle7EwyvMPiD8qz4LEOw0FxDFLC9Ly2hPauEV9xP4MLiOqVOOe8CupFG9PZwylOJwAGRVgC/k0mXjd2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735509; c=relaxed/simple;
	bh=c4sWq0yYiphQNnigAcBkyhQ7EL/xmF4ENZ14Fb0i6gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW+P9W4vdAenMrGph1jziDNG0+l9wL1UHLx/IgHlRCVQTNC0YeB7GVYKyi8QsIZD6risqu+hACmDwbZRnIlGsURevl4z1SWxxQcjVJWXvKCzt2B7Je0aocFE/5FnZYAwmN04P3Y4oGwo3ABQ4CVXZMcWPx+6R60F00G/XheqRys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s9KlT18z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E49BB20B7166; Mon, 25 May 2026 11:58:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E49BB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779735497;
	bh=sWhVOTOPYYXrJhIWUkF92uqbf/RxAtjukEwuBDpRK8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9KlT18zS9OKisCoT6RIgeivhhhAv+zhfxoiURqbjZJz6uT7qHN+0axAvqP1hVmYI
	 /VQw4qXg55/EcVeTUDh0f7rFP3RfaH2KhGkNI17U1L+4V+9BXP7p9DL6Dlb8qVVPuh
	 JBqtlK1ItOx7bP+f7pbqeUz3IAS0BfyhESAokDmY=
Date: Mon, 25 May 2026 11:58:17 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening:
 Clamp adapter capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <ahSbyYcq0sgfJnmZ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
 <20260316194929.GI61385@unreal>
 <SA1PR21MB66832D25A93394735624F454CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260317094408.GR61385@unreal>
 <SA1PR21MB66833EBAF447BA0B102862FCCE4DA@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260410154327.GA2551565@ziepe.ca>
 <LV0PR21MB66700DC2FB827B93ED6A5714CE592@LV0PR21MB6670.namprd21.prod.outlook.com>
 <20260413134602.GL3694781@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413134602.GL3694781@ziepe.ca>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11190-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A33785CDDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:46:02AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 10, 2026 at 10:29:45PM +0000, Long Li wrote:
> > > On Sat, Mar 21, 2026 at 12:56:39AM +0000, Long Li wrote:
> > > 
> > > > How we rephrase this in this way: the driver should not corrupt or
> > > > overflow other parts of the kernel if its device is misbehaving (or
> > > > has a bug).
> > > 
> > > If we are going to do this CC hardening stuff I think I want to see a more
> > > comphrensive approach, like if we detect an attack then the kernel instantly
> > > crashes or something. Or at least an approach in general agreed to by the CC and
> > > kernel community.
> > > 
> > > Igoring the issue and continuing seems just wrong.
> > > 
> > > This sprinkling of random checks in this series doesn't feel comprehensive or
> > > cohesive to me.
> > > 
> > > Jason
> > 
> > Can we follow the virtio BAD_RING()/vq->broken pattern in
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio_ring.c#n57.
> > 
> > Add a broken flag to mana_ib_dev. When any hardware response
> > contains out-of-range values, mark the device broken and fail the
> > operation - during probe this prevents device registration entirely,
> > at runtime all subsequent operations return -EIO.
> 
> If that's the plan I would think it should be struct device based, but
> yeah, I'm more comfortable with this sort of direction as a CC
> hardening plan.
> 
Hi Jason,

Our team is not aligned with marking the device broken, after multiple
discussions, since both the values that are received from hardware and
stored in mana_ib_gd_query_adapter_caps are u32.

I'm planning to send v3 as a non-hardening patch with only clamping the
values at mana_ib_query_device to INT_MAX when out-of-bound.

Your previous concerns:
> “I'm also not convinced clamping to such a high value has any value
> whatsoever, as it probably still triggers maths overflows elsewhere. I
> think you should clamp to reasonable limits for your device if you want
> to do this.”

We plan to clamp it to INT_MAX since it is the max in props.

> “There is no reason they should be signed, you should just fix the
> type.”

It is not allowed to change sign in props, so clamping is the best bet.

Thanks,
Vennela

