Return-Path: <linux-hyperv+bounces-7339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EFC0E70E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814E44E22C6
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191A3009D9;
	Mon, 27 Oct 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cdaBfoQb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0B3081CD;
	Mon, 27 Oct 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574995; cv=none; b=AoMTSf2lWm2j7WcXMva1oVS6szEd8JojUYowvxU3iTEQvBdk6EgSvw0Ig8VvlspUhIPR3dwl7v7ClNF3WfQQoheySISqdwKUd5X3PpXZJflf5UL6N6eu03Lej7+gWF16KawiKbHwPsheXXFJ+/NXDh9LyL83p36Zbsm6dUyNza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574995; c=relaxed/simple;
	bh=fm1rWXPQZcpi2+uxhMsNMIyRQSyhCR/roTyZlWfCFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf5W25MmFJuiGC163Mk8m2YVv1P+h6fAAf/zjl3CAcej8euwc4VC+yJHpuH6YZGCimmPBKEuHgDTmrYIbJzOfBLz9A/l/nrcpKuN2Ug+c2bbyratpHacPnGaKPV9kHegqX0htYAds0iPIBJmMRL9/OCR3SzkkTApr+ozRqaYYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cdaBfoQb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 300C940E019D;
	Mon, 27 Oct 2025 14:23:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z-6BA6geamk3; Mon, 27 Oct 2025 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761574986; bh=6wcpZ5fcSTosdMzg7ajLOqb/tuYrXwNTAuu+9ROomxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdaBfoQbPCuGj8RnDDCvVuAiGAxU4WThgJjGTdTgRCqrN8AkUqUIBCDkKcPcyibzL
	 IvDD0tRkUu4hb9Ej40MOa1OTKvOiGaa2MUt4l1oyGU0s5FHW6+UZFtS8lWdEX//TzU
	 MvhghKi7AL+pNZpf/5gWSvI4UEPk+FHEG1MUyAvjwVwoZSN4wvt4Eq3pgqsSaeoOu0
	 9wSmq6Tc6FkHPZFivnrWozgBHpfswcmbPv/jp9o3qpH4zLwrEe0p+FndQNPYh967fb
	 xphvlY/LYwujUse6YUUNLXbNYT9YeVxu9JjbPq0o/z2oFQ0nGMaQntOQz7fJdiCF45
	 oQ5SIl0eq60CpwrTqYcZaqLEY/FG5tSGK6GmH6HiinJ/uimUnr9qHcx/mDaE2XAfna
	 oQqL8YKsevy2Tepyq3EsZEza5LYtUr0F0JL0QqZVdUfbR7rbvbjL/U5H9TZdvicKbf
	 wDxUBFSCTPj8rYT1NtQ7MosRxgIYz6ytvydMIfIPXeENFDMRl18jymvgx+vtqHR4u6
	 JV+hhE02CoZjceYJpU92P34r5pw2ai3xQQtLZuuAtbYzBynzk7Whu9a8ZpRRPjh2iF
	 jHA+pcVZcfxkskA9kT4c0off2MBknKCMEaUfNhG28lQ/hVMQ2pUqIIzMXMnHqiKeDp
	 3PEFoHgjLe/dVQgaRvw84xS8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1F47440E01FA;
	Mon, 27 Oct 2025 14:22:45 +0000 (UTC)
Date: Mon, 27 Oct 2025 15:22:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <20251027142244.GZaP-ANLSidOxk0R_W@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>

On Thu, Oct 16, 2025 at 07:57:25PM -0700, Ricardo Neri wrote:
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

This is missing an ack from the devicetree maintainers:

./scripts/get_maintainer.pl -f Documentation/devicetree/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

