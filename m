Return-Path: <linux-hyperv+bounces-1446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0482F2E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 18:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331E12889D4
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFA1CA95;
	Tue, 16 Jan 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuG93urs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCF1CA87;
	Tue, 16 Jan 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425018; cv=none; b=Qvw1vx+rBbpzJbjpxEBgHzCJGqS+fnLbYGfP2swYafJr2iWORkUnhJIqgtbn1ucDPFRncJCVXmxFM/dqtky2FZrlXneeqlemw4usZZMeQJiJI8cWOL8KPknXYhzArM57gttX7b6y770PD57d8VnugvLVmNHcACj6LraODdFZckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425018; c=relaxed/simple;
	bh=+F0EM0MyQ7NcCg3Ixxu9z5Tybad96Gl5Tf0YqH4Dt+U=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=EiyoZ+MH9fAwwv7Nh/BWdMxYCu9WpoH4zIRgQSmHhdsj5sHlowZfHQ9PmkUImkNOfTN0MN/x7gNI14m6EBGI717kh0KwbXY0JSu0P2Co209rf2RWw7ZyNALr3S2Dho9PXyCsvsMon/mKGJA9wSNLKL7L9KB40oy0pEGB/+01S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuG93urs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705425017; x=1736961017;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=+F0EM0MyQ7NcCg3Ixxu9z5Tybad96Gl5Tf0YqH4Dt+U=;
  b=EuG93urs22+Rzqck03NUvlaV+3W1lMFn6/4m/KzkHiLIJ/ORTbux9dXx
   u3DTMBzTzzOXnd5O2y9hYDYn2Kgg4uGdwPi3LZkuCO0GYS33Vm9fc4D3y
   2spT9THB8/kyVJ+IjYSzvBuAwvHLqL12L7OlqbgSYw8g+ijldO+DXeuVW
   UaPVH6RRtDTReTDLbvE7j3uiW33ea42OUzu7qaR12Kl7z9VPbm+ouIkd+
   JeMogJslbJ77quzMwzt3M0x1bf9JbvI0dbeJCYS/cl/L860cYJ2anaGrd
   YXS5Bl9bjvAN/uT/gWJVtK7eSEDVf1FNg+nhZpz6yi3QGEvLP5z3y7xTE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7295108"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="7295108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="32529976"
Received: from ticela-or-353.amr.corp.intel.com ([10.209.70.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:10:09 -0800
Message-ID: <76352c8a2a91135b0fcc9041b6f6e06ff0e0a971.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when
 changing encrypted state
From: Rick Edgecombe <rick.p.edgecombe@linux.intel.com>
To: mhklinux@outlook.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de,  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
 kirill.shutemov@linux.intel.com, haiyangz@microsoft.com,
 wei.liu@kernel.org,  decui@microsoft.com, luto@kernel.org,
 peterz@infradead.org,  akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, lstoakes@gmail.com,  thomas.lendacky@amd.com,
 ardb@kernel.org, jroedel@suse.de, seanjc@google.com, 
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 16 Jan 2024 09:10:08 -0800
In-Reply-To: <20240116022008.1023398-1-mhklinux@outlook.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 18:20 -0800, mhkelley58@gmail.com wrote:
> =C2=A0 x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor
> =C2=A0=C2=A0=C2=A0 callback
> =C2=A0 x86/mm: Regularize set_memory_p() parameters and make non-static
> =C2=A0 x86/hyperv: Make encrypted/decrypted changes safe for
> =C2=A0=C2=A0=C2=A0 load_unaligned_zeropad()

I'm not clear on the HyperV specifics, but everything else looked good
to me. Thanks.

