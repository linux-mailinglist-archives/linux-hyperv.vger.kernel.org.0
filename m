Return-Path: <linux-hyperv+bounces-5493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FCAB5A74
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEDC1693C9
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83811DF73A;
	Tue, 13 May 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edjxddpo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953681DDC28;
	Tue, 13 May 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154709; cv=none; b=BLmku2NEL3eK5elc+e5yy7U67WdaXrbkqxGsKQFmPN2EzagJvMw/PEJBA/ejs9ENZ0TyEzMZNH4xRzcu6IJgWi1Xs7JegHTg/0icGxsi0E2DIo9Xd5CXX1xoAGav5U2U7ckeP2T5nfq0soX5r328ngmgGdvpFBXcgYCRwhEcOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154709; c=relaxed/simple;
	bh=9qNt2vvTJ8vncwwFBakHVgY0+vXZKoSXtrmG1BSclXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En2S/0MZDO4dn5TGaradHI+iiGt4tkawVJyo3nuzqOViv6FAPEz8hLKbml6WeCdb1b89AuS9e/SR4wBbNV6pXg5Tfr0MXX561BmJTvoMvw3gyaMKiGSYY/mP/SdR7XRV2FBqFFnrRUAzJnlzNQchPkXkMXfW18zuosS6vJajn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edjxddpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBC7C4CEE4;
	Tue, 13 May 2025 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747154709;
	bh=9qNt2vvTJ8vncwwFBakHVgY0+vXZKoSXtrmG1BSclXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdjxddpojJLkHNXEKf4SNDvhSbdPn4MGNdTfRNKe6PNXXYUIC7NTLm2hMYj2Z5/6y
	 WqQ0FoQDs4UMpOgrmLdwyMvOo2OZRj9u745CBFtKXaXs0TChFW9KqVYNLF36kKc1+k
	 hHbWGRrx+jQmrPneAzC1aM6/INbcK/X6WPCi9DYpPiy7J5EIYv97PSuCAaFURLMn3W
	 R/ofKjCnMvgknvFJz7eolbYdlOcEjhry+XCLDGz4z91Rr4y9/vWjnzGoVsfP5x0MIp
	 ud+NFf8ABf57KuUncbjMiaFV4WqMjKyjjHC0QE8meIYRHM2YfK+ZvcPurMNmbGmAet
	 xpA7gEp4Lv9VA==
Date: Tue, 13 May 2025 16:45:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] PCI: hv: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aCN3E7pQc5UHJ-4w@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <aAu8qsMQlbgH82iN@kspp>
 <SN6PR02MB41574AAF7B468757A9F9ED79D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157E7C91785BEA1E597B0EAD496A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157E7C91785BEA1E597B0EAD496A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, May 13, 2025 at 02:07:45AM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Sunday, April 27, 2025 8:22 AM
> > 
> > From: Gustavo A. R. Silva <gustavoars@kernel.org> Sent: Friday, April 25, 2025 9:48
> > AM
> > >
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > >
> > > Use the `DEFINE_RAW_FLEX()` helper for a few on-stack definitions
> > > of a flexible structure where the size of the flexible-array member
> > > is known at compile-time, and refactor the rest of the code,
> > > accordingly.
> > >
> > > So, with these changes, fix the following warnings:
> > >
> > > drivers/pci/controller/pci-hyperv.c:3809:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:2831:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:2468:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:1830:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:1593:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:1504:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > drivers/pci/controller/pci-hyperv.c:1424:35: warning: structure containing a flexible
> > > array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > I'm supportive of cleaning up these warnings. I've worked with the pci-hyperv.c
> > code a fair amount over the years, but never had looked closely at the on-stack
> > structs that are causing the warnings. The current code is a bit unusual and
> > perhaps unnecessarily obtuse.
> > 
> > Rather than the approach you've taken below, I tried removing the flex array
> > entirely from struct pci_packet. In all cases except one, it was used only to
> > locate the end of struct pci_packet, which is the beginning of the follow-on
> > message. Locating that follow-on message can easily be done by just referencing
> > the "buf" field in the on-stack structs, or as (pkt + 1) in the dynamically allocated
> > case. In both cases, there's no need for the flex array. In the one exception, a
> > couple of minor tweaks avoids the need for the flex array as well.
> > 
> > So here's an alternate approach to solving the problem. This approach is
> > 14 insertions and 15 deletions, so it's a lot less change than your approach.
> > I still don't understand why the on-stack struct are declared as (for example):
> > 
> > 	struct {
> > 		struct pci_packet pkt;
> > 		char buf[sizeof(struct pci_read_block)];
> > 	} pkt;
> > 
> > instead of just:
> > 
> > 	struct {
> > 		struct pci_packet pkt;
> > 		struct pci_read_block msg;
> > 	} pkt;
> > 
> > but that's a topic for another time.  Anyway, here's my proposed diff, which I've
> > compiled and smoke-tested in a VM in the Azure cloud:
> > 
> 
> Gustavo -- Are you waiting for me to submit a patch with my alternate proposal?
> I had not seen any follow up, so wanted to make sure we have clarity on who
> has the next action. Thx.

Michael, I prefer your approach. Please send a patch.

Thanks,
Wei.

> 
> Michael

