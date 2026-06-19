Return-Path: <linux-hyperv+bounces-11643-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9hCHKsGNWqymAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11643-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 11:06:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E200D6A4D9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 11:06:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H+IESCsc;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11643-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11643-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296453046071
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E635EDA4;
	Fri, 19 Jun 2026 09:05:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610C2F8E98;
	Fri, 19 Jun 2026 09:05:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859922; cv=none; b=BGw/GZ69vRDONXnjVRmo7nBHaepi8G3B6VZZB5nEmYHdZK4hfd5huptjtM4lMvCABhRQ2S1rk99lwUlt+RZKvSNBFAVlTnnuN9pDk0vE6gRFvc3QmRJLNYp51HCNexY4lsch+qW6An79YDIZxEzS6xtgzqP0Ejx1C+rHKLLPC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859922; c=relaxed/simple;
	bh=Y6gJkW+SMdPt4P0WObWk8jXzSDQ8tLBAMqzt6Zwp6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faSKyPf/oL8QMyOTfc6Z1t1F3jR6MmoLWALx9aFIv21YW8eBvxlih7m6xAITqWCglqrcKBhGY0naZnktHLy+yfI5fMU93B3m33w1bd9+x2EDtBsPCQM2GvlSEPn3xbQcwjAnHSOz/ZYqRCT5pdnNg3/r94ougw5sEOpzhVoTUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+IESCsc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618791F00A3A;
	Fri, 19 Jun 2026 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859921;
	bh=32w9dxrk/QVTrzVo27ewIaHHRflbbYBLF2NEwB58Tvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H+IESCscotb71bLxleLrr5NhbRv3opRbYRt6AbQJS/8NCONBqWVUM9jujZL64JVtg
	 QAZcOcHMV/jf8NZYaMU6IdBaRY+yGusO0bxKCRai0jDganpc8w5aVWDmUXHkWYFr9x
	 7PvhDXWiOuUCiqiHzGhHLv01X7yj+GQYjHfdwNoA32Oaa2vuTYhka2WYjhbTVuAKBx
	 OvQOjXAe0XL6t8mZ356TuZrC3dsX5fvDimTWAcGDSLX6/eJEXiGmCMA+9Onf3Dx5oL
	 jsIAAL8f/u8/CKEx6YuEA5X0wvf2inNwu4t1HtwPNW5sD1Mlxu/OhVFsVuaebCzH+K
	 fD9fT0HisWwew==
Date: Fri, 19 Jun 2026 10:05:14 +0100
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
Subject: Re: [PATCH net] net: mana: Sync page pool RX frags for CPU
Message-ID: <20260619090514.GT827683@horms.kernel.org>
References: <20260618035029.249361-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618035029.249361-1-decui@microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11643-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E200D6A4D9A

On Wed, Jun 17, 2026 at 08:50:29PM -0700, Dexuan Cui wrote:
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
> Also validate the packet length reported in the RX CQE before using it as
> a DMA sync length or passing it to skb processing. The CQE is supplied
> by the device and should not be blindly trusted by Confidential VMs.

I think this last part warrants being split out into a separate patch.

> 
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

...

