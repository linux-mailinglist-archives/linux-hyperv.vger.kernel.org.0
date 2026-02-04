Return-Path: <linux-hyperv+bounces-8712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEdDJKA9g2kPkQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8712-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 13:37:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC16E5E20
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A8C73007536
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1ED330B28;
	Wed,  4 Feb 2026 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2jf+8k8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA124DFF3;
	Wed,  4 Feb 2026 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208642; cv=none; b=FbNJJaTTBbeUne948Y2nC0s844sOi134iAKkrWqvu/PEvkPdzje797R43fC7iRqXo86JORHteBgHWqjFrLeOW98+eE3ZRgm1ghtLTPuv1xVq4TTWZm/RyvCj821QToDtUa5f8/m4ATncELXDX8mQpOutc9lCtLeB6ubz9snAL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208642; c=relaxed/simple;
	bh=Lfgz74GJBh4i45yr3gf/Dl4spcDUF4yt2tlV2Md+WfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1K5XxEnNh8Bkd23aN23JxO3JJ+n9cNJEcr+aey49zSwwgStsXj3NgUw6UD4XTifXNp/IrADLi0yPK6E2OA1+R2ox59kDnAtixvBzwSgKYlRJ4zh3i6yiRDk579PF8UiErbmWlCJw5Dfa11xaBdmUsC216QIT/LZwrnBFhg4vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2jf+8k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDC4C4CEF7;
	Wed,  4 Feb 2026 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208642;
	bh=Lfgz74GJBh4i45yr3gf/Dl4spcDUF4yt2tlV2Md+WfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2jf+8k8tcXxUA7YJYZEDqsCxnprbeRB+aJJuJ9HR7+qYJ7VDGPbJ1RzacSbXgIi6
	 uD1o5tnn4HE95PzIhiIp5mO+Sozrs9HlzcHy2rSxbTET7HZfLcbG9hE2uugx6rDP1g
	 SHvfXC4pixyC7ABhyZ0HXc9quCPy+R/Uttw4f8BA9zbK63AeixkVW8jez324J/7/Q1
	 3CLQaUb2oyY/+eHLPN0GXHWuvcexcg8su2qYbwEJGBXhPp9QZuFrOEg/uXfEZaQ0Du
	 swWsYwBfJSgbFWoS52t8/VUff34terAi/vBX9DVAMBH2pY64Y0jo+oacXsu4XGidyI
	 CaQxJCNGY4mwQ==
Date: Wed, 4 Feb 2026 18:07:08 +0530
From: "mani@kernel.org" <mani@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Message-ID: <lorhokiggjgxr7ghisdijmn5n2d27ezgxckr6m4yfbx2j3egro@ak3ikbgapaf5>
References: <20260111170034.67558-1-mhklinux@outlook.com>
 <SN6PR02MB41575DE702FAF2BCE5FD38CFD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB41575DE702FAF2BCE5FD38CFD49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8712-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FC16E5E20
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:35:29AM +0000, Michael Kelley wrote:
> From: mhkelley58@gmail.com <mhkelley58@gmail.com> Sent: Sunday, January 11, 2026 9:01 AM
> > 
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > Field pci_bus in struct hv_pcibus_device is unused since
> > commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> > 
> > No functional change.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Could a PCI maintainer give an Ack for this trivial patch?
> 

I see this got queued by Wei Liu, but FWIW:

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Thx, Michael
> 
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 1e237d3538f9..7fcba05cec30 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -501,7 +501,6 @@ struct hv_pcibus_device {
> >  	struct resource *low_mmio_res;
> >  	struct resource *high_mmio_res;
> >  	struct completion *survey_event;
> > -	struct pci_bus *pci_bus;
> >  	spinlock_t config_lock;	/* Avoid two threads writing index page */
> >  	spinlock_t device_list_lock;	/* Protect lists below */
> >  	void __iomem *cfg_addr;
> > --
> > 2.25.1
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

