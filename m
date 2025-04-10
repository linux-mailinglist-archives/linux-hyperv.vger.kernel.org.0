Return-Path: <linux-hyperv+bounces-4866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DCA84A35
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C857B6479
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E6A1EF39A;
	Thu, 10 Apr 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DE5xUXEs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3B1C5D7E
	for <linux-hyperv@vger.kernel.org>; Thu, 10 Apr 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302877; cv=none; b=ojV9dAfEpnz0trG4Lta7/qtWdZ+0Kvo2jUfU5/m9YArcwsknAs+G4x3urjk9Pjozco4bKORUSVZ2rZzkBJautzRJGENnwnaf2lJUMoNVof443CLgFAjavJoC9ZTpwrYgZj2+7fabh1SkM30GIZps0CskoKFl335KshEKdnhoTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302877; c=relaxed/simple;
	bh=GGlwuqZ8KgQv3VuocjO6hityEN9Tl7jKH7yqFq2v2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcUOoxMU7nltGWXpMCDqf8/FRa6fo8a3wWaIAgCBO7zYcY9CCNv0Fz2Q792oaC/9slw5uoPE+LcjETyNMg4y7oQPyzDSN4kp5S43HPl0wRCepWs5mO8Yzpe/m5a836rnyU65K0II1NdOr3X5ORbK2ykIUbO6SpSwhVcq11FY0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DE5xUXEs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8A1C121165A0; Thu, 10 Apr 2025 09:34:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A1C121165A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744302875;
	bh=uL2MVI8EPlJMTaDpvKWhLTLkSBOdXCTzDhoKO2DCtJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DE5xUXEs7yvxH2kVaaijesLOBexoxlfxU1fWPt5HChNKewQjtms9vJkLkhzsorhtE
	 djIwLbIkAa5+Y4OFJEVLabhXYBnXBnoX4TUqPQT8KH4V0j2Lua6OMCwGdYC7pDhsh7
	 F9M39y02FIcGb02vCJx862SWrk6LBjSJRBNPgkQs=
Date: Thu, 10 Apr 2025 09:34:35 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: update route parsing in kvp daemon
Message-ID: <20250410163435.GA18846@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241202102235.9701-1-olaf@aepfle.de>
 <20250408062057.6f5812d3.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408062057.6f5812d3.olaf@aepfle.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Apr 08, 2025 at 06:20:57AM +0200, Olaf Hering wrote:
> Mon,  2 Dec 2024 11:19:55 +0100 Olaf Hering <olaf@aepfle.de>:
> 
> > After recent changes in the VM network stack, the host fails to
> > display the IP addresses of the VM. As a result the "IP Addresses"
> > column in the "Networking" tab in the Windows Hyper-V Manager is
> > empty.
> 
> Did anyone had time to address this issue?
> 
> 
> Olaf
> 
Hi Olaf,
Wei's message for a review and quick test, somehow got missed by me.
Let me get back to you after a few tests with the patch on our envs.

Thanks,
Shradha.

