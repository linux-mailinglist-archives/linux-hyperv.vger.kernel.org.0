Return-Path: <linux-hyperv+bounces-6058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93ADAEEA8E
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 00:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E01BC165F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098C024677B;
	Mon, 30 Jun 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuxvQJxX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205D125B2;
	Mon, 30 Jun 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323432; cv=none; b=UVcJbj91rwefdxyp9WmM+FxdISIXQ1pKgouB1N+Kl0sA7jKKB47+xAJFpeAH7z5iSojfaJutEcDJZ1Zt6QZPa/qlGI10RGtWuZnDH3n1ILS6a+gublIj63bO1fDE6g2qD7LJkaasew9KcUEJ4GoG4kEa/4bngWj/RVV4PeerwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323432; c=relaxed/simple;
	bh=ffb/hTRPmY5KeK6OrulyF3uIh0DRkKHhLxkEtemA18k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r79WHAn+7Zqh8CCJ6qr1XD2jLzfS86lg9gRMpNTebYVdDbXLhjqQCZxuV0H6+gXwD2iB1ptZZUsRSMglmpr2k/7IH00hWPsDqUab8L5839uusN3/QHBLrFKYWjS2wZmITe/uzMXV6BCLro0uqRzh3gunAQjbdGwxxS3tcxG0XDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuxvQJxX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751323431; x=1782859431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ffb/hTRPmY5KeK6OrulyF3uIh0DRkKHhLxkEtemA18k=;
  b=YuxvQJxX04qiPvwXTetOAwkyUiT6A1TqDO5ZPhTBMPF8IFMIJeZUyJoa
   rj73HJo+xFpsmxqN+GB9rb4bhDrF6cK0b8xFg5UpHIt90fZBycScNiZOf
   8NmPt31vmAf3XjTAxyw29kVllboR2wMBNvunZBtF7pHsYiHOqFbRG9q3Y
   6mLxsGd7TMq6Pv/kgcotjXkfp0d2NyqXLXfE3J/ASEHjtEOPsh6P0RZwA
   n4FN5gXUxiCIFJUEuvjvb4IFX5FO9ZB99By1QOB+Acyc9+94Ssy5d7cIu
   aLv6lp9v9K4esQUXjSQxmjsbJtCJBrVqndqVKz/6LrkHppWndNF1UCCtr
   g==;
X-CSE-ConnectionGUID: 16DktrHjR5eXmqRUY6rIjQ==
X-CSE-MsgGUID: CVfy4fu0QAG6tjR+97r34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53526456"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53526456"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:43:50 -0700
X-CSE-ConnectionGUID: fiAwSQv8QKmrmHZGKskUGw==
X-CSE-MsgGUID: +1nCDvr8SWaVJgaf3d6gvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="177246336"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:43:48 -0700
Date: Mon, 30 Jun 2025 15:49:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250630224947.GA3072@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
 <CAJZ5v0h_oifyhJq4WiOzS0fcexrjeChJhVyAthfQCX=6v_GumA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h_oifyhJq4WiOzS0fcexrjeChJhVyAthfQCX=6v_GumA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 30, 2025 at 09:02:00PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jun 28, 2025 at 5:35 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
> > firmware for Intel processors.
> >
> > x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
> > followed by Start-Up IPI messages. The wakeup mailbox can be used when this
> > mechanism is unavailable.
> >
> > The wakeup mailbox offers more control to the operating system to boot
> > secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
> > for all CPUs while maintaining control over which CPUs to boot and when.
> > While it is possible to achieve the same level of control using a spin-
> > table, it would require to specify a separate `cpu-release-addr` for each
> > secondary CPU.
> >
> > The operation and structure of the mailbox is described in the
> > Multiprocessor Wakeup Structure defined in the ACPI specification. Note
> > that this structure does not specify how to publish the mailbox to the
> > operating system (ACPI-based platform firmware uses a separate table). No
> > ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.
> >
> > Add a `compatible` property that the operating system can use to discover
> > the mailbox. Nodes wanting to refer to the reserved memory usually define a
> > `memory-region` property. /cpus/cpu* nodes would want to refer to the
> > mailbox, but they do not have such property defined in the DeviceTree
> > specification. Moreover, it would imply that there is a memory region per
> > CPU.
> >
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> LGTM from the ACPI specification cross-referencing perspective, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you Rafael!

I hope this looks good to Krzysztof and Rob too.

