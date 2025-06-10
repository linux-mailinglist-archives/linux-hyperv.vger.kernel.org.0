Return-Path: <linux-hyperv+bounces-5842-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B2AD480E
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2888317DAEA
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB913CA9C;
	Wed, 11 Jun 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCQCtSCC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6EDDCD;
	Wed, 11 Jun 2025 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606060; cv=none; b=owgALq0/M2m/C3mwLGTQ/tDidWFTLKjJSUwn5m5E3L7ajvAN7c7U7AYciYXw/D3HyWF4g7dD6ElVJZXmPIE2rvaqdW9eiHXtAN97ueiQFQcCi+NRuZVqd2UcFHAZ3DI8Rerwm7VyTNfOmoSNtPr3ezWox2ie+pxHBmiGG+vRGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606060; c=relaxed/simple;
	bh=gxzoeGyT3r1HjkyAYKSBTMWTcAr/Q7V0wi256N0AQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9k/0Jfb1VJJYo0wooqqQjkBFEcI7xxzFd9FKYuo2JsewsqbOcheO74+5aPOaLgBEw8qmpZYpahbH/0MDWe0NFIxhiLy3FihyLNbBmsfUi3w2Qi0Krcl4Fn/hYVKBXpZiHUx0V3z3Idr+prqVhnGSeNqad27qZcZf/o/Sg8n/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCQCtSCC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749606052; x=1781142052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxzoeGyT3r1HjkyAYKSBTMWTcAr/Q7V0wi256N0AQqg=;
  b=bCQCtSCCaC4FxDvQ2+az23Ghpl4OOwg2608IzKAB4cD1Q52WWklJYNX3
   sh0+qX1jKHvllHRk9kPkXBm+YoG1oR2JF9RpXhUx80agNKx+XGnVyA7N4
   d5gT4R5zJr095d7cNo9aHvG+zkHCkiWeLysITWfqsOxImjPoyq1gVMPGp
   52GzGVDFrnWcl4nO4P/ZRIvdIo+Tk4yxjPsFpRZjUqNaqT6juWqztOOov
   ve/0ahqmLv7EXH74AgxcGvFfW5VhIERBJM+uMuqHkBTKl3U4JiCzNAIyM
   ucghs3xFW4mXk+Esz2RGWL2sMCp+bimYmkD3tgsPV6cIdROt42xM+cn7n
   Q==;
X-CSE-ConnectionGUID: z+jrRY2tSGCqVeH6E8E1Hg==
X-CSE-MsgGUID: C3a0NT+ITDauAKpYt5yjow==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55539083"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="55539083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 18:40:51 -0700
X-CSE-ConnectionGUID: a9UcM+sMRdGGzpvad5Xksw==
X-CSE-MsgGUID: pSwdYvqhTUmznhiBb9AnRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="147383498"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jun 2025 18:40:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uP6yd-0008qe-12;
	Tue, 10 Jun 2025 21:57:51 +0000
Date: Wed, 11 Jun 2025 05:57:48 +0800
From: kernel test robot <lkp@intel.com>
To: Naman Jain <namjain@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Drivers: hv: Export some symbols for mshv_vtl
Message-ID: <202506110544.q0NDMQVc-lkp@intel.com>
References: <20250610052435.1660967-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GJaJ7oPF950xrCl1"
Content-Disposition: inline
In-Reply-To: <20250610052435.1660967-2-namjain@linux.microsoft.com>


--GJaJ7oPF950xrCl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Naman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 475c850a7fdd0915b856173186d5922899d65686]

url:    https://github.com/intel-lab-lkp/linux/commits/Naman-Jain/Drivers-hv-Export-some-symbols-for-mshv_vtl/20250610-132611
base:   475c850a7fdd0915b856173186d5922899d65686
patch link:    https://lore.kernel.org/r/20250610052435.1660967-2-namjain%40linux.microsoft.com
patch subject: [PATCH v4 1/2] Drivers: hv: Export some symbols for mshv_vtl
config: i386-buildonly-randconfig-002-20250611
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506110544.q0NDMQVc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/drm_plane.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_plane_helper.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_print.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_privacy_screen.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_self_refresh_helper.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_simple_kms_helper.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_suballoc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_syncobj.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_vblank_work.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_vma_manager.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/drm_writeback.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/i915/gt/intel_rps.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/i915/intel_gvt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/i915/intel_gvt_mmio_table.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/imx/ipuv3/imx-drm-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/lib/drm_random.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/mcde/mcde_display.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/mediatek/mtk_cec.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/nouveau/dispnv04/nouveau_i2c_encoder.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/panel/panel-samsung-s6e63m0.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/pl111/pl111_nomadik.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/pl111/pl111_versatile.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/rockchip/rockchip_rgb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/scheduler/sched_entity.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/scheduler/sched_fence.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/scheduler/sched_main.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/solomon/ssd130x.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun4i_frontend.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun4i_lvds.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun4i_rgb.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun4i_tcon.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/sun4i/sun8i_tcon_top.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/tests/drm_kunit_helpers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/tests/ttm_mock_manager.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_agp_backend.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_backup.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_bo.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_bo_util.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_bo_vm.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_execbuf_util.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_pool.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_range_manager.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_resource.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/drm/ttm/ttm_tt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/channel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/context.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/context_bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/fence.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/job.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/mipi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/host1x/syncpt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-cpmem.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-ic-csc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-ic.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-image-convert.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-prg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/ipu-v3/ipu-vdi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/gpu/vga/vga_switcheroo.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/connection.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/debugfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/hd.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/interface.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/operation.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/greybus/svc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/bpf/hid_bpf_dispatch.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hid-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hid-input.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hid-roccat-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hid-roccat.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hid-sensor-hub.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/hidraw.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/i2c-hid/i2c-hid-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/intel-ish-hid/ishtp/bus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/intel-ish-hid/ishtp/client-buffers.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/intel-ish-hid/ishtp/client.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/surface-hid/surface_hid_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/usbhid/hid-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/usbhid/hid-pidff.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hid/usbhid/hiddev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hsi/clients/ssi_protocol.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hsi/controllers/omap_ssi_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hsi/hsi_boardinfo.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hsi/hsi_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hte/hte.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/channel.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/channel_mgmt.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
>> drivers/hv/hv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/hv_proc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/mshv_common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/mshv_root_hv_call.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/ring_buffer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hv/vmbus_drv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/adt7x10.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/hwmon-vid.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/hwmon.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/ltc2947-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/max1111.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/nct6775-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/pmbus/pmbus_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwmon/sch56xx-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwspinlock/hwspinlock_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-etm-perf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-platform.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-syscfg.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-sysfs.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-tmc-etr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/coresight/coresight-trace-id.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/intel_th/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/intel_th/msu.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/stm/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/hwtracing/stm/policy.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-bit.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-pca.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/algos/i2c-algo-pcf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-amd-mp2-pci.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-designware-slave.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-pasemi-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-piix4.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/busses/i2c-viai2c-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-atr.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-acpi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-of-prober.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-of.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-slave.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-core-smbus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-mux.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i2c/i2c-smbus.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i3c/device.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/i3c/master/dw-i3c-master.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl313_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl345_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl355_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl367.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl372.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/adxl380.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bma400_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bmc150-accel-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/bmi088-accel-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/fxls8962af-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/kionix-kx022a.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/kxsd9.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/mma7455_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/mma9551_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/accel/st_accel_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ad7091r-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ad7606.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ad_sigma_delta.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/ltc2497-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/qcom-vadc-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/stm32-dfsdm-adc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/adc/stm32-dfsdm-core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/afe/iio-rescale.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/industrialio-buffer-dma.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/industrialio-buffer-dmaengine.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/buffer/kfifo_buf.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/bme680_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/ens160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/chemical/sps30.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/hid-sensors/hid-sensor-attributes.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/hid-sensors/hid-sensor-trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/inv_sensors/inv_sensors_timestamp.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ms_sensors/ms_sensors_i2c.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ssp_sensors/ssp_dev.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/ssp_sensors/ssp_iio.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_buffer.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_i2c.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_spi.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/common/st_sensors/st_sensors_trigger.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad3552r-common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad5592r-base.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dac/ad5686.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/dummy/iio_dummy_evgen.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/bmg160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/fxas21002c_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/gyro/st_gyro_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/humidity/hts221_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/adis.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi160/bmi160_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi270/bmi270_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bmi323/bmi323_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/bno055/bno055.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/fxos8700_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--GJaJ7oPF950xrCl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

reproduce (this is a W=1 build):
        git checkout 475c850a7fdd0915b856173186d5922899d65686
        b4 shazam https://lore.kernel.org/r/20250610052435.1660967-2-namjain@linux.microsoft.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

--GJaJ7oPF950xrCl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 6.15.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_RUSTC_VERSION=0
CONFIG_RUSTC_LLVM_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY=y
CONFIG_PAHOLE_VERSION=130
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_LAZY=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
# CONFIG_FORCE_NEED_SRCU_NMI_SAFE is not set
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=2
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_EXP_KTHREAD is not set
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
CONFIG_RCU_NOCB_CPU_CB_BOOST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
CONFIG_RCU_LAZY=y
CONFIG_RCU_LAZY_DEFAULT_OFF=y
# CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKHEADERS=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_SLAB_OBJ_EXT=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_V1=y
CONFIG_CGROUP_SCHED=y
CONFIG_GROUP_SCHED_WEIGHT=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_DMEM=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_FORCE is not set
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_SMALL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_FUTEX_PRIVATE_HASH=y
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
CONFIG_GCOV_PROFILE_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_CACHESTAT_SYSCALL=y
# CONFIG_PC104 is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y

#
# Kexec and crash features
#
# CONFIG_KEXEC is not set
# end of Kexec and crash features
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2

#
# Processor type and features
#
# CONFIG_SMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MATOM is not set
CONFIG_CC_HAS_MARCH_NATIVE=y
# CONFIG_X86_GENERIC is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=5
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CX8=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
CONFIG_CPU_SUP_CENTAUR=y
# CONFIG_CPU_SUP_TRANSMETA_32 is not set
# CONFIG_CPU_SUP_UMC_32 is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
# CONFIG_CPU_SUP_VORTEX_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
# CONFIG_X86_ANCIENT_MCE is not set

