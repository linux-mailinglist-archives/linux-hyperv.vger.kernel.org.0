Return-Path: <linux-hyperv+bounces-10408-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFZrI2Lv72nYMgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10408-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 01:21:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C447BC2F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 01:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF80330068E7
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6013AE6FD;
	Mon, 27 Apr 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEdcdVm7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED243221FBB;
	Mon, 27 Apr 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332063; cv=none; b=k2o9YoIrATvuJlnsr8gsx4+cA18NdwGkj2K1OqLZ0klYUCak6AYj5f3MLCCUFKKzpzeEcTAzTeJWittxDIRsXMg09rFzQb28Aln4TRVhN6Q0yDy08nhqZFzLCOBa9NkHbbEx0JtlM6/VRO2Ur/CgllXOfVD7yYboimALt3u9cT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332063; c=relaxed/simple;
	bh=kJhtciu421O7ueHQhqPqW6F64apq6WD9S/98PUZ0xhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrxSjfwKtVMhpMckRMEjpytiZa9SmP7RhcJ61lV8bYB3Y+O/gITKsEPx9JwgzB/Rql0r8Aopj76NQ5pyNPUbz7fTV8Y71VVDCx0469uFjjvt8KjLbWwi8Q0O2MMvVXqv9C07ZNzC1AxLZHJQdtMj+4oBfl/c+IcbhkfyXV76WIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEdcdVm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B83C19425;
	Mon, 27 Apr 2026 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332062;
	bh=kJhtciu421O7ueHQhqPqW6F64apq6WD9S/98PUZ0xhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gEdcdVm7xpKZrEsM+oT2xb2RFKvUXaok9tghYeXA7iP9kB7K+w2s4DbBe5oKKUfrv
	 fF1d5+1vlcDyPNI6YZtxo4SbLgqcQWZUK4SpZ9ogkpIP8TSoG8nXgzSDFKuLAkZHWL
	 NSaClz1SmkpxtucZOHTWV7GVqFYV/rTUWOqZd6X/NjG/5+94iIk1kXL9FA2lWrM24d
	 xgEFYhLjplK8N3sN8lH2QDc72BGF1pmwJPXjQy7WCRrOkunQmRQxnsypD1sK8vz03x
	 73ppN0ijH8W7S+/IIN/Hd6YbRGLx3ZV/pZv4h+tvRA0sXDDtVJKKrlXaMGkHT0LxO8
	 5q1Wa9usw9fJw==
Date: Mon, 27 Apr 2026 16:21:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com,
 dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH net-next] net: mana: Force single RX buffer per page for
 CVM/encrypted guest memory
Message-ID: <20260427162100.5f731228@kernel.org>
In-Reply-To: <ae9pxvJfkAZYfKMf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <ae9pxvJfkAZYfKMf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C2C447BC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10408-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 06:51:02 -0700 Dipayaan Roy wrote:
> When page_pool allocates sub-page RX buffer fragments, the bounce buffer
> granularity may not align with these smaller fragment sizes, leading to
> failure in mana driver rx path.
> 
> Refactor the RX buffer decision into mana_use_single_rxbuf_per_page().
> When cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) is true, the driver is
> forced to use a single RX buffer per page. This ensures:
> - Each RX buffer is exactly one PAGE_SIZE.
> - The DMA offset is always 0.
> - SWIOTLB maps full, page-aligned blocks.

As commented on your RFC - I'm not sure why you need this.

