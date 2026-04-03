Return-Path: <linux-hyperv+bounces-9947-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPK0Jyc6z2lcuAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9947-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 05:55:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A525B390BE6
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 05:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 980473007A73
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D524A076;
	Fri,  3 Apr 2026 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="xprbPmqH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111E1DF27D;
	Fri,  3 Apr 2026 03:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188513; cv=pass; b=Il9h2/1CGUakas4T7MAmJttNAo3WuFKEUDFVpYgH63HqjcVaBU6Lez5LCbu3aMGusuI6+rTGb/JjoVlTNIfxGVuS1px3t3y1a5r2Zv3937H0ItblZF4Muw8OV9zC1wdA48ZiOA+rMYynIqIURbx7ESa6dA/QqnrL9Kl8SaKq+OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188513; c=relaxed/simple;
	bh=gzIH/Itt04VrTJtOZkXL/TD7+2TYvSq/sxPCsvim8lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKQdgjAsl7y6XC9b/edtYplzhYw157+Bj0ktByegSIL6Bvtm2nvv0UmF81oiEx095T74BXqJKLZ3gJn5ScZKqaS4kPS378mSTlcq4VLbaMrBJ2/tXGeWP7r3VdVTVTi5g0uCVoQNVKUDmmV4qpt+F4KU9P+uUmgBvMDDi6iWdRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=xprbPmqH; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775188501; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YEVQs4c001kX2JpJO4s2egHsoHs4JpkPwg+9ML1T6xAFWuUL/9Np7MJh4u01ZLP15uzdSd7uaXSSNqTE+7h081BKMOp0XkMPzHHrqKXvkfhtTs0ZLBdMi43CrjYzGlX0azPV6jUw0Wu7kkFJFcFmiBRW6WizDDAPusTBgCKl37U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775188501; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WlzpJL74AylohI4cEePkrA4CJGbla5nlVC5YnW213Yc=; 
	b=ntVK+1Kx1LW8M5r06rDqtXSBDotuErqkYc2HH/RAGnhfF/jO2WVOFCAvkWgbDJzZff/uUkLDpbHtsHdr07iPKplLHyOAF/ThTd90Hmfay4f6sOebGN3D+F8byrZhUH9HiZIFNqeRwU5ABUx9mS8P/DbYkQkt8t8+vYDYUW1VhTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775188501;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WlzpJL74AylohI4cEePkrA4CJGbla5nlVC5YnW213Yc=;
	b=xprbPmqH0+eZEa2RPCL+3mhVuayiEaRRJWRxncj479v5nt5z5aNQ8ZSuGvyc6mjS
	z/zh8oYbAyMTRy2eCoTLFgp1bdrGA9yRLTR2ZzhaR9mRbZ8qnP7rhs7whdZ9v5bpJ43
	ggVE5+oAGhMPxcHQFcbiO/JmO9rPz9fdpJfSqmWs=
Received: by mx.zohomail.com with SMTPS id 1775188498345257.967926561386;
	Thu, 2 Apr 2026 20:54:58 -0700 (PDT)
Date: Fri, 3 Apr 2026 03:54:52 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mshv: Rename mshv_mem_region to mshv_region
Message-ID: <20260403-gainful-cerulean-asp-5a1a2d@anirudhrb>
References: <177508151446.215674.7844504277869257435.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177508156067.215674.12361225930217655159.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <20260402-fervent-thick-boobook-45dba9@anirudhrb>
 <ac6t9d2CIvL469_t@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6t9d2CIvL469_t@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9947-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: A525B390BE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 10:57:09AM -0700, Stanislav Kinsburskii wrote:
> On Thu, Apr 02, 2026 at 04:33:24PM +0000, Anirudh Rayabharam wrote:
> > On Wed, Apr 01, 2026 at 10:12:40PM +0000, Stanislav Kinsburskii wrote:
> > > The mshv_mem_region structure represents guest address space regions,
> > > which can be either RAM-backed memory or memory-mapped IO regions
> > > without physical backing. The "mem_" prefix incorrectly suggests the
> > > structure only handles memory regions, creating confusion about its
> > > actual purpose.
> > > 
> > > Remove the "mem_" prefix to align with existing function naming
> > > (mshv_region_map, mshv_region_pin, etc.) and accurately reflect that
> > > this structure manages arbitrary guest address space mappings
> > > regardless of their backing type.
> > 
> > I don't think the "mem_" prefix automatically suggested the backing
> > type.
> > 
> 
> What else can it suggest?

To me it just suggested that the struct contained info or properties of
a guest memory region. The name itself didn't suggest what backing type
the memory has.

> 
> > Isn't mshv_region too vague now? Region of what?
> > 
> 
> The region of address space, which can or can not be backed by memory.

Yeah but that's not obvious just from the new name. The new name just
says mshv_region and doesn't what the region is of.

Thanks,
Anirudh.

> 
> Thanks,
> Stanislav
> 
> > Thanks,
> > Anirudh.