#
# Performance monitoring
#
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_IOPL_IOPERM=y
CONFIG_TOSHIBA=m
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
CONFIG_VMSPLIT_2G_OPT=y
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0x78000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_ARCH_PKEY_BITS=4
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
# CONFIG_EFI_RUNTIME_MAP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_DEFAULT_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_CC_HAS_NAMED_AS=y
CONFIG_CC_HAS_NAMED_AS_FIXED_SANITIZERS=y
CONFIG_USE_X86_SEG_SUPPORT=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
# CONFIG_CPU_MITIGATIONS is not set

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_THERMAL_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
# CONFIG_ACPI_EC is not set
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=m
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_BGRT is not set
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_ACPI_NHLT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=m
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_ACPI_FFH=y
CONFIG_PMIC_OPREGION=y
CONFIG_XPOWER_PMIC_OPREGION=y
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_GOBIOS=y
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_BIOS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
# CONFIG_SCx200HR_TIMER is not set
CONFIG_OLPC=y
CONFIG_OLPC_XO15_SCI=y
CONFIG_GEODE_COMMON=y
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_X86_REQUIRED_FEATURE_ALWAYS=y
CONFIG_X86_REQUIRED_FEATURE_CX8=y
CONFIG_X86_REQUIRED_FEATURE_UP=y
CONFIG_X86_REQUIRED_FEATURE_FPU=y
CONFIG_X86_DISABLED_FEATURE_PCID=y
CONFIG_X86_DISABLED_FEATURE_PKU=y
CONFIG_X86_DISABLED_FEATURE_OSPKE=y
CONFIG_X86_DISABLED_FEATURE_PTI=y
CONFIG_X86_DISABLED_FEATURE_RETPOLINE=y
CONFIG_X86_DISABLED_FEATURE_RETPOLINE_LFENCE=y
CONFIG_X86_DISABLED_FEATURE_RETHUNK=y
CONFIG_X86_DISABLED_FEATURE_UNRET=y
CONFIG_X86_DISABLED_FEATURE_CALL_DEPTH=y
CONFIG_X86_DISABLED_FEATURE_LAM=y
CONFIG_X86_DISABLED_FEATURE_ENQCMD=y
CONFIG_X86_DISABLED_FEATURE_SGX=y
CONFIG_X86_DISABLED_FEATURE_XENPV=y
CONFIG_X86_DISABLED_FEATURE_TDX_GUEST=y
CONFIG_X86_DISABLED_FEATURE_USER_SHSTK=y
CONFIG_X86_DISABLED_FEATURE_IBT=y
CONFIG_X86_DISABLED_FEATURE_FRED=y
CONFIG_X86_DISABLED_FEATURE_SEV_SNP=y
CONFIG_X86_DISABLED_FEATURE_INVLPGB=y
CONFIG_AS_AVX512=y
CONFIG_AS_GFNI=y
CONFIG_AS_VAES=y
CONFIG_AS_VPCLMULQDQ=y
CONFIG_AS_WRUSS=y
CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=y

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_SUPPORTS_RT=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=y
CONFIG_ARCH_VMLINUX_NEEDS_RELOCS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_MODULES=y
CONFIG_MODULE_DEBUGFS=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_COMPRESS_ALL is not set
# CONFIG_MODULE_DECOMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# Slab allocator options
#
CONFIG_SLUB=y
CONFIG_KVFREE_RCU_BATCHED=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLAB_BUCKETS is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_RANDOM_KMALLOC_CACHES is not set
# end of Slab allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_GUP_FAST=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_PAGE_MAPCOUNT=y
CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=8
CONFIG_PAGE_BLOCK_ORDER=10
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_HMM_MIRROR=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_PG_ARCH_2=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_LOCK_MM_AND_FIND_VMA=y
CONFIG_EXECMEM=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_NPEM=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
# CONFIG_PCIE_TPH is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_DYNAMIC_OF_NODES is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCIE_ALTERA is not set
# CONFIG_PCI_VERSATILE is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCI_LOONGSON is not set
# CONFIG_PCIE_MT7621 is not set
# CONFIG_PCIE_RCAR_EP is not set
# CONFIG_PCIE_ROCKCHIP_EP is not set
# CONFIG_PCI_V3_SEMI is not set
# CONFIG_PCI_XGENE is not set
# CONFIG_PCIE_XILINX_CPM is not set

#
# Cadence-based PCIe controllers
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# CONFIG_PCI_J721E_HOST is not set
# CONFIG_PCI_J721E_EP is not set
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCIE_ARTPEC6_EP is not set
# CONFIG_PCI_IMX6_EP is not set
# CONFIG_PCI_LAYERSCAPE_EP is not set
# CONFIG_PCIE_TEGRA194_EP is not set
# CONFIG_PCIE_QCOM_EP is not set
# CONFIG_PCIE_RCAR_GEN4_EP is not set
# CONFIG_PCIE_ROCKCHIP_DW_EP is not set
# CONFIG_PCIE_UNIPHIER_EP is not set
# CONFIG_PCI_KEYSTONE_EP is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers

#
# PLDA-based PCIe controllers
#
# end of PLDA-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
# CONFIG_PCI_EPF_TEST is not set
CONFIG_PCI_EPF_NTB=m
CONFIG_PCI_EPF_VNTB=m
# CONFIG_PCI_EPF_MHI is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_PCI_PWRCTRL_SLOT is not set
# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SOUNDWIRE_MBQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_IMX_WEIM is not set
# CONFIG_INTEL_IXP4XX_EB is not set
# CONFIG_QCOM_EBI2 is not set
# CONFIG_STM32_FIREWALL is not set
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_FW_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
# CONFIG_EFI_DXE_MEM_ATTRIBUTES is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
CONFIG_EFI_TEST=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

# CONFIG_IMX_SCMI_CPU_DRV is not set
# CONFIG_IMX_SCMI_LMM_DRV is not set
# CONFIG_IMX_SCMI_MISC_DRV is not set

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_FWCTL is not set
CONFIG_GNSS=m
CONFIG_GNSS_USB=m
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
# CONFIG_OF_DYNAMIC is not set
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_PC_FIFO is not set
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
# CONFIG_TI_FPC202 is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_SMPRO_ERRMON is not set
CONFIG_SMPRO_MISC=m
# CONFIG_HP_ILO is not set
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=m
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_HISI_HIKEY_USB=m
CONFIG_OPEN_DICE=m
CONFIG_NTSYNC=m
CONFIG_VCPU_STALL_DETECTOR=y
CONFIG_NSM=y
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_INTEL_MEI_PXP=m
CONFIG_VMWARE_VMCI=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
CONFIG_UACCE=m
# CONFIG_PVPANIC is not set
CONFIG_GP_PCI1XXXX=m
# CONFIG_KEBA_CP500 is not set
# CONFIG_AMD_SBRMI_I2C is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=m
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_EP93XX is not set
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=m
# CONFIG_KEYBOARD_LPC32XX is not set
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
# CONFIG_KEYBOARD_IMX is not set
# CONFIG_KEYBOARD_IMX_BBM_SCMI is not set
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_KEYBOARD_TEGRA is not set
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_PINEPHONE=m
# CONFIG_KEYBOARD_PXA27x is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=m
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_SH_KEYSC is not set
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_SPEAR is not set
CONFIG_KEYBOARD_TC3589X=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=m
# CONFIG_KEYBOARD_MT6779 is not set
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_KEYBOARD_CYPRESS_SF=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_LIFEBOOK=y
# CONFIG_MOUSE_PS2_TRACKPOINT is not set
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
# CONFIG_MOUSE_PS2_OLPC is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
CONFIG_MOUSE_BCM5974=m
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=m
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LEGACY_TIOCSTI is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
# CONFIG_SERIAL_ATMEL is not set
# CONFIG_SERIAL_MESON is not set
# CONFIG_SERIAL_CLPS711X is not set
# CONFIG_SERIAL_SAMSUNG is not set
# CONFIG_SERIAL_TEGRA is not set
# CONFIG_SERIAL_TEGRA_UTC is not set
# CONFIG_SERIAL_IMX is not set
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
# CONFIG_SERIAL_SH_SCI is not set
# CONFIG_SERIAL_HS_LPC32XX is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_MSM is not set
# CONFIG_SERIAL_VT8500 is not set
# CONFIG_SERIAL_OMAP is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
# CONFIG_SERIAL_MXS_AUART is not set
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_MPS2_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_SERIAL_MVEBU_UART is not set
# CONFIG_SERIAL_OWL is not set
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_MILBEAUT_USIO is not set
# CONFIG_SERIAL_LITEUART is not set
# CONFIG_SERIAL_SUNPLUS is not set
# CONFIG_SERIAL_NUVOTON_MA35D1 is not set
# CONFIG_SERIAL_ESP32 is not set
# CONFIG_SERIAL_ESP32_ACM is not set
# end of Serial drivers

# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=m
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=y
# CONFIG_NULL_TTY_DEFAULT_CONSOLE is not set
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_SSIF_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_AIROHA=y
CONFIG_HW_RANDOM_ATMEL=y
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_BCM74110=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
# CONFIG_HW_RANDOM_GEODE is not set
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_MXC_RNGA=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_INGENIC_RNG=y
CONFIG_HW_RANDOM_INGENIC_TRNG=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_HISI=y
# CONFIG_HW_RANDOM_HISTB is not set
# CONFIG_HW_RANDOM_ST is not set
CONFIG_HW_RANDOM_XGENE=y
CONFIG_HW_RANDOM_STM32=y
# CONFIG_HW_RANDOM_PIC32 is not set
# CONFIG_HW_RANDOM_MESON is not set
# CONFIG_HW_RANDOM_MTK is not set
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_HW_RANDOM_JH7110 is not set
CONFIG_HW_RANDOM_ROCKCHIP=y
CONFIG_APPLICOM=y
# CONFIG_MWAVE is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
# CONFIG_DEVPORT is not set
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TPM2_HMAC=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C=y
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=y
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=m
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=m
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_ATR is not set
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=m
# CONFIG_I2C_HIX5HD2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_I801_MUX=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=m
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_ZHAOXIN=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
# CONFIG_I2C_ASPEED is not set
# CONFIG_I2C_AT91 is not set
# CONFIG_I2C_AXXIA is not set
# CONFIG_I2C_BCM2835 is not set
# CONFIG_I2C_BCM_IPROC is not set
# CONFIG_I2C_BCM_KONA is not set
# CONFIG_I2C_BRCMSTB is not set
# CONFIG_I2C_CADENCE is not set
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDISP is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DIGICOLOR is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_EXYNOS5 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_GXP is not set
# CONFIG_I2C_HIGHLANDER is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_K1 is not set
# CONFIG_I2C_KEBA is not set
# CONFIG_I2C_LPC2K is not set
# CONFIG_I2C_LS2X is not set
# CONFIG_I2C_MLXBF is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MICROCHIP_CORE is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NOMADIK is not set
# CONFIG_I2C_NPCM is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PNX is not set
CONFIG_I2C_PXA=m
CONFIG_I2C_PXA_PCI=y
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
CONFIG_I2C_RK3X=y
# CONFIG_I2C_RTL9300 is not set
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_S3C2410 is not set
# CONFIG_I2C_SH_MOBILE is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
# CONFIG_I2C_ST is not set
# CONFIG_I2C_STM32F4 is not set
# CONFIG_I2C_STM32F7 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
# CONFIG_I2C_SYNQUACER is not set
# CONFIG_I2C_TEGRA_BPMP is not set
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
CONFIG_I2C_XILINX=m
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_LJCA=m
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_PCI1XXXX=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=y
CONFIG_I2C_FSI=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=m
CONFIG_PPS_DEBUG=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m
CONFIG_PPS_GENERATOR=m
CONFIG_PPS_GENERATOR_DUMMY=m

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_AMDISP is not set
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AT91 is not set
# CONFIG_PINCTRL_AT91PIO4 is not set
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AW9523=m
# CONFIG_PINCTRL_BM1880 is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_DA9062=m
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_EYEQ5 is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_K230 is not set
# CONFIG_PINCTRL_LOONGSON2 is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MAX77620=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_MICROCHIP_SGPIO=m
CONFIG_PINCTRL_OCELOT=m
CONFIG_PINCTRL_PALMAS=m
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SCMI is not set
CONFIG_PINCTRL_SINGLE=m
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_TH1520 is not set
# CONFIG_PINCTRL_MLXBF3 is not set
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
# CONFIG_PINCTRL_NSP_GPIO is not set
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
# CONFIG_PINCTRL_CS42L43 is not set
# CONFIG_PINCTRL_IMX1 is not set
# CONFIG_PINCTRL_IMX27 is not set
# CONFIG_PINCTRL_IMX25 is not set
# CONFIG_PINCTRL_IMX35 is not set
# CONFIG_PINCTRL_IMX50 is not set
# CONFIG_PINCTRL_IMX51 is not set
# CONFIG_PINCTRL_IMX53 is not set
# CONFIG_PINCTRL_IMX6Q is not set
# CONFIG_PINCTRL_IMX6SL is not set
# CONFIG_PINCTRL_IMX6SLL is not set
# CONFIG_PINCTRL_IMX6SX is not set
# CONFIG_PINCTRL_IMX6UL is not set
# CONFIG_PINCTRL_IMX7D is not set
# CONFIG_PINCTRL_IMX7ULP is not set
# CONFIG_PINCTRL_IMX8MM is not set
# CONFIG_PINCTRL_IMX8MN is not set
# CONFIG_PINCTRL_IMX8MP is not set
# CONFIG_PINCTRL_IMX8MQ is not set
# CONFIG_PINCTRL_IMX8QM is not set
# CONFIG_PINCTRL_IMX8QXP is not set
# CONFIG_PINCTRL_IMX8DXL is not set
# CONFIG_PINCTRL_IMX8ULP is not set
# CONFIG_PINCTRL_IMXRT1050 is not set
# CONFIG_PINCTRL_IMX93 is not set
# CONFIG_PINCTRL_VF610 is not set
# CONFIG_PINCTRL_IMXRT1170 is not set

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_INTEL_PLATFORM=m
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
CONFIG_PINCTRL_ELKHARTLAKE=y
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=m
CONFIG_PINCTRL_METEORPOINT=y
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
# CONFIG_PINCTRL_MERRIFIELD is not set
# CONFIG_PINCTRL_MOOREFIELD is not set
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_AIROHA is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT6893 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7981 is not set
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT7988 is not set
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8188 is not set
# CONFIG_PINCTRL_MT8192 is not set
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8196 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

