Return-Path: <linux-hyperv+bounces-11866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kvwAI4AvTmp3EwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11866-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 13:07:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11904724A8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 13:07:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=tCAc3fIZ;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11866-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11866-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF42311950B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3F37C11F;
	Wed,  8 Jul 2026 10:55:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53042A14D;
	Wed,  8 Jul 2026 10:55:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508150; cv=none; b=pFQO5euW8R+Re3CfzJ870+Z7r2dKPhtWZuYXbwzE3f4rdZsIQ04OGyOM3ausFle0uRDXRj2ZEuW6WyoQ3AW9uWFMbA+qNH6kck2iLDbeemfSl4KwmAYqmfSZeESClnKyTB9+OqSH3wq0d4VSY0ce3sdYEZvqrHEr3A4InAkj90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508150; c=relaxed/simple;
	bh=qL5AoQWnmR8UHjuBrRtRjyT4/A5GEH2c5u/W5QQRlGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc511vwCbjK7c5+cAv9YU+A46aGgPJJSoiO1KCJlUDCOUquj241SlqdXI/wvpV9Z3yk2ctQwLASPFCCvbH6ShwDSbQaB/ROCQc0iFPsM70ilPfvh/YEg/ioYGh5uW8/24yfiZQItyl3yZau/oNLJuQuAj1ogGNgS33pyr/JtDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tCAc3fIZ; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0625E20B7166;
	Wed,  8 Jul 2026 03:55:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0625E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783508133;
	bh=GQohfw83Lg3P2fJ0nv7+m+KPFTUocHs75c6ito6ahRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCAc3fIZqXsGm4KISNSDZMU0aaeAP+3BkwCgdsoE/uOzAQO4HUdBA5JbNNyxk5q3Q
	 RTMnWA7X+U9YjewCB+tPEXxzaGCGFMMMwGljsP7FS0+FgaVauKvde7walIazRLM+Yy
	 OArMljp+qHICnicOoc/E+6yMUBxN06Tpkv/fC37E=
Date: Wed, 8 Jul 2026 18:55:35 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, 
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	longli@microsoft.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org, 
	robh@kernel.org, arnd@arndb.de, jgg@ziepe.ca, mhklinux@outlook.com, 
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com, 
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <t7ghdzre3gbxgfu2d7jt2hc6ktofm3n5ifvzzjmh6wzlqlbrv6@bzyl3xepeith>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <20260706095510.00007ce1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706095510.00007ce1@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jacob.pan@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:mhklinux@outlook.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11866-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,outlook.com,linux.microsoft.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11904724A8C

On Mon, Jul 06, 2026 at 09:55:10AM -0700, Jacob Pan wrote:
> Hi Yu,
> 
> On Fri,  3 Jul 2026 00:05:17 +0800
> Yu Zhang <zhangyu1@linux.microsoft.com> wrote:
> 
> > +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct
> > device *dev,
> > +			       struct iommu_domain *old)
> > +{
> > +	u64 status;
> > +	u32 prefix;
> > +	unsigned long flags;
> > +	struct pci_dev *pdev;
> > +	struct hv_input_attach_device_domain *input;
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct hv_iommu_domain *hv_domain =
> > to_hv_iommu_domain(domain);
> > +	int ret;
> > +
> > +	if (vdev->hv_domain == hv_domain)
> > +		return 0;
> > +
> Is this needed? seems the core code already skips same domain attach?
> i.e.
> 
> static int __iommu_group_set_domain_internal(struct iommu_group *group,
> 					     struct iommu_domain
> *new_domain, unsigned int flags)
> {
> ...
> 	if (group->domain == new_domain)
> 		return 0;
> 

Thanks for catching this, Jacob. Will remove

B.R.
Yu

