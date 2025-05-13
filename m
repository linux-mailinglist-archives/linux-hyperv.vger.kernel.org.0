Return-Path: <linux-hyperv+bounces-5495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E6AB5F0A
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 00:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAD8C02CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA12A1FFC46;
	Tue, 13 May 2025 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlpvT5Ib"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E726B672;
	Tue, 13 May 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174190; cv=none; b=tDh3cZoHN1EqugUTcwL83nNj+uAl9jXq0fyJt6y/3LJp+vrKTqANdIMEyv/gJbbaZ6dHvQBG/NSyoiZWOqjbE4Pnm/q9BlHja8mlr4XKQtWYgGc2oUSDMivGTctA9N/kf13LKRa/wrCPGHC4BXuEg1Lu2zE9iACDZgpiVbF8szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174190; c=relaxed/simple;
	bh=KkbSGaaqp8jSgFqgu1SEOqd6OF0O+xElkdV+bbcIil4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t20eg0s+2oIJNDjGRCNjhfQPsu7s7LKASg3UhHV7B1i8Y24LLqPpjqoxTCq9yRMq2eksCIZhZC8USRFbQxRYuo6soJXsEQnopntPfBfFt7sqZn069Y4eSZZsNGcKfoc2Ub7yLhFajMMPNiDjU//JyBjtcMprKEijUT4XcdIQdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlpvT5Ib; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747174189; x=1778710189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KkbSGaaqp8jSgFqgu1SEOqd6OF0O+xElkdV+bbcIil4=;
  b=YlpvT5Ib8ZuMsXdQZClTNVGqTlTH9lk2DgwUYMBluedRKXEry52WJC8c
   5V1LW9oZCTMIt0wdjuFTJmiwEoybhoxsCBnWUY9qGk8xkBrESS366X3bA
   N6IItr85ozZMt/kXVtww3aSNZvvvlncaQZe3gO2UffK0/Nlf0g3A2RYhM
   cJD8eRxYPQ8r8igV9X0Bb4wlw8QNi2FTICyj5K5bnXnkwCXe1Q3HO43OF
   m/ur7517+dpm07zCPkhH0TMG8j24EKs5w2CXsoUZbCS/KYSxHaoUgs9Av
   NTJ+LesO8mFAnO8+ciB8/fAi3930PV7XuSLKdVEsEXJathC2SimZY65J4
   w==;
X-CSE-ConnectionGUID: e9TcuRIgTImwaW8ETroW5g==
X-CSE-MsgGUID: o1dZKRdZRrq3z+QO3a201w==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71548759"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="71548759"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:09:48 -0700
X-CSE-ConnectionGUID: An0NDBrZQse9QVSSeLPPdQ==
X-CSE-MsgGUID: 5j1rMCa/RKOIqlFg7QemzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="142947639"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 15:09:48 -0700
Date: Tue, 13 May 2025 15:14:56 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250513221456.GA2794@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
 <20250507032339.GA27243@ranerica-svr.sc.intel.com>
 <20250512153224.GA3377771-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512153224.GA3377771-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 12, 2025 at 10:32:24AM -0500, Rob Herring wrote:
> On Tue, May 06, 2025 at 08:23:39PM -0700, Ricardo Neri wrote:
> > On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> > > On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > > > If this is a device, then compatibles specific to devices. You do not
> > > > > get different rules than all other bindings... or this does not have to
> > > > > be binding at all. Why standard reserved-memory does not work for here?
> > > > > 
> > > > > Why do you need compatible in the first place?
> > > > 
> > > > Are you suggesting something like this?
> > > > 
> > > > reserved-memory {
> > > > 	# address-cells = <2>;
> > > > 	# size-cells = <1>;
> > > > 
> > > > 	wakeup_mailbox: wakeupmb@fff000 {
> > > > 		reg = < 0x0 0xfff000 0x1000>
> > > > 	}
> > > > 
> > > > and then reference to the reserved memory using the wakeup_mailbox
> > > > phandle?
> > > 
> > > Yes just like every other, typical reserved memory block.
> > 
> > Thanks! I will take this approach and drop this patch.
> 
> If there is nothing else to this other than the reserved region, then 
> don't do this. Keep it like you had. There's no need for 2 nodes.

Thank you for your feedback!

I was planning to use one reserved-memory node and inside of it a child
node to with a `reg` property to specify the location and size of the
mailbox. I would reference to that subnode from the kernel code.

IIUC, the reserved-memory node is only the container and the actual memory
regions are expressed as child nodes.

I had it like that before, but with a `compatible` property that I did not
need.

Am I missing anything?

Thanks and BR,
Ricardo

