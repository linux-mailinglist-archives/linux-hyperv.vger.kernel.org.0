Return-Path: <linux-hyperv+bounces-7347-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6CC116A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4A3B1704
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C6317707;
	Mon, 27 Oct 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epbD1kNT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB66305E29;
	Mon, 27 Oct 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597499; cv=none; b=kTtewusQhSqOHBdoojLi0X70o8aeAqAoXIQ7GArbN7uO55fZO4QdV2BYFa041TJABerp+U1g/iTJcUqhqABvxv8ZfdNufdXZrXmW3sRC0lfvMTCoTyIl29EvkLFUeF4l/wEHfgXFXPN/4bmNbMPnPBUJkHdQFQhn67Se6rVEfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597499; c=relaxed/simple;
	bh=5UQm7v/j9A/hzLS0XZZ9DQ+j2ooCVmH3POGZzPBRr54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnzrBgIorHeiujz9qybsd+0vIuVpEQFU/mwsBREj6GeVw0HU+8H6qVDlualfjJHkQNYb9OG2ESWpX8kwmnSHk6kxklnbJgl4RJCUwETh8UYyBf4cY1WvhT6V9K8zMZooKOp6qT2Dvgy7bZqNh/yWDwkA6ppp8wg+UDjsyqMITJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epbD1kNT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761597497; x=1793133497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UQm7v/j9A/hzLS0XZZ9DQ+j2ooCVmH3POGZzPBRr54=;
  b=epbD1kNTday+NqVJtsQzEGJLe65ofy1iKOLOEaeGHDj2ywxB75ODurFv
   xaTJAptJ6BHqKoXOC/MG4xd9id86wkFFtGMO4OqDVAjEBIBMGcdNp7c9u
   Y54SaSPkgJ9Gpg9ThyxiDIBOwdWWicgE1EmA0x+QzZendiIZyTTidBfuz
   PxhQKfi15Qm+IZX/KuRQodxik/NQn4sqvnK9jnjgOPWBAQaSPywwmqkRn
   4O5vA9RzFGn4/qYDTjY4lEwBn5rxW26UsVoiBmmzcnmBzHDugrMjP4IW1
   Dxw/PaXQavjfaA6ACcppcdvl9g+bGG1kVdEnImr04MLo/TkDOgxBp0HAB
   g==;
X-CSE-ConnectionGUID: JYUGpnhlTqacRCiblxWWKQ==
X-CSE-MsgGUID: U04Iml9iSKyij0gAIfvAaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75033727"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="75033727"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:38:17 -0700
X-CSE-ConnectionGUID: 843NkRjgSAK5pPp1mxXvXQ==
X-CSE-MsgGUID: 5vBnlc7qTWCD6sOE7pOpYA==
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:38:16 -0700
Date: Mon, 27 Oct 2025 13:45:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v6 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20251027204538.GA14161@ranerica-svr.sc.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>
 <20251027142244.GZaP-ANLSidOxk0R_W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027142244.GZaP-ANLSidOxk0R_W@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Oct 27, 2025 at 03:22:44PM +0100, Borislav Petkov wrote:
> On Thu, Oct 16, 2025 at 07:57:25PM -0700, Ricardo Neri wrote:
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> This is missing an ack from the devicetree maintainers:
> 
> ./scripts/get_maintainer.pl -f Documentation/devicetree/

Agreed. They are in the "To:" field of my submission. Rob has reviewed the
patchset.

