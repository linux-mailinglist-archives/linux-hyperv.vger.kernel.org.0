Return-Path: <linux-hyperv+bounces-9965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGZJMdr2z2lT2AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9965-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 19:20:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCA396EF7
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBF730692F2
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E73D3CEA;
	Fri,  3 Apr 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KSHb6Glr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0B313298;
	Fri,  3 Apr 2026 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236621; cv=none; b=TLa4mECPw9232PahxM+CWOjZhVMBMbJa1cwVSztReuJoGytQwtlG7bakGuZElm57XvAEj11CyxKmozHpvgLe8rx4IZfO0kzyc6jpo2ZVwc6vN2hqmWZi5YGriMh2mfba7jtFFUMm7OmcIJI0zsIm67Rwzd75+DzOHvkmnp1prrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236621; c=relaxed/simple;
	bh=By9EQpNCDpp6s2NYHjtZqT1nhJ8CR8Y2CKPeiQPRZwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzwuI3YiQVx1LJZDwocccvUhzqFcd9siI/2iub2p63cqQvfi5Q/9Oe3xUWG9i8g7z570b1DmlGWXeiHPW8x/XBhQ7wOZuSWenTF2R2lJUGaGbrL9AtGve3LOfBLUpqlAwZKKxBdhdBcPXZn2VVsyoNCWtszYkrTDuy7t4JK2h+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KSHb6Glr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C975720B6F01; Fri,  3 Apr 2026 10:16:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C975720B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775236619;
	bh=kh5ou9R6vorVFKGIjYV/L1uLTk5ZwMi2N5RzFqNbU74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSHb6GlrE+oMlnijn2yddWJvQl4JlPLJPvGgrzNN9VpDP8m8olNJC1Ze0Q2l7fMAL
	 2phDY5wnNto5r5I7PxwqYV2sRrc6nKhAeAhNclPw/n4fmIS6oDQ8Mex6D5j9WY29U/
	 naca6YQjgLNdFhb+sC39IFbdc1TmOU3KQVoIfsWM=
Date: Fri, 3 Apr 2026 10:16:59 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dan.j.williams@intel.com, mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix double ida_free in hv_pci_probe error path
Message-ID: <ac/2CyhuZhWa8ctW@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9965-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,google.com,intel.com,outlook.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ssengar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ADCA396EF7
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

LGTM,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

