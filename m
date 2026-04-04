Return-Path: <linux-hyperv+bounces-9978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NOrGCa560GlO8AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9978-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 04:42:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 724CB399AA2
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 04:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DF4301FF92
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD0241665;
	Sat,  4 Apr 2026 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKrjXe2R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3750276;
	Sat,  4 Apr 2026 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775270569; cv=none; b=gTXYuPiYvstZuoPK87LggbL2ZquzWEQLQb41uzJgtr+vyOlc1bwG97bBCZQlXOXznOSu+VMnEqRKm2k8dx/82CaYFEhaL0Z4P/vbm5mymrKImpC8ltUPpAd7wQubayVKjgnv8jqHG1k+OQxXP6MbjxGUhNGiIlcCi3NhzE11fvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775270569; c=relaxed/simple;
	bh=QqB5bvrRBlRYHAkjrmkAS8KiUZry2YuTWlK/boc4+l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B70pJppxEDiN8oIUcyQsrVICQW4m6ZPNNhw/kjQkY4CcRrcy6ndB60RKsc+mJ0zqPZfPQmeduRQ7F1lD0e9tH5R0WjiHQwgyHJ7axM4JPJW48k2A0/YlwlKy14PZ5D6Qky+VZeNzZlIRCu+R9NKSR8g0gUocmKAsQvElMZsD6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKrjXe2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1300DC4CEF7;
	Sat,  4 Apr 2026 02:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775270569;
	bh=QqB5bvrRBlRYHAkjrmkAS8KiUZry2YuTWlK/boc4+l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKrjXe2RhKmkPs+6ix9VLYcP9aXOzxv+/fX2WnlKuROyMr9KYeBKpu89wU6d09LHh
	 18rRiLv+q4akjmJFxXcYQgp8gv9PeQ2pCkKxOTIBMkeQxUskmyBjRdtbuy45wW+ON1
	 VRSdKIX+KSDPF+bgE2/TWfTMVnmfL+6O0LxCbtrY+W9KE6hM4Jmri5QWhucr7R4d7f
	 FSHeTgKBLOSxM5ELXotudZdN2dY2ph58/9IuxVyhGuoXLk4QYdZTmuipyvfLVR19wx
	 IfJd0AVXgiocylxxZUqiaK+iygFh28KxPz7aBsJtxGMTKZRxNTVZGcHI2DnyDbrW9+
	 1DJVYe79aSOnA==
Date: Sat, 4 Apr 2026 08:12:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, dan.j.williams@intel.com, 
	mhklinux@outlook.com, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix double ida_free in hv_pci_probe error path
Message-ID: <v7l3vghep7h52f3qyoxdbqzu6un5vhio3njy4u46wjrqzhrrvx@hl5imwzjwocf>
References: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9978-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,google.com,intel.com,outlook.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 724CB399AA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:09:29AM -0700, Sahil Chandna wrote:
> If hv_pci_probe() fails after storing the domain number in
> hbus->bridge->domain_nr, there is a call to free this domain_nr via
> pci_bus_release_emul_domain_nr(), however, during cleanup, the bridge
> release callback pci_release_host_bridge_dev() also frees the domain_nr
> causing ida_free to be called on same ID twice and triggering following
> warning:
> 
>   ida_free called for id=28971 which is not allocated.
>   WARNING: lib/idr.c:594 at ida_free+0xdf/0x160, CPU#0: kworker/0:2/198
>   Call Trace:
>    pci_bus_release_emul_domain_nr+0x17/0x20
>    pci_release_host_bridge_dev+0x4b/0x60
>    device_release+0x3b/0xa0
>    kobject_put+0x8e/0x220
>    devm_pci_alloc_host_bridge_release+0xe/0x20
>    devres_release_all+0x9a/0xd0
>    device_unbind_cleanup+0x12/0xa0
>    really_probe+0x1c5/0x3f0
>    vmbus_add_channel_work+0x135/0x1a0
> 
> Fix this by letting pci core handle the free domain_nr and remove
> the explicit free called in pci-hyperv driver.
> 
> Fixes: bcce8c74f1ce ("PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms")
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Wei: I see that you've taken previous hyperv patches. So feel free to take this
one also.

We will be proactive from next release onwards ;)

- Mani

> ---
>  drivers/pci/controller/pci-hyperv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 2c7a406b4ba8..5616ad5d2a8f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3778,7 +3778,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  					   hbus->bridge->domain_nr);
>  	if (!hbus->wq) {
>  		ret = -ENOMEM;
> -		goto free_dom;
> +		goto free_bus;
>  	}
> 
>  	hdev->channel->next_request_id_callback = vmbus_next_request_id;
> @@ -3874,8 +3874,6 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	vmbus_close(hdev->channel);
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
> -free_dom:
> -	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
>  free_bus:
>  	kfree(hbus);
>  	return ret;
> --
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்