# CONFIG_PINCTRL_MESON is not set
# CONFIG_PINCTRL_NOMADIK is not set
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
# CONFIG_PINCTRL_NPCM8XX is not set
# CONFIG_PINCTRL_MA35D1 is not set
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
# CONFIG_PINCTRL_MSM is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
# CONFIG_PINCTRL_PFC_R8A77990 is not set
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A779H0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SOPHGO_CV1800B is not set
# CONFIG_PINCTRL_SOPHGO_CV1812H is not set
# CONFIG_PINCTRL_SOPHGO_SG2000 is not set
# CONFIG_PINCTRL_SOPHGO_SG2002 is not set
# CONFIG_PINCTRL_SOPHGO_SG2042 is not set
# CONFIG_PINCTRL_SOPHGO_SG2044 is not set
# CONFIG_PINCTRL_SPACEMIT_K1 is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
# CONFIG_PINCTRL_STARFIVE_JH7100 is not set
# CONFIG_PINCTRL_STARFIVE_JH7110_SYS is not set
# CONFIG_PINCTRL_STARFIVE_JH7110_AON is not set
# CONFIG_PINCTRL_STM32F429 is not set
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_STM32MP257 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
# CONFIG_PINCTRL_UNIPHIER is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m
CONFIG_GPIO_IDIO_16=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BLZP1600 is not set
# CONFIG_GPIO_BRCMSTB is not set
CONFIG_GPIO_CADENCE=m
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DAVINCI is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EIC_SPRD is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_GE_FPGA is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRANITERAPIDS=m
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_LOONGSON_64BIT is not set
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
# CONFIG_GPIO_MVEBU is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_NOMADIK is not set
# CONFIG_GPIO_NPCM_SGPIO is not set
# CONFIG_GPIO_OMAP is not set
# CONFIG_GPIO_PL061 is not set
# CONFIG_GPIO_POLARFIRE_SOC is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_RTD=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SNPS_CREG is not set
# CONFIG_GPIO_SPACEMIT_K1 is not set
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
# CONFIG_GPIO_SYSCON is not set
CONFIG_GPIO_TANGIER=y
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VF610 is not set
# CONFIG_GPIO_VISCONTI is not set
CONFIG_GPIO_WCD934X=m
# CONFIG_GPIO_XGENE_SB is not set
CONFIG_GPIO_XILINX=m
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_ZYNQ is not set
# CONFIG_GPIO_ZYNQMP_MODEPIN is not set
CONFIG_GPIO_AMD_FCH=m
# CONFIG_GPIO_MSC313 is not set
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_TS5500 is not set
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_FXL6408=y
CONFIG_GPIO_DS4520=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ADP5585=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_CROS_EC is not set
# CONFIG_GPIO_DA9052 is not set
# CONFIG_HTC_EGPIO is not set
CONFIG_GPIO_ELKHARTLAKE=y
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_LJCA is not set
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=m
CONFIG_GPIO_MAX77650=m
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TN48M_CPLD is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WHISKEY_COVE is not set
CONFIG_GPIO_WM8350=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_MLXBF3 is not set
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_GPIO_MPSSE=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_LATCH=m
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

#
# GPIO Debugging utilities
#
# CONFIG_GPIO_VIRTUSER is not set
# end of GPIO Debugging utilities

CONFIG_DEV_SYNC_PROBE=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_AMD_AXI=y
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_MXC is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_HDQ_MASTER_OMAP is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=m
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_BRCMKONA is not set
# CONFIG_POWER_RESET_BRCMSTB is not set
# CONFIG_POWER_RESET_EP93XX is not set
# CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_OCELOT_RESET is not set
# CONFIG_POWER_RESET_ODROID_GO_ULTRA_POWEROFF is not set
# CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TORADEX_EC is not set
CONFIG_POWER_RESET_TPS65086=y
# CONFIG_POWER_RESET_KEYSTONE is not set
# CONFIG_POWER_RESET_SYSCON is not set
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_POWER_RESET_RMOBILE is not set
CONFIG_REBOOT_MODE=m
# CONFIG_SYSCON_REBOOT_MODE is not set
# CONFIG_POWER_RESET_SC27XX is not set
CONFIG_NVMEM_REBOOT_MODE=m
CONFIG_POWER_SEQUENCING=y
# CONFIG_POWER_SEQUENCING_QCOM_WCN is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_IP5XXX_POWER=y
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CHAGALL is not set
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_OLPC=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1720X=m
CONFIG_BATTERY_MAX1721X=y
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=m
# CONFIG_CHARGER_TWL6030 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX77705=m
CONFIG_CHARGER_MAX77976=y
# CONFIG_CHARGER_MAX8971 is not set
CONFIG_CHARGER_MAX8997=m
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_BATTERY_PM8916_BMS_VM is not set
# CONFIG_CHARGER_PM8916_LBC is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_RT9467=y
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_FUEL_GAUGE_SC27XX is not set
# CONFIG_FUEL_GAUGE_STC3117 is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=m
CONFIG_RN5T618_POWER=m
CONFIG_BATTERY_UG3105=y
CONFIG_FUEL_GAUGE_MM8013=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_SMPRO is not set
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CHIPCAP2 is not set
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=y
# CONFIG_SENSORS_GXP_FAN_CTRL is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_HS3001=m
CONFIG_SENSORS_HTU31=y
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=m
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_ISL28022 is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWERZ=m
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LENOVO_EC=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2991=y
# CONFIG_SENSORS_LTC2992 is not set
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_LTC4282=y
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX31760=m
CONFIG_MAX31827=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MAX77705 is not set
# CONFIG_SENSORS_MC34VR500 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7363=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NSA320 is not set
CONFIG_SENSORS_OCC_P8_I2C=m
CONFIG_SENSORS_OCC=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=y
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ACBEL_FSG032=y
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_ADP1050 is not set
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_BPA_RS600=y
CONFIG_SENSORS_CRPS=y
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
CONFIG_SENSORS_INA233=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LT3074 is not set
CONFIG_SENSORS_LT7182S=m
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_LTC4286=y
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2856 is not set
CONFIG_SENSORS_MP2888=m
# CONFIG_SENSORS_MP2891 is not set
CONFIG_SENSORS_MP2975=y
# CONFIG_SENSORS_MP2993 is not set
CONFIG_SENSORS_MP2975_REGULATOR=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_MP5920=y
# CONFIG_SENSORS_MP5990 is not set
# CONFIG_SENSORS_MP9941 is not set
# CONFIG_SENSORS_MPQ7932_REGULATOR is not set
CONFIG_SENSORS_MPQ7932=y
CONFIG_SENSORS_MPQ8785=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TDA38640=y
CONFIG_SENSORS_TDA38640_REGULATOR=y
CONFIG_SENSORS_TPS25990=m
CONFIG_SENSORS_TPS25990_REGULATOR=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_XDP710=y
CONFIG_SENSORS_XDPE152=m
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PT5161L=m
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC2305 is not set
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
# CONFIG_SENSORS_SFCTEMP is not set
# CONFIG_SENSORS_SG2042_MCU is not set
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_SPD5118=y
# CONFIG_SENSORS_SPD5118_DETECT is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_SENSORS_ASUS_WMI=m
CONFIG_SENSORS_HP_WMI=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_DEBUGFS=y
CONFIG_THERMAL_CORE_TESTING=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_CPU_THERMAL=y
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
# CONFIG_HISI_THERMAL is not set
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
# CONFIG_K3_THERMAL is not set
CONFIG_MAX77620_THERMAL=m
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_AIROHA_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
# CONFIG_KIRKWOOD_THERMAL is not set
# CONFIG_DOVE_THERMAL is not set
# CONFIG_ARMADA_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

#
# Mediatek thermal drivers
#
# CONFIG_MTK_THERMAL is not set
# end of Mediatek thermal drivers

#
# Intel thermal drivers
#
CONFIG_INTEL_TCC=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_BXT_PMIC_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=m
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
# CONFIG_BCM2835_THERMAL is not set
# CONFIG_BRCMSTB_THERMAL is not set
# CONFIG_BCM_NS_THERMAL is not set
# CONFIG_BCM_SR_THERMAL is not set
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

# CONFIG_RCAR_THERMAL is not set
# CONFIG_RCAR_GEN3_THERMAL is not set
# CONFIG_RZG2L_THERMAL is not set

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
# CONFIG_TEGRA_BPMP_THERMAL is not set
# CONFIG_TEGRA30_TSENSOR is not set
# end of NVIDIA Tegra thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
# CONFIG_SPRD_THERMAL is not set
# CONFIG_LOONGSON2_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ADP5585=m
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_SUN4I_GPADC is not set
CONFIG_MFD_AS3711=y
CONFIG_MFD_SMPRO=y
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CGBC is not set
# CONFIG_MFD_CROS_EC_DEV is not set
CONFIG_MFD_CS42L43=y
CONFIG_MFD_CS42L43_I2C=y
CONFIG_MFD_CS42L43_SDW=y
# CONFIG_MFD_MADERA is not set
CONFIG_MFD_MAX5970=m
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_ENE_KB3930 is not set
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=m
# CONFIG_MFD_HI655X_PMIC is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_INTEL_PMC_BXT=m
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_88PM886_PMIC is not set
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77541=y
CONFIG_MFD_MAX77620=m
CONFIG_MFD_MAX77650=m
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77705=m
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77759 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=m
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=m
CONFIG_MFD_RT5120=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK8XX_I2C is not set
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SEC_I2C is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=m
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_RZ_MTU3 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=m
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=m
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS65219 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS6594_I2C is not set
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=m
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_ROHM_BD718XX=m
# CONFIG_MFD_ROHM_BD71828 is not set
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_ROHM_BD96801=y
# CONFIG_MFD_STM32_LPTIMER is not set
# CONFIG_MFD_STM32_TIMERS is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_MFD_CS40L50_I2C is not set
CONFIG_MFD_RSMU_I2C=m
CONFIG_MFD_UPBOARD_FPGA=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ADP5055 is not set
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=m
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AW37503=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD718XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_BD957XMUF=m
CONFIG_REGULATOR_BD96801=m
CONFIG_REGULATOR_CROS_EC=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=m
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX5970 is not set
# CONFIG_REGULATOR_MAX77503 is not set
CONFIG_REGULATOR_MAX77541=m
CONFIG_REGULATOR_MAX77620=m
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX77857=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX20411=y
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6331=m
CONFIG_REGULATOR_MT6332=m
CONFIG_REGULATOR_MT6357=m
CONFIG_REGULATOR_MT6358=m
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PF9453=m
CONFIG_REGULATOR_PF8X00=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_QCOM_REFGEN is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RAA215300=m
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT4803 is not set
# CONFIG_REGULATOR_RT4831 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5120=m
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5739=y
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6190 is not set
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_RTQ2208 is not set
CONFIG_REGULATOR_S2MPA01=m
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=m
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_STPMIC1=m
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SUN20I is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=m
CONFIG_REGULATOR_TPS6287X=m
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
# CONFIG_REGULATOR_TPS65218 is not set
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_RZG2L_VBCTRL is not set
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=m
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
# CONFIG_LIRC is not set
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_RCMM_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
# CONFIG_IR_FINTEK is not set
CONFIG_IR_GPIO_CIR=m
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_IMON=m
CONFIG_IR_IMON_RAW=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MCEUSB=m
# CONFIG_IR_MESON is not set
# CONFIG_IR_MESON_TX is not set
# CONFIG_IR_MTK is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_SUNXI is not set
# CONFIG_IR_TOY is not set
CONFIG_IR_TTUSBIR=m
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_ATI_REMOTE=m
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_ST is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_IMG is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_SCREEN_INFO=y
CONFIG_VIDEO=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_TEGRA_HOST1X is not set
# CONFIG_IMX_IPUV3_CORE is not set
CONFIG_DRM=m

