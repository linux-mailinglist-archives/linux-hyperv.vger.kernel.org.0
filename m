Return-Path: <linux-hyperv+bounces-9526-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DVjL6S9ummqbQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9526-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 15:58:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB232BDB02
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 197BA30C9DC5
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Mar 2026 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4913E120F;
	Wed, 18 Mar 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szx6C34I"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026883DFC8E;
	Wed, 18 Mar 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845374; cv=none; b=qwcYlWhJfpRsv5BNW6mA2tEyzupHHhGZJh/nWV3xDDwP13P4bTsmQ/52gJ0yNgJWt+ufnfRC2rw1nSa21RakujGUSDODF8ljOJw5ygFwxgo4hPGtMVCNjjR9s5bp7I1HNr0hhFNW0Ztn2LniMoZ/qUJJ2XoX+EpRghl8eaAjlTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845374; c=relaxed/simple;
	bh=wjL9ciqdCWcL/zpYteBo9jr8z/hJJuF/zC+yQOcCUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiajy6YKgRbgI14WO4Rfk8jrTlDlvanumngsTgAzCu+FuCQY8OiC9dN7vE0PcdvGRWsVzQT7jkd3rgHyYa3/6m5bpvUQHQEefiXhgUpUw4IpKFy0slNJxWnnBJci3D9OpTyxK1lP7tQZ4GvFMooOLXhTsbQjMOCB1qzXUvr+Mck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szx6C34I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F30C19421;
	Wed, 18 Mar 2026 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773845373;
	bh=wjL9ciqdCWcL/zpYteBo9jr8z/hJJuF/zC+yQOcCUKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Szx6C34IHWdK/Rh2CQ60ByQ5z1LThBSbM4Ezrejp/Wv5RDkgeYBrUD8j69MulSh12
	 fSHhxzrDJ0FkIhun/geXzhB5XtsD+SLghVpcwmd8mjfKFOfe2RWBIGtjMI/oopOqt+
	 uUVOSYMlf2RzcEtFcRCQKGGi1EXP85u7w3u5x8b6BYn2g/DXI+a/ERstzOMHoKx+yP
	 9++0g1ln9JNLL74gXaqgOGvONXo3IXN6EPCZ2+v1UMGz7NiAIQ4iku7NMEltPnfzI5
	 /5+5Alykd3qF8LZJMP/rcai6adQ/IIduNv+eaEi62ZiSfdOCzg6CSGDQ99S1PvNlbd
	 Ad8o1+fyDow+A==
Date: Wed, 18 Mar 2026 16:49:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle
 service reset for RDMA resources
Message-ID: <20260318144927.GB352386@unreal>
References: <20260307014723.556523-1-longli@microsoft.com>
 <20260307173814.GN12611@unreal>
 <20260313165928.GH1704121@ziepe.ca>
 <20260316200843.GK61385@unreal>
 <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR21MB66832D0A369DE7E411ACCDEDCE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9526-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BB232BDB02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:43:49PM +0000, Long Li wrote:
> > 
> > On Fri, Mar 13, 2026 at 01:59:28PM -0300, Jason Gunthorpe wrote:
> > > On Sat, Mar 07, 2026 at 07:38:14PM +0200, Leon Romanovsky wrote:
> > > > On Fri, Mar 06, 2026 at 05:47:14PM -0800, Long Li wrote:
> > > > > When the MANA hardware undergoes a service reset, the ETH
> > > > > auxiliary device
> > > > > (mana.eth) used by DPDK persists across the reset cycle — it is
> > > > > not removed and re-added like RC/UD/GSI QPs. This means userspace
> > > > > RDMA consumers such as DPDK have no way of knowing that firmware
> > > > > handles for their PD, CQ, WQ, QP and MR resources have become stale.
> > > >
> > > > NAK to any of this.
> > > >
> > > > In case of hardware reset, mana_ib AUX device needs to be destroyed
> > > > and recreated later.
> > >
> > > Yeah, that is our general model for any serious RAS event where the
> > > driver's view of resources becomes out of sync with the HW.
> > >
> > > You have tear down the ib_device by removing the aux and then bring
> > > back a new one.
> > >
> > > There is an IB_EVENT_DEVICE_FATAL, but the purpose of that event is to
> > > tell userspace to close and re-open their uverbs FD.
> > >
> > > We don't have a model where a uverbs FD in userspace can continue to
> > > work after the device has a catasrophic RAS event.
> > >
> > > There may be room to have a model where the ib device doesn't fully
> > > unplug/replug so it retains its name and things, but that is core code
> > > not driver stuff.
> > 
> > Good luck with that model. It is going to break RDMA-CM hotplug support.
> > 
> 
>    I think we can preserve RDMA-CM behavior without requiring ib_device
>    unregister/re-register.
> 
>    On device reset, the driver can dispatch IB_EVENT_DEVICE_FATAL (or a
>    new reset event) through ib_dispatch_event(). RDMA-CM already handles
>    device events — we would add a handler that iterates all rdma_cm_ids
>    on the device and sends RDMA_CM_EVENT_DEVICE_REMOVAL to each, same
>    as cma_process_remove() does today. The difference: cma_device stays
>    alive, so applications can reconnect on the same device after recovery
>    instead of waiting for a new one to appear.
> 
>    The motivation for keeping ib_device alive is that some RDMA consumers
>    — DPDK and NCCL — don't use RDMA-CM at all. They use raw verbs and
>    manage QP state themselves.

RDMA-CM provides an "external QP" model where the QP is managed by the
rdma-cm user.

As Jason noted, you should propose the core changes together with the
corresponding librdmacm updates. The final result must ensure that legacy
applications continue to function correctly with the new kernel.

Thanks

