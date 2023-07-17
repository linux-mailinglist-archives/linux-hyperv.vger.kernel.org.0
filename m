Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A49755F79
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jul 2023 11:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGQJid (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jul 2023 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjGQJiC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jul 2023 05:38:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203A1990;
        Mon, 17 Jul 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689586593; x=1721122593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5TYmTtlTfntSQg4aPnMTHdSZrsTPtIqbLnEImTw0oOU=;
  b=DU7Qs3sMvWLe/a5mtE7MDyXv1lwB47QQCKq0KMu6MOIgjn/UKcIPO4ei
   1gKApvNVGLvH4xn57OcE4wwgWlSfH5UH/ydUaNFTmSsch3+fHZj0KHGDG
   cvjGHax7ezrpGFgvv2JRBVamcV8TUX0Og/+tumQWMkep0tWz0s5xu1kTC
   vkZSKRizMapsDTtYGFH5hp6UU2SwYtFovyaO2m3ZUUoSBGOFJqOY6Izbo
   QGDurB98DCeYaPdqRaF9js/yc01E+vW9z8kVLt3SzjPAK/KEN+cq9LBRY
   yWp8LxqKwOHgjzNae6SRkeKnY8A9nVkcIimr3BFBc8yTMGnrQAAlTrbAT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="396712630"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396712630"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="836820997"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="836820997"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2023 02:36:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qLKeM-007bvc-1V;
        Mon, 17 Jul 2023 12:36:14 +0300
Date:   Mon, 17 Jul 2023 12:36:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Message-ID: <ZLULjoePQaF+nSk2@smile.fi.intel.com>
References: <20230705140242.844167-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705140242.844167-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 05, 2023 at 04:02:24PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous patch addressed the fortified memcpy warning for most
> builds, but I still see this one with gcc-9:

JFYI: as of today I have run Linux Next with `make W=1 allmodconfig` on x86_64
and it seems there are still tons of similar issues which break the build.

-- 
With Best Regards,
Andy Shevchenko