#
# DRM debugging options
#
# CONFIG_DRM_WERROR is not set
# CONFIG_DRM_DEBUG_MM is not set
# end of DRM debugging options

CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_DRAW=y
CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_FOREGROUND_COLOR=0xffffff
CONFIG_DRM_PANIC_BACKGROUND_COLOR=0x000000
CONFIG_DRM_PANIC_DEBUG=y
CONFIG_DRM_PANIC_SCREEN="user"
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_CLIENT=y
CONFIG_DRM_CLIENT_LIB=m
CONFIG_DRM_CLIENT_SELECTION=m
CONFIG_DRM_CLIENT_SETUP=y

#
# Supported DRM clients
#
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
# CONFIG_DRM_CLIENT_LOG is not set
CONFIG_DRM_CLIENT_DEFAULT_FBDEV=y
CONFIG_DRM_CLIENT_DEFAULT="fbdev"
# end of Supported DRM clients

CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_DP_AUX_BUS=m
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_BRIDGE_CONNECTOR=y
# CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
# CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV is not set
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_DSC_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_AUDIO_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_STATE_HELPER=y
CONFIG_DRM_TTM=m
CONFIG_DRM_EXEC=m
CONFIG_DRM_GPUVM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SUBALLOC_HELPER=m
CONFIG_DRM_SCHED=m

#
# Drivers for system framebuffers
#
CONFIG_DRM_SYSFB_HELPER=m
# CONFIG_DRM_EFIDRM is not set
# CONFIG_DRM_OFDRM is not set
CONFIG_DRM_SIMPLEDRM=m
# CONFIG_DRM_VESADRM is not set
# end of Drivers for system framebuffers

#
# ARM devices
#
# CONFIG_DRM_HDLCD is not set
# CONFIG_DRM_MALI_DISPLAY is not set
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
# CONFIG_DRM_AMDGPU is not set
CONFIG_DRM_NOUVEAU=m
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
CONFIG_NOUVEAU_DEBUG_PUSH=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_NOUVEAU_GSP_DEFAULT=y
# CONFIG_DRM_NOUVEAU_CH7006 is not set
CONFIG_DRM_NOUVEAU_SIL164=m
# CONFIG_DRM_I915 is not set
CONFIG_DRM_XE=m
# CONFIG_DRM_XE_DISPLAY is not set
CONFIG_DRM_XE_FORCE_PROBE=""

#
# drm/Xe Debugging
#
# CONFIG_DRM_XE_DEBUG_VM is not set
CONFIG_DRM_XE_DEBUG_MEMIRQ=y
CONFIG_DRM_XE_DEBUG_SRIOV=y
# CONFIG_DRM_XE_DEBUG_MEM is not set
CONFIG_DRM_XE_USERPTR_INVAL_INJECT=y
# end of drm/Xe Debugging

#
# drm/xe Profile Guided Optimisation
#
CONFIG_DRM_XE_JOB_TIMEOUT_MAX=10000
CONFIG_DRM_XE_JOB_TIMEOUT_MIN=1
CONFIG_DRM_XE_TIMESLICE_MAX=10000000
CONFIG_DRM_XE_TIMESLICE_MIN=1
CONFIG_DRM_XE_PREEMPT_TIMEOUT=640000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MAX=10000000
CONFIG_DRM_XE_PREEMPT_TIMEOUT_MIN=1
# CONFIG_DRM_XE_ENABLE_SCHEDTIMEOUT_LIMIT is not set
# end of drm/xe Profile Guided Optimisation

# CONFIG_DRM_KMB_DISPLAY is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_VKMS=m
# CONFIG_DRM_EXYNOS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_ATMEL_HLCDC is not set
# CONFIG_DRM_RCAR_DU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_USE_MIPI_DSI is not set
# CONFIG_DRM_RZG2L_USE_MIPI_DSI is not set
# CONFIG_DRM_SHMOBILE is not set
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_OMAP is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
# CONFIG_DRM_MSM is not set
# CONFIG_DRM_TEGRA is not set
# CONFIG_DRM_STM is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TD4320 is not set
CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A=m
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
CONFIG_DRM_PANEL_BOE_TV101WUM_LL2=m
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
# CONFIG_DRM_PANEL_DSI_CM is not set
CONFIG_DRM_PANEL_LVDS=m
# CONFIG_DRM_PANEL_HIMAX_HX8279 is not set
CONFIG_DRM_PANEL_HIMAX_HX83102=m
CONFIG_DRM_PANEL_HIMAX_HX83112A=m
CONFIG_DRM_PANEL_HIMAX_HX8394=m
# CONFIG_DRM_PANEL_ILITEK_ILI9805 is not set
CONFIG_DRM_PANEL_ILITEK_ILI9806E=m
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
# CONFIG_DRM_PANEL_JDI_LPM102A188A is not set
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=m
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
# CONFIG_DRM_PANEL_LINCOLNTECH_LCD197 is not set
CONFIG_DRM_PANEL_LG_SW43408=m
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
CONFIG_DRM_PANEL_NEWVISION_NV3051D=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=m
CONFIG_DRM_PANEL_NOVATEK_NT35950=m
# CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
# CONFIG_DRM_PANEL_NOVATEK_NT37801 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM67200=m
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m
CONFIG_DRM_PANEL_RAYDIUM_RM69380=m
CONFIG_DRM_PANEL_RONBO_RB070D30=m
CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01=m
# CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24=m
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7=m
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=m
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SONY_TD4353_JDI is not set
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
CONFIG_DRM_PANEL_EDP=m
CONFIG_DRM_PANEL_SIMPLE=m
CONFIG_DRM_PANEL_SUMMIT=m
# CONFIG_DRM_PANEL_SYNAPTICS_R63353 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=m
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
# CONFIG_DRM_PANEL_VISIONOX_G2647FB105 is not set
# CONFIG_DRM_PANEL_VISIONOX_R66451 is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_VISIONOX_RM692E5=m
CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
CONFIG_DRM_PANEL_XINPENG_XPP055C272=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y
CONFIG_DRM_AUX_BRIDGE=m

#
# Display Interface Bridges
#
CONFIG_DRM_CHIPONE_ICN6211=m
CONFIG_DRM_CHRONTEL_CH7033=m
CONFIG_DRM_CROS_EC_ANX7688=m
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_FSL_LDB is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_ITE_IT6263 is not set
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=m
CONFIG_DRM_LONTIUM_LT9211=m
# CONFIG_DRM_LONTIUM_LT9611 is not set
CONFIG_DRM_LONTIUM_LT9611UXC=m
CONFIG_DRM_ITE_IT66121=m
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SAMSUNG_DSIM=m
CONFIG_DRM_SIL_SII8620=m
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=m
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
CONFIG_DRM_TOSHIBA_TC358767=m
CONFIG_DRM_TOSHIBA_TC358768=m
CONFIG_DRM_TOSHIBA_TC358775=m
# CONFIG_DRM_TI_DLPC3433 is not set
CONFIG_DRM_TI_TDP158=m
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI83=m
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_TI_TPD12S015=m
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_ANALOGIX_ANX7625=m
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_CDNS_DSI_J721E=y
CONFIG_DRM_CDNS_MHDP8546=m
CONFIG_DRM_CDNS_MHDP8546_J721E=y
# CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE is not set
# CONFIG_DRM_IMX8MP_HDMI_PVI is not set
# CONFIG_DRM_IMX8QM_LDB is not set
# CONFIG_DRM_IMX8QXP_LDB is not set
# CONFIG_DRM_IMX8QXP_PIXEL_COMBINER is not set
# CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI is not set
# CONFIG_DRM_IMX93_MIPI_DSI is not set
# end of Display Interface Bridges

# CONFIG_DRM_STI is not set
# CONFIG_DRM_IMX_DCSS is not set
# CONFIG_DRM_IMX_LCDC is not set
# CONFIG_DRM_INGENIC is not set
# CONFIG_DRM_V3D is not set
# CONFIG_DRM_VC4 is not set
# CONFIG_DRM_LOONGSON is not set
CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_HISI_KIRIN is not set
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_IMX_LCDIF is not set
# CONFIG_DRM_MESON is not set
# CONFIG_DRM_APPLETBDRM is not set
CONFIG_DRM_ARCPGU=m
CONFIG_DRM_BOCHS=m
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PL111 is not set
# CONFIG_DRM_TVE200 is not set
CONFIG_DRM_VBOXVIDEO=m
# CONFIG_DRM_LIMA is not set
# CONFIG_DRM_PANFROST is not set
# CONFIG_DRM_PANTHOR is not set
# CONFIG_DRM_ASPEED_GFX is not set
# CONFIG_DRM_MCDE is not set
# CONFIG_DRM_TIDSS is not set
CONFIG_DRM_GUD=m
# CONFIG_DRM_ST7571_I2C is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_SPRD is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m

