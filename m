Return-Path: <linux-hyperv+bounces-7642-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB18C65A1C
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD23F4E3DDF
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC69303CB7;
	Mon, 17 Nov 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Hi8HR6gs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903E2C0F89;
	Mon, 17 Nov 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402306; cv=pass; b=l75+hYDbVJmHHp6IqRrrVtUBEn9/suAC6w/tnD3A4a7nZ8nKuvHpAYl0QObVaW0GtK/6tc5U1s+LDdUzluuTKouGzVsG0pYjmc9rnhvYQhU4YvyIab7IzygOYaJKW6GZDXtAUvNfBCER6PT2j+A5PhiFzSFufy3FcIKHJOlMve8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402306; c=relaxed/simple;
	bh=2rNH0yyQwPxiUnte3OgDSEm+m3RdQSUEqi6Z6iLPXfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9QVIP9nFV7vA3vLugUHdkG0vxYsvZ+zF0GVK/6a7DXVaz4wMupvhbqbGwG7KSkRB579HRn+kkKpK0QunYHW/Kf9GHXykJDeQZZehy4DLI5U5FbHdgz07Fxn3JM0wgekxCs1PJqAUnL4TNp+1HntdZaPWxxsqOzkQZ5GSO/Z4/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Hi8HR6gs; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763402278; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fW1KtFHpGqgX6RDESPkICQhiCh9G3/yo4r/5y0vrkOTMex5ALVg3g/fMtVLVuICP3i4Ul6cHFzD+6OTBPKl5RxZWgPDPrDM2TQFpZDWHA7MxB0wyq8ww/YMVyOxfAO7TjMp2VlMZQKakDupWxHjV9+ydeI8NVwQX/NxzyLsxduk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763402278; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mtj/y1tj4Qb6xMK6ny1DnT4aSEezLdSFUIrKSEg5pAk=; 
	b=UTJsRkMdK6SN+lBzntZl98xpEXew4eidh25/O+ONsTTTtH2h/A4hl4gkqW50QLLzYnyBDoOe8I2h6Vf0uz2KzQ817LJxsF8HYnkoAeXr5UDipwcQf54DZmr8dcu5ki1E4DxgC5j2n2WD25DN9uKifuS4QLZBitqOCVFGKVGWziI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763402278;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Mtj/y1tj4Qb6xMK6ny1DnT4aSEezLdSFUIrKSEg5pAk=;
	b=Hi8HR6gsKUw7Nb/f4UccZ1opfSR7mbMZJzFhjrCHmGAqyn02ePtYVnRPUqUqFRA9
	+6s4o474aJbtaPKG0Z+7P5kByh+aovAz9isAXckXnOxwmi1NEfTDjn5hhvc0FbreQO1
	9MTdgMiG0OFikAN74G36S7hoslEWHmtex2jqIrGY=
Received: by mx.zohomail.com with SMTPS id 1763402276135717.0723309216664;
	Mon, 17 Nov 2025 09:57:56 -0800 (PST)
Date: Mon, 17 Nov 2025 17:57:50 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, kernel test robot <lkp@intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <aRtiHkEYMi_eqTvQ@anirudh-surface.localdomain>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
 <202511161617.KcDzR4sA-lkp@intel.com>
 <20251117173428.GB2380208@liuwe-devbox-debian-v2.local>
 <522f1bc2-417f-434a-92f9-7b417744cef4@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522f1bc2-417f-434a-92f9-7b417744cef4@linux.microsoft.com>
X-ZohoMailClient: External

On Mon, Nov 17, 2025 at 09:41:19AM -0800, Nuno Das Neves wrote:
> On 11/17/2025 9:34 AM, Wei Liu wrote:
> > +Nuno
> > 
> > On Sun, Nov 16, 2025 at 04:17:08PM +0800, kernel test robot wrote:
> >> Hi Anirudh,
> >>
> >> kernel test robot noticed the following build errors:
> >>
> >> [auto build test ERROR on linus/master]
> >> [also build test ERROR on v6.18-rc5]
> >> [cannot apply to next-20251114]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>
> >> url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Rayabharam/Drivers-hv-ioctl-for-self-targeted-passthrough-hvcalls/20251114-182039
> >> base:   linus/master
> >> patch link:    https://lore.kernel.org/r/20251114095853.3482596-1-anirudh%40anirudhrb.com
> >> patch subject: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
> >> config: x86_64-buildonly-randconfig-005-20251116 (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/config)
> >> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202511161617.KcDzR4sA-lkp@intel.com/
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>>> drivers/hv/mshv_root_main.c:125:2: error: use of undeclared identifier 'HVCALL_GET_PARTITION_PROPERTY_EX'
> >>      125 |         HVCALL_GET_PARTITION_PROPERTY_EX,
> >>          |         ^
> > 
> > Anirudh, please check this.
> > 
> This is introduced in hyperv-next, in:
> 59aeea195948 mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
> 
> But the bot applies the patch to linus/master, that is probably why.

Right. In the v2 of this patch, I used the --base argument to git
format-patch as suggested by the tool above. That should help it apply
the patch in the right tree. Let's see if it still complains.

Anirudh

> 
> >>>> drivers/hv/mshv_root_main.c:175:18: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
> >>      175 |         for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
> >>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This is from the original patch. Perhaps adding the explicit declaration
> > of the array size would help.
> > 
> 
> I think this is just due to the earlier error...
> 
> Nuno
> 
> > Wei
> 

