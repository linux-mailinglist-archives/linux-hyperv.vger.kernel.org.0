Return-Path: <linux-hyperv+bounces-7639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1339C658F1
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 965974EE413
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040430F52D;
	Mon, 17 Nov 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT6UTOLH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBC308F27;
	Mon, 17 Nov 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400872; cv=none; b=ErRiNijxUQYlLJojK8ljGLynK+t+zpGFWYrvetgy4akJl73YYqGSdbznDl6hmjh7Rf4wvZ5GSb44QP66KUVJP8Sabaz9g+TUQoydO1nWYReJYi4S/tAijlfhrpV5oOUom/Bh5Vj0AsdOA23dviz4uncfg0UxWAUHoIpYEoC7btI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400872; c=relaxed/simple;
	bh=AuEXOa39D2Uppr9TqncDkFYpFegbstOeXdQgCGq2VIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCrgmn68lCVukkFiYCqv/xRWor5UWlLK+45RzYKLr1uZ81ZYgRJ25JfjtGbHZuCwmaFvsSU5tIZwSAOuE+HrC64wcWdWo2GC2eax/vmNyxn/2nje0wGXsG1ac1vedOUUscsaPgtvLfqU6BOUuxTsEwbjkRAxLVw8wfB8Z5cVvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT6UTOLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C927C19421;
	Mon, 17 Nov 2025 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400870;
	bh=AuEXOa39D2Uppr9TqncDkFYpFegbstOeXdQgCGq2VIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT6UTOLHB/lLqFuyUY6rnaTsziNc7oPcASYkbSq/Ka6LTOyvSbvNGnVzPDJtzvNpL
	 PZdQB4gxxQP/7F5Ag6icbdb46Z0XDo3jmgyEYMky2PrSP2I+xsFXz13ef+aaD33kxG
	 bAzh8+Cg4Lg5069eJ5RZ40ZhQ3Bv0PJx3nr+1Hv4iFLrAw84LRHz1t9QbV0GdIsWV3
	 uw9EyT41r0mHYwz1Tra+WiN1rfJHsZS20OSbC+iTSF+/Vm6zcQ7naxJkU/JUdDXWtG
	 zETXNlBVXbx8oJ/hNzX4VcT7UGgETZcscby3E55qXdHuQ/z5On8jSW3Zkk0h6hksho
	 6kXJ3mj7i6/Yg==
Date: Mon, 17 Nov 2025 17:34:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: kernel test robot <lkp@intel.com>, nunodasneves@linux.microsoft.com
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <20251117173428.GB2380208@liuwe-devbox-debian-v2.local>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
 <202511161617.KcDzR4sA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511161617.KcDzR4sA-lkp@intel.com>

+Nuno

On Sun, Nov 16, 2025 at 04:17:08PM +0800, kernel test robot wrote:
> Hi Anirudh,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.18-rc5]
> [cannot apply to next-20251114]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Rayabharam/Drivers-hv-ioctl-for-self-targeted-passthrough-hvcalls/20251114-182039
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20251114095853.3482596-1-anirudh%40anirudhrb.com
> patch subject: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
> config: x86_64-buildonly-randconfig-005-20251116 (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511161617.KcDzR4sA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/hv/mshv_root_main.c:125:2: error: use of undeclared identifier 'HVCALL_GET_PARTITION_PROPERTY_EX'
>      125 |         HVCALL_GET_PARTITION_PROPERTY_EX,
>          |         ^

Anirudh, please check this.

> >> drivers/hv/mshv_root_main.c:175:18: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
>      175 |         for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is from the original patch. Perhaps adding the explicit declaration
of the array size would help.

Wei