#
# Frame buffer Devices
#
CONFIG_FB=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_CIRRUS=m
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CLPS711X is not set
# CONFIG_FB_IMX is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=m
# CONFIG_FB_CONTROL is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_GBE is not set
# CONFIG_FB_PVR2 is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_ATMEL is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_WM8505 is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
# CONFIG_FB_GEODE_GX is not set
# CONFIG_FB_GEODE_GX1 is not set
# CONFIG_FB_PXA168 is not set
# CONFIG_FB_S3C is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=y
# CONFIG_FB_SM712 is not set
# CONFIG_MMP_DISP is not set
CONFIG_FB_CORE=y
CONFIG_FB_NOTIFY=y
# CONFIG_FIRMWARE_EDID is not set
# CONFIG_FB_DEVICE is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYSMEM_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_DMAMEM_HELPERS=y
CONFIG_FB_DMAMEM_HELPERS_DEFERRED=y
CONFIG_FB_IOMEM_FOPS=y
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_KTD2801 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_APPLE_DWI is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3509=m
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_TPS65217=m
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
# CONFIG_SND_UTIMER is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
# CONFIG_SND_SEQ_UMP is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=m
CONFIG_SND_PCMTEST=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=y
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=m
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_SB_COMMON=m
CONFIG_SND_ISA=y
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT1605 is not set
# CONFIG_SND_AZT2316 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8328 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_SC6000 is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_JAZZ16 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_MSND_PINNACLE is not set
# CONFIG_SND_MSND_CLASSIC is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS4000=m
CONFIG_SND_ASIHPI=y
# CONFIG_SND_ATIIXP is not set
CONFIG_SND_ATIIXP_MODEM=y
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=y
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=y
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=y
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_NEW_DSP is not set
# CONFIG_SND_CS5530 is not set
CONFIG_SND_CS5535AUDIO=m
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=y
CONFIG_SND_LAYLA20=y
CONFIG_SND_DARLA24=y
CONFIG_SND_GINA24=y
CONFIG_SND_LAYLA24=y
CONFIG_SND_MONA=m
CONFIG_SND_MIA=y
# CONFIG_SND_ECHO3G is not set
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=m
# CONFIG_SND_INDIGODJ is not set
CONFIG_SND_INDIGOIOX=y
CONFIG_SND_INDIGODJX=y
CONFIG_SND_ENS1370=y
CONFIG_SND_ENS1371=m
CONFIG_SND_FM801=m
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
CONFIG_SND_HDSPM=y
CONFIG_SND_ICE1724=y
# CONFIG_SND_INTEL8X0 is not set
CONFIG_SND_INTEL8X0M=y
CONFIG_SND_KORG1212=m
# CONFIG_SND_LOLA is not set
CONFIG_SND_LX6464ES=m
# CONFIG_SND_MIXART is not set
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
# CONFIG_SND_RME32 is not set
CONFIG_SND_RME96=y
CONFIG_SND_RME9652=y
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=y
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=y
# CONFIG_SND_HDA_ACPI is not set
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_SCODEC_COMPONENT=m
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set
CONFIG_SND_HDA_SCODEC_TAS2781=m
CONFIG_SND_HDA_SCODEC_TAS2781_I2C=m

#
# Set to Y if you want auto-loading the side codec driver
#
CONFIG_SND_HDA_CODEC_REALTEK=m

#
# Set to Y if you want auto-loading the codec driver
#
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
# CONFIG_SND_HDA_CODEC_HDMI is not set
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
CONFIG_SND_HDA_CODEC_CS8409=m

#
# Set to Y if you want auto-loading the codec driver
#
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_SENARYTECH=y
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
CONFIG_SND_HDA_CTL_DEV_ID=y
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_ADI=y
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
# CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_SOC_AMD_ST_ES8336_MACH=m
CONFIG_SND_SOC_AMD_ACP3x=m
CONFIG_SND_SOC_AMD_RV_RT5682_MACH=m
CONFIG_SND_SOC_AMD_RENOIR=y
CONFIG_SND_SOC_AMD_RENOIR_MACH=y
# CONFIG_SND_SOC_AMD_ACP5x is not set
CONFIG_SND_SOC_AMD_ACP6x=m
CONFIG_SND_SOC_AMD_YC_MACH=m
CONFIG_SND_AMD_ACP_CONFIG=y
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_SOC_AMD_RPL_ACP6x=m
# CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL is not set
# CONFIG_SND_SOC_APPLE_MCA is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM2835_SOC_I2S is not set
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
# CONFIG_SND_EP93XX_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_MQS is not set
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=m
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_FSL_AUD2HTX is not set
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_FSL_RPMSG=m
# CONFIG_SND_SOC_FSL_LPC3XXX is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# CONFIG_SND_IMX_SOC is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_SOC_CHV3_I2S is not set
CONFIG_SND_I2S_HI6210_I2S=m
# CONFIG_SND_JZ4740_SOC_I2S is not set
# CONFIG_SND_KIRKWOOD_SOC is not set

#
# SoC Audio for Loongson CPUs
#
# CONFIG_SND_SOC_LOONGSON_CARD is not set
# CONFIG_SND_SOC_LOONGSON_I2S_PCI is not set
# CONFIG_SND_SOC_LOONGSON_I2S_PLATFORM is not set
# end of SoC Audio for Loongson CPUs

# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_INTEL_KEEMBAY is not set
CONFIG_SND_SOC_INTEL_AVS=y

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_CARDNAME_OBSOLETE is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_ES8336=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_PCM3168A is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT274=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5514 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5663 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=m
CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
# end of Intel AVS Machine drivers

# CONFIG_SND_SOC_MT8186 is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_MT8188 is not set
# CONFIG_SND_SOC_MT8195 is not set
# CONFIG_SND_SOC_MT8365 is not set

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
# CONFIG_SND_MESON_AXG_FRDDR is not set
# CONFIG_SND_MESON_AXG_TODDR is not set
# CONFIG_SND_MESON_AXG_TDMIN is not set
# CONFIG_SND_MESON_AXG_TDMOUT is not set
# CONFIG_SND_MESON_AXG_SOUND_CARD is not set
# CONFIG_SND_MESON_AXG_SPDIFOUT is not set
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
# CONFIG_SND_MESON_AXG_PDM is not set
# CONFIG_SND_MESON_GX_SOUND_CARD is not set
# CONFIG_SND_MESON_G12A_TOACODEC is not set
# CONFIG_SND_MESON_G12A_TOHDMITX is not set
# CONFIG_SND_SOC_MESON_T9015 is not set
# end of ASoC support for Amlogic platforms

# CONFIG_SND_MXS_SOC is not set
# CONFIG_SND_PXA2XX_SOC is not set
# CONFIG_SND_SOC_QCOM is not set

#
# SoC Audio support for Renesas SoCs
#
# CONFIG_SND_SOC_SH4_FSI is not set
# CONFIG_SND_SOC_RCAR is not set
# CONFIG_SND_SOC_MSIOF is not set
# CONFIG_SND_SOC_RZ is not set
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_ROCKCHIP is not set
# CONFIG_SND_SOC_SAMSUNG is not set
CONFIG_SND_SOC_SDCA_OPTIONAL=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=y
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_OF=m
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_IMX_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_MTK_TOPLEVEL is not set
# CONFIG_SND_SOC_SPRD is not set
# CONFIG_SND_SOC_STARFIVE is not set
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_STM32_SAI is not set
# CONFIG_SND_SOC_STM32_I2S is not set
# CONFIG_SND_SOC_STM32_SPDIFRX is not set
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
# CONFIG_SND_SUN4I_CODEC is not set
# CONFIG_SND_SUN8I_CODEC is not set
# CONFIG_SND_SUN8I_CODEC_ANALOG is not set
# CONFIG_SND_SUN50I_CODEC_ANALOG is not set
# CONFIG_SND_SUN4I_I2S is not set
# CONFIG_SND_SUN4I_SPDIF is not set
# CONFIG_SND_SUN50I_DMIC is not set
# end of Allwinner SoC Audio support

# CONFIG_SND_SOC_TEGRA is not set

#
# Audio support for Texas Instruments SoCs
#

#
# Texas Instruments DAI support for:
#
# CONFIG_SND_SOC_DAVINCI_ASP is not set
# CONFIG_SND_SOC_DAVINCI_MCASP is not set
# CONFIG_SND_SOC_OMAP_DMIC is not set
# CONFIG_SND_SOC_OMAP_MCBSP is not set
# CONFIG_SND_SOC_OMAP_MCPDM is not set

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP3_TWL4030 is not set
# CONFIG_SND_SOC_OMAP_ABE_TWL6040 is not set
# CONFIG_SND_SOC_OMAP_AMS_DELTA is not set
# CONFIG_SND_SOC_OMAP_HDMI is not set
# CONFIG_SND_SOC_J721E_EVM is not set
# end of Audio support for Texas Instruments SoCs

# CONFIG_SND_SOC_UNIPHIER is not set
CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_ALL_CODECS is not set
CONFIG_SND_SOC_WM_ADSP=y
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
CONFIG_SND_SOC_ADAU1373=y
CONFIG_SND_SOC_ADAU1701=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU7002 is not set
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4375=y
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4619=m
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_AUDIO_IIO_AUX is not set
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_AW88395_LIB=y
CONFIG_SND_SOC_AW88395=m
CONFIG_SND_SOC_AW88166=y
CONFIG_SND_SOC_AW88261=m
# CONFIG_SND_SOC_AW88081 is not set
CONFIG_SND_SOC_AW87390=m
# CONFIG_SND_SOC_AW88399 is not set
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CHV3_CODEC=y
# CONFIG_SND_SOC_CPCAP is not set
CONFIG_SND_SOC_CROS_EC_CODEC=m
CONFIG_SND_SOC_CS_AMP_LIB=m
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_I2C=y
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_I2C=y
CONFIG_SND_SOC_CS35L56=m
CONFIG_SND_SOC_CS35L56_SHARED=m
# CONFIG_SND_SOC_CS35L56_I2C is not set
CONFIG_SND_SOC_CS35L56_SDW=m
CONFIG_SND_SOC_CS42L42_CORE=y
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L42_SDW=y
CONFIG_SND_SOC_CS42L43=m
CONFIG_SND_SOC_CS42L43_SDW=m
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=m
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS42L83=m
CONFIG_SND_SOC_CS42L84=y
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CS530X=m
CONFIG_SND_SOC_CS530X_I2C=m
CONFIG_SND_SOC_CX2072X=y
# CONFIG_SND_SOC_JZ4740_CODEC is not set
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
# CONFIG_SND_SOC_JZ4770_CODEC is not set
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=m
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=y
# CONFIG_SND_SOC_ES8311 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8323 is not set
# CONFIG_SND_SOC_ES8326 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_ES8375 is not set
# CONFIG_SND_SOC_ES8389 is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=y
CONFIG_SND_SOC_ICS43432=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MAX98088=m
# CONFIG_SND_SOC_MAX98090 is not set
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98520=y
CONFIG_SND_SOC_MAX98363=m
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98388=m
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_PCM6240=y
# CONFIG_SND_SOC_RK3308 is not set
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RK817 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
# CONFIG_SND_SOC_RT1017_SDCA_SDW is not set
# CONFIG_SND_SOC_RT1308_SDW is not set
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT1318_SDW=m
CONFIG_SND_SOC_RT1320_SDW=y
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
# CONFIG_SND_SOC_RT5682_SDW is not set
CONFIG_SND_SOC_RT700=y
CONFIG_SND_SOC_RT700_SDW=y
CONFIG_SND_SOC_RT711=y
CONFIG_SND_SOC_RT711_SDW=y
# CONFIG_SND_SOC_RT711_SDCA_SDW is not set
CONFIG_SND_SOC_RT712_SDCA_SDW=m
CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=m
# CONFIG_SND_SOC_RT721_SDCA_SDW is not set
# CONFIG_SND_SOC_RT722_SDCA_SDW is not set
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
# CONFIG_SND_SOC_RT715_SDCA_SDW is not set
CONFIG_SND_SOC_RT9120=m
# CONFIG_SND_SOC_RT9123 is not set
# CONFIG_SND_SOC_RT9123P is not set
CONFIG_SND_SOC_RTQ9128=y
# CONFIG_SND_SOC_SDW_MOCKUP is not set
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SMA1303=y
CONFIG_SND_SOC_SMA1307=m
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
# CONFIG_SND_SOC_SSM2305 is not set
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM3515 is not set
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=m
# CONFIG_SND_SOC_TAS2780 is not set
CONFIG_SND_SOC_TAS2781_COMLIB=m
CONFIG_SND_SOC_TAS2781_COMLIB_I2C=m
CONFIG_SND_SOC_TAS2781_FMWLIB=m
CONFIG_SND_SOC_TAS2781_I2C=m
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=m
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC31XX=y
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_UDA1342=m
CONFIG_SND_SOC_WCD_CLASSH=y
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WCD_MBHC=y
CONFIG_SND_SOC_WCD934X=m
CONFIG_SND_SOC_WCD937X=y
CONFIG_SND_SOC_WCD937X_SDW=y
# CONFIG_SND_SOC_WCD938X_SDW is not set
# CONFIG_SND_SOC_WCD939X_SDW is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=y
# CONFIG_SND_SOC_WM8731_I2C is not set
CONFIG_SND_SOC_WM8737=m
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=m
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=m
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_WSA881X=m
CONFIG_SND_SOC_WSA883X=y
CONFIG_SND_SOC_WSA884X=y
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
# CONFIG_SND_SOC_MT6357 is not set
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8821=y
CONFIG_SND_SOC_NAU8822=m
# CONFIG_SND_SOC_NAU8824 is not set
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_NTPFW=y
CONFIG_SND_SOC_NTP8918=m
CONFIG_SND_SOC_NTP8835=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
CONFIG_SND_SOC_LPASS_VA_MACRO=y
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD2=m
# CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE is not set
CONFIG_SND_TEST_COMPONENT=m
CONFIG_SND_X86=y
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y
CONFIG_HID_SUPPORT=y
# CONFIG_HID is not set

