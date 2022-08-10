Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9858F13D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Aug 2022 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiHJRKS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Aug 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiHJRKQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Aug 2022 13:10:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0021F2CB;
        Wed, 10 Aug 2022 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660151415; x=1691687415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=se+6zjvh/5uSsxW/QEuqduedVHHp8pgTm+C8PMJwhp4=;
  b=caTnK5OU1smOyv3oD+2MKMLLTDnqshKhw5uMiiSzNZVdrSvwTPLKXGpb
   qlazKYTCrZt2MRivSzpMY2umtrxJrjxEIhRPneITfkpwgR/pwc+IEI833
   bm5MciZ+rO1FxGrgHHoO2HCDJi3B/jok0pfp5nsXXM4cfLVzPWZ7KSdtf
   Zl+pQR/Q+EUX/JxGgkQ2n1/OGoQcKIjEDVOxcJKQw0lEqqoUYAJ3Rz63a
   mg4uTEBlRAsHLT5bnllHneTKs7D8Cz4DYbnRfudLm3mGmsuBmzO8RXM/V
   mAa+goxrUM/E7EeFzWDN5S8ZOV2fda4Wpk0cUsH9svTQb/G/u23rzY328
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292398622"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="292398622"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:10:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="664986467"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 10:10:09 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 10 Aug 2022 20:10:07 +0300
Date:   Wed, 10 Aug 2022 20:10:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 5/5][RFT] ACPI: Drop parent field from struct
 acpi_device
Message-ID: <YvPmb1MObTZ4a0rn@lahna>
References: <12036348.O9o76ZdvQC@kreacher>
 <2196460.iZASKD2KPV@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2196460.iZASKD2KPV@kreacher>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 10, 2022 at 06:23:05PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The parent field in struct acpi_device is, in fact, redundant,
> because the dev.parent field in it effectively points to the same
> object and it is used by the driver core.
> 
> Accordingly, the parent field can be dropped from struct acpi_device
> and for this purpose define acpi_dev_parent() to retrieve the parent
> struct acpi_device pointer from the dev.parent field in struct
> acpi_device.  Next, update all of the users of the parent field
> in struct acpi_device to use acpi_dev_parent() instead of it and
> drop it.
> 
> While at it, drop the ACPI_IS_ROOT_DEVICE() macro that is only used
> in one place in a confusing way.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> I may have missed some places where adev->parent is used directly, so
> if that's happened, please let me know (I'm assuming that 0-day will
> pick up this patch and run it through all of the relevant configs
> anyway).
> 
> ---
>  drivers/acpi/acpi_platform.c |    6 +++---
>  drivers/acpi/acpi_video.c    |    2 +-
>  drivers/acpi/device_pm.c     |   19 ++++++++++---------
>  drivers/acpi/property.c      |    6 ++++--
>  drivers/acpi/sbs.c           |    2 +-
>  drivers/acpi/sbshc.c         |    2 +-
>  drivers/acpi/scan.c          |   17 ++++++-----------
>  drivers/hv/vmbus_drv.c       |    3 ++-
>  drivers/spi/spi.c            |    2 +-
>  drivers/thunderbolt/acpi.c   |    2 +-

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
