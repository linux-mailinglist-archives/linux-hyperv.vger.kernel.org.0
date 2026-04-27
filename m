Return-Path: <linux-hyperv+bounces-10396-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C4KGsGR72nRCwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10396-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:41:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989A476929
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63238303C4E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122933CF042;
	Mon, 27 Apr 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkE6XZt8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE33115AF;
	Mon, 27 Apr 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307730; cv=none; b=sVkkfho8yV7V+HdABM/TeS1B7U5zvBbyuEm0AvlxfyThD1jekK8PbrExBWpuSzJNN5Dkd5BC0CiAkR+eyz/jliWTDX/mjXOpLAIdu61A+boQXIJfbFy/FRRUsEPqUnaNrDMsF97x+e1u4cHgUQ03iPtVJx6CeuPuBR81mgiaqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307730; c=relaxed/simple;
	bh=D3D5ZZ3ICOyCwBz++60Gx9PYVYCei1edKRjnHNhau8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DPZKGGWuI0U2mNQ//f7ucIQs6McBnlQYQV8pmTzQMHpt12En4sx/mWROmjOQAvzI8Vc6FQkkGTlkFAhEB8cJZQtZgZp3HcXIobBoDjgKJ3EaWHa/zWU2KMBiftm3/uIqjddxrfRBqWFPM2sFri0rgTqVdn+e+o9n1cF9Lv1WjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkE6XZt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CB6C19425;
	Mon, 27 Apr 2026 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777307729;
	bh=D3D5ZZ3ICOyCwBz++60Gx9PYVYCei1edKRjnHNhau8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hkE6XZt8XlkF9Pl+/DKL+h1M2/OBgmIGmrTamJYq4zg0NRNh09iG+ffmtgSIiTt/s
	 QxnCJFxLfqKXpsegisI8568lfRK+7NLxOamENBPDafwtwVoCpqJE9gluIaM3Km0zk6
	 szmlEsSAOlXnQQZOAkpOSYc3/8/KWbjKaR+VH5ZG5gX51a/kDhiX3/iFc0/G3qNLGV
	 yPSukJZ4OKBspyQTy5VfVaD5EULjHkQ4VffAY81658RXMhYbgX4t9lX93m/eRJGPKd
	 TU8txvGd1RE6vFslhO98xzDuKnpympyMWH7mutYvYeQVXAAdgGKR/IeQCf9LGRclEv
	 JcFZhkpaDgyjg==
Date: Mon, 27 Apr 2026 11:35:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 10/13] PCI: hv: Build device id for a VMBus device,
 export PCI devid function
Message-ID: <20260427163528.GA156670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-11-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: 0989A476929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10396-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 07:32:36PM -0700, Mukesh R wrote:
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device id as a parameter. This device id refers
> to that specific device during the lifetime of passthru.
> 
> An L1VH VM only contains VMBus based devices. A device id for a VMBus
> device is slightly different in that it uses the hv_pcibus_device info
> for building it to make sure it matches exactly what the hypervisor
> expects. This VMBus based device id is needed when attaching devices in
> an L1VH based guest VM. Before building it, a check is done to make sure
> the device is a valid VMBus device.
> 
> In remaining cases, PCI device id is used. So, also make pci device
> id build function public.

s/id/ID/ throughout, including subject line, since "id" is not really
a word by itself.  Well, it *is* a word, but not the one you want here :)

s/pci/PCI/, although I would prefer if you just mentioned the name of
the function instead.  I guess this refers to
hv_build_devid_type_pci()?  Or maybe hv_pci_vmbus_device_id()?
Or hv_build_devid_oftype()?

> +++ b/include/asm-generic/mshyperv.h
> +#if IS_ENABLED(CONFIG_PCI_HYPERV)
> +u64 hv_pci_vmbus_device_id(struct pci_dev *pdev);
> +#else   /* IS_ENABLED(CONFIG_PCI_HYPERV) */
> +static inline u64 hv_pci_vmbus_device_id(struct pci_dev *pdev)
> +{ return 0; }
> +#endif /* IS_ENABLED(CONFIG_PCI_HYPERV) */

IMO the "IS_ENABLED()" comments here are just clutter since it's only
six lines and it's obvious what the #else and #endif belong to.