#
# USB HID support
#
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# end of USB HID Boot Protocol drivers
# end of USB HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=m
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=m
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=1
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PCI_RENESAS=m
CONFIG_USB_XHCI_PLATFORM=m
# CONFIG_USB_XHCI_HISTB is not set
# CONFIG_USB_XHCI_MTK is not set
# CONFIG_USB_XHCI_MVEBU is not set
# CONFIG_USB_XHCI_RCAR is not set
# CONFIG_USB_XHCI_SIDEBAND is not set
# CONFIG_USB_BRCMSTB is not set
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_FSL=m
# CONFIG_USB_EHCI_HCD_NPCM7XX is not set
# CONFIG_USB_EHCI_HCD_OMAP is not set
# CONFIG_USB_EHCI_HCD_ORION is not set
# CONFIG_USB_EHCI_HCD_SPEAR is not set
# CONFIG_USB_EHCI_HCD_STI is not set
# CONFIG_USB_EHCI_HCD_AT91 is not set
# CONFIG_USB_EHCI_SH is not set
# CONFIG_USB_EHCI_EXYNOS is not set
# CONFIG_USB_EHCI_MV is not set
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_TEST_MODE=y
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set

#
# USB dual-mode controller drivers
#
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_GADGET=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_CDNS3_TI=m
CONFIG_USB_CDNS3_IMX=m
# CONFIG_USB_CDNS3_STARFIVE is not set
CONFIG_USB_CDNSP_PCI=m
# CONFIG_USB_CDNSP_GADGET is not set
# CONFIG_USB_CDNSP_HOST is not set
# CONFIG_USB_FOTG210 is not set
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_DSPS is not set
# CONFIG_USB_MUSB_UX500 is not set
# CONFIG_USB_MUSB_JZ4740 is not set
# CONFIG_USB_MUSB_MEDIATEK is not set
# CONFIG_USB_MUSB_POLARFIRE_SOC is not set

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
# CONFIG_USB_CHIPIDEA_UDC is not set
CONFIG_USB_CHIPIDEA_HOST=y
# CONFIG_USB_CHIPIDEA_PCI is not set
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_NPCM=m
CONFIG_USB_CHIPIDEA_IMX=m
# CONFIG_USB_CHIPIDEA_GENERIC is not set
# CONFIG_USB_CHIPIDEA_TEGRA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_LJCA=m
CONFIG_USB_SISUSBVGA=m
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_BRCM_USB_PINMAP is not set
CONFIG_USB_ONBOARD_DEV=m
CONFIG_USB_ONBOARD_DEV_USB5744=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_KEYSTONE_USB_PHY is not set
CONFIG_NOP_USB_XCEIV=m
# CONFIG_AM335X_PHY_USB is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_TEGRA_PHY is not set
# CONFIG_USB_ULPI is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
# CONFIG_USB_LPC32XX is not set
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=m
# CONFIG_USB_RZV2M_USB3DRD is not set
# CONFIG_USB_RENESAS_USB3 is not set
# CONFIG_USB_RENESAS_USBF is not set
# CONFIG_USB_PXA27X is not set
CONFIG_USB_SNP_CORE=m
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=m
CONFIG_USB_BDC_UDC=m
CONFIG_USB_AMD5536UDC=m
CONFIG_USB_NET2280=m
CONFIG_USB_GOKU=m
CONFIG_USB_EG20T=m
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_ASPEED_UDC is not set
# CONFIG_USB_ASPEED_VHUB is not set
CONFIG_USB_CDNS2_UDC=m
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC1_LEGACY=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
# CONFIG_USB_CONFIGFS_F_MIDI2 is not set
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_AUDIO=m
# CONFIG_GADGET_UAC1 is not set
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=m
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_G_SERIAL=m
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
CONFIG_USB_G_HID=m
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_TCPCI_MAXIM=m
# CONFIG_TYPEC_FUSB302 is not set
CONFIG_TYPEC_WCOVE=m
# CONFIG_TYPEC_QCOM_PMIC is not set
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
CONFIG_UCSI_STM32G0=m
CONFIG_TYPEC_TPS6598X=m
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_STUSB160X=m
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_GPIO_SBU=m
CONFIG_TYPEC_MUX_PI3USB30532=m
# CONFIG_TYPEC_MUX_INTEL_PMC is not set
# CONFIG_TYPEC_MUX_IT5205 is not set
CONFIG_TYPEC_MUX_NB7VPQ904M=m
CONFIG_TYPEC_MUX_PS883X=m
# CONFIG_TYPEC_MUX_PTN36502 is not set
# CONFIG_TYPEC_MUX_TUSB1046 is not set
CONFIG_TYPEC_MUX_WCD939X_USBSS=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
CONFIG_TYPEC_TBT_ALTMODE=y
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_LEDS_EXPRESSWIRE=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_APU=y
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_AW200XX=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
# CONFIG_LEDS_SUN50I_A100 is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP5569=m
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=m
# CONFIG_LEDS_LP8864 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_PCA995X=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MAX5970=m
# CONFIG_LEDS_NS2 is not set
# CONFIG_LEDS_NETXBIG is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_MAX77705=m
# CONFIG_LEDS_MAX8997 is not set
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y
CONFIG_LEDS_UPBOARD=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_BLINKM_MULTICOLOR is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
# CONFIG_LEDS_LM3697 is not set
# CONFIG_LEDS_LM36274 is not set
CONFIG_LEDS_ST1202=y
# CONFIG_LEDS_IP30 is not set
# CONFIG_LEDS_BCM63138 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MAX77693=m
# CONFIG_LEDS_QCOM_FLASH is not set
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=y
CONFIG_LEDS_SY7802=y
# CONFIG_LEDS_TPS6131X is not set

#
# RGB LED drivers
#
CONFIG_LEDS_GROUP_MULTICOLOR=m
CONFIG_LEDS_KTD202X=m
# CONFIG_LEDS_NCP5623 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_TTY is not set
CONFIG_LEDS_TRIGGER_INPUT_EVENTS=m

#
# Simatic LED drivers
#
CONFIG_LEDS_SIEMENS_SIMATIC_IPC=y
CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE=m
# CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_SCRUB is not set
# CONFIG_EDAC_ECS is not set
CONFIG_EDAC_MEM_REPAIR=y
# CONFIG_EDAC_AL_MC is not set
CONFIG_EDAC_AMD76X=m
# CONFIG_EDAC_E7XXX is not set
CONFIG_EDAC_E752X=m
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_X38 is not set
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
CONFIG_EDAC_R82600=y
CONFIG_EDAC_I5100=y
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_XGENE is not set
# CONFIG_EDAC_ZYNQMP is not set
# CONFIG_EDAC_NPCM is not set
# CONFIG_EDAC_VERSAL is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_UIO=y
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_GROUP=y
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_DEBUGFS is not set

#
# VFIO support for PCI devices
#
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_VIRTIO_VFIO_PCI=m
# CONFIG_VIRTIO_VFIO_PCI_ADMIN_LEGACY is not set
# end of VFIO support for PCI devices

#
# VFIO support for platform devices
#
# CONFIG_VFIO_PLATFORM is not set
# CONFIG_VFIO_AMBA is not set
# end of VFIO support for platform devices

CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=m
CONFIG_VIRTIO_PCI_LIB_LEGACY=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_ADMIN_LEGACY=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
CONFIG_VIRTIO_DEBUG=y
# CONFIG_VIRTIO_RTC is not set
CONFIG_VHOST_MENU=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
# CONFIG_COMEDI_PCL818 is not set
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
# CONFIG_COMEDI_RTI800 is not set
# CONFIG_COMEDI_RTI802 is not set
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=m
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
# CONFIG_COMEDI_DAS6402 is not set
# CONFIG_COMEDI_DT2801 is not set
CONFIG_COMEDI_DT2811=m
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=m
# CONFIG_COMEDI_DT2817 is not set
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
# CONFIG_COMEDI_FL512 is not set
CONFIG_COMEDI_AIO_AIO12_8=m
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
# CONFIG_COMEDI_NI_LABPC_ISA is not set
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
CONFIG_COMEDI_TESTS_NI_ROUTES=m
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_ACPI=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=y
# CONFIG_CHROMEOS_OF_HW_PROBER is not set
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
# CONFIG_CZNIC_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLX_PLATFORM is not set
# CONFIG_MLXREG_DPU is not set
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
# CONFIG_MLXREG_LC is not set
CONFIG_NVSW_SN2201=m
CONFIG_OLPC_EC=y
# CONFIG_OLPC_XO175 is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_MXM_WMI=m
CONFIG_NVIDIA_WMI_EC_BACKLIGHT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_GIGABYTE_WMI=m
CONFIG_YOGABOOK=m
CONFIG_ACER_WIRELESS=m

#
# AMD HSMP Driver
#
# CONFIG_AMD_HSMP_ACPI is not set
# CONFIG_AMD_HSMP_PLAT is not set
# end of AMD HSMP Driver

