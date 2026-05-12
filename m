Return-Path: <linux-hyperv+bounces-10807-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HFFqL2pmA2qa5gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10807-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 19:42:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCD525F2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A2FC300600F
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4AD3E0758;
	Tue, 12 May 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Che5QV00"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262483E0738;
	Tue, 12 May 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607717; cv=none; b=iIAekx22FMZk81TAdUnQK3QorNhcOzFXJWPpaprAKBpheQu9CVSRCZK696pdNNYdknumuZll1cqjJobXA9YKjO56Fin9JMHewXulNPtU/WSznUCflEnq0fIQwYvTg8yiBJjLlkc+cQex4VlfDK5tqozFgM56gH1bGdj+Red/gRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607717; c=relaxed/simple;
	bh=0IBJXkR3QCl3CT5FkY4S+RQddewS2cZDu4PxcyWGpoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cQzOgjFcMryBPZ2kgsQO7oEIWRmrCJsn2nIbuOL6SpzRHuO9aiX+yBchPo5p7zqlO8MsRJequwneDvfzTvhQYAa+YIVEfEo80uGony2h0fHU75RnWPmnAhU+olV+JIwGXHA4sjUFHTk63Mf1Sg7aXjkiDTQHtPFfCXRD3GOgBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Che5QV00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB22BC2BCC7;
	Tue, 12 May 2026 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778607717;
	bh=0IBJXkR3QCl3CT5FkY4S+RQddewS2cZDu4PxcyWGpoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Che5QV00iFYIcYW67C/V6FoPD/zC+BRZYm143CseiGHCH40Xv7qm9FTbs0zrB0DF3
	 YYR+GPabRRhfPzFgVXLdndX1CyXE00MYpIHkJD83f4rt2Ceris3q/PBHzFhbuSfOTf
	 /0rjfEU18/sLHQIbaLzcBmzLTcAn1OFDeU1PNxWnP2pWDlXohws/jdvOpOj1Rby1Rp
	 2JhZ9nqJkzfulFInDenjgMnCUsm0q8AaNF2Av5bl8zO6OZYRTcFO2zQEd1PZQoj38Y
	 CdMCnQXz08exHWiFqLwNVvEWRuLvsviyv/u1GaAj/jF1TGXSaRTTsrK6Tjxj2OvQlT
	 9X9vRwg1AG0XA==
Date: Tue, 12 May 2026 12:41:55 -0500
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
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 08/11] PCI: hv: VMBus and PCI device IDs for PCI
 passthru
Message-ID: <20260512174155.GA231433@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512020259.1678627-9-mrathor@linux.microsoft.com>
X-Rspamd-Queue-Id: DFDCD525F2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10807-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:02:56PM -0700, Mukesh R wrote:
> On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
> interrupts, etc need a device ID as a parameter. This device ID refers
> to that specific device during the lifetime of passthru.
> 
> An L1VH VM only contains VMBus based devices. A device ID for a VMBus
> device is slightly different in that it uses the hv_pcibus_device info
> for building it to make sure it matches exactly what the hypervisor
> expects. This VMBus based device ID is needed when attaching devices in
> an L1VH based guest VM. Add a function to build and export it. Before
> building it, a check is done to make sure the device is a valid VMBus
> device.
> 
> In remaining cases, PCI device ID is used. So, also make PCI device ID
> build function hv_build_devid_type_pci() public.

The subject line should start with a verb to help say what this patch
does.  I guess it's something about adding a function to build the
device IDs expected by the hypervisor?  Would be good to include the
function name too, e.g., something like this:

  PCI: hv: Add foo() to build hypervisor device IDs

