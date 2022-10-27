Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2D60F447
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 12:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiJ0KBB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 06:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiJ0KAf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 06:00:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA5DD3A6;
        Thu, 27 Oct 2022 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666864812; x=1698400812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJPCFTV8MpF6btptcz/BJUn1rRYOmr6pkto3N3fNH+w=;
  b=espbAOe/VK/OuqYKfXdARkFUuJjbBmlKz6uBipnUZ3106njesWzYF+PP
   KaBrzQ6RODPm4ro47uEpH0eU3Z2CL8DrektXHFutfIRSa4cBhekantubr
   WB6VfJrzY0kNN8OnV16zehRuvBhe7xaxI6AjXAS+anTCkw/E730n1aBFg
   WpdvJRq+QRMiPYFjUWTvzdA/oOXVjZfHEzGJLIj1cFsUUDBbmYebhjG8k
   bYG4v6Ee6IPao9sOK0DETn5qJeN43S1y7rJfYfltG6hQ1ZHB+kLLt0u0K
   5ZRFtgcas5XDGl5b4taMzw3dKnrO9EUBuHEDbOYSHGr0wa/IXK9oFHYyz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="394498356"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="394498356"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 03:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="583498473"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="583498473"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.132])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2022 03:00:08 -0700
Date:   Thu, 27 Oct 2022 18:05:48 +0800
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        =?iso-8859-1?Q?Dexuan=A0Cui?= <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Ira=A0Weiny=A0?= <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
Message-ID: <Y1pX/BGRgceJcEE9@liuzhao-OptiPlex-7080>
References: <20221020083820.2341088-1-zhao1.liu@linux.intel.com>
 <Y1lPfphHVRn2e4I5@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1lPfphHVRn2e4I5@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Oct 26, 2022 at 03:17:18PM +0000, Wei Liu wrote:
> Date: Wed, 26 Oct 2022 15:17:18 +0000
> From: Wei Liu <wei.liu@kernel.org>
> Subject: Re: [PATCH v2] x86/hyperv: Remove BUG_ON() for kmap_local_page()
> 
> On Thu, Oct 20, 2022 at 04:38:20PM +0800, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > The commit 154fb14df7a3c ("x86/hyperv: Replace kmap() with
> > kmap_local_page()") keeps the BUG_ON() to check if kmap_local_page()
> > fails.
> > 
> > But in fact, kmap_local_page() always returns a valid kernel address
> > and won't return NULL here. It will BUG on its own if it fails. [1]
> > 
> > So directly use memcpy_to_page() which creates local mapping to copy.
> > 
> > [1]: https://lore.kernel.org/lkml/YztFEyUA48et0yTt@iweiny-mobl/
> > 
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Applied to hyperv-fixes. Thanks.

Sorry Wei, I appology for not deleting unused variables, which caused
the next tree break. Do I need to send another v3 to make up for my
carelessness?

Zhao