CONFIG_AMD_WBRF=y
CONFIG_ADV_SWBUTTON=y
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=m
CONFIG_ALIENWARE_WMI_LEGACY=y
# CONFIG_ALIENWARE_WMI_WMAX is not set
CONFIG_DCDBAS=y
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_SMO8800=y
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_DDV is not set
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_WMI_SYSMAN=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
CONFIG_WIRELESS_HOTKEY=y
# CONFIG_IBM_RTL is not set
# CONFIG_IDEAPAD_LAPTOP is not set
CONFIG_LENOVO_WMI_HOTKEY_UTILITIES=m
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_INTEL_SAR_INT1092=m
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_INTEL_MRFLD_PWRBTN=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_VSEC=m
CONFIG_ACPI_QUICKSTART=m
CONFIG_MEEGOPAD_ANX7428=m
CONFIG_MSI_WMI=m
CONFIG_MSI_WMI_PLATFORM=m
# CONFIG_XO15_EBOOK is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=m
CONFIG_TOSHIBA_WMI=m
CONFIG_ACPI_CMPC=y
CONFIG_PANASONIC_LAPTOP=m
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_INSPUR_PLATFORM_PROFILE=m
# CONFIG_LENOVO_WMI_CAMERA is not set
# CONFIG_DASHARO_ACPI is not set
CONFIG_FW_ATTR_CLASS=m
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_SIEMENS_SIMATIC_IPC=y
CONFIG_SIEMENS_SIMATIC_IPC_BATT=m
# CONFIG_SIEMENS_SIMATIC_IPC_BATT_APOLLOLAKE is not set
CONFIG_SIEMENS_SIMATIC_IPC_BATT_ELKHARTLAKE=m
CONFIG_SILICOM_PLATFORM=m
CONFIG_WINMATE_FM07_KEYS=y
CONFIG_SEL3350_PLATFORM=m
CONFIG_P2SB=y
# CONFIG_ARM64_PLATFORM_DEVICES is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RP1 is not set
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_TPS68470 is not set
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_EP93XX is not set
# CONFIG_COMMON_CLK_EYEQ is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_CLK_TWL is not set
CONFIG_CLK_TWL6040=y
CONFIG_COMMON_CLK_AXI_CLKGEN=m
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_NPCM8XX is not set
# CONFIG_COMMON_CLK_LOONGSON2 is not set
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_RS9_PCIE=y
# CONFIG_COMMON_CLK_SI521XX is not set
# CONFIG_COMMON_CLK_VC3 is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_VC7=m
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
CONFIG_COMMON_CLK_BD718XX=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
# CONFIG_COMMON_CLK_SP7021 is not set
# CONFIG_CLK_ACTIONS is not set
# CONFIG_CLK_BAIKAL_T1 is not set
# CONFIG_CLK_BCM2711_DVP is not set
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM63268_TIMER is not set
# CONFIG_CLK_BCM_KONA is not set
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
# CONFIG_COMMON_CLK_HI3798CV200 is not set
# CONFIG_COMMON_CLK_HI6220 is not set
# CONFIG_RESET_HISI is not set
# CONFIG_COMMON_CLK_BOSTON is not set
# CONFIG_MXC_CLK is not set
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
# CONFIG_CLK_IMX8MP is not set
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set
# CONFIG_CLK_IMX95_BLK_CTL is not set
# CONFIG_CLK_IMXRT1050 is not set

#
# Ingenic SoCs drivers
#
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4755 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
# CONFIG_COMMON_CLK_MEDIATEK_FHCTL is not set
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6735 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7981 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT7988 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8188 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_CPUPLL is not set
# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_COMMON_CLK_NUVOTON=y
CONFIG_CLK_MA35D1=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_MTMIPS is not set
# CONFIG_CLK_RENESAS is not set
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_CLK_SIFIVE is not set
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_CLK_SOPHGO_CV1800 is not set
# CONFIG_CLK_SOPHGO_SG2042_PLL is not set
# CONFIG_CLK_SOPHGO_SG2044 is not set
# CONFIG_CLK_SOPHGO_SG2044_PLL is not set
# CONFIG_SPACEMIT_CCU is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_STARFIVE_JH7110_PLL is not set
# CONFIG_CLK_STARFIVE_JH7110_SYS is not set
# CONFIG_CLK_SUNXI is not set
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_STM32MP=y
CONFIG_COMMON_CLK_STM32MP135=y
CONFIG_COMMON_CLK_STM32MP157=y
CONFIG_COMMON_CLK_STM32MP257=y
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=m
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
# CONFIG_ECONET_EN751221_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_REALTEK_OTTO_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_MTK_CPUX_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_LOONGSON1_PWM is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_RALINK_TIMER is not set
# CONFIG_NXP_STM_TIMER is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
# CONFIG_IOMMU_IO_PGTABLE_DART is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_ARM_SMMU is not set
# CONFIG_QCOM_IOMMU is not set
# CONFIG_IOMMUFD is not set
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
# CONFIG_SUN50I_IOMMU is not set
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_IPMMU_VMSA is not set
# CONFIG_APPLE_DART is not set
# CONFIG_MTK_IOMMU is not set
# CONFIG_MTK_IOMMU_V1 is not set
CONFIG_VIRTIO_IOMMU=y
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_AMD=y
CONFIG_SOUNDWIRE_CADENCE=y
CONFIG_SOUNDWIRE_INTEL=y
CONFIG_SOUNDWIRE_QCOM=y
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=y

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
# CONFIG_ASPEED_LPC_SNOOP is not set
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
# CONFIG_DPAA2_CONSOLE is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# Hisilicon SoC drivers
#
# end of Hisilicon SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# CONFIG_SOC_IMX9 is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_LOONGSON2_GUTS is not set

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
# CONFIG_MTK_INFRACFG is not set
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_REGULATOR_COUPLER is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
# CONFIG_QCOM_RAMP_CTRL is not set
# CONFIG_QCOM_RMTFS_MEM is not set
# CONFIG_QCOM_RPM_MASTER_STATS is not set
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
# CONFIG_SOC_SAMSUNG is not set

#
# Sophgo SoC drivers
#
# CONFIG_SOPHGO_CV1800_RTCSYS is not set
# CONFIG_SOPHGO_SG2044_TOPSYS is not set
# end of Sophgo SoC drivers

# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_TI_PRUSS is not set
# CONFIG_UX500_SOC_ID is not set
# CONFIG_SOC_INTEGRATOR_CM is not set
# CONFIG_SOC_REALVIEW is not set

#
# VIA/WonderMedia SoC drivers
#
# CONFIG_WMT_SOCINFO is not set
# end of VIA/WonderMedia SoC drivers

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic PM Domains
#
# CONFIG_MESON_EE_PM_DOMAINS is not set
# end of Amlogic PM Domains

# CONFIG_APPLE_PMGR_PWRSTATE is not set
# CONFIG_ARM_SCMI_PERF_DOMAIN is not set
# CONFIG_ARM_SCMI_POWER_DOMAIN is not set
# CONFIG_ARM_SCPI_POWER_DOMAIN is not set

#
# Broadcom PM Domains
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_BCM_PMB is not set
# CONFIG_BCM63XX_POWER is not set
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# CONFIG_IMX_GPCV2_PM_DOMAINS is not set
# end of i.MX PM Domains

#
# MediaTek PM Domains
#
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
# end of MediaTek PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains

# CONFIG_UX500_PM_DOMAIN is not set
# CONFIG_JH71XX_PMU is not set
# CONFIG_SUN20I_PPU is not set
# CONFIG_SUN50I_H6_PRCM_PPU is not set
# end of PM Domains

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=m
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_INTEL_MRFLD=m
CONFIG_EXTCON_LC824206XA=m
# CONFIG_EXTCON_MAX14577 is not set
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_MAX14526 is not set
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_EXTCON_USBC_TUSB320=y
# CONFIG_EXTCON_RTK_TYPE_C is not set
CONFIG_MEMORY=y
# CONFIG_ATMEL_EBI is not set
# CONFIG_BRCMSTB_DPFE is not set
# CONFIG_BRCMSTB_MEMC is not set
# CONFIG_BT1_L2_CTL is not set
# CONFIG_TI_AEMIF is not set
# CONFIG_TI_EMIF is not set
# CONFIG_OMAP_GPMC is not set
# CONFIG_MVEBU_DEVBUS is not set
# CONFIG_FSL_CORENET_CF is not set
# CONFIG_FSL_IFC is not set
# CONFIG_JZ4780_NEMC is not set
# CONFIG_MTK_SMI is not set
# CONFIG_DA8XX_DDRCTL is not set
# CONFIG_RENESAS_RPCIF is not set
# CONFIG_STM32_FMC2_EBI is not set
# CONFIG_STM32_OMM is not set
# CONFIG_SAMSUNG_MC is not set
# CONFIG_TEGRA_MC is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_GTS_HELPER=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
# CONFIG_IIO_TRIGGERED_EVENT is not set
CONFIG_IIO_BACKEND=m

