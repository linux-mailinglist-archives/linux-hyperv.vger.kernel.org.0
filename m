Return-Path: <linux-hyperv+bounces-9979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE1/DmGf0Gno9wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9979-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 07:19:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5D399FEA
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2E8302D133
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F330BB91;
	Sat,  4 Apr 2026 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejcCGfKO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF61AAE17;
	Sat,  4 Apr 2026 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279960; cv=none; b=IVYfsKyUf9POwOv/Uj1lP+NaBnGZ4FIUc3nYKpW7Ez1eQ3BkvIFf5ckveIuGzJTt3s7XRAjnUJcm54UCWlwIA8V7i8S/9HuwpPdf3VUlyB5IsUGMWmQRR1jroXjm5dMx/iQ1yBB4vRoyRFc1Gq7SNdhm616D/LncDGoV2MB5i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279960; c=relaxed/simple;
	bh=9SlzOaOIuzawtKONvOgwkbzTlgoXVR5XMlVH/UJnXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN/0/vGo5+wpEnlCaMv2CY3NmDl1qoNdnr41PKcmAqr1S0clM3PTs1WlEMkA9lepSrfg7hesu7VzOlFMIRNy3jxCsiP9PPxEYYTElzBYmj/6gNB40h5XsXOsiHCzdY+g8IGbcHOuoI2s2qcw9W2056qlEcgV2Zr+xS0wJ6DyQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejcCGfKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BF2C19423;
	Sat,  4 Apr 2026 05:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775279960;
	bh=9SlzOaOIuzawtKONvOgwkbzTlgoXVR5XMlVH/UJnXDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejcCGfKO6vS/q7d6zdf5ihWo3GdmeBVK7g2Jlw1ZXdIdcbK5FLIEg7bG68VaFE3+G
	 ioA8EMeaXCl1bnuXuUkN43VPY3vr9jG9lN3TWXTZiVslmwnOIT7qP6qp/sKIjqUA8V
	 gL5777zY7o5l5xFCnsouksMKn/yu5bKebN6DF+NwY9uwRWj4kvEp7UCnS1QZCg3rRZ
	 rL37oyQ9xdV5MVWXnRrXHAVrD79i7elZjQWOV5M1LuakH1+ylkTkrs8aadcw2WFZhT
	 DZbPIsU/CKrg1xBdTZtqloVgc927DxeHgEqdEfivTlj0qlQzzPg0We6uvAOmCGlh/L
	 9te8zRYTJWGJg==
Date: Sat, 4 Apr 2026 05:19:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sahil Chandna <sahilchandna@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, dan.j.williams@intel.com,
	mhklinux@outlook.com, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix double ida_free in hv_pci_probe error path
Message-ID: <20260404051918.GA60588@liuwe-devbox-debian-v2.local>
References: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
 <v7l3vghep7h52f3qyoxdbqzu6un5vhio3njy4u46wjrqzhrrvx@hl5imwzjwocf>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v7l3vghep7h52f3qyoxdbqzu6un5vhio3njy4u46wjrqzhrrvx@hl5imwzjwocf>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9979-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,kernel.org,google.com,intel.com,outlook.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5C5D399FEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 08:12:36AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Apr 03, 2026 at 05:09:29AM -0700, Sahil Chandna wrote:
> > If hv_pci_probe() fails after storing the domain number in
> > hbus->bridge->domain_nr, there is a call to free this domain_nr via
> > pci_bus_release_emul_domain_nr(), however, during cleanup, the bridge
> > release callback pci_release_host_bridge_dev() also frees the domain_nr
> > causing ida_free to be called on same ID twice and triggering following
> > warning:
> > 
> >   ida_free called for id=28971 which is not allocated.
> >   WARNING: lib/idr.c:594 at ida_free+0xdf/0x160, CPU#0: kworker/0:2/198
> >   Call Trace:
> >    pci_bus_release_emul_domain_nr+0x17/0x20
> >    pci_release_host_bridge_dev+0x4b/0x60
> >    device_release+0x3b/0xa0
> >    kobject_put+0x8e/0x220
> >    devm_pci_alloc_host_bridge_release+0xe/0x20
> >    devres_release_all+0x9a/0xd0
> >    device_unbind_cleanup+0x12/0xa0
> >    really_probe+0x1c5/0x3f0
> >    vmbus_add_channel_work+0x135/0x1a0
> > 
> > Fix this by letting pci core handle the free domain_nr and remove
> > the explicit free called in pci-hyperv driver.
> > 
> > Fixes: bcce8c74f1ce ("PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms")
> > Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Wei: I see that you've taken previous hyperv patches. So feel free to take this
> one also.

Sure. I will pick this up.

Wei

