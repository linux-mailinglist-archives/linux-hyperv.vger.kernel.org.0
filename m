Return-Path: <linux-hyperv+bounces-11070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCYfI9MXDmpT6AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11070-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:21:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D75997B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1DC83144157
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 18:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDB3F9296;
	Wed, 20 May 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GMSX5ZVz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F863F660B;
	Wed, 20 May 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301632; cv=none; b=MJ8IKYEw8kh4NEU2TPb37nG1XzEEZCu0lcwGf/Oqjf7cjq1gLJpMBGODjoZYFIiQ5IrD04x682j0DlalllwfzkbLkoQ8Gv5C9/IOPJXUgfqEkAYIceZES2zH7jaiA1suomGwE5ewObvj7OUgPg35CVW1p7SwFhxXZ+8ZRzjGMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301632; c=relaxed/simple;
	bh=fTdmivmwVagTXRKs9Rs6wXSEQpi13QJ4Juq0z4rNBx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF+qmdTwYM5kReIOWXWgPgO9BribQ7Rtt/KHpN2urJCzvCeWeNn5AM9kiyd5O+Fg+WrP1VbgtjV8rOKhw5mIz9ukFfy+JHe4AYEG8zHMTTDlM9oP4AD9YBxT/gchQ18gaQ5B0swct1UyzAN9Du0FnhsTE6hVgQjOt7UeYI7IfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GMSX5ZVz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 301DE20B7167;
	Wed, 20 May 2026 11:27:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 301DE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779301623;
	bh=uYPToCkYVV4AyipGNqeIKkJ9ehryN1iaVuRL+SUlIkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GMSX5ZVzpdCJ7txbFSiQ+RgeIwjW5AC2umvJEC0SXJ4sxH+qfUNon5JMe8Ov7Big0
	 ns9NCzb3OoloVQ3onUvHqIbOtkfkeXz9hsZnpwaPGgoSZWYASKIUjkPhXSrLpxcxzD
	 V5idt0yY21CoiGef7e5fCp8Ewm+XmcWc6ZZENgXw=
Date: Wed, 20 May 2026 11:27:08 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
 lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org, arnd@arndb.de,
 mhklinux@outlook.com, tgopinath@linux.microsoft.com,
 easwar.hariharan@linux.microsoft.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260520112708.00003640@linux.microsoft.com>
In-Reply-To: <yqhb6vxoovscvfafgv6i6zn7uydpfxeff7hqmvbn6z7c2tjqp6@jn2vvtxqgfef>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
	<20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
	<20260515223139.GK7702@ziepe.ca>
	<yqhb6vxoovscvfafgv6i6zn7uydpfxeff7hqmvbn6z7c2tjqp6@jn2vvtxqgfef>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11070-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[ziepe.ca,vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: B60D75997B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yu,

On Wed, 20 May 2026 23:25:43 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> > > +static const struct iommu_domain_ops
> > > hv_iommu_identity_domain_ops = {
> > > +	.attach_dev	= hv_iommu_attach_dev,
> > > +};
> > > +
> > > +static const struct iommu_domain_ops
> > > hv_iommu_blocking_domain_ops = {
> > > +	.attach_dev	= hv_iommu_attach_dev,
> > > +};  
> > 
> > Usually I would expect these to have their own attach
> > functions. blocking in particular must have an attach op that cannot
> > fail. It is used to recover the device back to a known translation
> > in case of cascading other errors.
> >   
> 
> For blocking domain, the hypercall handler of such attach essentially
> disable the translation and IOPF for the device.
I think this should disable all faults, including unrecoverable fault
reporting. right?