#
# Accelerometers
#
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL355=m
CONFIG_ADXL355_I2C=m
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
CONFIG_ADXL380=m
CONFIG_ADXL380_I2C=m
# CONFIG_BMA180 is not set
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMI088_ACCEL=m
CONFIG_BMI088_ACCEL_I2C=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
CONFIG_IIO_KX022A=m
CONFIG_IIO_KX022A_I2C=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7291 is not set
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD799X=m
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_ASPEED_ADC is not set
# CONFIG_AT91_ADC is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=m
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_EP93XX_ADC is not set
# CONFIG_EXYNOS_ADC is not set
CONFIG_GEHC_PMC_ADC=m
# CONFIG_HX711 is not set
# CONFIG_INGENIC_ADC is not set
# CONFIG_INTEL_MRFLD_ADC is not set
# CONFIG_IMX7D_ADC is not set
# CONFIG_IMX8QXP_ADC is not set
# CONFIG_IMX93_ADC is not set
# CONFIG_LPC18XX_ADC is not set
# CONFIG_LPC32XX_ADC is not set
CONFIG_LTC2309=m
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
CONFIG_MAX1363=m
# CONFIG_MAX34408 is not set
CONFIG_MAX77541_ADC=m
CONFIG_MAX9611=m
CONFIG_MCP3422=m
# CONFIG_MEDIATEK_MT6359_AUXADC is not set
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_MESON_SARADC is not set
CONFIG_NAU7802=m
# CONFIG_NCT7201 is not set
# CONFIG_NPCM_ADC is not set
CONFIG_PAC1921=m
CONFIG_PAC1934=m
# CONFIG_PALMAS_GPADC is not set
# CONFIG_RCAR_GYRO_ADC is not set
CONFIG_RN5T618_ADC=m
# CONFIG_ROHM_BD79124 is not set
# CONFIG_ROCKCHIP_SARADC is not set
CONFIG_RICHTEK_RTQ6056=m
# CONFIG_RZG2L_ADC is not set
# CONFIG_SC27XX_ADC is not set
# CONFIG_SOPHGO_CV1800B_ADC is not set
# CONFIG_SPEAR_ADC is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_STM32_ADC_CORE is not set
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
# CONFIG_SUN20I_GPADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS1100=m
CONFIG_TI_ADS1119=m
# CONFIG_TI_ADS7138 is not set
CONFIG_TI_ADS7924=m
CONFIG_TWL4030_MADC=m
# CONFIG_TWL6030_GPADC is not set
CONFIG_VF610_ADC=m
CONFIG_VIPERBOARD_ADC=m
CONFIG_XILINX_XADC=m
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_AOSONG_AGS02MA=m
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
# CONFIG_CCS811 is not set
# CONFIG_ENS160 is not set
CONFIG_IAQCORE=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD4X=m
# CONFIG_SEN0322 is not set
CONFIG_SENSIRION_SGP30=m
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_INV_SENSORS_TIMESTAMP=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD3552R_HS=m
CONFIG_AD3552R_LIB=m
# CONFIG_AD5064 is not set
CONFIG_AD5380=m
CONFIG_AD5446=m
# CONFIG_AD5593R is not set
# CONFIG_ADI_AXI_DAC is not set
# CONFIG_AD5696_I2C is not set
CONFIG_CIO_DAC=m
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
# CONFIG_LPC18XX_DAC is not set
CONFIG_M62332=m
# CONFIG_MAX517 is not set
CONFIG_MAX5821=m
CONFIG_MCP4725=m
# CONFIG_MCP4728 is not set
# CONFIG_STM32_DAC is not set
CONFIG_TI_DAC5571=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADMFM2000 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_ENS210=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HDC3020=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI270=m
CONFIG_BMI270_I2C=m
# CONFIG_BMI323_I2C is not set
CONFIG_BOSCH_BNO055=m
CONFIG_BOSCH_BNO055_I2C=m
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=m
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
CONFIG_AL3000A=m
CONFIG_AL3010=m
CONFIG_AL3320A=m
CONFIG_APDS9160=m
# CONFIG_APDS9300 is not set
CONFIG_APDS9306=m
CONFIG_APDS9960=m
CONFIG_AS73211=m
CONFIG_BH1745=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM3605=m
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_ISL76682=m
CONFIG_JSA1212=m
# CONFIG_ROHM_BU27034 is not set
CONFIG_RPR0521=m
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_LTR390 is not set
# CONFIG_LTR501 is not set
CONFIG_LTRF216A=m
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_NOA1305=m
CONFIG_OPT3001=m
CONFIG_OPT4001=m
CONFIG_OPT4060=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
CONFIG_TSL4531=m
# CONFIG_US5182D is not set
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
# CONFIG_VEML3235 is not set
CONFIG_VEML6030=m
CONFIG_VEML6040=m
# CONFIG_VEML6070 is not set
CONFIG_VEML6075=m
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AF8133J is not set
CONFIG_AK8974=m
CONFIG_AK8975=m
# CONFIG_AK09911 is not set
CONFIG_ALS31300=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=m
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_SI7210=m
# CONFIG_TI_TMAG5273 is not set
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
CONFIG_MCP4018=m
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_ROHM_BM1390 is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_HSC030PA=m
CONFIG_HSC030PA_I2C=m
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL3115=m
CONFIG_MPRLS0025PA=m
CONFIG_MPRLS0025PA_I2C=m
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
# CONFIG_SDP500 is not set
CONFIG_IIO_ST_PRESS=m
# CONFIG_IIO_ST_PRESS_I2C is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_CROS_EC_MKBP_PROXIMITY=m
CONFIG_HX9023S=m
CONFIG_IRSD200=m
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
# CONFIG_PING is not set
CONFIG_RFD77402=m
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=m
# CONFIG_SX9310 is not set
CONFIG_SX9324=m
CONFIG_SX9360=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# CONFIG_AW96103 is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_MLX90635=m
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TMP117=m
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
CONFIG_MAX30208=m
# CONFIG_MCP9600 is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# CONFIG_LAN966X_OIC is not set
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_RENESAS_RZV2H_ICU is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_STM32MP_EXTI is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_IMX_MU_MSI is not set
# CONFIG_STARFIVE_JH8100_INTC is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SOPHGO_SG2042_MSI is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_BRCMSTB is not set
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_EYEQ is not set
CONFIG_RESET_GPIO=y
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_IMX8MP_AUDIOMIX is not set
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_NUVOTON_MA35D1 is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
# CONFIG_RESET_QCOM_PDC is not set
CONFIG_RESET_RASPBERRYPI=m
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_RZV2H_USB2PHY is not set
# CONFIG_RESET_SCMI is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TH1520 is not set
# CONFIG_RESET_TI_SCI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TI_TPS380X is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
# CONFIG_RESET_UNIPHIER_GLUE is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_ZYNQMP is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUX is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_STIH407_RESET is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set
# CONFIG_RESET_TEGRA_BPMP is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_SNPS_EUSB2 is not set
# CONFIG_PHY_XGENE is not set
CONFIG_USB_LGM_PHY=m
CONFIG_PHY_CAN_TRANSCEIVER=y
# CONFIG_PHY_AIROHA_PCIE is not set
CONFIG_PHY_NXP_PTN3222=m
# CONFIG_PHY_SUN4I_USB is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON8B_USB2 is not set
# CONFIG_PHY_MESON_GXL_USB2 is not set
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
# CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
# CONFIG_PHY_BCM_SR_PCIE is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=m
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_IMX8QM_HSIO is not set
# CONFIG_PHY_FSL_SAMSUNG_HDMI_PHY is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_UTMI is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_XFI_TPHY is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_CSI_0_5 is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_MTK_DP is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_CPCAP_USB=m
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_MA35_USB is not set
CONFIG_PHY_ATH79_USB=m
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_EUSB2_REPEATER is not set
# CONFIG_PHY_QCOM_M31_USB is not set
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
# CONFIG_PHY_QCOM_SGMII_ETH is not set
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RTK_RTD_USB2PHY is not set
# CONFIG_PHY_RTK_RTD_USB3PHY is not set
# CONFIG_PHY_R8A779F0_ETHERNET_SERDES is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SAMSUNG_DCPHY is not set
# CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_S5PV210_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_COMBOPHY is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_STARFIVE_JH7110_DPHY_RX is not set
# CONFIG_PHY_STARFIVE_JH7110_DPHY_TX is not set
# CONFIG_PHY_STARFIVE_JH7110_PCIE is not set
# CONFIG_PHY_STARFIVE_JH7110_USB is not set
# CONFIG_PHY_SUNPLUS_USB is not set
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_DM816X_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=m
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_ARM_NI is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
# CONFIG_HNS3_PMU is not set
CONFIG_DWC_PCIE_PMU=m
# CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU is not set
# CONFIG_MESON_DDR_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DEBUGFS_MARGINING is not set
CONFIG_USB4_DMA_TEST=y

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_LAYOUTS=y

#
# Layout Types
#
CONFIG_NVMEM_LAYOUT_SL28_VPD=y
CONFIG_NVMEM_LAYOUT_ONIE_TLV=y
CONFIG_NVMEM_LAYOUT_U_BOOT_ENV=y
# end of Layout Types

# CONFIG_NVMEM_APPLE_EFUSES is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_IMX_OCOTP_ELE is not set
# CONFIG_NVMEM_JZ4780_EFUSE is not set
# CONFIG_NVMEM_LAN9662_OTPC is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_MTK_EFUSE is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_NVMEM_QCOM_QFPROM is not set
# CONFIG_NVMEM_QCOM_SEC_QFPROM is not set
# CONFIG_NVMEM_RCAR_EFUSE is not set
CONFIG_NVMEM_RMEM=m
# CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_SC27XX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_NVMEM_SPRD_EFUSE is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_NVMEM_QORIQ_EFUSE is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_MASTER_I2CR=y
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=y
# CONFIG_FSI_OCC is not set
CONFIG_I2CR_SCOM=m
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=m
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
# CONFIG_INTERCONNECT_MTK is not set
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_SAMSUNG is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
# CONFIG_PECI_NPCM is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
# CONFIG_FUSE_PASSTHROUGH is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# end of Caches

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_QUOTA is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_PROC_MEM_ALWAYS_FORCE=y
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
# CONFIG_PROC_MEM_NO_FORCE is not set
CONFIG_SECURITYFS=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,ipe,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

#
# Bounds checking
#
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_HARDENED_USERCOPY is not set
# end of Bounds checking

#
# Hardening of kernel data structures
#
CONFIG_LIST_HARDENED=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_SELFTESTS is not set
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_KRB5ENC=y
# CONFIG_CRYPTO_BENCHMARK is not set
CONFIG_CRYPTO_ENGINE=m
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_GENIV=y
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y
# CONFIG_CRYPTO_ESSIV is not set
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=m
# CONFIG_CRYPTO_GHASH is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
# CONFIG_CRYPTO_CRC32C is not set
CONFIG_CRYPTO_CRC32=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
# end of Random number generation

#
# Userspace interface
#
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_SERPENT_SSE2_586=y
CONFIG_CRYPTO_TWOFISH_586=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_GEODE=y
# CONFIG_CRYPTO_DEV_SL3516 is not set
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_CRYPTO_DEV_FSL_CAAM is not set
# CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
# CONFIG_CRYPTO_DEV_S5P is not set
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_MARVELL_CESA is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_420XX is not set
# CONFIG_CRYPTO_DEV_QAT_6XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_CCREE=m
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
# CONFIG_CRYPTO_DEV_SA2UL is not set
# CONFIG_CRYPTO_DEV_ASPEED is not set
# CONFIG_CRYPTO_DEV_JH7110 is not set
# CONFIG_CRYPTO_DEV_EIP93 is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

CONFIG_CRYPTO_KRB5=m
# CONFIG_CRYPTO_KRB5_SELFTESTS is not set

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_AESCFB=y
CONFIG_CRYPTO_LIB_GF128MUL=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SHA256_GENERIC=y
CONFIG_CRYPTO_LIB_SM3=m
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_ARCH_HAS_CRC_T10DIF=y
CONFIG_CRC32=y
CONFIG_ARCH_HAS_CRC32=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_CRC8=y
# CONFIG_CRC_OPTIMIZATIONS is not set
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_ARM64=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_RISCV is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS_HELPERS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_NEED_SYNC=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_FORCE_NR_CPUS=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=m
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=y
CONFIG_GENERIC_VDSO_DATA_STORE=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
CONFIG_FONT_10x18=y
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_TER16x32 is not set
CONFIG_FONT_6x8=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
CONFIG_LWQ_TEST=y
# end of Library routines

CONFIG_FIRMWARE_TABLE=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_SYMBOLIC_ERRNAME is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_ULEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=0
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
# CONFIG_BUILTIN_MODULE_RANGES is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
# CONFIG_KGDB_HONOUR_BLOCKLIST is not set
# CONFIG_KGDB_TESTS is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=y
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
# CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VFS is not set
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_MAPLE_TREE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_DEFERRABLE=y
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_WQ_CPU_INTENSIVE_REPORT=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
CONFIG_DEBUG_KOBJECT=y

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE is not set
# CONFIG_RCU_TORTURE_TEST_LOG_CPU is not set
# CONFIG_RCU_TORTURE_TEST_LOG_GP is not set
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_CPU_STALL_NOTIFIER is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
CONFIG_RCU_STRICT_GRACE_PERIOD=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FREGS=y
CONFIG_HAVE_FTRACE_GRAPH_FUNC=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
CONFIG_SAMPLE_HW_BREAKPOINT=m
CONFIG_SAMPLE_KFIFO=m
CONFIG_SAMPLE_KDB=m
CONFIG_SAMPLE_RPMSG_CLIENT=m
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_HIDRAW is not set
CONFIG_SAMPLE_LANDLOCK=y
# CONFIG_SAMPLE_PIDFD is not set
# CONFIG_SAMPLE_TIMER is not set
# CONFIG_SAMPLE_TSM_MR is not set
# CONFIG_SAMPLE_UHID is not set
CONFIG_SAMPLE_VFIO_MDEV_MTTY=m
CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_ANDROID_BINDERFS is not set
CONFIG_SAMPLE_VFS=y
CONFIG_SAMPLE_INTEL_MEI=y
# CONFIG_SAMPLE_TPS6594_PFSM is not set
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
CONFIG_SAMPLE_KMEMLEAK=m
CONFIG_SAMPLE_CGROUP=y
# CONFIG_SAMPLE_CHECK_EXEC is not set

#
# DAMON Samples
#
# CONFIG_SAMPLE_DAMON_WSSE is not set
CONFIG_SAMPLE_DAMON_PRCL=y
# CONFIG_SAMPLE_DAMON_MTIER is not set
# end of DAMON Samples

CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_X86_DEBUG_FPU is not set
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
# CONFIG_FAULT_INJECTION_CONFIGFS is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
CONFIG_LKDTM=m
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
CONFIG_TEST_MULDIV64=m
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=m
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_BITMAP is not set
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=m
CONFIG_TEST_MAPLE_TREE=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=y
CONFIG_TEST_VMALLOC=m
CONFIG_FIND_BIT_BENCHMARK=m
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_KALLSYMS is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_FREE_PAGES=y
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_TEST_OBJPOOL=m
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

#
# Documentation
#
# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Documentation

--GJaJ7oPF950xrCl1--

