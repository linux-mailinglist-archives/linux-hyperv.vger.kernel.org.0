Return-Path: <linux-hyperv+bounces-2769-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCE9950F31
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9BF1F233F4
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C21B17B515;
	Tue, 13 Aug 2024 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaYZ3Ma8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C517CC;
	Tue, 13 Aug 2024 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584992; cv=none; b=SUea1LDPysojrnNDnkvwYFNGa+IDwwh20gNmwLl3AyAi9Y+xWFOntwMqnq5Sg55YsjfPJ2eIgB6GO43cTW3sHxD2vXbY/3xFg2Mz9ySwmBH9NWeEJVo3BKpl79aS+/V5wrIJTvgIj5MEROkupHxR5Fq0W09YHLdeOvdNXvj4Aa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584992; c=relaxed/simple;
	bh=hIThzvLfNjHy8d8yTXSfHuOhmB/F30HL+S4bAmftiP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgkeaNzWlLaSq9uIE798/hfrYAhmbpqMK2EmIHydSRbaEEKokUt05sVkvkn4PqFFStCb/XfZznVK1yUu3vCN2pG7UjkFis01WAeazbj8jHtxUOsywaoAu955CHsV8tj6QDMsFkR1UeLw58EdEBHpqno9eHKT2XOSo+Qx42Q5DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaYZ3Ma8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723584989; x=1755120989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIThzvLfNjHy8d8yTXSfHuOhmB/F30HL+S4bAmftiP8=;
  b=PaYZ3Ma8mdiRsgRhfEYVlfVvyDS/o6sBktw12FqZSUl6kUTgqaarkZZa
   KgPaxcdPfumb38sjytLnWJZkEskd8HhGW4dL9AYcjJObXH7IS8y2stnGv
   Q9EUa46XDfuqfNpli00+wOh11DIaaDP8IGTP2aZLxydXLzswWpy1mNCqj
   J0EkEn6ktrxujqpZFepTzpZaKY8Ek39ZEqgvRAq1QF0Io28JAqe9xWXJf
   +XGg2cJ/Mgycs/x8gRCqbKoLBCjS+PFhmHbkj0SXdpuqIJbEO7bt0AV2Q
   rwGtVtzaHWs80c7eOBErm8/DGG3UOMq6Pai8DKvXqSyt2jmMcwdfI/MA3
   g==;
X-CSE-ConnectionGUID: GuiTgVFvQWKu9FHqH4Zf1w==
X-CSE-MsgGUID: XajXncEaQ9eg6a0UMojzIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39283638"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="39283638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:29 -0700
X-CSE-ConnectionGUID: 06ub4qFPRgKEbQz0svQ1Ng==
X-CSE-MsgGUID: g4LA9E7WReigYMu4VxB2zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58497276"
Received: from unknown (HELO localhost) ([10.79.152.34])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:36:29 -0700
Date: Tue, 13 Aug 2024 14:36:28 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question to hv_vtl_real_mode_header in hv_vtl.c
Message-ID: <20240813213628.GA7852@yjiang5-mobl.amr.corp.intel.com>
References: <20240813172819.GA6572@yjiang5-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813172819.GA6572@yjiang5-mobl.amr.corp.intel.com>

On Tue, Aug 13, 2024 at 10:28:19AM -0700, Yunhong Jiang wrote:
> Hi, Srinivasan and Dexuan,
> 	I have a question to the hv_vtl_real_mode_header in
> arch/x86//hyperv/hv_vtl.c when addressing one patch review comment.
> 	In hv_vtl_early_init(), the real_mode_header is set to
> hv_vtl_real_mode_header, but there is no setup to the real_mode_header, since
> the realmode_init() is marked x86_init_noop in hv_vtl_init_platform.
> 	How is the real_mode_header(in another word, hv_vtl_real_mode_header)
> used? Is it to meet the access requirement from do_boot_cpu(), so that
> real_mode_header->trampoline_start64 will work, although the start_ip is not
> used?
> 	If it's really to support the do_boot_cpu() requirement, how does the
> non-VTL guest meet the access requirement? The hv_vtl_init_platform() is
> unconditionally called from ms_hyperv_init_platform(), so I assume all hyperv
> guest will have the realmode_init() set as x86_init_noop.

The patch review mentioned above is
https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/ . Can we set real_mode_header
to hv_vtl_real_mode_header in hv_vtl_init_platform(), instead of
hv_vtl_early_init()? I'm not sure if such move is safe, because
hv_vtl_early_init() is invoked only for vtl!=0 guest while
hv_vtl_init_platform() is invoked for all the hyperv guest.

> 
> Thank you
> --jyh
> 

